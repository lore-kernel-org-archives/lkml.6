Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061AEC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C039220866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzeqpeca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C039220866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbeJPMBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbeJPMBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81B8021476;
        Tue, 16 Oct 2018 04:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663194;
        bh=wyunlqN90djKdxe4bozoBYtPB9PwmTerEfQAyC3WTzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fzeqpecaDB7/S/kyqRxe4Ykx+GunTUQdJsDcLvgDcaT5mbAulsYzrPjOUf9WpGUvb
         jctQd3wrXGGzNQBXYZ3+TuIc4c+c5IvFqZ8e6g75W5D1r0sVrP/V0uY8CtXjYzZo7q
         z5nzWWhL5tnN2RpgvAqdZBri+fhVAlzg721/Ics4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Liran Alon <liran.alon@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 057/100] KVM: nVMX: Do not expose MPX VMX controls when guest MPX disabled
Date:   Tue, 16 Oct 2018 00:11:38 -0400
Message-Id: <20181016041221.135528-57-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liran Alon <liran.alon@oracle.com>

[ Upstream commit 5f76f6f5ff96587af5acd5930f7d9fea81e0d1a8 ]

Before this commit, KVM exposes MPX VMX controls to L1 guest only based
on if KVM and host processor supports MPX virtualization.
However, these controls should be exposed to guest only in case guest
vCPU supports MPX.

Without this change, a L1 guest running with kernel which don't have
commit 691bd4340bef ("kvm: vmx: allow host to access guest
MSR_IA32_BNDCFGS") asserts in QEMU on the following:
	qemu-kvm: error: failed to set MSR 0xd90 to 0x0
	qemu-kvm: .../qemu-2.10.0/target/i386/kvm.c:1801 kvm_put_msrs:
	Assertion 'ret == cpu->kvm_msr_buf->nmsrs failed'
This is because L1 KVM kvm_init_msr_list() will see that
vmx_mpx_supported() (As it only checks MPX VMX controls support) and
therefore KVM_GET_MSR_INDEX_LIST IOCTL will include MSR_IA32_BNDCFGS.
However, later when L1 will attempt to set this MSR via KVM_SET_MSRS
IOCTL, it will fail because !guest_cpuid_has_mpx(vcpu).

Therefore, fix the issue by exposing MPX VMX controls to L1 guest only
when vCPU supports MPX.

Fixes: 36be0b9deb23 ("KVM: x86: Add nested virtualization support for MPX")

Reported-by: Eyal Moscovici <eyal.moscovici@oracle.com>
Reviewed-by: Nikita Leshchenko <nikita.leshchenko@oracle.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kvm/vmx.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 32721ef9652d..ea691ddfc3aa 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -3395,9 +3395,6 @@ static void nested_vmx_setup_ctls_msrs(struct nested_vmx_msrs *msrs, bool apicv)
 		VM_EXIT_LOAD_IA32_EFER | VM_EXIT_SAVE_IA32_EFER |
 		VM_EXIT_SAVE_VMX_PREEMPTION_TIMER | VM_EXIT_ACK_INTR_ON_EXIT;
 
-	if (kvm_mpx_supported())
-		msrs->exit_ctls_high |= VM_EXIT_CLEAR_BNDCFGS;
-
 	/* We support free control of debug control saving. */
 	msrs->exit_ctls_low &= ~VM_EXIT_SAVE_DEBUG_CONTROLS;
 
@@ -3414,8 +3411,6 @@ static void nested_vmx_setup_ctls_msrs(struct nested_vmx_msrs *msrs, bool apicv)
 		VM_ENTRY_LOAD_IA32_PAT;
 	msrs->entry_ctls_high |=
 		(VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR | VM_ENTRY_LOAD_IA32_EFER);
-	if (kvm_mpx_supported())
-		msrs->entry_ctls_high |= VM_ENTRY_LOAD_BNDCFGS;
 
 	/* We support free control of debug control loading. */
 	msrs->entry_ctls_low &= ~VM_ENTRY_LOAD_DEBUG_CONTROLS;
@@ -10825,6 +10820,23 @@ static void nested_vmx_cr_fixed1_bits_update(struct kvm_vcpu *vcpu)
 #undef cr4_fixed1_update
 }
 
+static void nested_vmx_entry_exit_ctls_update(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+
+	if (kvm_mpx_supported()) {
+		bool mpx_enabled = guest_cpuid_has(vcpu, X86_FEATURE_MPX);
+
+		if (mpx_enabled) {
+			vmx->nested.msrs.entry_ctls_high |= VM_ENTRY_LOAD_BNDCFGS;
+			vmx->nested.msrs.exit_ctls_high |= VM_EXIT_CLEAR_BNDCFGS;
+		} else {
+			vmx->nested.msrs.entry_ctls_high &= ~VM_ENTRY_LOAD_BNDCFGS;
+			vmx->nested.msrs.exit_ctls_high &= ~VM_EXIT_CLEAR_BNDCFGS;
+		}
+	}
+}
+
 static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -10841,8 +10853,10 @@ static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
 		to_vmx(vcpu)->msr_ia32_feature_control_valid_bits &=
 			~FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
 
-	if (nested_vmx_allowed(vcpu))
+	if (nested_vmx_allowed(vcpu)) {
 		nested_vmx_cr_fixed1_bits_update(vcpu);
+		nested_vmx_entry_exit_ctls_update(vcpu);
+	}
 }
 
 static void vmx_set_supported_cpuid(u32 func, struct kvm_cpuid_entry2 *entry)
-- 
2.17.1

