Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id dvSFKUhXGVtNeAAAmS7hNA
	; Thu, 07 Jun 2018 16:04:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 85D17608BA; Thu,  7 Jun 2018 16:04:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DA57360115;
	Thu,  7 Jun 2018 16:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA57360115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934417AbeFGQDz (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:03:55 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39265 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933022AbeFGOJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:04 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb4-0005Zt-80; Thu, 07 Jun 2018 15:09:02 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb1-0002ot-67; Thu, 07 Jun 2018 15:08:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jens Axboe" <axboe@kernel.dk>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        "Tejun Heo" <tj@kernel.org>,
        "Bart Van Assche" <bart.vanassche@wdc.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.25123677@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 095/410] pktcdvd: Fix pkt_setup_dev() error path
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@wdc.com>

commit 5a0ec388ef0f6e33841aeb810d7fa23f049ec4cd upstream.

Commit 523e1d399ce0 ("block: make gendisk hold a reference to its queue")
modified add_disk() and disk_release() but did not update any of the
error paths that trigger a put_disk() call after disk->queue has been
assigned. That introduced the following behavior in the pktcdvd driver
if pkt_new_dev() fails:

Kernel BUG at 00000000e98fd882 [verbose debug info unavailable]

Since disk_release() calls blk_put_queue() anyway if disk->queue != NULL,
fix this by removing the blk_cleanup_queue() call from the pkt_setup_dev()
error path.

Fixes: commit 523e1d399ce0 ("block: make gendisk hold a reference to its queue")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/block/pktcdvd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2796,7 +2796,7 @@ static int pkt_setup_dev(dev_t dev, dev_
 	pd->pkt_dev = MKDEV(pktdev_major, idx);
 	ret = pkt_new_dev(pd, dev);
 	if (ret)
-		goto out_new_dev;
+		goto out_mem2;
 
 	/* inherit events of the host device */
 	disk->events = pd->bdev->bd_disk->events;
@@ -2814,8 +2814,6 @@ static int pkt_setup_dev(dev_t dev, dev_
 	mutex_unlock(&ctl_mutex);
 	return 0;
 
-out_new_dev:
-	blk_cleanup_queue(disk->queue);
 out_mem2:
 	put_disk(disk);
 out_mem:
