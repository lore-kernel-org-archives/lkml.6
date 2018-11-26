Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0985CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EDA20672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQ/g9OD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0EDA20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbeKZTV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:21:57 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35353 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeKZTV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:21:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so6221786pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 00:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XikUJSYCqMAqYBnHRFn+fjrwiBCPE49KgEvLOilmY78=;
        b=UQ/g9OD/QQfM1nDif6Do/z69YCL6QsLP0fbUgaf7l0UUinCp4CddoC18pks2E0wq4R
         whhNXZ32qdKAt379saD4RRMxAKwCzbgJtqR6E4mhXrkSt0zFb/4NSemRUXB5gJkQ3RXq
         v3aFi+RvNuQ6ShwcdbIN3z9huaGtmrrCEcQEYIR4B1JL7eneI1Bi7cyBYn8Pz41YtRxf
         JhY3QXT1H6ZF3TsDiv8Xp2Hm+kMqThA7gTuERNFxeVCN7fLrHMFLk+leguYITGSwWvKw
         Z6gcCOG1D6YbXbB5JyyoCq4U8wD/fgxVyrHSuwJu1TpWpyHB32tViHhq+AXW8PDB4Cf5
         uvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XikUJSYCqMAqYBnHRFn+fjrwiBCPE49KgEvLOilmY78=;
        b=pAD+BqoSXc9vdZIcdNlKVWuksFrvb5iGlZpPuvX30gmaBnpiUTGiBMzNiv9hn2xoP4
         tcsQ5ByRXYgPmECqBaXP5msapYr4gbSJOHZTyHh3zcTbuNFOqxFgPlU14nCGhG4m2SUm
         4dtCXybaNqKGcrrEccCHrZF4QLVULYViRP1elaUNjKHo8aEjI996UbhmkyVg/VNMfAiX
         cU+rVpBZzr5N3bheWj1MQpH8MnuFGun3SPleuJ8BCrWXZjWjpF272T3JnuirLcydZE5x
         9VQuk+oWcHGGxEh4sV6dta7+0cN7tJ8+fv/WBjUcQN2AlHYM3Dl04Y+3OgjTTjDo2FvE
         lSWw==
X-Gm-Message-State: AA+aEWY8PeEa+AqNhuzKixIiLGqI2oRu5H9vjKRwsmKvsrv0xia/LMs7
        JBfCBBimQoKHb0K+rt0qX18=
X-Google-Smtp-Source: AJdET5dZJCScLrNbHFi5m7fY8tevN+FOJBFf9f/QMGohGGKf/McVA34CoEoa4rCU78JnAMN8wqLCJA==
X-Received: by 2002:a65:6542:: with SMTP id a2mr23682667pgw.389.1543220912816;
        Mon, 26 Nov 2018 00:28:32 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id j197sm82846611pgc.76.2018.11.26.00.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 00:28:31 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v2 4/7] zram: introduce ZRAM_IDLE flag
Date:   Mon, 26 Nov 2018 17:28:10 +0900
Message-Id: <20181126082813.81977-5-minchan@kernel.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181126082813.81977-1-minchan@kernel.org>
References: <20181126082813.81977-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support idle page writeback with upcoming patches, this patch
introduces a new ZRAM_IDLE flag.

Userspace can mark zram slots as "idle" via
	"echo all > /sys/block/zramX/idle"
which marks every allocated zram slot as ZRAM_IDLE.
User could see it by /sys/kernel/debug/zram/zram0/block_state.

          300    75.033841 ...i
          301    63.806904 s..i
          302    63.806919 ..hi

Once there is IO for the slot, the mark will be disappeared.

	  300    75.033841 ...
          301    63.806904 s..i
          302    63.806919 ..hi

Therefore, 300th block is idle zpage. With this feature,
user can how many zram has idle pages which are waste of memory.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 Documentation/ABI/testing/sysfs-block-zram |  8 ++++
 Documentation/blockdev/zram.txt            | 10 ++--
 drivers/block/zram/zram_drv.c              | 55 ++++++++++++++++++++--
 drivers/block/zram/zram_drv.h              |  1 +
 4 files changed, 67 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-block-zram b/Documentation/ABI/testing/sysfs-block-zram
index c1513c756af1..04c9a5980bc7 100644
--- a/Documentation/ABI/testing/sysfs-block-zram
+++ b/Documentation/ABI/testing/sysfs-block-zram
@@ -98,3 +98,11 @@ Contact:	Minchan Kim <minchan@kernel.org>
 		The backing_dev file is read-write and set up backing
 		device for zram to write incompressible pages.
 		For using, user should enable CONFIG_ZRAM_WRITEBACK.
+
+What:		/sys/block/zram<id>/idle
+Date:		November 2018
+Contact:	Minchan Kim <minchan@kernel.org>
+Description:
+		idle file is write-only and mark zram slot as idle.
+		If system has mounted debugfs, user can see which slots
+		are idle via /sys/kernel/debug/zram/zram<id>/block_state
diff --git a/Documentation/blockdev/zram.txt b/Documentation/blockdev/zram.txt
index 3c1b5ab54bc0..f3bcd716d8a9 100644
--- a/Documentation/blockdev/zram.txt
+++ b/Documentation/blockdev/zram.txt
@@ -169,6 +169,7 @@ comp_algorithm    RW    show and change the compression algorithm
 compact           WO    trigger memory compaction
 debug_stat        RO    this file is used for zram debugging purposes
 backing_dev	  RW	set up backend storage for zram to write out
+idle		  WO	mark allocated slot as idle
 
 
 User space is advised to use the following files to read the device statistics.
@@ -251,16 +252,17 @@ pages of the process with*pagemap.
 If you enable the feature, you could see block state via
 /sys/kernel/debug/zram/zram0/block_state". The output is as follows,
 
-	  300    75.033841 .wh
-	  301    63.806904 s..
-	  302    63.806919 ..h
+	  300    75.033841 .wh.
+	  301    63.806904 s...
+	  302    63.806919 ..hi
 
 First column is zram's block index.
 Second column is access time since the system was booted
 Third column is state of the block.
 (s: same page
 w: written page to backing store
-h: huge page)
+h: huge page
+i: idle page)
 
 First line of above example says 300th block is accessed at 75.033841sec
 and the block's state is huge so it is written back to the backing
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fee7e67c750d..59f78011d2d9 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -281,6 +281,45 @@ static ssize_t mem_used_max_store(struct device *dev,
 	return len;
 }
 
+static ssize_t idle_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	int index;
+	char mode_buf[64];
+	ssize_t sz;
+
+	strlcpy(mode_buf, buf, sizeof(mode_buf));
+	/* ignore trailing new line */
+	sz = strlen(mode_buf);
+	if (sz > 0 && mode_buf[sz - 1] == '\n')
+		mode_buf[sz - 1] = 0x00;
+
+	if (strcmp(mode_buf, "all"))
+		return -EINVAL;
+
+	down_read(&zram->init_lock);
+	if (!init_done(zram)) {
+		up_read(&zram->init_lock);
+		return -EINVAL;
+	}
+
+	for (index = 0; index < nr_pages; index++) {
+		zram_slot_lock(zram, index);
+		if (!zram_allocated(zram, index))
+			goto next;
+
+		zram_set_flag(zram, index, ZRAM_IDLE);
+next:
+		zram_slot_unlock(zram, index);
+	}
+
+	up_read(&zram->init_lock);
+
+	return len;
+}
+
 #ifdef CONFIG_ZRAM_WRITEBACK
 static void reset_bdev(struct zram *zram)
 {
@@ -660,6 +699,7 @@ static void zram_debugfs_destroy(void)
 
 static void zram_accessed(struct zram *zram, u32 index)
 {
+	zram_clear_flag(zram, index, ZRAM_IDLE);
 	zram->table[index].ac_time = ktime_get_boottime();
 }
 
@@ -692,12 +732,13 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 
 		ts = ktime_to_timespec64(zram->table[index].ac_time);
 		copied = snprintf(kbuf + written, count,
-			"%12zd %12lld.%06lu %c%c%c\n",
+			"%12zd %12lld.%06lu %c%c%c%c\n",
 			index, (s64)ts.tv_sec,
 			ts.tv_nsec / NSEC_PER_USEC,
 			zram_test_flag(zram, index, ZRAM_SAME) ? 's' : '.',
 			zram_test_flag(zram, index, ZRAM_WB) ? 'w' : '.',
-			zram_test_flag(zram, index, ZRAM_HUGE) ? 'h' : '.');
+			zram_test_flag(zram, index, ZRAM_HUGE) ? 'h' : '.',
+			zram_test_flag(zram, index, ZRAM_IDLE) ? 'i' : '.');
 
 		if (count < copied) {
 			zram_slot_unlock(zram, index);
@@ -742,7 +783,10 @@ static void zram_debugfs_unregister(struct zram *zram)
 #else
 static void zram_debugfs_create(void) {};
 static void zram_debugfs_destroy(void) {};
-static void zram_accessed(struct zram *zram, u32 index) {};
+static void zram_accessed(struct zram *zram, u32 index)
+{
+	zram_clear_flag(zram, index, ZRAM_IDLE);
+};
 static void zram_debugfs_register(struct zram *zram) {};
 static void zram_debugfs_unregister(struct zram *zram) {};
 #endif
@@ -946,6 +990,9 @@ static void zram_free_page(struct zram *zram, size_t index)
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
 	zram->table[index].ac_time = 0;
 #endif
+	if (zram_test_flag(zram, index, ZRAM_IDLE))
+		zram_clear_flag(zram, index, ZRAM_IDLE);
+
 	if (zram_test_flag(zram, index, ZRAM_HUGE)) {
 		zram_clear_flag(zram, index, ZRAM_HUGE);
 		atomic64_dec(&zram->stats.huge_pages);
@@ -1611,6 +1658,7 @@ static DEVICE_ATTR_RO(initstate);
 static DEVICE_ATTR_WO(reset);
 static DEVICE_ATTR_WO(mem_limit);
 static DEVICE_ATTR_WO(mem_used_max);
+static DEVICE_ATTR_WO(idle);
 static DEVICE_ATTR_RW(max_comp_streams);
 static DEVICE_ATTR_RW(comp_algorithm);
 #ifdef CONFIG_ZRAM_WRITEBACK
@@ -1624,6 +1672,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_compact.attr,
 	&dev_attr_mem_limit.attr,
 	&dev_attr_mem_used_max.attr,
+	&dev_attr_idle.attr,
 	&dev_attr_max_comp_streams.attr,
 	&dev_attr_comp_algorithm.attr,
 #ifdef CONFIG_ZRAM_WRITEBACK
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index d75bf190f262..214fa4bb46b9 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -48,6 +48,7 @@ enum zram_pageflags {
 	ZRAM_SAME,	/* Page consists the same element */
 	ZRAM_WB,	/* page is stored on backing_device */
 	ZRAM_HUGE,	/* Incompressible page */
+	ZRAM_IDLE,	/* not accessed page since last idle marking */
 
 	__NR_ZRAM_PAGEFLAGS,
 };
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

