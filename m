Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2D6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2061520672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+QpkHIw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2061520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeKZTVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:21:47 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33581 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbeKZTVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:21:47 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so13523221plo.0;
        Mon, 26 Nov 2018 00:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gIXZ6+6b7JWytYBum89XOoPuSyuoolyetOMPk/bolfc=;
        b=F+QpkHIw/1aEqAxDkMSqTH+KH3W35Zkqf5eQQNQoFCvrWWK2YR3kN44Mldc6M6g6Jm
         I60fLgHhaLKJ1qY97As8tTRPnBhRY+Kb9M8CUk62Vd1jM4Bhqz0xrFn2bKOxiW4aU//u
         ug6O+P7RQThwSyf8U0oFEszv+zD25IYOWpBLlzj6j2LVHaqCr1WnO2yG6oINerfIzkYK
         Ju6dmz14A0gB4Bnk4VxBJ4B+sVVvfaPJNYbUZwXIY9kssjBqSyndi6WsYHXI9N0QjNHW
         qJhwKQ0C2dk2qwCkNFwr1OdVUlJFWRK9cROC1IP2F1i48tE4fUixZbx3mH2jepDN2Cl3
         lOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=gIXZ6+6b7JWytYBum89XOoPuSyuoolyetOMPk/bolfc=;
        b=KWA6UxMjQWp/Lt6ouO/MBVHPPqORx3ZFUFXDh8Rh3ITmwh4WFv5tO5uc8I4NruNxLt
         2dI31W/3sJsa3Xt8K/WMZz3R6FeXe0u7Qe0aEKRG51HvCNdL/tFfJ0zVFOnhGBjVstF5
         drWPV4jmxN2kagGDXVJregq9l5u2m6RwHyEPqZjS/DwRb95DT6PbU22+paGpx+lloXya
         3B8GD6rkSMXQ8u1gLkmk/XEGpES10yJJ2ekrvEHg4ltUn3T4l5pwj7T+MAHaHLAQAkls
         OcL3SejxvIbuVMvyUQgJUSzNgTmsDji59kz/0EqpwnZSFWAKZVlPBpaFFJqKeJjVT6pN
         nnOQ==
X-Gm-Message-State: AA+aEWYmP6Zc/1w2Wwzzyor9LAQXXaNYkUeHbOOhCUQ05nEEZjkJQjqv
        Q8Bo4goVFv6LoUMfklPkqpo=
X-Google-Smtp-Source: AFSGD/VLBfpSUOpSdZ2OjM7RN4ko+8uv10cImIJgfMqwzhAaS3r0kiBjQwQVZ1ytCYeB2Pp24cJR3Q==
X-Received: by 2002:a17:902:29ab:: with SMTP id h40mr26546337plb.238.1543220904263;
        Mon, 26 Nov 2018 00:28:24 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id j197sm82846611pgc.76.2018.11.26.00.28.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 00:28:23 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Minchan Kim <minchan@kernel.org>, stable@vger.kernel.org
Subject: [PATCH v2 1/7] zram: fix lockdep warning of free block handling
Date:   Mon, 26 Nov 2018 17:28:07 +0900
Message-Id: <20181126082813.81977-2-minchan@kernel.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181126082813.81977-1-minchan@kernel.org>
References: <20181126082813.81977-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[  254.519728] ================================
[  254.520311] WARNING: inconsistent lock state
[  254.520898] 4.19.0+ #390 Not tainted
[  254.521387] --------------------------------
[  254.521732] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
[  254.521732] zram_verify/2095 [HC0[0]:SC1[1]:HE1:SE0] takes:
[  254.521732] 00000000b1828693 (&(&zram->bitmap_lock)->rlock){+.?.}, at: put_entry_bdev+0x1e/0x50
[  254.521732] {SOFTIRQ-ON-W} state was registered at:
[  254.521732]   _raw_spin_lock+0x2c/0x40
[  254.521732]   zram_make_request+0x755/0xdc9
[  254.521732]   generic_make_request+0x373/0x6a0
[  254.521732]   submit_bio+0x6c/0x140
[  254.521732]   __swap_writepage+0x3a8/0x480
[  254.521732]   shrink_page_list+0x1102/0x1a60
[  254.521732]   shrink_inactive_list+0x21b/0x3f0
[  254.521732]   shrink_node_memcg.constprop.99+0x4f8/0x7e0
[  254.521732]   shrink_node+0x7d/0x2f0
[  254.521732]   do_try_to_free_pages+0xe0/0x300
[  254.521732]   try_to_free_pages+0x116/0x2b0
[  254.521732]   __alloc_pages_slowpath+0x3f4/0xf80
[  254.521732]   __alloc_pages_nodemask+0x2a2/0x2f0
[  254.521732]   __handle_mm_fault+0x42e/0xb50
[  254.521732]   handle_mm_fault+0x55/0xb0
[  254.521732]   __do_page_fault+0x235/0x4b0
[  254.521732]   page_fault+0x1e/0x30
[  254.521732] irq event stamp: 228412
[  254.521732] hardirqs last  enabled at (228412): [<ffffffff98245846>] __slab_free+0x3e6/0x600
[  254.521732] hardirqs last disabled at (228411): [<ffffffff98245625>] __slab_free+0x1c5/0x600
[  254.521732] softirqs last  enabled at (228396): [<ffffffff98e0031e>] __do_softirq+0x31e/0x427
[  254.521732] softirqs last disabled at (228403): [<ffffffff98072051>] irq_exit+0xd1/0xe0
[  254.521732]
[  254.521732] other info that might help us debug this:
[  254.521732]  Possible unsafe locking scenario:
[  254.521732]
[  254.521732]        CPU0
[  254.521732]        ----
[  254.521732]   lock(&(&zram->bitmap_lock)->rlock);
[  254.521732]   <Interrupt>
[  254.521732]     lock(&(&zram->bitmap_lock)->rlock);
[  254.521732]
[  254.521732]  *** DEADLOCK ***
[  254.521732]
[  254.521732] no locks held by zram_verify/2095.
[  254.521732]
[  254.521732] stack backtrace:
[  254.521732] CPU: 5 PID: 2095 Comm: zram_verify Not tainted 4.19.0+ #390
[  254.521732] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[  254.521732] Call Trace:
[  254.521732]  <IRQ>
[  254.521732]  dump_stack+0x67/0x9b
[  254.521732]  print_usage_bug+0x1bd/0x1d3
[  254.521732]  mark_lock+0x4aa/0x540
[  254.521732]  ? check_usage_backwards+0x160/0x160
[  254.521732]  __lock_acquire+0x51d/0x1300
[  254.521732]  ? free_debug_processing+0x24e/0x400
[  254.521732]  ? bio_endio+0x6d/0x1a0
[  254.521732]  ? lockdep_hardirqs_on+0x9b/0x180
[  254.521732]  ? lock_acquire+0x90/0x180
[  254.521732]  lock_acquire+0x90/0x180
[  254.521732]  ? put_entry_bdev+0x1e/0x50
[  254.521732]  _raw_spin_lock+0x2c/0x40
[  254.521732]  ? put_entry_bdev+0x1e/0x50
[  254.521732]  put_entry_bdev+0x1e/0x50
[  254.521732]  zram_free_page+0xf6/0x110
[  254.521732]  zram_slot_free_notify+0x42/0xa0
[  254.521732]  end_swap_bio_read+0x5b/0x170
[  254.521732]  blk_update_request+0x8f/0x340
[  254.521732]  scsi_end_request+0x2c/0x1e0
[  254.521732]  scsi_io_completion+0x98/0x650
[  254.521732]  blk_done_softirq+0x9e/0xd0
[  254.521732]  __do_softirq+0xcc/0x427
[  254.521732]  irq_exit+0xd1/0xe0
[  254.521732]  do_IRQ+0x93/0x120
[  254.521732]  common_interrupt+0xf/0xf
[  254.521732]  </IRQ>

With writeback feature, zram_slot_free_notify could be called
in softirq context by end_swap_bio_read. However, bitmap_lock
is not aware of that so lockdep yell out. Thanks.

The problem is not only bitmap_lock but it is also zram_slot_lock
so straightforward solution would disable irq on zram_slot_lock
which covers every bitmap_lock, too.
Although duration disabling the irq is short in many places
zram_slot_lock is used, a place(ie, decompress) is not fast
enough to hold irqlock on relying on compression algorithm
so it's not a option.

The approach in this patch is just "best effort", not guarantee
"freeing orphan zpage". If the zram_slot_lock contention may happen,
kernel couldn't free the zpage until it recycles the block. However,
such contention between zram_slot_free_notify and other places to
hold zram_slot_lock should be very rare in real practice.
To see how often it happens, this patch adds new debug stat
"miss_free".

It also adds irq lock in get/put_block_bdev to prevent deadlock
lockdep reported. The reason I used irq disable rather than bottom
half is swap_slot_free_notify could be called with irq disabled
so it breaks local_bh_enable's rule. The irqlock works on only
writebacked zram slot entry so it should be not frequent lock.

Cc: stable@vger.kernel.org # 4.14+
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 56 +++++++++++++++++++++++++----------
 drivers/block/zram/zram_drv.h |  1 +
 2 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 4879595200e1..472027eaed60 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -53,6 +53,11 @@ static size_t huge_class_size;
 
 static void zram_free_page(struct zram *zram, size_t index);
 
+static int zram_slot_trylock(struct zram *zram, u32 index)
+{
+	return bit_spin_trylock(ZRAM_LOCK, &zram->table[index].value);
+}
+
 static void zram_slot_lock(struct zram *zram, u32 index)
 {
 	bit_spin_lock(ZRAM_LOCK, &zram->table[index].value);
@@ -443,29 +448,45 @@ static ssize_t backing_dev_store(struct device *dev,
 
 static unsigned long get_entry_bdev(struct zram *zram)
 {
-	unsigned long entry;
+	unsigned long blk_idx;
+	unsigned long ret = 0;
 
-	spin_lock(&zram->bitmap_lock);
 	/* skip 0 bit to confuse zram.handle = 0 */
-	entry = find_next_zero_bit(zram->bitmap, zram->nr_pages, 1);
-	if (entry == zram->nr_pages) {
-		spin_unlock(&zram->bitmap_lock);
-		return 0;
+	blk_idx = find_next_zero_bit(zram->bitmap, zram->nr_pages, 1);
+	if (blk_idx == zram->nr_pages)
+		goto retry;
+
+	spin_lock_irq(&zram->bitmap_lock);
+	if (test_bit(blk_idx, zram->bitmap)) {
+		spin_unlock_irq(&zram->bitmap_lock);
+		goto retry;
 	}
 
-	set_bit(entry, zram->bitmap);
-	spin_unlock(&zram->bitmap_lock);
+	set_bit(blk_idx, zram->bitmap);
+	ret = blk_idx;
+	goto out;
+retry:
+	spin_lock_irq(&zram->bitmap_lock);
+	blk_idx = find_next_zero_bit(zram->bitmap, zram->nr_pages, 1);
+	if (blk_idx == zram->nr_pages)
+		goto out;
+
+	set_bit(blk_idx, zram->bitmap);
+	ret = blk_idx;
+out:
+	spin_unlock_irq(&zram->bitmap_lock);
 
-	return entry;
+	return ret;
 }
 
 static void put_entry_bdev(struct zram *zram, unsigned long entry)
 {
 	int was_set;
+	unsigned long flags;
 
-	spin_lock(&zram->bitmap_lock);
+	spin_lock_irqsave(&zram->bitmap_lock, flags);
 	was_set = test_and_clear_bit(entry, zram->bitmap);
-	spin_unlock(&zram->bitmap_lock);
+	spin_unlock_irqrestore(&zram->bitmap_lock, flags);
 	WARN_ON_ONCE(!was_set);
 }
 
@@ -886,9 +907,10 @@ static ssize_t debug_stat_show(struct device *dev,
 
 	down_read(&zram->init_lock);
 	ret = scnprintf(buf, PAGE_SIZE,
-			"version: %d\n%8llu\n",
+			"version: %d\n%8llu %8llu\n",
 			version,
-			(u64)atomic64_read(&zram->stats.writestall));
+			(u64)atomic64_read(&zram->stats.writestall),
+			(u64)atomic64_read(&zram->stats.miss_free));
 	up_read(&zram->init_lock);
 
 	return ret;
@@ -1400,10 +1422,14 @@ static void zram_slot_free_notify(struct block_device *bdev,
 
 	zram = bdev->bd_disk->private_data;
 
-	zram_slot_lock(zram, index);
+	atomic64_inc(&zram->stats.notify_free);
+	if (!zram_slot_trylock(zram, index)) {
+		atomic64_inc(&zram->stats.miss_free);
+		return;
+	}
+
 	zram_free_page(zram, index);
 	zram_slot_unlock(zram, index);
-	atomic64_inc(&zram->stats.notify_free);
 }
 
 static int zram_rw_page(struct block_device *bdev, sector_t sector,
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 72c8584b6dff..89da501292ff 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -79,6 +79,7 @@ struct zram_stats {
 	atomic64_t pages_stored;	/* no. of pages currently stored */
 	atomic_long_t max_used_pages;	/* no. of maximum pages stored */
 	atomic64_t writestall;		/* no. of write slow paths */
+	atomic64_t miss_free;		/* no. of missed free */
 };
 
 struct zram {
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

