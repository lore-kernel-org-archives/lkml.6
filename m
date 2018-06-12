Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1225DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C535A208B7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C535A208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933667AbeFLH5C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:57:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933553AbeFLH46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:56:58 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5C7sxUN063101
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:56:57 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jj7m2ek69-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:56:57 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 12 Jun 2018 08:56:55 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Jun 2018 08:56:53 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5C7uqp635258426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jun 2018 07:56:52 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8104AE056;
        Tue, 12 Jun 2018 08:45:43 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9AACAE051;
        Tue, 12 Jun 2018 08:45:43 +0100 (BST)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.92])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jun 2018 08:45:43 +0100 (BST)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, cohuck@redhat.com
Subject: [PATCH v3 1/8] vfio: ccw: Moving state change out of IRQ context
Date:   Tue, 12 Jun 2018 09:56:43 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
References: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18061207-0008-0000-0000-00000246BEC9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061207-0009-0000-0000-000021ACE6C6
Message-Id: <1528790210-19535-2-git-send-email-pmorel@linux.ibm.com>
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

From: Pierre Morel <pmorel@linux.vnet.ibm.com>

Having state changes out of IRQ context allows to protect
critical sections with mutexes.
Next patches in the serie will use this possibility.

We use work queues to thread the interrupts.

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

