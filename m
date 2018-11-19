Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C01C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB81620870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="o82WIat6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB81620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbeKTC5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:57:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:56048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730241AbeKTC5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:57:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7053920831;
        Mon, 19 Nov 2018 16:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645195;
        bh=+RSRFg1EZe52AXA5yobu6EsLMMypl0TGtXAMpYZ3Gdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o82WIat6ZwJA86ucqbIkatGNpHzqNs49CT7pk9KTWzSdc81JZ+nKr9rBRfCSoyzHn
         EbPPzMsMyeu1xfAOZby57r4s1Y0uJbYQlUwyGaXQZiClvrL4r+LI5ClHFBUEtyCrym
         khrOlbaR0PK1KNej0ZkAnmNTeJNiny3yAR8HXzWE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Hannes Reinecke <hare@suse.com>,
        Howard Chen <howardsoc@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 073/205] zram: close udev startup race condition as default groups
Date:   Mon, 19 Nov 2018 17:26:20 +0100
Message-Id: <20181119162630.005323876@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a1d6b5597c17..66921427d109 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1636,6 +1636,11 @@ static const struct attribute_group zram_disk_attr_group = {
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
@@ -1716,24 +1721,15 @@ static int zram_add(void)
 
 	zram->disk->queue->backing_dev_info->capabilities |=
 			(BDI_CAP_STABLE_WRITES | BDI_CAP_SYNCHRONOUS_IO);
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
 
 	zram_debugfs_register(zram);
 	pr_info("Added device: %s\n", zram->disk->disk_name);
 	return device_id;
 
-out_free_disk:
-	del_gendisk(zram->disk);
-	put_disk(zram->disk);
 out_free_queue:
 	blk_cleanup_queue(queue);
 out_free_idr:
@@ -1762,16 +1758,6 @@ static int zram_remove(struct zram *zram)
 	mutex_unlock(&bdev->bd_mutex);
 
 	zram_debugfs_unregister(zram);
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
2.17.1



