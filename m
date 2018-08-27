Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7611C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64175208D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64175208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbeH0PNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:13:01 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35314 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeH0PMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:12:55 -0400
Received: by mail-ed1-f67.google.com with SMTP id y20-v6so3526501edq.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 04:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w8FkKqoz4arYOPrFAusP9GIOvx2XYTMfGYJsQt6jYP0=;
        b=IwNRCZd+7knz4VZVw59EZUL7VfjI1n2p8EFN3b9i66FDO+mO3OiofedMmvm3gWi44c
         m02uWP/vaa1tjpPCHKeGYirWsTaSEKb4qQnuDtInSX2dwjOSHtWil6grr7P0MEM2bDJe
         8A8j7I5ogiGGNXTJ51wdNhCc5IOcZwGigK5WH7qMkHly1XNsem2Zy+GXCRpDizydvTTW
         UW9KVMYHj0ORVMEEAfiP4h3R5/KWtpwk4Sr2WZplD8bRy+16pYqjGYFqng/Q/+//88/k
         uFWktRvYj6HAmrjRULk0kwCaLShzP547z1xCVWnTWQDYuJ/Au8JLxSDqlsm9NayRiVnA
         VkpQ==
X-Gm-Message-State: APzg51BJE+A/caJ1s0H+DxclKeCJJoJwT5ugGoiSfQ+18TNeo6kfT4b1
        FDwuXqfJTIv2xTo90+D76u0=
X-Google-Smtp-Source: ANB0VdYczqC9Yqxtb1VL1/+NUws5G5DlAbCv50qys7oObdORxml7SUdI60ahxhkBpeh0PbLfjKs3FQ==
X-Received: by 2002:aa7:c358:: with SMTP id j24-v6mr6856960edr.100.1535369198652;
        Mon, 27 Aug 2018 04:26:38 -0700 (PDT)
Received: from tiehlicka.suse.cz (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id v1-v6sm6454416edf.3.2018.08.27.04.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 04:26:38 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
Subject: [PATCH 3/3] Revert "mm, mmu_notifier: annotate mmu notifiers with blockable invalidate callbacks"
Date:   Mon, 27 Aug 2018 13:26:23 +0200
Message-Id: <20180827112623.8992-4-mhocko@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827112623.8992-1-mhocko@kernel.org>
References: <20180827112623.8992-1-mhocko@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

This reverts commit 5ff7091f5a2ca1b7b642ca0dbdede8f693a56926.

MMU_INVALIDATE_DOES_NOT_BLOCK flags was the only one used and it is no
longer needed since 93065ac753e4 ("mm, oom: distinguish blockable mode
for mmu notifiers"). We now have a full support for per range !blocking
behavior so we can drop the stop gap workaround which the per notifier
flag was used for.

Cc: David Rientjes <rientjes@google.com>
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 drivers/infiniband/hw/hfi1/mmu_rb.c |  1 -
 drivers/iommu/amd_iommu_v2.c        |  1 -
 drivers/iommu/intel-svm.c           |  1 -
 drivers/misc/sgi-gru/grutlbpurge.c  |  1 -
 include/linux/mmu_notifier.h        | 23 ---------------------
 mm/mmu_notifier.c                   | 31 -----------------------------
 virt/kvm/kvm_main.c                 |  1 -
 7 files changed, 59 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/mmu_rb.c b/drivers/infiniband/hw/hfi1/mmu_rb.c
index e1c7996c018e..475b769e120c 100644
--- a/drivers/infiniband/hw/hfi1/mmu_rb.c
+++ b/drivers/infiniband/hw/hfi1/mmu_rb.c
@@ -77,7 +77,6 @@ static void do_remove(struct mmu_rb_handler *handler,
 static void handle_remove(struct work_struct *work);
 
 static const struct mmu_notifier_ops mn_opts = {
-	.flags = MMU_INVALIDATE_DOES_NOT_BLOCK,
 	.invalidate_range_start = mmu_notifier_range_start,
 };
 
diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd_iommu_v2.c
index 58da65df03f5..fd552235bd13 100644
--- a/drivers/iommu/amd_iommu_v2.c
+++ b/drivers/iommu/amd_iommu_v2.c
@@ -427,7 +427,6 @@ static void mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
 }
 
 static const struct mmu_notifier_ops iommu_mn = {
-	.flags			= MMU_INVALIDATE_DOES_NOT_BLOCK,
 	.release		= mn_release,
 	.clear_flush_young      = mn_clear_flush_young,
 	.invalidate_range       = mn_invalidate_range,
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
index 7d65aab36a96..e16ee247add8 100644
--- a/drivers/iommu/intel-svm.c
+++ b/drivers/iommu/intel-svm.c
@@ -292,7 +292,6 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 }
 
 static const struct mmu_notifier_ops intel_mmuops = {
-	.flags = MMU_INVALIDATE_DOES_NOT_BLOCK,
 	.release = intel_mm_release,
 	.change_pte = intel_change_pte,
 	.invalidate_range = intel_invalidate_range,
diff --git a/drivers/misc/sgi-gru/grutlbpurge.c b/drivers/misc/sgi-gru/grutlbpurge.c
index be28f05bfafa..03b49d52092e 100644
--- a/drivers/misc/sgi-gru/grutlbpurge.c
+++ b/drivers/misc/sgi-gru/grutlbpurge.c
@@ -261,7 +261,6 @@ static void gru_release(struct mmu_notifier *mn, struct mm_struct *mm)
 
 
 static const struct mmu_notifier_ops gru_mmuops = {
-	.flags			= MMU_INVALIDATE_DOES_NOT_BLOCK,
 	.invalidate_range_start	= gru_invalidate_range_start,
 	.invalidate_range_end	= gru_invalidate_range_end,
 	.release		= gru_release,
diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 698e371aafe3..9893a6432adf 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -2,7 +2,6 @@
 #ifndef _LINUX_MMU_NOTIFIER_H
 #define _LINUX_MMU_NOTIFIER_H
 
-#include <linux/types.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/mm_types.h>
@@ -11,9 +10,6 @@
 struct mmu_notifier;
 struct mmu_notifier_ops;
 
-/* mmu_notifier_ops flags */
-#define MMU_INVALIDATE_DOES_NOT_BLOCK	(0x01)
-
 #ifdef CONFIG_MMU_NOTIFIER
 
 /*
@@ -30,15 +26,6 @@ struct mmu_notifier_mm {
 };
 
 struct mmu_notifier_ops {
-	/*
-	 * Flags to specify behavior of callbacks for this MMU notifier.
-	 * Used to determine which context an operation may be called.
-	 *
-	 * MMU_INVALIDATE_DOES_NOT_BLOCK: invalidate_range_* callbacks do not
-	 *	block
-	 */
-	int flags;
-
 	/*
 	 * Called either by mmu_notifier_unregister or when the mm is
 	 * being destroyed by exit_mmap, always before all pages are
@@ -183,10 +170,6 @@ struct mmu_notifier_ops {
 	 * Note that this function might be called with just a sub-range
 	 * of what was passed to invalidate_range_start()/end(), if
 	 * called between those functions.
-	 *
-	 * If this callback cannot block, and invalidate_range_{start,end}
-	 * cannot block, mmu_notifier_ops.flags should have
-	 * MMU_INVALIDATE_DOES_NOT_BLOCK set.
 	 */
 	void (*invalidate_range)(struct mmu_notifier *mn, struct mm_struct *mm,
 				 unsigned long start, unsigned long end);
@@ -241,7 +224,6 @@ extern void __mmu_notifier_invalidate_range_end(struct mm_struct *mm,
 				  bool only_end);
 extern void __mmu_notifier_invalidate_range(struct mm_struct *mm,
 				  unsigned long start, unsigned long end);
-extern bool mm_has_blockable_invalidate_notifiers(struct mm_struct *mm);
 
 static inline void mmu_notifier_release(struct mm_struct *mm)
 {
@@ -495,11 +477,6 @@ static inline void mmu_notifier_invalidate_range(struct mm_struct *mm,
 {
 }
 
-static inline bool mm_has_blockable_invalidate_notifiers(struct mm_struct *mm)
-{
-	return false;
-}
-
 static inline void mmu_notifier_mm_init(struct mm_struct *mm)
 {
 }
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 82bb1a939c0e..5119ff846769 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -247,37 +247,6 @@ void __mmu_notifier_invalidate_range(struct mm_struct *mm,
 }
 EXPORT_SYMBOL_GPL(__mmu_notifier_invalidate_range);
 
-/*
- * Must be called while holding mm->mmap_sem for either read or write.
- * The result is guaranteed to be valid until mm->mmap_sem is dropped.
- */
-bool mm_has_blockable_invalidate_notifiers(struct mm_struct *mm)
-{
-	struct mmu_notifier *mn;
-	int id;
-	bool ret = false;
-
-	WARN_ON_ONCE(!rwsem_is_locked(&mm->mmap_sem));
-
-	if (!mm_has_notifiers(mm))
-		return ret;
-
-	id = srcu_read_lock(&srcu);
-	hlist_for_each_entry_rcu(mn, &mm->mmu_notifier_mm->list, hlist) {
-		if (!mn->ops->invalidate_range &&
-		    !mn->ops->invalidate_range_start &&
-		    !mn->ops->invalidate_range_end)
-				continue;
-
-		if (!(mn->ops->flags & MMU_INVALIDATE_DOES_NOT_BLOCK)) {
-			ret = true;
-			break;
-		}
-	}
-	srcu_read_unlock(&srcu, id);
-	return ret;
-}
-
 static int do_mmu_notifier_register(struct mmu_notifier *mn,
 				    struct mm_struct *mm,
 				    int take_mmap_sem)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f986e31fa68c..636462edc7ca 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -499,7 +499,6 @@ static void kvm_mmu_notifier_release(struct mmu_notifier *mn,
 }
 
 static const struct mmu_notifier_ops kvm_mmu_notifier_ops = {
-	.flags			= MMU_INVALIDATE_DOES_NOT_BLOCK,
 	.invalidate_range_start	= kvm_mmu_notifier_invalidate_range_start,
 	.invalidate_range_end	= kvm_mmu_notifier_invalidate_range_end,
 	.clear_flush_young	= kvm_mmu_notifier_clear_flush_young,
-- 
2.18.0

