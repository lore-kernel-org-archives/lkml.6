Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B90C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F1627B33
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jgi48upn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F1627B33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935810AbeF2S07 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:26:59 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59946 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966019AbeF2SZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:25:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5TIO7mk095926;
        Fri, 29 Jun 2018 18:25:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=63/ZMt3BnYN0KGlKozL16pnCbJ1B0MjOGFxZdYS10XI=;
 b=jgi48upn8BVksu2NeqnB5qGFuEbnjKPYZtvSMKKFJi+PdF/KODGz9zOaLa2Xa2rVgkuU
 3kurI0R9wApFn6J90pGakq7DYlt2lCQMApli6Lg8qYirU43V/TgVsoqsRjhAOJ5rUrC3
 MFppGA33oprvAYjRA/q2dkLVivdFtyXDYK/tkREjAnu1BxcTj27T5zYfcHLZ0OCLkqgI
 MT8wgx9GABJ6o6/cMj+ucphOLDNQ1eOIAP4c2/YK8Tpb5TJD8f+UGBOcIpdEBSuHm9pq
 nMoLsCyLVj24V6Asq4hmxV8d12cdPI8SbgAmtLtvhllpChtN2emF78NJCJq74DOGFy5s CA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2jum0afh72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jun 2018 18:25:49 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5TIPmM3017155
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jun 2018 18:25:49 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5TIPmkW019460;
        Fri, 29 Jun 2018 18:25:48 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Jun 2018 11:25:48 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     pasha.tatashin@oracle.com, steven.sistare@oracle.com,
        daniel.m.jordan@oracle.com, linux-kernel@vger.kernel.org,
        jeffrey.t.kirsher@intel.com, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, gregkh@linuxfoundation.org,
        alexander.duyck@gmail.com, tobin@apporbit.com,
        andy.shevchenko@gmail.com
Subject: [PATCH v6 2/3] drivers core: prepare device_shutdown for multi-threading
Date:   Fri, 29 Jun 2018 14:25:40 -0400
Message-Id: <20180629182541.6735-3-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180629182541.6735-1-pasha.tatashin@oracle.com>
References: <20180629182541.6735-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8939 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806290195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do all the necessary refactoring to prepare device_shutdown() logic to
be multi-threaded.

Which includes:
1. Change the direction of traversing the list instead of going backward,
we now go forward.
2. Children are shutdown recursively for each root device from bottom-up.
3. Functions that can be multi-threaded have _task() in their name.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 drivers/base/core.c | 178 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 149 insertions(+), 29 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 07380aa0683b..5d8623b38d4d 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2134,6 +2134,59 @@ const char *device_get_devnode(struct device *dev,
 	return *tmp = s;
 }
 
+/*
+ * device_children_count - device children count
+ * @parent: parent struct device.
+ *
+ * Returns number of children for this device or 0 if none.
+ */
+static int device_children_count(struct device *parent)
+{
+	struct klist_iter i;
+	int children = 0;
+
+	if (!parent->p)
+		return 0;
+
+	klist_iter_init(&parent->p->klist_children, &i);
+	while (next_device(&i))
+		children++;
+	klist_iter_exit(&i);
+
+	return children;
+}
+
+/*
+ * device_get_child_by_index - Return child using the provided index.
+ * @parent: parent struct device.
+ * @index:  Index of the child, where 0 is the first child in the children list,
+ * and so on.
+ *
+ * Returns child or NULL if child with this index is not present.
+ */
+static struct device *
+device_get_child_by_index(struct device *parent, int index)
+{
+	struct klist_iter i;
+	struct device *dev = NULL, *d;
+	int child_index = 0;
+
+	if (!parent->p || index < 0)
+		return NULL;
+
+	klist_iter_init(&parent->p->klist_children, &i);
+	while ((d = next_device(&i))) {
+		if (child_index == index) {
+			dev = d;
+			break;
+		}
+		child_index++;
+	}
+	klist_iter_exit(&i);
+
+	return dev;
+}
+
 /**
  * device_for_each_child - device child iterator.
  * @parent: parent struct device.
@@ -2831,50 +2884,117 @@ static void device_shutdown_one(struct device *dev)
 	put_device(dev);
 }
 
+/*
+ * Passed as an argument to device_shutdown_child_task().
+ * child_next_index	the next available child index.
+ * parent		Parent device.
+ */
+struct device_shutdown_task_data {
+	atomic_t		child_next_index;
+	struct device		*parent;
+};
+
+static int device_shutdown_child_task(void *data);
+
+/*
+ * Shutdown device tree with root started in dev. If dev has no children
+ * simply shutdown only this device. If dev has children recursively shutdown
+ * children first, and only then the parent.
+ */
+static void device_shutdown_tree(struct device *dev)
+{
+	int children_count;
+
+	device_lock(dev);
+	children_count = device_children_count(dev);
+
+	if (children_count) {
+		struct device_shutdown_task_data tdata;
+		int i;
+
+		atomic_set(&tdata.child_next_index, 0);
+		tdata.parent = dev;
+
+		for (i = 0; i < children_count; i++) {
+			device_shutdown_child_task(&tdata);
+		}
+	}
+	device_shutdown_one(dev);
+	device_unlock(dev);
+}
+
+/*
+ * Only devices with parent are going through this function. The parent is
+ * locked and waits for all of its children to finish shutting down before
+ * calling shutdown function for itself.
+ */
+static int device_shutdown_child_task(void *data)
+{
+	struct device_shutdown_task_data *tdata = data;
+	int cidx = atomic_inc_return(&tdata->child_next_index) - 1;
+	struct device *dev = device_get_child_by_index(tdata->parent, cidx);
+
+	/* ref. counter is going to be decremented in device_shutdown_one() */
+	get_device(dev);
+	device_shutdown_tree(dev);
+	return 0;
+}
+
+/*
+ * On shutdown each root device (the one that does not have a parent) goes
+ * through this function.
+ */
+static int device_shutdown_root_task(void *data)
+{
+	struct device *dev = (struct device *)data;
+
+	device_shutdown_tree(dev);
+
+	return 0;
+}
+
 /**
  * device_shutdown - call ->shutdown() on each device to shutdown.
  */
 void device_shutdown(void)
 {
-	struct device *dev, *parent;
+	struct device *dev;
 
-	spin_lock(&devices_kset->list_lock);
-	/*
-	 * Walk the devices list backward, shutting down each in turn.
-	 * Beware that device unplug events may also start pulling
-	 * devices offline, even as the system is shutting down.
+	/* Shutdown the root devices. The children are going to be
+	 * shutdown first in device_shutdown_tree().
 	 */
+	spin_lock(&devices_kset->list_lock);
 	while (!list_empty(&devices_kset->list)) {
-		dev = list_entry(devices_kset->list.prev, struct device,
-				kobj.entry);
+		dev = list_entry(devices_kset->list.next, struct device,
+				 kobj.entry);
 
-		/*
-		 * hold reference count of device's parent to
-		 * prevent it from being freed because parent's
-		 * lock is to be held
-		 */
-		parent = get_device(dev->parent);
-		get_device(dev);
 		/*
 		 * Make sure the device is off the kset list, in the
 		 * event that dev->*->shutdown() doesn't remove it.
 		 */
 		list_del_init(&dev->kobj.entry);
-		spin_unlock(&devices_kset->list_lock);
 
-		/* hold lock to avoid race with probe/release */
-		if (parent)
-			device_lock(parent);
-		device_lock(dev);
-
-		device_shutdown_one(dev);
-		device_unlock(dev);
-		if (parent)
-			device_unlock(parent);
-
-		put_device(parent);
-
-		spin_lock(&devices_kset->list_lock);
+		/* Here we start tasks for root devices only */
+		if (!dev->parent) {
+			/* Prevents devices from being freed. The counter is
+			 * going to be decremented in device_shutdown_one() once
+			 * this root device is shutdown.
+			 */
+			get_device(dev);
+
+			/* We unlock list for performance reasons,
+			 * dev->*->shutdown(), may try to take this lock to
+			 * remove us from kset list. To avoid unlocking this
+			 * list we could replace spin lock in:
+			 * dev->kobj.kset->list_lock with a dummy one once
+			 * device is locked in device_shutdown_root_task() and
+			 * in device_shutdown_child_task().
+			 */
+			spin_unlock(&devices_kset->list_lock);
+
+			device_shutdown_root_task(dev);
+			spin_lock(&devices_kset->list_lock);
+		}
 	}
 	spin_unlock(&devices_kset->list_lock);
 }
-- 
2.18.0

