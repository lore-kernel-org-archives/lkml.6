Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A951C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302FF20862
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302FF20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=geekplace.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935508AbeFRKJZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:09:25 -0400
Received: from zulu.geekplace.eu ([5.45.100.158]:42970 "EHLO zulu.geekplace.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934787AbeFRKJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:09:23 -0400
Received: from flo-ubook.informatik.uni-erlangen.de (flowubook.informatik.uni-erlangen.de [131.188.34.88])
        by zulu.geekplace.eu (Postfix) with ESMTPA id A8F814A17CE;
        Mon, 18 Jun 2018 12:09:17 +0200 (CEST)
From:   Florian Schmaus <flo@geekplace.eu>
To:     Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org
Cc:     Florian Schmaus <flo@geekplace.eu>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] bcache: do not assign in if condition in bcache_device_init()
Date:   Mon, 18 Jun 2018 12:09:02 +0200
Message-Id: <20180618100902.4015-4-flo@geekplace.eu>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180618100902.4015-1-flo@geekplace.eu>
References: <20180618100902.4015-1-flo@geekplace.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes an error condition reported by checkpatch.pl which is caused by
assigning a variable in an if condition.

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
---
 drivers/md/bcache/super.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index f09f4f046315..4a2a028c8754 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -796,11 +796,12 @@ static int bcache_device_init(struct bcache_device *d, unsigned block_size,
 		return idx;
 
 	if (bioset_init(&d->bio_split, 4, offsetof(struct bbio, bio),
-			BIOSET_NEED_BVECS|BIOSET_NEED_RESCUER) ||
-	    !(d->disk = alloc_disk(BCACHE_MINORS))) {
-		ida_simple_remove(&bcache_device_idx, idx);
-		return -ENOMEM;
-	}
+				BIOSET_NEED_BVECS|BIOSET_NEED_RESCUER))
+		goto err;
+
+	d->disk = alloc_disk(BCACHE_MINORS);
+	if (!d->disk)
+		goto err;
 
 	set_capacity(d->disk, sectors);
 	snprintf(d->disk->disk_name, DISK_NAME_LEN, "bcache%i", idx);
@@ -834,6 +835,11 @@ static int bcache_device_init(struct bcache_device *d, unsigned block_size,
 	blk_queue_write_cache(q, true, true);
 
 	return 0;
+
+err:
+	ida_simple_remove(&bcache_device_idx, idx);
+	return -ENOMEM;
+
 }
 
 /* Cached device */
-- 
2.16.4

