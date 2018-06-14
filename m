Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8EAC0C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B353208DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbEz+Y/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B353208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965897AbeFNOLq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965880AbeFNOLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:11:40 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B235A208E1;
        Thu, 14 Jun 2018 14:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985500;
        bh=+rKWRwT4IWpGE7gbPt743hfjuXfcOM7FbDbrV1GIyH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SbEz+Y/UeoyVTmnOVbsd+2nRYwpd7f7bM4DG5ez5vtx4Fgkz7YU4TuTdRE9b4TkOB
         RDsqazqDu8YWWWRA6ycXyQTva05JF/8rRV3NKRICnuqF9/zHQfa4AQZooRoYG0HAJp
         JcTxhJLbKmWAA6Cl3ci35Mzg1spRRaVtHbXBAF+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.9 13/30] KVM: x86: pass kvm_vcpu to kvm_read_guest_virt and kvm_write_guest_virt_system
Date:   Thu, 14 Jun 2018 16:04:54 +0200
Message-Id: <20180614132600.817092376@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132600.255515394@linuxfoundation.org>
References: <20180614132600.255515394@linuxfoundation.org>
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

From: Paolo Bonzini <pbonzini@redhat.com>

commit ce14e868a54edeb2e30cb7a7b104a2fc4b9d76ca upstream.

Int the next patch the emulator's .read_std and .write_std callbacks will
grow another argument, which is not needed in kvm_read_guest_virt and
kvm_write_guest_virt_system's callers.  Since we have to make separate
functions, let's give the currently existing names a nicer interface, too.

Fixes: 129a72a0d3c8 ("KVM: x86: Introduce segmented_write_std", 2017-01-12)
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |   23 ++++++++++-------------
 arch/x86/kvm/x86.c |   39 ++++++++++++++++++++++++++-------------
 arch/x86/kvm/x86.h |    4 ++--
 3 files changed, 38 insertions(+), 28 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -6928,8 +6928,7 @@ static int nested_vmx_check_vmptr(struct
 			vmcs_read32(VMX_INSTRUCTION_INFO), false, &gva))
 		return 1;
 
-	if (kvm_read_guest_virt(&vcpu->arch.emulate_ctxt, gva, &vmptr,
-				sizeof(vmptr), &e)) {
+	if (kvm_read_guest_virt(vcpu, gva, &vmptr, sizeof(vmptr), &e)) {
 		kvm_inject_page_fault(vcpu, &e);
 		return 1;
 	}
@@ -7469,8 +7468,8 @@ static int handle_vmread(struct kvm_vcpu
 				vmx_instruction_info, true, &gva))
 			return 1;
 		/* _system ok, as nested_vmx_check_permission verified cpl=0 */
-		kvm_write_guest_virt_system(&vcpu->arch.emulate_ctxt, gva,
-			     &field_value, (is_long_mode(vcpu) ? 8 : 4), NULL);
+		kvm_write_guest_virt_system(vcpu, gva, &field_value,
+					    (is_long_mode(vcpu) ? 8 : 4), NULL);
 	}
 
 	nested_vmx_succeed(vcpu);
@@ -7505,8 +7504,8 @@ static int handle_vmwrite(struct kvm_vcp
 		if (get_vmx_mem_address(vcpu, exit_qualification,
 				vmx_instruction_info, false, &gva))
 			return 1;
-		if (kvm_read_guest_virt(&vcpu->arch.emulate_ctxt, gva,
-			   &field_value, (is_64_bit_mode(vcpu) ? 8 : 4), &e)) {
+		if (kvm_read_guest_virt(vcpu, gva, &field_value,
+					(is_64_bit_mode(vcpu) ? 8 : 4), &e)) {
 			kvm_inject_page_fault(vcpu, &e);
 			return 1;
 		}
@@ -7603,9 +7602,9 @@ static int handle_vmptrst(struct kvm_vcp
 			vmx_instruction_info, true, &vmcs_gva))
 		return 1;
 	/* ok to use *_system, as nested_vmx_check_permission verified cpl=0 */
-	if (kvm_write_guest_virt_system(&vcpu->arch.emulate_ctxt, vmcs_gva,
-				 (void *)&to_vmx(vcpu)->nested.current_vmptr,
-				 sizeof(u64), &e)) {
+	if (kvm_write_guest_virt_system(vcpu, vmcs_gva,
+					(void *)&to_vmx(vcpu)->nested.current_vmptr,
+					sizeof(u64), &e)) {
 		kvm_inject_page_fault(vcpu, &e);
 		return 1;
 	}
@@ -7659,8 +7658,7 @@ static int handle_invept(struct kvm_vcpu
 	if (get_vmx_mem_address(vcpu, vmcs_readl(EXIT_QUALIFICATION),
 			vmx_instruction_info, false, &gva))
 		return 1;
-	if (kvm_read_guest_virt(&vcpu->arch.emulate_ctxt, gva, &operand,
-				sizeof(operand), &e)) {
+	if (kvm_read_guest_virt(vcpu, gva, &operand, sizeof(operand), &e)) {
 		kvm_inject_page_fault(vcpu, &e);
 		return 1;
 	}
@@ -7723,8 +7721,7 @@ static int handle_invvpid(struct kvm_vcp
 	if (get_vmx_mem_address(vcpu, vmcs_readl(EXIT_QUALIFICATION),
 			vmx_instruction_info, false, &gva))
 		return 1;
-	if (kvm_read_guest_virt(&vcpu->arch.emulate_ctxt, gva, &vpid,
-				sizeof(u32), &e)) {
+	if (kvm_read_guest_virt(vcpu, gva, &vpid, sizeof(u32), &e)) {
 		kvm_inject_page_fault(vcpu, &e);
 		return 1;
 	}
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4395,11 +4395,10 @@ static int kvm_fetch_guest_virt(struct x
 	return X86EMUL_CONTINUE;
 }
 
-int kvm_read_guest_virt(struct x86_emulate_ctxt *ctxt,
+int kvm_read_guest_virt(struct kvm_vcpu *vcpu,
 			       gva_t addr, void *val, unsigned int bytes,
 			       struct x86_exception *exception)
 {
-	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 	u32 access = (kvm_x86_ops->get_cpl(vcpu) == 3) ? PFERR_USER_MASK : 0;
 
 	return kvm_read_guest_virt_helper(addr, val, bytes, vcpu, access,
@@ -4407,9 +4406,9 @@ int kvm_read_guest_virt(struct x86_emula
 }
 EXPORT_SYMBOL_GPL(kvm_read_guest_virt);
 
-static int kvm_read_guest_virt_system(struct x86_emulate_ctxt *ctxt,
-				      gva_t addr, void *val, unsigned int bytes,
-				      struct x86_exception *exception)
+static int emulator_read_std(struct x86_emulate_ctxt *ctxt,
+			     gva_t addr, void *val, unsigned int bytes,
+			     struct x86_exception *exception)
 {
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 	return kvm_read_guest_virt_helper(addr, val, bytes, vcpu, 0, exception);
@@ -4424,18 +4423,16 @@ static int kvm_read_guest_phys_system(st
 	return r < 0 ? X86EMUL_IO_NEEDED : X86EMUL_CONTINUE;
 }
 
-int kvm_write_guest_virt_system(struct x86_emulate_ctxt *ctxt,
-				       gva_t addr, void *val,
-				       unsigned int bytes,
-				       struct x86_exception *exception)
+static int kvm_write_guest_virt_helper(gva_t addr, void *val, unsigned int bytes,
+				      struct kvm_vcpu *vcpu, u32 access,
+				      struct x86_exception *exception)
 {
-	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 	void *data = val;
 	int r = X86EMUL_CONTINUE;
 
 	while (bytes) {
 		gpa_t gpa =  vcpu->arch.walk_mmu->gva_to_gpa(vcpu, addr,
-							     PFERR_WRITE_MASK,
+							     access,
 							     exception);
 		unsigned offset = addr & (PAGE_SIZE-1);
 		unsigned towrite = min(bytes, (unsigned)PAGE_SIZE - offset);
@@ -4456,6 +4453,22 @@ int kvm_write_guest_virt_system(struct x
 out:
 	return r;
 }
+
+static int emulator_write_std(struct x86_emulate_ctxt *ctxt, gva_t addr, void *val,
+			      unsigned int bytes, struct x86_exception *exception)
+{
+	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
+
+	return kvm_write_guest_virt_helper(addr, val, bytes, vcpu,
+					   PFERR_WRITE_MASK, exception);
+}
+
+int kvm_write_guest_virt_system(struct kvm_vcpu *vcpu, gva_t addr, void *val,
+				unsigned int bytes, struct x86_exception *exception)
+{
+	return kvm_write_guest_virt_helper(addr, val, bytes, vcpu,
+					   PFERR_WRITE_MASK, exception);
+}
 EXPORT_SYMBOL_GPL(kvm_write_guest_virt_system);
 
 static int vcpu_mmio_gva_to_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
@@ -5180,8 +5193,8 @@ static void emulator_set_hflags(struct x
 static const struct x86_emulate_ops emulate_ops = {
 	.read_gpr            = emulator_read_gpr,
 	.write_gpr           = emulator_write_gpr,
-	.read_std            = kvm_read_guest_virt_system,
-	.write_std           = kvm_write_guest_virt_system,
+	.read_std            = emulator_read_std,
+	.write_std           = emulator_write_std,
 	.read_phys           = kvm_read_guest_phys_system,
 	.fetch               = kvm_fetch_guest_virt,
 	.read_emulated       = emulator_read_emulated,
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -161,11 +161,11 @@ int kvm_inject_realmode_interrupt(struct
 void kvm_write_tsc(struct kvm_vcpu *vcpu, struct msr_data *msr);
 u64 get_kvmclock_ns(struct kvm *kvm);
 
-int kvm_read_guest_virt(struct x86_emulate_ctxt *ctxt,
+int kvm_read_guest_virt(struct kvm_vcpu *vcpu,
 	gva_t addr, void *val, unsigned int bytes,
 	struct x86_exception *exception);
 
-int kvm_write_guest_virt_system(struct x86_emulate_ctxt *ctxt,
+int kvm_write_guest_virt_system(struct kvm_vcpu *vcpu,
 	gva_t addr, void *val, unsigned int bytes,
 	struct x86_exception *exception);
 


