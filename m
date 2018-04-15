Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752952AbeDOV5t (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 17:57:49 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:27408 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752623AbeDOVy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 17:54:58 -0400
X-IronPort-AV: E=Sophos;i="5.48,456,1517875200";
   d="scan'208";a="606991216"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH v2 02/12] X86/nVMX: handle_vmptrld: Copy the VMCS12 directly from guest memory
Date: Sun, 15 Apr 2018 23:53:08 +0200
Message-Id: <1523829198-13236-3-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523829198-13236-1-git-send-email-karahmed@amazon.de>
References: <1523829198-13236-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copy the VMCS12 directly from guest memory instead of the map->copy->unmap
sequence. This also avoids using kvm_vcpu_gpa_to_page() and kmap() which
assumes that there is a "struct page" for guest memory.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
v1 -> v2:
- Massage commit message a bit.
---
 arch/x86/kvm/vmx.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 77fc1ee..810ba7a 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8156,30 +8156,18 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 	}
 
 	if (vmx->nested.current_vmptr != vmptr) {
-		struct vmcs12 *new_vmcs12;
-		struct page *page;
-		page = kvm_vcpu_gpa_to_page(vcpu, vmptr);
-		if (is_error_page(page)) {
-			nested_vmx_failInvalid(vcpu);
-			return kvm_skip_emulated_instruction(vcpu);
-		}
-		new_vmcs12 = kmap(page);
-		if (new_vmcs12->revision_id != VMCS12_REVISION) {
-			kunmap(page);
-			kvm_release_page_clean(page);
-			nested_vmx_failValid(vcpu,
-				VMXERR_VMPTRLD_INCORRECT_VMCS_REVISION_ID);
-			return kvm_skip_emulated_instruction(vcpu);
-		}
-
 		nested_release_vmcs12(vmx);
+
 		/*
 		 * Load VMCS12 from guest memory since it is not already
 		 * cached.
 		 */
-		memcpy(vmx->nested.cached_vmcs12, new_vmcs12, VMCS12_SIZE);
-		kunmap(page);
-		kvm_release_page_clean(page);
+		if (kvm_read_guest(vcpu->kvm, vmptr, vmx->nested.cached_vmcs12,
+				   sizeof(*vmx->nested.cached_vmcs12)) ||
+		    vmx->nested.cached_vmcs12->revision_id != VMCS12_REVISION) {
+			nested_vmx_failInvalid(vcpu);
+			return kvm_skip_emulated_instruction(vcpu);
+		}
 
 		set_current_vmptr(vmx, vmptr);
 	}
-- 
2.7.4
