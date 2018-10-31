Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7B8ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832A620664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hg3VOhy0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 832A620664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731502AbeKAILN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:11:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731458AbeKAILJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:11:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 496C820840;
        Wed, 31 Oct 2018 23:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027457;
        bh=6aA6Ch5b2Lonu9ONXKOeqNMoUj6GvuhzTiYEe5fOBTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hg3VOhy0X31MBqkpQ7HQr5YlqeRJU+HqMTL7XS0uHCjQbJYP0aVD0t/NkctH3rCOq
         V43BBYZlmpfdvPhnlcvmuqPTNiC3bxuyUmAYe4g09fND0tVP/xJloZ35QulZsM2A1m
         kNcTUXys0PfbnAm/m1ut+hVLBQ/vQNOLhsrgsmVc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 03/48] ataflop: fix error handling during setup
Date:   Wed, 31 Oct 2018 19:10:09 -0400
Message-Id: <20181031231054.29333-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031231054.29333-1-sashal@kernel.org>
References: <20181031231054.29333-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

[ Upstream commit 71327f547ee3a46ec5c39fdbbd268401b2578d0e ]

Move queue allocation next to disk allocation to fix a couple of issues:

- If add_disk() hasn't been called, we should clear disk->queue before
  calling put_disk().
- If we fail to allocate a request queue, we still need to put all of
  the disks, not just the ones that we allocated queues for.

Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/ataflop.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 2104b1b4ccda..9ab759bcebd5 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1933,6 +1933,11 @@ static int __init atari_floppy_init (void)
 		unit[i].disk = alloc_disk(1);
 		if (!unit[i].disk)
 			goto Enomem;
+
+		unit[i].disk->queue = blk_init_queue(do_fd_request,
+						     &ataflop_lock);
+		if (!unit[i].disk->queue)
+			goto Enomem;
 	}
 
 	if (UseTrackbuffer < 0)
@@ -1964,10 +1969,6 @@ static int __init atari_floppy_init (void)
 		sprintf(unit[i].disk->disk_name, "fd%d", i);
 		unit[i].disk->fops = &floppy_fops;
 		unit[i].disk->private_data = &unit[i];
-		unit[i].disk->queue = blk_init_queue(do_fd_request,
-					&ataflop_lock);
-		if (!unit[i].disk->queue)
-			goto Enomem;
 		set_capacity(unit[i].disk, MAX_DISK_SIZE * 2);
 		add_disk(unit[i].disk);
 	}
@@ -1982,13 +1983,17 @@ static int __init atari_floppy_init (void)
 
 	return 0;
 Enomem:
-	while (i--) {
-		struct request_queue *q = unit[i].disk->queue;
+	do {
+		struct gendisk *disk = unit[i].disk;
 
-		put_disk(unit[i].disk);
-		if (q)
-			blk_cleanup_queue(q);
-	}
+		if (disk) {
+			if (disk->queue) {
+				blk_cleanup_queue(disk->queue);
+				disk->queue = NULL;
+			}
+			put_disk(unit[i].disk);
+		}
+	} while (i--);
 
 	unregister_blkdev(FLOPPY_MAJOR, "fd");
 	return -ENOMEM;
-- 
2.17.1

