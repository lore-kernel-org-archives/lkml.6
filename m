Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbeDSI3F (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 04:29:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49704 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751110AbeDSI3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 04:29:03 -0400
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: unquiesce the queue before cleaup it
Date: Thu, 19 Apr 2018 16:29:13 +0800
Message-Id: <1524126553-16290-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8867 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=728
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804190074
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is race between nvme_remove and nvme_reset_work that can
lead to io hang.

nvme_remove                    nvme_reset_work
-> change state to DELETING
                               -> fail to change state to LIVE
                               -> nvme_remove_dead_ctrl
                                 -> nvme_dev_disable
                                   -> quiesce request_queue
                                 -> queue remove_work
-> cancel_work_sync reset_work
-> nvme_remove_namespaces
  -> splice ctrl->namespaces
                               nvme_remove_dead_ctrl_work
                               -> nvme_kill_queues
  -> nvme_ns_remove               do nothing
    -> blk_cleanup_queue
      -> blk_freeze_queue
Finally, the request_queue is quiesced state when wait freeze,
we will get io hang here.

To fix it, unquiesce the request_queue directly before nvme_ns_remove.
We have spliced the ctrl->namespaces, so nobody could access them
and quiesce the queue any more.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9df4f71..0e95082 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3249,8 +3249,15 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	list_splice_init(&ctrl->namespaces, &ns_list);
 	up_write(&ctrl->namespaces_rwsem);
 
-	list_for_each_entry_safe(ns, next, &ns_list, list)
+	/*
+	 * After splice the namespaces list from the ctrl->namespaces,
+	 * nobody could get them anymore, let's unquiesce the request_queue
+	 * forcibly to avoid io hang.
+	 */
+	list_for_each_entry_safe(ns, next, &ns_list, list) {
+		blk_mq_unquiesce_queue(ns->queue);
 		nvme_ns_remove(ns);
+	}
 }
 EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
 
-- 
2.7.4
