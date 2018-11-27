Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877C8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 05:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D22820873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 05:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/4TogNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D22820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbeK0Qw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 11:52:27 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44128 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbeK0Qw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 11:52:26 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so7324336pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 21:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xafR/Nsxenm54c8kvXBtutIk9U7sjaDwl3Jg2m9Nlto=;
        b=O/4TogNMwtsIMKu1JkH41ZPvxzPecm8lB0spGLKkYH1a0J9rRi+YhgvqeNpq8TkK0+
         JkQ+06APOvnYbxyUNHj1x91J8VwRRyzdf0IzvLx8SLIChmdwOGWiMy9DtdtGc9DR7lgv
         jl5vwf/FKIRZRP69k21zhuBPPL5ZjYM3ZFoMfiuwMje7t4oLttfK9+pYGj8NbsUoBHc8
         Kz+iK+WoRkiSJNMQ8yYwhW93QKM0xTZoyONAmKiREhCKtOfo/a42B7I6wbdedG9wIg8B
         y3oR33VFmQif4XN7NhtOmA8Egdv14TomzSUZqnkGfQrW3z/oOWQ46/uCDBvFp8HKCbxP
         0RkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xafR/Nsxenm54c8kvXBtutIk9U7sjaDwl3Jg2m9Nlto=;
        b=mMzk27YymVTDvWzwE2DzZn8dd3LZtEBYnV72cI4S48ClGxx9lSlZ4EghUkTEy1P0/5
         Ra1atIWWOQXzTs9AmmczRzC/IFc9l1STBKXW7gKKjuwhc+1Yh6QM98PGMgnG//bf9E7R
         x4KF+vYP20eS5f5yA0DIUU0KaS6p2WySUQc/aoYRn390GruRlj7+kdWoJCf8p6Pw0oD+
         BCRQIU0EndWr2ag6t/HjOjEXJPw3s6/cWBzfO3c87psbcktkNLaR2viA5TGMhyPOk9g3
         3XOJgm6H0u55n7NS59/ZjspKXRa33gd3LJCUc3j+p0l5zNHl5zwwwmjqPKFU4Ano5uNm
         wMNg==
X-Gm-Message-State: AA+aEWZGh9rfgPuoHdBgdxK9Cwd+Qp0i07aUJ+gbSpOD493ACScXDzmB
        vu8VBX8fU3fhKC0abFhbqu8=
X-Google-Smtp-Source: AFSGD/VgfjniVnGfftNUvUdjrzt7JSfpOKXoY2prze7/2qgdI5eU/Z4gjA0KBIwQbyOZftmShftPxg==
X-Received: by 2002:a62:5ec5:: with SMTP id s188mr9003255pfb.145.1543298141199;
        Mon, 26 Nov 2018 21:55:41 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id f32sm2580203pgf.80.2018.11.26.21.55.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 21:55:40 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH v3 4/7] zram: introduce ZRAM_IDLE flag
Date:   Tue, 27 Nov 2018 14:54:26 +0900
Message-Id: <20181127055429.251614-5-minchan@kernel.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181127055429.251614-1-minchan@kernel.org>
References: <20181127055429.251614-1-minchan@kernel.org>
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
 Documentation/ABI/testing/sysfs-block-zram |  8 +++
 Documentation/blockdev/zram.txt            | 10 ++--
 drivers/block/zram/zram_drv.c              | 57 ++++++++++++++++++++--
 drivers/block/zram/zram_drv.h              |  1 +
 4 files changed, 69 insertions(+), 7 deletions(-)

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
index 4457d0395bfb..180613b478a6 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -281,6 +281,47 @@ static ssize_t mem_used_max_store(struct device *dev,
 	return len;
 }
 
+static ssize_t idle_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
+	int index;
+	char mode_buf[8];
+	ssize_t sz;
+
+	sz = strscpy(mode_buf, buf, sizeof(mode_buf));
+	if (sz <= 0)
+		return -EINVAL;
+
+	/* ignore trailing new line */
+	if (mode_buf[sz - 1] == '\n')
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
@@ -638,6 +679,7 @@ static void zram_debugfs_destroy(void)
 
 static void zram_accessed(struct zram *zram, u32 index)
 {
+	zram_clear_flag(zram, index, ZRAM_IDLE);
 	zram->table[index].ac_time = ktime_get_boottime();
 }
 
@@ -670,12 +712,13 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 
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
@@ -720,7 +763,10 @@ static void zram_debugfs_unregister(struct zram *zram)
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
@@ -924,6 +970,9 @@ static void zram_free_page(struct zram *zram, size_t index)
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
 	zram->table[index].ac_time = 0;
 #endif
+	if (zram_test_flag(zram, index, ZRAM_IDLE))
+		zram_clear_flag(zram, index, ZRAM_IDLE);
+
 	if (zram_test_flag(zram, index, ZRAM_HUGE)) {
 		zram_clear_flag(zram, index, ZRAM_HUGE);
 		atomic64_dec(&zram->stats.huge_pages);
@@ -1589,6 +1638,7 @@ static DEVICE_ATTR_RO(initstate);
 static DEVICE_ATTR_WO(reset);
 static DEVICE_ATTR_WO(mem_limit);
 static DEVICE_ATTR_WO(mem_used_max);
+static DEVICE_ATTR_WO(idle);
 static DEVICE_ATTR_RW(max_comp_streams);
 static DEVICE_ATTR_RW(comp_algorithm);
 #ifdef CONFIG_ZRAM_WRITEBACK
@@ -1602,6 +1652,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_compact.attr,
 	&dev_attr_mem_limit.attr,
 	&dev_attr_mem_used_max.attr,
+	&dev_attr_idle.attr,
 	&dev_attr_max_comp_streams.attr,
 	&dev_attr_comp_algorithm.attr,
 #ifdef CONFIG_ZRAM_WRITEBACK
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 4f83f1f14b0a..a84611b97867 100644
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

