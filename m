Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D67BC46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3CF21A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3CF21A04
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbeHFNnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:43:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:33658 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727340AbeHFNnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:43:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D4EADAE4C;
        Mon,  6 Aug 2018 11:34:18 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org
Cc:     konrad.wilk@oracle.com, roger.pau@citrix.com, axboe@kernel.dk,
        boris.ostrovsky@oracle.com, Juergen Gross <jgross@suse.com>
Subject: [PATCH 2/4] xen/blkfront: cleanup stale persistent grants
Date:   Mon,  6 Aug 2018 13:34:01 +0200
Message-Id: <20180806113403.24728-4-jgross@suse.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20180806113403.24728-1-jgross@suse.com>
References: <20180806113403.24728-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a periodic cleanup function to remove old persistent grants which
are no longer in use on the backend side. This avoids starvation in
case there are lots of persistent grants for a device which no longer
is involved in I/O business.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/block/xen-blkfront.c | 99 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 4 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index b5cedccb5d7d..19feb8835fc4 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -46,6 +46,7 @@
 #include <linux/scatterlist.h>
 #include <linux/bitmap.h>
 #include <linux/list.h>
+#include <linux/workqueue.h>
 
 #include <xen/xen.h>
 #include <xen/xenbus.h>
@@ -121,6 +122,9 @@ static inline struct blkif_req *blkif_req(struct request *rq)
 
 static DEFINE_MUTEX(blkfront_mutex);
 static const struct block_device_operations xlvbd_block_fops;
+static struct delayed_work blkfront_work;
+static LIST_HEAD(info_list);
+static bool blkfront_work_active;
 
 /*
  * Maximum number of segments in indirect requests, the actual value used by
@@ -216,6 +220,7 @@ struct blkfront_info
 	/* Save uncomplete reqs and bios for migration. */
 	struct list_head requests;
 	struct bio_list bio_list;
+	struct list_head info_list;
 };
 
 static unsigned int nr_minors;
@@ -1764,6 +1769,12 @@ static int write_per_ring_nodes(struct xenbus_transaction xbt,
 	return err;
 }
 
+static void free_info(struct blkfront_info *info)
+{
+	list_del(&info->info_list);
+	kfree(info);
+}
+
 /* Common code used when first setting up, and when resuming. */
 static int talk_to_blkback(struct xenbus_device *dev,
 			   struct blkfront_info *info)
@@ -1885,7 +1896,10 @@ static int talk_to_blkback(struct xenbus_device *dev,
  destroy_blkring:
 	blkif_free(info, 0);
 
-	kfree(info);
+	mutex_lock(&blkfront_mutex);
+	free_info(info);
+	mutex_unlock(&blkfront_mutex);
+
 	dev_set_drvdata(&dev->dev, NULL);
 
 	return err;
@@ -1996,6 +2010,10 @@ static int blkfront_probe(struct xenbus_device *dev,
 	info->handle = simple_strtoul(strrchr(dev->nodename, '/')+1, NULL, 0);
 	dev_set_drvdata(&dev->dev, info);
 
+	mutex_lock(&blkfront_mutex);
+	list_add(&info->info_list, &info_list);
+	mutex_unlock(&blkfront_mutex);
+
 	return 0;
 }
 
@@ -2306,6 +2324,15 @@ static void blkfront_gather_backend_features(struct blkfront_info *info)
 	if (indirect_segments <= BLKIF_MAX_SEGMENTS_PER_REQUEST)
 		indirect_segments = 0;
 	info->max_indirect_segments = indirect_segments;
+
+	if (info->feature_persistent) {
+		mutex_lock(&blkfront_mutex);
+		if (!blkfront_work_active) {
+			blkfront_work_active = true;
+			schedule_delayed_work(&blkfront_work, HZ * 10);
+		}
+		mutex_unlock(&blkfront_mutex);
+	}
 }
 
 /*
@@ -2487,7 +2514,9 @@ static int blkfront_remove(struct xenbus_device *xbdev)
 	mutex_unlock(&info->mutex);
 
 	if (!bdev) {
-		kfree(info);
+		mutex_lock(&blkfront_mutex);
+		free_info(info);
+		mutex_unlock(&blkfront_mutex);
 		return 0;
 	}
 
@@ -2507,7 +2536,9 @@ static int blkfront_remove(struct xenbus_device *xbdev)
 	if (info && !bdev->bd_openers) {
 		xlvbd_release_gendisk(info);
 		disk->private_data = NULL;
-		kfree(info);
+		mutex_lock(&blkfront_mutex);
+		free_info(info);
+		mutex_unlock(&blkfront_mutex);
 	}
 
 	mutex_unlock(&bdev->bd_mutex);
@@ -2590,7 +2621,7 @@ static void blkif_release(struct gendisk *disk, fmode_t mode)
 		dev_info(disk_to_dev(bdev->bd_disk), "releasing disk\n");
 		xlvbd_release_gendisk(info);
 		disk->private_data = NULL;
-		kfree(info);
+		free_info(info);
 	}
 
 out:
@@ -2623,6 +2654,62 @@ static struct xenbus_driver blkfront_driver = {
 	.is_ready = blkfront_is_ready,
 };
 
+static void purge_persistent_grants(struct blkfront_info *info)
+{
+	unsigned int i;
+	unsigned long flags;
+
+	for (i = 0; i < info->nr_rings; i++) {
+		struct blkfront_ring_info *rinfo = &info->rinfo[i];
+		struct grant *gnt_list_entry, *tmp;
+
+		spin_lock_irqsave(&rinfo->ring_lock, flags);
+
+		if (rinfo->persistent_gnts_c == 0) {
+			spin_unlock_irqrestore(&rinfo->ring_lock, flags);
+			continue;
+		}
+
+		list_for_each_entry_safe(gnt_list_entry, tmp, &rinfo->grants,
+					 node) {
+			if (gnt_list_entry->gref == GRANT_INVALID_REF ||
+			    gnttab_query_foreign_access(gnt_list_entry->gref))
+				continue;
+
+			list_del(&gnt_list_entry->node);
+			gnttab_end_foreign_access(gnt_list_entry->gref, 0, 0UL);
+			rinfo->persistent_gnts_c--;
+			__free_page(gnt_list_entry->page);
+			kfree(gnt_list_entry);
+		}
+
+		spin_unlock_irqrestore(&rinfo->ring_lock, flags);
+	}
+}
+
+static void blkfront_delay_work(struct work_struct *work)
+{
+	struct blkfront_info *info;
+
+	mutex_lock(&blkfront_mutex);
+
+	blkfront_work_active = false;
+
+	list_for_each_entry(info, &info_list, info_list) {
+		if (info->feature_persistent) {
+			blkfront_work_active = true;
+			mutex_lock(&info->mutex);
+			purge_persistent_grants(info);
+			mutex_unlock(&info->mutex);
+		}
+	}
+
+	if (blkfront_work_active)
+		schedule_delayed_work(&blkfront_work, HZ * 10);
+
+	mutex_unlock(&blkfront_mutex);
+}
+
 static int __init xlblk_init(void)
 {
 	int ret;
@@ -2655,6 +2742,8 @@ static int __init xlblk_init(void)
 		return -ENODEV;
 	}
 
+	INIT_DELAYED_WORK(&blkfront_work, blkfront_delay_work);
+
 	ret = xenbus_register_frontend(&blkfront_driver);
 	if (ret) {
 		unregister_blkdev(XENVBD_MAJOR, DEV_NAME);
@@ -2668,6 +2757,8 @@ module_init(xlblk_init);
 
 static void __exit xlblk_exit(void)
 {
+	cancel_delayed_work_sync(&blkfront_work);
+
 	xenbus_unregister_driver(&blkfront_driver);
 	unregister_blkdev(XENVBD_MAJOR, DEV_NAME);
 	kfree(minors);
-- 
2.13.7

