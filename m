Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085E3ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFEC020652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 13:27:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFEC020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732127AbeGTOPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 10:15:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730825AbeGTOOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 10:14:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7A1A37263D;
        Fri, 20 Jul 2018 13:26:34 +0000 (UTC)
Received: from vitty.brq.redhat.com (ovpn-204-189.brq.redhat.com [10.40.204.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B7DB2026D6B;
        Fri, 20 Jul 2018 13:26:33 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 3/7] x86/kvm/mmu.c: add kvm_mmu parameter to kvm_mmu_free_roots()
Date:   Fri, 20 Jul 2018 15:26:22 +0200
Message-Id: <20180720132626.5975-4-vkuznets@redhat.com>
In-Reply-To: <20180720132626.5975-1-vkuznets@redhat.com>
References: <20180720132626.5975-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 20 Jul 2018 13:26:34 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 20 Jul 2018 13:26:34 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an option to specify which MMU root we want to free. This will
be used when nested and non-nested MMUs for L1 are split.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 2 +-
 arch/x86/kvm/mmu.c              | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 2aa3c43ca5e5..d819947d0a97 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1282,7 +1282,7 @@ void __kvm_mmu_free_some_pages(struct kvm_vcpu *vcpu);
 int kvm_mmu_load(struct kvm_vcpu *vcpu);
 void kvm_mmu_unload(struct kvm_vcpu *vcpu);
 void kvm_mmu_sync_roots(struct kvm_vcpu *vcpu);
-void kvm_mmu_free_roots(struct kvm_vcpu *vcpu);
+void kvm_mmu_free_roots(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu);
 gpa_t translate_nested_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u32 access,
 			   struct x86_exception *exception);
 gpa_t kvm_mmu_gva_to_gpa_read(struct kvm_vcpu *vcpu, gva_t gva,
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 10598dd396ed..8c5e5664d830 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -3358,11 +3358,10 @@ static void mmu_free_root_page(struct kvm *kvm, hpa_t *root_hpa,
 	*root_hpa = INVALID_PAGE;
 }
 
-void kvm_mmu_free_roots(struct kvm_vcpu *vcpu)
+void kvm_mmu_free_roots(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu)
 {
 	int i;
 	LIST_HEAD(invalid_list);
-	struct kvm_mmu *mmu = vcpu->arch.mmu;
 
 	if (!VALID_PAGE(mmu->root_hpa))
 		return;
@@ -3954,7 +3953,7 @@ static void nonpaging_init_context(struct kvm_vcpu *vcpu,
 
 void kvm_mmu_new_cr3(struct kvm_vcpu *vcpu)
 {
-	kvm_mmu_free_roots(vcpu);
+	kvm_mmu_free_roots(vcpu, vcpu->arch.mmu);
 }
 
 static unsigned long get_cr3(struct kvm_vcpu *vcpu)
@@ -4671,7 +4670,7 @@ EXPORT_SYMBOL_GPL(kvm_mmu_load);
 
 void kvm_mmu_unload(struct kvm_vcpu *vcpu)
 {
-	kvm_mmu_free_roots(vcpu);
+	kvm_mmu_free_roots(vcpu, vcpu->arch.mmu);
 	WARN_ON(VALID_PAGE(vcpu->arch.mmu->root_hpa));
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_unload);
-- 
2.14.4

