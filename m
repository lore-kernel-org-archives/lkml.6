Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753320AbeBKJkP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 04:40:15 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:47126 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753230AbeBKJjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 04:39:46 -0500
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] nvme-pci: quiesce IO queues prior to disabling device HMB accesses
Date: Sun, 11 Feb 2018 17:38:35 +0800
Message-Id: <1518341920-1060-5-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8801 signatures=668668
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802110127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quiesce IO queues prior to disabling device HMB accesses. A controller
using HMB may relay on it to efficiently complete IO commands.

Reviewed-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/pci.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6fe7af0..00cffed 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2186,7 +2186,10 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	if (!dead) {
 		if (shutdown)
 			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
+	}
+	nvme_stop_queues(&dev->ctrl);
 
+	if (!dead) {
 		/*
 		 * If the controller is still alive tell it to stop using the
 		 * host memory buffer.  In theory the shutdown / reset should
@@ -2195,11 +2198,6 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		 */
 		if (dev->host_mem_descs)
 			nvme_set_host_mem(dev, 0);
-
-	}
-	nvme_stop_queues(&dev->ctrl);
-
-	if (!dead) {
 		nvme_disable_io_queues(dev);
 		nvme_disable_admin_queue(dev, shutdown);
 	}
-- 
2.7.4
