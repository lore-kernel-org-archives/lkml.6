Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0346CC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA9C0223C8
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2H/2mqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9C0223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389412AbeKPRcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 12:32:01 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46598 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727410AbeKPRcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 12:32:00 -0500
Received: by mail-pf1-f193.google.com with SMTP id s9-v6so10953593pfm.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 23:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KEJhNU83vzrdLqiqiakB9mWmCMsYQKVWHLjRLYVJA54=;
        b=O2H/2mqBHmFBu/nyRHwG6+vs0kL/sWAXk0itLscSqBlqL98QBbrVh024ECteTO2uUA
         7A7heZL3eQGAU4S55raC0KIUm8kYOzXfhINxQFoSqrt4e50Umyak0siBRetD1K8rhZQV
         btzy3iMrTPOuxrAV4Iiw29BFFBDKhTejXssg1+DPxPbtCxk8RFCqzuUc/FGpYeKjmpYS
         6oUpZG+5jovl2XscCHV4R0lIZu5BX5l260oz7Rhp3NmX75VTQaR5zvVGwaXOFvEptMli
         tEFPrl8lyOPCda3WEE54v4yqimFKXTflTTvQwdqxk+CUeYvAKarCEEU4PjJA1RE367MU
         2/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KEJhNU83vzrdLqiqiakB9mWmCMsYQKVWHLjRLYVJA54=;
        b=MnmztF3Rb40gCg1ZVl6pynxcEwTUGmvVY9/nqJgFLbJRtx0tz16pyWr5Pg0wwHrCFI
         Jec2F6TBXv62rUggQTgvR2s/l4k8RQVbiF1B0SibaFvXPa3uN9rGzVZKQdP310DZo7bd
         /CA4TEKfA/uLdPS9DPu3mZbDcJXqu5iiQRRbPskziGN5YhhOs4DIqRkjCkuP6k151JZg
         I4TT9h6kPQ5r6N6xp7sNQB/DVeX/Cvm63HQCvEJskdpllHR26KU5bzIvsUrWfYz4QyyJ
         VOk8NbnmuWhsizsGxLOuWCys2sv86imJFhoMI47H23+YRemD9QWWrFR3CZRb0u3yKZ7f
         F5Ug==
X-Gm-Message-State: AGRZ1gJdKUrpu3HmTBER8Hm40ylYDuuX+sra2WG8bFgJxxjJYnXGNZrx
        kUS5M2+uB30ItwIbKEObkHMQycRoWOo=
X-Google-Smtp-Source: AJdET5c4FCxFVn1aOzPaHAziQMjltyikI9nV80Nwy91kXxRcy6z+NoXFsCuD4yoMw7eh8nRja5t+Gw==
X-Received: by 2002:a62:65c3:: with SMTP id z186-v6mr10089836pfb.206.1542352848317;
        Thu, 15 Nov 2018 23:20:48 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:7630:de9:f6f2:276f])
        by smtp.gmail.com with ESMTPSA id e9sm13974637pff.5.2018.11.15.23.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 23:20:47 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH 2/6] zram: refactoring flags and writeback stuff
Date:   Fri, 16 Nov 2018 16:20:31 +0900
Message-Id: <20181116072035.155108-3-minchan@kernel.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <20181116072035.155108-1-minchan@kernel.org>
References: <20181116072035.155108-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does renaming some variables and restructuring
some codes for better redability in writeback and zs_free_page.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 105 +++++++++++++---------------------
 drivers/block/zram/zram_drv.h |   8 +--
 2 files changed, 44 insertions(+), 69 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 472027eaed60..bc59db2b1036 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -55,17 +55,17 @@ static void zram_free_page(struct zram *zram, size_t index);
 
 static int zram_slot_trylock(struct zram *zram, u32 index)
 {
-	return bit_spin_trylock(ZRAM_LOCK, &zram->table[index].value);
+	return bit_spin_trylock(ZRAM_LOCK, &zram->table[index].flags);
 }
 
 static void zram_slot_lock(struct zram *zram, u32 index)
 {
-	bit_spin_lock(ZRAM_LOCK, &zram->table[index].value);
+	bit_spin_lock(ZRAM_LOCK, &zram->table[index].flags);
 }
 
 static void zram_slot_unlock(struct zram *zram, u32 index)
 {
-	bit_spin_unlock(ZRAM_LOCK, &zram->table[index].value);
+	bit_spin_unlock(ZRAM_LOCK, &zram->table[index].flags);
 }
 
 static inline bool init_done(struct zram *zram)
@@ -76,7 +76,7 @@ static inline bool init_done(struct zram *zram)
 static inline bool zram_allocated(struct zram *zram, u32 index)
 {
 
-	return (zram->table[index].value >> (ZRAM_FLAG_SHIFT + 1)) ||
+	return (zram->table[index].flags >> (ZRAM_FLAG_SHIFT + 1)) ||
 					zram->table[index].handle;
 }
 
@@ -99,19 +99,19 @@ static void zram_set_handle(struct zram *zram, u32 index, unsigned long handle)
 static bool zram_test_flag(struct zram *zram, u32 index,
 			enum zram_pageflags flag)
 {
-	return zram->table[index].value & BIT(flag);
+	return zram->table[index].flags & BIT(flag);
 }
 
 static void zram_set_flag(struct zram *zram, u32 index,
 			enum zram_pageflags flag)
 {
-	zram->table[index].value |= BIT(flag);
+	zram->table[index].flags |= BIT(flag);
 }
 
 static void zram_clear_flag(struct zram *zram, u32 index,
 			enum zram_pageflags flag)
 {
-	zram->table[index].value &= ~BIT(flag);
+	zram->table[index].flags &= ~BIT(flag);
 }
 
 static inline void zram_set_element(struct zram *zram, u32 index,
@@ -127,15 +127,15 @@ static unsigned long zram_get_element(struct zram *zram, u32 index)
 
 static size_t zram_get_obj_size(struct zram *zram, u32 index)
 {
-	return zram->table[index].value & (BIT(ZRAM_FLAG_SHIFT) - 1);
+	return zram->table[index].flags & (BIT(ZRAM_FLAG_SHIFT) - 1);
 }
 
 static void zram_set_obj_size(struct zram *zram,
 					u32 index, size_t size)
 {
-	unsigned long flags = zram->table[index].value >> ZRAM_FLAG_SHIFT;
+	unsigned long flags = zram->table[index].flags >> ZRAM_FLAG_SHIFT;
 
-	zram->table[index].value = (flags << ZRAM_FLAG_SHIFT) | size;
+	zram->table[index].flags = (flags << ZRAM_FLAG_SHIFT) | size;
 }
 
 #if PAGE_SIZE != 4096
@@ -282,16 +282,11 @@ static ssize_t mem_used_max_store(struct device *dev,
 }
 
 #ifdef CONFIG_ZRAM_WRITEBACK
-static bool zram_wb_enabled(struct zram *zram)
-{
-	return zram->backing_dev;
-}
-
 static void reset_bdev(struct zram *zram)
 {
 	struct block_device *bdev;
 
-	if (!zram_wb_enabled(zram))
+	if (!zram->backing_dev)
 		return;
 
 	bdev = zram->bdev;
@@ -318,7 +313,7 @@ static ssize_t backing_dev_show(struct device *dev,
 	ssize_t ret;
 
 	down_read(&zram->init_lock);
-	if (!zram_wb_enabled(zram)) {
+	if (!zram->backing_dev) {
 		memcpy(buf, "none\n", 5);
 		up_read(&zram->init_lock);
 		return 5;
@@ -446,7 +441,7 @@ static ssize_t backing_dev_store(struct device *dev,
 	return err;
 }
 
-static unsigned long get_entry_bdev(struct zram *zram)
+static unsigned long alloc_block_bdev(struct zram *zram)
 {
 	unsigned long blk_idx;
 	unsigned long ret = 0;
@@ -479,13 +474,13 @@ static unsigned long get_entry_bdev(struct zram *zram)
 	return ret;
 }
 
-static void put_entry_bdev(struct zram *zram, unsigned long entry)
+static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
 {
 	int was_set;
 	unsigned long flags;
 
 	spin_lock_irqsave(&zram->bitmap_lock, flags);
-	was_set = test_and_clear_bit(entry, zram->bitmap);
+	was_set = test_and_clear_bit(blk_idx, zram->bitmap);
 	spin_unlock_irqrestore(&zram->bitmap_lock, flags);
 	WARN_ON_ONCE(!was_set);
 }
@@ -599,7 +594,7 @@ static int write_to_bdev(struct zram *zram, struct bio_vec *bvec,
 	if (!bio)
 		return -ENOMEM;
 
-	entry = get_entry_bdev(zram);
+	entry = alloc_block_bdev(zram);
 	if (!entry) {
 		bio_put(bio);
 		return -ENOSPC;
@@ -610,7 +605,7 @@ static int write_to_bdev(struct zram *zram, struct bio_vec *bvec,
 	if (!bio_add_page(bio, bvec->bv_page, bvec->bv_len,
 					bvec->bv_offset)) {
 		bio_put(bio);
-		put_entry_bdev(zram, entry);
+		free_block_bdev(zram, entry);
 		return -EIO;
 	}
 
@@ -628,18 +623,7 @@ static int write_to_bdev(struct zram *zram, struct bio_vec *bvec,
 	return 0;
 }
 
-static void zram_wb_clear(struct zram *zram, u32 index)
-{
-	unsigned long entry;
-
-	zram_clear_flag(zram, index, ZRAM_WB);
-	entry = zram_get_element(zram, index);
-	zram_set_element(zram, index, 0);
-	put_entry_bdev(zram, entry);
-}
-
 #else
-static bool zram_wb_enabled(struct zram *zram) { return false; }
 static inline void reset_bdev(struct zram *zram) {};
 static int write_to_bdev(struct zram *zram, struct bio_vec *bvec,
 					u32 index, struct bio *parent,
@@ -654,7 +638,8 @@ static int read_from_bdev(struct zram *zram, struct bio_vec *bvec,
 {
 	return -EIO;
 }
-static void zram_wb_clear(struct zram *zram, u32 index) {}
+
+static void free_block_bdev(struct zram *zram, unsigned long blk_idx) {};
 #endif
 
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
@@ -676,11 +661,6 @@ static void zram_accessed(struct zram *zram, u32 index)
 	zram->table[index].ac_time = ktime_get_boottime();
 }
 
-static void zram_reset_access(struct zram *zram, u32 index)
-{
-	zram->table[index].ac_time = 0;
-}
-
 static ssize_t read_block_state(struct file *file, char __user *buf,
 				size_t count, loff_t *ppos)
 {
@@ -761,7 +741,6 @@ static void zram_debugfs_unregister(struct zram *zram)
 static void zram_debugfs_create(void) {};
 static void zram_debugfs_destroy(void) {};
 static void zram_accessed(struct zram *zram, u32 index) {};
-static void zram_reset_access(struct zram *zram, u32 index) {};
 static void zram_debugfs_register(struct zram *zram) {};
 static void zram_debugfs_unregister(struct zram *zram) {};
 #endif
@@ -962,17 +941,18 @@ static void zram_free_page(struct zram *zram, size_t index)
 {
 	unsigned long handle;
 
-	zram_reset_access(zram, index);
-
+#ifdef CONFIG_ZRAM_MEMORY_TRACKING
+	zram->table[index].ac_time = 0;
+#endif
 	if (zram_test_flag(zram, index, ZRAM_HUGE)) {
 		zram_clear_flag(zram, index, ZRAM_HUGE);
 		atomic64_dec(&zram->stats.huge_pages);
 	}
 
-	if (zram_wb_enabled(zram) && zram_test_flag(zram, index, ZRAM_WB)) {
-		zram_wb_clear(zram, index);
-		atomic64_dec(&zram->stats.pages_stored);
-		return;
+	if (zram_test_flag(zram, index, ZRAM_WB)) {
+		zram_clear_flag(zram, index, ZRAM_WB);
+		free_block_bdev(zram, zram_get_element(zram, index));
+		goto out;
 	}
 
 	/*
@@ -981,10 +961,8 @@ static void zram_free_page(struct zram *zram, size_t index)
 	 */
 	if (zram_test_flag(zram, index, ZRAM_SAME)) {
 		zram_clear_flag(zram, index, ZRAM_SAME);
-		zram_set_element(zram, index, 0);
 		atomic64_dec(&zram->stats.same_pages);
-		atomic64_dec(&zram->stats.pages_stored);
-		return;
+		goto out;
 	}
 
 	handle = zram_get_handle(zram, index);
@@ -995,10 +973,11 @@ static void zram_free_page(struct zram *zram, size_t index)
 
 	atomic64_sub(zram_get_obj_size(zram, index),
 			&zram->stats.compr_data_size);
+out:
 	atomic64_dec(&zram->stats.pages_stored);
-
 	zram_set_handle(zram, index, 0);
 	zram_set_obj_size(zram, index, 0);
+	WARN_ON_ONCE(zram->table[index].flags & ~(1UL << ZRAM_LOCK));
 }
 
 static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
@@ -1009,24 +988,20 @@ static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
 	unsigned int size;
 	void *src, *dst;
 
-	if (zram_wb_enabled(zram)) {
-		zram_slot_lock(zram, index);
-		if (zram_test_flag(zram, index, ZRAM_WB)) {
-			struct bio_vec bvec;
-
-			zram_slot_unlock(zram, index);
+	zram_slot_lock(zram, index);
+	if (zram_test_flag(zram, index, ZRAM_WB)) {
+		struct bio_vec bvec;
 
-			bvec.bv_page = page;
-			bvec.bv_len = PAGE_SIZE;
-			bvec.bv_offset = 0;
-			return read_from_bdev(zram, &bvec,
-					zram_get_element(zram, index),
-					bio, partial_io);
-		}
 		zram_slot_unlock(zram, index);
+
+		bvec.bv_page = page;
+		bvec.bv_len = PAGE_SIZE;
+		bvec.bv_offset = 0;
+		return read_from_bdev(zram, &bvec,
+				zram_get_element(zram, index),
+				bio, partial_io);
 	}
 
-	zram_slot_lock(zram, index);
 	handle = zram_get_handle(zram, index);
 	if (!handle || zram_test_flag(zram, index, ZRAM_SAME)) {
 		unsigned long value;
@@ -1138,7 +1113,7 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 
 	if (unlikely(comp_len >= huge_class_size)) {
 		comp_len = PAGE_SIZE;
-		if (zram_wb_enabled(zram) && allow_wb) {
+		if (zram->backing_dev && allow_wb) {
 			zcomp_stream_put(zram->comp);
 			ret = write_to_bdev(zram, bvec, index, bio, &element);
 			if (!ret) {
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 89da501292ff..d75bf190f262 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -30,7 +30,7 @@
 
 
 /*
- * The lower ZRAM_FLAG_SHIFT bits of table.value is for
+ * The lower ZRAM_FLAG_SHIFT bits of table.flags is for
  * object size (excluding header), the higher bits is for
  * zram_pageflags.
  *
@@ -41,7 +41,7 @@
  */
 #define ZRAM_FLAG_SHIFT 24
 
-/* Flags for zram pages (table[page_no].value) */
+/* Flags for zram pages (table[page_no].flags) */
 enum zram_pageflags {
 	/* zram slot is locked */
 	ZRAM_LOCK = ZRAM_FLAG_SHIFT,
@@ -60,7 +60,7 @@ struct zram_table_entry {
 		unsigned long handle;
 		unsigned long element;
 	};
-	unsigned long value;
+	unsigned long flags;
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
 	ktime_t ac_time;
 #endif
@@ -105,8 +105,8 @@ struct zram {
 	 * zram is claimed so open request will be failed
 	 */
 	bool claim; /* Protected by bdev->bd_mutex */
-#ifdef CONFIG_ZRAM_WRITEBACK
 	struct file *backing_dev;
+#ifdef CONFIG_ZRAM_WRITEBACK
 	struct block_device *bdev;
 	unsigned int old_block_size;
 	unsigned long *bitmap;
-- 
2.19.1.1215.g8438c0b245-goog

