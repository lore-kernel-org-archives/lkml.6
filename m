Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753945AbeBESvd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:51:33 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:15450 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753657AbeBESr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:47:58 -0500
X-IronPort-AV: E=Sophos;i="5.46,465,1511827200";
   d="scan'208";a="706879261"
From: KarimAllah Ahmed <karahmed@amazon.de>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: KarimAllah Ahmed <karahmed@amazon.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [RFC 04/12] KVM/VMX: Use the new host mapping API for pi_desc_page
Date: Mon,  5 Feb 2018 19:47:23 +0100
Message-Id: <1517856451-2932-5-git-send-email-karahmed@amazon.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
References: <1517856451-2932-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For nested guests the pi_desc_page was mapped to the host kernel using
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
 arch/x86/kvm/vmx.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 6bd0c45..40d73f4 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -453,7 +453,7 @@ struct nested_vmx {
 	 */
 	struct kvm_host_mapping apic_access_mapping;
 	struct kvm_host_mapping virtual_apic_mapping;
-	struct page *pi_desc_page;
+	struct kvm_host_mapping pi_desc_mapping;
 	struct pi_desc *pi_desc;
 	bool pi_pending;
 	u16 posted_intr_nv;
@@ -7501,12 +7501,11 @@ static void free_nested(struct vcpu_vmx *vmx)
 	/* Unpin physical memory we referred to in the vmcs02 */
 	if (vmx->nested.apic_access_mapping.pfn)
 		kvm_release_host_mapping(&vmx->nested.apic_access_mapping, true);
+
 	if (vmx->nested.virtual_apic_mapping.pfn)
 		kvm_release_host_mapping(&vmx->nested.virtual_apic_mapping, true);
-	if (vmx->nested.pi_desc_page) {
-		kunmap(vmx->nested.pi_desc_page);
-		kvm_release_page_dirty(vmx->nested.pi_desc_page);
-		vmx->nested.pi_desc_page = NULL;
+	if (vmx->nested.pi_desc_mapping.pfn) {
+		kvm_release_host_mapping(&vmx->nested.pi_desc_mapping, true);
 		vmx->nested.pi_desc = NULL;
 	}
 
@@ -10041,7 +10040,6 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu,
 					struct vmcs12 *vmcs12)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-	struct page *page;
 
 	if (nested_cpu_has2(vmcs12, SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES)) {
 		/*
@@ -10097,24 +10095,22 @@ static void nested_get_vmcs12_pages(struct kvm_vcpu *vcpu,
 	}
 
 	if (nested_cpu_has_posted_intr(vmcs12)) {
-		if (vmx->nested.pi_desc_page) { /* shouldn't happen */
-			kunmap(vmx->nested.pi_desc_page);
-			kvm_release_page_dirty(vmx->nested.pi_desc_page);
-			vmx->nested.pi_desc_page = NULL;
-		}
-		page = kvm_vcpu_gpa_to_page(vcpu, vmcs12->posted_intr_desc_addr);
-		if (is_error_page(page))
+		if (vmx->nested.pi_desc_mapping.pfn) /* shouldn't happen */
+			kvm_release_host_mapping(&vmx->nested.pi_desc_mapping, true);
+
+		if (!kvm_vcpu_gpa_to_host_mapping(vcpu, vmcs12->posted_intr_desc_addr,
+						  &vmx->nested.pi_desc_mapping, true))
 			return;
-		vmx->nested.pi_desc_page = page;
-		vmx->nested.pi_desc = kmap(vmx->nested.pi_desc_page);
+
+		vmx->nested.pi_desc = vmx->nested.pi_desc_mapping.kaddr;
 		vmx->nested.pi_desc =
 			(struct pi_desc *)((void *)vmx->nested.pi_desc +
 			(unsigned long)(vmcs12->posted_intr_desc_addr &
 			(PAGE_SIZE - 1)));
 		vmcs_write64(POSTED_INTR_DESC_ADDR,
-			page_to_phys(vmx->nested.pi_desc_page) +
-			(unsigned long)(vmcs12->posted_intr_desc_addr &
-			(PAGE_SIZE - 1)));
+			     (vmx->nested.pi_desc_mapping.pfn << PAGE_SHIFT) +
+			     (unsigned long)(vmcs12->posted_intr_desc_addr &
+					     (PAGE_SIZE - 1)));
 	}
 	if (cpu_has_vmx_msr_bitmap() &&
 	    nested_cpu_has(vmcs12, CPU_BASED_USE_MSR_BITMAPS) &&
@@ -11675,12 +11671,12 @@ static void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
 	/* Unpin physical memory we referred to in vmcs02 */
 	if (vmx->nested.apic_access_mapping.pfn)
 		kvm_release_host_mapping(&vmx->nested.apic_access_mapping, true);
+
 	if (vmx->nested.virtual_apic_mapping.pfn)
 		kvm_release_host_mapping(&vmx->nested.virtual_apic_mapping, true);
-	if (vmx->nested.pi_desc_page) {
-		kunmap(vmx->nested.pi_desc_page);
-		kvm_release_page_dirty(vmx->nested.pi_desc_page);
-		vmx->nested.pi_desc_page = NULL;
+
+	if (vmx->nested.pi_desc_mapping.pfn) {
+		kvm_release_host_mapping(&vmx->nested.pi_desc_mapping, true);
 		vmx->nested.pi_desc = NULL;
 	}
 
-- 
2.7.4
