Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966143AbeEYKVn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:21:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54900 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965883AbeEYKVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:21:37 -0400
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
To: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, cohuck@redhat.com
Subject: [PATCH v2 10/10] vfio: ccw: Let user wait when busy on IO
Date: Fri, 25 May 2018 12:21:18 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527243678-3140-1-git-send-email-pmorel@linux.vnet.ibm.com>
References: <1527243678-3140-1-git-send-email-pmorel@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052510-0012-0000-0000-000005DA7F95
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052510-0013-0000-0000-00001957D353
Message-Id: <1527243678-3140-11-git-send-email-pmorel@linux.vnet.ibm.com>
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

In the current implementation, we do not want to start a new SSCH
command before the last one ends.

Currently the user needs to poll on the -EBUSY error to
wait before sending a new request.

Let's be friendly with global warming and let the user sleep
until he may send a new request.

Let's make the caller wait until the last SSCH ends.

Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_fsm.c     | 4 ++++
 drivers/s390/cio/vfio_ccw_ops.c     | 6 ++++++
 drivers/s390/cio/vfio_ccw_private.h | 1 +
 3 files changed, 11 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index c37052d..97b74a1 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -200,6 +200,10 @@ static int fsm_irq(struct vfio_ccw_private *private)
 
 	if (private->io_trigger)
 		eventfd_signal(private->io_trigger, 1);
+
+	if (private->io_completion)
+		complete(private->io_completion);
+
 	return VFIO_CCW_STATE_IDLE;
 }
 
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index b202e73..39beb6e 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -183,6 +183,7 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 	struct vfio_ccw_private *private;
 	struct ccw_io_region *region;
 	union scsw *scsw;
+	DECLARE_COMPLETION_ONSTACK(completion);
 
 	if (*ppos + count > sizeof(*region))
 		return -EINVAL;
@@ -196,6 +197,11 @@ static ssize_t vfio_ccw_mdev_write(struct mdev_device *mdev,
 	scsw = (union scsw *) &region->scsw_area;
 	switch (scsw->cmd.fctl) {
 	case SCSW_FCTL_START_FUNC:
+		if (private->state == VFIO_CCW_STATE_BUSY) {
+			private->io_completion = &completion;
+			if (wait_for_completion_interruptible(&completion))
+				return -EINTR;
+		}
 		vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_SSCH_REQ);
 		break;
 	default:
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index ab5e37fa..e2e4f6d 100644
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
-- 
2.7.4
