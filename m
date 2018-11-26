Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC46EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7425C20817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvbH3E7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7425C20817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeKZVrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:47:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:55448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbeKZVrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:47:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B3B020817;
        Mon, 26 Nov 2018 10:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229614;
        bh=0MQbv3WXR/R3/X33pXmulC2zlkk5xZSAzFCiLPnoP48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OvbH3E7uQp/fDF4+3vUb9pYXK00xZbrz+14jBEPv6jLKHgQcyHKPjEnU1/ostisE8
         peAbGkAtgGN3oqVusuBrQxOsbEME94k8oms+63U3d3z9rXrRKG+CpEwVBb7DghoLzF
         fSQv7qVtaSlvBIzYeWAJW+lx17qXZ2FkECAV35NM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Hannes Reinecke <hare@suse.com>,
        Howard Chen <howardsoc@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 11/24] zram: close udev startup race condition as default groups
Date:   Mon, 26 Nov 2018 11:51:05 +0100
Message-Id: <20181126105031.483289228@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105029.790599475@linuxfoundation.org>
References: <20181126105029.790599475@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 7e94459a489a..5f4e6a3c2dde 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -999,6 +999,11 @@ static struct attribute_group zram_disk_attr_group = {
 	.attrs = zram_disk_attrs,
 };
 
+static const struct attribute_group *zram_disk_attr_groups[] = {
+	&zram_disk_attr_group,
+	NULL,
+};
+
 static int create_device(struct zram *zram, int device_id)
 {
 	int ret = -ENOMEM;
@@ -1060,22 +1065,14 @@ static int create_device(struct zram *zram, int device_id)
 		zram->disk->queue->limits.discard_zeroes_data = 0;
 	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, zram->disk->queue);
 
+	disk_to_dev(zram->disk)->groups = zram_disk_attr_groups;
 	add_disk(zram->disk);
 
-	ret = sysfs_create_group(&disk_to_dev(zram->disk)->kobj,
-				&zram_disk_attr_group);
-	if (ret < 0) {
-		pr_warn("Error creating sysfs group");
-		goto out_free_disk;
-	}
 	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
 	zram->meta = NULL;
 	zram->max_comp_streams = 1;
 	return 0;
 
-out_free_disk:
-	del_gendisk(zram->disk);
-	put_disk(zram->disk);
 out_free_queue:
 	blk_cleanup_queue(zram->queue);
 out:
@@ -1084,9 +1081,6 @@ out:
 
 static void destroy_device(struct zram *zram)
 {
-	sysfs_remove_group(&disk_to_dev(zram->disk)->kobj,
-			&zram_disk_attr_group);
-
 	del_gendisk(zram->disk);
 	put_disk(zram->disk);
 
-- 
2.17.1



