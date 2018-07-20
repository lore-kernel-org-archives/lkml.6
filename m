Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C31ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E0A20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E0A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbeGTOO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:14:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731848AbeGTOOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:14:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AEF4B81663E5;
        Fri, 20 Jul 2018 13:26:37 +0000 (UTC)
Received: from vitty.brq.redhat.com (ovpn-204-189.brq.redhat.com [10.40.204.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DE7A2026D69;
        Fri, 20 Jul 2018 13:26:36 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 5/7] x86/kvm/mmu: get rid of redundant kvm_mmu_setup()
Date:   Fri, 20 Jul 2018 15:26:24 +0200
Message-Id: <20180720132626.5975-6-vkuznets@redhat.com>
In-Reply-To: <20180720132626.5975-1-vkuznets@redhat.com>
References: <20180720132626.5975-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 20 Jul 2018 13:26:37 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 20 Jul 2018 13:26:37 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm_mmu_setup() is used only once in kvm_arch_vcpu_setup() and
kvm_mmu_reset_context() is good enough: we have no root to free so the end
result is not any different. init_kvm_mmu() can now be dropped too.

This is a preparatory change to optimizing kvm_mmu_reset_context().

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/mmu.c              | 17 +++--------------
 arch/x86/kvm/x86.c              |  2 +-
 3 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3d0d26142619..2c0b493e09f7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1128,7 +1128,6 @@ void kvm_mmu_module_exit(void);
 
 void kvm_mmu_destroy(struct kvm_vcpu *vcpu);
 int kvm_mmu_create(struct kvm_vcpu *vcpu);
-void kvm_mmu_setup(struct kvm_vcpu *vcpu);
 void kvm_mmu_init_vm(struct kvm *kvm);
 void kvm_mmu_uninit_vm(struct kvm *kvm);
 void kvm_mmu_set_mask_ptes(u64 user_mask, u64 accessed_mask,
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 76849eda1a5b..fb6652643b15 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -4633,8 +4633,10 @@ static void init_kvm_nested_mmu(struct kvm_vcpu *vcpu)
 	update_last_nonleaf_level(vcpu, g_context);
 }
 
-static void init_kvm_mmu(struct kvm_vcpu *vcpu)
+void kvm_mmu_reset_context(struct kvm_vcpu *vcpu)
 {
+	kvm_mmu_unload(vcpu);
+
 	if (mmu_is_nested(vcpu))
 		init_kvm_nested_mmu(vcpu);
 	else if (tdp_enabled)
@@ -4642,12 +4644,6 @@ static void init_kvm_mmu(struct kvm_vcpu *vcpu)
 	else
 		init_kvm_softmmu(vcpu);
 }
-
-void kvm_mmu_reset_context(struct kvm_vcpu *vcpu)
-{
-	kvm_mmu_unload(vcpu);
-	init_kvm_mmu(vcpu);
-}
 EXPORT_SYMBOL_GPL(kvm_mmu_reset_context);
 
 int kvm_mmu_load(struct kvm_vcpu *vcpu)
@@ -5062,13 +5058,6 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
 	return alloc_mmu_pages(vcpu);
 }
 
-void kvm_mmu_setup(struct kvm_vcpu *vcpu)
-{
-	MMU_WARN_ON(VALID_PAGE(vcpu->arch.mmu->root_hpa));
-
-	init_kvm_mmu(vcpu);
-}
-
 static void kvm_mmu_invalidate_zap_pages_in_memslot(struct kvm *kvm,
 			struct kvm_memory_slot *slot,
 			struct kvm_page_track_notifier_node *node)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a98fafd6ac24..5510a7f50195 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8333,7 +8333,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	kvm_vcpu_mtrr_init(vcpu);
 	vcpu_load(vcpu);
 	kvm_vcpu_reset(vcpu, false);
-	kvm_mmu_setup(vcpu);
+	kvm_mmu_reset_context(vcpu);
 	vcpu_put(vcpu);
 	return 0;
 }
-- 
2.14.4

