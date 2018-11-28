Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E908BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A5820660
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92A5820660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbeK1Xmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:42:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728372AbeK1Xmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:42:50 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wASCd9LY129210
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 07:41:17 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p1u27ge17-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 07:41:17 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 28 Nov 2018 12:41:15 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 28 Nov 2018 12:41:11 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wASCfAE015990908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Nov 2018 12:41:10 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 130514C046;
        Wed, 28 Nov 2018 12:41:10 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC79B4C040;
        Wed, 28 Nov 2018 12:41:09 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.168])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Nov 2018 12:41:09 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     pasic@linux.vnet.ibm.com
Cc:     cohuck@redhat.com, farman@linux.ibm.com, alifm@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH v3 2/6] vfio: ccw: Rework subchannel state on setup
Date:   Wed, 28 Nov 2018 13:41:03 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
References: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18112812-0012-0000-0000-000002D17963
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112812-0013-0000-0000-00002106BE1E
Message-Id: <1543408867-16465-3-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=911 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811280112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subchannel enablement and the according setting to the
VFIO_CCW_STATE_STANDBY state should only be done when all
parts of the VFIO mediated device have been initialized
i.e. after the mediated device has been successfully opened.

Let's stay in VFIO_CCW_STATE_NOT_OPER until the mediated
device has been opened and set the VFIO_CCW_STATE_STANDBY
on a successful open.

On release the state is set back to VFIO_CCW_STATE_NOT_OPER
by vfio_ccw_sch_quiesce().

When the mediated device is closed,  disable the sub channel
by calling vfio_ccw_sch_quiesce().

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_async.c   | 11 +++++++++++
 drivers/s390/cio/vfio_ccw_drv.c     | 10 +---------
 drivers/s390/cio/vfio_ccw_ops.c     | 27 +++++++++++++++++++++------
 drivers/s390/cio/vfio_ccw_private.h |  1 +
 4 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_async.c b/drivers/s390/cio/vfio_ccw_async.c
index 8c7f51d..033574e 100644
--- a/drivers/s390/cio/vfio_ccw_async.c
+++ b/drivers/s390/cio/vfio_ccw_async.c
@@ -76,6 +76,17 @@ const struct vfio_ccw_regops vfio_ccw_async_region_ops = {
 	.release = vfio_ccw_async_region_release,
 };
 
+void vfio_ccw_unregister_async_dev_regions(struct vfio_ccw_private *private)
+{
+	int i;
+
+	for (i = 0; i < private->num_regions; i++)
+		private->region[i].ops->release(private, &private->region[i]);
+	private->num_regions = 0;
+	kfree(private->region);
+	private->region = NULL;
+}
+
 int vfio_ccw_register_async_dev_regions(struct vfio_ccw_private *private)
 {
 	return vfio_ccw_register_dev_region(private,
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index bce7fed..d3527b6 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -133,26 +133,18 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	private->sch = sch;
 	dev_set_drvdata(&sch->dev, private);
 
-	spin_lock_irq(sch->lock);
 	private->state = VFIO_CCW_STATE_NOT_OPER;
 	sch->isc = VFIO_CCW_ISC;
-	ret = cio_enable_subchannel(sch, (u32)(unsigned long)sch);
-	spin_unlock_irq(sch->lock);
-	if (ret)
-		goto out_free;
 
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
 	atomic_set(&private->avail, 1);
-	private->state = VFIO_CCW_STATE_STANDBY;
 
 	ret = vfio_ccw_mdev_reg(sch);
 	if (ret)
-		goto out_disable;
+		goto out_free;
 
 	return 0;
 
-out_disable:
-	cio_disable_subchannel(sch);
 out_free:
 	dev_set_drvdata(&sch->dev, NULL);
 	if (private->cmd_region)
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 0e1f7f7b..cc7d46a 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -113,14 +113,11 @@ static int vfio_ccw_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 	struct vfio_ccw_private *private =
 		dev_get_drvdata(mdev_parent_dev(mdev));
 
-	if (private->state == VFIO_CCW_STATE_NOT_OPER)
-		return -ENODEV;
-
 	if (atomic_dec_if_positive(&private->avail) < 0)
 		return -EPERM;
 
 	private->mdev = mdev;
-	private->state = VFIO_CCW_STATE_IDLE;
+	private->state = VFIO_CCW_STATE_NOT_OPER;
 
 	return 0;
 }
@@ -148,6 +145,7 @@ static int vfio_ccw_mdev_open(struct mdev_device *mdev)
 	struct vfio_ccw_private *private =
 		dev_get_drvdata(mdev_parent_dev(mdev));
 	unsigned long events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
+	struct subchannel *sch = private->sch;
 	int ret;
 
 	private->nb.notifier_call = vfio_ccw_mdev_notifier;
@@ -159,8 +157,24 @@ static int vfio_ccw_mdev_open(struct mdev_device *mdev)
 
 	ret = vfio_ccw_register_async_dev_regions(private);
 	if (ret)
-		vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
-					 &private->nb);
+		goto err_regions;
+
+	spin_lock_irq(private->sch->lock);
+	ret = cio_enable_subchannel(sch, (u32)(unsigned long)sch);
+	if (ret)
+		goto err_enable;
+
+	private->state = VFIO_CCW_STATE_STANDBY;
+	spin_unlock_irq(sch->lock);
+	return 0;
+
+err_enable:
+	spin_unlock_irq(sch->lock);
+	vfio_ccw_unregister_async_dev_regions(private);
+
+err_regions:
+	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+				 &private->nb);
 	return ret;
 }
 
@@ -170,6 +184,7 @@ static void vfio_ccw_mdev_release(struct mdev_device *mdev)
 		dev_get_drvdata(mdev_parent_dev(mdev));
 	int i;
 
+	vfio_ccw_sch_quiesce(private->sch);
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
 				 &private->nb);
 
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 1a41a14..5d799b7 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -54,6 +54,7 @@ int vfio_ccw_register_dev_region(struct vfio_ccw_private *private,
 				 size_t size, u32 flags, void *data);
 
 int vfio_ccw_register_async_dev_regions(struct vfio_ccw_private *private);
+void vfio_ccw_unregister_async_dev_regions(struct vfio_ccw_private *private);
 
 /**
  * struct vfio_ccw_private
-- 
2.7.4

