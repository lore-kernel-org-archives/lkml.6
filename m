Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932549AbeE1R6x (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 13:58:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932242AbeE1R6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 13:58:51 -0400
From: "Rodrigo R. Galvao" <rosattig@linux.vnet.ibm.com>
Cc: rosattig@linux.vnet.ibm.com, maurosr@linux.vnet.ibm.com,
        kernel@gpiccoli.net, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla2xxx: Fix crash on qla2x00_mailbox_command
Date: Mon, 28 May 2018 14:58:44 -0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18052817-0016-0000-0000-000008D19725
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009096; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000263; SDB=6.01038988; UDB=6.00531726; IPR=6.00818116;
 MB=3.00021343; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-28 17:58:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052817-0017-0000-0000-00003EF764D8
Message-Id: <1527530324-32359-1-git-send-email-rosattig@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805280214
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a crash on qla2x00_mailbox_command caused when the
driver is on UNLOADING state and tries to call qla2x00_poll, which
triggers a NULL pointer dereference.

Signed-off-by: Rodrigo R. Galvao <rosattig@linux.vnet.ibm.com>
Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
---
 drivers/scsi/qla2xxx/qla_mbx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index d8a36c1..7e875f5 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -292,6 +292,14 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 			if (time_after(jiffies, wait_time))
 				break;
 
+			/*
+			 * Check if it's UNLOADING, cause we cannot poll in
+			 * this case, or else a NULL pointer dereference
+			 * is triggered.
+			 */
+			if (unlikely(test_bit(UNLOADING, &base_vha->dpc_flags)))
+				return QLA_FUNCTION_TIMEOUT;
+
 			/* Check for pending interrupts. */
 			qla2x00_poll(ha->rsp_q_map[0]);
 
-- 
2.7.4
