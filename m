Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A547C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F242E21653
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:56:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F242E21653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390104AbeHNUaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:30:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59172 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390075AbeHNUaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:30:07 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id ED927D84;
        Tue, 14 Aug 2018 17:32:05 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.17 75/97] x86/KVM/VMX: Initialize the vmx_l1d_flush_pages content
Date:   Tue, 14 Aug 2018 19:17:27 +0200
Message-Id: <20180814171435.996476615@linuxfoundation.org>
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

From: Nicolai Stange <nstange@suse.de>

commit 288d152c23dcf3c09da46c5c481903ca10ebfef7 upstream

The slow path in vmx_l1d_flush() reads from vmx_l1d_flush_pages in order
to evict the L1d cache.

However, these pages are never cleared and, in theory, their data could be
leaked.

More importantly, KSM could merge a nested hypervisor's vmx_l1d_flush_pages
to fewer than 1 << L1D_CACHE_ORDER host physical pages and this would break
the L1d flushing algorithm: L1D on x86_64 is tagged by physical addresses.

Fix this by initializing the individual vmx_l1d_flush_pages with a
different pattern each.

Rename the "empty_zp" asm constraint identifier in vmx_l1d_flush() to
"flush_pages" to reflect this change.

Fixes: a47dd5f06714 ("x86/KVM/VMX: Add L1D flush algorithm")
Signed-off-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -211,6 +211,7 @@ static void *vmx_l1d_flush_pages;
 static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
 {
 	struct page *page;
+	unsigned int i;
 
 	if (!enable_ept) {
 		l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_EPT_DISABLED;
@@ -243,6 +244,16 @@ static int vmx_setup_l1d_flush(enum vmx_
 		if (!page)
 			return -ENOMEM;
 		vmx_l1d_flush_pages = page_address(page);
+
+		/*
+		 * Initialize each page with a different pattern in
+		 * order to protect against KSM in the nested
+		 * virtualization case.
+		 */
+		for (i = 0; i < 1u << L1D_CACHE_ORDER; ++i) {
+			memset(vmx_l1d_flush_pages + i * PAGE_SIZE, i + 1,
+			       PAGE_SIZE);
+		}
 	}
 
 	l1tf_vmx_mitigation = l1tf;
@@ -9471,7 +9482,7 @@ static void vmx_l1d_flush(struct kvm_vcp
 		/* First ensure the pages are in the TLB */
 		"xorl	%%eax, %%eax\n"
 		".Lpopulate_tlb:\n\t"
-		"movzbl	(%[empty_zp], %%" _ASM_AX "), %%ecx\n\t"
+		"movzbl	(%[flush_pages], %%" _ASM_AX "), %%ecx\n\t"
 		"addl	$4096, %%eax\n\t"
 		"cmpl	%%eax, %[size]\n\t"
 		"jne	.Lpopulate_tlb\n\t"
@@ -9480,12 +9491,12 @@ static void vmx_l1d_flush(struct kvm_vcp
 		/* Now fill the cache */
 		"xorl	%%eax, %%eax\n"
 		".Lfill_cache:\n"
-		"movzbl	(%[empty_zp], %%" _ASM_AX "), %%ecx\n\t"
+		"movzbl	(%[flush_pages], %%" _ASM_AX "), %%ecx\n\t"
 		"addl	$64, %%eax\n\t"
 		"cmpl	%%eax, %[size]\n\t"
 		"jne	.Lfill_cache\n\t"
 		"lfence\n"
-		:: [empty_zp] "r" (vmx_l1d_flush_pages),
+		:: [flush_pages] "r" (vmx_l1d_flush_pages),
 		    [size] "r" (size)
 		: "eax", "ebx", "ecx", "edx");
 }


