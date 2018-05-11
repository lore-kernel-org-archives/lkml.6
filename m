Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753281AbeEKNif (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 09:38:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752977AbeEKNiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 09:38:03 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Subject: [PATCH RFC v2 4/5] KVM: nVMX: implement enlightened VMPTRLD and VMCLEAR
Date: Fri, 11 May 2018 15:37:50 +0200
Message-Id: <20180511133751.13414-5-vkuznets@redhat.com>
In-Reply-To: <20180511133751.13414-1-vkuznets@redhat.com>
References: <20180511133751.13414-1-vkuznets@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
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
 arch/x86/kvm/vmx.c | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 91 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 9d41b2ffcef5..c74374f74ea7 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -20,6 +20,7 @@
 #include "mmu.h"
 #include "cpuid.h"
 #include "lapic.h"
+#include "hyperv.h"
 
 #include <linux/kvm_host.h>
 #include <linux/module.h>
@@ -530,6 +531,8 @@ struct nested_vmx {
 		bool guest_mode;
 	} smm;
 
+	gpa_t hv_evmcs_vmptr;
+	struct page *hv_evmcs_page;
 	struct hv_enlightened_vmcs *hv_evmcs;
 };
 
@@ -7460,7 +7463,9 @@ static void nested_vmx_failInvalid(struct kvm_vcpu *vcpu)
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
@@ -7758,6 +7763,18 @@ static void vmx_disable_shadow_vmcs(struct vcpu_vmx *vmx)
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
@@ -7817,6 +7834,8 @@ static void free_nested(struct vcpu_vmx *vmx)
 		vmx->nested.pi_desc = NULL;
 	}
 
+	nested_release_evmcs(vmx);
+
 	free_loaded_vmcs(&vmx->nested.vmcs02);
 }
 
@@ -7853,12 +7872,18 @@ static int handle_vmclear(struct kvm_vcpu *vcpu)
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
@@ -8545,6 +8570,10 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 		return kvm_skip_emulated_instruction(vcpu);
 	}
 
+	/* Forbid normal VMPTRLD if Enlightened version was used */
+	if (vmx->nested.hv_evmcs)
+		return 1;
+
 	if (vmx->nested.current_vmptr != vmptr) {
 		struct vmcs12 *new_vmcs12;
 		struct page *page;
@@ -8578,6 +8607,55 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
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
+		vmx->nested.dirty_vmcs12 = true;
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
@@ -8589,6 +8667,9 @@ static int handle_vmptrst(struct kvm_vcpu *vcpu)
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
 
+	if (unlikely(to_vmx(vcpu)->nested.hv_evmcs))
+		return 1;
+
 	if (get_vmx_mem_address(vcpu, exit_qualification,
 			vmx_instruction_info, true, &vmcs_gva))
 		return 1;
@@ -11887,7 +11968,10 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
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
2.14.3
