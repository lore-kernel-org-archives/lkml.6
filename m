Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EFEC46474
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8C42168D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8C42168D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbeHNUY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:24:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57448 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbeHNUY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:24:27 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 11353DE0;
        Tue, 14 Aug 2018 17:36:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 059/104] x86/KVM/VMX: Add L1D MSR based flush
Date:   Tue, 14 Aug 2018 19:17:13 +0200
Message-Id: <20180814171519.145603242@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171515.270692185@linuxfoundation.org>
References: <20180814171515.270692185@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit 3fa045be4c720146b18a19cea7a767dc6ad5df94 upstream

336996-Speculative-Execution-Side-Channel-Mitigations.pdf defines a new MSR
(IA32_FLUSH_CMD aka 0x10B) which has similar write-only semantics to other
MSRs defined in the document.

The semantics of this MSR is to allow "finer granularity invalidation of
caching structures than existing mechanisms like WBINVD. It will writeback
and invalidate the L1 data cache, including all cachelines brought in by
preceding instructions, without invalidating all caches (eg. L2 or
LLC). Some processors may also invalidate the first level level instruction
cache on a L1D_FLUSH command. The L1 data and instruction caches may be
shared across the logical processors of a core."

Use it instead of the loop based L1 flush algorithm.

A copy of this document is available at
   https://bugzilla.kernel.org/show_bug.cgi?id=199511

[ tglx: Avoid allocating pages when the MSR is available ]

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/msr-index.h |    6 ++++++
 arch/x86/kvm/vmx.c               |   15 +++++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -76,6 +76,12 @@
 						    * control required.
 						    */
 
+#define MSR_IA32_FLUSH_CMD		0x0000010b
+#define L1D_FLUSH			(1 << 0)   /*
+						    * Writeback and invalidate the
+						    * L1 data cache.
+						    */
+
 #define MSR_IA32_BBL_CR_CTL		0x00000119
 #define MSR_IA32_BBL_CR_CTL3		0x0000011e
 
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9055,6 +9055,11 @@ static void __maybe_unused vmx_l1d_flush
 {
 	int size = PAGE_SIZE << L1D_CACHE_ORDER;
 
+	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
+		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
+		return;
+	}
+
 	asm volatile(
 		/* First ensure the pages are in the TLB */
 		"xorl	%%eax, %%eax\n"
@@ -12456,11 +12461,13 @@ static int __init vmx_setup_l1d_flush(vo
 	    !boot_cpu_has_bug(X86_BUG_L1TF))
 		return 0;
 
-	page = alloc_pages(GFP_KERNEL, L1D_CACHE_ORDER);
-	if (!page)
-		return -ENOMEM;
+	if (!boot_cpu_has(X86_FEATURE_FLUSH_L1D)) {
+		page = alloc_pages(GFP_KERNEL, L1D_CACHE_ORDER);
+		if (!page)
+			return -ENOMEM;
+		vmx_l1d_flush_pages = page_address(page);
+	}
 
-	vmx_l1d_flush_pages = page_address(page);
 	static_branch_enable(&vmx_l1d_should_flush);
 	return 0;
 }


