Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 87E1BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337E9208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 337E9208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933853AbeFLH6B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:58:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933752AbeFLH5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:57:08 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5C7sYXX137830
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:57:07 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jj6u891m1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:57:07 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 12 Jun 2018 08:57:04 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Jun 2018 08:57:01 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5C7v0RP29622412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jun 2018 07:57:00 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE0BCAE055;
        Tue, 12 Jun 2018 08:45:51 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A3F0AE058;
        Tue, 12 Jun 2018 08:45:51 +0100 (BST)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.92])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jun 2018 08:45:51 +0100 (BST)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, cohuck@redhat.com
Subject: [PATCH v3 7/8] vfio: ccw: Introduce the INIT event
Date:   Tue, 12 Jun 2018 09:56:49 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
References: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18061207-4275-0000-0000-0000028CC31A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061207-4276-0000-0000-00003793E627
Message-Id: <1528790210-19535-8-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806120094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduce a new event: VFIO_CCW_EVENT_INIT.

This event is sent to the FSM during the open of the mediated
device, when a guest is about to take care of the real device.

At this moment the FSM state is VFIO_CCW_STATE_NOT_OPER,
nothing can be done with the device as no one is there
to take care of it.
The VFIO_CCW_STATE_NOT_OPER is the only state accepting
the VFIO_CCW_EVENT_INIT event.

In the FSM, when receiving the VFIO_CCW_EVENT_INIT event
the sub-channel is enabled and the next state is set to
VFIO_CCW_STATE_STANDBY.

This patch move part of the initialization to different
places:
- In the probe callback,  all driver private structures
  are initialized before registering the mediated device.
- The call to the FSM is done in the mediated device open
  callback.
- The enabling of the real device is moved inside the FSM
  fsm_init function called through the jump table during
  the mediated device open callback.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c     | 21 ++++++---------------
 drivers/s390/cio/vfio_ccw_fsm.c     | 20 ++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_ops.c     | 26 +++++++++++++-------------
 drivers/s390/cio/vfio_ccw_private.h |  1 +
 4 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 98951d5..e1a9806 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -114,31 +114,22 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	private = kzalloc(sizeof(*private), GFP_KERNEL | GFP_DMA);
 	if (!private)
 		return -ENOMEM;
+
+	private->state = VFIO_CCW_STATE_NOT_OPER;
 	private->sch = sch;
 	dev_set_drvdata(&sch->dev, private);
 	mutex_init(&private->state_mutex);
 
-	spin_lock_irq(sch->lock);
-	private->state = VFIO_CCW_STATE_NOT_OPER;
-	sch->isc = VFIO_CCW_ISC;
-	ret = cio_enable_subchannel(sch, (u32)(unsigned long)sch);
-	spin_unlock_irq(sch->lock);
-	if (ret)
-		goto out_free;
-
-	ret = vfio_ccw_mdev_reg(sch);
-	if (ret)
-		goto out_disable;
-
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
 	INIT_WORK(&private->event_work, vfio_ccw_sch_event_todo);
 	atomic_set(&private->avail, 1);
-	private->state = VFIO_CCW_STATE_STANDBY;
+
+	ret = vfio_ccw_mdev_reg(sch);
+	if (ret)
+		goto out_free;
 
 	return 0;
 
-out_disable:
-	cio_disable_subchannel(sch);
 out_free:
 	dev_set_drvdata(&sch->dev, NULL);
 	kfree(private);
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 2d55742..5f1035c 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -9,6 +9,7 @@
 
 #include <linux/vfio.h>
 #include <linux/mdev.h>
+#include <asm/isc.h>
 
 #include "ioasm.h"
 #include "vfio_ccw_private.h"
@@ -187,35 +188,54 @@ static int fsm_sch_event(struct vfio_ccw_private *private)
 	return ret;
 }
 
+static int fsm_init(struct vfio_ccw_private *private)
+{
+	struct subchannel *sch = private->sch;
+	int ret = VFIO_CCW_STATE_STANDBY;
+
+	spin_lock_irq(sch->lock);
+	sch->isc = VFIO_CCW_ISC;
+	if (cio_enable_subchannel(sch, (u32)(unsigned long)sch))
+		ret = VFIO_CCW_STATE_NOT_OPER;
+	spin_unlock_irq(sch->lock);
+
+	return ret;
+}
+
 /*
  * Device statemachine
  */
 fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
 	[VFIO_CCW_STATE_NOT_OPER] = {
+		[VFIO_CCW_EVENT_INIT]		= fsm_init,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_nop,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_error,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_disabled_irq,
 		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_nop,
 	},
 	[VFIO_CCW_STATE_STANDBY] = {
+		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_error,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
 	},
 	[VFIO_CCW_STATE_IDLE] = {
+		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_request,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
 	},
 	[VFIO_CCW_STATE_BOXED] = {
+		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_busy,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
 		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
 	},
 	[VFIO_CCW_STATE_BUSY] = {
+		[VFIO_CCW_EVENT_INIT]		= fsm_nop,
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_busy,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index af05932..e020a836 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -111,14 +111,10 @@ static int vfio_ccw_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 	struct vfio_ccw_private *private =
 		dev_get_drvdata(mdev_parent_dev(mdev));
 
-	if (private->state == VFIO_CCW_STATE_NOT_OPER)
-		return -ENODEV;
-
 	if (atomic_dec_if_positive(&private->avail) < 0)
 		return -EPERM;
 
 	private->mdev = mdev;
-	private->state = VFIO_CCW_STATE_IDLE;
 
 	return 0;
 }
@@ -128,13 +124,6 @@ static int vfio_ccw_mdev_remove(struct mdev_device *mdev)
 	struct vfio_ccw_private *private =
 		dev_get_drvdata(mdev_parent_dev(mdev));
 
-	if ((private->state != VFIO_CCW_STATE_NOT_OPER) &&
-	    (private->state != VFIO_CCW_STATE_STANDBY)) {
-		if (!vfio_ccw_mdev_reset(mdev))
-			private->state = VFIO_CCW_STATE_STANDBY;
-		/* The state will be NOT_OPER on error. */
-	}
-
 	private->mdev = NULL;
 	atomic_inc(&private->avail);
 
@@ -146,11 +135,22 @@ static int vfio_ccw_mdev_open(struct mdev_device *mdev)
 	struct vfio_ccw_private *private =
 		dev_get_drvdata(mdev_parent_dev(mdev));
 	unsigned long events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
+	int ret;
 
 	private->nb.notifier_call = vfio_ccw_mdev_notifier;
 
-	return vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
-				      &events, &private->nb);
+	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+				     &events, &private->nb);
+	if (ret)
+		return ret;
+
+	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_INIT);
+	if (private->state == VFIO_CCW_STATE_STANDBY)
+		return 0;
+
+	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+				 &private->nb);
+	return -EFAULT;
 }
 
 static void vfio_ccw_mdev_release(struct mdev_device *mdev)
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index e3dc12c..f9e7570 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -76,6 +76,7 @@ enum vfio_ccw_state {
  * Asynchronous events of the device statemachine.
  */
 enum vfio_ccw_event {
+	VFIO_CCW_EVENT_INIT,
 	VFIO_CCW_EVENT_NOT_OPER,
 	VFIO_CCW_EVENT_IO_REQ,
 	VFIO_CCW_EVENT_INTERRUPT,
-- 
2.7.4

