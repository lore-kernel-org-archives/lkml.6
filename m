Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DC0C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA676250A8
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA676250A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933658AbeFXPqY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:46:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60594 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932144AbeFXPqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:46:21 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DE016941;
        Sun, 24 Jun 2018 15:46:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Josef Bacik <jbacik@fb.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.17 41/70] nbd: use bd_set_size when updating disk size
Date:   Sun, 24 Jun 2018 23:22:33 +0800
Message-Id: <20180624142743.045535031@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142740.481662434@linuxfoundation.org>
References: <20180624142740.481662434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josef Bacik <jbacik@fb.com>

commit 9e2b19675d1338d2a38e99194756f2db44a081df upstream.

When we stopped relying on the bdev everywhere I broke updating the
block device size on the fly, which ceph relies on.  We can't just do
set_capacity, we also have to do bd_set_size so things like parted will
notice the device size change.

Fixes: 29eaadc ("nbd: stop using the bdev everywhere")
cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <jbacik@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/nbd.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -234,9 +234,18 @@ static void nbd_size_clear(struct nbd_de
 static void nbd_size_update(struct nbd_device *nbd)
 {
 	struct nbd_config *config = nbd->config;
+	struct block_device *bdev = bdget_disk(nbd->disk, 0);
+
 	blk_queue_logical_block_size(nbd->disk->queue, config->blksize);
 	blk_queue_physical_block_size(nbd->disk->queue, config->blksize);
 	set_capacity(nbd->disk, config->bytesize >> 9);
+	if (bdev) {
+		if (bdev->bd_disk)
+			bd_set_size(bdev, config->bytesize);
+		else
+			bdev->bd_invalidated = 1;
+		bdput(bdev);
+	}
 	kobject_uevent(&nbd_to_dev(nbd)->kobj, KOBJ_CHANGE);
 }
 
@@ -1114,7 +1123,6 @@ static int nbd_start_device_ioctl(struct
 	if (ret)
 		return ret;
 
-	bd_set_size(bdev, config->bytesize);
 	if (max_part)
 		bdev->bd_invalidated = 1;
 	mutex_unlock(&nbd->config_lock);


