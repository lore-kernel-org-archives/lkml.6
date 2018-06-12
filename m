Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1CCA5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7AB4208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7AB4208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933783AbeFLH5I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:57:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933642AbeFLH5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:57:01 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5C7sTbw142603
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:57:01 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jj9myhd71-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:57:01 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 12 Jun 2018 08:56:58 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Jun 2018 08:56:56 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5C7ut5h31129754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jun 2018 07:56:55 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BF7DAE056;
        Tue, 12 Jun 2018 08:45:46 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4DC73AE051;
        Tue, 12 Jun 2018 08:45:46 +0100 (BST)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.92])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jun 2018 08:45:46 +0100 (BST)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, cohuck@redhat.com
Subject: [PATCH v3 3/8] vfio: ccw: new VFIO_CCW_EVENT_SCHIB_CHANGED event
Date:   Tue, 12 Jun 2018 09:56:45 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
References: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18061207-0016-0000-0000-000001DABEA5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061207-0017-0000-0000-0000322DEFD1
Message-Id: <1528790210-19535-4-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806120094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre Morel <pmorel@linux.vnet.ibm.com>

The Sub channel event callback is threaded using workqueues.
The work uses the FSM introducing the VFIO_CCW_EVENT_SCHIB_CHANGED
event.
The update of the SCHIB is now done inside the FSM function.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c     | 33 ++++++++++++---------------------
 drivers/s390/cio/vfio_ccw_fsm.c     | 23 +++++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_private.h |  3 +++
 3 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 095a2d9..e5a516a 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -75,6 +75,14 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_INTERRUPT);
 }
 
+static void vfio_ccw_sch_event_todo(struct work_struct *work)
+{
+	struct vfio_ccw_private *private;
+
+	private = container_of(work, struct vfio_ccw_private, event_work);
+	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_SCHIB_CHANGED);
+}
+
 /*
  * Css driver callbacks
  */
@@ -122,6 +130,7 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 		goto out_disable;
 
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
+	INIT_WORK(&private->event_work, vfio_ccw_sch_event_todo);
 	atomic_set(&private->avail, 1);
 	private->state = VFIO_CCW_STATE_STANDBY;
 
@@ -168,28 +177,10 @@ static void vfio_ccw_sch_shutdown(struct subchannel *sch)
 static int vfio_ccw_sch_event(struct subchannel *sch, int process)
 {
 	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
-	unsigned long flags;
-
-	spin_lock_irqsave(sch->lock, flags);
-	if (!device_is_registered(&sch->dev))
-		goto out_unlock;
 
-	if (work_pending(&sch->todo_work))
-		goto out_unlock;
-
-	if (cio_update_schib(sch)) {
-		vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_NOT_OPER);
-		goto out_unlock;
-	}
-
-	private = dev_get_drvdata(&sch->dev);
-	if (private->state == VFIO_CCW_STATE_NOT_OPER) {
-		private->state = private->mdev ? VFIO_CCW_STATE_IDLE :
-				 VFIO_CCW_STATE_STANDBY;
-	}
-
-out_unlock:
-	spin_unlock_irqrestore(sch->lock, flags);
+	if (work_pending(&private->event_work))
+		return -EAGAIN;
+	queue_work(vfio_ccw_work_q, &private->event_work);
 
 	return 0;
 }
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 1a0585f..94bf151 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -191,6 +191,24 @@ static int fsm_irq(struct vfio_ccw_private *private,
 }
 
 /*
+ * Got a sub-channel event .
+ */
+static int fsm_sch_event(struct vfio_ccw_private *private,
+			 enum vfio_ccw_event event)
+{
+	unsigned long flags;
+	int ret = private->state;
+	struct subchannel *sch = private->sch;
+
+	spin_lock_irqsave(sch->lock, flags);
+	if (cio_update_schib(sch))
+		ret = VFIO_CCW_STATE_NOT_OPER;
+	spin_unlock_irqrestore(sch->lock, flags);
+
+	return ret;
+}
+
+/*
  * Device statemachine
  */
 fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
@@ -198,25 +216,30 @@ fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_nop,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_error,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_disabled_irq,
+		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_nop,
 	},
 	[VFIO_CCW_STATE_STANDBY] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_error,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
+		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
 	},
 	[VFIO_CCW_STATE_IDLE] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_request,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
+		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
 	},
 	[VFIO_CCW_STATE_BOXED] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_busy,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
+		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
 	},
 	[VFIO_CCW_STATE_BUSY] = {
 		[VFIO_CCW_EVENT_NOT_OPER]	= fsm_notoper,
 		[VFIO_CCW_EVENT_IO_REQ]		= fsm_io_busy,
 		[VFIO_CCW_EVENT_INTERRUPT]	= fsm_irq,
+		[VFIO_CCW_EVENT_SCHIB_CHANGED]	= fsm_sch_event,
 	},
 };
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index f526b18..a2be0c9 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -33,6 +33,7 @@
  * @scsw: scsw info
  * @io_trigger: eventfd ctx for signaling userspace I/O results
  * @io_work: work for deferral process of I/O handling
+ * @event_work: work for deferral process of sub-channel event
  */
 struct vfio_ccw_private {
 	struct subchannel	*sch;
@@ -49,6 +50,7 @@ struct vfio_ccw_private {
 
 	struct eventfd_ctx	*io_trigger;
 	struct work_struct	io_work;
+	struct work_struct	event_work;
 } __aligned(8);
 
 extern int vfio_ccw_mdev_reg(struct subchannel *sch);
@@ -76,6 +78,7 @@ enum vfio_ccw_event {
 	VFIO_CCW_EVENT_NOT_OPER,
 	VFIO_CCW_EVENT_IO_REQ,
 	VFIO_CCW_EVENT_INTERRUPT,
+	VFIO_CCW_EVENT_SCHIB_CHANGED,
 	/* last element! */
 	NR_VFIO_CCW_EVENTS
 };
-- 
2.7.4

