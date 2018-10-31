Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4613AC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC3320847
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gi2myE1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC3320847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbeKAI33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:29:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730799AbeKAIKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:10:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4D3820840;
        Wed, 31 Oct 2018 23:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027392;
        bh=xzg1+kz4UkZoygvSxIEUOi6d4mPvsNAK4hdqEu2B9dY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gi2myE1aXdrHii7mITn0MbB7L58oQM3sQd1YX7gW5u5MxnMyGd+x9yis2UTmpYMPm
         3I86TYcJF0qKzBakPAH5sIB6YSA+R5vgvqIA2uMnxQwAJhGkMmzU5oVg+mVqALpQgR
         G2WdUyLLQtAArD7qyTgfbdE30+XwgR8CcD/8bAR8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 03/73] ataflop: fix error handling during setup
Date:   Wed, 31 Oct 2018 19:08:38 -0400
Message-Id: <20181031230948.29203-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230948.29203-1-sashal@kernel.org>
References: <20181031230948.29203-1-sashal@kernel.org>
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
index 92da886180aa..1dacc42e2dcf 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1935,6 +1935,11 @@ static int __init atari_floppy_init (void)
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
@@ -1966,10 +1971,6 @@ static int __init atari_floppy_init (void)
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
@@ -1984,13 +1985,17 @@ static int __init atari_floppy_init (void)
 
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

