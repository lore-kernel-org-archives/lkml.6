Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01695C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B219A20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwsR4VbB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B219A20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbeKZTWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:22:03 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41666 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeKZTWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:22:02 -0500
Received: by mail-pg1-f195.google.com with SMTP id 70so5815399pgh.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 00:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ie6UPVbn4gUhFwtUvkVfmGwTVsUs9odsxydRk/3pJ+0=;
        b=bwsR4VbBDeQ559PuhLJEWQ/uzBSPcI3lqvAKoomG/+NDbSIkFTT/sYWaf57sEIvvz2
         IggBwiETlUtqrXFMd703WJO4zAkt790pNgIC/4GkYw0QGdeL6ChJZJKPvHWcqLFVVSIy
         M7nQ7Zva71BsCvp6w00hk/hgtKOplbJ8gkdtbkD3sJXypZoOr/rrWmG96agni/lqvovI
         QP6HLdHhu9yhw/PDRIEfB4cmZrbej4SHDzYzgnPPHt9De/ynsNDnBKBt2+aBwgKYHM3O
         9C+clmvPLq9M7mXhmXK1/Eyh3tbMa9vqZe4BQNRa4EGmSROJJzRIZaYQluIcXbV9Yxuh
         HV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Ie6UPVbn4gUhFwtUvkVfmGwTVsUs9odsxydRk/3pJ+0=;
        b=C7F8WmtjHXIGvxfD0YGx6Mxy/uGRIidVSDksJPH55zwzcXTVJvm5G/Qdt1M0kAHbOi
         ArKmySZadH+MGSqaL/8zdZh+XmDawChZX7VEpDwgzV9MJHibhgzoMcvAjH4JoJtpMyFN
         SSWahWC/sO1qN6Wlwg1cDewxZ/PZxZ+ZJ1aW/6FDGbfsuAMxEcpdP8B2SXJxX25iXSyy
         99GuzYIPctV3ygoZuvj3Y5dH3T1fDWHWptgdVNwYv/y+oump1rmA350rrcgDTbrvJY7n
         35CnT/aBbLKfbzLpO4IoGQPrqkSGgK8gst0mOcstGBRNpQUpZyx34nyWNTHf6RQqg+N4
         772Q==
X-Gm-Message-State: AA+aEWYcaC/FGFcy5qJ6rLB20CSCI3icLN8TiqAw86lHItQL8E1MlBL8
        M7A/IEbn4c5cDlbDCZBz7H8=
X-Google-Smtp-Source: AFSGD/Xf6NDPFVoOJON9UMSUVlXGUlgiAXQQgjbNI90/kuXAbhQpYzIcQLySoqkPNChJtp827ElS1w==
X-Received: by 2002:a63:f047:: with SMTP id s7mr23786929pgj.441.1543220920302;
        Mon, 26 Nov 2018 00:28:40 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id j197sm82846611pgc.76.2018.11.26.00.28.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 00:28:39 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 7/7] zram: writeback throttle
Date:   Mon, 26 Nov 2018 17:28:13 +0900
Message-Id: <20181126082813.81977-8-minchan@kernel.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181126082813.81977-1-minchan@kernel.org>
References: <20181126082813.81977-1-minchan@kernel.org>
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
index 550bca77d322..41748d52712d 100644
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
index cceaa10301e8..07c0847b7c0f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -328,6 +328,40 @@ static ssize_t idle_store(struct device *dev,
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
@@ -592,6 +626,7 @@ static ssize_t writeback_store(struct device *dev,
 	char mode_buf[64];
 	unsigned long mode = -1UL;
 	unsigned long blk_idx = 0;
+	u64 wb_count, wb_limit;
 
 	strlcpy(mode_buf, buf, sizeof(mode_buf));
 	/* ignore trailing newline */
@@ -631,6 +666,11 @@ static ssize_t writeback_store(struct device *dev,
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
@@ -689,7 +729,7 @@ static ssize_t writeback_store(struct device *dev,
 			continue;
 		}
 
-		atomic64_inc(&zram->stats.bd_writes);
+		wb_count = atomic64_inc_return(&zram->stats.bd_writes);
 		/*
 		 * We released zram_slot_lock so need to check if the slot was
 		 * changed. If there is freeing for the slot, we can catch it
@@ -713,6 +753,9 @@ static ssize_t writeback_store(struct device *dev,
 		zram_set_element(zram, index, blk_idx);
 		blk_idx = 0;
 		atomic64_inc(&zram->stats.pages_stored);
+		wb_limit = atomic64_read(&zram->stats.bd_wb_limit);
+		if (wb_limit != 0 && wb_count >= wb_limit)
+			zram->stop_writeback = true;
 next:
 		zram_slot_unlock(zram, index);
 	}
@@ -1786,6 +1829,7 @@ static DEVICE_ATTR_RW(comp_algorithm);
 #ifdef CONFIG_ZRAM_WRITEBACK
 static DEVICE_ATTR_RW(backing_dev);
 static DEVICE_ATTR_WO(writeback);
+static DEVICE_ATTR_RW(writeback_limit);
 #endif
 
 static struct attribute *zram_disk_attrs[] = {
@@ -1801,6 +1845,7 @@ static struct attribute *zram_disk_attrs[] = {
 #ifdef CONFIG_ZRAM_WRITEBACK
 	&dev_attr_backing_dev.attr,
 	&dev_attr_writeback.attr,
+	&dev_attr_writeback_limit.attr,
 #endif
 	&dev_attr_io_stat.attr,
 	&dev_attr_mm_stat.attr,
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 7cbb134fc0c9..024044e82c9b 100644
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

