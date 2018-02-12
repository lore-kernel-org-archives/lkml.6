Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935013AbeBLMz3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 07:55:29 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56580 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933341AbeBLMzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 07:55:24 -0500
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] nvme: fix the deadlock in nvme_update_formats
Date: Mon, 12 Feb 2018 20:54:45 +0800
Message-Id: <1518440086-583-2-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518440086-583-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1518440086-583-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8802 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=681
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802120167
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvme_update_formats will invoke nvme_ns_remove under namespaces_mutext.
The will cause deadlock because nvme_ns_remove will also require
the namespaces_mutext. Fix it by getting the ns entries which should
be removed under namespaces_mutext and invoke nvme_ns_remove out of
namespaces_mutext.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d05855b..a051c2f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1119,14 +1119,19 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 static void nvme_update_formats(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ns *ns;
+	struct nvme_ns *ns, *next;
+	LIST_HEAD(rm_list);
 
 	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		if (ns->disk && nvme_revalidate_disk(ns->disk))
-			nvme_ns_remove(ns);
+		if (ns->disk && nvme_revalidate_disk(ns->disk)) {
+			list_move_tail(&ns->list, &rm_list);
+		}
 	}
 	mutex_unlock(&ctrl->namespaces_mutex);
+
+	list_for_each_entry_safe(ns, next, &rm_list, list)
+		nvme_ns_remove(ns);
 }
 
 static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
-- 
2.7.4
