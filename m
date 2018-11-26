Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F5AC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A7320855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myULDRDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A7320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbeKZTWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:22:01 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37457 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeKZTWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:22:00 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so13528393plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 00:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4kafmVdbDXZPaFstch5il4XuzmKdATRh8Gz/oY6ar+M=;
        b=myULDRDXsAdzx2np7te18XFJ9UaqS0r6/OivBA+w8j0cILOK6V8G90E/EbEhfD2lpP
         h6q7WX7nUnnw7QHFTQTYWKhnWubNyRXCIaGcQ8O+kqqU7EoFGuJvpTsjW/GDeWK0H6hz
         XNSHIzVgBXlOOqKM/76iZKKJE+9VQeiN5/cBAZ/0Aih3Zwyo42QNKQv3u8f01u0qnPxl
         VkepZHM6g2dfK5YaFL/gpc8B89qdlON3E2miZThs6hbZf2Tjmjghn3Unv28t0LnJnfNc
         bBev81zkxXVZqtAk1tBVhwxk/YLvQyBOt42vLTzJWVFQD3d8G0+ICAtYuPJYZf8BaM8h
         CTgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=4kafmVdbDXZPaFstch5il4XuzmKdATRh8Gz/oY6ar+M=;
        b=qN1LlDj4roPQSlWlptCS1r4MXPBkPI5Ltbx82Ro6d2nxBLp6cMNlq2xk6bOnsfa0+L
         lnxu9hQfUIoqVzdenQJnQ86W61+Td9yb2Uv/kVBdjlvd1wi/8KjlQrlRxnnlb62GUErg
         qo9Tx2MmBuA3nUJcNJcRDJZkHsV0thiSH16zLCV4dfjiIn4gxcAeZFTnaVBHSGk7PVAB
         JtsU6LAn4xKqBoeaUTAM1uvsKbUJXahrv1DoDglAsVR2v2/sNS/sacACAl+GBOu5fJKP
         qLeVJ11UCF4j2oOHy+WvEOel95raNk+hWnl22AsQlTLTrq+mN9oIle4MgrRegmi+ujWm
         A1xA==
X-Gm-Message-State: AA+aEWbOSzoSvI0YRCCDK3d/PWue6PKAEBmvlmP8ShwcXSZb7H/FTdlN
        pOV/IEy2GpKoqza91xE/c+e6x8t/G44=
X-Google-Smtp-Source: AFSGD/WH5PxkItSTMWzoCTUG0Y1vAbTOrKDgOnWH6RbpdpWLu+1Lq27rluM1dgKDyoobx8kMKtmtRg==
X-Received: by 2002:a17:902:8484:: with SMTP id c4mr25932483plo.59.1543220917853;
        Mon, 26 Nov 2018 00:28:37 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id j197sm82846611pgc.76.2018.11.26.00.28.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 00:28:36 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 6/7] zram: add bd_stat statistics
Date:   Mon, 26 Nov 2018 17:28:12 +0900
Message-Id: <20181126082813.81977-7-minchan@kernel.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181126082813.81977-1-minchan@kernel.org>
References: <20181126082813.81977-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bd_stat represents things happened in backing device. Currently,
it supports bd_counts, bd_reads and bd_writes which are helpful
to understand wearout of flash and memory saving.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 Documentation/ABI/testing/sysfs-block-zram |  8 ++++++
 Documentation/blockdev/zram.txt            | 11 ++++++++
 drivers/block/zram/zram_drv.c              | 30 ++++++++++++++++++++++
 drivers/block/zram/zram_drv.h              |  5 ++++
 4 files changed, 54 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-block-zram b/Documentation/ABI/testing/sysfs-block-zram
index d1f80b077885..65fc33b2f53b 100644
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
+		statistics (bd_count, bd_reads, bd_writes) in a format
+		similar to block layer statistics file format.
diff --git a/Documentation/blockdev/zram.txt b/Documentation/blockdev/zram.txt
index 806cdaabac83..550bca77d322 100644
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
index 3d069b2328f8..cceaa10301e8 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -518,6 +518,8 @@ static unsigned long alloc_block_bdev(struct zram *zram)
 	ret = blk_idx;
 out:
 	spin_unlock_irq(&zram->bitmap_lock);
+	if (ret != 0)
+		atomic64_inc(&zram->stats.bd_count);
 
 	return ret;
 }
@@ -531,6 +533,7 @@ static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
 	was_set = test_and_clear_bit(blk_idx, zram->bitmap);
 	spin_unlock_irqrestore(&zram->bitmap_lock, flags);
 	WARN_ON_ONCE(!was_set);
+	atomic64_dec(&zram->stats.bd_count);
 }
 
 static void zram_page_end_io(struct bio *bio)
@@ -686,6 +689,7 @@ static ssize_t writeback_store(struct device *dev,
 			continue;
 		}
 
+		atomic64_inc(&zram->stats.bd_writes);
 		/*
 		 * We released zram_slot_lock so need to check if the slot was
 		 * changed. If there is freeing for the slot, we can catch it
@@ -775,6 +779,7 @@ static int read_from_bdev_sync(struct zram *zram, struct bio_vec *bvec,
 static int read_from_bdev(struct zram *zram, struct bio_vec *bvec,
 			unsigned long entry, struct bio *parent, bool sync)
 {
+	atomic64_inc(&zram->stats.bd_reads);
 	if (sync)
 		return read_from_bdev_sync(zram, bvec, entry, parent);
 	else
@@ -1031,6 +1036,25 @@ static ssize_t mm_stat_show(struct device *dev,
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
@@ -1051,6 +1075,9 @@ static ssize_t debug_stat_show(struct device *dev,
 
 static DEVICE_ATTR_RO(io_stat);
 static DEVICE_ATTR_RO(mm_stat);
+#ifdef CONFIG_ZRAM_WRITEBACK
+static DEVICE_ATTR_RO(bd_stat);
+#endif
 static DEVICE_ATTR_RO(debug_stat);
 
 static void zram_meta_free(struct zram *zram, u64 disksize)
@@ -1777,6 +1804,9 @@ static struct attribute *zram_disk_attrs[] = {
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
index 07695fe70e17..7cbb134fc0c9 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -82,6 +82,11 @@ struct zram_stats {
 	atomic_long_t max_used_pages;	/* no. of maximum pages stored */
 	atomic64_t writestall;		/* no. of write slow paths */
 	atomic64_t miss_free;		/* no. of missed free */
+#ifdef	CONFIG_ZRAM_WRITEBACK
+	atomic64_t bd_count;		/* no. of pages in backing device */
+	atomic64_t bd_reads;		/* no. of reads from backing device */
+	atomic64_t bd_writes;		/* no. of writes from backing device */
+#endif
 };
 
 struct zram {
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

