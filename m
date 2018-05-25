Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965803AbeEYKV1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:21:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965370AbeEYKVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:21:25 -0400
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
To: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, cohuck@redhat.com
Subject: [PATCH v2 01/10] vfio: ccw: Moving state change out of IRQ context
Date: Fri, 25 May 2018 12:21:09 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527243678-3140-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1527243678-3140-1-git-send-email-pmorel@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052510-0012-0000-0000-000005DA7F8A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052510-0013-0000-0000-00001957D348
Message-Id: <1527243678-3140-2-git-send-email-pmorel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-25_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805250113
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's move the state change from the IRQ routine to the
workqueue callback.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c | 20 +++++++-------------
 drivers/s390/cio/vfio_ccw_fsm.c | 14 ++++++++------
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index ea6a2d0..57ae1ab 100644
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
@@ -94,9 +83,14 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 static void vfio_ccw_sch_irq(struct subchannel *sch)
 {
 	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
+	struct irb *irb = this_cpu_ptr(&cio_irb);
 
 	inc_irq_stat(IRQIO_CIO);
-	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_INTERRUPT);
+	memcpy(&private->irb, irb, sizeof(*irb));
+
+	queue_work(vfio_ccw_work_q, &private->io_work);
+	if (private->completion)
+		complete(private->completion);
 }
 
 static int vfio_ccw_sch_probe(struct subchannel *sch)
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 3c80064..24e1e04 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -172,14 +172,16 @@ static void fsm_io_request(struct vfio_ccw_private *private,
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
