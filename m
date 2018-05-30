Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753326AbeE3LZI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:25:08 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33305 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753306AbeE3LY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:24:57 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        "Bart Van Assche" <bart.vanassche@wdc.com>,
        "Jens Axboe" <axboe@kernel.dk>, "Tejun Heo" <tj@kernel.org>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.513540932@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 035/153] pktcdvd: Fix pkt_setup_dev() error path
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -2885,7 +2885,7 @@ static int pkt_setup_dev(dev_t dev, dev_
 	pd->pkt_dev = MKDEV(pktdev_major, idx);
 	ret = pkt_new_dev(pd, dev);
 	if (ret)
-		goto out_new_dev;
+		goto out_mem2;
 
 	/* inherit events of the host device */
 	disk->events = pd->bdev->bd_disk->events;
@@ -2903,8 +2903,6 @@ static int pkt_setup_dev(dev_t dev, dev_
 	mutex_unlock(&ctl_mutex);
 	return 0;
 
-out_new_dev:
-	blk_cleanup_queue(disk->queue);
 out_mem2:
 	put_disk(disk);
 out_mem:
