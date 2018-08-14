Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89F1C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD1821733
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD1821733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389120AbeHNURK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:17:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52826 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387930AbeHNURJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:17:09 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D241140B;
        Tue, 14 Aug 2018 17:29:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH 4.17 22/97] x86/speculation/l1tf: Increase 32bit PAE __PHYSICAL_PAGE_SHIFT
Date:   Tue, 14 Aug 2018 19:16:34 +0200
Message-Id: <20180814171434.034318596@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171433.160434170@linuxfoundation.org>
References: <20180814171433.160434170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Kleen <ak@linux.intel.com>

commit 50896e180c6aa3a9c61a26ced99e15d602666a4c upstream

L1 Terminal Fault (L1TF) is a speculation related vulnerability. The CPU
speculates on PTE entries which do not have the PRESENT bit set, if the
content of the resulting physical address is available in the L1D cache.

The OS side mitigation makes sure that a !PRESENT PTE entry points to a
physical address outside the actually existing and cachable memory
space. This is achieved by inverting the upper bits of the PTE. Due to the
address space limitations this only works for 64bit and 32bit PAE kernels,
but not for 32bit non PAE.

This mitigation applies to both host and guest kernels, but in case of a
64bit host (hypervisor) and a 32bit PAE guest, inverting the upper bits of
the PAE address space (44bit) is not enough if the host has more than 43
bits of populated memory address space, because the speculation treats the
PTE content as a physical host address bypassing EPT.

The host (hypervisor) protects itself against the guest by flushing L1D as
needed, but pages inside the guest are not protected against attacks from
other processes inside the same guest.

For the guest the inverted PTE mask has to match the host to provide the
full protection for all pages the host could possibly map into the
guest. The hosts populated address space is not known to the guest, so the
mask must cover the possible maximal host address space, i.e. 52 bit.

On 32bit PAE the maximum PTE mask is currently set to 44 bit because that
is the limit imposed by 32bit unsigned long PFNs in the VMs. This limits
the mask to be below what the host could possible use for physical pages.

The L1TF PROT_NONE protection code uses the PTE masks to determine which
bits to invert to make sure the higher bits are set for unmapped entries to
prevent L1TF speculation attacks against EPT inside guests.

In order to invert all bits that could be used by the host, increase
__PHYSICAL_PAGE_SHIFT to 52 to match 64bit.

The real limit for a 32bit PAE kernel is still 44 bits because all Linux
PTEs are created from unsigned long PFNs, so they cannot be higher than 44
bits on a 32bit kernel. So these extra PFN bits should be never set. The
only users of this macro are using it to look at PTEs, so it's safe.

[ tglx: Massaged changelog ]

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/page_32_types.h |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/page_32_types.h
+++ b/arch/x86/include/asm/page_32_types.h
@@ -29,8 +29,13 @@
 #define N_EXCEPTION_STACKS 1
 
 #ifdef CONFIG_X86_PAE
-/* 44=32+12, the limit we can fit into an unsigned long pfn */
-#define __PHYSICAL_MASK_SHIFT	44
+/*
+ * This is beyond the 44 bit limit imposed by the 32bit long pfns,
+ * but we need the full mask to make sure inverted PROT_NONE
+ * entries have all the host bits set in a guest.
+ * The real limit is still 44 bits.
+ */
+#define __PHYSICAL_MASK_SHIFT	52
 #define __VIRTUAL_MASK_SHIFT	32
 
 #else  /* !CONFIG_X86_PAE */


