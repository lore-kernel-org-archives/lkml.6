Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753847AbeDSOuQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:50:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753333AbeDSOuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:50:14 -0400
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
To: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, cohuck@redhat.com
Subject: [PATCH 01/10] vfio: ccw: Moving state change out of IRQ context
Date: Thu, 19 Apr 2018 16:48:04 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041914-0040-0000-0000-00000430CE30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041914-0041-0000-0000-00002634E5E2
Message-Id: <1524149293-12658-2-git-send-email-pmorel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804190131
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having state changes out of IRQ context allows to protect
critical sections with mutexes.
Next patches in the serie will use this possibility.

We use work queues to thread the interrupts.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c | 21 ++++++++-------------
 drivers/s390/cio/vfio_ccw_fsm.c | 14 ++++++++------
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index ea6a2d0..f1b158c 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -70,20 +70,9 @@ int vfio_ccw_sch_quiesce(struct subchannel *sch)
 static void vfio_ccw_sch_io_todo(struct work_struct *work)
 {
 	struct vfio_ccw_private *private;
-	struct irb *irb;
 
 	private = container_of(work, struct vfio_ccw_private, io_work);
-	irb = &private->irb;
-
-	if (scsw_is_solicited(&irb->scsw)) {
-		cp_update_scsw(&private->cp, &irb->scsw);
-		cp_free(&private->cp);
-	}
-	memcpy(private->io_region.irb_area, irb, sizeof(*irb));
-
-	if (private->io_trigger)
-		eventfd_signal(private->io_trigger, 1);
-
+	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_INTERRUPT);
 	if (private->mdev)
 		private->state = VFIO_CCW_STATE_IDLE;
 }
@@ -94,9 +83,15 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 static void vfio_ccw_sch_irq(struct subchannel *sch)
 {
 	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
+	struct irb *irb = this_cpu_ptr(&cio_irb);
 
 	inc_irq_stat(IRQIO_CIO);
-	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_INTERRUPT);
+	memcpy(&private->irb, irb, sizeof(*irb));
+
+	WARN_ON(work_pending(&private->io_work));
+	queue_work(vfio_ccw_work_q, &private->io_work);
+	if (private->completion)
+		complete(private->completion);
 }
 
 static int vfio_ccw_sch_probe(struct subchannel *sch)
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index c30420c..af88551 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -162,14 +162,16 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 static void fsm_irq(struct vfio_ccw_private *private,
 		    enum vfio_ccw_event event)
 {
-	struct irb *irb = this_cpu_ptr(&cio_irb);
+	struct irb *irb = &private->irb;
 
-	memcpy(&private->irb, irb, sizeof(*irb));
-
-	queue_work(vfio_ccw_work_q, &private->io_work);
+	if (scsw_is_solicited(&irb->scsw)) {
+		cp_update_scsw(&private->cp, &irb->scsw);
+		cp_free(&private->cp);
+	}
+	memcpy(private->io_region.irb_area, irb, sizeof(*irb));
 
-	if (private->completion)
-		complete(private->completion);
+	if (private->io_trigger)
+		eventfd_signal(private->io_trigger, 1);
 }
 
 /*
-- 
2.7.4
