Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965869AbeEXJP1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 05:15:27 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51894 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965445AbeEXJPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 05:15:21 -0400
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: qla2xxx-upstream@cavium.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla2xxx: reduce the time granularity of the qla2x00_eh_wait_on_command
Date: Thu, 24 May 2018 17:16:10 +0800
Message-Id: <1527153370-1741-1-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8902 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=787
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805240111
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the cmd has not be returned after aborted by qla2x00_eh_abort,
when qla2x00_eh_wait_on_command is invoked, it has to wait for it.
However, the time is 1000ms at least currently. If there are a lot
cmds need to be aborted, the delay could be long enough to lead to
panic due to such as hung task, ocfs2 heartbeat, etc, just before
scsi recovery work completes and get back the HBA.

Change the granularity to 1ms, even though more context switches
would be introduced, but it should be ok as it is not hot path.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 15eaa6d..9ea4e02 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1064,7 +1064,7 @@ qla2xxx_mqueuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd,
 static int
 qla2x00_eh_wait_on_command(struct scsi_cmnd *cmd)
 {
-#define ABORT_POLLING_PERIOD	1000
+#define ABORT_POLLING_PERIOD	1
 #define ABORT_WAIT_ITER		((2 * 1000) / (ABORT_POLLING_PERIOD))
 	unsigned long wait_iter = ABORT_WAIT_ITER;
 	scsi_qla_host_t *vha = shost_priv(cmd->device->host);
-- 
2.7.4
