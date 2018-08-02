Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E3CC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79AA621501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 10:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79AA621501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732280AbeHBLwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 07:52:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732126AbeHBLwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 07:52:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C6B381663F6;
        Thu,  2 Aug 2018 10:01:42 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B36B213ED6A;
        Thu,  2 Aug 2018 10:01:41 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: [PATCH 5/9] x86/kvm/mmu: get rid of redundant kvm_mmu_setup()
Date:   Thu,  2 Aug 2018 12:01:28 +0200
Message-Id: <20180802100132.5249-6-vkuznets@redhat.com>
In-Reply-To: <20180802100132.5249-1-vkuznets@redhat.com>
References: <20180802100132.5249-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 02 Aug 2018 10:01:42 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 02 Aug 2018 10:01:42 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

Just inline the contents into the sole caller, kvm_init_mmu is now
public.

Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_host.h | 1 -
 arch/x86/kvm/mmu.c              | 7 -------
 arch/x86/kvm/x86.c              | 2 +-
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 932c3285739f..c5f116f9783d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1167,7 +1167,6 @@ void kvm_mmu_module_exit(void);
 
 void kvm_mmu_destroy(struct kvm_vcpu *vcpu);
 int kvm_mmu_create(struct kvm_vcpu *vcpu);
-void kvm_mmu_setup(struct kvm_vcpu *vcpu);
 void kvm_mmu_init_vm(struct kvm *kvm);
 void kvm_mmu_uninit_vm(struct kvm *kvm);
 void kvm_mmu_set_mask_ptes(u64 user_mask, u64 accessed_mask,
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 3e3c351b5c61..85ec027299d6 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -5382,13 +5382,6 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
 	return alloc_mmu_pages(vcpu);
 }
 
-void kvm_mmu_setup(struct kvm_vcpu *vcpu)
-{
-	MMU_WARN_ON(VALID_PAGE(vcpu->arch.mmu->root_hpa));
-
-	kvm_init_mmu(vcpu, true);
-}
-
 static void kvm_mmu_invalidate_zap_pages_in_memslot(struct kvm *kvm,
 			struct kvm_memory_slot *slot,
 			struct kvm_page_track_notifier_node *node)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b49091a55865..5b53237148c8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8398,7 +8398,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	kvm_vcpu_mtrr_init(vcpu);
 	vcpu_load(vcpu);
 	kvm_vcpu_reset(vcpu, false);
-	kvm_mmu_setup(vcpu);
+	kvm_init_mmu(vcpu, true);
 	vcpu_put(vcpu);
 	return 0;
 }
-- 
2.14.4

