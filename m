Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753780AbeDSOtr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:49:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753725AbeDSOtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:49:45 -0400
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
To: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, cohuck@redhat.com
Subject: [PATCH 10/10] vfio: ccw: Let user wait when busy on IO
Date: Thu, 19 Apr 2018 16:48:13 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18041914-0020-0000-0000-00000413BD3A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041914-0021-0000-0000-000042A80A4B
Message-Id: <1524149293-12658-11-git-send-email-pmorel@linux.vnet.ibm.com>
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

In the current implementation, we do not want to start a new SSCH
command before the last one ends.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c     |  3 +++
 drivers/s390/cio/vfio_ccw_ops.c     | 21 ++++++++++++++++++++-
 drivers/s390/cio/vfio_ccw_private.h |  4 +++-
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index b77b8ad..4140292 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -195,6 +195,9 @@ static int fsm_irq(struct vfio_ccw_private *private)
 	if (private->io_trigger)
 		eventfd_signal(private->io_trigger, 1);
 
+	if (private->io_completion)
+		complete(private->io_completion);
+
 	return VFIO_CCW_STATE_IDLE;
 }
 
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index f0f4071..346532d 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -171,6 +171,8 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 	struct vfio_ccw_private *private;
 	struct ccw_io_region *region;
 	union scsw *scsw;
+	int max_retries = 5;
+	DECLARE_COMPLETION_ONSTACK(completion);
 
 	if (*ppos + count > sizeof(*region))
 		return -EINVAL;
@@ -185,7 +187,24 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 	if ((scsw->cmd.fctl & SCSW_FCTL_START_FUNC) != SCSW_FCTL_START_FUNC)
 		return -EINVAL;
 
-	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_SSCH_REQ);
+	do {
+		switch (private->state) {
+		case VFIO_CCW_STATE_BUSY:
+			private->io_completion = &completion;
+			wait_for_completion(&completion);
+			break;
+		case VFIO_CCW_STATE_IDLE:
+			if (!vfio_ccw_fsm_event(private,
+						VFIO_CCW_EVENT_SSCH_REQ))
+				return count;
+			break;
+		default:
+			return -EBUSY;
+		}
+	} while (max_retries--);
+
+	if (max_retries <= 0)
+		return -EBUSY;
 	if (region->ret_code != 0)
 		return region->ret_code;
 
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index dbef727..7cca078 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -39,6 +39,7 @@ struct vfio_ccw_private {
 	struct subchannel	*sch;
 	int			state;
 	struct completion	*completion;
+	struct completion	*io_completion;
 	atomic_t		avail;
 	struct mdev_device	*mdev;
 	struct notifier_block	nb;
@@ -93,12 +94,13 @@ enum vfio_ccw_event {
 typedef int (fsm_func_t)(struct vfio_ccw_private *);
 extern fsm_func_t *vfio_ccw_jumptable[NR_VFIO_CCW_STATES][NR_VFIO_CCW_EVENTS];
 
-static inline void vfio_ccw_fsm_event(struct vfio_ccw_private *private,
+static inline int vfio_ccw_fsm_event(struct vfio_ccw_private *private,
 				     int event)
 {
 	mutex_lock(&private->state_mutex);
 	private->state = vfio_ccw_jumptable[private->state][event](private);
 	mutex_unlock(&private->state_mutex);
+	return private->io_region.ret_code;
 }
 
 extern struct workqueue_struct *vfio_ccw_work_q;
-- 
2.7.4
