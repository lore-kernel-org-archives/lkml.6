Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753986AbeCGMdz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:33:55 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36760 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbeCGMdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:33:50 -0500
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: lduncan@suse.com, cleech@redhat.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc: open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: iscsi_tcp: set BDI_CAP_STABLE_WRITES when data digest enabled
Date: Wed,  7 Mar 2018 20:29:03 +0800
Message-Id: <1520425743-1923-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8824 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803070146
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iscsi tcp will first send out data, then calculate and send data
digest. If we don't have BDI_CAP_STABLE_WRITES, the page cache will
be written in spite of the on going writeback. Consequently, wrong
digest will be got and sent to target.

To fix this, set BDI_CAP_STABLE_WRITES when data digest is enabled
in iscsi_tcp .slave_configure callback.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/scsi/iscsi_tcp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 6198559..261c686 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -37,6 +37,7 @@
 #include <linux/kfifo.h>
 #include <linux/scatterlist.h>
 #include <linux/module.h>
+#include <linux/backing-dev.h>
 #include <net/tcp.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_device.h>
@@ -954,6 +955,12 @@ static int iscsi_sw_tcp_slave_alloc(struct scsi_device *sdev)
 
 static int iscsi_sw_tcp_slave_configure(struct scsi_device *sdev)
 {
+	struct iscsi_sw_tcp_host *tcp_sw_host = iscsi_host_priv(sdev->host);
+	struct iscsi_session *session = tcp_sw_host->session;
+	struct iscsi_conn *conn = session->leadconn;
+
+	if (conn->datadgst_en)
+		sdev->request_queue->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;
 	blk_queue_bounce_limit(sdev->request_queue, BLK_BOUNCE_ANY);
 	blk_queue_dma_alignment(sdev->request_queue, 0);
 	return 0;
-- 
2.7.4
