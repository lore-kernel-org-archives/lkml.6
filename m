Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936122AbeEYMyd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:54:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:40259 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752784AbeEYMxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:53:38 -0400
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Laurence Oberman <loberman@redhat.com>, Ewan Milne <emilne@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 1/3] nvme: provide a way to disable nvme mpath per subsystem
Date: Fri, 25 May 2018 14:53:20 +0200
Message-Id: <20180525125322.15398-2-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180525125322.15398-1-jthumshirn@suse.de>
References: <20180525125322.15398-1-jthumshirn@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a way to disable NVMe native multipathing on a per-subsystem
basis to enable a user to use dm-mpath and nvme native multipathing on
the same host for different nvme devices.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/nvme/host/core.c      | 63 +++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/multipath.c | 34 +++++++++++++++++++----
 drivers/nvme/host/nvme.h      |  8 ++++++
 3 files changed, 100 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 99b857e5a7a9..3a1c70bd9008 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2082,6 +2082,10 @@ static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
 	return NULL;
 }
 
+#define SUBSYS_ATTR_RW(_name)			      \
+	struct device_attribute subsys_attr_##_name = \
+		__ATTR_RW(_name)
+
 #define SUBSYS_ATTR_RO(_name, _mode, _show)			\
 	struct device_attribute subsys_attr_##_name = \
 		__ATTR(_name, _mode, _show, NULL)
@@ -2112,11 +2116,62 @@ nvme_subsys_show_str_function(model);
 nvme_subsys_show_str_function(serial);
 nvme_subsys_show_str_function(firmware_rev);
 
+
+#ifdef CONFIG_NVME_MULTIPATH
+static ssize_t mpath_personality_show(struct device *dev,
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct nvme_subsystem *subsys =
+		container_of(dev, struct nvme_subsystem, dev);
+	ssize_t ret;
+
+	if (subsys->native_mpath)
+		ret = scnprintf(buf, PAGE_SIZE, "[native] other\n");
+	else
+		ret = scnprintf(buf, PAGE_SIZE, "native [other]\n");
+
+	return ret;
+}
+
+static ssize_t mpath_personality_store(struct device *dev,
+				  struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct nvme_subsystem *subsys =
+		container_of(dev, struct nvme_subsystem, dev);
+	bool native_mpath = false;
+	int ret = 0;
+
+	if (!strncmp(buf, "native", strlen("native")))
+		native_mpath = true;
+	else if (!strncmp(buf, "other", strlen("other")))
+		native_mpath = false;
+	else {
+		pr_warn("unknown value %s\n", buf);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (subsys->native_mpath != native_mpath) {
+		subsys->native_mpath = native_mpath;
+		ret = nvme_mpath_change_personality(subsys);
+	}
+
+out:
+	return ret ? ret : count;
+}
+static SUBSYS_ATTR_RW(mpath_personality);
+#endif
+
 static struct attribute *nvme_subsys_attrs[] = {
 	&subsys_attr_model.attr,
 	&subsys_attr_serial.attr,
 	&subsys_attr_firmware_rev.attr,
 	&subsys_attr_subsysnqn.attr,
+#ifdef CONFIG_NVME_MULTIPATH
+	&subsys_attr_mpath_personality.attr,
+#endif
 	NULL,
 };
 
@@ -2220,6 +2275,10 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
 	mutex_unlock(&subsys->lock);
 
+#ifdef CONFIG_NVME_MULTIPATH
+	subsys->native_mpath = nvme_multipath;
+#endif
+
 	return 0;
 
 out_unlock:
@@ -2850,6 +2909,10 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	head->ns_id = nsid;
 	kref_init(&head->ref);
 
+#ifdef CONFIG_NVME_MULTIPATH
+	head->native_mpath = ctrl->subsys->native_mpath;
+#endif
+
 	nvme_report_ns_ids(ctrl, nsid, id, &head->ids);
 
 	ret = __nvme_check_ids(ctrl->subsys, head);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d7b664ae5923..53d2610605ca 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -14,8 +14,8 @@
 #include <linux/moduleparam.h>
 #include "nvme.h"
 
-static bool multipath = true;
-module_param(multipath, bool, 0444);
+bool nvme_multipath = true;
+module_param_named(multipath, nvme_multipath, bool, 0444);
 MODULE_PARM_DESC(multipath,
 	"turn on native support for multiple controllers per subsystem");
 
@@ -29,7 +29,7 @@ MODULE_PARM_DESC(multipath,
 void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 			struct nvme_ctrl *ctrl, int *flags)
 {
-	if (!multipath) {
+	if (!ctrl->subsys->native_mpath) {
 		sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
 	} else if (ns->head->disk) {
 		sprintf(disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
@@ -181,7 +181,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	 * We also do this for private namespaces as the namespace sharing data could
 	 * change after a rescan.
 	 */
-	if (!(ctrl->subsys->cmic & (1 << 1)) || !multipath)
+	if (!(ctrl->subsys->cmic & (1 << 1)) || !ctrl->subsys->native_mpath)
 		return 0;
 
 	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE, NULL);
@@ -218,7 +218,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 
 void nvme_mpath_add_disk(struct nvme_ns_head *head)
 {
-	if (!head->disk)
+	if (!head->disk || !head->native_mpath)
 		return;
 
 	mutex_lock(&head->subsys->lock);
@@ -246,3 +246,27 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 	blk_cleanup_queue(head->disk->queue);
 	put_disk(head->disk);
 }
+
+int nvme_mpath_change_personality(struct nvme_subsystem *subsys)
+{
+	struct nvme_ctrl *ctrl;
+	int ret = 0;
+
+restart:
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		if (!list_empty(&ctrl->namespaces)) {
+			mutex_unlock(&subsys->lock);
+			nvme_remove_namespaces(ctrl);
+			goto restart;
+		}
+	}
+	mutex_unlock(&subsys->lock);
+
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
+		nvme_queue_scan(ctrl);
+	mutex_unlock(&subsys->lock);
+
+	return ret;
+}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 17d2f7cf3fed..f7253c074a89 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -32,6 +32,8 @@ extern unsigned int admin_timeout;
 #define NVME_DEFAULT_KATO	5
 #define NVME_KATO_GRACE		10
 
+extern bool nvme_multipath;
+
 extern struct workqueue_struct *nvme_wq;
 extern struct workqueue_struct *nvme_reset_wq;
 extern struct workqueue_struct *nvme_delete_wq;
@@ -232,6 +234,10 @@ struct nvme_subsystem {
 	u8			cmic;
 	u16			vendor_id;
 	struct ida		ns_ida;
+
+#ifdef CONFIG_NVME_MULTIPATH
+	bool native_mpath;
+#endif
 };
 
 /*
@@ -257,6 +263,7 @@ struct nvme_ns_head {
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
 	struct work_struct	requeue_work;
+	bool native_mpath;
 #endif
 	struct list_head	list;
 	struct srcu_struct      srcu;
@@ -449,6 +456,7 @@ void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns_head *head);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
+int nvme_mpath_change_personality(struct nvme_subsystem *subsys);
 
 static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
-- 
2.16.3
