Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D84C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 564F6208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564F6208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbeJAU6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:58:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729651AbeJAU6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:58:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 591E1308FB9A;
        Mon,  1 Oct 2018 14:20:46 +0000 (UTC)
Received: from vitty.brq.redhat.com (ovpn-204-59.brq.redhat.com [10.40.204.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A268F6E41E;
        Mon,  1 Oct 2018 14:20:43 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/9] x86/kvm/mmu: get rid of redundant kvm_mmu_setup()
Date:   Mon,  1 Oct 2018 16:20:06 +0200
Message-Id: <20181001142010.21132-6-vkuznets@redhat.com>
In-Reply-To: <20181001142010.21132-1-vkuznets@redhat.com>
References: <20181001142010.21132-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 01 Oct 2018 14:20:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

Just inline the contents into the sole caller, kvm_init_mmu is now
public.

Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/mmu.c              | 12 ------------
 arch/x86/kvm/x86.c              |  2 +-
 3 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index a3829869353b..a64da200aed1 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1176,7 +1176,6 @@ void kvm_mmu_module_exit(void);
 
 void kvm_mmu_destroy(struct kvm_vcpu *vcpu);
 int kvm_mmu_create(struct kvm_vcpu *vcpu);
-void kvm_mmu_setup(struct kvm_vcpu *vcpu);
 void kvm_mmu_init_vm(struct kvm *kvm);
 void kvm_mmu_uninit_vm(struct kvm *kvm);
 void kvm_mmu_set_mask_ptes(u64 user_mask, u64 accessed_mask,
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index bb6584222848..02bc3d6c27a3 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -5426,18 +5426,6 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
 	return alloc_mmu_pages(vcpu);
 }
 
-void kvm_mmu_setup(struct kvm_vcpu *vcpu)
-{
-	MMU_WARN_ON(VALID_PAGE(vcpu->arch.mmu->root_hpa));
-
-	/*
-	 * kvm_mmu_setup() is called only on vCPU initialization.  
-	 * Therefore, no need to reset mmu roots as they are not yet
-	 * initialized.
-	 */
-	kvm_init_mmu(vcpu, false);
-}
-
 static void kvm_mmu_invalidate_zap_pages_in_memslot(struct kvm *kvm,
 			struct kvm_memory_slot *slot,
 			struct kvm_page_track_notifier_node *node)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d58dc530ed84..b93b1ef8854b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8478,7 +8478,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	kvm_vcpu_mtrr_init(vcpu);
 	vcpu_load(vcpu);
 	kvm_vcpu_reset(vcpu, false);
-	kvm_mmu_setup(vcpu);
+	kvm_init_mmu(vcpu, false);
 	vcpu_put(vcpu);
 	return 0;
 }
-- 
2.17.1

