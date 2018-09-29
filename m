Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8798FC004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B4C2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B4C2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbeI3ESa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:30 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51759 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727989AbeI3ES2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:28 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N68-0000Gv-Dh; Sat, 29 Sep 2018 22:48:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5y-0006wB-Ev; Sat, 29 Sep 2018 22:48:14 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Michal Hocko" <mhocko@suse.com>,
        "Dave Hansen" <dave.hansen@intel.com>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.629173816@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 091/131] x86/speculation/l1tf: Increase 32bit PAE
 __PHYSICAL_PAGE_SHIFT
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Kleen <ak@linux.intel.com>

commit 50896e180c6aa3a9c61a26ced99e15d602666a4c upstream.

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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/page_32_types.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/page_32_types.h
+++ b/arch/x86/include/asm/page_32_types.h
@@ -27,8 +27,13 @@
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

