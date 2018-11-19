Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8EEC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5414F21104
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iK1immQQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5414F21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404293AbeKTDUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:20:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:60284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390603AbeKTDUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:20:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53140208E3;
        Mon, 19 Nov 2018 16:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646592;
        bh=DJfbPe9ZalAzV8bp3eMJzVRyJt78XXzfSFnEZWOttC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iK1immQQrcAt8kLJmfQAJbzkg/alflrHnMycsSkE+VPactOeiGSRjCtZvk6OkgB40
         sWxlBbj2kDV0siSULQhBg+EMRmtoAx4G5HDoATf5sltdFlZPZvPehPwSXHjCU/NRHp
         HIKeOOXn4hdoggniil/WISN8GMcy+Se8qlwN9ud4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 017/160] ataflop: fix error handling during setup
Date:   Mon, 19 Nov 2018 17:27:36 +0100
Message-Id: <20181119162632.083371287@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/ataflop.c |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -1933,6 +1933,11 @@ static int __init atari_floppy_init (voi
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
@@ -1964,10 +1969,6 @@ static int __init atari_floppy_init (voi
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
@@ -1982,13 +1983,17 @@ static int __init atari_floppy_init (voi
 
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


