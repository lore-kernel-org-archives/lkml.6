Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752096AbeB1IzF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 03:55:05 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47368 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbeB1IzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 03:55:03 -0500
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc: Bart.VanAssche@wdc.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2] scsi: core: use blk_mq_requeue_request in __scsi_queue_insert
Date: Wed, 28 Feb 2018 16:55:13 +0800
Message-Id: <1519808113-2863-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8817 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280108
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In scsi core, __scsi_queue_insert should just put request back on
the queue and retry using the same command as before. However, for
blk-mq, scsi_mq_requeue_cmd is employed here which will unprepare
the request. To align with the semantics of __scsi_queue_insert,
use blk_mq_requeue_request with kick_requeue_list == true and put
the reference of scsi_device.

V1 -> V2:
 - add put_device on scsi_device->sdev_gendev

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/scsi/scsi_lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index a86df9c..6fa7b0c 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -191,7 +191,8 @@ static void __scsi_queue_insert(struct scsi_cmnd *cmd, int reason, bool unbusy)
 	 */
 	cmd->result = 0;
 	if (q->mq_ops) {
-		scsi_mq_requeue_cmd(cmd);
+		blk_mq_requeue_request(cmd->request, true);
+		put_device(&device->sdev_gendev);
 		return;
 	}
 	spin_lock_irqsave(q->queue_lock, flags);
-- 
2.7.4
