Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBFBC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E1820837
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7FiKTmw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E1820837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbeKCDsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728250AbeKCDsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:48:24 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACA172082E;
        Fri,  2 Nov 2018 18:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184012;
        bh=4OByuoP9deREC6tvuXlbsfGcAHigc5vWGed7XZtmiH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S7FiKTmwliekMIlLRPB7PibqoKYTjMgMkONfRyBXVrxu7N4rj2f65y2IkJA9ACV/5
         /oAzsqiI+vTfUyKURyv9I8PlaTw3nXdEonBc3j3Q6BU/syZ69eHfNx6/WPZtyo75DF
         D0rHVMzzGQ8NdbK28LHuFbn5SGNxiPS79+ytK+Kk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eyal Moscovici <eyal.moscovici@oracle.com>,
        Nikita Leshchenko <nikita.leshchenko@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Liran Alon <liran.alon@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 050/150] KVM: nVMX: Do not expose MPX VMX controls when guest MPX disabled
Date:   Fri,  2 Nov 2018 19:33:32 +0100
Message-Id: <20181102182906.959285072@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



