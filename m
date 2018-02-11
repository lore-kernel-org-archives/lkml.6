Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbeBKJld (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 04:41:33 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33580 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752809AbeBKJjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 04:39:14 -0500
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] nvme: change namespaces_mutext to namespaces_rwsem
Date: Sun, 11 Feb 2018 17:38:34 +0800
Message-Id: <1518341920-1060-4-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8801 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=638
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802110127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

namespaces_mutext is used to synchronize the operations on ctrl
namespaces list. Most of the time, it is a read operation. It is
better to change it from mutex to rwsem.

On the other hand, the namespaces mutex could introduce circular
dependency easily.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/core.c      | 64 +++++++++++++++++++++----------------------
 drivers/nvme/host/multipath.c |  4 +--
 drivers/nvme/host/nvme.h      |  2 +-
 3 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7425124..176ba9e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1120,14 +1120,14 @@ static void nvme_update_formats(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns, *next;
 	LIST_HEAD(rm_list);
 
-	mutex_lock(&ctrl->namespaces_mutex);
+	down_write(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		if (ns->disk && nvme_revalidate_disk(ns->disk)) {
 			list_del_init(&ns->list);
 			list_add_tail(&ns->list, &rm_list);
 		}
 	}
-	mutex_unlock(&ctrl->namespaces_mutex);
+	up_write(&ctrl->namespaces_rwsem);
 
 	list_for_each_entry_safe(ns, next, &rm_list, list)
 		nvme_ns_remove(ns);
@@ -2437,7 +2437,7 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
 	struct nvme_ns *ns;
 	int ret;
 
-	mutex_lock(&ctrl->namespaces_mutex);
+	down_read(&ctrl->namespaces_rwsem);
 	if (list_empty(&ctrl->namespaces)) {
 		ret = -ENOTTY;
 		goto out_unlock;
@@ -2454,14 +2454,14 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
 	dev_warn(ctrl->device,
 		"using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!\n");
 	kref_get(&ns->kref);
-	mutex_unlock(&ctrl->namespaces_mutex);
+	up_read(&ctrl->namespaces_rwsem);
 
 	ret = nvme_user_cmd(ctrl, ns, argp);
 	nvme_put_ns(ns);
 	return ret;
 
 out_unlock:
-	mutex_unlock(&ctrl->namespaces_mutex);
+	up_read(&ctrl->namespaces_rwsem);
 	return ret;
 }
 
@@ -2894,7 +2894,7 @@ static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns, *ret = NULL;
 
-	mutex_lock(&ctrl->namespaces_mutex);
+	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		if (ns->head->ns_id == nsid) {
 			if (!kref_get_unless_zero(&ns->kref))
@@ -2905,7 +2905,7 @@ static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		if (ns->head->ns_id > nsid)
 			break;
 	}
-	mutex_unlock(&ctrl->namespaces_mutex);
+	up_read(&ctrl->namespaces_rwsem);
 	return ret;
 }
 
@@ -3017,9 +3017,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	__nvme_revalidate_disk(disk, id);
 
-	mutex_lock(&ctrl->namespaces_mutex);
+	down_write(&ctrl->namespaces_rwsem);
 	list_add_tail(&ns->list, &ctrl->namespaces);
-	mutex_unlock(&ctrl->namespaces_mutex);
+	up_write(&ctrl->namespaces_rwsem);
 
 	nvme_get_ctrl(ctrl);
 
@@ -3072,9 +3072,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	list_del_rcu(&ns->siblings);
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
-	mutex_lock(&ns->ctrl->namespaces_mutex);
+	down_write(&ns->ctrl->namespaces_rwsem);
 	list_del_init(&ns->list);
-	mutex_unlock(&ns->ctrl->namespaces_mutex);
+	up_write(&ns->ctrl->namespaces_rwsem);
 
 	synchronize_srcu(&ns->head->srcu);
 	nvme_mpath_check_last_path(ns);
@@ -3100,14 +3100,14 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 	struct nvme_ns *ns, *next;
 	LIST_HEAD(rm_list);
 
-	mutex_lock(&ctrl->namespaces_mutex);
+	down_write(&ctrl->namespaces_rwsem);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
 		if (ns->head->ns_id > nsid) {
 			list_del_init(&ns->list);
 			list_add_tail(&ns->list, &rm_list);
 		}
 	}
-	mutex_unlock(&ctrl->namespaces_mutex);
+	up_write(&ctrl->namespaces_rwsem);
 
 	list_for_each_entry_safe(ns, next, &rm_list, list)
 		nvme_ns_remove(ns);
@@ -3187,9 +3187,9 @@ static void nvme_scan_work(struct work_struct *work)
 	}
 	nvme_scan_ns_sequential(ctrl, nn);
  done:
-	mutex_lock(&ctrl->namespaces_mutex);
+	down_write(&ctrl->namespaces_rwsem);
 	list_sort(NULL, &ctrl->namespaces, ns_cmp);
-	mutex_unlock(&ctrl->namespaces_mutex);
+	up_write(&ctrl->namespaces_rwsem);
 	kfree(id);
 }
 
@@ -3222,9 +3222,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	if (ctrl->state == NVME_CTRL_DEAD)
 		nvme_kill_queues(ctrl);
 
-	mutex_lock(&ctrl->namespaces_mutex);
+	down_write(&ctrl->namespaces_rwsem);
 	list_splice_init(&ctrl->namespaces, &ns_list);
-	mutex_unlock(&ctrl->namespaces_mutex);
+	up_write(&ctrl->namespaces_rwsem);
 
 	list_for_each_entry_safe(ns, next, &ns_list, list)
 		nvme_ns_remove(ns);
@@ -3413,7 +3413,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->state = NVME_CTRL_NEW;
 	spin_lock_init(&ctrl->lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
-	mutex_init(&ctrl->namespaces_mutex);
+	init_rwsem(&ctrl->namespaces_rwsem);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
 	ctrl->quirks = quirks;
@@ -3474,7 +3474,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	mutex_lock(&ctrl->namespaces_mutex);
+	down_read(&ctrl->namespaces_rwsem);
 
 	/* Forcibly unquiesce queues to avoid blocking dispatch */
 	if (ctrl->admin_q)
@@ -3493,7 +3493,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 		/* Forcibly unquiesce queues to avoid blocking dispatch */
 		blk_mq_unquiesce_queue(ns->queue);
 	}
-	mutex_unlock(&ctrl->namespaces_mutex);
+	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_kill_queues);
 
@@ -3501,10 +3501,10 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	mutex_lock(&ctrl->namespaces_mutex);
+	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		blk_mq_unfreeze_queue(ns->queue);
-	mutex_unlock(&ctrl->namespaces_mutex);
+	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_unfreeze);
 
@@ -3512,13 +3512,13 @@ void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
 {
 	struct nvme_ns *ns;
 
-	mutex_lock(&ctrl->namespaces_mutex);
+	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		timeout = blk_mq_freeze_queue_wait_timeout(ns->queue, timeout);
 		if (timeout <= 0)
 			break;
 	}
-	mutex_unlock(&ctrl->namespaces_mutex);
+	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_wait_freeze_timeout);
 
@@ -3526,10 +3526,10 @@ void nvme_wait_freeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	mutex_lock(&ctrl->namespaces_mutex);
+	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		blk_mq_freeze_queue_wait(ns->queue);
-	mutex_unlock(&ctrl->namespaces_mutex);
+	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_wait_freeze);
 
@@ -3537,10 +3537,10 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	mutex_lock(&ctrl->namespaces_mutex);
+	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		blk_freeze_queue_start(ns->queue);
-	mutex_unlock(&ctrl->namespaces_mutex);
+	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_start_freeze);
 
@@ -3548,10 +3548,10 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	mutex_lock(&ctrl->namespaces_mutex);
+	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		blk_mq_quiesce_queue(ns->queue);
-	mutex_unlock(&ctrl->namespaces_mutex);
+	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
 
@@ -3559,10 +3559,10 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	mutex_lock(&ctrl->namespaces_mutex);
+	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		blk_mq_unquiesce_queue(ns->queue);
-	mutex_unlock(&ctrl->namespaces_mutex);
+	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 3b211d9..559b601 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -44,12 +44,12 @@ void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	mutex_lock(&ctrl->namespaces_mutex);
+	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		if (ns->head->disk)
 			kblockd_schedule_work(&ns->head->requeue_work);
 	}
-	mutex_unlock(&ctrl->namespaces_mutex);
+	up_read(&ctrl->namespaces_rwsem);
 }
 
 static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8e4550f..4191650 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -140,7 +140,7 @@ struct nvme_ctrl {
 	struct blk_mq_tag_set *tagset;
 	struct blk_mq_tag_set *admin_tagset;
 	struct list_head namespaces;
-	struct mutex namespaces_mutex;
+	struct rw_semaphore namespaces_rwsem;
 	struct device ctrl_device;
 	struct device *device;	/* char device */
 	struct cdev cdev;
-- 
2.7.4
