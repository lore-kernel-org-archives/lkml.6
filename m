Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60920C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2806420652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130755;
	bh=vPg17l6FBmAs2ROLVdoI0TkycoN9hpcaPX6XTB9+thk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qYIz5ZCMHLRfxNcxk/TQ+ugctyOT5wQK5z2S89mQDtyhLS6OVBFC5S+wP/0uIcO+e
	 zWHRofHGr1IhcVFkBXeu/AJkuRakbC0mEcyHUtBaJ1XPQ5WoGrq2iSYM18/EGSnQ+R
	 WR9rlEcqjcIWnSjpOLcG1qumIKRgSDS85Ush4OII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733150AbfBYVgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:36:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:42932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731602AbfBYVgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:36:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B580F217F5;
        Mon, 25 Feb 2019 21:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130574;
        bh=vPg17l6FBmAs2ROLVdoI0TkycoN9hpcaPX6XTB9+thk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i0nrCIlT+vgu2Yl5moSbN7G3TGug4YIR2a/ShPnjpFTCO/aQZvfG4sgy+pdlgozA6
         6TwpoOmktz3ehEfUFsXCvmAn5P7znUPk12yqjDj6EX6M/xkG28LMWX/oNI1fCQv2mG
         e7QXamTmV7tWuj1kE9tKHqKHxOUgXInRTaKk0qyw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.20 164/183] x86/kvm/mmu: fix switch between root and guest MMUs
Date:   Mon, 25 Feb 2019 22:12:17 +0100
Message-Id: <20190225195122.732254000@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaly Kuznetsov <vkuznets@redhat.com>

commit ad7dc69aeb23138cc23c406cac25003b97e8ee17 upstream.

Commit 14c07ad89f4d ("x86/kvm/mmu: introduce guest_mmu") brought one subtle
change: previously, when switching back from L2 to L1, we were resetting
MMU hooks (like mmu->get_cr3()) in kvm_init_mmu() called from
nested_vmx_load_cr3() and now we do that in nested_ept_uninit_mmu_context()
when we re-target vcpu->arch.mmu pointer.
The change itself looks logical: if nested_ept_init_mmu_context() changes
something than nested_ept_uninit_mmu_context() restores it back. There is,
however, one thing: the following call chain:

 nested_vmx_load_cr3()
  kvm_mmu_new_cr3()
    __kvm_mmu_new_cr3()
      fast_cr3_switch()
        cached_root_available()

now happens with MMU hooks pointing to the new MMU (root MMU in our case)
while previously it was happening with the old one. cached_root_available()
tries to stash current root but it is incorrect to read current CR3 with
mmu->get_cr3(), we need to use old_mmu->get_cr3() which in case we're
switching from L2 to L1 is guest_mmu. (BTW, in shadow page tables case this
is a non-issue because we don't switch MMU).

While we could've tried to guess that we're switching between MMUs and call
the right ->get_cr3() from cached_root_available() this seems to be overly
complicated. Instead, just stash the corresponding CR3 when setting
root_hpa and make cached_root_available() use the stashed value.

Fixes: 14c07ad89f4d ("x86/kvm/mmu: introduce guest_mmu")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/kvm_host.h |    1 +
 arch/x86/kvm/mmu.c              |   17 +++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -398,6 +398,7 @@ struct kvm_mmu {
 	void (*update_pte)(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp,
 			   u64 *spte, const void *pte);
 	hpa_t root_hpa;
+	gpa_t root_cr3;
 	union kvm_mmu_role mmu_role;
 	u8 root_level;
 	u8 shadow_root_level;
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3517,6 +3517,7 @@ void kvm_mmu_free_roots(struct kvm_vcpu
 							   &invalid_list);
 			mmu->root_hpa = INVALID_PAGE;
 		}
+		mmu->root_cr3 = 0;
 	}
 
 	kvm_mmu_commit_zap_page(vcpu->kvm, &invalid_list);
@@ -3572,6 +3573,7 @@ static int mmu_alloc_direct_roots(struct
 		vcpu->arch.mmu->root_hpa = __pa(vcpu->arch.mmu->pae_root);
 	} else
 		BUG();
+	vcpu->arch.mmu->root_cr3 = vcpu->arch.mmu->get_cr3(vcpu);
 
 	return 0;
 }
@@ -3580,10 +3582,11 @@ static int mmu_alloc_shadow_roots(struct
 {
 	struct kvm_mmu_page *sp;
 	u64 pdptr, pm_mask;
-	gfn_t root_gfn;
+	gfn_t root_gfn, root_cr3;
 	int i;
 
-	root_gfn = vcpu->arch.mmu->get_cr3(vcpu) >> PAGE_SHIFT;
+	root_cr3 = vcpu->arch.mmu->get_cr3(vcpu);
+	root_gfn = root_cr3 >> PAGE_SHIFT;
 
 	if (mmu_check_root(vcpu, root_gfn))
 		return 1;
@@ -3608,7 +3611,7 @@ static int mmu_alloc_shadow_roots(struct
 		++sp->root_count;
 		spin_unlock(&vcpu->kvm->mmu_lock);
 		vcpu->arch.mmu->root_hpa = root;
-		return 0;
+		goto set_root_cr3;
 	}
 
 	/*
@@ -3674,6 +3677,9 @@ static int mmu_alloc_shadow_roots(struct
 		vcpu->arch.mmu->root_hpa = __pa(vcpu->arch.mmu->lm_root);
 	}
 
+set_root_cr3:
+	vcpu->arch.mmu->root_cr3 = root_cr3;
+
 	return 0;
 }
 
@@ -4125,7 +4131,7 @@ static bool cached_root_available(struct
 	struct kvm_mmu_root_info root;
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
 
-	root.cr3 = mmu->get_cr3(vcpu);
+	root.cr3 = mmu->root_cr3;
 	root.hpa = mmu->root_hpa;
 
 	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++) {
@@ -4138,6 +4144,7 @@ static bool cached_root_available(struct
 	}
 
 	mmu->root_hpa = root.hpa;
+	mmu->root_cr3 = root.cr3;
 
 	return i < KVM_MMU_NUM_PREV_ROOTS;
 }
@@ -5478,11 +5485,13 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu
 	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
 
 	vcpu->arch.root_mmu.root_hpa = INVALID_PAGE;
+	vcpu->arch.root_mmu.root_cr3 = 0;
 	vcpu->arch.root_mmu.translate_gpa = translate_gpa;
 	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
 		vcpu->arch.root_mmu.prev_roots[i] = KVM_MMU_ROOT_INFO_INVALID;
 
 	vcpu->arch.guest_mmu.root_hpa = INVALID_PAGE;
+	vcpu->arch.guest_mmu.root_cr3 = 0;
 	vcpu->arch.guest_mmu.translate_gpa = translate_gpa;
 	for (i = 0; i < KVM_MMU_NUM_PREV_ROOTS; i++)
 		vcpu->arch.guest_mmu.prev_roots[i] = KVM_MMU_ROOT_INFO_INVALID;


