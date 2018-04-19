Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753481AbeDSOss (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:48:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752291AbeDSOsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:48:46 -0400
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
To: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, cohuck@redhat.com
Subject: [PATCH 05/10] vfio: ccw: Suppress unused event parameter
Date: Thu, 19 Apr 2018 16:48:08 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041914-0020-0000-0000-00000413BD36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041914-0021-0000-0000-000042A80A47
Message-Id: <1524149293-12658-6-git-send-email-pmorel@linux.vnet.ibm.com>
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

The fsm_func_t function type definition does not need the event
parameter since all functions are in a state/event table.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c     | 34 +++++++++++-----------------------
 drivers/s390/cio/vfio_ccw_private.h |  5 ++---
 2 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index f9855cd..f8ded70 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -55,8 +55,7 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
 	}
 }
 
-static int fsm_notoper(struct vfio_ccw_private *private,
-			enum vfio_ccw_event event)
+static int fsm_notoper(struct vfio_ccw_private *private)
 {
 	struct subchannel *sch = private->sch;
 
@@ -65,36 +64,31 @@ static int fsm_notoper(struct vfio_ccw_private *private,
 	 * Probably we should send the machine check to the guest.
 	 */
 	css_sched_sch_todo(sch, SCH_TODO_UNREG);
-	private->state = VFIO_CCW_STATE_NOT_OPER;
-	return private->state;
+	return VFIO_CCW_STATE_NOT_OPER;
 }
 
 /*
  * No operation action.
  */
-static int fsm_nop(struct vfio_ccw_private *private,
-		    enum vfio_ccw_event event)
+static int fsm_nop(struct vfio_ccw_private *private)
 {
 	return private->state;
 }
 
-static int fsm_io_error(struct vfio_ccw_private *private,
-			 enum vfio_ccw_event event)
+static int fsm_io_error(struct vfio_ccw_private *private)
 {
 	pr_err("vfio-ccw: FSM: I/O request from state:%d\n", private->state);
 	private->io_region.ret_code = -EIO;
 	return private->state;
 }
 
-static int fsm_io_busy(struct vfio_ccw_private *private,
-			enum vfio_ccw_event event)
+static int fsm_io_busy(struct vfio_ccw_private *private)
 {
 	private->io_region.ret_code = -EBUSY;
 	return private->state;
 }
 
-static int fsm_disabled_irq(struct vfio_ccw_private *private,
-			     enum vfio_ccw_event event)
+static int fsm_disabled_irq(struct vfio_ccw_private *private)
 {
 	struct subchannel *sch = private->sch;
 
@@ -109,17 +103,14 @@ static int fsm_disabled_irq(struct vfio_ccw_private *private,
 /*
  * Deal with the ccw command request from the userspace.
  */
-static int fsm_io_request(struct vfio_ccw_private *private,
-			   enum vfio_ccw_event event)
+static int fsm_io_request(struct vfio_ccw_private *private)
 {
-	union orb *orb;
 	struct ccw_io_region *io_region = &private->io_region;
+	union orb *orb = (union orb *)io_region->orb_area;
 	struct mdev_device *mdev = private->mdev;
 
 	private->state = VFIO_CCW_STATE_BOXED;
 
-	orb = (union orb *)io_region->orb_area;
-
 	io_region->ret_code = cp_init(&private->cp, mdev_dev(mdev), orb);
 	if (io_region->ret_code)
 		goto err_out;
@@ -139,15 +130,13 @@ static int fsm_io_request(struct vfio_ccw_private *private,
 	return VFIO_CCW_STATE_BUSY;
 
 err_out:
-	private->state = VFIO_CCW_STATE_IDLE;
-	return private->state;
+	return VFIO_CCW_STATE_IDLE;
 }
 
 /*
  * Got an interrupt for a normal io (state busy).
  */
-static int fsm_irq(struct vfio_ccw_private *private,
-		    enum vfio_ccw_event event)
+static int fsm_irq(struct vfio_ccw_private *private)
 {
 	struct irb *irb = &private->irb;
 
@@ -166,8 +155,7 @@ static int fsm_irq(struct vfio_ccw_private *private,
 /*
  * Got a sub-channel event .
  */
-static int fsm_sch_event(struct vfio_ccw_private *private,
-			 enum vfio_ccw_event event)
+static int fsm_sch_event(struct vfio_ccw_private *private)
 {
 	unsigned long flags;
 	int ret = private->state;
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 93aab87..823e46c 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -86,14 +86,13 @@ enum vfio_ccw_event {
 /*
  * Action called through jumptable.
  */
-typedef int (fsm_func_t)(struct vfio_ccw_private *, enum vfio_ccw_event);
+typedef int (fsm_func_t)(struct vfio_ccw_private *);
 extern fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS];
 
 static inline void vfio_ccw_fsm_event(struct vfio_ccw_private *private,
 				     int event)
 {
-	private->state = vfio_ccw_jumptable[private->state][event](private,
-								   event);
+	private->state = vfio_ccw_jumptable[private->state][event](private);
 }
 
 extern struct workqueue_struct *vfio_ccw_work_q;
-- 
2.7.4
