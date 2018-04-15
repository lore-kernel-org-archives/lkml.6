Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753088AbeDOVzt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 17:55:49 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:40933 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeDOVzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 17:55:01 -0400
X-IronPort-AV: E=Sophos;i="5.48,456,1517875200";
   d="scan'208";a="726275411"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v2 01/12] X86/nVMX: handle_vmon: Read 4 bytes from guest memory
Date: Sun, 15 Apr 2018 23:53:07 +0200
Message-Id: <1523829198-13236-2-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523829198-13236-1-git-send-email-karahmed@amazon.de>
References: <1523829198-13236-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read the data directly from guest memory instead instead of the
map->read->unmap sequence. This also avoids using kvm_vcpu_gpa_to_page()
and kmap() which assumes that there is a "struct page" for guest memory.

Suggested-by: Jim Mattson <jmattson@google.com>
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
v1 -> v2:
- Massage commit message a bit.
---
 arch/x86/kvm/vmx.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 55ab0ca..77fc1ee 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -7672,7 +7672,7 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
 {
 	int ret;
 	gpa_t vmptr;
-	struct page *page;
+	uint32_t revision;
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	const u64 VMXON_NEEDED_FEATURES = FEATURE_CONTROL_LOCKED
 		| FEATURE_CONTROL_VMXON_ENABLED_OUTSIDE_SMX;
@@ -7718,19 +7718,11 @@ static int handle_vmon(struct kvm_vcpu *vcpu)
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
