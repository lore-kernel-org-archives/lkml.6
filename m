Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4974BC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE25221712
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 22:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzlNQTyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE25221712
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeJUGfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 02:35:07 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42388 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeJUGfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 02:35:06 -0400
Received: by mail-wr1-f67.google.com with SMTP id f8-v6so1444901wro.9;
        Sat, 20 Oct 2018 15:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=RUYGp8iLApsFozbBs63aAa+WysaQOIS8JQ7soMZ0ybg=;
        b=FzlNQTyFAh+n2xndBYzicl6a0qGfDux0ntOMWHl6HoW4VOqIvdJKorS+Ff9WTLSyNp
         A37PzjSBNcgoyFk1Wwa1hwsTrHpP81SjnS/N1oYhDZFWHXtiExposhr865UrUdSXW1tG
         f8YsQxoOEzxQEiy3CbKVNSopHpD8vYOFyJvvbjMfQE62NL+mTo8jfLIXwE2j0cAcZ1Pz
         ankLvnueR6HFY164paJr/BU6oifVta5kjef/RdaOezEjw8KY5JsD9/KVaQIvfDPD0QiW
         s1ilklB5+3z1yL/mBd0S9wSMzUY2SKNcTCjB83QNz136nlXJxweB7OYkqYw7PPSS7kek
         we3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=RUYGp8iLApsFozbBs63aAa+WysaQOIS8JQ7soMZ0ybg=;
        b=OB/2icRpWdPtTJ318UGlKyNJtnrc3E44a0UeH4VpMpQjblPHXnBikou60I+CmSKK/1
         rdJSkfg+8oJWdNCtIPJtPhXPKA5xxtOjc86tUU3ltRXkC5cS1uGkMDZXYorLV9fMrQW0
         BqvlZhriY/rzk0oIwQ/xwUsBEnkPE9SB37Xuf4tEv3qgDrGoi9Hl6ZB8KWcNLFVxZaqb
         d1VMPCn39AgAcZ8B/LkSBNGukekbQVDwxC7n6Q887vElgHAWsucsNvqNDOVqKY9GvRwQ
         J4DlXDFclAXR7S1Gbm3mjVJpydMUydF/O5N1yd5D9ykXt44EZQOPPqE20WiOkemf+drz
         ROMQ==
X-Gm-Message-State: AGRZ1gLh68bMGPuN5W94c5MwtcfVfUdPeKoVvKDf5NsbRMiDo5ANRteF
        0GIk1jAd+wgzZEh74PZRFC4=
X-Google-Smtp-Source: AJdET5dZu3NU00RhFhVSX797FS/yBhg/EG9aBPCSbT9zzLLtwaNKyr8ljhUMNlAKOXXLMKeonmfL/Q==
X-Received: by 2002:adf:fe87:: with SMTP id l7-v6mr2818799wrr.164.1540074186379;
        Sat, 20 Oct 2018 15:23:06 -0700 (PDT)
Received: from localhost.localdomain ([156.213.155.51])
        by smtp.gmail.com with ESMTPSA id o81-v6sm5013746wmo.38.2018.10.20.15.23.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Oct 2018 15:23:05 -0700 (PDT)
From:   Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahmedsoliman0x666@gmail.com, Ovich00@gmail.com,
        kernel-hardening@lists.openwall.com, nigel.edwards@hpe.com,
        Boris Lukashev <blukashev@sempervictus.com>,
        Hossam Hassan <7ossam9063@gmail.com>,
        Ahmed Lotfy <A7med.lotfey@gmail.com>
Subject: [PATCH V4 2/5] KVM: X86: Adding arbitrary data pointer in kvm memslot iterator functions
Date:   Sun, 21 Oct 2018 00:21:24 +0200
Message-Id: <20181020222127.6368-3-ahmedsoliman0x666@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181020222127.6368-1-ahmedsoliman0x666@gmail.com>
References: <20181020222127.6368-1-ahmedsoliman0x666@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will help sharing data into the slot_level_handler callback. In my
case I need to a share a counter for the pages traversed to use it in some
bitmap. Being able to send arbitrary memory pointer into the
slot_level_handler callback made it easy.

Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
---
 arch/x86/kvm/mmu.c | 65 ++++++++++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 51b953ad9d4e..cc36abe1ee44 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -1486,7 +1486,7 @@ static bool spte_write_protect(u64 *sptep, bool pt_protect)
 
 static bool __rmap_write_protect(struct kvm *kvm,
 				 struct kvm_rmap_head *rmap_head,
-				 bool pt_protect)
+				 bool pt_protect, void *data)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -1525,7 +1525,8 @@ static bool wrprot_ad_disabled_spte(u64 *sptep)
  *	- W bit on ad-disabled SPTEs.
  * Returns true iff any D or W bits were cleared.
  */
-static bool __rmap_clear_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head)
+static bool __rmap_clear_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+				void *data)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -1551,7 +1552,8 @@ static bool spte_set_dirty(u64 *sptep)
 	return mmu_spte_update(sptep, spte);
 }
 
-static bool __rmap_set_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head)
+static bool __rmap_set_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+				void *data)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -1583,7 +1585,7 @@ static void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
 	while (mask) {
 		rmap_head = __gfn_to_rmap(slot->base_gfn + gfn_offset + __ffs(mask),
 					  PT_PAGE_TABLE_LEVEL, slot);
-		__rmap_write_protect(kvm, rmap_head, false);
+		__rmap_write_protect(kvm, rmap_head, false, NULL);
 
 		/* clear the first set bit */
 		mask &= mask - 1;
@@ -1609,7 +1611,7 @@ void kvm_mmu_clear_dirty_pt_masked(struct kvm *kvm,
 	while (mask) {
 		rmap_head = __gfn_to_rmap(slot->base_gfn + gfn_offset + __ffs(mask),
 					  PT_PAGE_TABLE_LEVEL, slot);
-		__rmap_clear_dirty(kvm, rmap_head);
+		__rmap_clear_dirty(kvm, rmap_head, NULL);
 
 		/* clear the first set bit */
 		mask &= mask - 1;
@@ -1662,7 +1664,8 @@ bool kvm_mmu_slot_gfn_write_protect(struct kvm *kvm,
 
 	for (i = PT_PAGE_TABLE_LEVEL; i <= PT_MAX_HUGEPAGE_LEVEL; ++i) {
 		rmap_head = __gfn_to_rmap(gfn, i, slot);
-		write_protected |= __rmap_write_protect(kvm, rmap_head, true);
+		write_protected |= __rmap_write_protect(kvm, rmap_head, true,
+				NULL);
 	}
 
 	return write_protected;
@@ -1676,7 +1679,8 @@ static bool rmap_write_protect(struct kvm_vcpu *vcpu, u64 gfn)
 	return kvm_mmu_slot_gfn_write_protect(vcpu->kvm, slot, gfn);
 }
 
-static bool kvm_zap_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head)
+static bool kvm_zap_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
+		void *data)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -1696,7 +1700,7 @@ static int kvm_unmap_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
 			   struct kvm_memory_slot *slot, gfn_t gfn, int level,
 			   unsigned long data)
 {
-	return kvm_zap_rmapp(kvm, rmap_head);
+	return kvm_zap_rmapp(kvm, rmap_head, NULL);
 }
 
 static int kvm_set_pte_rmapp(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
@@ -5465,13 +5469,15 @@ void kvm_mmu_uninit_vm(struct kvm *kvm)
 }
 
 /* The return value indicates if tlb flush on all vcpus is needed. */
-typedef bool (*slot_level_handler) (struct kvm *kvm, struct kvm_rmap_head *rmap_head);
+typedef bool (*slot_level_handler) (struct kvm *kvm,
+		struct kvm_rmap_head *rmap_head, void *data);
 
 /* The caller should hold mmu-lock before calling this function. */
 static __always_inline bool
 slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
 			slot_level_handler fn, int start_level, int end_level,
-			gfn_t start_gfn, gfn_t end_gfn, bool lock_flush_tlb)
+			gfn_t start_gfn, gfn_t end_gfn, bool lock_flush_tlb,
+			void *data)
 {
 	struct slot_rmap_walk_iterator iterator;
 	bool flush = false;
@@ -5479,7 +5485,7 @@ slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	for_each_slot_rmap_range(memslot, start_level, end_level, start_gfn,
 			end_gfn, &iterator) {
 		if (iterator.rmap)
-			flush |= fn(kvm, iterator.rmap);
+			flush |= fn(kvm, iterator.rmap, data);
 
 		if (need_resched() || spin_needbreak(&kvm->mmu_lock)) {
 			if (flush && lock_flush_tlb) {
@@ -5501,36 +5507,36 @@ slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
 static __always_inline bool
 slot_handle_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		  slot_level_handler fn, int start_level, int end_level,
-		  bool lock_flush_tlb)
+		  bool lock_flush_tlb, void *data)
 {
 	return slot_handle_level_range(kvm, memslot, fn, start_level,
 			end_level, memslot->base_gfn,
 			memslot->base_gfn + memslot->npages - 1,
-			lock_flush_tlb);
+			lock_flush_tlb, data);
 }
 
 static __always_inline bool
 slot_handle_all_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
-		      slot_level_handler fn, bool lock_flush_tlb)
+		      slot_level_handler fn, bool lock_flush_tlb, void *data)
 {
 	return slot_handle_level(kvm, memslot, fn, PT_PAGE_TABLE_LEVEL,
-				 PT_MAX_HUGEPAGE_LEVEL, lock_flush_tlb);
+				 PT_MAX_HUGEPAGE_LEVEL, lock_flush_tlb, data);
 }
 
 static __always_inline bool
 slot_handle_large_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
-			slot_level_handler fn, bool lock_flush_tlb)
+			slot_level_handler fn, bool lock_flush_tlb, void *data)
 {
 	return slot_handle_level(kvm, memslot, fn, PT_PAGE_TABLE_LEVEL + 1,
-				 PT_MAX_HUGEPAGE_LEVEL, lock_flush_tlb);
+				 PT_MAX_HUGEPAGE_LEVEL, lock_flush_tlb, data);
 }
 
 static __always_inline bool
 slot_handle_leaf(struct kvm *kvm, struct kvm_memory_slot *memslot,
-		 slot_level_handler fn, bool lock_flush_tlb)
+		 slot_level_handler fn, bool lock_flush_tlb, void *data)
 {
 	return slot_handle_level(kvm, memslot, fn, PT_PAGE_TABLE_LEVEL,
-				 PT_PAGE_TABLE_LEVEL, lock_flush_tlb);
+				 PT_PAGE_TABLE_LEVEL, lock_flush_tlb, data);
 }
 
 void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
@@ -5552,7 +5558,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 
 			slot_handle_level_range(kvm, memslot, kvm_zap_rmapp,
 						PT_PAGE_TABLE_LEVEL, PT_MAX_HUGEPAGE_LEVEL,
-						start, end - 1, true);
+						start, end - 1, true, NULL);
 		}
 	}
 
@@ -5560,9 +5566,10 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
 }
 
 static bool slot_rmap_write_protect(struct kvm *kvm,
-				    struct kvm_rmap_head *rmap_head)
+				    struct kvm_rmap_head *rmap_head,
+				    void *data)
 {
-	return __rmap_write_protect(kvm, rmap_head, false);
+	return __rmap_write_protect(kvm, rmap_head, false, data);
 }
 
 void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
@@ -5572,7 +5579,7 @@ void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
 
 	spin_lock(&kvm->mmu_lock);
 	flush = slot_handle_all_level(kvm, memslot, slot_rmap_write_protect,
-				      false);
+				      false, NULL);
 	spin_unlock(&kvm->mmu_lock);
 
 	/*
@@ -5598,7 +5605,8 @@ void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
 }
 
 static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
-					 struct kvm_rmap_head *rmap_head)
+					 struct kvm_rmap_head *rmap_head,
+					 void *data)
 {
 	u64 *sptep;
 	struct rmap_iterator iter;
@@ -5636,7 +5644,7 @@ void kvm_mmu_zap_collapsible_sptes(struct kvm *kvm,
 	/* FIXME: const-ify all uses of struct kvm_memory_slot.  */
 	spin_lock(&kvm->mmu_lock);
 	slot_handle_leaf(kvm, (struct kvm_memory_slot *)memslot,
-			 kvm_mmu_zap_collapsible_spte, true);
+			 kvm_mmu_zap_collapsible_spte, true, NULL);
 	spin_unlock(&kvm->mmu_lock);
 }
 
@@ -5646,7 +5654,7 @@ void kvm_mmu_slot_leaf_clear_dirty(struct kvm *kvm,
 	bool flush;
 
 	spin_lock(&kvm->mmu_lock);
-	flush = slot_handle_leaf(kvm, memslot, __rmap_clear_dirty, false);
+	flush = slot_handle_leaf(kvm, memslot, __rmap_clear_dirty, false, NULL);
 	spin_unlock(&kvm->mmu_lock);
 
 	lockdep_assert_held(&kvm->slots_lock);
@@ -5669,7 +5677,7 @@ void kvm_mmu_slot_largepage_remove_write_access(struct kvm *kvm,
 
 	spin_lock(&kvm->mmu_lock);
 	flush = slot_handle_large_level(kvm, memslot, slot_rmap_write_protect,
-					false);
+					false, NULL);
 	spin_unlock(&kvm->mmu_lock);
 
 	/* see kvm_mmu_slot_remove_write_access */
@@ -5686,7 +5694,8 @@ void kvm_mmu_slot_set_dirty(struct kvm *kvm,
 	bool flush;
 
 	spin_lock(&kvm->mmu_lock);
-	flush = slot_handle_all_level(kvm, memslot, __rmap_set_dirty, false);
+	flush = slot_handle_all_level(kvm, memslot, __rmap_set_dirty, false,
+			NULL);
 	spin_unlock(&kvm->mmu_lock);
 
 	lockdep_assert_held(&kvm->slots_lock);
-- 
2.18.1

