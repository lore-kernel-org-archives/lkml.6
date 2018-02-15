Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967847AbeBOLOE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 06:14:04 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:49184 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966589AbeBOLOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 06:14:03 -0500
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] nvme-pci: set cq_vector to -1 if io queue setup fails
Date: Thu, 15 Feb 2018 19:13:41 +0800
Message-Id: <1518693221-2430-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8805 signatures=668671
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802150139
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvme cq irq is freed based on queue_count. When the sq/cq creation
fails, irq will not be setup. free_irq will warn 'Try to free
already-free irq'.

To fix it, set the nvmeq->cq_vector to -1, then nvme_suspend_queue
will ignore it.

Change log:
V1 -> V2
 - Follow Keith's suggestion, just set cq_vector to -1 if io queue setup
   fails.
 - Change patch name and comment

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/pci.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4a7c420..f4528ef 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1452,7 +1452,7 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	nvmeq->cq_vector = qid - 1;
 	result = adapter_alloc_cq(dev, qid, nvmeq);
 	if (result < 0)
-		return result;
+		goto clean_cq_vector;
 
 	result = adapter_alloc_sq(dev, qid, nvmeq);
 	if (result < 0)
@@ -1461,14 +1461,17 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	nvme_init_queue(nvmeq, qid);
 	result = queue_request_irq(nvmeq);
 	if (result < 0)
-		goto release_sq;
+		goto offline;
 
 	return result;
 
- release_sq:
+offline:
+	dev->online_queues--;
 	adapter_delete_sq(dev, qid);
- release_cq:
+release_cq:
 	adapter_delete_cq(dev, qid);
+clean_cq_vector:
+	nvmeq->cq_vector = -1;
 	return result;
 }
 
-- 
2.7.4
