Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1FFC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C92121727
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C92121727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389686AbeHNUT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:19:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53316 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389653AbeHNUTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:19:23 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6F01CBDB;
        Tue, 14 Aug 2018 17:31:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.17 61/97] x86/KVM/VMX: Use MSR save list for IA32_FLUSH_CMD if required
Date:   Tue, 14 Aug 2018 19:17:13 +0200
Message-Id: <20180814171435.478873831@linuxfoundation.org>
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

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 390d975e0c4e60ce70d4157e0dd91ede37824603 upstream

If the L1D flush module parameter is set to 'always' and the IA32_FLUSH_CMD
MSR is available, optimize the VMENTER code with the MSR save list.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -6045,6 +6045,16 @@ static void ept_set_mmio_spte_mask(void)
 				   VMX_EPT_MISCONFIG_WX_VALUE);
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
@@ -6160,6 +6170,12 @@ static void vmx_vcpu_setup(struct vcpu_v
 		vmcs_write64(PML_ADDRESS, page_to_phys(vmx->pml_pg));
 		vmcs_write16(GUEST_PML_INDEX, PML_ENTITY_NUM - 1);
 	}
+	/*
+	 * If flushing the L1D cache on every VMENTER is enforced and the
+	 * MSR is available, use the MSR save list.
+	 */
+	if (vmx_l1d_use_msr_save_list())
+		add_atomic_switch_msr(vmx, MSR_IA32_FLUSH_CMD, L1D_FLUSH, 0, true);
 }
 
 static void vmx_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
@@ -9377,11 +9393,26 @@ static void vmx_l1d_flush(struct kvm_vcp
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
@@ -13024,7 +13055,8 @@ static int __init vmx_setup_l1d_flush(vo
 	struct page *page;
 
 	if (vmentry_l1d_flush == VMENTER_L1D_FLUSH_NEVER ||
-	    !boot_cpu_has_bug(X86_BUG_L1TF))
+	    !boot_cpu_has_bug(X86_BUG_L1TF) ||
+	    vmx_l1d_use_msr_save_list())
 		return 0;
 
 	if (!boot_cpu_has(X86_FEATURE_FLUSH_L1D)) {


