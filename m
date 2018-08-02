Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F528C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 350D3214FB
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350D3214FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732163AbeHBLwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:52:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726769AbeHBLwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:52:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 108A581663FE;
        Thu,  2 Aug 2018 10:01:41 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3A29213ED80;
        Thu,  2 Aug 2018 10:01:39 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH 4/9] x86/kvm/mmu: introduce guest_mmu
Date:   Thu,  2 Aug 2018 12:01:27 +0200
Message-Id: <20180802100132.5249-5-vkuznets@redhat.com>
In-Reply-To: <20180802100132.5249-1-vkuznets@redhat.com>
References: <20180802100132.5249-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 02 Aug 2018 10:01:41 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 02 Aug 2018 10:01:41 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
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
 arch/x86/include/asm/kvm_host.h |  3 +++
 arch/x86/kvm/mmu.c              | 15 +++++++++++----
 arch/x86/kvm/vmx.c              | 27 +++++++++++++++++++--------
 3 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7b157cd43e1f..932c3285739f 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -538,6 +538,9 @@ struct kvm_vcpu_arch {
 	/* Non-nested MMU for L1 */
 	struct kvm_mmu root_mmu;
 
+	/* L1 MMU when running nested */
+	struct kvm_mmu guest_mmu;
+
 	/*
 	 * Paging state of an L2 guest (used for nested npt)
 	 *
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 1bcab6f9d1c8..3e3c351b5c61 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4937,8 +4937,10 @@ EXPORT_SYMBOL_GPL(kvm_mmu_load);
 
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
 
@@ -5365,13 +5367,18 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
 
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
index 80cf941a3080..494148818b8d 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -8175,8 +8175,10 @@ static inline void nested_release_vmcs12(struct vcpu_vmx *vmx)
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
 
@@ -8209,6 +8211,8 @@ static void free_nested(struct vcpu_vmx *vmx)
 		vmx->nested.pi_desc = NULL;
 	}
 
+	kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
+
 	free_loaded_vmcs(&vmx->nested.vmcs02);
 }
 
@@ -8217,7 +8221,7 @@ static int handle_vmoff(struct kvm_vcpu *vcpu)
 {
 	if (!nested_vmx_check_permission(vcpu))
 		return 1;
-	free_nested(to_vmx(vcpu));
+	free_nested(vcpu);
 	nested_vmx_succeed(vcpu);
 	return kvm_skip_emulated_instruction(vcpu);
 }
@@ -8248,6 +8252,8 @@ static int handle_vmclear(struct kvm_vcpu *vcpu)
 	if (vmptr == vmx->nested.current_vmptr)
 		nested_release_vmcs12(vmx);
 
+	kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu, KVM_MMU_ROOTS_ALL);
+
 	kvm_vcpu_write_guest(vcpu,
 			vmptr + offsetof(struct vmcs12, launch_state),
 			&zero, sizeof(zero));
@@ -8631,6 +8637,9 @@ static int handle_vmptrld(struct kvm_vcpu *vcpu)
 		}
 
 		nested_release_vmcs12(vmx);
+
+		kvm_mmu_free_roots(vcpu, &vcpu->arch.guest_mmu,
+				   KVM_MMU_ROOTS_ALL);
 		/*
 		 * Load VMCS12 from guest memory since it is not already
 		 * cached.
@@ -10576,12 +10585,12 @@ static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
  */
 static void vmx_free_vcpu_nested(struct kvm_vcpu *vcpu)
 {
-       struct vcpu_vmx *vmx = to_vmx(vcpu);
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
-       vcpu_load(vcpu);
-       vmx_switch_vmcs(vcpu, &vmx->vmcs01);
-       free_nested(vmx);
-       vcpu_put(vcpu);
+	vcpu_load(vcpu);
+	vmx_switch_vmcs(vcpu, &vmx->vmcs01);
+	free_nested(vcpu);
+	vcpu_put(vcpu);
 }
 
 static void vmx_free_vcpu(struct kvm_vcpu *vcpu)
@@ -10907,6 +10916,7 @@ static int nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 	if (!valid_ept_address(vcpu, nested_ept_get_cr3(vcpu)))
 		return 1;
 
+	vcpu->arch.mmu = &vcpu->arch.guest_mmu;
 	kvm_init_shadow_ept_mmu(vcpu,
 			to_vmx(vcpu)->nested.msrs.ept_caps &
 			VMX_EPT_EXECUTE_ONLY_BIT,
@@ -10922,6 +10932,7 @@ static int nested_ept_init_mmu_context(struct kvm_vcpu *vcpu)
 
 static void nested_ept_uninit_mmu_context(struct kvm_vcpu *vcpu)
 {
+	vcpu->arch.mmu = &vcpu->arch.root_mmu;
 	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
 }
 
@@ -12960,7 +12971,7 @@ static void vmx_leave_nested(struct kvm_vcpu *vcpu)
 		to_vmx(vcpu)->nested.nested_run_pending = 0;
 		nested_vmx_vmexit(vcpu, -1, 0, 0);
 	}
-	free_nested(to_vmx(vcpu));
+	free_nested(vcpu);
 }
 
 /*
-- 
2.14.4

