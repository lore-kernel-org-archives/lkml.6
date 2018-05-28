Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937733AbeE1KpN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937617AbeE1KpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:45:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Haberland <sth@linux.vnet.ibm.com>,
        Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 089/496] s390/dasd: fix handling of internal requests
Date: Mon, 28 May 2018 11:57:54 +0200
Message-Id: <20180528100323.557833015@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Haberland <sth@linux.vnet.ibm.com>

[ Upstream commit 9487cfd3430d07366801886bdf185799a2b6f066 ]

Internal DASD device driver I/O such as query host access count or
path verification is started using the _sleep_on() function.
To mark a request as started or ended the callback_data is set to either
DASD_SLEEPON_START_TAG or DASD_SLEEPON_END_TAG.

In cases where the request has to be stopped unconditionally the status is
set to DASD_SLEEPON_END_TAG as well which leads to immediate clearing of
the request.
But the request might still be on a device request queue for normal
operation which might lead to a panic because of a BUG() statement in
__dasd_device_process_final_queue() or a list corruption of the device
request queue.

Fix by removing the setting of DASD_SLEEPON_END_TAG in the
dasd_cancel_req() and dasd_generic_requeue_all_requests() functions and
ensure that the request is not deleted in the requeue function.
Trigger the device tasklet in the requeue function and let the normal
processing cleanup the request.

Signed-off-by: Stefan Haberland <sth@linux.vnet.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/block/dasd.c |   21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2596,8 +2596,6 @@ int dasd_cancel_req(struct dasd_ccw_req
 	case DASD_CQR_QUEUED:
 		/* request was not started - just set to cleared */
 		cqr->status = DASD_CQR_CLEARED;
-		if (cqr->callback_data == DASD_SLEEPON_START_TAG)
-			cqr->callback_data = DASD_SLEEPON_END_TAG;
 		break;
 	case DASD_CQR_IN_IO:
 		/* request in IO - terminate IO and release again */
@@ -3917,9 +3915,12 @@ static int dasd_generic_requeue_all_requ
 		wait_event(dasd_flush_wq,
 			   (cqr->status != DASD_CQR_CLEAR_PENDING));
 
-		/* mark sleepon requests as ended */
-		if (cqr->callback_data == DASD_SLEEPON_START_TAG)
-			cqr->callback_data = DASD_SLEEPON_END_TAG;
+		/*
+		 * requeue requests to blocklayer will only work
+		 * for block device requests
+		 */
+		if (_dasd_requeue_request(cqr))
+			continue;
 
 		/* remove requests from device and block queue */
 		list_del_init(&cqr->devlist);
@@ -3932,13 +3933,6 @@ static int dasd_generic_requeue_all_requ
 			cqr = refers;
 		}
 
-		/*
-		 * requeue requests to blocklayer will only work
-		 * for block device requests
-		 */
-		if (_dasd_requeue_request(cqr))
-			continue;
-
 		if (cqr->block)
 			list_del_init(&cqr->blocklist);
 		cqr->block->base->discipline->free_cp(
@@ -3955,8 +3949,7 @@ static int dasd_generic_requeue_all_requ
 		list_splice_tail(&requeue_queue, &device->ccw_queue);
 		spin_unlock_irq(get_ccwdev_lock(device->cdev));
 	}
-	/* wake up generic waitqueue for eventually ended sleepon requests */
-	wake_up(&generic_waitq);
+	dasd_schedule_device_bh(device);
 	return rc;
 }
 
