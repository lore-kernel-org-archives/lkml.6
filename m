Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA62C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619BD2154F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619BD2154F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390486AbeHNUbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:31:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59732 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbeHNUbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:31:08 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1B0F0AF3;
        Tue, 14 Aug 2018 17:42:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 070/107] x86/kvm: Drop L1TF MSR list approach
Date:   Tue, 14 Aug 2018 19:17:33 +0200
Message-Id: <20180814171525.124970724@linuxfoundation.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

commit 2f055947ae5e2741fb2dc5bba1033c417ccf4faa upstream

The VMX module parameter to control the L1D flush should become
writeable.

The MSR list is set up at VM init per guest VCPU, but the run time
switching is based on a static key which is global. Toggling the MSR list
at run time might be feasible, but for now drop this optimization and use
the regular MSR write to make run-time switching possible.

The default mitigation is the conditional flush anyway, so for extra
paranoid setups this will add some small overhead, but the extra code
executed is in the noise compared to the flush itself.

Aside of that the EPT disabled case is not handled correctly at the moment
and the MSR list magic is in the way for fixing that as well.

If it's really providing a significant advantage, then this needs to be
revisited after the code is correct and the control is writable.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jiri Kosina <jkosina@suse.cz>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20180713142322.516940445@linutronix.de
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/vmx.c |   43 +++++++------------------------------------
 1 file changed, 7 insertions(+), 36 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -5263,16 +5263,6 @@ static void ept_set_mmio_spte_mask(void)
 	kvm_mmu_set_mmio_spte_mask((0x3ull << 62) | 0x6ull);
 }
 
-static bool vmx_l1d_use_msr_save_list(void)
-{
-	if (!enable_ept || !boot_cpu_has_bug(X86_BUG_L1TF) ||
-	    static_cpu_has(X86_FEATURE_HYPERVISOR) ||
-	    !static_cpu_has(X86_FEATURE_FLUSH_L1D))
-		return false;
-
-	return vmentry_l1d_flush == VMENTER_L1D_FLUSH_ALWAYS;
-}
-
 #define VMX_XSS_EXIT_BITMAP 0
 /*
  * Sets up the vmcs for emulated real mode.
@@ -5622,12 +5612,6 @@ static void vmx_set_nmi_mask(struct kvm_
 			vmcs_clear_bits(GUEST_INTERRUPTIBILITY_INFO,
 					GUEST_INTR_STATE_NMI);
 	}
-	/*
-	 * If flushing the L1D cache on every VMENTER is enforced and the
-	 * MSR is available, use the MSR save list.
-	 */
-	if (vmx_l1d_use_msr_save_list())
-		add_atomic_switch_msr(vmx, MSR_IA32_FLUSH_CMD, L1D_FLUSH, 0, true);
 }
 
 static int vmx_nmi_allowed(struct kvm_vcpu *vcpu)
@@ -8591,26 +8575,14 @@ static void vmx_l1d_flush(struct kvm_vcp
 	bool always;
 
 	/*
-	 * This code is only executed when:
-	 * - the flush mode is 'cond'
-	 * - the flush mode is 'always' and the flush MSR is not
-	 *   available
-	 *
-	 * If the CPU has the flush MSR then clear the flush bit because
-	 * 'always' mode is handled via the MSR save list.
-	 *
-	 * If the MSR is not avaibable then act depending on the mitigation
-	 * mode: If 'flush always', keep the flush bit set, otherwise clear
-	 * it.
+	 * This code is only executed when the the flush mode is 'cond' or
+	 * 'always'
 	 *
-	 * The flush bit gets set again either from vcpu_run() or from one
-	 * of the unsafe VMEXIT handlers.
+	 * If 'flush always', keep the flush bit set, otherwise clear
+	 * it. The flush bit gets set again either from vcpu_run() or from
+	 * one of the unsafe VMEXIT handlers.
 	 */
-	if (static_cpu_has(X86_FEATURE_FLUSH_L1D))
-		always = false;
-	else
-		always = vmentry_l1d_flush == VMENTER_L1D_FLUSH_ALWAYS;
-
+	always = vmentry_l1d_flush == VMENTER_L1D_FLUSH_ALWAYS;
 	vcpu->arch.l1tf_flush_l1d = always;
 
 	vcpu->stat.l1d_flush++;
@@ -11689,8 +11661,7 @@ static int __init vmx_setup_l1d_flush(vo
 
 	l1tf_vmx_mitigation = vmentry_l1d_flush;
 
-	if (vmentry_l1d_flush == VMENTER_L1D_FLUSH_NEVER ||
-	    vmx_l1d_use_msr_save_list())
+	if (vmentry_l1d_flush == VMENTER_L1D_FLUSH_NEVER)
 		return 0;
 
 	if (!boot_cpu_has(X86_FEATURE_FLUSH_L1D)) {


