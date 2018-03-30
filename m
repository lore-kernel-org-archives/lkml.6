Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbeC3JHo (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:07:44 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44239 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbeC3JHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:07:40 -0400
X-Google-Smtp-Source: AIpwx4+fe5hja5XQoNfMZ64aL+JtmFRGWlRGwLiw8cCpOLEyZn1No7LRLJucANxjGRlhLuOkLsWgXQ==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH v4 1/2] KVM: X86: Introduce handle_ud()
Date: Fri, 30 Mar 2018 02:06:43 -0700
Message-Id: <1522400804-4578-2-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522400804-4578-1-git-send-email-wanpengli@tencent.com>
References: <1522400804-4578-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Introduce handle_ud() to handle invalid opcode, this function will be
used by later patches.

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Reviewed-By: Liran Alon <liran.alon@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/svm.c |  9 +--------
 arch/x86/kvm/vmx.c | 10 ++--------
 arch/x86/kvm/x86.c | 13 +++++++++++++
 arch/x86/kvm/x86.h |  2 ++
 4 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index f66fc2e..e0a3f56 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -2676,14 +2676,7 @@ static int bp_interception(struct vcpu_svm *svm)
 
 static int ud_interception(struct vcpu_svm *svm)
 {
-	int er;
-
-	er = emulate_instruction(&svm->vcpu, EMULTYPE_TRAP_UD);
-	if (er == EMULATE_USER_EXIT)
-		return 0;
-	if (er != EMULATE_DONE)
-		kvm_queue_exception(&svm->vcpu, UD_VECTOR);
-	return 1;
+	return handle_ud(&svm->vcpu);
 }
 
 static int ac_interception(struct vcpu_svm *svm)
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index b2f8a70..0f11243 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -6436,14 +6436,8 @@ static int handle_exception(struct kvm_vcpu *vcpu)
 	if (is_nmi(intr_info))
 		return 1;  /* already handled by vmx_vcpu_run() */
 
-	if (is_invalid_opcode(intr_info)) {
-		er = emulate_instruction(vcpu, EMULTYPE_TRAP_UD);
-		if (er == EMULATE_USER_EXIT)
-			return 0;
-		if (er != EMULATE_DONE)
-			kvm_queue_exception(vcpu, UD_VECTOR);
-		return 1;
-	}
+	if (is_invalid_opcode(intr_info))
+		return handle_ud(vcpu);
 
 	error_code = 0;
 	if (intr_info & INTR_INFO_DELIVER_CODE_MASK)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7d9a444..1eb495e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4840,6 +4840,19 @@ int kvm_write_guest_virt_system(struct x86_emulate_ctxt *ctxt,
 }
 EXPORT_SYMBOL_GPL(kvm_write_guest_virt_system);
 
+int handle_ud(struct kvm_vcpu *vcpu)
+{
+	enum emulation_result er;
+
+	er = emulate_instruction(vcpu, EMULTYPE_TRAP_UD);
+	if (er == EMULATE_USER_EXIT)
+		return 0;
+	if (er != EMULATE_DONE)
+		kvm_queue_exception(vcpu, UD_VECTOR);
+	return 1;
+}
+EXPORT_SYMBOL_GPL(handle_ud);
+
 static int vcpu_is_mmio_gpa(struct kvm_vcpu *vcpu, unsigned long gva,
 			    gpa_t gpa, bool write)
 {
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 1e86174..7d35ce6 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -255,6 +255,8 @@ int kvm_write_guest_virt_system(struct x86_emulate_ctxt *ctxt,
 	gva_t addr, void *val, unsigned int bytes,
 	struct x86_exception *exception);
 
+int handle_ud(struct kvm_vcpu *vcpu);
+
 void kvm_vcpu_mtrr_init(struct kvm_vcpu *vcpu);
 u8 kvm_mtrr_get_guest_memory_type(struct kvm_vcpu *vcpu, gfn_t gfn);
 bool kvm_mtrr_valid(struct kvm_vcpu *vcpu, u32 msr, u64 data);
-- 
2.7.4
