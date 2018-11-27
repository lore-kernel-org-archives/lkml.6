Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9757C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 05:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6ADD20873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 05:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyFoszg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6ADD20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbeK0Qwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 11:52:36 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39222 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbeK0Qwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 11:52:35 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so8779556pld.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 21:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9yJ5k5N14UmdgT7Yomdb6cJXcUJSwrW0bJOfZvFH1t8=;
        b=KyFoszg4i1Hz6T/guSDxaua4sm9cISpyTbQh3ikZabllEtcSTdJskY7jRd+V9hUoJ0
         Nlu8Je+KRTW4OS5qq/8KY7alcqWSXIuyuuEZeAx+o0bazvqC+gH0ZUYQ5q9ptpQvGPHl
         zRdbCcyjh5U6pHRcZ8ApuNu37mxWVjsokeCE6MZHD6uteEfeFt08eQNnflIXTkQHpuNA
         bCUHPQvnZt4xJeZxgg3J02lVOsYMoSiL8AKWBGXFUeU7P5XrnWWgUzPva1yUIgaNfG2R
         iQ8dy2MOtDzEm+v0Eka3Su269sQ0pkIkNZv/7Rc0iQpKhUV4S+xvCP177oRfSjyKKXVv
         hFBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9yJ5k5N14UmdgT7Yomdb6cJXcUJSwrW0bJOfZvFH1t8=;
        b=rK4khMUZ7dO6oN51/l10lvIdj5SuZret3eaq/dpL/Rfbj5XY/5kDGeBftWMuge4fCR
         xifSRmQi8UlrpwXMpWKv9y5NQXyJrFox0Um8kY4oFBOeswI+C7+/wrYylksUCyOUgqVh
         dTmqCY7krCGLzW2jYtP8X9Un6jHHgcB6hzey3dk3s2WUmlouaCXjYHQUiZtmGi/akeDW
         W0+UBua9hHJMx8N5E6+pR/jFG7yHvmELbP9VExJUkdpixwbapKw8fQv07/0NSlsEdngE
         1QgIjxL4uJeqlBZnXvd9/G0zL9GzP/ohDYbKUJ7MCzjX2ooGe4Tq0D5RerPw/OJtjV/G
         WGAA==
X-Gm-Message-State: AA+aEWbi4wElg1G7dVfMOFUX/Fe+ucwOzT5pZTzcLSm9udIAPEsnJw06
        pbIxF8a6ntNvoLPrcU0RU3o=
X-Google-Smtp-Source: AFSGD/V35r27kKVO60TP5GN+3C9h04Q+po77z62tKSC43ayd2uWThCeFJIdY+wUZxTeEOlip18WGIw==
X-Received: by 2002:a17:902:7b91:: with SMTP id w17mr31175818pll.111.1543298150376;
        Mon, 26 Nov 2018 21:55:50 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id f32sm2580203pgf.80.2018.11.26.21.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 21:55:49 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v3 7/7] zram: writeback throttle
Date:   Tue, 27 Nov 2018 14:54:29 +0900
Message-Id: <20181127055429.251614-8-minchan@kernel.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181127055429.251614-1-minchan@kernel.org>
References: <20181127055429.251614-1-minchan@kernel.org>
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
 Documentation/ABI/testing/sysfs-block-zram |  9 +++++
 Documentation/blockdev/zram.txt            |  2 +
 drivers/block/zram/zram_drv.c              | 47 +++++++++++++++++++++-
 drivers/block/zram/zram_drv.h              |  2 +
 4 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-block-zram b/Documentation/ABI/testing/sysfs-block-zram
index 65fc33b2f53b..9d2339a485c8 100644
--- a/Documentation/ABI/testing/sysfs-block-zram
+++ b/Documentation/ABI/testing/sysfs-block-zram
@@ -121,3 +121,12 @@ Contact:	Minchan Kim <minchan@kernel.org>
 		The bd_stat file is read-only and represents backing device's
 		statistics (bd_count, bd_reads, bd_writes) in a format
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
index 906df97527a7..64b61925e475 100644
--- a/Documentation/blockdev/zram.txt
+++ b/Documentation/blockdev/zram.txt
@@ -164,6 +164,8 @@ reset             WO    trigger device reset
 mem_used_max      WO    reset the `mem_used_max' counter (see later)
 mem_limit         WO    specifies the maximum amount of memory ZRAM can use
                         to store the compressed data
+writeback_limit   WO    specifies the maximum amount of write IO zram can
+			write out to backing device as 4KB unit
 max_comp_streams  RW    the number of possible concurrent compress operations
 comp_algorithm    RW    show and change the compression algorithm
 compact           WO    trigger memory compaction
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 67168a6ecca6..58b025c5c83e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -330,6 +330,40 @@ static ssize_t idle_store(struct device *dev,
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
@@ -571,6 +605,7 @@ static ssize_t writeback_store(struct device *dev,
 	char mode_buf[8];
 	unsigned long mode = -1UL;
 	unsigned long blk_idx = 0;
+	u64 wb_count, wb_limit;
 
 	sz = strscpy(mode_buf, buf, sizeof(mode_buf));
 	if (sz <= 0)
@@ -612,6 +647,11 @@ static ssize_t writeback_store(struct device *dev,
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
@@ -670,7 +710,7 @@ static ssize_t writeback_store(struct device *dev,
 			continue;
 		}
 
-		atomic64_inc(&zram->stats.bd_writes);
+		wb_count = atomic64_inc_return(&zram->stats.bd_writes);
 		/*
 		 * We released zram_slot_lock so need to check if the slot was
 		 * changed. If there is freeing for the slot, we can catch it
@@ -694,6 +734,9 @@ static ssize_t writeback_store(struct device *dev,
 		zram_set_element(zram, index, blk_idx);
 		blk_idx = 0;
 		atomic64_inc(&zram->stats.pages_stored);
+		wb_limit = atomic64_read(&zram->stats.bd_wb_limit);
+		if (wb_limit != 0 && wb_count >= wb_limit)
+			zram->stop_writeback = true;
 next:
 		zram_slot_unlock(zram, index);
 	}
@@ -1767,6 +1810,7 @@ static DEVICE_ATTR_RW(comp_algorithm);
 #ifdef CONFIG_ZRAM_WRITEBACK
 static DEVICE_ATTR_RW(backing_dev);
 static DEVICE_ATTR_WO(writeback);
+static DEVICE_ATTR_RW(writeback_limit);
 #endif
 
 static struct attribute *zram_disk_attrs[] = {
@@ -1782,6 +1826,7 @@ static struct attribute *zram_disk_attrs[] = {
 #ifdef CONFIG_ZRAM_WRITEBACK
 	&dev_attr_backing_dev.attr,
 	&dev_attr_writeback.attr,
+	&dev_attr_writeback_limit.attr,
 #endif
 	&dev_attr_io_stat.attr,
 	&dev_attr_mm_stat.attr,
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index bc477803530d..4bd3afd15e83 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -86,6 +86,7 @@ struct zram_stats {
 	atomic64_t bd_count;		/* no. of pages in backing device */
 	atomic64_t bd_reads;		/* no. of reads from backing device */
 	atomic64_t bd_writes;		/* no. of writes from backing device */
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
2.20.0.rc0.387.gc7a69e6b6c-goog

