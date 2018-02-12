Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935082AbeBLM6E (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:58:04 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57034 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935065AbeBLM6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:58:00 -0500
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] nvme: fix the dangerous reference of namespaces list
Date: Mon, 12 Feb 2018 20:54:44 +0800
Message-Id: <1518440086-583-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8802 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=812
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802120168
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
 drivers/nvme/host/core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2fd8688..d05855b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3094,11 +3094,18 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					unsigned nsid)
 {
 	struct nvme_ns *ns, *next;
+	LIST_HEAD(rm_list);
 
+	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
 		if (ns->head->ns_id > nsid)
-			nvme_ns_remove(ns);
+			list_move_tail(&ns->list, &rm_list);
 	}
+	mutex_unlock(&ctrl->namespaces_mutex);
+
+	list_for_each_entry_safe(ns, next, &rm_list, list)
+		nvme_ns_remove(ns);
+
 }
 
 static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
@@ -3198,6 +3205,7 @@ EXPORT_SYMBOL_GPL(nvme_queue_scan);
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns, *next;
+	LIST_HEAD(ns_list);
 
 	/*
 	 * The dead states indicates the controller was not gracefully
@@ -3208,7 +3216,11 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
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
