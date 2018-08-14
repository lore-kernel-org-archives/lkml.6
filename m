Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94063C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5883A2154F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5883A2154F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390451AbeHNUa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:30:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59702 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbeHNUa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:30:58 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6160EAF3;
        Tue, 14 Aug 2018 17:42:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 067/107] x86/KVM/VMX: Use MSR save list for IA32_FLUSH_CMD if required
Date:   Tue, 14 Aug 2018 19:17:30 +0200
Message-Id: <20180814171524.999876779@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171520.883143803@linuxfoundation.org>
References: <20180814171520.883143803@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 390d975e0c4e60ce70d4157e0dd91ede37824603 upstream

If the L1D flush module parameter is set to 'always' and the IA32_FLUSH_CMD
MSR is available, optimize the VMENTER code with the MSR save list.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -5269,6 +5269,16 @@ static void ept_set_mmio_spte_mask(void)
 	kvm_mmu_set_mmio_spte_mask((0x3ull << 62) | 0x6ull);
 }
 
+static bool vmx_l1d_use_msr_save_list(void)
+{
+	if (!enable_ept || !boot_cpu_has_bug(X86_BUG_L1TF) ||
+	    static_cpu_has(X86_FEATURE_HYPERVISOR) ||
+	    !static_cpu_has(X86_FEATURE_FLUSH_L1D))
+		return false;
+
+	return vmentry_l1d_flush == VMENTER_L1D_FLUSH_ALWAYS;
+}
+
 #define VMX_XSS_EXIT_BITMAP 0
 /*
  * Sets up the vmcs for emulated real mode.
@@ -5618,6 +5628,12 @@ static void vmx_set_nmi_mask(struct kvm_
 			vmcs_clear_bits(GUEST_INTERRUPTIBILITY_INFO,
 					GUEST_INTR_STATE_NMI);
 	}
+	/*
+	 * If flushing the L1D cache on every VMENTER is enforced and the
+	 * MSR is available, use the MSR save list.
+	 */
+	if (vmx_l1d_use_msr_save_list())
+		add_atomic_switch_msr(vmx, MSR_IA32_FLUSH_CMD, L1D_FLUSH, 0, true);
 }
 
 static int vmx_nmi_allowed(struct kvm_vcpu *vcpu)
@@ -8581,11 +8597,26 @@ static void vmx_l1d_flush(struct kvm_vcp
 	bool always;
 
 	/*
-	 * If the mitigation mode is 'flush always', keep the flush bit
-	 * set, otherwise clear it. It gets set again either from
-	 * vcpu_run() or from one of the unsafe VMEXIT handlers.
+	 * This code is only executed when:
+	 * - the flush mode is 'cond'
+	 * - the flush mode is 'always' and the flush MSR is not
+	 *   available
+	 *
+	 * If the CPU has the flush MSR then clear the flush bit because
+	 * 'always' mode is handled via the MSR save list.
+	 *
+	 * If the MSR is not avaibable then act depending on the mitigation
+	 * mode: If 'flush always', keep the flush bit set, otherwise clear
+	 * it.
+	 *
+	 * The flush bit gets set again either from vcpu_run() or from one
+	 * of the unsafe VMEXIT handlers.
 	 */
-	always = vmentry_l1d_flush == VMENTER_L1D_FLUSH_ALWAYS;
+	if (static_cpu_has(X86_FEATURE_FLUSH_L1D))
+		always = false;
+	else
+		always = vmentry_l1d_flush == VMENTER_L1D_FLUSH_ALWAYS;
+
 	vcpu->arch.l1tf_flush_l1d = always;
 
 	vcpu->stat.l1d_flush++;
@@ -11660,7 +11691,8 @@ static int __init vmx_setup_l1d_flush(vo
 	struct page *page;
 
 	if (vmentry_l1d_flush == VMENTER_L1D_FLUSH_NEVER ||
-	    !boot_cpu_has_bug(X86_BUG_L1TF))
+	    !boot_cpu_has_bug(X86_BUG_L1TF) ||
+	    vmx_l1d_use_msr_save_list())
 		return 0;
 
 	if (!boot_cpu_has(X86_FEATURE_FLUSH_L1D)) {


