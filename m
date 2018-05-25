Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966091AbeEYKVk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:21:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965661AbeEYKVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:21:36 -0400
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
To: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, cohuck@redhat.com
Subject: [PATCH v2 09/10] vfio: ccw: Suppressing the BOXED state
Date: Fri, 25 May 2018 12:21:17 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527243678-3140-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1527243678-3140-1-git-send-email-pmorel@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052510-0012-0000-0000-000005DA7F94
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052510-0013-0000-0000-00001957D352
Message-Id: <1527243678-3140-10-git-send-email-pmorel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-25_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805250113
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VFIO_CCW_STATE_BOXED and VFIO_CCW_STATE_BUSY are the same
states.
Let's only keep one: VFIO_CCW_STATE_BUSY

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c     | 11 -----------
 drivers/s390/cio/vfio_ccw_private.h |  1 -
 2 files changed, 12 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 0acab2f..c37052d 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -162,8 +162,6 @@ static int fsm_io_request(struct vfio_ccw_private *private)
 	struct ccw_io_region *io_region = &private->io_region;
 	struct mdev_device *mdev = private->mdev;
 
-	private->state = VFIO_CCW_STATE_BOXED;
-
 	orb = (union orb *)io_region->orb_area;
 
 	io_region->ret_code = cp_init(&private->cp, mdev_dev(mdev), orb);
@@ -263,15 +261,6 @@ fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
 	},
-	[VFIO_CCW_STATE_BOXED] = {
-		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
-		[VFIO_CCW_EVENT_ONLINE]		= fsm_nop,
-		[VFIO_CCW_EVENT_OFFLINE]	= fsm_quiescing,
-		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
-		[VFIO_CCW_EVENT_SSCH_REQ]	= fsm_io_busy,
-		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
-		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
-	},
 	[VFIO_CCW_STATE_BUSY] = {
 		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
 		[VFIO_CCW_EVENT_ONLINE]		= fsm_nop,
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index ad59091..ab5e37fa 100644
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
