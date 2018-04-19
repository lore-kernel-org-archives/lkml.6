Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753436AbeDSOsi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:48:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752854AbeDSOsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:48:31 -0400
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
To: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, cohuck@redhat.com
Subject: [PATCH 06/10] vfio: ccw: Make FSM functions atomic
Date: Thu, 19 Apr 2018 16:48:09 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041914-0020-0000-0000-00000413BD37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041914-0021-0000-0000-000042A80A49
Message-Id: <1524149293-12658-7-git-send-email-pmorel@linux.vnet.ibm.com>
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

We use mutex around the FSM function call to make the FSM
event handling and state change atomic.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c     | 3 +--
 drivers/s390/cio/vfio_ccw_fsm.c     | 2 --
 drivers/s390/cio/vfio_ccw_ops.c     | 4 +---
 drivers/s390/cio/vfio_ccw_private.h | 3 +++
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 8a91eee..1c9422a 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -73,8 +73,6 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 
 	private = container_of(work, struct vfio_ccw_private, io_work);
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_INTERRUPT);
-	if (private->mdev)
-		private->state = VFIO_CCW_STATE_IDLE;
 }
 
 static void vfio_ccw_sch_event_todo(struct work_struct *work)
@@ -120,6 +118,7 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 		return -ENOMEM;
 	private->sch = sch;
 	dev_set_drvdata(&sch->dev, private);
+	mutex_init(&private->state_mutex);
 
 	spin_lock_irq(sch->lock);
 	private->state = VFIO_CCW_STATE_NOT_OPER;
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index f8ded70..d85bcfc 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -109,8 +109,6 @@ static int fsm_io_request(struct vfio_ccw_private *private)
 	union orb *orb = (union orb *)io_region->orb_area;
 	struct mdev_device *mdev = private->mdev;
 
-	private->state = VFIO_CCW_STATE_BOXED;
-
 	io_region->ret_code = cp_init(&private->cp, mdev_dev(mdev), orb);
 	if (io_region->ret_code)
 		goto err_out;
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 4da7b61..dac8ce4 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -204,10 +204,8 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 		return -EINVAL;
 
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_SSCH_REQ);
-	if (region->ret_code != 0) {
-		private->state = VFIO_CCW_STATE_IDLE;
+	if (region->ret_code != 0)
 		return region->ret_code;
-	}
 
 	return count;
 }
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 823e46c..cf197cf 100644
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
