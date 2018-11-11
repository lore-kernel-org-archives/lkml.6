Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FFBC0044C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267C72154B
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHPnJjGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267C72154B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbeKLIQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:16:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbeKLIQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:16:52 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F7C7214F1;
        Sun, 11 Nov 2018 22:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975216;
        bh=mufrby9rZjPI8oB8NF5bn08Du7RyOw90z8Yai7pSIXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fHPnJjGUbY+kBod23nJfjc9KD4IH07ZAdGfU0Db9nehpk6CZGVz0k4xauO2pATqUy
         ph7Ez8u4eRluZOENmOaEAnvYMmwMylUK5LYa0mLx17v1ld2wtf4C69gtMOQF/7V5xW
         CC7bMXyWKRPl2WL9CEOsowWG8l7HKKEC+sHhFp0w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tang Junhui <tang.junhui.linux@gmail.com>,
        Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.19 013/361] bcache: fix ioctl in flash device
Date:   Sun, 11 Nov 2018 14:16:00 -0800
Message-Id: <20181111221621.792101493@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
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

From: Tang Junhui <tang.junhui.linux@gmail.com>

commit dd0c91793b7c2658ea32c6b3a2247a8ceca45dc0 upstream.

When doing ioctl in flash device, it will call ioctl_dev() in super.c,
then we should not to get cached device since flash only device has
no backend device. This patch just move the jugement dc->io_disable
to cached_dev_ioctl() to make ioctl in flash device correctly.

Fixes: 0f0709e6bfc3c ("bcache: stop bcache device when backing device is offline")
Signed-off-by: Tang Junhui <tang.junhui.linux@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/bcache/request.c |    3 +++
 drivers/md/bcache/super.c   |    4 ----
 2 files changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -1218,6 +1218,9 @@ static int cached_dev_ioctl(struct bcach
 {
 	struct cached_dev *dc = container_of(d, struct cached_dev, disk);
 
+	if (dc->io_disable)
+		return -EIO;
+
 	return __blkdev_driver_ioctl(dc->bdev, mode, cmd, arg);
 }
 
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -643,10 +643,6 @@ static int ioctl_dev(struct block_device
 		     unsigned int cmd, unsigned long arg)
 {
 	struct bcache_device *d = b->bd_disk->private_data;
-	struct cached_dev *dc = container_of(d, struct cached_dev, disk);
-
-	if (dc->io_disable)
-		return -EIO;
 
 	return d->ioctl(d, mode, cmd, arg);
 }


