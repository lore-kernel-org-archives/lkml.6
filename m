Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751065AbeC0EjI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 00:39:08 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43895 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbeC0EjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 00:39:07 -0400
X-Google-Smtp-Source: AG47ELvRniWOYowAUnPh509TzC4rmYsrYQKZUrrU12E9gEJ2onAHmS7Cua7ibtRmxqTy2ZvBqSY04w==
From: Baegjae Sung <baegjae@gmail.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        baegjae@gmail.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-multipath: implement active-active round-robin path selector
Date: Tue, 27 Mar 2018 13:38:51 +0900
Message-Id: <20180327043851.6640-1-baegjae@gmail.com>
X-Mailer: git-send-email 2.8.3.windows.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some storage environments (e.g., dual-port NVMe SSD) provide higher
performance when using multiple paths simultaneously. Choosing a
path from multiple paths in a round-robin fashion is a simple and
efficient way to meet these requirements.

We implement the active-active round-robin path selector that
chooses the path that is NVME_CTRL_LIVE and next to the previous
path. By maintaining the structure of the active-standby path
selector, we can easily switch between the active-standby path
selector and the active-active round-robin path selector.

Example usage)
  # cat /sys/block/nvme0n1/mpath_policy
  [active-standby] round-robin
  # echo round-robin > /sys/block/nvme0n1/mpath_policy
  # cat /sys/block/nvme0n1/mpath_policy
  active-standby [round-robin]

Below are the results from a physical dual-port NVMe SSD using fio.

(MB/s)                  active-standby     round-robin
Random Read (4k)            1,672             2,640
Sequential Read (128k)      1,707             3,414
Random Write (4k)           1,450             1,728
Sequential Write (128k)     1,481             2,708

A single thread was used for sequential workloads and 16 threads
were used for random workloads. The queue depth for each thread
was 64.

Signed-off-by: Baegjae Sung <baegjae@gmail.com>
---
 drivers/nvme/host/core.c      | 49 +++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/multipath.c | 45 ++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h      |  8 +++++++
 3 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7aeca5db7916..cc91e8b247d0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -68,6 +68,13 @@ static bool streams;
 module_param(streams, bool, 0644);
 MODULE_PARM_DESC(streams, "turn on support for Streams write directives");
 
+#ifdef CONFIG_NVME_MULTIPATH
+static const char *const mpath_policy_name[] = {
+	[NVME_MPATH_ACTIVE_STANDBY] = "active-standby",
+	[NVME_MPATH_ROUND_ROBIN] = "round-robin",
+};
+#endif
+
 /*
  * nvme_wq - hosts nvme related works that are not reset or delete
  * nvme_reset_wq - hosts nvme reset works
@@ -2603,12 +2610,51 @@ static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(nsid);
 
+#ifdef CONFIG_NVME_MULTIPATH
+static ssize_t mpath_policy_show(struct device *dev,
+	struct device_attribute *attr,
+	char *buf)
+{
+	int i, len = 0;
+	struct nvme_ns_head *head = dev_to_ns_head(dev);
+
+	for (i = 0;i < ARRAY_SIZE(mpath_policy_name);i++) {
+		if (i == head->mpath_policy)
+			len += sprintf(buf + len, "[%s] ", mpath_policy_name[i]);
+		else
+			len += sprintf(buf + len, "%s ", mpath_policy_name[i]);
+	}
+	len += sprintf(buf + len, "\n");
+	return len;
+}
+static ssize_t mpath_policy_store(struct device *dev,
+	struct device_attribute *attr, const char *buf,
+	size_t count)
+{
+	int i;
+	struct nvme_ns_head *head = dev_to_ns_head(dev);
+
+	for (i = 0;i < ARRAY_SIZE(mpath_policy_name);i++) {
+		if (strncmp(buf, mpath_policy_name[i], count - 1) == 0) {
+			head->mpath_policy = i;
+			dev_info(dev, "change mpath policy to %s\n", mpath_policy_name[i]);
+		}
+	}
+	return count;
+}
+static DEVICE_ATTR(mpath_policy, S_IRUGO | S_IWUSR, mpath_policy_show, \
+	mpath_policy_store);
+#endif
+
 static struct attribute *nvme_ns_id_attrs[] = {
 	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
 	&dev_attr_nguid.attr,
 	&dev_attr_eui.attr,
 	&dev_attr_nsid.attr,
+#ifdef CONFIG_NVME_MULTIPATH
+	&dev_attr_mpath_policy.attr,
+#endif
 	NULL,
 };
 
@@ -2818,6 +2864,9 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	head->subsys = ctrl->subsys;
 	head->ns_id = nsid;
 	kref_init(&head->ref);
+#ifdef CONFIG_NVME_MULTIPATH
+	head->mpath_policy = NVME_MPATH_ACTIVE_STANDBY;
+#endif
 
 	nvme_report_ns_ids(ctrl, nsid, id, &head->ids);
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 060f69e03427..6b6a15ccb542 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -75,6 +75,42 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 	return ns;
 }
 
+inline struct nvme_ns *nvme_find_path_rr(struct nvme_ns_head *head)
+{
+	struct nvme_ns *prev_ns = srcu_dereference(head->current_path, &head->srcu);
+	struct nvme_ns *ns, *cand_ns = NULL;
+	bool after_prev_ns = false;
+
+	/*
+	 * Active-active round-robin path selector
+	 * Choose the path that is NVME_CTRL_LIVE and next to the previous path
+	 */
+
+	/* Case 1. If there is no previous path, choose the first LIVE path */
+	if (!prev_ns) {
+		ns = __nvme_find_path(head);
+		return ns;
+	}
+
+	list_for_each_entry_rcu(ns, &head->list, siblings) {
+		/*
+		 * Case 2-1. Choose the first LIVE path from the next path of
+		 * previous path to end
+		 */
+		if (after_prev_ns && ns->ctrl->state == NVME_CTRL_LIVE) {
+			rcu_assign_pointer(head->current_path, ns);
+			return ns;
+		}
+		/* Case 2-2. Mark the first LIVE path from start to previous path */
+		if (!cand_ns && ns->ctrl->state == NVME_CTRL_LIVE)
+			cand_ns = ns;
+		if (ns == prev_ns)
+			after_prev_ns = true;
+	}
+	rcu_assign_pointer(head->current_path, cand_ns);
+	return cand_ns;
+}
+
 static blk_qc_t nvme_ns_head_make_request(struct request_queue *q,
 		struct bio *bio)
 {
@@ -85,7 +121,14 @@ static blk_qc_t nvme_ns_head_make_request(struct request_queue *q,
 	int srcu_idx;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	switch (head->mpath_policy) {
+	case NVME_MPATH_ROUND_ROBIN:
+		ns = nvme_find_path_rr(head);
+		break;
+	case NVME_MPATH_ACTIVE_STANDBY:
+	default:
+		ns = nvme_find_path(head);
+	}
 	if (likely(ns)) {
 		bio->bi_disk = ns->disk;
 		bio->bi_opf |= REQ_NVME_MPATH;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d733b14ede9d..15e1163bbf2b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -128,6 +128,13 @@ enum nvme_ctrl_state {
 	NVME_CTRL_DEAD,
 };
 
+#ifdef CONFIG_NVME_MULTIPATH
+enum nvme_mpath_policy {
+	NVME_MPATH_ACTIVE_STANDBY,
+	NVME_MPATH_ROUND_ROBIN, /* active-active round-robin */
+};
+#endif
+
 struct nvme_ctrl {
 	enum nvme_ctrl_state state;
 	bool identified;
@@ -250,6 +257,7 @@ struct nvme_ns_head {
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
 	struct work_struct	requeue_work;
+	enum nvme_mpath_policy	mpath_policy;
 #endif
 	struct list_head	list;
 	struct srcu_struct      srcu;
-- 
2.16.2
