Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752804AbeBEJVg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 04:21:36 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52048 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752583AbeBEJUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 04:20:54 -0500
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 6/6] nvme-pci: discard wait timeout when delete cq/sq
Date: Mon,  5 Feb 2018 17:20:15 +0800
Message-Id: <1517822415-11710-7-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517822415-11710-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1517822415-11710-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8795 signatures=668662
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802050117
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, nvme_disable_io_queues could be wakeup by both request
completion and wait timeout path. This is unnecessary and could
introduce race between nvme_dev_disable and request timeout path.
When delete cq/sq command expires, the nvme_disable_io_queues will
also be wakeup and return to nvme_dev_disable, then handle the
outstanding requests. This will race with the request timeout path.

To fix it, just use wait_for_completion instead of the timeout one.
The request timeout path will wakeup it.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/nvme/host/pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 43033fc..f3262cc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2050,7 +2050,6 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 static void nvme_disable_io_queues(struct nvme_dev *dev)
 {
 	int pass, queues = dev->online_queues - 1;
-	unsigned long timeout;
 	u8 opcode = nvme_admin_delete_sq;
 
 	for (pass = 0; pass < 2; pass++) {
@@ -2058,15 +2057,12 @@ static void nvme_disable_io_queues(struct nvme_dev *dev)
 
 		reinit_completion(&dev->ioq_wait);
  retry:
-		timeout = ADMIN_TIMEOUT;
 		for (; i > 0; i--, sent++)
 			if (nvme_delete_queue(&dev->queues[i], opcode))
 				break;
 
 		while (sent--) {
-			timeout = wait_for_completion_io_timeout(&dev->ioq_wait, timeout);
-			if (timeout == 0)
-				return;
+			wait_for_completion(&dev->ioq_wait);
 			if (i)
 				goto retry;
 		}
-- 
2.7.4
