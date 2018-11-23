Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBD8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED4A20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oc6sn6R2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED4A20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502086AbeKWRLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 12:11:01 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34268 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729253AbeKWRLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 12:11:01 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so2906070pfg.1;
        Thu, 22 Nov 2018 22:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ErDqdjEsmLSbUpdX6oGb3pbSY6xEibcOQetQLQGdD78=;
        b=oc6sn6R2WOP5kuK129ydTGk7VaczqCIINYeevmJEWgw4OmhG+rsbRfuU+pbhrSN2+v
         72rEk8SbTv+zWtPyVFvf7coYd/eYQk/cULHN/j2S3K45SFZneqP4CogWa8R04taVjoD5
         3q7+6SecPgbcKgtkCTQ7b3gvXAjy72XCrJIzEK79132vNPyLkGi/kyosTtyNsnCiuPXt
         ZYGYfDljj1BNXE7sq0jdkx6gjqnZN5b+ixKQARvh/TktBZl0gXZ0x6l9y8Kq1Ce9cFG0
         sSwKPpNcMtjkeupxTyV6HcgvJVwwcsYagh8h6xGI2Cbg3EbpFzbYYC/TF09RaOtz/1WO
         SItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ErDqdjEsmLSbUpdX6oGb3pbSY6xEibcOQetQLQGdD78=;
        b=IqI9boF+fZgIK+xcky0+x8yYFEdVl5xzj5Pl0kfhHngj2egbrOd5sL7FUEA3xnUopC
         bn3kXi0GkRWnh6Mu/T+A4giPRgfvmlnkGfVTJRZerry55o/uJlXkRMyd7OH7jlPL8Yhe
         9Nfpu4OXFhT1FqJk6tqTVPQHlxMZ17hbqysBQrVJEXn4M1e91T2qeukG5Ao4GcfvAeNj
         ZZgw25OhSxKwu15IT1r5kIml2sBWFMMc2MhVp/MB3tjltZJi7Dg18vnhNOY9e3xqN/sK
         59+d5rf8+8samX3KQHpScq6FQNgTI4yaMYoUOVzOvqow6bOgeJFny9MpKWxelllwDdHj
         EkIg==
X-Gm-Message-State: AGRZ1gLTj8doPdVo1tHkDLNWpW26ArtnIzpg05ojxxfUb3PEsgUEF3yv
        bTDyIhqiHEfRzLNPUGgY6uhegwtRJ/Q=
X-Google-Smtp-Source: AJdET5eaanl5jJLsIhXsLHRy0pXGjSSWmVdopvRt2QjZQFPE5BI80DdV5Cqnvy9FXIgv6YhIfUBgPw==
X-Received: by 2002:aa7:8497:: with SMTP id u23mr14561578pfn.220.1542954490432;
        Thu, 22 Nov 2018 22:28:10 -0800 (PST)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id m67sm468875pfb.25.2018.11.22.22.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 22:28:09 -0800 (PST)
From:   Minchan Kim <minchan@kernel.org>
To:     stable@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, hare@suse.com,
        LKML <linux-kernel@vger.kernel.org>, sashal@kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Howard Chen <howardsoc@google.com>
Subject: [PATCH for 4.9] zram: close udev startup race condition as default groups
Date:   Fri, 23 Nov 2018 15:28:02 +0900
Message-Id: <20181123062802.197704-1-minchan@kernel.org>
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
index b7c0b69a02f5..d64a53d3270a 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1223,6 +1223,11 @@ static struct attribute_group zram_disk_attr_group = {
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
@@ -1303,24 +1308,15 @@ static int zram_add(void)
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
 
 	pr_info("Added device: %s\n", zram->disk->disk_name);
 	return device_id;
 
-out_free_disk:
-	del_gendisk(zram->disk);
-	put_disk(zram->disk);
 out_free_queue:
 	blk_cleanup_queue(queue);
 out_free_idr:
@@ -1348,16 +1344,6 @@ static int zram_remove(struct zram *zram)
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

