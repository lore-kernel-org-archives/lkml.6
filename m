Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbeB1HGR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 02:06:17 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43969 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751631AbeB1HGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 02:06:15 -0500
X-Google-Smtp-Source: AH8x227J3V3Dg9rvfgoTe/8XFc5gfKkVBxTJuc0leinYIBjpfs3Fbm+Uf8n4WNiMYA6Q6j7qfUua9g==
From: Baegjae Sung <baegjae@gmail.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        baegjae@gmail.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvme-multipath: fix sysfs dangerously created links
Date: Wed, 28 Feb 2018 16:06:04 +0900
Message-Id: <20180228070604.25868-1-baegjae@gmail.com>
X-Mailer: git-send-email 2.8.3.windows.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If multipathing is enabled, each NVMe subsystem creates a head
namespace (e.g., nvme0n1) and multiple private namespaces
(e.g., nvme0c0n1 and nvme0c1n1) in sysfs. When creating links for
private namespaces, links of head namespace are used, so the
namespace creation order must be followed (e.g., nvme0n1 ->
nvme0c1n1). If the order is not followed, links of sysfs will be
incomplete or kernel panic will occur.

The kernel panic was:
  kernel BUG at fs/sysfs/symlink.c:27!
  Call Trace:
    nvme_mpath_add_disk_links+0x5d/0x80 [nvme_core]
    nvme_validate_ns+0x5c2/0x850 [nvme_core]
    nvme_scan_work+0x1af/0x2d0 [nvme_core]

Correct order
Context A     Context B
nvme0n1
nvme0c0n1     nvme0c1n1

Incorrect order
Context A     Context B
              nvme0c1n1
nvme0n1
nvme0c0n1

The nvme_mpath_add_disk (for creating head namespace) is called
just before the nvme_mpath_add_disk_links (for creating private
namespaces). In nvme_mpath_add_disk, the first context acquires
the lock of subsystem and creates a head namespace, and other
contexts do nothing by checking GENHD_FL_UP of a head namespace
after waiting to acquire the lock. We verified the code with or
without multipathing using three vendors of dual-port NVMe SSDs.

Signed-off-by: Baegjae Sung <baegjae@gmail.com>
---
 drivers/nvme/host/core.c      | 12 +++---------
 drivers/nvme/host/multipath.c | 15 ++++++++++-----
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0fe7ea35c221..817e5e2766da 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2844,7 +2844,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 }
 
 static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
-		struct nvme_id_ns *id, bool *new)
+		struct nvme_id_ns *id)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	bool is_shared = id->nmic & (1 << 0);
@@ -2860,8 +2860,6 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 			ret = PTR_ERR(head);
 			goto out_unlock;
 		}
-
-		*new = true;
 	} else {
 		struct nvme_ns_ids ids;
 
@@ -2873,8 +2871,6 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 			ret = -EINVAL;
 			goto out_unlock;
 		}
-
-		*new = false;
 	}
 
 	list_add_tail(&ns->siblings, &head->list);
@@ -2945,7 +2941,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	struct nvme_id_ns *id;
 	char disk_name[DISK_NAME_LEN];
 	int node = dev_to_node(ctrl->dev), flags = GENHD_FL_EXT_DEVT;
-	bool new = true;
 
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
@@ -2971,7 +2966,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (id->ncap == 0)
 		goto out_free_id;
 
-	if (nvme_init_ns_head(ns, nsid, id, &new))
+	if (nvme_init_ns_head(ns, nsid, id))
 		goto out_free_id;
 	nvme_setup_streams_ns(ctrl, ns);
 	
@@ -3037,8 +3032,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		pr_warn("%s: failed to register lightnvm sysfs group for identification\n",
 			ns->disk->disk_name);
 
-	if (new)
-		nvme_mpath_add_disk(ns->head);
+	nvme_mpath_add_disk(ns->head);
 	nvme_mpath_add_disk_links(ns);
 	return;
  out_unlink_ns:
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 3b211d9e58b8..b7e5c6db4d92 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -198,11 +198,16 @@ void nvme_mpath_add_disk(struct nvme_ns_head *head)
 {
 	if (!head->disk)
 		return;
-	device_add_disk(&head->subsys->dev, head->disk);
-	if (sysfs_create_group(&disk_to_dev(head->disk)->kobj,
-			&nvme_ns_id_attr_group))
-		pr_warn("%s: failed to create sysfs group for identification\n",
-			head->disk->disk_name);
+
+	mutex_lock(&head->subsys->lock);
+	if (!(head->disk->flags & GENHD_FL_UP)) {
+		device_add_disk(&head->subsys->dev, head->disk);
+		if (sysfs_create_group(&disk_to_dev(head->disk)->kobj,
+				&nvme_ns_id_attr_group))
+			pr_warn("%s: failed to create sysfs group for identification\n",
+				head->disk->disk_name);
+	}
+	mutex_unlock(&head->subsys->lock);
 }
 
 void nvme_mpath_add_disk_links(struct nvme_ns *ns)
-- 
2.16.2
