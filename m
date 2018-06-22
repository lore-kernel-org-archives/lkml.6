Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F8DC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA4C23E0D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vOWwLIS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFA4C23E0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751367AbeFVHKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:10:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56514 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbeFVHKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:10:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5M7APIK050702;
        Fri, 22 Jun 2018 07:10:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=1Lc1/HQzym9P21n42cYx+/hHUKb5hJ3F4jjlh0G/kbE=;
 b=vOWwLIS5ibBqSvaKmIEJvCH5wxE2OjDUexF7Vab+bzd1ssjT3Tf1+i3GjPZryIyn4gnX
 yoXz3QWGB9ZwAAsDv/QGYPU81/pPoRyLFnHtcEyD19nxt2mutO4qWJujHPDVUNAp5QH6
 Ix5UsCmXx55Rr1ogErLxOV3+znBUWTC8w6R7nZOfLJvELj6CpF5aNTDZLsE1nuuQhhbg
 ve03dFWhBHwCkrcUdk+jWl12yhbXE8RyPz+A53jbVRsuoYWRjgOQjC8R4ohM+ir/f1KF
 kIu60m+CxbwPIpPTlMvt3RZAtvoyLj0YIpvcRaLHtRuaB8mE48t5kS9vRbnv3ZJpla10 Wg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2jrp8hrrnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jun 2018 07:10:32 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5M7AWH0008905
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Jun 2018 07:10:32 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5M7AVZf012890;
        Fri, 22 Jun 2018 07:10:32 GMT
Received: from will-ThinkCentre-M910s.cn.oracle.com (/10.182.70.254)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Jun 2018 00:10:31 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     bart.vanassche@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] block: fix the lock inversion caused by kobject_del under sysfs_lock
Date:   Fri, 22 Jun 2018 15:11:20 +0800
Message-Id: <1529651480-1734-4-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529651480-1734-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1529651480-1734-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8931 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806220081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the kobject_del for sysfs mq and hctx entry is invoked
under q->sysfs_lock. lock inversion will came up when someone try
to access the sysfs entries concurrently. The scenario is as below:
  hold q->sysfs_lock    access mq,hctx sysfs entries
  kobject_del
  __kernfs_remove          kernfs_get_active
    kernfs_drain
     wait kn->active       require q->sysfs_lock
To fix this issue, we do as following:
 - still reserve q->sysfs_lock as the sync method between queue, mq
   hctx sysfs entries' show and store method.
 - use QUEUE_FLAG_REGISTERED to sync the blk_register/unregister_queue
   with sysfs entries.
 - use QUEUE_FLAG_REGISTERED to sync the blk_mq_register/unregister_dev
   with blk_mq_sysfs_register/unregister.
 - change q->mq_sysfs_init_done to q->mq_sysfs_ready to sync
   blk_mq_register/unregister_dev and blk_mq_sysfs_register/unregister
   with mq,hctx entries.
Then we don't need sysfs_lock on kobject_del anymore.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq-sysfs.c   | 66 +++++++++++++++++++++++++++++++++++++-------------
 block/blk-sysfs.c      | 39 +++++++++++++++--------------
 block/blk-wbt.c        |  4 ---
 block/elevator.c       |  3 ++-
 include/linux/blkdev.h |  2 +-
 5 files changed, 73 insertions(+), 41 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index ec26745..0923c2c 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -55,7 +55,9 @@ static ssize_t blk_mq_sysfs_show(struct kobject *kobj, struct attribute *attr,
 
 	res = -ENOENT;
 	mutex_lock(&q->sysfs_lock);
-	if (!blk_queue_dying(q))
+	if (!blk_queue_dying(q) &&
+	    blk_queue_registered(q) &&
+	    q->mq_sysfs_ready)
 		res = entry->show(ctx, page);
 	mutex_unlock(&q->sysfs_lock);
 	return res;
@@ -78,7 +80,9 @@ static ssize_t blk_mq_sysfs_store(struct kobject *kobj, struct attribute *attr,
 
 	res = -ENOENT;
 	mutex_lock(&q->sysfs_lock);
-	if (!blk_queue_dying(q))
+	if (!blk_queue_dying(q) &&
+	    blk_queue_registered(q) &&
+	    q->mq_sysfs_ready)
 		res = entry->store(ctx, page, length);
 	mutex_unlock(&q->sysfs_lock);
 	return res;
@@ -101,7 +105,9 @@ static ssize_t blk_mq_hw_sysfs_show(struct kobject *kobj,
 
 	res = -ENOENT;
 	mutex_lock(&q->sysfs_lock);
-	if (!blk_queue_dying(q))
+	if (!blk_queue_dying(q) &&
+	    blk_queue_registered(q) &&
+	    q->mq_sysfs_ready)
 		res = entry->show(hctx, page);
 	mutex_unlock(&q->sysfs_lock);
 	return res;
@@ -125,7 +131,9 @@ static ssize_t blk_mq_hw_sysfs_store(struct kobject *kobj,
 
 	res = -ENOENT;
 	mutex_lock(&q->sysfs_lock);
-	if (!blk_queue_dying(q))
+	if (!blk_queue_dying(q) &&
+	    blk_queue_registered(q) &&
+	    q->mq_sysfs_ready)
 		res = entry->store(hctx, page, length);
 	mutex_unlock(&q->sysfs_lock);
 	return res;
@@ -253,7 +261,9 @@ void blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	lockdep_assert_held(&q->sysfs_lock);
+	mutex_lock(&q->sysfs_lock);
+	q->mq_sysfs_ready = false;
+	mutex_unlock(&q->sysfs_lock);
 
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
@@ -262,7 +272,6 @@ void blk_mq_unregister_dev(struct device *dev, struct request_queue *q)
 	kobject_del(&q->mq_kobj);
 	kobject_put(&dev->kobj);
 
-	q->mq_sysfs_init_done = false;
 }
 
 void blk_mq_hctx_kobj_init(struct blk_mq_hw_ctx *hctx)
@@ -295,13 +304,22 @@ void blk_mq_sysfs_init(struct request_queue *q)
 	}
 }
 
+/*
+ * blk_mq_register_dev/blk_mq_unregister_dev are only invoked by
+ * blk_register_queue/blk_unregister_queue. So we could use
+ * QUEUE_FLAG_REGISTERED to sync with blk_mq_sysfs_register/unregister.
+ * If QUEUE_FLAG_REGISTERED is set, q->mq_kobj is ok, otherwise, it is
+ * not there.
+ * blk_mq_register/unregister_dev blk_mq_sysfs_register/unregister all
+ * use q->mq_sysfs_ready to sync with mq and hctx sysfs entries' store
+ * and show method.
+ */
 int blk_mq_register_dev(struct device *dev, struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	int ret, i;
 
 	WARN_ON_ONCE(!q->kobj.parent);
-	lockdep_assert_held(&q->sysfs_lock);
 
 	ret = kobject_add(&q->mq_kobj, kobject_get(&dev->kobj), "%s", "mq");
 	if (ret < 0)
@@ -315,7 +333,9 @@ int blk_mq_register_dev(struct device *dev, struct request_queue *q)
 			goto unreg;
 	}
 
-	q->mq_sysfs_init_done = true;
+	mutex_lock(&q->sysfs_lock);
+	q->mq_sysfs_ready = true;
+	mutex_unlock(&q->sysfs_lock);
 
 out:
 	return ret;
@@ -335,15 +355,20 @@ void blk_mq_sysfs_unregister(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
+	/*
+	 * If QUEUE_FLAG_REGISTERED is not set, q->mq_kobj
+	 * is not ready.
+	 */
 	mutex_lock(&q->sysfs_lock);
-	if (!q->mq_sysfs_init_done)
-		goto unlock;
+	if (!blk_queue_registered(q)) {
+		mutex_unlock(&q->sysfs_lock);
+		return;
+	}
+	q->mq_sysfs_ready = false;
+	mutex_unlock(&q->sysfs_lock);
 
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_unregister_hctx(hctx);
-
-unlock:
-	mutex_unlock(&q->sysfs_lock);
 }
 
 int blk_mq_sysfs_register(struct request_queue *q)
@@ -351,9 +376,16 @@ int blk_mq_sysfs_register(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	int i, ret = 0;
 
+	/*
+	 * If QUEUE_FLAG_REGISTERED is not set, q->mq_kobj
+	 * is not ready.
+	 */
 	mutex_lock(&q->sysfs_lock);
-	if (!q->mq_sysfs_init_done)
-		goto unlock;
+	if (!blk_queue_registered(q)) {
+		mutex_unlock(&q->sysfs_lock);
+		return ret;
+	}
+	mutex_unlock(&q->sysfs_lock);
 
 	queue_for_each_hw_ctx(q, hctx, i) {
 		ret = blk_mq_register_hctx(hctx);
@@ -361,8 +393,8 @@ int blk_mq_sysfs_register(struct request_queue *q)
 			break;
 	}
 
-unlock:
+	mutex_lock(&q->sysfs_lock);
+	q->mq_sysfs_ready = true;
 	mutex_unlock(&q->sysfs_lock);
-
 	return ret;
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 96dcbb9..a3ef681 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -741,7 +741,8 @@ queue_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
 	if (!entry->show)
 		return -EIO;
 	mutex_lock(&q->sysfs_lock);
-	if (blk_queue_dying(q)) {
+	if (blk_queue_dying(q) ||
+	    !blk_queue_registered(q)) {
 		mutex_unlock(&q->sysfs_lock);
 		return -ENOENT;
 	}
@@ -763,7 +764,8 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 
 	q = container_of(kobj, struct request_queue, kobj);
 	mutex_lock(&q->sysfs_lock);
-	if (blk_queue_dying(q)) {
+	if (blk_queue_dying(q) ||
+	    !blk_queue_registered(q)) {
 		mutex_unlock(&q->sysfs_lock);
 		return -ENOENT;
 	}
@@ -866,7 +868,6 @@ int blk_register_queue(struct gendisk *disk)
 	WARN_ONCE(blk_queue_registered(q),
 		  "%s is registering an already registered queue\n",
 		  kobject_name(&dev->kobj));
-	queue_flag_set_unlocked(QUEUE_FLAG_REGISTERED, q);
 
 	/*
 	 * SCSI probing may synchronously create and destroy a lot of
@@ -887,17 +888,16 @@ int blk_register_queue(struct gendisk *disk)
 	if (ret)
 		return ret;
 
-	/* Prevent changes through sysfs until registration is completed. */
-	mutex_lock(&q->sysfs_lock);
-
 	ret = kobject_add(&q->kobj, kobject_get(&dev->kobj), "%s", "queue");
 	if (ret < 0) {
 		blk_trace_remove_sysfs(dev);
-		goto unlock;
+		return ret;
 	}
 
 	if (q->mq_ops) {
-		blk_mq_register_dev(dev, q);
+		ret = blk_mq_register_dev(dev, q);
+		if (ret)
+			goto err_kobj;
 		blk_mq_debugfs_register(q);
 	}
 
@@ -907,20 +907,25 @@ int blk_register_queue(struct gendisk *disk)
 
 	blk_throtl_register_queue(q);
 
+	/* Prevent changes through sysfs until registration is completed. */
+	mutex_lock(&q->sysfs_lock);
 	if (q->request_fn || (q->mq_ops && q->elevator)) {
 		ret = elv_register_queue(q);
 		if (ret) {
 			mutex_unlock(&q->sysfs_lock);
-			kobject_uevent(&q->kobj, KOBJ_REMOVE);
-			kobject_del(&q->kobj);
-			blk_trace_remove_sysfs(dev);
-			kobject_put(&dev->kobj);
-			return ret;
+			goto err_kobj;
 		}
 	}
-	ret = 0;
-unlock:
+
+	blk_queue_flag_set(QUEUE_FLAG_REGISTERED, q);
 	mutex_unlock(&q->sysfs_lock);
+	return 0;
+
+err_kobj:
+	kobject_uevent(&q->kobj, KOBJ_REMOVE);
+	kobject_del(&q->kobj);
+	blk_trace_remove_sysfs(dev);
+	kobject_put(&dev->kobj);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_register_queue);
@@ -949,16 +954,14 @@ void blk_unregister_queue(struct gendisk *disk)
 	 * concurrent elv_iosched_store() calls.
 	 */
 	mutex_lock(&q->sysfs_lock);
-
 	blk_queue_flag_clear(QUEUE_FLAG_REGISTERED, q);
-
+	mutex_unlock(&q->sysfs_lock);
 	/*
 	 * Remove the sysfs attributes before unregistering the queue data
 	 * structures that can be modified through sysfs.
 	 */
 	if (q->mq_ops)
 		blk_mq_unregister_dev(disk_to_dev(disk), q);
-	mutex_unlock(&q->sysfs_lock);
 
 	kobject_uevent(&q->kobj, KOBJ_REMOVE);
 	kobject_del(&q->kobj);
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 43ae265..c26deca 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -706,10 +706,6 @@ void wbt_enable_default(struct request_queue *q)
 	if (q->rq_wb)
 		return;
 
-	/* Queue not registered? Maybe shutting down... */
-	if (!blk_queue_registered(q))
-		return;
-
 	if ((q->mq_ops && IS_ENABLED(CONFIG_BLK_WBT_MQ)) ||
 	    (q->request_fn && IS_ENABLED(CONFIG_BLK_WBT_SQ)))
 		wbt_init(q);
diff --git a/block/elevator.c b/block/elevator.c
index a574841..a68e3e6 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -869,7 +869,8 @@ void elv_unregister_queue(struct request_queue *q)
 		kobject_del(&e->kobj);
 		e->registered = 0;
 		/* Re-enable throttling in case elevator disabled it */
-		wbt_enable_default(q);
+		if (blk_queue_registered(q))
+			wbt_enable_default(q);
 	}
 }
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d6174ed..df53e8f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -666,7 +666,7 @@ struct request_queue {
 	struct dentry		*sched_debugfs_dir;
 #endif
 
-	bool			mq_sysfs_init_done;
+	bool			mq_sysfs_ready;
 
 	size_t			cmd_size;
 	void			*rq_alloc_data;
-- 
2.7.4

