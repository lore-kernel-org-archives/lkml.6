Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966021AbeCHGUi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 01:20:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37232 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965986AbeCHGUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 01:20:36 -0500
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 5/5] nvme-pci: add the timeout case for DELETEING state
Date: Thu,  8 Mar 2018 14:19:31 +0800
Message-Id: <1520489971-31174-6-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8825 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803080079
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the controller is being removed, blk_cleanup_queue will try
to drain the queues. At the moment, if the controller no response,
because of DELETEING state, reset_work will not be able to be
scheduled, and completion of the expired request is deferred to
nvme_dev_disable, blk_cleanup_queue will hang forever. Add case
for DELETEING in nvme_timeout, when abort fails, disable the
controller and complete the request directly.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/pci.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6c7c19cb..ac9efcd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1261,11 +1261,30 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	}
 
 	if (nvmeq->qid) {
-		if (dev->ctrl.state == NVME_CTRL_RESETTING ||
-				iod->aborted)
+		switch (dev->ctrl.state) {
+		case NVME_CTRL_RESETTING:
 			action = RESET;
-		else
-			action = ABORT;
+			break;
+		case NVME_CTRL_DELETING:
+			/*
+			 * When ctrl is being removed, we try to abort the
+			 * expired request first, if success, it will be
+			 * requeued, otherwise, disable the controller and
+			 * complete it directly, because we cannot schedule
+			 * the reset_work to do recovery in DELELTING state.
+			 */
+			if (iod->aborted)
+				action = DISABLE;
+			else
+				action = ABORT;
+			break;
+		default:
+			if (iod->aborted)
+				action = RESET;
+			else
+				action = ABORT;
+			break;
+		}
 	} else {
 		/*
 		 * Disable immediately if controller times out while disabling/
-- 
2.7.4
