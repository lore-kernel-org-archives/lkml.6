Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09975C46471
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C121721727
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C121721727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbeHNUYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:24:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57438 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbeHNUYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:24:24 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0BFECDDE;
        Tue, 14 Aug 2018 17:36:14 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 058/104] x86/KVM/VMX: Add L1D flush algorithm
Date:   Tue, 14 Aug 2018 19:17:12 +0200
Message-Id: <20180814171519.078959828@linuxfoundation.org>
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

commit a47dd5f06714c844b33f3b5f517b6f3e81ce57b5 upstream

To mitigate the L1 Terminal Fault vulnerability it's required to flush L1D
on VMENTER to prevent rogue guests from snooping host memory.

CPUs will have a new control MSR via a microcode update to flush L1D with a
single MSR write, but in the absence of microcode a fallback to a software
based flush algorithm is required.

Add a software flush loop which is based on code from Intel.

[ tglx: Split out from combo patch ]
[ bpetkov: Polish the asm code ]

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   70 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 4 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -9038,6 +9038,46 @@ static int vmx_handle_exit(struct kvm_vc
 	}
 }
 
+/*
+ * Software based L1D cache flush which is used when microcode providing
+ * the cache control MSR is not loaded.
+ *
+ * The L1D cache is 32 KiB on Nehalem and later microarchitectures, but to
+ * flush it is required to read in 64 KiB because the replacement algorithm
+ * is not exactly LRU. This could be sized at runtime via topology
+ * information but as all relevant affected CPUs have 32KiB L1D cache size
+ * there is no point in doing so.
+ */
+#define L1D_CACHE_ORDER 4
+static void *vmx_l1d_flush_pages;
+
+static void __maybe_unused vmx_l1d_flush(void)
+{
+	int size = PAGE_SIZE << L1D_CACHE_ORDER;
+
+	asm volatile(
+		/* First ensure the pages are in the TLB */
+		"xorl	%%eax, %%eax\n"
+		".Lpopulate_tlb:\n\t"
+		"movzbl	(%[empty_zp], %%" _ASM_AX "), %%ecx\n\t"
+		"addl	$4096, %%eax\n\t"
+		"cmpl	%%eax, %[size]\n\t"
+		"jne	.Lpopulate_tlb\n\t"
+		"xorl	%%eax, %%eax\n\t"
+		"cpuid\n\t"
+		/* Now fill the cache */
+		"xorl	%%eax, %%eax\n"
+		".Lfill_cache:\n"
+		"movzbl	(%[empty_zp], %%" _ASM_AX "), %%ecx\n\t"
+		"addl	$64, %%eax\n\t"
+		"cmpl	%%eax, %[size]\n\t"
+		"jne	.Lfill_cache\n\t"
+		"lfence\n"
+		:: [empty_zp] "r" (vmx_l1d_flush_pages),
+		    [size] "r" (size)
+		: "eax", "ebx", "ecx", "edx");
+}
+
 static void update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
 {
 	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
@@ -12408,25 +12448,45 @@ static struct kvm_x86_ops vmx_x86_ops __
 	.setup_mce = vmx_setup_mce,
 };
 
-static void __init vmx_setup_l1d_flush(void)
+static int __init vmx_setup_l1d_flush(void)
 {
+	struct page *page;
+
 	if (vmentry_l1d_flush == VMENTER_L1D_FLUSH_NEVER ||
 	    !boot_cpu_has_bug(X86_BUG_L1TF))
-		return;
+		return 0;
 
+	page = alloc_pages(GFP_KERNEL, L1D_CACHE_ORDER);
+	if (!page)
+		return -ENOMEM;
+
+	vmx_l1d_flush_pages = page_address(page);
 	static_branch_enable(&vmx_l1d_should_flush);
+	return 0;
+}
+
+static void vmx_free_l1d_flush_pages(void)
+{
+	if (vmx_l1d_flush_pages) {
+		free_pages((unsigned long)vmx_l1d_flush_pages, L1D_CACHE_ORDER);
+		vmx_l1d_flush_pages = NULL;
+	}
 }
 
 static int __init vmx_init(void)
 {
 	int r;
 
-	vmx_setup_l1d_flush();
+	r = vmx_setup_l1d_flush();
+	if (r)
+		return r;
 
 	r = kvm_init(&vmx_x86_ops, sizeof(struct vcpu_vmx),
 		     __alignof__(struct vcpu_vmx), THIS_MODULE);
-	if (r)
+	if (r) {
+		vmx_free_l1d_flush_pages();
 		return r;
+	}
 
 #ifdef CONFIG_KEXEC_CORE
 	rcu_assign_pointer(crash_vmclear_loaded_vmcss,
@@ -12444,6 +12504,8 @@ static void __exit vmx_exit(void)
 #endif
 
 	kvm_exit();
+
+	vmx_free_l1d_flush_pages();
 }
 
 module_init(vmx_init)


