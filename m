Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C7FC5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA3921470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA3921470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeJQAlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:41:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727272AbeJQAlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:41:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 470543082DCF;
        Tue, 16 Oct 2018 16:50:29 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC809608EE;
        Tue, 16 Oct 2018 16:50:26 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH v6 05/13] KVM: nVMX: implement enlightened VMPTRLD and VMCLEAR
Date:   Tue, 16 Oct 2018 18:50:03 +0200
Message-Id: <20181016165011.6607-6-vkuznets@redhat.com>
In-Reply-To: <20181016165011.6607-1-vkuznets@redhat.com>
References: <20181016165011.6607-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 16 Oct 2018 16:50:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per Hyper-V TLFS 5.0b:

"The L1 hypervisor may choose to use enlightened VMCSs by writing 1 to
the corresponding field in the VP assist page (see section 7.8.7).
Another field in the VP assist page controls the currently active
enlightened VMCS. Each enlightened VMCS is exactly one page (4 KB) in
size and must be initially zeroed. No VMPTRLD instruction must be
executed to make an enlightened VMCS active or current.

After the L1 hypervisor performs a VM entry with an enlightened VMCS,
the VMCS is considered active on the processor. An enlightened VMCS
can only be active on a single processor at the same time. The L1
hypervisor can execute a VMCLEAR instruction to transition an
enlightened VMCS from the active to the non-active state. Any VMREAD
or VMWRITE instructions while an enlightened VMCS is active is
unsupported and can result in unexpected behavior."

Keep Enlightened VMCS structure for the current L2 guest permanently mapped
from struct nested_vmx instead of mapping it every time.

Suggested-by: Ladi Prosek <lprosek@redhat.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx.c | 115 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 108 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index aebd008ccccb..cfb44acd4291 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -20,6 +20,7 @@
 #include "mmu.h"
 #include "cpuid.h"
 #include "lapic.h"
+#include "hyperv.h"
 
 #include <linux/kvm_host.h>
 #include <linux/module.h>
@@ -889,6 +890,8 @@ struct nested_vmx {
 		bool guest_mode;
 	} smm;
 
+	gpa_t hv_evmcs_vmptr;
+	struct page *hv_evmcs_page;
 	struct hv_enlightened_vmcs *hv_evmcs;
 };
 
@@ -8111,11 +8114,13 @@ static int nested_vmx_failInvalid(struct kvm_vcpu *vcpu)
 static int nested_vmx_failValid(struct kvm_vcpu *vcpu,
 				u32 vm_instruction_error)
 {
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+
 	/*
 	 * failValid writes the error number to the current VMCS, which
 	 * can't be done if there isn't a current VMCS.
 	 */
-	if (to_vmx(vcpu)->nested.current_vmptr == -1ull)
+	if (vmx->nested.current_vmptr == -1ull && !vmx->nested.hv_evmcs)
 		return nested_vmx_failInvalid(vcpu);
 
 	vmx_set_rflags(vcpu, (vmx_get_rflags(vcpu)
@@ -8441,6 +8446,20 @@ static void vmx_disable_shadow_vmcs(struct vcpu_vmx *vmx)
 	vmcs_write64(VMCS_LINK_POINTER, -1ull);
 }
 
+static inline void nested_release_evmcs(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+
+	if (!vmx->nested.hv_evmcs)
+		return;
+
+	kunmap(vmx->nested.hv_evmcs_page);
+	kvm_release_page_dirty(vmx->nested.hv_evmcs_page);
+	vmx->nested.hv_evmcs_vmptr = -1ull;
+	vmx->nested.hv_evmcs_page = NULL;
+	vmx->nested.hv_evmcs = NULL;
+}
+
 static inline void nested_release_vmcs12(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
@@ -8509,6 +8528,8 @@ static void free_nested(struct kvm_vcpu *vcpu)
 
 	kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
 
+	nested_release_evmcs(vcpu);
+
 	free_loaded_vmcs(&vmx->nested.vmcs02);
 }
 
@@ -8542,12 +8563,18 @@ static int handle_vmclear(struct kvm_vcpu *vcpu)
 		return nested_vmx_failValid(vcpu,
 			VMXERR_VMCLEAR_VMXON_POINTER);
 
-	if (vmptr == vmx->nested.current_vmptr)
-		nested_release_vmcs12(vcpu);
+	if (vmx->nested.hv_evmcs_page) {
+		if (vmptr == vmx->nested.hv_evmcs_vmptr)
+			nested_release_evmcs(vcpu);
+	} else {
+		if (vmptr == vmx->nested.current_vmptr)
+			nested_release_vmcs12(vcpu);
 
-	kvm_vcpu_write_guest(vcpu,
-			vmptr + offsetof(struct vmcs12, launch_state),
-			&zero, sizeof(zero));
+		kvm_vcpu_write_guest(vcpu,
+				     vmptr + offsetof(struct vmcs12,
+						      launch_state),
+				     &zero, sizeof(zero));
+	}
 
 	return nested_vmx_succeed(vcpu);
 }
@@ -8637,6 +8664,8 @@ static int copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx)
 	struct vmcs12 *vmcs12 = vmx->nested.cached_vmcs12;
 	struct hv_enlightened_vmcs *evmcs = vmx->nested.hv_evmcs;
 
+	vmcs12->hdr.revision_id = evmcs->revision_id;
+
 	/* HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE */
 	vmcs12->tpr_threshold = evmcs->tpr_threshold;
 	vmcs12->guest_rip = evmcs->guest_rip;
@@ -9268,6 +9297,10 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 		return nested_vmx_failValid(vcpu,
 			VMXERR_VMPTRLD_VMXON_POINTER);
 
+	/* Forbid normal VMPTRLD if Enlightened version was used */
+	if (vmx->nested.hv_evmcs)
+		return 1;
+
 	if (vmx->nested.current_vmptr != vmptr) {
 		struct vmcs12 *new_vmcs12;
 		struct page *page;
@@ -9301,6 +9334,68 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 	return nested_vmx_succeed(vcpu);
 }
 
+/*
+ * This is an equivalent of the nested hypervisor executing the vmptrld
+ * instruction.
+ */
+static int nested_vmx_handle_enlightened_vmptrld(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct hv_vp_assist_page assist_page;
+
+	if (likely(!vmx->nested.enlightened_vmcs_enabled))
+		return 1;
+
+	if (unlikely(!kvm_hv_get_assist_page(vcpu, &assist_page)))
+		return 1;
+
+	if (unlikely(!assist_page.enlighten_vmentry))
+		return 1;
+
+	if (unlikely(assist_page.current_nested_vmcs !=
+		     vmx->nested.hv_evmcs_vmptr)) {
+
+		if (!vmx->nested.hv_evmcs)
+			vmx->nested.current_vmptr = -1ull;
+
+		nested_release_evmcs(vcpu);
+
+		vmx->nested.hv_evmcs_page = kvm_vcpu_gpa_to_page(
+			vcpu, assist_page.current_nested_vmcs);
+
+		if (unlikely(is_error_page(vmx->nested.hv_evmcs_page)))
+			return 0;
+
+		vmx->nested.hv_evmcs = kmap(vmx->nested.hv_evmcs_page);
+
+		if (vmx->nested.hv_evmcs->revision_id != VMCS12_REVISION) {
+			nested_release_evmcs(vcpu);
+			return 0;
+		}
+
+		vmx->nested.dirty_vmcs12 = true;
+		/*
+		 * As we keep L2 state for one guest only 'hv_clean_fields' mask
+		 * can't be used when we switch between them. Reset it here for
+		 * simplicity.
+		 */
+		vmx->nested.hv_evmcs->hv_clean_fields &=
+			~HV_VMX_ENLIGHTENED_CLEAN_FIELD_ALL;
+		vmx->nested.hv_evmcs_vmptr = assist_page.current_nested_vmcs;
+
+		/*
+		 * Unlike normal vmcs12, enlightened vmcs12 is not fully
+		 * reloaded from guest's memory (read only fields, fields not
+		 * present in struct hv_enlightened_vmcs, ...). Make sure there
+		 * are no leftovers.
+		 */
+		memset(vmx->nested.cached_vmcs12, 0,
+		       sizeof(*vmx->nested.cached_vmcs12));
+
+	}
+	return 1;
+}
+
 /* Emulate the VMPTRST instruction */
 static int handle_vmptrst(struct kvm_vcpu *vcpu)
 {
@@ -9313,6 +9408,9 @@ static int handle_vmptrst(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
+	if (unlikely(to_vmx(vcpu)->nested.hv_evmcs))
+		return 1;
+
 	if (get_vmx_mem_address(vcpu, exit_qual, instr_info, true, &gva))
 		return 1;
 	/* *_system ok, nested_vmx_check_permission has verified cpl=0 */
@@ -13314,7 +13412,10 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	if (vmx->nested.current_vmptr == -1ull)
+	if (!nested_vmx_handle_enlightened_vmptrld(vcpu))
+		return 1;
+
+	if (!vmx->nested.hv_evmcs && vmx->nested.current_vmptr == -1ull)
 		return nested_vmx_failInvalid(vcpu);
 
 	vmcs12 = get_vmcs12(vcpu);
-- 
2.17.1

