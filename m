Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965579AbeEYKXC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:23:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965920AbeEYKVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:21:33 -0400
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
To: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, cohuck@redhat.com
Subject: [PATCH v2 06/10] vfio: ccw: Make FSM functions atomic
Date: Fri, 25 May 2018 12:21:14 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527243678-3140-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1527243678-3140-1-git-send-email-pmorel@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052510-0040-0000-0000-0000043DC0F2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052510-0041-0000-0000-000026430208
Message-Id: <1527243678-3140-7-git-send-email-pmorel@linux.vnet.ibm.com>
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

We use mutex around the FSM function call to make the FSM
event handling and state change atomic.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c     | 3 +--
 drivers/s390/cio/vfio_ccw_private.h | 3 +++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 6b7112e..98951d5 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -73,8 +73,6 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 
 	private = container_of(work, struct vfio_ccw_private, io_work);
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_INTERRUPT);
-	if (private->mdev)
-		private->state = VFIO_CCW_STATE_IDLE;
 }
 
 static void vfio_ccw_sch_event_todo(struct work_struct *work)
@@ -118,6 +116,7 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 		return -ENOMEM;
 	private->sch = sch;
 	dev_set_drvdata(&sch->dev, private);
+	mutex_init(&private->state_mutex);
 
 	spin_lock_irq(sch->lock);
 	private->state = VFIO_CCW_STATE_NOT_OPER;
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 6c74f73..241176c 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -51,6 +51,7 @@ struct vfio_ccw_private {
 	struct eventfd_ctx	*io_trigger;
 	struct work_struct	io_work;
 	struct work_struct	event_work;
+	struct mutex		state_mutex;
 } __aligned(8);
 
 extern int vfio_ccw_mdev_reg(struct subchannel *sch);
@@ -92,7 +93,9 @@ extern fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS];
 static inline void vfio_ccw_fsm_event(struct vfio_ccw_private *private,
 				     int event)
 {
+	mutex_lock(&private->state_mutex);
 	private->state = vfio_ccw_jumptable[private->state][event](private);
+	mutex_unlock(&private->state_mutex);
 }
 
 extern struct workqueue_struct *vfio_ccw_work_q;
-- 
2.7.4
