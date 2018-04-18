Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753330AbeDRHcg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 03:32:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42776 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752947AbeDRHcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 03:32:35 -0400
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: fix the suspicious RCU usage warning in nvme_mpath_clear_current_path
Date: Wed, 18 Apr 2018 15:32:47 +0800
Message-Id: <1524036767-3701-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8866 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=974
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804180070
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With lockdep enabled, when trigger nvme_remove, suspicious RCU
usage warning will be printed out.
Fix it with adding srcu_read_lock/unlock in it.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/nvme.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 061fecf..d326c23 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -446,9 +446,14 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head);
 static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
 	struct nvme_ns_head *head = ns->head;
+	int srcu_idx;
 
-	if (head && ns == srcu_dereference(head->current_path, &head->srcu))
-		rcu_assign_pointer(head->current_path, NULL);
+	if (head) {
+		srcu_idx = srcu_read_lock(&head->srcu);
+		if (ns == srcu_dereference(head->current_path, &head->srcu))
+			rcu_assign_pointer(head->current_path, NULL);
+		srcu_read_unlock(&head->srcu, srcu_idx);
+	}
 }
 struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
 
-- 
2.7.4
