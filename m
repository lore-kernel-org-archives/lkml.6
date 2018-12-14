Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6F2C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6449721479
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789805;
	bh=KW8unDsOXjmywQ70y831Ybz6mgGM+mtywOrpENG4guo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uD0U0OrWVFrBE1z87kDa0QddwVBAzn+eaPifJwRaLtERVakaXbNPqHeZyLYnPaY0y
	 jRvPDi68zpYgoDO40uC3J2P1FbubHsbBTzo0A1BoCvmoH7peTciiJklPtFy8RLsO7l
	 bmSUFuAlp67WarN0OJbXtWm7Wcldc1+Qr9k1S4sc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6449721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732809AbeLNMQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:16:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732780AbeLNMQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:16:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD7CE21479;
        Fri, 14 Dec 2018 12:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789796;
        bh=KW8unDsOXjmywQ70y831Ybz6mgGM+mtywOrpENG4guo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RpV2beNtoWNcHWXt4d4JqiAmuh3aR1DL22yPAdQmHwt2vb2hDn3NaQH2OQF+AAlxr
         eUIIydHtSnjKYJNbIvSD2tJoBkCYeOANxlyGUn9hI+E5vqZrc5AJrUbiI+ee/fpcOn
         3P1h3maiDsvOm9IUfGY3DxE2VSjtLM1Hx1F/51rc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 59/88] x86/bugs, KVM: Extend speculation control for VIRT_SPEC_CTRL
Date:   Fri, 14 Dec 2018 13:00:33 +0100
Message-Id: <20181214115707.313009206@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit ccbcd2674472a978b48c91c1fbfb66c0ff959f24 upstream.

AMD is proposing a VIRT_SPEC_CTRL MSR to handle the Speculative Store
Bypass Disable via MSR_AMD64_LS_CFG so that guests do not have to care
about the bit position of the SSBD bit and thus facilitate migration.
Also, the sibling coordination on Family 17H CPUs can only be done on
the host.

Extend x86_spec_ctrl_set_guest() and x86_spec_ctrl_restore_host() with an
extra argument for the VIRT_SPEC_CTRL MSR.

Hand in 0 from VMX and in SVM add a new virt_spec_ctrl member to the CPU
data structure which is going to be used in later patches for the actual
implementation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 4.4: This was partly applied before; apply just the
 missing bits]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kvm/svm.c |   11 +++++++++--
 arch/x86/kvm/vmx.c |    5 +++--
 2 files changed, 12 insertions(+), 4 deletions(-)

--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -149,6 +149,12 @@ struct vcpu_svm {
 	} host;
 
 	u64 spec_ctrl;
+	/*
+	 * Contains guest-controlled bits of VIRT_SPEC_CTRL, which will be
+	 * translated into the appropriate L2_CFG bits on the host to
+	 * perform speculative control.
+	 */
+	u64 virt_spec_ctrl;
 
 	u32 *msrpm;
 
@@ -1146,6 +1152,7 @@ static void svm_vcpu_reset(struct kvm_vc
 	u32 eax = 1;
 
 	svm->spec_ctrl = 0;
+	svm->virt_spec_ctrl = 0;
 
 	if (!init_event) {
 		svm->vcpu.arch.apic_base = APIC_DEFAULT_PHYS_BASE |
@@ -3904,7 +3911,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	 * is no need to worry about the conditional branch over the wrmsr
 	 * being speculatively taken.
 	 */
-	x86_spec_ctrl_set_guest(svm->spec_ctrl);
+	x86_spec_ctrl_set_guest(svm->spec_ctrl, svm->virt_spec_ctrl);
 
 	asm volatile (
 		"push %%" _ASM_BP "; \n\t"
@@ -4028,7 +4035,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
 		svm->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
-	x86_spec_ctrl_restore_host(svm->spec_ctrl);
+	x86_spec_ctrl_restore_host(svm->spec_ctrl, svm->virt_spec_ctrl);
 
 	reload_tss(vcpu);
 
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8658,9 +8658,10 @@ static void __noclone vmx_vcpu_run(struc
 	 * is no need to worry about the conditional branch over the wrmsr
 	 * being speculatively taken.
 	 */
-	x86_spec_ctrl_set_guest(vmx->spec_ctrl);
+	x86_spec_ctrl_set_guest(vmx->spec_ctrl, 0);
 
 	vmx->__launched = vmx->loaded_vmcs->launched;
+
 	asm(
 		/* Store host registers */
 		"push %%" _ASM_DX "; push %%" _ASM_BP ";"
@@ -8796,7 +8797,7 @@ static void __noclone vmx_vcpu_run(struc
 	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
 		vmx->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
-	x86_spec_ctrl_restore_host(vmx->spec_ctrl);
+	x86_spec_ctrl_restore_host(vmx->spec_ctrl, 0);
 
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();


