Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753228AbeBKJjp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 04:39:45 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:54604 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753178AbeBKJjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 04:39:43 -0500
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] nvme: fix the dangerous reference of namespaces list
Date: Sun, 11 Feb 2018 17:38:32 +0800
Message-Id: <1518341920-1060-2-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8801 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=801
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802110127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvme_remove_namespaces and nvme_remove_invalid_namespaces reference
the ctrl->namespaces list w/o holding namespaces_mutext. It is ok
to invoke nvme_ns_remove there, but what if there is others.

To be safer, reference the ctrl->namespaces list under
namespaces_mutext.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/core.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e810487..bc05bc4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3092,11 +3092,20 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					unsigned nsid)
 {
 	struct nvme_ns *ns, *next;
+	LIST_HEAD(rm_list);
 
+	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
-		if (ns->head->ns_id > nsid)
-			nvme_ns_remove(ns);
+		if (ns->head->ns_id > nsid) {
+			list_del_init(&ns->list);
+			list_add_tail(&ns->list, &rm_list);
+		}
 	}
+	mutex_unlock(&ctrl->namespaces_mutex);
+
+	list_for_each_entry_safe(ns, next, &rm_list, list)
+		nvme_ns_remove(ns);
+
 }
 
 static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
@@ -3196,6 +3205,7 @@ EXPORT_SYMBOL_GPL(nvme_queue_scan);
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns, *next;
+	LIST_HEAD(ns_list);
 
 	/*
 	 * The dead states indicates the controller was not gracefully
@@ -3206,7 +3216,11 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	if (ctrl->state == NVME_CTRL_DEAD)
 		nvme_kill_queues(ctrl);
 
-	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list)
+	mutex_lock(&ctrl->namespaces_mutex);
+	list_splice_init(&ctrl->namespaces, &ns_list);
+	mutex_unlock(&ctrl->namespaces_mutex);
+
+	list_for_each_entry_safe(ns, next, &ns_list, list)
 		nvme_ns_remove(ns);
 }
 EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
-- 
2.7.4
