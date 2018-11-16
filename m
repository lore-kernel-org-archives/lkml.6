Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43208C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002C0208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlgPgMDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002C0208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389463AbeKPRcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 12:32:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44279 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389319AbeKPRcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 12:32:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id b81-v6so10475418pfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 23:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eI/WHE4QCbXfhOSNbH+XiRcXZRf3gqFMzHtcCg8DaGI=;
        b=WlgPgMDrJHROBHo/J3j9TYhGD7KVt+X1TWPkekI5qOOK50PGktrnVz6FWWd0TaNz79
         SpyzhGIT/jDhJY3kCjOb+GC3W6szuh5gJOpzAgqG4bsbNyB9L7RK6eSCBpIVywGxxkMn
         gaUNXFr3Eq0worKY0iEEUiLv/OhmvBRoxwBZ4+VfLXKOx9rSSAsNNb3UO/P18cgdql+G
         CEb9oENHJLU8N+w+SJmeT1UxNycA7Po79poR3m/0wG9tBtgseAH6WsFbMgKP/KjHz5zH
         PuVq+fVujUdVb4kPKWEoBbpTzikgL/ts24Q6BDY8Fl1DUfhCUwCaPPhfIqCO+1XxmYRL
         gKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=eI/WHE4QCbXfhOSNbH+XiRcXZRf3gqFMzHtcCg8DaGI=;
        b=F2x5JkLIf9UxLtxXxbfWvb5ZG7gtdW3kPMO50g1Rrb4guw4Jo92lClVZcNsczeJ06D
         5qcogjy0nNeNIIqrS9Jpw+OZqrdJPl3fmaClheOyLFIuUdH2J0KjEAUtrwCs/BPwVwfT
         io9rMRFRLZh81KRIgKdZtHo0QUKLuN+Q+ZUHyxWDoqj9UxHUy2MuPyoumADlNbJ+VzE9
         8B9cLaq2dp30/tYf5/3OOwmFrJr5slg+IbIxO+9OUnKdWahJxE9ztyRE22HKkfUlB61+
         Y0U/loEynpsNmk1Oh9/BmwSC4fhAIciw4OwxZ1xLLghB/TIlvbek+9eOhjppdGYeJ9vQ
         2gag==
X-Gm-Message-State: AGRZ1gJkR3/QlDPfeEm8aSgvv7atF0vUz3/wZFaL9cTgfTFgRInya7mx
        Jl4q+eifXrrc+ieFokw/55E=
X-Google-Smtp-Source: AJdET5fp5d1nYgrpcrD0/aPZe+zBCFfLDikzFruBPZoO3AnsPMcuIjZryuSU8VMyhQVbpmUvaeCRZA==
X-Received: by 2002:a62:14d1:: with SMTP id 200mr10041637pfu.103.1542352856103;
        Thu, 15 Nov 2018 23:20:56 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:7630:de9:f6f2:276f])
        by smtp.gmail.com with ESMTPSA id e9sm13974637pff.5.2018.11.15.23.20.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 23:20:54 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH 5/6] zram: add bd_stat statistics
Date:   Fri, 16 Nov 2018 16:20:34 +0900
Message-Id: <20181116072035.155108-6-minchan@kernel.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <20181116072035.155108-1-minchan@kernel.org>
References: <20181116072035.155108-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bd_stat reprenents things happened in backing device. Currently,
it supports bd_counts, bd_reads and bd_writes which are helpful
to understand wearout of flash and memory saving.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 Documentation/ABI/testing/sysfs-block-zram |  8 ++++++
 Documentation/blockdev/zram.txt            | 11 ++++++++
 drivers/block/zram/zram_drv.c              | 31 ++++++++++++++++++++++
 drivers/block/zram/zram_drv.h              |  5 ++++
 4 files changed, 55 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block-zram b/Documentation/ABI/testing/sysfs-block-zram
index d1f80b077885..a4daca7e5043 100644
--- a/Documentation/ABI/testing/sysfs-block-zram
+++ b/Documentation/ABI/testing/sysfs-block-zram
@@ -113,3 +113,11 @@ Contact:	Minchan Kim <minchan@kernel.org>
 Description:
 		The writeback file is write-only and trigger idle and/or
 		huge page writeback to backing device.
+
+What:		/sys/block/zram<id>/bd_stat
+Date:		November 2018
+Contact:	Minchan Kim <minchan@kernel.org>
+Description:
+		The bd_stat file is read-only and represents backing device's
+		statistics (bd_count, bd_reads, bd_writes.) in a format
+		similar to block layer statistics file format.
diff --git a/Documentation/blockdev/zram.txt b/Documentation/blockdev/zram.txt
index 60b585dab6e0..1f4907307a0d 100644
--- a/Documentation/blockdev/zram.txt
+++ b/Documentation/blockdev/zram.txt
@@ -221,6 +221,17 @@ The stat file represents device's mm statistics. It consists of a single
  pages_compacted  the number of pages freed during compaction
  huge_pages	  the number of incompressible pages
 
+File /sys/block/zram<id>/bd_stat
+
+The stat file represents device's backing device statistics. It consists of
+a single line of text and contains the following stats separated by whitespace:
+ bd_count	size of data written in backing device.
+		Unit: pages
+ bd_reads	the number of reads from backing device
+		Unit: pages
+ bd_writes	the number of writes to backing device
+		Unit: pages
+
 9) Deactivate:
 	swapoff /dev/zram0
 	umount /dev/zram1
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index b7b5c9e5f0cd..17d566d9a321 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -505,6 +505,8 @@ static unsigned long alloc_block_bdev(struct zram *zram)
 	ret = blk_idx;
 out:
 	spin_unlock_irq(&zram->bitmap_lock);
+	if (ret != 0)
+		atomic64_inc(&zram->stats.bd_count);
 
 	return ret;
 }
@@ -518,6 +520,7 @@ static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
 	was_set = test_and_clear_bit(blk_idx, zram->bitmap);
 	spin_unlock_irqrestore(&zram->bitmap_lock, flags);
 	WARN_ON_ONCE(!was_set);
+	atomic64_dec(&zram->stats.bd_count);
 }
 
 static void zram_page_end_io(struct bio *bio)
@@ -661,6 +664,7 @@ static ssize_t writeback_store(struct device *dev,
 			continue;
 		}
 
+		atomic64_inc(&zram->stats.bd_writes);
 		/*
 		 * We released zram_slot_lock so need to check if the slot was
 		 * changed. If there is freeing for the slot, we can catch it
@@ -748,6 +752,7 @@ static int read_from_bdev_sync(struct zram *zram, struct bio_vec *bvec,
 static int read_from_bdev(struct zram *zram, struct bio_vec *bvec,
 			unsigned long entry, struct bio *parent, bool sync)
 {
+	atomic64_inc(&zram->stats.bd_reads);
 	if (sync)
 		return read_from_bdev_sync(zram, bvec, entry, parent);
 	else
@@ -790,6 +795,7 @@ static int write_to_bdev(struct zram *zram, struct bio_vec *bvec,
 
 	submit_bio(bio);
 	*pentry = entry;
+	atomic64_inc(&zram->stats.bd_writes);
 
 	return 0;
 }
@@ -1053,6 +1059,25 @@ static ssize_t mm_stat_show(struct device *dev,
 	return ret;
 }
 
+#ifdef CONFIG_ZRAM_WRITEBACK
+static ssize_t bd_stat_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct zram *zram = dev_to_zram(dev);
+	ssize_t ret;
+
+	down_read(&zram->init_lock);
+	ret = scnprintf(buf, PAGE_SIZE,
+			"%8llu %8llu %8llu\n",
+			(u64)atomic64_read(&zram->stats.bd_count),
+			(u64)atomic64_read(&zram->stats.bd_reads),
+			(u64)atomic64_read(&zram->stats.bd_writes));
+	up_read(&zram->init_lock);
+
+	return ret;
+}
+#endif
+
 static ssize_t debug_stat_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -1073,6 +1098,9 @@ static ssize_t debug_stat_show(struct device *dev,
 
 static DEVICE_ATTR_RO(io_stat);
 static DEVICE_ATTR_RO(mm_stat);
+#ifdef CONFIG_ZRAM_WRITEBACK
+static DEVICE_ATTR_RO(bd_stat);
+#endif
 static DEVICE_ATTR_RO(debug_stat);
 
 static void zram_meta_free(struct zram *zram, u64 disksize)
@@ -1813,6 +1841,9 @@ static struct attribute *zram_disk_attrs[] = {
 #endif
 	&dev_attr_io_stat.attr,
 	&dev_attr_mm_stat.attr,
+#ifdef CONFIG_ZRAM_WRITEBACK
+	&dev_attr_bd_stat.attr,
+#endif
 	&dev_attr_debug_stat.attr,
 	NULL,
 };
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 07695fe70e17..487ff283fb31 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -82,6 +82,11 @@ struct zram_stats {
 	atomic_long_t max_used_pages;	/* no. of maximum pages stored */
 	atomic64_t writestall;		/* no. of write slow paths */
 	atomic64_t miss_free;		/* no. of missed free */
+#ifdef	CONFIG_ZRAM_WRITEBACK
+	atomic64_t bd_count;		/* no. of pages in backing device */
+	atomic64_t bd_reads;		/* no. of read from backing device */
+	atomic64_t bd_writes;		/* no. of write from backing device */
+#endif
 };
 
 struct zram {
-- 
2.19.1.1215.g8438c0b245-goog

