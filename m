Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbeBBG4v (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 01:56:51 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57904 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751664AbeBBGz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 01:55:57 -0500
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] nvme-pci: fix the freeze and quiesce for shutdown and reset case
Date: Fri,  2 Feb 2018 14:54:48 +0800
Message-Id: <1517554492-7680-3-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517554492-7680-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1517554492-7680-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8792 signatures=668660
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802020079
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, request queue will be frozen and quiesced for both reset
and shutdown case. This will trigger ioq requests in RECONNECTING
state which should be avoided to prepare for following patch.
Just freeze request queue for shutdown case and drain all the resudual
entered requests after controller has been shutdown.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/pci.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 00cffed..a7fa397 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2172,21 +2172,23 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	if (pci_is_enabled(pdev)) {
 		u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
-		if (dev->ctrl.state == NVME_CTRL_LIVE ||
-		    dev->ctrl.state == NVME_CTRL_RESETTING)
-			nvme_start_freeze(&dev->ctrl);
 		dead = !!((csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY) ||
 			pdev->error_state  != pci_channel_io_normal);
 	}
 
-	/*
-	 * Give the controller a chance to complete all entered requests if
-	 * doing a safe shutdown.
-	 */
-	if (!dead) {
-		if (shutdown)
+	/* Just freeze the queue for shutdown case */
+	if (shutdown) {
+		if (dev->ctrl.state == NVME_CTRL_LIVE ||
+			dev->ctrl.state == NVME_CTRL_RESETTING)
+			nvme_start_freeze(&dev->ctrl);
+		/*
+		 * Give the controller a chance to complete all
+		 * entered requests if doing a safe shutdown.
+		 */
+		if (!dead)
 			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
 	}
+
 	nvme_stop_queues(&dev->ctrl);
 
 	if (!dead) {
@@ -2210,12 +2212,15 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);
 
 	/*
-	 * The driver will not be starting up queues again if shutting down so
-	 * must flush all entered requests to their failed completion to avoid
-	 * deadlocking blk-mq hot-cpu notifier.
+	 * For shutdown case, controller will not be setup again soon. If any
+	 * residual requests here, the controller must have go wrong. Drain and
+	 * fail all the residual entered IO requests.
 	 */
-	if (shutdown)
+	if (shutdown) {
 		nvme_start_queues(&dev->ctrl);
+		nvme_wait_freeze(&dev->ctrl);
+		nvme_stop_queues(&dev->ctrl);
+	}
 	mutex_unlock(&dev->shutdown_lock);
 }
 
@@ -2349,12 +2354,11 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_remove_namespaces(&dev->ctrl);
 		new_state = NVME_CTRL_ADMIN_ONLY;
 	} else {
-		nvme_start_queues(&dev->ctrl);
-		nvme_wait_freeze(&dev->ctrl);
 		/* hit this only when allocate tagset fails */
 		if (nvme_dev_add(dev))
 			new_state = NVME_CTRL_ADMIN_ONLY;
-		nvme_unfreeze(&dev->ctrl);
+		if (was_suspend)
+			nvme_unfreeze(&dev->ctrl);
 	}
 
 	/*
-- 
2.7.4
