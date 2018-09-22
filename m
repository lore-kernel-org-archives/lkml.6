Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2334EECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC3D2156B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC3D2156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392132AbeIVGRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:17:44 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44072 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391846AbeIVGKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:42 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vds-0008Bb-O9; Sat, 22 Sep 2018 01:19:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdn-0000qv-Ii; Sat, 22 Sep 2018 01:19:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Paolo Bonzini" <pbonzini@redhat.com>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.432581606@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 16/63] KVM: x86: pass kvm_vcpu to kvm_read_guest_virt
 and kvm_write_guest_virt_system
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Bonzini <pbonzini@redhat.com>

commit ce14e868a54edeb2e30cb7a7b104a2fc4b9d76ca upstream.

Int the next patch the emulator's .read_std and .write_std callbacks will
grow another argument, which is not needed in kvm_read_guest_virt and
kvm_write_guest_virt_system's callers.  Since we have to make separate
functions, let's give the currently existing names a nicer interface, too.

Fixes: 129a72a0d3c8 ("KVM: x86: Introduce segmented_write_std", 2017-01-12)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[bwh: Backported to 3.16:
 - Drop change to handle_invvpid()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -6027,8 +6027,7 @@ static int nested_vmx_check_vmptr(struct
 			vmcs_read32(VMX_INSTRUCTION_INFO), &gva))
 		return 1;
 
-	if (kvm_read_guest_virt(&vcpu->arch.emulate_ctxt, gva, &vmptr,
-				sizeof(vmptr), &e)) {
+	if (kvm_read_guest_virt(vcpu, gva, &vmptr, sizeof(vmptr), &e)) {
 		kvm_inject_page_fault(vcpu, &e);
 		return 1;
 	}
@@ -6539,8 +6538,8 @@ static int handle_vmread(struct kvm_vcpu
 				vmx_instruction_info, &gva))
 			return 1;
 		/* _system ok, as nested_vmx_check_permission verified cpl=0 */
-		kvm_write_guest_virt_system(&vcpu->arch.emulate_ctxt, gva,
-			     &field_value, (is_long_mode(vcpu) ? 8 : 4), NULL);
+		kvm_write_guest_virt_system(vcpu, gva, &field_value,
+					    (is_long_mode(vcpu) ? 8 : 4), NULL);
 	}
 
 	nested_vmx_succeed(vcpu);
@@ -6575,8 +6574,8 @@ static int handle_vmwrite(struct kvm_vcp
 		if (get_vmx_mem_address(vcpu, exit_qualification,
 				vmx_instruction_info, &gva))
 			return 1;
-		if (kvm_read_guest_virt(&vcpu->arch.emulate_ctxt, gva,
-			   &field_value, (is_long_mode(vcpu) ? 8 : 4), &e)) {
+		if (kvm_read_guest_virt(vcpu, gva, &field_value,
+					(is_long_mode(vcpu) ? 8 : 4), &e)) {
 			kvm_inject_page_fault(vcpu, &e);
 			return 1;
 		}
@@ -6669,9 +6668,9 @@ static int handle_vmptrst(struct kvm_vcp
 			vmx_instruction_info, &vmcs_gva))
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
@@ -6723,8 +6722,7 @@ static int handle_invept(struct kvm_vcpu
 	if (get_vmx_mem_address(vcpu, vmcs_readl(EXIT_QUALIFICATION),
 			vmx_instruction_info, &gva))
 		return 1;
-	if (kvm_read_guest_virt(&vcpu->arch.emulate_ctxt, gva, &operand,
-				sizeof(operand), &e)) {
+	if (kvm_read_guest_virt(vcpu, gva, &operand, sizeof(operand), &e)) {
 		kvm_inject_page_fault(vcpu, &e);
 		return 1;
 	}
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4178,11 +4178,10 @@ static int kvm_fetch_guest_virt(struct x
 					  exception);
 }
 
-int kvm_read_guest_virt(struct x86_emulate_ctxt *ctxt,
+int kvm_read_guest_virt(struct kvm_vcpu *vcpu,
 			       gva_t addr, void *val, unsigned int bytes,
 			       struct x86_exception *exception)
 {
-	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 	u32 access = (kvm_x86_ops->get_cpl(vcpu) == 3) ? PFERR_USER_MASK : 0;
 
 	return kvm_read_guest_virt_helper(addr, val, bytes, vcpu, access,
@@ -4190,26 +4189,24 @@ int kvm_read_guest_virt(struct x86_emula
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
@@ -4230,6 +4227,22 @@ int kvm_write_guest_virt_system(struct x
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
@@ -4902,8 +4915,8 @@ static void emulator_write_gpr(struct x8
 static const struct x86_emulate_ops emulate_ops = {
 	.read_gpr            = emulator_read_gpr,
 	.write_gpr           = emulator_write_gpr,
-	.read_std            = kvm_read_guest_virt_system,
-	.write_std           = kvm_write_guest_virt_system,
+	.read_std            = emulator_read_std,
+	.write_std           = emulator_write_std,
 	.fetch               = kvm_fetch_guest_virt,
 	.read_emulated       = emulator_read_emulated,
 	.write_emulated      = emulator_write_emulated,
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -124,11 +124,11 @@ int kvm_inject_realmode_interrupt(struct
 
 void kvm_write_tsc(struct kvm_vcpu *vcpu, struct msr_data *msr);
 
-int kvm_read_guest_virt(struct x86_emulate_ctxt *ctxt,
+int kvm_read_guest_virt(struct kvm_vcpu *vcpu,
 	gva_t addr, void *val, unsigned int bytes,
 	struct x86_exception *exception);
 
-int kvm_write_guest_virt_system(struct x86_emulate_ctxt *ctxt,
+int kvm_write_guest_virt_system(struct kvm_vcpu *vcpu,
 	gva_t addr, void *val, unsigned int bytes,
 	struct x86_exception *exception);
 

