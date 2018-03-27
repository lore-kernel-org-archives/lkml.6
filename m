Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbeC0CNM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 22:13:12 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42204 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752266AbeC0CNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 22:13:08 -0400
X-Google-Smtp-Source: AG47ELuh4tHbcHJmjBfwzxs/rCpfhVMxQ8FCeECOsnN2OE4cQpoLEVUVXE6826pC+UG0j0dJ/33iEA==
From: Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: [PATCH 1/2] KVM: VMX: Introduce handle_ud()
Date: Mon, 26 Mar 2018 19:12:14 -0700
Message-Id: <1522116735-4861-2-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522116735-4861-1-git-send-email-wanpengli@tencent.com>
References: <1522116735-4861-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Introduce handle_ud() to handle invalid opcode, this function will be 
used by later patches.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/vmx.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 9bc05f5..0f99833 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -6215,6 +6215,18 @@ static int handle_machine_check(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+static int handle_ud(struct kvm_vcpu *vcpu)
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
+
 static int handle_exception(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -6233,14 +6245,8 @@ static int handle_exception(struct kvm_vcpu *vcpu)
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
-- 
2.7.4
