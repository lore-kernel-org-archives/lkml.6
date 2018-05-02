Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751127AbeEBH0K (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 03:26:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34602 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750930AbeEBH0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 03:26:09 -0400
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.ibm.com,
        pasic@linux.ibm.com, pmorel@linux.ibm.com,
        Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH 1/1] vfio: ccw: fix error return in vfio_ccw_sch_event
Date: Wed,  2 May 2018 09:25:59 +0200
X-Mailer: git-send-email 2.13.5
X-TM-AS-GCONF: 00
x-cbid: 18050207-0028-0000-0000-00000988D7DE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008959; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000258; SDB=6.01026304; UDB=6.00524157; IPR=6.00805535;
 MB=3.00020891; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-02 07:26:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050207-0029-0000-0000-00003A9EDB03
Message-Id: <20180502072559.50691-1-bjsdjshi@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805020074
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If device has not been registered, or there is a pending work,
we should reschedule a sch_event call again.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index ea6a2d0b2894..770fa9cfc310 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -177,6 +177,7 @@ static int vfio_ccw_sch_event(struct subchannel *sch, int process)
 {
 	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
 	unsigned long flags;
+	int rc = -EAGAIN;
 
 	spin_lock_irqsave(sch->lock, flags);
 	if (!device_is_registered(&sch->dev))
@@ -187,6 +188,7 @@ static int vfio_ccw_sch_event(struct subchannel *sch, int process)
 
 	if (cio_update_schib(sch)) {
 		vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_NOT_OPER);
+		rc = 0;
 		goto out_unlock;
 	}
 
@@ -195,11 +197,12 @@ static int vfio_ccw_sch_event(struct subchannel *sch, int process)
 		private->state = private->mdev ? VFIO_CCW_STATE_IDLE :
 				 VFIO_CCW_STATE_STANDBY;
 	}
+	rc = 0;
 
 out_unlock:
 	spin_unlock_irqrestore(sch->lock, flags);
 
-	return 0;
+	return rc;
 }
 
 static struct css_device_id vfio_ccw_sch_ids[] = {
-- 
2.13.5
