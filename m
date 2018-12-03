Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEEEC65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFAB208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cav2xOl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EFAB208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbeLCClR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 21:41:17 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38333 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbeLCClQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 21:41:16 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so5657515plb.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 18:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZZKbTI4RaupKgMeM0K0Oq1M7z4/V7WyolkpXJnj+pTI=;
        b=cav2xOl2U5quzY87ZAVIp8dYmdCfyEMnDLMIjvxnkLdmCNHN7Tm6MyAARS00xhcQTS
         ura5iAySKmHEYrCnXN6c8f/0bP8VwCScq+9UWhyFhnpgU7LpzJrNsXnxd0N2VXPVVTj0
         UyRc/yFjbHbPV6wBohjAaIIqzHj4Y7CrMEsw31K8dCduV3ws2r2ydXm2FJkuWLd2Qfro
         VVOR8LPL6SHYS5zWyAxLQykcFvOjCkogIr9PEHyfiL2bjOdX1TBdHgJcWv+5pK5YGxlp
         bR37H2Jgmoq3ydYJz85eq2jPNBHqBBAHYWIMfCmMQhGbGOStNYvq5pP2yj/NBBb6riFF
         5saQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZZKbTI4RaupKgMeM0K0Oq1M7z4/V7WyolkpXJnj+pTI=;
        b=akM1Bi1TUcBSHDU9nLjXVCeo+FKqEsV/eKD+IpMIkP49NHAko0MJ0rhuiBs5PIuI2E
         1jV39T24bMG127MTl6k42OI2NCMF2OfVamnPg7IIm3t1vZqU+uEGcTYcb+XLmmiicLFm
         Bzx2UIehbzH438oz+9KpZdQI9ezZ13qUq6DAOaskmVVd9l8B62DduYUyg525SR9mgwGw
         OEew/FyRc9/w4jHMDHe50ob+sUd+dD/Z1YLrzFGvsbYWwdgWthmt063CE8GZIvuaSIDz
         pnCre3Zb7pyyBxfiyDrwe6w6WyI9hWTjVNbCEmP9MmnGIoVpYnYL2QNy9Lafx5cCdxRP
         keeA==
X-Gm-Message-State: AA+aEWZ/1nw5TsnhBmwCYCyMYwW7dkveNUdlYnGV6ZtDPVC9vkWAWgEs
        q1DCvah3ceNa1S7Hk7bYW8I=
X-Google-Smtp-Source: AFSGD/XJWm7Bo3a0PyffJCPOhrP8OlKVl8ed/HzwAUosnVf2NeTQAYT8lGfIDxX0G+oAq0L96ma5BA==
X-Received: by 2002:a17:902:584:: with SMTP id f4mr14714663plf.28.1543804872441;
        Sun, 02 Dec 2018 18:41:12 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id z62sm18805864pfi.4.2018.12.02.18.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 18:41:11 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v4 6/7] zram: add bd_stat statistics
Date:   Mon,  3 Dec 2018 11:40:44 +0900
Message-Id: <20181203024045.153534-7-minchan@kernel.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181203024045.153534-1-minchan@kernel.org>
References: <20181203024045.153534-1-minchan@kernel.org>
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
 drivers/block/zram/zram_drv.c              | 29 ++++++++++++++++++++++
 drivers/block/zram/zram_drv.h              |  5 ++++
 4 files changed, 53 insertions(+)

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
index 806cdaabac83..906df97527a7 100644
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
+		Unit: 4K bytes
+ bd_reads	the number of reads from backing device
+		Unit: 4K bytes
+ bd_writes	the number of writes to backing device
+		Unit: 4K bytes
+
 9) Deactivate:
 	swapoff /dev/zram0
 	umount /dev/zram1
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6b5a886c8f32..f1832fa3ba41 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -502,6 +502,7 @@ static unsigned long alloc_block_bdev(struct zram *zram)
 	if (test_and_set_bit(blk_idx, zram->bitmap))
 		goto retry;
 
+	atomic64_inc(&zram->stats.bd_count);
 	return blk_idx;
 }
 
@@ -511,6 +512,7 @@ static void free_block_bdev(struct zram *zram, unsigned long blk_idx)
 
 	was_set = test_and_clear_bit(blk_idx, zram->bitmap);
 	WARN_ON_ONCE(!was_set);
+	atomic64_dec(&zram->stats.bd_count);
 }
 
 static void zram_page_end_io(struct bio *bio)
@@ -668,6 +670,7 @@ static ssize_t writeback_store(struct device *dev,
 			continue;
 		}
 
+		atomic64_inc(&zram->stats.bd_writes);
 		/*
 		 * We released zram_slot_lock so need to check if the slot was
 		 * changed. If there is freeing for the slot, we can catch it
@@ -757,6 +760,7 @@ static int read_from_bdev_sync(struct zram *zram, struct bio_vec *bvec,
 static int read_from_bdev(struct zram *zram, struct bio_vec *bvec,
 			unsigned long entry, struct bio *parent, bool sync)
 {
+	atomic64_inc(&zram->stats.bd_reads);
 	if (sync)
 		return read_from_bdev_sync(zram, bvec, entry, parent);
 	else
@@ -1013,6 +1017,25 @@ static ssize_t mm_stat_show(struct device *dev,
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
+		"%8llu %8llu %8llu\n",
+		(u64)atomic64_read(&zram->stats.bd_count) * (PAGE_SHIFT - 12),
+		(u64)atomic64_read(&zram->stats.bd_reads) * (PAGE_SHIFT - 12),
+		(u64)atomic64_read(&zram->stats.bd_writes) * (PAGE_SHIFT - 12));
+	up_read(&zram->init_lock);
+
+	return ret;
+}
+#endif
+
 static ssize_t debug_stat_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -1033,6 +1056,9 @@ static ssize_t debug_stat_show(struct device *dev,
 
 static DEVICE_ATTR_RO(io_stat);
 static DEVICE_ATTR_RO(mm_stat);
+#ifdef CONFIG_ZRAM_WRITEBACK
+static DEVICE_ATTR_RO(bd_stat);
+#endif
 static DEVICE_ATTR_RO(debug_stat);
 
 static void zram_meta_free(struct zram *zram, u64 disksize)
@@ -1759,6 +1785,9 @@ static struct attribute *zram_disk_attrs[] = {
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
index 1ad74f030b6d..bc477803530d 100644
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
2.20.0.rc1.387.gf8505762e3-goog

