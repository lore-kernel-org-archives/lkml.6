Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 65046C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A352208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A352208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933873AbeFLH7J (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:59:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933580AbeFLH47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:56:59 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5C7sTOL066500
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:56:59 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jj8chd3tc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 03:56:58 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 12 Jun 2018 08:56:57 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Jun 2018 08:56:54 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5C7urlB31588578
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jun 2018 07:56:53 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F7F9AE058;
        Tue, 12 Jun 2018 08:45:45 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02135AE055;
        Tue, 12 Jun 2018 08:45:45 +0100 (BST)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.92])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Jun 2018 08:45:44 +0100 (BST)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, cohuck@redhat.com
Subject: [PATCH v3 2/8] vfio: ccw: Transform FSM functions to return state
Date:   Tue, 12 Jun 2018 09:56:44 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
References: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18061207-0012-0000-0000-0000027E6F45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18061207-0013-0000-0000-000020AF843B
Message-Id: <1528790210-19535-3-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-12_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=963 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806120094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We change the FSM functions to return the next state,
and adapt the fsm_func_t function type.

Doing this change will allow to move the state changes out
of the action functions to a common point.
This is important to guaranty the coherency of the FSM
and add to readibility.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c     |  2 --
 drivers/s390/cio/vfio_ccw_fsm.c     | 26 ++++++++++++++++----------
 drivers/s390/cio/vfio_ccw_private.h |  5 +++--
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 57ae1ab..095a2d9 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -73,8 +73,6 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 
 	private = container_of(work, struct vfio_ccw_private, io_work);
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_INTERRUPT);
-	if (private->mdev)
-		private->state = VFIO_CCW_STATE_IDLE;
 }
 
 /*
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 24e1e04..1a0585f 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -65,7 +65,7 @@ static int fsm_io_helper(struct vfio_ccw_private *private)
 	return ret;
 }
 
-static void fsm_notoper(struct vfio_ccw_private *private,
+static int fsm_notoper(struct vfio_ccw_private *private,
 			enum vfio_ccw_event event)
 {
 	struct subchannel *sch = private->sch;
@@ -75,31 +75,34 @@ static void fsm_notoper(struct vfio_ccw_private *private,
 	 * Probably we should send the machine check to the guest.
 	 */
 	css_sched_sch_todo(sch, SCH_TODO_UNREG);
-	private->state = VFIO_CCW_STATE_NOT_OPER;
+	return VFIO_CCW_STATE_NOT_OPER;
 }
 
 /*
  * No operation action.
  */
-static void fsm_nop(struct vfio_ccw_private *private,
+static int fsm_nop(struct vfio_ccw_private *private,
 		    enum vfio_ccw_event event)
 {
+	return private->state;
 }
 
-static void fsm_io_error(struct vfio_ccw_private *private,
+static int fsm_io_error(struct vfio_ccw_private *private,
 			 enum vfio_ccw_event event)
 {
 	pr_err("vfio-ccw: FSM: I/O request from state:%d\n", private->state);
 	private->io_region.ret_code = -EIO;
+	return private->state;
 }
 
-static void fsm_io_busy(struct vfio_ccw_private *private,
+static int fsm_io_busy(struct vfio_ccw_private *private,
 			enum vfio_ccw_event event)
 {
 	private->io_region.ret_code = -EBUSY;
+	return private->state;
 }
 
-static void fsm_disabled_irq(struct vfio_ccw_private *private,
+static int fsm_disabled_irq(struct vfio_ccw_private *private,
 			     enum vfio_ccw_event event)
 {
 	struct subchannel *sch = private->sch;
@@ -109,12 +112,13 @@ static void fsm_disabled_irq(struct vfio_ccw_private *private,
 	 * successful - should not happen, but we try to disable again.
 	 */
 	cio_disable_subchannel(sch);
+	return private->state;
 }
 
 /*
  * Deal with the ccw command request from the userspace.
  */
-static void fsm_io_request(struct vfio_ccw_private *private,
+static int fsm_io_request(struct vfio_ccw_private *private,
 			   enum vfio_ccw_event event)
 {
 	union orb *orb;
@@ -151,7 +155,7 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 			cp_free(&private->cp);
 			goto err_out;
 		}
-		return;
+		return private->state;
 	} else if (scsw->cmd.fctl & SCSW_FCTL_HALT_FUNC) {
 		/* XXX: Handle halt. */
 		io_region->ret_code = -EOPNOTSUPP;
@@ -163,13 +167,13 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 	}
 
 err_out:
-	private->state = VFIO_CCW_STATE_IDLE;
+	return VFIO_CCW_STATE_IDLE;
 }
 
 /*
  * Got an interrupt for a normal io (state busy).
  */
-static void fsm_irq(struct vfio_ccw_private *private,
+static int fsm_irq(struct vfio_ccw_private *private,
 		    enum vfio_ccw_event event)
 {
 	struct irb *irb = &private->irb;
@@ -182,6 +186,8 @@ static void fsm_irq(struct vfio_ccw_private *private,
 
 	if (private->io_trigger)
 		eventfd_signal(private->io_trigger, 1);
+
+	return VFIO_CCW_STATE_IDLE;
 }
 
 /*
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 78a66d9..f526b18 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -83,13 +83,14 @@ enum vfio_ccw_event {
 /*
  * Action called through jumptable.
  */
-typedef void (fsm_func_t)(struct vfio_ccw_private *, enum vfio_ccw_event);
+typedef int (fsm_func_t)(struct vfio_ccw_private *, enum vfio_ccw_event);
 extern fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS];
 
 static inline void vfio_ccw_fsm_event(struct vfio_ccw_private *private,
 				     int event)
 {
-	vfio_ccw_jumptable[private->state][event](private, event);
+	private->state = vfio_ccw_jumptable[private->state][event](private,
+								   event);
 }
 
 extern struct workqueue_struct *vfio_ccw_work_q;
-- 
2.7.4

