Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753882AbeBESvT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:51:19 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:15456 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753401AbeBESr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:47:59 -0500
X-IronPort-AV: E=Sophos;i="5.46,465,1511827200";
   d="scan'208";a="706879275"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [RFC 06/12] KVM/VMX: Use the new host mapping API for handle_vmptrld
Date: Mon,  5 Feb 2018 19:47:25 +0100
Message-Id: <1517856451-2932-7-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
References: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
---
 arch/x86/kvm/vmx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 9e45bd1..9544df0 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -7865,30 +7865,30 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 	}
 
 	if (vmx->nested.current_vmptr != vmptr) {
+		struct kvm_host_mapping mapping;
 		struct vmcs12 *new_vmcs12;
-		struct page *page;
-		page = kvm_vcpu_gpa_to_page(vcpu, vmptr);
-		if (is_error_page(page)) {
+
+		if (!kvm_vcpu_gpa_to_host_mapping(vcpu, vmptr, &mapping, true)) {
 			nested_vmx_failInvalid(vcpu);
 			return kvm_skip_emulated_instruction(vcpu);
 		}
-		new_vmcs12 = kmap(page);
+
+		new_vmcs12 = mapping.kaddr;
 		if (new_vmcs12->revision_id != VMCS12_REVISION) {
-			kunmap(page);
-			kvm_release_page_clean(page);
+			kvm_release_host_mapping(&mapping, false);
 			nested_vmx_failValid(vcpu,
 				VMXERR_VMPTRLD_INCORRECT_VMCS_REVISION_ID);
 			return kvm_skip_emulated_instruction(vcpu);
 		}
 
 		nested_release_vmcs12(vmx);
+
 		/*
 		 * Load VMCS12 from guest memory since it is not already
 		 * cached.
 		 */
 		memcpy(vmx->nested.cached_vmcs12, new_vmcs12, VMCS12_SIZE);
-		kunmap(page);
-		kvm_release_page_clean(page);
+		kvm_release_host_mapping(&mapping, false);
 
 		set_current_vmptr(vmx, vmptr);
 	}
-- 
2.7.4
