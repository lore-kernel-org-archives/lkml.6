Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934955AbeBURrn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:47:43 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:46048 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932422AbeBURrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:47:39 -0500
X-IronPort-AV: E=Sophos;i="5.47,375,1515456000";
   d="scan'208";a="720905219"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hpa@zytor.com, jmattson@google.com, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH 01/10] X86/nVMX: handle_vmon: Read 4 bytes from guest memory instead of map->read->unmap sequence
Date: Wed, 21 Feb 2018 18:47:12 +0100
Message-Id: <1519235241-6500-2-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519235241-6500-1-git-send-email-karahmed@amazon.de>
References: <1519235241-6500-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... which also avoids using kvm_vcpu_gpa_to_page() and kmap() which assumes
that there is a "struct page" for guest memory.

Suggested-by: Jim Mattson <jmattson@google.com>
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 arch/x86/kvm/vmx.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 19a150b..cf696e2 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -7562,7 +7562,7 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
 {
 	int ret;
 	gpa_t vmptr;
-	struct page *page;
+	uint32_t revision;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	const u64 VMXON_NEEDED_FEATURES = FEATURE_CONTROL_LOCKED
 		| FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
@@ -7608,19 +7608,11 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
 		return kvm_skip_emulated_instruction(vcpu);
 	}
 
-	page = kvm_vcpu_gpa_to_page(vcpu, vmptr);
-	if (is_error_page(page)) {
+	if (kvm_read_guest(vcpu->kvm, vmptr, &revision, sizeof(revision)) ||
+	    revision != VMCS12_REVISION) {
 		nested_vmx_failInvalid(vcpu);
 		return kvm_skip_emulated_instruction(vcpu);
 	}
-	if (*(u32 *)kmap(page) != VMCS12_REVISION) {
-		kunmap(page);
-		kvm_release_page_clean(page);
-		nested_vmx_failInvalid(vcpu);
-		return kvm_skip_emulated_instruction(vcpu);
-	}
-	kunmap(page);
-	kvm_release_page_clean(page);
 
 	vmx->nested.vmxon_ptr = vmptr;
 	ret = enter_vmx_operation(vcpu);
-- 
2.7.4
