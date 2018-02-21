Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938512AbeBURz0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:55:26 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:20388 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934879AbeBURrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:47:41 -0500
X-IronPort-AV: E=Sophos;i="5.47,375,1515456000";
   d="scan'208";a="667841860"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hpa@zytor.com, jmattson@google.com, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de,
        KarimAllah Ahmed <karahmed@amazon.de>
Subject: [PATCH 02/10] X86/nVMX: handle_vmptrld: Copy the VMCS12 directly from guest memory instead of map->copy->unmap sequence.
Date: Wed, 21 Feb 2018 18:47:13 +0100
Message-Id: <1519235241-6500-3-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519235241-6500-1-git-send-email-karahmed@amazon.de>
References: <1519235241-6500-1-git-send-email-karahmed@amazon.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... which also avoids using kvm_vcpu_gpa_to_page() and kmap() which assumes
that there is a "struct page" for guest memory.

Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 arch/x86/kvm/vmx.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index cf696e2..e5653d2 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8046,30 +8046,18 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
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
