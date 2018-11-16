Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B23C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCDFC208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gu9tjyjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCDFC208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389426AbeKPRcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 12:32:02 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40180 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389319AbeKPRcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 12:32:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id x2-v6so10965911pfm.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 23:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2SgFFfCW14B0ZBBYcCf+kXAx7IpfThxhmLkgDogoCXA=;
        b=Gu9tjyjAmx7cxK56GxEC8dG8avPP6DNiNPmEY4DbxtIPmNDbfjcMTB6CJR1liDtM1k
         +0NPQes17MHYPZwOfzsYRRLnZdqBZy56NZM411Sw15jn09hOOF/aKCW5HgrwW6fkXMzQ
         m4KWruvKzijg9PWV9ABXdVMHIAiUszAoCDU9ki8+3qyuptZA9ym7aLwt/epbH7sOny7U
         SIo+3EsArzZ814ODqs7jwMI3Yx+aoNBaJKOb7KRYefZ3sz92aTnn0Zbct1dk70BNl5gL
         WAj7xuKqZPxIJOuE/zGZvozEf1ZofYQ5hniZLbZctsGq8pGopLyiOADwYlj5AUFExwpk
         kTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2SgFFfCW14B0ZBBYcCf+kXAx7IpfThxhmLkgDogoCXA=;
        b=Srr2bqDSES4EUXz1TNbfr78TY3mRkOBgjC8fCnEBVgB6HkC5y13MvD+8nulsFx8jrc
         iZ38QY6OpvZdcw43qqx0gcdXLSAU0qhK/ah6laelPN2atPFO1xwnYb1gBxk/MR7ojyqz
         ECzGEyGdEE7feaMmL044lx/A1AdEeFfJzh1rkzpsrSwjB16jdPjrhdSvT+vlcQrKUos7
         D0RgL1jEODl+LB4cgv18nUFsNtnxZZm8pWCipEf7Z5JS5puldkahH8eAbAIaE5cTXIXa
         hg+FgSL9JoYqi3hzuPSdCkfYLzX5vLkPlVclZojytBH9+O/5Wn+1MMAlyOn0pmqzrTW+
         vPhw==
X-Gm-Message-State: AGRZ1gKIr8zhROKmf8JvysdApko/MpYbKLtq6E9iG+OOCUmiL+BsWMNS
        IMwnyPqULrS6T6ELwTwebGQ=
X-Google-Smtp-Source: AJdET5f1Y26Srh5qgGymClmh9ltrhu7ellsvWZ0FDocO1Kcy0BNloV4djpzmlDJ+biK35y8eNIAVhw==
X-Received: by 2002:a62:198c:: with SMTP id 134-v6mr9912896pfz.33.1542352850831;
        Thu, 15 Nov 2018 23:20:50 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:7630:de9:f6f2:276f])
        by smtp.gmail.com with ESMTPSA id e9sm13974637pff.5.2018.11.15.23.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 23:20:49 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH 3/6] zram: introduce ZRAM_IDLE flag
Date:   Fri, 16 Nov 2018 16:20:32 +0900
Message-Id: <20181116072035.155108-4-minchan@kernel.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
In-Reply-To: <20181116072035.155108-1-minchan@kernel.org>
References: <20181116072035.155108-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support idle page writeback with upcoming patches, this patch
introduces a new ZRAM_IDLE flag.

Userspace can mark zram slots as "idle" via
	"echo 1 > /sys/block/zramX/idle"
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
 Documentation/blockdev/zram.txt            | 10 +++--
 drivers/block/zram/zram_drv.c              | 44 ++++++++++++++++++++--
 drivers/block/zram/zram_drv.h              |  1 +
 4 files changed, 56 insertions(+), 7 deletions(-)

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
index bc59db2b1036..f956179076ce 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -281,6 +281,34 @@ static ssize_t mem_used_max_store(struct device *dev,
 	return len;
 }
 
+static ssize_t idle_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	int index;
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
@@ -658,6 +686,7 @@ static void zram_debugfs_destroy(void)
 
 static void zram_accessed(struct zram *zram, u32 index)
 {
+	zram_clear_flag(zram, index, ZRAM_IDLE);
 	zram->table[index].ac_time = ktime_get_boottime();
 }
 
@@ -690,12 +719,13 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 
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
@@ -740,7 +770,10 @@ static void zram_debugfs_unregister(struct zram *zram)
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
@@ -944,6 +977,9 @@ static void zram_free_page(struct zram *zram, size_t index)
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
 	zram->table[index].ac_time = 0;
 #endif
+	if (zram_test_flag(zram, index, ZRAM_IDLE))
+		zram_clear_flag(zram, index, ZRAM_IDLE);
+
 	if (zram_test_flag(zram, index, ZRAM_HUGE)) {
 		zram_clear_flag(zram, index, ZRAM_HUGE);
 		atomic64_dec(&zram->stats.huge_pages);
@@ -1609,6 +1645,7 @@ static DEVICE_ATTR_RO(initstate);
 static DEVICE_ATTR_WO(reset);
 static DEVICE_ATTR_WO(mem_limit);
 static DEVICE_ATTR_WO(mem_used_max);
+static DEVICE_ATTR_WO(idle);
 static DEVICE_ATTR_RW(max_comp_streams);
 static DEVICE_ATTR_RW(comp_algorithm);
 #ifdef CONFIG_ZRAM_WRITEBACK
@@ -1622,6 +1659,7 @@ static struct attribute *zram_disk_attrs[] = {
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
2.19.1.1215.g8438c0b245-goog

