Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753647AbeBESuI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:50:08 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:14366 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753984AbeBESs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:48:56 -0500
X-IronPort-AV: E=Sophos;i="5.46,465,1511827200";
   d="scan'208";a="718190604"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [RFC 02/12] KVM/VMX: Use the new host mapping API for apic_access_page
Date: Mon,  5 Feb 2018 19:47:21 +0100
Message-Id: <1517856451-2932-3-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
References: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For nested guests the apic_access_page was mapped to the host kernel using
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
 arch/x86/kvm/vmx.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 5d8a6a91..b76ab06 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -451,7 +451,7 @@ struct nested_vmx {
 	 * Guest pages referred to in the vmcs02 with host-physical
 	 * pointers, so we must keep them pinned while L2 runs.
 	 */
-	struct page *apic_access_page;
+	struct kvm_host_mapping apic_access_mapping;
 	struct page *virtual_apic_page;
 	struct page *pi_desc_page;
 	struct pi_desc *pi_desc;
@@ -7500,10 +7500,8 @@ static void free_nested(struct vcpu_vmx *vmx)
 	}
 	kfree(vmx->nested.cached_vmcs12);
 	/* Unpin physical memory we referred to in the vmcs02 */
-	if (vmx->nested.apic_access_page) {
-		kvm_release_page_dirty(vmx->nested.apic_access_page);
-		vmx->nested.apic_access_page = NULL;
-	}
+	if (vmx->nested.apic_access_mapping.pfn)
+		kvm_release_host_mapping(&vmx->nested.apic_access_mapping, true);
 	if (vmx->nested.virtual_apic_page) {
 		kvm_release_page_dirty(vmx->nested.virtual_apic_page);
 		vmx->nested.virtual_apic_page = NULL;
@@ -10056,25 +10054,22 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu,
 		 * physical address remains valid. We keep a reference
 		 * to it so we can release it later.
 		 */
-		if (vmx->nested.apic_access_page) { /* shouldn't happen */
-			kvm_release_page_dirty(vmx->nested.apic_access_page);
-			vmx->nested.apic_access_page = NULL;
-		}
-		page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->apic_access_addr);
+		if (vmx->nested.apic_access_mapping.pfn) /* shouldn't happen */
+			kvm_release_host_mapping(&vmx->nested.apic_access_mapping, true);
+
 		/*
 		 * If translation failed, no matter: This feature asks
 		 * to exit when accessing the given address, and if it
 		 * can never be accessed, this feature won't do
 		 * anything anyway.
 		 */
-		if (!is_error_page(page)) {
-			vmx->nested.apic_access_page = page;
-			hpa = page_to_phys(vmx->nested.apic_access_page);
-			vmcs_write64(APIC_ACCESS_ADDR, hpa);
-		} else {
+		if (kvm_vcpu_gpa_to_host_mapping(vcpu, vmcs12->apic_access_addr,
+						 &vmx->nested.apic_access_mapping, false))
+			vmcs_write64(APIC_ACCESS_ADDR,
+				     vmx->nested.apic_access_mapping.pfn << PAGE_SHIFT);
+		else
 			vmcs_clear_bits(SECONDARY_VM_EXEC_CONTROL,
 					SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES);
-		}
 	} else if (!(nested_cpu_has_virt_x2apic_mode(vmcs12)) &&
 		   cpu_need_virtualize_apic_accesses(&vmx->vcpu)) {
 		vmcs_set_bits(SECONDARY_VM_EXEC_CONTROL,
@@ -11686,10 +11681,8 @@ static void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
 	vmx->host_rsp = 0;
 
 	/* Unpin physical memory we referred to in vmcs02 */
-	if (vmx->nested.apic_access_page) {
-		kvm_release_page_dirty(vmx->nested.apic_access_page);
-		vmx->nested.apic_access_page = NULL;
-	}
+	if (vmx->nested.apic_access_mapping.pfn)
+		kvm_release_host_mapping(&vmx->nested.apic_access_mapping, true);
 	if (vmx->nested.virtual_apic_page) {
 		kvm_release_page_dirty(vmx->nested.virtual_apic_page);
 		vmx->nested.virtual_apic_page = NULL;
-- 
2.7.4
