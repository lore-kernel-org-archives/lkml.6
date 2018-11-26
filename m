Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646E8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C13C20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9dR/MBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C13C20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbeKZTV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:21:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36137 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeKZTV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:21:58 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so1045566plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 00:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bu/MAgZi2z5LxG5NM9cVu17e220gM6NXY3hWM7N2Me0=;
        b=R9dR/MBsH4vtgyg65w8xNrPvloHxP6Hx8wfr6bq/34l4m4MB3kSj7y6AC/BVIa49z3
         zHaiQRzTAzEtLVhvfYB5oJX2uN8KJQGqEEDjmMFPREsb6bEeQd79bSd/VXiMsyNvhqKb
         Oho7jbXP+J/t3RkBEjRuex3VNgFml732v7sw0eNioz62INQb2Nq9LB/zG6fyVuKhbrnF
         KwrdghvHQ2fWIQ6armoysCGv0Es8dKzk2sKepjNnqaFnwa9xPeBZph0Uo81JoQwEdzHj
         5OL+Ld7eZhBN6iUPeoaUqj4wRvUTDJ3ZqilczvPwfFxq8XTj80yIojSr2eEZb4qTMf5Q
         izkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Bu/MAgZi2z5LxG5NM9cVu17e220gM6NXY3hWM7N2Me0=;
        b=YJMV3MoMttzujMSp7/1CA/Sqzm2hzQKvASZ5K6y2R02Yfy6nbykph4dbvn5WaxEiVv
         1aAidnfK11wsaPC+9v9Ox7rMxBDqwZawjmZI/L80KnkKDUJeg1AYYziqOQ571qiBGRo0
         whQBrOiidbaSPlf/V+vRFq71JiaHSo47kT1LvFtyRcJQO2nrAWKZCfNFbNEHxFrmKwVP
         qob97dfcO7WbQYQfaMqYJi/HXfaxkNpwaFpQcM5wKCyAEVsvYzhNdgoE+Yvc8zDAMtST
         v/w+3ft8SYmmETD9TB1H0Um4oBNqh2D7izr9xExuPfMaUgea5PUTZtuJxG94TaPpUDRy
         IFJw==
X-Gm-Message-State: AA+aEWZw2hVwCsyaU3TZjb8Lb/3t4/m9YhfQ/cIvT0BpXreTIaFC2op6
        N6pCJ2zuXnYtGqgvikKcz5o=
X-Google-Smtp-Source: AFSGD/UX3R/fnfCR+2rFqu2+31oHEiKF8RbJVNGskkauBe7uDnoicKU9h4vnDHk9uPh9+3c60ABQ5A==
X-Received: by 2002:a17:902:d806:: with SMTP id a6mr25711652plz.172.1543220915184;
        Mon, 26 Nov 2018 00:28:35 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id j197sm82846611pgc.76.2018.11.26.00.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 00:28:34 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 5/7] zram: support idle/huge page writeback
Date:   Mon, 26 Nov 2018 17:28:11 +0900
Message-Id: <20181126082813.81977-6-minchan@kernel.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181126082813.81977-1-minchan@kernel.org>
References: <20181126082813.81977-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch supports new feature "zram idle/huge page writeback".
On zram-swap usecase, zram has usually many idle/huge swap pages.
It's pointless to keep in memory(ie, zram).

To solve the problem, this feature introduces idle/huge page
writeback to backing device so the goal is to save more memory
space on embedded system.

Normal sequence to use idle/huge page writeback feature is as follows,

while (1) {
        # mark allocated zram slot to idle
        echo all > /sys/block/zram0/idle
        # leave system working for several hours
        # Unless there is no access for some blocks on zram,
	# they are still IDLE marked pages.

        echo "idle" > /sys/block/zram0/writeback
	or/and
	echo "huge" > /sys/block/zram0/writeback
        # write the IDLE or/and huge marked slot into backing device
	# and free the memory.
}

By per discussion:
https://lore.kernel.org/lkml/20181122065926.GG3441@jagdpanzerIV/T/#u,

This patch removes direct incommpressibe page writeback feature
(d2afd25114f4, zram: write incompressible pages to backing device)
so we could regard it as regression because incompressible pages
doesn't go to backing storage automatically. Instead, usre should
do it via "echo huge" > /sys/block/zram/writeback" manually.

If we hear some regression, we could restore the function.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 Documentation/ABI/testing/sysfs-block-zram |   7 +
 Documentation/blockdev/zram.txt            |  28 ++-
 drivers/block/zram/Kconfig                 |   5 +-
 drivers/block/zram/zram_drv.c              | 245 ++++++++++++++-------
 drivers/block/zram/zram_drv.h              |   1 +
 5 files changed, 207 insertions(+), 79 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-block-zram b/Documentation/ABI/testing/sysfs-block-zram
index 04c9a5980bc7..d1f80b077885 100644
--- a/Documentation/ABI/testing/sysfs-block-zram
+++ b/Documentation/ABI/testing/sysfs-block-zram
@@ -106,3 +106,10 @@ Contact:	Minchan Kim <minchan@kernel.org>
 		idle file is write-only and mark zram slot as idle.
 		If system has mounted debugfs, user can see which slots
 		are idle via /sys/kernel/debug/zram/zram<id>/block_state
+
+What:		/sys/block/zram<id>/writeback
+Date:		November 2018
+Contact:	Minchan Kim <minchan@kernel.org>
+Description:
+		The writeback file is write-only and trigger idle and/or
+		huge page writeback to backing device.
diff --git a/Documentation/blockdev/zram.txt b/Documentation/blockdev/zram.txt
index f3bcd716d8a9..806cdaabac83 100644
--- a/Documentation/blockdev/zram.txt
+++ b/Documentation/blockdev/zram.txt
@@ -238,11 +238,31 @@ The stat file represents device's mm statistics. It consists of a single
 
 = writeback
 
-With incompressible pages, there is no memory saving with zram.
-Instead, with CONFIG_ZRAM_WRITEBACK, zram can write incompressible page
+With CONFIG_ZRAM_WRITEBACK, zram can write idle/incompressible page
 to backing storage rather than keeping it in memory.
-User should set up backing device via /sys/block/zramX/backing_dev
-before disksize setting.
+To use the feature, admin should set up backing device via
+
+	"echo /dev/sda5 > /sys/block/zramX/backing_dev"
+
+before disksize setting. It supports only partition at this moment.
+If admin want to use incompressible page writeback, they could do via
+
+	"echo huge > /sys/block/zramX/write"
+
+To use idle page writeback, first, user need to declare zram pages
+as idle.
+
+	"echo all > /sys/block/zramX/idle"
+
+From now on, any pages on zram are idle pages. The idle mark
+will be removed until someone request access of the block.
+IOW, unless there is access request, those pages are still idle pages.
+
+Admin can request writeback of those idle pages at right timing via
+
+	"echo idle > /sys/block/zramX/writeback"
+
+With the command, zram writeback idle pages from memory to the storage.
 
 = memory tracking
 
diff --git a/drivers/block/zram/Kconfig b/drivers/block/zram/Kconfig
index fcd055457364..1ffc64770643 100644
--- a/drivers/block/zram/Kconfig
+++ b/drivers/block/zram/Kconfig
@@ -15,7 +15,7 @@ config ZRAM
 	  See Documentation/blockdev/zram.txt for more information.
 
 config ZRAM_WRITEBACK
-       bool "Write back incompressible page to backing device"
+       bool "Write back incompressible or idle page to backing device"
        depends on ZRAM
        help
 	 With incompressible page, there is no memory saving to keep it
@@ -23,6 +23,9 @@ config ZRAM_WRITEBACK
 	 For this feature, admin should set up backing device via
 	 /sys/block/zramX/backing_dev.
 
+	 With /sys/block/zramX/{idle,writeback}, application could ask
+	 idle page's writeback to the backing device to save in memory.
+
 	 See Documentation/blockdev/zram.txt for more information.
 
 config ZRAM_MEMORY_TRACKING
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 59f78011d2d9..3d069b2328f8 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -52,6 +52,9 @@ static unsigned int num_devices = 1;
 static size_t huge_class_size;
 
 static void zram_free_page(struct zram *zram, size_t index);
+static int zram_bvec_read(struct zram *zram, struct bio_vec *bvec,
+				u32 index, int offset, struct bio *bio);
+
 
 static int zram_slot_trylock(struct zram *zram, u32 index)
 {
@@ -73,13 +76,6 @@ static inline bool init_done(struct zram *zram)
 	return zram->disksize;
 }
 
-static inline bool zram_allocated(struct zram *zram, u32 index)
-{
-
-	return (zram->table[index].flags >> (ZRAM_FLAG_SHIFT + 1)) ||
-					zram->table[index].handle;
-}
-
 static inline struct zram *dev_to_zram(struct device *dev)
 {
 	return (struct zram *)dev_to_disk(dev)->private_data;
@@ -138,6 +134,13 @@ static void zram_set_obj_size(struct zram *zram,
 	zram->table[index].flags = (flags << ZRAM_FLAG_SHIFT) | size;
 }
 
+static inline bool zram_allocated(struct zram *zram, u32 index)
+{
+	return zram_get_obj_size(zram, index) ||
+			zram_test_flag(zram, index, ZRAM_SAME) ||
+			zram_test_flag(zram, index, ZRAM_WB);
+}
+
 #if PAGE_SIZE != 4096
 static inline bool is_partial_io(struct bio_vec *bvec)
 {
@@ -306,10 +309,14 @@ static ssize_t idle_store(struct device *dev,
 	}
 
 	for (index = 0; index < nr_pages; index++) {
+		/*
+		 * Do not mark ZRAM_UNDER_WB slot as ZRAM_IDLE to close race.
+		 * See the comment in writeback_store.
+		 */
 		zram_slot_lock(zram, index);
-		if (!zram_allocated(zram, index))
+		if (!zram_allocated(zram, index) ||
+				zram_test_flag(zram, index, ZRAM_UNDER_WB))
 			goto next;
-
 		zram_set_flag(zram, index, ZRAM_IDLE);
 next:
 		zram_slot_unlock(zram, index);
@@ -566,6 +573,156 @@ static int read_from_bdev_async(struct zram *zram, struct bio_vec *bvec,
 	return 1;
 }
 
+#define HUGE_WRITEBACK 0x1
+#define IDLE_WRITEBACK 0x2
+
+static ssize_t writeback_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	unsigned long index;
+	struct bio bio;
+	struct bio_vec bio_vec;
+	struct page *page;
+	ssize_t ret, sz;
+	char mode_buf[64];
+	unsigned long mode = -1UL;
+	unsigned long blk_idx = 0;
+
+	strlcpy(mode_buf, buf, sizeof(mode_buf));
+	/* ignore trailing newline */
+	sz = strlen(mode_buf);
+	if (sz > 0 && mode_buf[sz - 1] == '\n')
+		mode_buf[sz - 1] = 0x00;
+
+	if (!strcmp(mode_buf, "idle"))
+		mode = IDLE_WRITEBACK;
+	if (!strcmp(mode_buf, "huge"))
+		mode = HUGE_WRITEBACK;
+
+	if (mode == -1UL)
+		return -EINVAL;
+
+	down_read(&zram->init_lock);
+	if (!init_done(zram)) {
+		ret = -EINVAL;
+		goto release_init_lock;
+	}
+
+	if (!zram->backing_dev) {
+		ret = -ENODEV;
+		goto release_init_lock;
+	}
+
+	page = alloc_page(GFP_KERNEL);
+	if (!page) {
+		ret = -ENOMEM;
+		goto release_init_lock;
+	}
+
+	for (index = 0; index < nr_pages; index++) {
+		struct bio_vec bvec;
+
+		bvec.bv_page = page;
+		bvec.bv_len = PAGE_SIZE;
+		bvec.bv_offset = 0;
+
+		if (!blk_idx) {
+			blk_idx = alloc_block_bdev(zram);
+			if (!blk_idx) {
+				ret = -ENOSPC;
+				break;
+			}
+		}
+
+		zram_slot_lock(zram, index);
+		if (!zram_allocated(zram, index))
+			goto next;
+
+		if (zram_test_flag(zram, index, ZRAM_WB) ||
+				zram_test_flag(zram, index, ZRAM_SAME) ||
+				zram_test_flag(zram, index, ZRAM_UNDER_WB))
+			goto next;
+
+		if ((mode & IDLE_WRITEBACK &&
+			  !zram_test_flag(zram, index, ZRAM_IDLE)) &&
+		    (mode & HUGE_WRITEBACK &&
+			  !zram_test_flag(zram, index, ZRAM_HUGE)))
+			goto next;
+		/*
+		 * Clearing ZRAM_UNDER_WB is duty of caller.
+		 * IOW, zram_free_page never clear it.
+		 */
+		zram_set_flag(zram, index, ZRAM_UNDER_WB);
+		/* Need for hugepage writeback racing */
+		zram_set_flag(zram, index, ZRAM_IDLE);
+		zram_slot_unlock(zram, index);
+		if (zram_bvec_read(zram, &bvec, index, 0, NULL)) {
+			zram_slot_lock(zram, index);
+			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
+			zram_clear_flag(zram, index, ZRAM_IDLE);
+			zram_slot_unlock(zram, index);
+			continue;
+		}
+
+		bio_init(&bio, &bio_vec, 1);
+		bio_set_dev(&bio, zram->bdev);
+		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
+		bio.bi_opf = REQ_OP_WRITE | REQ_SYNC;
+
+		bio_add_page(&bio, bvec.bv_page, bvec.bv_len,
+				bvec.bv_offset);
+		/*
+		 * XXX: A single page IO would be inefficient for write
+		 * but it would be not bad as starter.
+		 */
+		ret = submit_bio_wait(&bio);
+		if (ret) {
+			zram_slot_lock(zram, index);
+			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
+			zram_clear_flag(zram, index, ZRAM_IDLE);
+			zram_slot_unlock(zram, index);
+			continue;
+		}
+
+		/*
+		 * We released zram_slot_lock so need to check if the slot was
+		 * changed. If there is freeing for the slot, we can catch it
+		 * easily by zram_allocated.
+		 * A subtle case is the slot is freed/reallocated/marked as
+		 * ZRAM_IDLE again. To close the race, idle_store doesn't
+		 * mark ZRAM_IDLE once it found the slot was ZRAM_UNDER_WB.
+		 * Thus, we could close the race by checking ZRAM_IDLE bit.
+		 */
+		zram_slot_lock(zram, index);
+		if (!zram_allocated(zram, index) ||
+			  !zram_test_flag(zram, index, ZRAM_IDLE)) {
+			zram_clear_flag(zram, index, ZRAM_UNDER_WB);
+			zram_clear_flag(zram, index, ZRAM_IDLE);
+			goto next;
+		}
+
+		zram_free_page(zram, index);
+		zram_clear_flag(zram, index, ZRAM_UNDER_WB);
+		zram_set_flag(zram, index, ZRAM_WB);
+		zram_set_element(zram, index, blk_idx);
+		blk_idx = 0;
+		atomic64_inc(&zram->stats.pages_stored);
+next:
+		zram_slot_unlock(zram, index);
+	}
+
+	if (blk_idx)
+		free_block_bdev(zram, blk_idx);
+	ret = len;
+	__free_page(page);
+release_init_lock:
+	up_read(&zram->init_lock);
+
+	return ret;
+}
+
 struct zram_work {
 	struct work_struct work;
 	struct zram *zram;
@@ -623,57 +780,8 @@ static int read_from_bdev(struct zram *zram, struct bio_vec *bvec,
 	else
 		return read_from_bdev_async(zram, bvec, entry, parent);
 }
-
-static int write_to_bdev(struct zram *zram, struct bio_vec *bvec,
-					u32 index, struct bio *parent,
-					unsigned long *pentry)
-{
-	struct bio *bio;
-	unsigned long entry;
-
-	bio = bio_alloc(GFP_ATOMIC, 1);
-	if (!bio)
-		return -ENOMEM;
-
-	entry = alloc_block_bdev(zram);
-	if (!entry) {
-		bio_put(bio);
-		return -ENOSPC;
-	}
-
-	bio->bi_iter.bi_sector = entry * (PAGE_SIZE >> 9);
-	bio_set_dev(bio, zram->bdev);
-	if (!bio_add_page(bio, bvec->bv_page, bvec->bv_len,
-					bvec->bv_offset)) {
-		bio_put(bio);
-		free_block_bdev(zram, entry);
-		return -EIO;
-	}
-
-	if (!parent) {
-		bio->bi_opf = REQ_OP_WRITE | REQ_SYNC;
-		bio->bi_end_io = zram_page_end_io;
-	} else {
-		bio->bi_opf = parent->bi_opf;
-		bio_chain(bio, parent);
-	}
-
-	submit_bio(bio);
-	*pentry = entry;
-
-	return 0;
-}
-
 #else
 static inline void reset_bdev(struct zram *zram) {};
-static int write_to_bdev(struct zram *zram, struct bio_vec *bvec,
-					u32 index, struct bio *parent,
-					unsigned long *pentry)
-
-{
-	return -EIO;
-}
-
 static int read_from_bdev(struct zram *zram, struct bio_vec *bvec,
 			unsigned long entry, struct bio *parent, bool sync)
 {
@@ -1026,7 +1134,8 @@ static void zram_free_page(struct zram *zram, size_t index)
 	atomic64_dec(&zram->stats.pages_stored);
 	zram_set_handle(zram, index, 0);
 	zram_set_obj_size(zram, index, 0);
-	WARN_ON_ONCE(zram->table[index].flags & ~(1UL << ZRAM_LOCK));
+	WARN_ON_ONCE(zram->table[index].flags &
+		~(1UL << ZRAM_LOCK | 1UL << ZRAM_UNDER_WB));
 }
 
 static int __zram_bvec_read(struct zram *zram, struct page *page, u32 index,
@@ -1135,7 +1244,6 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 	struct page *page = bvec->bv_page;
 	unsigned long element = 0;
 	enum zram_pageflags flags = 0;
-	bool allow_wb = true;
 
 	mem = kmap_atomic(page);
 	if (page_same_filled(mem, &element)) {
@@ -1160,21 +1268,8 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 		return ret;
 	}
 
-	if (unlikely(comp_len >= huge_class_size)) {
+	if (comp_len >= huge_class_size)
 		comp_len = PAGE_SIZE;
-		if (zram->backing_dev && allow_wb) {
-			zcomp_stream_put(zram->comp);
-			ret = write_to_bdev(zram, bvec, index, bio, &element);
-			if (!ret) {
-				flags = ZRAM_WB;
-				ret = 1;
-				goto out;
-			}
-			allow_wb = false;
-			goto compress_again;
-		}
-	}
-
 	/*
 	 * handle allocation has 2 paths:
 	 * a) fast path is executed with preemption disabled (for
@@ -1663,6 +1758,7 @@ static DEVICE_ATTR_RW(max_comp_streams);
 static DEVICE_ATTR_RW(comp_algorithm);
 #ifdef CONFIG_ZRAM_WRITEBACK
 static DEVICE_ATTR_RW(backing_dev);
+static DEVICE_ATTR_WO(writeback);
 #endif
 
 static struct attribute *zram_disk_attrs[] = {
@@ -1677,6 +1773,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_comp_algorithm.attr,
 #ifdef CONFIG_ZRAM_WRITEBACK
 	&dev_attr_backing_dev.attr,
+	&dev_attr_writeback.attr,
 #endif
 	&dev_attr_io_stat.attr,
 	&dev_attr_mm_stat.attr,
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 214fa4bb46b9..07695fe70e17 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -47,6 +47,7 @@ enum zram_pageflags {
 	ZRAM_LOCK = ZRAM_FLAG_SHIFT,
 	ZRAM_SAME,	/* Page consists the same element */
 	ZRAM_WB,	/* page is stored on backing_device */
+	ZRAM_UNDER_WB,	/* page is under writeback */
 	ZRAM_HUGE,	/* Incompressible page */
 	ZRAM_IDLE,	/* not accessed page since last idle marking */
 
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

