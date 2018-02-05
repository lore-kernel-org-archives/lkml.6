Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753906AbeBESt7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:49:59 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:14382 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753853AbeBESs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:48:58 -0500
X-IronPort-AV: E=Sophos;i="5.46,465,1511827200";
   d="scan'208";a="718190621"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [RFC 05/12] KVM/VMX: Use the new host mapping API for mapping nested vmptr
Date: Mon,  5 Feb 2018 19:47:24 +0100
Message-Id: <1517856451-2932-6-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
References: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For nested guests the vmptr was mapped to the host kernel using
kvm_vcpu_gpa_to_page which assumes that all guest memory is backed by a
"struct page". This breaks guests that have their memory outside the kernel
control.

Switch to the new host mapping API which takes care of this use-case as
well.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 arch/x86/kvm/vmx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 40d73f4..9e45bd1 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -7364,7 +7364,7 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
 {
 	int ret;
 	gpa_t vmptr;
-	struct page *page;
+	struct kvm_host_mapping mapping;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	const u64 VMXON_NEEDED_FEATURES = FEATURE_CONTROL_LOCKED
 		| FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
@@ -7410,19 +7410,17 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
 		return kvm_skip_emulated_instruction(vcpu);
 	}
 
-	page = kvm_vcpu_gpa_to_page(vcpu, vmptr);
-	if (is_error_page(page)) {
+	if (!kvm_vcpu_gpa_to_host_mapping(vcpu, vmptr, &mapping, true)) {
 		nested_vmx_failInvalid(vcpu);
 		return kvm_skip_emulated_instruction(vcpu);
 	}
-	if (*(u32 *)kmap(page) != VMCS12_REVISION) {
-		kunmap(page);
-		kvm_release_page_clean(page);
+	if (*(u32 *)mapping.kaddr != VMCS12_REVISION) {
+		kvm_release_host_mapping(&mapping, false);
 		nested_vmx_failInvalid(vcpu);
 		return kvm_skip_emulated_instruction(vcpu);
 	}
-	kunmap(page);
-	kvm_release_page_clean(page);
+
+	kvm_release_host_mapping(&mapping, false);
 
 	vmx->nested.vmxon_ptr = vmptr;
 	ret = enter_vmx_operation(vcpu);
-- 
2.7.4
