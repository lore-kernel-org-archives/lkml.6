Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE373ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBD42087A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sacZfYyg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBD42087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732234AbeKAIMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:12:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730722AbeKAIMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:12:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DBD420840;
        Wed, 31 Oct 2018 23:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027530;
        bh=LM8Cs5VjIr68e6vnNOfHa07r3AbCoouhpw8nrrupQX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sacZfYygrsqo82JqoCBuV1V7dRHxpKD4FjmmFLij+rrJc4wsXMxiiJKcQTCq/kPs8
         1/MnsPIbOW6Cgl4Erv8mDUgTwx+/8kKU0sOS1gzwgtf8rcfRCtnI98S62sRukHvO8T
         2Wja4lelPN4oofJfMoA3TqIBsWSYbU0c52wZOqSQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 03/22] swim: fix cleanup on setup error
Date:   Wed, 31 Oct 2018 19:11:47 -0400
Message-Id: <20181031231206.29509-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231206.29509-1-sashal@kernel.org>
References: <20181031231206.29509-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

[ Upstream commit 1448a2a5360ae06f25e2edc61ae070dff5c0beb4 ]

If we fail to allocate the request queue for a disk, we still need to
free that disk, not just the previous ones. Additionally, we need to
cleanup the previous request queues.

Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/swim.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 6b44bbe528b7..d1e2bb55163b 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -868,8 +868,17 @@ static int swim_floppy_init(struct swim_priv *swd)
 
 exit_put_disks:
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
-	while (drive--)
-		put_disk(swd->unit[drive].disk);
+	do {
+		struct gendisk *disk = swd->unit[drive].disk;
+
+		if (disk) {
+			if (disk->queue) {
+				blk_cleanup_queue(disk->queue);
+				disk->queue = NULL;
+			}
+			put_disk(disk);
+		}
+	} while (drive--);
 	return err;
 }
 
-- 
2.17.1

