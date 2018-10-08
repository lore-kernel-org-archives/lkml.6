Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B80FC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012612089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012612089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbeJICl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:41:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbeJICl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:41:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 85EC9307D910;
        Mon,  8 Oct 2018 19:28:37 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.205.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 113D161B6E;
        Mon,  8 Oct 2018 19:28:34 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/9] x86/kvm/mmu: introduce guest_mmu
Date:   Mon,  8 Oct 2018 21:28:08 +0200
Message-Id: <20181008192813.30624-5-vkuznets@redhat.com>
In-Reply-To: <20181008192813.30624-1-vkuznets@redhat.com>
References: <20181008192813.30624-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 08 Oct 2018 19:28:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When EPT is used for nested guest we need to re-init MMU as shadow
EPT MMU (nested_ept_init_mmu_context() does that). When we return back
from L2 to L1 kvm_mmu_reset_context() in nested_vmx_load_cr3() resets
MMU back to normal TDP mode. Add a special 'guest_mmu' so we can use
separate root caches; the improved hit rate is not very important for
single vCPU performance, but it avoids contention on the mmu_lock for
many vCPUs.

On the nested CPUID benchmark, with 16 vCPUs, an L2->L1->L2 vmexit
goes from 42k to 26k cycles.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
Changes since v3:
- Drop stale role initializer in kvm_calc_shadow_ept_root_page_role()
  [Sean Christopherson]
---
 arch/x86/include/asm/kvm_host.h |  3 +++
 arch/x86/kvm/mmu.c              | 20 ++++++++++++++-----
 arch/x86/kvm/vmx.c              | 35 +++++++++++++++++++++------------
 3 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index ee5ce6b39b20..f2a39222f9dc 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -548,6 +548,9 @@ struct kvm_vcpu_arch {
 	/* Non-nested MMU for L1 */
 	struct kvm_mmu root_mmu;
 
+	/* L1 MMU when running nested */
+	struct kvm_mmu guest_mmu;
+
 	/*
 	 * Paging state of an L2 guest (used for nested npt)
 	 *
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 96c753746b3b..bf9e3145ff0b 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4832,7 +4832,10 @@ EXPORT_SYMBOL_GPL(kvm_init_shadow_mmu);
 static union kvm_mmu_page_role
 kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty)
 {
-	union kvm_mmu_page_role role = vcpu->arch.mmu->base_role;
+	union kvm_mmu_page_role role;
+
+	/* Role is inherited from root_mmu */
+	role.word = vcpu->arch.root_mmu.base_role.word;
 
 	role.level = PT64_ROOT_4LEVEL;
 	role.direct = false;
@@ -4982,8 +4985,10 @@ EXPORT_SYMBOL_GPL(kvm_mmu_load);
 
 void kvm_mmu_unload(struct kvm_vcpu *vcpu)
 {
-	kvm_mmu_free_roots(vcpu, vcpu->arch.mmu, KVM_MMU_ROOTS_ALL);
-	WARN_ON(VALID_PAGE(vcpu->arch.mmu->root_hpa));
+	kvm_mmu_free_roots(vcpu, &vcpu->arch.root_mmu, KVM_MMU_ROOTS_ALL);
+	WARN_ON(VALID_PAGE(vcpu->arch.root_mmu.root_hpa));
+	kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
+	WARN_ON(VALID_PAGE(vcpu->arch.guest_mmu.root_hpa));
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_unload);
 
@@ -5422,13 +5427,18 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.mmu = &vcpu->arch.root_mmu;
 	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
+
 	vcpu->arch.root_mmu.root_hpa = INVALID_PAGE;
 	vcpu->arch.root_mmu.translate_gpa = translate_gpa;
-	vcpu->arch.nested_mmu.translate_gpa = translate_nested_gpa;
-
 	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
 		vcpu->arch.root_mmu.prev_roots[i] = KVM_MMU_ROOT_INFO_INVALID;
 
+	vcpu->arch.guest_mmu.root_hpa = INVALID_PAGE;
+	vcpu->arch.guest_mmu.translate_gpa = translate_gpa;
+	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
+		vcpu->arch.guest_mmu.prev_roots[i] = KVM_MMU_ROOT_INFO_INVALID;
+
+	vcpu->arch.nested_mmu.translate_gpa = translate_nested_gpa;
 	return alloc_mmu_pages(vcpu);
 }
 
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 5c32b6f18f2a..cedb223f79c2 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8424,8 +8424,10 @@ static void vmx_disable_shadow_vmcs(struct vcpu_vmx *vmx)
 	vmcs_write64(VMCS_LINK_POINTER, -1ull);
 }
 
-static inline void nested_release_vmcs12(struct vcpu_vmx *vmx)
+static inline void nested_release_vmcs12(struct kvm_vcpu *vcpu)
 {
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+
 	if (vmx->nested.current_vmptr == -1ull)
 		return;
 
@@ -8439,10 +8441,12 @@ static inline void nested_release_vmcs12(struct vcpu_vmx *vmx)
 	vmx->nested.posted_intr_nv = -1;
 
 	/* Flush VMCS12 to guest memory */
-	kvm_vcpu_write_guest_page(&vmx->vcpu,
+	kvm_vcpu_write_guest_page(vcpu,
 				  vmx->nested.current_vmptr >> PAGE_SHIFT,
 				  vmx->nested.cached_vmcs12, 0, VMCS12_SIZE);
 
+	kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
+
 	vmx->nested.current_vmptr = -1ull;
 }
 
@@ -8450,8 +8454,10 @@ static inline void nested_release_vmcs12(struct vcpu_vmx *vmx)
  * Free whatever needs to be freed from vmx->nested when L1 goes down, or
  * just stops using VMX.
  */
-static void free_nested(struct vcpu_vmx *vmx)
+static void free_nested(struct kvm_vcpu *vcpu)
 {
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+
 	if (!vmx->nested.vmxon && !vmx->nested.smm.vmxon)
 		return;
 
@@ -8484,6 +8490,8 @@ static void free_nested(struct vcpu_vmx *vmx)
 		vmx->nested.pi_desc = NULL;
 	}
 
+	kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
+
 	free_loaded_vmcs(&vmx->nested.vmcs02);
 }
 
@@ -8492,7 +8500,7 @@ static int handle_vmoff(struct kvm_vcpu *vcpu)
 {
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
-	free_nested(to_vmx(vcpu));
+	free_nested(vcpu);
 	return nested_vmx_succeed(vcpu);
 }
 
@@ -8518,7 +8526,7 @@ static int handle_vmclear(struct kvm_vcpu *vcpu)
 			VMXERR_VMCLEAR_VMXON_POINTER);
 
 	if (vmptr == vmx->nested.current_vmptr)
-		nested_release_vmcs12(vmx);
+		nested_release_vmcs12(vcpu);
 
 	kvm_vcpu_write_guest(vcpu,
 			vmptr + offsetof(struct vmcs12, launch_state),
@@ -8873,7 +8881,8 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 				VMXERR_VMPTRLD_INCORRECT_VMCS_REVISION_ID);
 		}
 
-		nested_release_vmcs12(vmx);
+		nested_release_vmcs12(vcpu);
+
 		/*
 		 * Load VMCS12 from guest memory since it is not already
 		 * cached.
@@ -10922,12 +10931,10 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
  */
 static void vmx_free_vcpu_nested(struct kvm_vcpu *vcpu)
 {
-       struct vcpu_vmx *vmx = to_vmx(vcpu);
-
-       vcpu_load(vcpu);
-       vmx_switch_vmcs(vcpu, &vmx->vmcs01);
-       free_nested(vmx);
-       vcpu_put(vcpu);
+	vcpu_load(vcpu);
+	vmx_switch_vmcs(vcpu, &to_vmx(vcpu)->vmcs01);
+	free_nested(vcpu);
+	vcpu_put(vcpu);
 }
 
 static void vmx_free_vcpu(struct kvm_vcpu *vcpu)
@@ -11294,6 +11301,7 @@ static void nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 {
 	WARN_ON(mmu_is_nested(vcpu));
 
+	vcpu->arch.mmu = &vcpu->arch.guest_mmu;
 	kvm_init_shadow_ept_mmu(vcpu,
 			to_vmx(vcpu)->nested.msrs.ept_caps &
 			VMX_EPT_EXECUTE_ONLY_BIT,
@@ -11309,6 +11317,7 @@ static void nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 
 static void nested_ept_uninit_mmu_context(struct kvm_vcpu *vcpu)
 {
+	vcpu->arch.mmu = &vcpu->arch.root_mmu;
 	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
 }
 
@@ -13712,7 +13721,7 @@ static void vmx_leave_nested(struct kvm_vcpu *vcpu)
 		to_vmx(vcpu)->nested.nested_run_pending = 0;
 		nested_vmx_vmexit(vcpu, -1, 0, 0);
 	}
-	free_nested(to_vmx(vcpu));
+	free_nested(vcpu);
 }
 
 static int vmx_check_intercept(struct kvm_vcpu *vcpu,
-- 
2.17.1

