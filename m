Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934942AbeBLMzb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:55:31 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:50030 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934729AbeBLMzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:55:25 -0500
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] nvme: change namespaces_mutext to namespaces_rwsem
Date: Mon, 12 Feb 2018 20:54:46 +0800
Message-Id: <1518440086-583-3-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518440086-583-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1518440086-583-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8802 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=823
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802120167
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

namespaces_mutext is used to synchronize the operations on ctrl
namespaces list. Most of the time, it is a read operation.

On the other hand, there are many interfaces in nvme core that
need this lock, such as nvme_wait_freeze, and even more interfaces
will be added. If we use mutex here, circular dependency could be
introduced easily. For example:
context A                  context B
nvme_xxx                   nvme_xxx
hold namespaces_mutext     require namespaces_mutext
sync context B

So it is better to change it from mutex to rwsem.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/core.c      | 64 +++++++++++++++++++++----------------------
 drivers/nvme/host/multipath.c |  4 +--
 drivers/nvme/host/nvme.h      |  2 +-
 3 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a051c2f..e8a3671 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1122,13 +1122,13 @@ static void nvme_update_formats(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns, *next;
 	LIST_HEAD(rm_list);
 
-	mutex_lock(&ctrl->namespaces_mutex);
+	down_write(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		if (ns->disk && nvme_revalidate_disk(ns->disk)) {
 			list_move_tail(&ns->list, &rm_list);
 		}
 	}
-	mutex_unlock(&ctrl->namespaces_mutex);
+	up_write(&ctrl->namespaces_rwsem);
 
 	list_for_each_entry_safe(ns, next, &rm_list, list)
 		nvme_ns_remove(ns);
@@ -2438,7 +2438,7 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
 	struct nvme_ns *ns;
 	int ret;
 
-	mutex_lock(&ctrl->namespaces_mutex);
+	down_read(&ctrl->namespaces_rwsem);
 	if (list_empty(&ctrl->namespaces)) {
 		ret = -ENOTTY;
 		goto out_unlock;
@@ -2455,14 +2455,14 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
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
 
@@ -2895,7 +2895,7 @@ static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns, *ret = NULL;
 
-	mutex_lock(&ctrl->namespaces_mutex);
+	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		if (ns->head->ns_id == nsid) {
 			if (!kref_get_unless_zero(&ns->kref))
@@ -2906,7 +2906,7 @@ static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		if (ns->head->ns_id > nsid)
 			break;
 	}
-	mutex_unlock(&ctrl->namespaces_mutex);
+	up_read(&ctrl->namespaces_rwsem);
 	return ret;
 }
 
@@ -3018,9 +3018,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	__nvme_revalidate_disk(disk, id);
 
-	mutex_lock(&ctrl->namespaces_mutex);
+	down_write(&ctrl->namespaces_rwsem);
 	list_add_tail(&ns->list, &ctrl->namespaces);
-	mutex_unlock(&ctrl->namespaces_mutex);
+	up_write(&ctrl->namespaces_rwsem);
 
 	nvme_get_ctrl(ctrl);
 
@@ -3073,9 +3073,9 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	list_del_rcu(&ns->siblings);
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
-	mutex_lock(&ns->ctrl->namespaces_mutex);
+	down_write(&ns->ctrl->namespaces_rwsem);
 	list_del_init(&ns->list);
-	mutex_unlock(&ns->ctrl->namespaces_mutex);
+	up_write(&ns->ctrl->namespaces_rwsem);
 
 	synchronize_srcu(&ns->head->srcu);
 	nvme_mpath_check_last_path(ns);
@@ -3101,12 +3101,12 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 	struct nvme_ns *ns, *next;
 	LIST_HEAD(rm_list);
 
-	mutex_lock(&ctrl->namespaces_mutex);
+	down_write(&ctrl->namespaces_rwsem);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
 		if (ns->head->ns_id > nsid)
 			list_move_tail(&ns->list, &rm_list);
 	}
-	mutex_unlock(&ctrl->namespaces_mutex);
+	up_write(&ctrl->namespaces_rwsem);
 
 	list_for_each_entry_safe(ns, next, &rm_list, list)
 		nvme_ns_remove(ns);
@@ -3186,9 +3186,9 @@ static void nvme_scan_work(struct work_struct *work)
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
 
@@ -3221,9 +3221,9 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	if (ctrl->state == NVME_CTRL_DEAD)
 		nvme_kill_queues(ctrl);
 
-	mutex_lock(&ctrl->namespaces_mutex);
+	down_write(&ctrl->namespaces_rwsem);
 	list_splice_init(&ctrl->namespaces, &ns_list);
-	mutex_unlock(&ctrl->namespaces_mutex);
+	up_write(&ctrl->namespaces_rwsem);
 
 	list_for_each_entry_safe(ns, next, &ns_list, list)
 		nvme_ns_remove(ns);
@@ -3412,7 +3412,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->state = NVME_CTRL_NEW;
 	spin_lock_init(&ctrl->lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
-	mutex_init(&ctrl->namespaces_mutex);
+	init_rwsem(&ctrl->namespaces_rwsem);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
 	ctrl->quirks = quirks;
@@ -3473,7 +3473,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
 
-	mutex_lock(&ctrl->namespaces_mutex);
+	down_read(&ctrl->namespaces_rwsem);
 
 	/* Forcibly unquiesce queues to avoid blocking dispatch */
 	if (ctrl->admin_q)
@@ -3492,7 +3492,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 		/* Forcibly unquiesce queues to avoid blocking dispatch */
 		blk_mq_unquiesce_queue(ns->queue);
 	}
-	mutex_unlock(&ctrl->namespaces_mutex);
+	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_kill_queues);
 
@@ -3500,10 +3500,10 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl)
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
 
@@ -3511,13 +3511,13 @@ void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout)
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
 
@@ -3525,10 +3525,10 @@ void nvme_wait_freeze(struct nvme_ctrl *ctrl)
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
 
@@ -3536,10 +3536,10 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
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
 
@@ -3547,10 +3547,10 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
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
 
@@ -3558,10 +3558,10 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
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
index 27e31c0..d90f638 100644
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
