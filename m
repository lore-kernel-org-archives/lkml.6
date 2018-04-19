Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753829AbeDSOuC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:50:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49586 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753435AbeDSOt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:49:57 -0400
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
To: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, cohuck@redhat.com
Subject: [PATCH 09/10] vfio: ccw: Suppressing the BOXED state
Date: Thu, 19 Apr 2018 16:48:12 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041914-0040-0000-0000-00000430CE35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041914-0041-0000-0000-00002634E5E6
Message-Id: <1524149293-12658-10-git-send-email-pmorel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804190131
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VFIO_CCW_STATE_BOXED and VFIO_CCW_STATE_BUSY are the same
states.
Let's only keep one: VFIO_CCW_STATE_BUSY

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c     | 9 ---------
 drivers/s390/cio/vfio_ccw_private.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 444424e..b77b8ad 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -261,15 +261,6 @@ fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 		[VFIO_CCW_EVENT_SCH_EVENT]	= fsm_sch_event,
 	},
-	[VFIO_CCW_STATE_BOXED] = {
-		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
-		[VFIO_CCW_EVENT_ONLINE]		= fsm_nop,
-		[VFIO_CCW_EVENT_OFFLINE]	= fsm_quiescing,
-		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
-		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_busy,
-		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
-		[VFIO_CCW_EVENT_SCH_EVENT]	= fsm_sch_event,
-	},
 	[VFIO_CCW_STATE_BUSY] = {
 		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
 		[VFIO_CCW_EVENT_ONLINE]		= fsm_nop,
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index e7ea076..dbef727 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -66,7 +66,6 @@ enum vfio_ccw_state {
 	VFIO_CCW_STATE_NOT_OPER,
 	VFIO_CCW_STATE_STANDBY,
 	VFIO_CCW_STATE_IDLE,
-	VFIO_CCW_STATE_BOXED,
 	VFIO_CCW_STATE_BUSY,
 	VFIO_CCW_STATE_QUIESCING,
 	/* last element! */
-- 
2.7.4
