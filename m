Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165196AbeE1NJr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:09:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163822AbeE1Kvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:51:40 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bhavesh Davda <bhavesh.davda@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 232/496] xen-blkfront: move negotiate_mq to cover all cases of new VBDs
Date: Mon, 28 May 2018 12:00:17 +0200
Message-Id: <20180528100329.681633877@linuxfoundation.org>
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

From: Bhavesh Davda <bhavesh.davda@oracle.com>

[ Upstream commit 7ed8ce1c5fc7cf25b3602c73bef897a3466a6645 ]

negotiate_mq should happen in all cases of a new VBD being discovered by
xen-blkfront, whether called through _probe() or a hot-attached new VBD
from dom-0 via xenstore. Otherwise, hot-attached new VBDs are left
configured without multi-queue.

Signed-off-by: Bhavesh Davda <bhavesh.davda@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/xen-blkfront.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -262,6 +262,7 @@ static DEFINE_SPINLOCK(minor_lock);
 
 static int blkfront_setup_indirect(struct blkfront_ring_info *rinfo);
 static void blkfront_gather_backend_features(struct blkfront_info *info);
+static int negotiate_mq(struct blkfront_info *info);
 
 static int get_id_from_freelist(struct blkfront_ring_info *rinfo)
 {
@@ -1774,11 +1775,18 @@ static int talk_to_blkback(struct xenbus
 	unsigned int i, max_page_order;
 	unsigned int ring_page_order;
 
+	if (!info)
+		return -ENODEV;
+
 	max_page_order = xenbus_read_unsigned(info->xbdev->otherend,
 					      "max-ring-page-order", 0);
 	ring_page_order = min(xen_blkif_max_ring_order, max_page_order);
 	info->nr_ring_pages = 1 << ring_page_order;
 
+	err = negotiate_mq(info);
+	if (err)
+		goto destroy_blkring;
+
 	for (i = 0; i < info->nr_rings; i++) {
 		struct blkfront_ring_info *rinfo = &info->rinfo[i];
 
@@ -1978,11 +1986,6 @@ static int blkfront_probe(struct xenbus_
 	}
 
 	info->xbdev = dev;
-	err = negotiate_mq(info);
-	if (err) {
-		kfree(info);
-		return err;
-	}
 
 	mutex_init(&info->mutex);
 	info->vdevice = vdevice;
@@ -2099,10 +2102,6 @@ static int blkfront_resume(struct xenbus
 
 	blkif_free(info, info->connected == BLKIF_STATE_CONNECTED);
 
-	err = negotiate_mq(info);
-	if (err)
-		return err;
-
 	err = talk_to_blkback(dev, info);
 	if (!err)
 		blk_mq_update_nr_hw_queues(&info->tag_set, info->nr_rings);
