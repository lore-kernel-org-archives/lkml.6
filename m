Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08FEC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C56A2089D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C56A2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeIZAIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:08:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbeIZAIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:08:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A3663307D927;
        Tue, 25 Sep 2018 17:59:25 +0000 (UTC)
Received: from vitty.brq.redhat.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 09B2860BE1;
        Tue, 25 Sep 2018 17:59:22 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/9] x86/kvm/mmu: introduce guest_mmu
Date:   Tue, 25 Sep 2018 19:58:39 +0200
Message-Id: <20180925175844.20277-5-vkuznets@redhat.com>
In-Reply-To: <20180925175844.20277-1-vkuznets@redhat.com>
References: <20180925175844.20277-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 25 Sep 2018 17:59:25 +0000 (UTC)
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
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
Changes since v1:
- drop now unneded local vmx variable in vmx_free_vcpu_nested
  [Sean Christopherson]
---
 arch/x86/include/asm/kvm_host.h |  3 +++
 arch/x86/kvm/mmu.c              | 15 +++++++++++----
 arch/x86/kvm/vmx.c              | 27 ++++++++++++++++++---------
 3 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 404c3438827b..a3829869353b 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -539,6 +539,9 @@ struct kvm_vcpu_arch {
 	/* Non-nested MMU for L1 */
 	struct kvm_mmu root_mmu;
 
+	/* L1 MMU when running nested */
+	struct kvm_mmu guest_mmu;
+
 	/*
 	 * Paging state of an L2 guest (used for nested npt)
 	 *
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 4491b8894337..96c2a0b3eb53 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4967,8 +4967,10 @@ EXPORT_SYMBOL_GPL(kvm_mmu_load);
 
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
 
@@ -5407,13 +5409,18 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
 
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
index 2d55adab52de..93ff08136fc1 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8468,8 +8468,10 @@ static inline void nested_release_vmcs12(struct vcpu_vmx *vmx)
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
 
@@ -8502,6 +8504,8 @@ static void free_nested(struct vcpu_vmx *vmx)
 		vmx->nested.pi_desc = NULL;
 	}
 
+	kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
+
 	free_loaded_vmcs(&vmx->nested.vmcs02);
 }
 
@@ -8510,7 +8514,7 @@ static int handle_vmoff(struct kvm_vcpu *vcpu)
 {
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
-	free_nested(to_vmx(vcpu));
+	free_nested(vcpu);
 	nested_vmx_succeed(vcpu);
 	return kvm_skip_emulated_instruction(vcpu);
 }
@@ -8541,6 +8545,8 @@ static int handle_vmclear(struct kvm_vcpu *vcpu)
 	if (vmptr == vmx->nested.current_vmptr)
 		nested_release_vmcs12(vmx);
 
+	kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
+
 	kvm_vcpu_write_guest(vcpu,
 			vmptr + offsetof(struct vmcs12, launch_state),
 			&zero, sizeof(zero));
@@ -8924,6 +8930,9 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 		}
 
 		nested_release_vmcs12(vmx);
+
+		kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu,
+				   KVM_MMU_ROOTS_ALL);
 		/*
 		 * Load VMCS12 from guest memory since it is not already
 		 * cached.
@@ -10976,12 +10985,10 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
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
@@ -11331,6 +11338,7 @@ static int nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 	if (!valid_ept_address(vcpu, nested_ept_get_cr3(vcpu)))
 		return 1;
 
+	vcpu->arch.mmu = &vcpu->arch.guest_mmu;
 	kvm_init_shadow_ept_mmu(vcpu,
 			to_vmx(vcpu)->nested.msrs.ept_caps &
 			VMX_EPT_EXECUTE_ONLY_BIT,
@@ -11346,6 +11354,7 @@ static int nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 
 static void nested_ept_uninit_mmu_context(struct kvm_vcpu *vcpu)
 {
+	vcpu->arch.mmu = &vcpu->arch.root_mmu;
 	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
 }
 
@@ -13421,7 +13430,7 @@ static void vmx_leave_nested(struct kvm_vcpu *vcpu)
 		to_vmx(vcpu)->nested.nested_run_pending = 0;
 		nested_vmx_vmexit(vcpu, -1, 0, 0);
 	}
-	free_nested(to_vmx(vcpu));
+	free_nested(vcpu);
 }
 
 /*
-- 
2.17.1

