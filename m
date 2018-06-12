Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1AA33C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B171C20891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RgH7n/gF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B171C20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934815AbeFLU7D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:59:03 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:1586 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934195AbeFLU4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:56:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1528836998; x=1560372998;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=2y5dPCNZgeX5m6Sr6j1VUhCYPEOLggUV3bD8hHxBGF4=;
  b=RgH7n/gFi+Z1OVIc+/pHnT+nzoZDjq1Fv15JsABjQGNq+27UIKMIz8e+
   trqbac8CPeyjuTaAtAUsmSuvIkxhFM0Svt5oT6yUCjHYK7H9AYXpLGSUT
   906RR7XobXgfxbXGSoqQdresQWmbc3f0mjRnXy2L2pcWeDVq/JR9ig5Ba
   o=;
X-IronPort-AV: E=Sophos;i="5.51,216,1526342400"; 
   d="scan'208";a="617032505"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 12 Jun 2018 20:56:38 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w5CKuWGu118041
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 12 Jun 2018 20:56:33 GMT
Received: from EX13D10UWA001.ant.amazon.com (10.43.160.216) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Jun 2018 20:56:32 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D10UWA001.ant.amazon.com (10.43.160.216) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 12 Jun 2018 20:56:31 +0000
Received: from localhost (10.25.15.63) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 12 Jun 2018 20:56:31 +0000
From:   Anchal Agarwal <anchalag@amazon.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
        <x86@kernel.org>
CC:     <boris.ostrovsky@oracle.com>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>, <netdev@vger.kernel.org>,
        <jgross@suse.com>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>, <kamatam@amazon.com>,
        <anchalag@amazon.com>, <fllinden@amazon.com>, <vallish@amazon.com>,
        <guruanb@amazon.com>, <eduval@amazon.com>, <rjw@rjwysocki.net>,
        <pavel@ucw.cz>, <len.brown@intel.com>, <linux-pm@vger.kernel.org>,
        <cyberax@amazon.com>
Subject: [RFC PATCH 06/12] xen-blkfront: add callbacks for PM suspend and hibernation
Date:   Tue, 12 Jun 2018 20:56:13 +0000
Message-ID: <20180612205619.28156-7-anchalag@amazon.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180612205619.28156-1-anchalag@amazon.com>
References: <20180612205619.28156-1-anchalag@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Munehisa Kamata <kamatam@amazon.com>

Add freeze and restore callbacks for PM suspend and hibernation support.
The freeze handler stops a block-layer queue and disconnect the frontend
from the backend while freeing ring_info and associated resources. The
restore handler re-allocates ring_info and re-connect to the backedend,
so the rest of the kernel can continue to use the block device
transparently.Also, the handlers are used for both PM
suspend and hibernation so that we can keep the existing suspend/resume
callbacks for Xen suspend without modification.
If a backend doesn't have commit 12ea729645ac ("xen/blkback: unmap all
persistent grants when frontend gets disconnected"), the frontend may see
massive amount of grant table warning when freeing resources.

 [   36.852659] deferring g.e. 0xf9 (pfn 0xffffffffffffffff)
 [   36.855089] xen:grant_table: WARNING: g.e. 0x112 still in use!

In this case, persistent grants would need to be disabled.

Ensure no reqs/rsps in rings before disconnecting. When disconnecting
the frontend from the backend in blkfront_freeze(), there still may be
unconsumed requests or responses in the rings, especially when the
backend is backed by network-based device. If the frontend gets
disconnected with such reqs/rsps remaining there, it can cause
grant warnings and/or losing reqs/rsps by freeing pages afterward.
This can lead resumed kernel into unrecoverable state like unexpected
freeing of grant page and/or hung task due to the lost reqs or rsps.
Therefore we have to ensure that there is no unconsumed requests or
responses before disconnecting.

Actually, the frontend just needs to wait for some amount of time so that
the backend can process the requests, put responses and notify the
frontend back. Timeout used here is based on some heuristic. If we somehow
hit the timeout, it would mean something serious happens in the backend,
the frontend will just return an error to PM core and PM
suspend/hibernation will be aborted. This may be something should be
fixed by the backend side, but a frontend side fix is probably
still worth doing to work with broader backends.

Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
Reviewed-by: Munehisa Kamata <kamatam@amazon.com>
Reviewed-by: Eduardo Valentin <eduval@amazon.com>
---
 drivers/block/xen-blkfront.c | 158 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 151 insertions(+), 7 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index ae00a82f350b..a223864c2220 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -46,6 +46,8 @@
 #include <linux/scatterlist.h>
 #include <linux/bitmap.h>
 #include <linux/list.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
 
 #include <xen/xen.h>
 #include <xen/xenbus.h>
@@ -78,6 +80,8 @@ enum blkif_state {
 	BLKIF_STATE_DISCONNECTED,
 	BLKIF_STATE_CONNECTED,
 	BLKIF_STATE_SUSPENDED,
+	BLKIF_STATE_FREEZING,
+	BLKIF_STATE_FROZEN
 };
 
 struct grant {
@@ -216,6 +220,7 @@ struct blkfront_info
 	/* Save uncomplete reqs and bios for migration. */
 	struct list_head requests;
 	struct bio_list bio_list;
+	struct completion wait_backend_disconnected;
 };
 
 static unsigned int nr_minors;
@@ -262,6 +267,16 @@ static DEFINE_SPINLOCK(minor_lock);
 static int blkfront_setup_indirect(struct blkfront_ring_info *rinfo);
 static void blkfront_gather_backend_features(struct blkfront_info *info);
 static int negotiate_mq(struct blkfront_info *info);
+static void __blkif_free(struct blkfront_info *info);
+
+static inline bool blkfront_ring_is_busy(struct blkif_front_ring *ring)
+{
+       if (RING_SIZE(ring) > RING_FREE_REQUESTS(ring) ||
+		RING_HAS_UNCONSUMED_RESPONSES(ring))
+		return true;
+	else
+		return false;
+}
 
 static int get_id_from_freelist(struct blkfront_ring_info *rinfo)
 {
@@ -996,6 +1011,7 @@ static int xlvbd_init_blk_queue(struct gendisk *gd, u16 sector_size,
 	info->sector_size = sector_size;
 	info->physical_sector_size = physical_sector_size;
 	blkif_set_queue_limits(info);
+	init_completion(&info->wait_backend_disconnected);
 
 	return 0;
 }
@@ -1219,6 +1235,8 @@ static void xlvbd_release_gendisk(struct blkfront_info *info)
 /* Already hold rinfo->ring_lock. */
 static inline void kick_pending_request_queues_locked(struct blkfront_ring_info *rinfo)
 {
+	if (unlikely(rinfo->dev_info->connected == BLKIF_STATE_FREEZING))
+		return;
 	if (!RING_FULL(&rinfo->ring))
 		blk_mq_start_stopped_hw_queues(rinfo->dev_info->rq, true);
 }
@@ -1342,8 +1360,6 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
 
 static void blkif_free(struct blkfront_info *info, int suspend)
 {
-	unsigned int i;
-
 	/* Prevent new requests being issued until we fix things up. */
 	info->connected = suspend ?
 		BLKIF_STATE_SUSPENDED : BLKIF_STATE_DISCONNECTED;
@@ -1351,6 +1367,13 @@ static void blkif_free(struct blkfront_info *info, int suspend)
 	if (info->rq)
 		blk_mq_stop_hw_queues(info->rq);
 
+	__blkif_free(info);
+}
+
+static void __blkif_free(struct blkfront_info *info)
+{
+	unsigned int i;
+
 	for (i = 0; i < info->nr_rings; i++)
 		blkif_free_ring(&info->rinfo[i]);
 
@@ -1554,8 +1577,10 @@ static irqreturn_t blkif_interrupt(int irq, void *dev_id)
 	struct blkfront_ring_info *rinfo = (struct blkfront_ring_info *)dev_id;
 	struct blkfront_info *info = rinfo->dev_info;
 
-	if (unlikely(info->connected != BLKIF_STATE_CONNECTED))
-		return IRQ_HANDLED;
+	if (unlikely(info->connected != BLKIF_STATE_CONNECTED)) {
+		if (info->connected != BLKIF_STATE_FREEZING)
+			return IRQ_HANDLED;
+	}
 
 	spin_lock_irqsave(&rinfo->ring_lock, flags);
  again:
@@ -2005,6 +2030,7 @@ static int blkif_recover(struct blkfront_info *info)
 	struct bio *bio;
 	unsigned int segs;
 
+	bool frozen = info->connected == BLKIF_STATE_FROZEN;
 	blkfront_gather_backend_features(info);
 	/* Reset limits changed by blk_mq_update_nr_hw_queues(). */
 	blkif_set_queue_limits(info);
@@ -2031,6 +2057,9 @@ static int blkif_recover(struct blkfront_info *info)
 		kick_pending_request_queues(rinfo);
 	}
 
+	if (frozen)
+		return 0;
+
 	list_for_each_entry_safe(req, n, &info->requests, queuelist) {
 		/* Requeue pending requests (flush or discard) */
 		list_del_init(&req->queuelist);
@@ -2335,6 +2364,7 @@ static void blkfront_connect(struct blkfront_info *info)
 
 		return;
 	case BLKIF_STATE_SUSPENDED:
+	case BLKIF_STATE_FROZEN:
 		/*
 		 * If we are recovering from suspension, we need to wait
 		 * for the backend to announce it's features before
@@ -2452,12 +2482,37 @@ static void blkback_changed(struct xenbus_device *dev,
 		break;
 
 	case XenbusStateClosed:
-		if (dev->state == XenbusStateClosed)
+		if (dev->state == XenbusStateClosed) {
+			if (info->connected == BLKIF_STATE_FREEZING) {
+				__blkif_free(info);
+				info->connected = BLKIF_STATE_FROZEN;
+				complete(&info->wait_backend_disconnected);
+				break;
+			}
+
+			break;
+		}
+
+		/*
+		 * We may somehow receive backend's Closed again while thawing
+		 * or restoring and it causes thawing or restoring to fail.
+		 * Ignore such unexpected state anyway.
+		 */
+		if (info->connected == BLKIF_STATE_FROZEN &&
+				dev->state == XenbusStateInitialised) {
+			dev_dbg(&dev->dev,
+					"ignore the backend's Closed state: %s",
+					dev->nodename);
 			break;
+		}
 		/* fall through */
 	case XenbusStateClosing:
-		if (info)
-			blkfront_closing(info);
+		if (info) {
+			if (info->connected == BLKIF_STATE_FREEZING)
+				xenbus_frontend_closed(dev);
+			else
+				blkfront_closing(info);
+		}
 		break;
 	}
 }
@@ -2594,6 +2649,92 @@ static void blkif_release(struct gendisk *disk, fmode_t mode)
 	mutex_unlock(&blkfront_mutex);
 }
 
+static int blkfront_freeze(struct xenbus_device *dev)
+{
+	unsigned int i;
+	struct blkfront_info *info = dev_get_drvdata(&dev->dev);
+	struct blkfront_ring_info *rinfo;
+	struct blkif_front_ring *ring;
+	/* This would be reasonable timeout as used in xenbus_dev_shutdown() */
+	unsigned int timeout = 5 * HZ;
+	int err = 0;
+
+	info->connected = BLKIF_STATE_FREEZING;
+
+	blk_mq_stop_hw_queues(info->rq);
+
+	for (i = 0; i < info->nr_rings; i++) {
+		rinfo = &info->rinfo[i];
+
+		gnttab_cancel_free_callback(&rinfo->callback);
+		flush_work(&rinfo->work);
+	}
+
+	for (i = 0; i < info->nr_rings; i++) {
+		spinlock_t *lock;
+		bool busy;
+		unsigned long req_timeout_ms = 25;
+		unsigned long ring_timeout;
+
+		rinfo = &info->rinfo[i];
+		ring = &rinfo->ring;
+
+		lock = &rinfo->ring_lock;
+
+		ring_timeout = jiffies +
+			msecs_to_jiffies(req_timeout_ms * RING_SIZE(ring));
+
+		do {
+			spin_lock_irq(lock);
+			busy = blkfront_ring_is_busy(ring);
+			spin_unlock_irq(lock);
+
+			if (busy)
+				msleep(req_timeout_ms);
+			else
+				break;
+		} while (time_is_after_jiffies(ring_timeout));
+
+		/* Timed out */
+		if (busy) {
+			xenbus_dev_error(dev, err, "the ring is still busy");
+			info->connected = BLKIF_STATE_CONNECTED;
+			return -EBUSY;
+		}
+	}
+
+	/* Kick the backend to disconnect */
+	xenbus_switch_state(dev, XenbusStateClosing);
+
+	/*
+	 * We don't want to move forward before the frontend is diconnected
+	 * from the backend cleanly.
+	 */
+	timeout = wait_for_completion_timeout(&info->wait_backend_disconnected,
+					      timeout);
+	if (!timeout) {
+		err = -EBUSY;
+		xenbus_dev_error(dev, err, "Freezing timed out;"
+				 "the device may become inconsistent state");
+	}
+
+	return err;
+}
+
+static int blkfront_restore(struct xenbus_device *dev)
+{
+	struct blkfront_info *info = dev_get_drvdata(&dev->dev);
+	int err = 0;
+
+	err = talk_to_blkback(dev, info);
+	if (err)
+		goto out;
+	blk_mq_update_nr_hw_queues(&info->tag_set, info->nr_rings);
+
+out:
+	return err;
+}
+
 static const struct block_device_operations xlvbd_block_fops =
 {
 	.owner = THIS_MODULE,
@@ -2616,6 +2757,9 @@ static struct xenbus_driver blkfront_driver = {
 	.resume = blkfront_resume,
 	.otherend_changed = blkback_changed,
 	.is_ready = blkfront_is_ready,
+	.freeze = blkfront_freeze,
+	.thaw = blkfront_restore,
+	.restore = blkfront_restore
 };
 
 static int __init xlblk_init(void)
-- 
2.13.6

