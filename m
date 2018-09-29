Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927FEC64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FBA4206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 22:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FBA4206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeI3EbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:31:14 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51554 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726673AbeI3ESV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:21 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N60-0000Gx-ET; Sat, 29 Sep 2018 22:48:16 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5v-0006pE-9C; Sat, 29 Sep 2018 22:48:11 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ingo Molnar" <mingo@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        "Borislav Petkov" <bp@suse.de>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.593578985@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 005/131] x86/bugs, KVM: Support the combination of
 guest and host IBRS
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

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 5cf687548705412da47c9cec342fd952d71ed3d5 upstream.

A guest may modify the SPEC_CTRL MSR from the value used by the
kernel. Since the kernel doesn't use IBRS, this means a value of zero is
what is needed in the host.

But the 336996-Speculative-Execution-Side-Channel-Mitigations.pdf refers to
the other bits as reserved so the kernel should respect the boot time
SPEC_CTRL value and use that.

This allows to deal with future extensions to the SPEC_CTRL interface if
any at all.

Note: This uses wrmsrl() instead of native_wrmsl(). I does not make any
difference as paravirt will over-write the callq *0xfff.. with the wrmsrl
assembler code.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/nospec-branch.h | 10 ++++++++++
 arch/x86/kernel/cpu/bugs.c           | 18 ++++++++++++++++++
 arch/x86/kvm/svm.c                   |  6 ++----
 arch/x86/kvm/vmx.c                   |  6 ++----
 4 files changed, 32 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -183,6 +183,16 @@ enum spectre_v2_mitigation {
 extern void x86_spec_ctrl_set(u64);
 extern u64 x86_spec_ctrl_get_default(void);
 
+/*
+ * On VMENTER we must preserve whatever view of the SPEC_CTRL MSR
+ * the guest has, while on VMEXIT we restore the host view. This
+ * would be easier if SPEC_CTRL were architecturally maskable or
+ * shadowable for guests but this is not (currently) the case.
+ * Takes the guest view of SPEC_CTRL MSR as a parameter.
+ */
+extern void x86_spec_ctrl_set_guest(u64);
+extern void x86_spec_ctrl_restore_host(u64);
+
 extern char __indirect_thunk_start[];
 extern char __indirect_thunk_end[];
 
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -185,6 +185,24 @@ u64 x86_spec_ctrl_get_default(void)
 }
 EXPORT_SYMBOL_GPL(x86_spec_ctrl_get_default);
 
+void x86_spec_ctrl_set_guest(u64 guest_spec_ctrl)
+{
+	if (!boot_cpu_has(X86_FEATURE_IBRS))
+		return;
+	if (x86_spec_ctrl_base != guest_spec_ctrl)
+		wrmsrl(MSR_IA32_SPEC_CTRL, guest_spec_ctrl);
+}
+EXPORT_SYMBOL_GPL(x86_spec_ctrl_set_guest);
+
+void x86_spec_ctrl_restore_host(u64 guest_spec_ctrl)
+{
+	if (!boot_cpu_has(X86_FEATURE_IBRS))
+		return;
+	if (x86_spec_ctrl_base != guest_spec_ctrl)
+		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
+}
+EXPORT_SYMBOL_GPL(x86_spec_ctrl_restore_host);
+
 #ifdef RETPOLINE
 static bool spectre_v2_bad_module;
 
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3967,8 +3967,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	 * is no need to worry about the conditional branch over the wrmsr
 	 * being speculatively taken.
 	 */
-	if (svm->spec_ctrl)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
+	x86_spec_ctrl_set_guest(svm->spec_ctrl);
 
 	asm volatile (
 		"push %%" _ASM_BP "; \n\t"
@@ -4080,8 +4079,7 @@ static void svm_vcpu_run(struct kvm_vcpu
 	if (unlikely(!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL)))
 		svm->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
-	if (svm->spec_ctrl)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+	x86_spec_ctrl_restore_host(svm->spec_ctrl);
 
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -7540,8 +7540,7 @@ static void __noclone vmx_vcpu_run(struc
 	 * is no need to worry about the conditional branch over the wrmsr
 	 * being speculatively taken.
 	 */
-	if (vmx->spec_ctrl)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
+	x86_spec_ctrl_set_guest(vmx->spec_ctrl);
 
 	vmx->__launched = vmx->loaded_vmcs->launched;
 	asm(
@@ -7674,8 +7673,7 @@ static void __noclone vmx_vcpu_run(struc
 	if (unlikely(!msr_write_intercepted_l01(vcpu, MSR_IA32_SPEC_CTRL)))
 		vmx->spec_ctrl = native_read_msr(MSR_IA32_SPEC_CTRL);
 
-	if (vmx->spec_ctrl)
-		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+	x86_spec_ctrl_restore_host(vmx->spec_ctrl);
 
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();

