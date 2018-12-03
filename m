Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90405C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43716208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 02:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rG4da5ne"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43716208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbeLCClU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 21:41:20 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46404 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbeLCClT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 21:41:19 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so5553622pfe.13
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 18:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Plp9sS9gHE/ZeUa5h5ej6xtYSbjwCZQGUmIpDWiAys=;
        b=rG4da5neLafmpLt+dC3pJ4qd/2OOxvelz2SfEHyz3TDfsS6UWm/9C5otw44fbjwJnn
         8o5uTBPrj7ju7hXvAITqmc0s8q9czi5NKsdiHuYOlIQXzQBo87YgQ1QxgHgmL6MmLjrc
         5gUc/xtwFRewENBePG2QHi4J5Vxr873gWzoqdcdcQ4VrIWZV5Nt02kJYee7z4IUqEsAQ
         ceiJjh7BZsudix4dNLYENEgLtTDbW0Eu+tzhCP2WybbPRaWZ0twsk7dSOBX54olUnuH9
         aQB9Jh2Iperl5lSfJxfoo5e5U7b6vqWG5Bf6PJ1vjXJTayzL9wx5WHFsedL3L2rByZrk
         Q6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3Plp9sS9gHE/ZeUa5h5ej6xtYSbjwCZQGUmIpDWiAys=;
        b=bZFv8xsM6XFmjhfkIGwlbdo472AninxrVukAp/b1WVvtlwCREWB5mHqDv3lycmEHh5
         yy9T0PXzF/tdXffO7znNjirLve3GX2ri7TMZPd/7kvK9VLvdAMrD4Mve3tAIRa/b8++J
         eso9GLSiXYzDdpAdZnsv3hxbTaSD5ME9lfbbSQmkWoeeypsH0JVlC0oMvGy0S6PdZpl9
         phIxCnwI+4Vn91rELzc/ruSAybHGBik3G6bjGIvGvaEd0fSI0tc2SxjX/NB3j4RNFx1R
         6oceOyAFxFf8/svy0QKopmSw1Tuzf5pHtQEuGrKTBbBW9OHrk2E/OrIX1e5RqsldeZeX
         iDFA==
X-Gm-Message-State: AA+aEWZucCBNK3n4S24fPPzp4Omb5yCFQsTI/ooOaFakOJRS03veSiLo
        rL2hTPgTtJcDe2IovuD+z9JeI//siq0=
X-Google-Smtp-Source: AFSGD/WBVzajfLzq2NLRgVgBJf5UB73uidBB58wdFkLm1YtaCRKxIAQzz55PsxDBBuIHc8YBC37exg==
X-Received: by 2002:a63:cd17:: with SMTP id i23mr11743682pgg.13.1543804875140;
        Sun, 02 Dec 2018 18:41:15 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id z62sm18805864pfi.4.2018.12.02.18.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 18:41:14 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v4 7/7] zram: writeback throttle
Date:   Mon,  3 Dec 2018 11:40:45 +0900
Message-Id: <20181203024045.153534-8-minchan@kernel.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181203024045.153534-1-minchan@kernel.org>
References: <20181203024045.153534-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there are lots of write IO with flash device, it could have a
wearout problem of storage. To overcome the problem, admin needs
to design write limitation to guarantee flash health
for entire product life.

This patch creates a new knob "writeback_limit" on zram.

writeback_limit's default value is 0 so that it doesn't limit
any writeback. If admin want to measure writeback count in a
certain period, he could know it via /sys/block/zram0/bd_stat's
3rd column.

If admin want to limit writeback as per-day 400M, he could do it
like below.

	MB_SHIFT=20
	4K_SHIFT=12
	echo $((400<<MB_SHIFT>>4K_SHIFT)) > \
		/sys/block/zram0/writeback_limit.

If admin want to allow further write again, he could do it like below

	echo 0 > /sys/block/zram0/writeback_limit

If admin want to see remaining writeback budget,

	cat /sys/block/zram0/writeback_limit

The writeback_limit count will reset whenever you reset zram(e.g.,
system reboot, echo 1 > /sys/block/zramX/reset) so keeping how many of
writeback happened until you reset the zram to allocate extra writeback
budget in next setting is user's job.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---

I removed Reviewed-by from Sergey and Joey because I modified interface
since they had reviewed.

 Documentation/ABI/testing/sysfs-block-zram |  9 ++++
 Documentation/blockdev/zram.txt            | 31 +++++++++++++
 drivers/block/zram/zram_drv.c              | 52 ++++++++++++++++++++--
 drivers/block/zram/zram_drv.h              |  2 +
 4 files changed, 91 insertions(+), 3 deletions(-)

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
index 906df97527a7..436c5e98e1b6 100644
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
@@ -275,6 +277,35 @@ Admin can request writeback of those idle pages at right timing via
 
 With the command, zram writeback idle pages from memory to the storage.
 
+If there are lots of write IO with flash device, potentially, it has
+flash wearout problem so that admin needs to design write limitation
+to guarantee storage health for entire product life.
+To overcome the concern, zram supports "writeback_limit".
+The "writeback_limit"'s default value is 0 so that it doesn't limit
+any writeback. If admin want to measure writeback count in a certain
+period, he could know it via /sys/block/zram0/bd_stat's 3rd column.
+
+If admin want to limit writeback as per-day 400M, he could do it
+like below.
+
+    MB_SHIFT=20
+    4K_SHIFT=12
+    echo $((400<<MB_SHIFT>>4K_SHIFT)) > \
+	    /sys/block/zram0/writeback_limit.
+
+If admin want to allow further write again, he could do it like below
+
+    echo 0 > /sys/block/zram0/writeback_limit
+
+If admin want to see remaining writeback budget since he set,
+
+    cat /sys/block/zram0/writeback_limit
+
+The writeback_limit count will reset whenever you reset zram(e.g.,
+system reboot, echo 1 > /sys/block/zramX/reset) so keeping how many of
+writeback happened until you reset the zram to allocate extra writeback
+budget in next setting is user's job.
+
 = memory tracking
 
 With CONFIG_ZRAM_MEMORY_TRACKING, user can know information of the
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f1832fa3ba41..33c5cc879f24 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -330,6 +330,39 @@ static ssize_t idle_store(struct device *dev,
 }
 
 #ifdef CONFIG_ZRAM_WRITEBACK
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
+	if (val == 0)
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
@@ -612,6 +645,11 @@ static ssize_t writeback_store(struct device *dev,
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
@@ -694,6 +732,11 @@ static ssize_t writeback_store(struct device *dev,
 		zram_set_element(zram, index, blk_idx);
 		blk_idx = 0;
 		atomic64_inc(&zram->stats.pages_stored);
+		if (atomic64_add_unless(&zram->stats.bd_wb_limit,
+					-1 << (PAGE_SHIFT - 12), 0)) {
+			if (atomic64_read(&zram->stats.bd_wb_limit) == 0)
+				zram->stop_writeback = true;
+		}
 next:
 		zram_slot_unlock(zram, index);
 	}
@@ -1018,6 +1061,7 @@ static ssize_t mm_stat_show(struct device *dev,
 }
 
 #ifdef CONFIG_ZRAM_WRITEBACK
+#define FOUR_K(x) ((x) * (1 << (PAGE_SHIFT - 12)))
 static ssize_t bd_stat_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -1027,9 +1071,9 @@ static ssize_t bd_stat_show(struct device *dev,
 	down_read(&zram->init_lock);
 	ret = scnprintf(buf, PAGE_SIZE,
 		"%8llu %8llu %8llu\n",
-		(u64)atomic64_read(&zram->stats.bd_count) * (PAGE_SHIFT - 12),
-		(u64)atomic64_read(&zram->stats.bd_reads) * (PAGE_SHIFT - 12),
-		(u64)atomic64_read(&zram->stats.bd_writes) * (PAGE_SHIFT - 12));
+			FOUR_K((u64)atomic64_read(&zram->stats.bd_count)),
+			FOUR_K((u64)atomic64_read(&zram->stats.bd_reads)),
+			FOUR_K((u64)atomic64_read(&zram->stats.bd_writes)));
 	up_read(&zram->init_lock);
 
 	return ret;
@@ -1767,6 +1811,7 @@ static DEVICE_ATTR_RW(comp_algorithm);
 #ifdef CONFIG_ZRAM_WRITEBACK
 static DEVICE_ATTR_RW(backing_dev);
 static DEVICE_ATTR_WO(writeback);
+static DEVICE_ATTR_RW(writeback_limit);
 #endif
 
 static struct attribute *zram_disk_attrs[] = {
@@ -1782,6 +1827,7 @@ static struct attribute *zram_disk_attrs[] = {
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
2.20.0.rc1.387.gf8505762e3-goog

