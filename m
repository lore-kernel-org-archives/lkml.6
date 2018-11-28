Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C72C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8769320660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:41:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8769320660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbeK1XnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:43:16 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728365AbeK1Xmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:42:51 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wASCd9Y1052208
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 07:41:18 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p1tcq275j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 07:41:17 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 28 Nov 2018 12:41:16 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 28 Nov 2018 12:41:13 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wASCfB7t328034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Nov 2018 12:41:11 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 599F54C040;
        Wed, 28 Nov 2018 12:41:11 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E5FB4C04E;
        Wed, 28 Nov 2018 12:41:11 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.168])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Nov 2018 12:41:11 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     pasic@linux.vnet.ibm.com
Cc:     cohuck@redhat.com, farman@linux.ibm.com, alifm@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH v3 3/6] vfio: ccw: Rework subchannel state on removing
Date:   Wed, 28 Nov 2018 13:41:04 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
References: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18112812-0016-0000-0000-0000022DF37A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112812-0017-0000-0000-0000328650CD
Message-Id: <1543408867-16465-4-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=877 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811280112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch can be squash with the previous and is separate
to ease review.

We continue to clarify the state changes.

NOT_OPER is set on unrecoverable error
bind (probe) set the state to STANDBY
open set the state to idle
release set the state back to STANDBY

All functions called during the normal state of the device
do not change the state but on errors.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_drv.c |  1 -
 drivers/s390/cio/vfio_ccw_ops.c | 25 ++++++++++---------------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index d3527b6..1779b46 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -66,7 +66,6 @@ int vfio_ccw_sch_quiesce(struct subchannel *sch)
 		ret = cio_disable_subchannel(sch);
 	} while (ret == -EBUSY);
 out_unlock:
-	private->state = VFIO_CCW_STATE_NOT_OPER;
 	spin_unlock_irq(sch->lock);
 	return ret;
 }
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index cc7d46a..eb5b49d 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -35,11 +35,7 @@ static int vfio_ccw_mdev_reset(struct mdev_device *mdev)
 	if (ret)
 		return ret;
 
-	ret = cio_enable_subchannel(sch, (u32)(unsigned long)sch);
-	if (!ret)
-		private->state = VFIO_CCW_STATE_IDLE;
-
-	return ret;
+	return cio_enable_subchannel(sch, (u32)(unsigned long)sch);
 }
 
 static int vfio_ccw_mdev_notifier(struct notifier_block *nb,
@@ -117,7 +113,7 @@ static int vfio_ccw_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 		return -EPERM;
 
 	private->mdev = mdev;
-	private->state = VFIO_CCW_STATE_NOT_OPER;
+	private->state = VFIO_CCW_STATE_STANDBY;
 
 	return 0;
 }
@@ -128,11 +124,11 @@ static int vfio_ccw_mdev_remove(struct mdev_device *mdev)
 		dev_get_drvdata(mdev_parent_dev(mdev));
 
 	if ((private->state != VFIO_CCW_STATE_NOT_OPER) &&
-	    (private->state != VFIO_CCW_STATE_STANDBY)) {
-		if (!vfio_ccw_mdev_reset(mdev))
-			private->state = VFIO_CCW_STATE_STANDBY;
-		/* The state will be NOT_OPER on error. */
-	}
+	    (private->state != VFIO_CCW_STATE_STANDBY))
+		return -EBUSY;
+
+	vfio_ccw_mdev_reset(mdev);
+	private->state = VFIO_CCW_STATE_NOT_OPER;
 
 	private->mdev = NULL;
 	atomic_inc(&private->avail);
@@ -164,7 +160,7 @@ static int vfio_ccw_mdev_open(struct mdev_device *mdev)
 	if (ret)
 		goto err_enable;
 
-	private->state = VFIO_CCW_STATE_STANDBY;
+	private->state = VFIO_CCW_STATE_IDLE;
 	spin_unlock_irq(sch->lock);
 	return 0;
 
@@ -184,6 +180,7 @@ static void vfio_ccw_mdev_release(struct mdev_device *mdev)
 		dev_get_drvdata(mdev_parent_dev(mdev));
 	int i;
 
+	private->state = VFIO_CCW_STATE_STANDBY;
 	vfio_ccw_sch_quiesce(private->sch);
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
 				 &private->nb);
@@ -256,10 +253,8 @@ static ssize_t vfio_ccw_mdev_write_io_region(struct vfio_ccw_private *private,
 		return -EFAULT;
 
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_IO_REQ);
-	if (region->ret_code != 0) {
-		private->state = VFIO_CCW_STATE_IDLE;
+	if (region->ret_code != 0)
 		return region->ret_code;
-	}
 
 	return count;
 
-- 
2.7.4

