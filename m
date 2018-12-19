Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BA3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D79420869
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 16:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbeLSQZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 11:25:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbeLSQZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 11:25:17 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AF26F7AEB1;
        Wed, 19 Dec 2018 16:25:17 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24E01171F3;
        Wed, 19 Dec 2018 16:25:15 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] KVM: x86: nSVM: fix switch to guest mmu
Date:   Wed, 19 Dec 2018 17:25:14 +0100
Message-Id: <20181219162514.30453-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 19 Dec 2018 16:25:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent optimizations in MMU code broke nested SVM with NPT in L1
completely: when we do nested_svm_{,un}init_mmu_context() we want
to switch from TDP MMU to shadow MMU, both init_kvm_tdp_mmu() and
kvm_init_shadow_mmu() check if re-configuration is needed by looking
at cache source data. The data, however, doesn't change - it's only
the type of the MMU which changes. We end up not re-initializing
guest MMU as shadow and everything goes off the rails.

The issue could have been fixed by putting MMU type into extended MMU
role but this is not really needed. We can just split root and guest MMUs
the exact same way we did for nVMX, their types never change in the
lifetime of a vCPU.

There is still room for improvement: currently, we reset all MMU roots
when switching from L1 to L2 and back and this is not needed.

Fixes: 7dcd57552008 ("x86/kvm/mmu: check if tdp/shadow MMU reconfiguration is needed")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/svm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index b78c691adea2..38821b0b78da 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -2923,6 +2923,8 @@ static void nested_svm_inject_npf_exit(struct kvm_vcpu *vcpu,
 static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 {
 	WARN_ON(mmu_is_nested(vcpu));
+
+	vcpu->arch.mmu = &vcpu->arch.guest_mmu;
 	kvm_init_shadow_mmu(vcpu);
 	vcpu->arch.mmu->set_cr3           = nested_svm_set_tdp_cr3;
 	vcpu->arch.mmu->get_cr3           = nested_svm_get_tdp_cr3;
@@ -2935,6 +2937,7 @@ static void nested_svm_init_mmu_context(struct kvm_vcpu *vcpu)
 
 static void nested_svm_uninit_mmu_context(struct kvm_vcpu *vcpu)
 {
+	vcpu->arch.mmu = &vcpu->arch.root_mmu;
 	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
 }
 
@@ -3444,7 +3447,6 @@ static void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
 		svm->vcpu.arch.hflags &= ~HF_HIF_MASK;
 
 	if (nested_vmcb->control.nested_ctl & SVM_NESTED_CTL_NP_ENABLE) {
-		kvm_mmu_unload(&svm->vcpu);
 		svm->nested.nested_cr3 = nested_vmcb->control.nested_cr3;
 		nested_svm_init_mmu_context(&svm->vcpu);
 	}
-- 
2.19.2

