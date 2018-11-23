Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB917C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9443620861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tN1Z00bz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9443620861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502108AbeKWRNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 12:13:05 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44028 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbeKWRNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 12:13:05 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so10193433plb.10;
        Thu, 22 Nov 2018 22:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0CVoFvhwe5+ovTk8gc8kR9h+VqWDSGR6ELmmpIWJRDM=;
        b=tN1Z00bzWFWQ2MxPEUNRc6gH41XYVkZE2/0ez3qwcHcdviOr3oCaRX6aKsVJaokhz4
         MR3RF0N5uUXrFkKS5lBfD5/ZU3aZGRBV5pagypamjXnetnF4GTNmKaprCbJo8rgRS2gN
         B/EJ5+1P24//fcFMwKOrDcSkRvvBCEsbf2a4HDuN2IAifeVzhlHqfJcNYjzWCcc1flGq
         sV3fA3Iz1aCfmZuVnE9Da7bKefHjx1ZGz2q15CMq6mEkxaYgk+2h1eeq3f8osZyPmP1c
         5/IPrZNdAm5bKlYBXwGjT2jjZvd/YOLsrIWTaXK0nflKWm7vt0p19+Q9ekXEKLrdCMhX
         SbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0CVoFvhwe5+ovTk8gc8kR9h+VqWDSGR6ELmmpIWJRDM=;
        b=cx8YCUCdM2HXu1DMt5ImiXXFkYSA+behtejV9Nkhejj/W2rft2zYuPrgFn/b4ToWmh
         KqTDfwJoVI9cFCgj8XEIBdTDctAvHSXofb1GolKOjJzewLk+7qqIGNHiVkYuIdkeFla7
         HuOAlL8sckTCZxvn9q/sOJ92rm5Fln3ptl5BwAsCJxq3eedN00pHrK32Ar+kCAHD+XbD
         dl1JSoKksejTZJ/iHzp4Bj8E9COaVHaRUkWVPzucBhmV4l+/33krQ2gRC0alHmrr1oSF
         ZglhsaQhGFH+tugKOfQ5AJKaCWhSLES9IC37Er11Og6iZKsF7xUsAbnD7I4tiVDwjPFc
         GNXA==
X-Gm-Message-State: AA+aEWYEwFvmv3FkD/K18WU7+uvc67tr1kZ61Yz9rIT8wQz+pzAS4wxJ
        PhiJZtKonOZteH4fF8hy9t9KDeCKTVg=
X-Google-Smtp-Source: AFSGD/UrVHWYMPlbVeVt6Kq9GlBEwKFkRvKd21X8j0Y2x6unqT1hixHGUvsrNvGCRatyl4bt6YHaTw==
X-Received: by 2002:a17:902:b01:: with SMTP id 1mr7027363plq.331.1542954614229;
        Thu, 22 Nov 2018 22:30:14 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id y29sm68885808pga.59.2018.11.22.22.30.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 22:30:13 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     stable@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, hare@suse.com,
        LKML <linux-kernel@vger.kernel.org>, sashal@kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Howard Chen <howardsoc@google.com>
Subject: [PATCH] [PATCH for v4.4] zram: close udev startup race condition as default groups
Date:   Fri, 23 Nov 2018 15:30:06 +0900
Message-Id: <20181123063006.228167-1-minchan@kernel.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181115174504.GJ95254@sasha-vm>
References: <20181115174504.GJ95254@sasha-vm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit fef912bf860e upstream.
commit 98af4d4df889 upstream.

I got a report from Howard Chen that he saw zram and sysfs race(ie,
zram block device file is created but sysfs for it isn't yet)
when he tried to create new zram devices via hotadd knob.

v4.20 kernel fixes it by [1, 2] but it's too large size to merge
into -stable so this patch fixes the problem by registering defualt
group by Greg KH's approach[3].

This patch should be applied to every stable tree [3.16+] currently
existing from kernel.org because the problem was introduced at 2.6.37
by [4].

[1] fef912bf860e, block: genhd: add 'groups' argument to device_add_disk
[2] 98af4d4df889, zram: register default groups with device_add_disk()
[3] http://kroah.com/log/blog/2013/06/26/how-to-create-a-sysfs-file-correctly/
[4] 33863c21e69e9, Staging: zram: Replace ioctls with sysfs interface

Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Hannes Reinecke <hare@suse.com>
Tested-by: Howard Chen <howardsoc@google.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 502406c9e6e1..616ee4f9c233 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1184,6 +1184,11 @@ static struct attribute_group zram_disk_attr_group = {
 	.attrs = zram_disk_attrs,
 };
 
+static const struct attribute_group *zram_disk_attr_groups[] = {
+	&zram_disk_attr_group,
+	NULL,
+};
+
 /*
  * Allocate and initialize new zram device. the function returns
  * '>= 0' device_id upon success, and negative value otherwise.
@@ -1264,15 +1269,9 @@ static int zram_add(void)
 		zram->disk->queue->limits.discard_zeroes_data = 0;
 	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, zram->disk->queue);
 
+	disk_to_dev(zram->disk)->groups = zram_disk_attr_groups;
 	add_disk(zram->disk);
 
-	ret = sysfs_create_group(&disk_to_dev(zram->disk)->kobj,
-				&zram_disk_attr_group);
-	if (ret < 0) {
-		pr_err("Error creating sysfs group for device %d\n",
-				device_id);
-		goto out_free_disk;
-	}
 	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
 	zram->meta = NULL;
 	zram->max_comp_streams = 1;
@@ -1280,9 +1279,6 @@ static int zram_add(void)
 	pr_info("Added device: %s\n", zram->disk->disk_name);
 	return device_id;
 
-out_free_disk:
-	del_gendisk(zram->disk);
-	put_disk(zram->disk);
 out_free_queue:
 	blk_cleanup_queue(queue);
 out_free_idr:
@@ -1310,16 +1306,6 @@ static int zram_remove(struct zram *zram)
 	zram->claim = true;
 	mutex_unlock(&bdev->bd_mutex);
 
-	/*
-	 * Remove sysfs first, so no one will perform a disksize
-	 * store while we destroy the devices. This also helps during
-	 * hot_remove -- zram_reset_device() is the last holder of
-	 * ->init_lock, no later/concurrent disksize_store() or any
-	 * other sysfs handlers are possible.
-	 */
-	sysfs_remove_group(&disk_to_dev(zram->disk)->kobj,
-			&zram_disk_attr_group);
-
 	/* Make sure all the pending I/O are finished */
 	fsync_bdev(bdev);
 	zram_reset_device(zram);
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

