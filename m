Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA565C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A42F223C8
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkajEFt1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A42F223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389479AbeKPRcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 12:32:10 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33789 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389319AbeKPRcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 12:32:09 -0500
Received: by mail-pg1-f193.google.com with SMTP id z11so7574847pgu.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 23:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EFJ1Ravm0NwSShWhWHw0dSqokeg5ma4lkXp8sytm7RE=;
        b=XkajEFt1/LaDN9zInU4q41QHfif1fYIx5LFMK9FJr93LWr960Q56uzKCqVxjTpnUk4
         yYMG86NBAGUe9wpHA1e7BN5X1CzXfxTtJ1EnB1zn+kkULf9jHHbW+V/v6grigaB2DkJQ
         yaIRrtI8watcZPcgZmJ+FnrtnBo1JJeqX7FOA8UrwFC+vdx3QtOTlTgCyS5cvLuCIw4H
         EngGH6k8++gVfQAPgD/g1xqug7UluyL0Y6rhXKxZ4WInVR5zOwUNjVPnXksi03jmzl9N
         /AFC1MPj0IG9U6epswc+Ra6TAqZXtx0yK8G4qywlwIsQYkcogaSGbJpdUQgDqCrBnHqE
         92Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EFJ1Ravm0NwSShWhWHw0dSqokeg5ma4lkXp8sytm7RE=;
        b=s1ofco1ieXzLq1Q8pX03miKjaZxMPEPVLODy5AAQoHKh7fWF1mAK5JlkQ6jTHILH8N
         8l1CjKz1mQXhVXTYJdVSR7eacjgL0VXQn9zPO/WMloXbPZ4x4GTCJfjAZP6HKtZB3qGn
         E0JjkwTzpay47NFas5yE7dU1kJl0IPipm1ysriJ7P9vtI3FYMSzjcwz9jRNqQi+MJR9u
         tJT35Z/7clR73opH5YzZ2fE5E4b3G6y8dCdZmHhkZRiHVEySLHvQb3S80IQBmGfftgTr
         HjrO4z/jzNuhxGRjj9/FDvjimOwijgV+i6ImFjZjgTXln1nvOBes3Z0KhfPAM+VUdj1x
         RLCg==
X-Gm-Message-State: AGRZ1gJauXzlSiugC1yvtxjrbmbCCXtkEjpRc4OKBOdS49cPdGRgYC/H
        m2pngv96v5agCjXSjkoqISQ=
X-Google-Smtp-Source: AJdET5delHSKEBpHS/XhDXtbWNFAc+6qX9FWgPb0QKqkY0zefaNR5/TgcYFIP+S7bgiaHy5LFsOCVQ==
X-Received: by 2002:a63:f615:: with SMTP id m21mr7033677pgh.428.1542352858918;
        Thu, 15 Nov 2018 23:20:58 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:7630:de9:f6f2:276f])
        by smtp.gmail.com with ESMTPSA id e9sm13974637pff.5.2018.11.15.23.20.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 23:20:57 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH 6/6] zram: writeback throttle
Date:   Fri, 16 Nov 2018 16:20:35 +0900
Message-Id: <20181116072035.155108-7-minchan@kernel.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <20181116072035.155108-1-minchan@kernel.org>
References: <20181116072035.155108-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On small memory system, there are lots of write IO so if we use
flash device as swap, there would be serious flash wearout.
To overcome the problem, system developers need to design write
limitation strategy to guarantee flash health for entire product life.

This patch creates a new konb "writeback_limit" on zram. With that,
if current writeback IO count(/sys/block/zramX/io_stat) excceds
the limitation, zram stops further writeback until admin can reset
the limit.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 Documentation/ABI/testing/sysfs-block-zram |  9 ++++
 Documentation/blockdev/zram.txt            |  2 +
 drivers/block/zram/zram_drv.c              | 55 ++++++++++++++++++++--
 drivers/block/zram/zram_drv.h              |  2 +
 4 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-block-zram b/Documentation/ABI/testing/sysfs-block-zram
index a4daca7e5043..210f2cdac752 100644
--- a/Documentation/ABI/testing/sysfs-block-zram
+++ b/Documentation/ABI/testing/sysfs-block-zram
@@ -121,3 +121,12 @@ Contact:	Minchan Kim <minchan@kernel.org>
 		The bd_stat file is read-only and represents backing device's
 		statistics (bd_count, bd_reads, bd_writes.) in a format
 		similar to block layer statistics file format.
+
+What:		/sys/block/zram<id>/writeback_limit
+Date:		November 2018
+Contact:	Minchan Kim <minchan@kernel.org>
+Description:
+		The writeback_limit file is read-write and specifies the maximum
+		amount of writeback ZRAM can do. The limit could be changed
+		in run time and "0" means disable the limit.
+		No limit is the initial state.
diff --git a/Documentation/blockdev/zram.txt b/Documentation/blockdev/zram.txt
index 1f4907307a0d..39ee416bf552 100644
--- a/Documentation/blockdev/zram.txt
+++ b/Documentation/blockdev/zram.txt
@@ -164,6 +164,8 @@ reset             WO    trigger device reset
 mem_used_max      WO    reset the `mem_used_max' counter (see later)
 mem_limit         WO    specifies the maximum amount of memory ZRAM can use
                         to store the compressed data
+writeback_limit	  WO	specifies the maximum amount of write IO zram can
+			write out to backing device
 max_comp_streams  RW    the number of possible concurrent compress operations
 comp_algorithm    RW    show and change the compression algorithm
 compact           WO    trigger memory compaction
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 17d566d9a321..b263febaed10 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -317,6 +317,40 @@ static ssize_t idle_store(struct device *dev,
 }
 
 #ifdef CONFIG_ZRAM_WRITEBACK
+
+static ssize_t writeback_limit_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	u64 val;
+	ssize_t ret = -EINVAL;
+
+	if (kstrtoull(buf, 10, &val))
+		return ret;
+
+	down_read(&zram->init_lock);
+	atomic64_set(&zram->stats.bd_wb_limit, val);
+	if (val == 0 || val > atomic64_read(&zram->stats.bd_writes))
+		zram->stop_writeback = false;
+	up_read(&zram->init_lock);
+	ret = len;
+
+	return ret;
+}
+
+static ssize_t writeback_limit_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	u64 val;
+	struct zram *zram = dev_to_zram(dev);
+
+	down_read(&zram->init_lock);
+	val = atomic64_read(&zram->stats.bd_wb_limit);
+	up_read(&zram->init_lock);
+
+	return scnprintf(buf, PAGE_SIZE, "%llu\n", val);
+}
+
 static void reset_bdev(struct zram *zram)
 {
 	struct block_device *bdev;
@@ -575,6 +609,7 @@ static ssize_t writeback_store(struct device *dev,
 	ssize_t ret;
 	unsigned long mode;
 	unsigned long blk_idx = 0;
+	u64 wb_count, wb_limit;
 
 #define HUGE_WRITEBACK 0x1
 #define IDLE_WRITEBACK 0x2
@@ -610,6 +645,11 @@ static ssize_t writeback_store(struct device *dev,
 		bvec.bv_len = PAGE_SIZE;
 		bvec.bv_offset = 0;
 
+		if (zram->stop_writeback) {
+			ret = -EIO;
+			break;
+		}
+
 		if (!blk_idx) {
 			blk_idx = alloc_block_bdev(zram);
 			if (!blk_idx) {
@@ -664,7 +704,7 @@ static ssize_t writeback_store(struct device *dev,
 			continue;
 		}
 
-		atomic64_inc(&zram->stats.bd_writes);
+		wb_count = atomic64_inc_return(&zram->stats.bd_writes);
 		/*
 		 * We released zram_slot_lock so need to check if the slot was
 		 * changed. If there is freeing for the slot, we can catch it
@@ -687,6 +727,9 @@ static ssize_t writeback_store(struct device *dev,
 		zram_set_element(zram, index, blk_idx);
 		blk_idx = 0;
 		atomic64_inc(&zram->stats.pages_stored);
+		wb_limit = atomic64_read(&zram->stats.bd_wb_limit);
+		if (wb_limit != 0 && wb_count >= wb_limit)
+			zram->stop_writeback = true;
 next:
 		zram_slot_unlock(zram, index);
 	}
@@ -765,6 +808,7 @@ static int write_to_bdev(struct zram *zram, struct bio_vec *bvec,
 {
 	struct bio *bio;
 	unsigned long entry;
+	u64 wb_count, wb_limit;
 
 	bio = bio_alloc(GFP_ATOMIC, 1);
 	if (!bio)
@@ -795,7 +839,10 @@ static int write_to_bdev(struct zram *zram, struct bio_vec *bvec,
 
 	submit_bio(bio);
 	*pentry = entry;
-	atomic64_inc(&zram->stats.bd_writes);
+	wb_count = atomic64_inc_return(&zram->stats.bd_writes);
+	wb_limit = atomic64_read(&zram->stats.bd_wb_limit);
+	if (wb_limit != 0 && wb_count >= wb_limit)
+		zram->stop_writeback = true;
 
 	return 0;
 }
@@ -1319,7 +1366,7 @@ static int __zram_bvec_write(struct zram *zram, struct bio_vec *bvec,
 		return ret;
 	}
 
-	if (unlikely(comp_len >= huge_class_size)) {
+	if (unlikely(comp_len >= huge_class_size) && !zram->stop_writeback) {
 		comp_len = PAGE_SIZE;
 		if (zram->backing_dev && allow_wb) {
 			zcomp_stream_put(zram->comp);
@@ -1823,6 +1870,7 @@ static DEVICE_ATTR_RW(comp_algorithm);
 #ifdef CONFIG_ZRAM_WRITEBACK
 static DEVICE_ATTR_RW(backing_dev);
 static DEVICE_ATTR_WO(writeback);
+static DEVICE_ATTR_RW(writeback_limit);
 #endif
 
 static struct attribute *zram_disk_attrs[] = {
@@ -1838,6 +1886,7 @@ static struct attribute *zram_disk_attrs[] = {
 #ifdef CONFIG_ZRAM_WRITEBACK
 	&dev_attr_backing_dev.attr,
 	&dev_attr_writeback.attr,
+	&dev_attr_writeback_limit.attr,
 #endif
 	&dev_attr_io_stat.attr,
 	&dev_attr_mm_stat.attr,
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 487ff283fb31..41cbd0f7aea8 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -86,6 +86,7 @@ struct zram_stats {
 	atomic64_t bd_count;		/* no. of pages in backing device */
 	atomic64_t bd_reads;		/* no. of read from backing device */
 	atomic64_t bd_writes;		/* no. of write from backing device */
+	atomic64_t bd_wb_limit;		/* writeback limit of backing device */
 #endif
 };
 
@@ -113,6 +114,7 @@ struct zram {
 	 */
 	bool claim; /* Protected by bdev->bd_mutex */
 	struct file *backing_dev;
+	bool stop_writeback;
 #ifdef CONFIG_ZRAM_WRITEBACK
 	struct block_device *bdev;
 	unsigned int old_block_size;
-- 
2.19.1.1215.g8438c0b245-goog

