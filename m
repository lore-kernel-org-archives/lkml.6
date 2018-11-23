Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF10C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8116220861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DGOdB88G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8116220861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502076AbeKWRJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 12:09:08 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45568 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbeKWRJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 12:09:08 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so2622683pgc.12;
        Thu, 22 Nov 2018 22:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WY7lE94eZeM6JKFyYa05G0/1cFXbQw6tUw3ja4+IQlg=;
        b=DGOdB88GbLE6xA1UUSHe84K+cMm6UjqzkMUrU1/xH2IKFGNhNHMw1UokQVzsNRo1xI
         nAauboaFhYXP+pQsWH3utUP9ZVNmppcEaEJKw9abwaUVjj1gb9lYn/e2k5e25RA6EBRf
         tlPbcmKyVcQueWVEZxTM9Rk8t6/OBA2TXb2q/23t99WTMrRfuEqfypi8IvIDtrnI26cv
         hsLXUwLMgFn5TZ+B4LbQlySbj788mxhj6pFl/gUIRW93pZdh2gyMem/QF724BoDmoDOf
         SZiGfC83YvtSDIf+ICNnM3mHvjDfO5dRPMfWxt7dw1VSuoYKRA8Cx8DL2zKzMayphjSQ
         M2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WY7lE94eZeM6JKFyYa05G0/1cFXbQw6tUw3ja4+IQlg=;
        b=cjyNl9bU0Qppo+WLhhbL5umMReCot8jSMCQAvj55oUl9zI6I2fp6LTjcSnHPhTeOvD
         cI6TkC7pWL3MSxrBFyyqF2K7d5e6j7N48saantRPN5YVdixAAmSsZNMFAB0PB4zSpNR+
         iEg3snBkml8QNGkogg4qJgoKsQ8dQYML25iATBbOqVwMhru8gfTqS4DHVCWrRse6MlpV
         Wg/HoxlWgQSmylDZMzeu4tDpoAxGLdlz5s4MXD47Zsg9vSMI6ToAYE+wfW9kfBIeQx+y
         xvvv4hp6d9xp+lW4xGx+GvDdSm6f+ty0c1J3URWebyeL+vg70wykIWBAaJp+Uraxc17d
         11fw==
X-Gm-Message-State: AA+aEWY4jJKePNwvOIDwpmssjZdfRmZU/Q4DWcoTAqxSAm5MJ9LNgHME
        EReTbn8HlPU0UVEwPvI/SfxQgagnw0o=
X-Google-Smtp-Source: AFSGD/V6iIFdYXMyZk1HAus4xjkv/4auSpbCjbzEEm6KR8ni0obKaA3kQe1b5/T1QYS6LhlGxxqxeg==
X-Received: by 2002:a63:1c61:: with SMTP id c33mr12540263pgm.354.1542954378238;
        Thu, 22 Nov 2018 22:26:18 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id j64-v6sm31548068pfc.43.2018.11.22.22.26.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 22:26:16 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     stable@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, hare@suse.com,
        LKML <linux-kernel@vger.kernel.org>, sashal@kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Howard Chen <howardsoc@google.com>
Subject: [PATCH for v4.14] zram: close udev startup race condition as default groups
Date:   Fri, 23 Nov 2018 15:25:50 +0900
Message-Id: <20181123062550.163536-1-minchan@kernel.org>
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
index 1e2648e4c286..27b202c64c84 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1491,6 +1491,11 @@ static const struct attribute_group zram_disk_attr_group = {
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
@@ -1568,23 +1573,14 @@ static int zram_add(void)
 	if (ZRAM_LOGICAL_BLOCK_SIZE == PAGE_SIZE)
 		blk_queue_max_write_zeroes_sectors(zram->disk->queue, UINT_MAX);
 
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
 
 	pr_info("Added device: %s\n", zram->disk->disk_name);
 	return device_id;
 
-out_free_disk:
-	del_gendisk(zram->disk);
-	put_disk(zram->disk);
 out_free_queue:
 	blk_cleanup_queue(queue);
 out_free_idr:
@@ -1612,16 +1608,6 @@ static int zram_remove(struct zram *zram)
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

