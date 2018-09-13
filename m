Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18B1ECDFCD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970C42177A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970C42177A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbeIMWQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 18:16:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728342AbeIMWQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 18:16:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 358AB80F9C;
        Thu, 13 Sep 2018 17:05:40 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0822608E0;
        Thu, 13 Sep 2018 17:05:37 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 05/12] KVM: nVMX: implement enlightened VMPTRLD and VMCLEAR
Date:   Thu, 13 Sep 2018 19:05:15 +0200
Message-Id: <20180913170522.24876-6-vkuznets@redhat.com>
In-Reply-To: <20180913170522.24876-1-vkuznets@redhat.com>
References: <20180913170522.24876-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 13 Sep 2018 17:05:40 +0000 (UTC)
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
 arch/x86/kvm/vmx.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 106 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index cb0e18d3a111..993f48154087 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -20,6 +20,7 @@
 #include "mmu.h"
 #include "cpuid.h"
 #include "lapic.h"
+#include "hyperv.h"
 
 #include <linux/kvm_host.h>
 #include <linux/module.h>
@@ -877,6 +878,8 @@ struct nested_vmx {
 		bool guest_mode;
 	} smm;
 
+	gpa_t hv_evmcs_vmptr;
+	struct page *hv_evmcs_page;
 	struct hv_enlightened_vmcs *hv_evmcs;
 };
 
@@ -8099,7 +8102,9 @@ static void nested_vmx_failInvalid(struct kvm_vcpu *vcpu)
 static void nested_vmx_failValid(struct kvm_vcpu *vcpu,
 					u32 vm_instruction_error)
 {
-	if (to_vmx(vcpu)->nested.current_vmptr == -1ull) {
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+
+	if (vmx->nested.current_vmptr == -1ull && !vmx->nested.hv_evmcs) {
 		/*
 		 * failValid writes the error number to the current VMCS, which
 		 * can't be done there isn't a current VMCS.
@@ -8434,6 +8439,18 @@ static void vmx_disable_shadow_vmcs(struct vcpu_vmx *vmx)
 	vmcs_write64(VMCS_LINK_POINTER, -1ull);
 }
 
+static inline void nested_release_evmcs(struct vcpu_vmx *vmx)
+{
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
 static inline void nested_release_vmcs12(struct vcpu_vmx *vmx)
 {
 	if (vmx->nested.current_vmptr == -1ull)
@@ -8494,6 +8511,8 @@ static void free_nested(struct vcpu_vmx *vmx)
 		vmx->nested.pi_desc = NULL;
 	}
 
+	nested_release_evmcs(vmx);
+
 	free_loaded_vmcs(&vmx->nested.vmcs02);
 }
 
@@ -8530,12 +8549,18 @@ static int handle_vmclear(struct kvm_vcpu *vcpu)
 		return kvm_skip_emulated_instruction(vcpu);
 	}
 
-	if (vmptr == vmx->nested.current_vmptr)
-		nested_release_vmcs12(vmx);
+	if (vmx->nested.hv_evmcs_page) {
+		if (vmptr == vmx->nested.hv_evmcs_vmptr)
+			nested_release_evmcs(vmx);
+	} else {
+		if (vmptr == vmx->nested.current_vmptr)
+			nested_release_vmcs12(vmx);
 
-	kvm_vcpu_write_guest(vcpu,
-			vmptr + offsetof(struct vmcs12, launch_state),
-			&zero, sizeof(zero));
+		kvm_vcpu_write_guest(vcpu,
+				     vmptr + offsetof(struct vmcs12,
+						      launch_state),
+				     &zero, sizeof(zero));
+	}
 
 	nested_vmx_succeed(vcpu);
 	return kvm_skip_emulated_instruction(vcpu);
@@ -8626,6 +8651,8 @@ static int copy_enlightened_to_vmcs12(struct vcpu_vmx *vmx)
 	struct vmcs12 *vmcs12 = vmx->nested.cached_vmcs12;
 	struct hv_enlightened_vmcs *evmcs = vmx->nested.hv_evmcs;
 
+	vmcs12->hdr.revision_id = evmcs->revision_id;
+
 	/* HV_VMX_ENLIGHTENED_CLEAN_FIELD_NONE */
 	vmcs12->tpr_threshold = evmcs->tpr_threshold;
 	vmcs12->guest_rip = evmcs->guest_rip;
@@ -9283,6 +9310,10 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 		return kvm_skip_emulated_instruction(vcpu);
 	}
 
+	/* Forbid normal VMPTRLD if Enlightened version was used */
+	if (vmx->nested.hv_evmcs)
+		return 1;
+
 	if (vmx->nested.current_vmptr != vmptr) {
 		struct vmcs12 *new_vmcs12;
 		struct page *page;
@@ -9318,6 +9349,68 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 	return kvm_skip_emulated_instruction(vcpu);
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
+		nested_release_evmcs(vmx);
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
+			nested_release_evmcs(vmx);
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
@@ -9330,6 +9423,9 @@ static int handle_vmptrst(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
+	if (unlikely(to_vmx(vcpu)->nested.hv_evmcs))
+		return 1;
+
 	if (get_vmx_mem_address(vcpu, exit_qual, instr_info, true, &gva))
 		return 1;
 	/* *_system ok, nested_vmx_check_permission has verified cpl=0 */
@@ -13044,7 +13140,10 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
-	if (!nested_vmx_check_vmcs12(vcpu))
+	if (!nested_vmx_handle_enlightened_vmptrld(vcpu))
+		return 1;
+
+	if (!vmx->nested.hv_evmcs && !nested_vmx_check_vmcs12(vcpu))
 		goto out;
 
 	vmcs12 = get_vmcs12(vcpu);
-- 
2.14.4

