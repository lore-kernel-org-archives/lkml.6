Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2611C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A97222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407148AbfBNNv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:51:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51690 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407123AbfBNNv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:51:26 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EDiW98042051
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:51:25 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qn900jk0m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:51:24 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 14 Feb 2019 13:51:22 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Feb 2019 13:51:21 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1EDpJQH3539410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Feb 2019 13:51:19 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EC3342042;
        Thu, 14 Feb 2019 13:51:19 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2229D42041;
        Thu, 14 Feb 2019 13:51:19 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.140])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Feb 2019 13:51:19 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: [PATCH v3 6/9] vfio: ap: register IOMMU VFIO notifier
Date:   Thu, 14 Feb 2019 14:51:06 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19021413-0008-0000-0000-000002C072A9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021413-0009-0000-0000-0000222C954A
Message-Id: <1550152269-6317-7-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902140098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be able to use the VFIO interface to facilitate the
mediated device memory pining/unpining we need to register
a notifier for IOMMU.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 64 +++++++++++++++++++++++++++++++----
 drivers/s390/crypto/vfio_ap_private.h |  2 ++
 2 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 1851b24..6eddc2c 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -781,6 +781,36 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
 };
 
 /**
+ * vfio_ap_mdev_iommu_notifier: IOMMU notifier callback
+ *
+ * @nb: The notifier block
+ * @action: Action to be taken (VFIO_IOMMU_NOTIFY_DMA_UNMAP)
+ * @data: the specific unmap structure for vfio_iommu_type1
+ *
+ * Unpins the guest IOVA. (The NIB guest address we pinned before).
+ * Return NOTIFY_OK after unpining on a UNMAP request.
+ * otherwise, returns NOTIFY_DONE .
+ */
+static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
+				       unsigned long action, void *data)
+{
+	struct ap_matrix_mdev *matrix_mdev;
+
+	matrix_mdev = container_of(nb, struct ap_matrix_mdev, iommu_notifier);
+
+	if (action == VFIO_IOMMU_NOTIFY_DMA_UNMAP) {
+		struct vfio_iommu_type1_dma_unmap *unmap = data;
+		unsigned long g_pfn = unmap->iova >> PAGE_SHIFT;
+
+		vfio_unpin_pages(mdev_dev(matrix_mdev->mdev), &g_pfn, 1);
+		return NOTIFY_OK;
+	}
+
+	return NOTIFY_DONE;
+}
+
+
+/**
  * vfio_ap_mdev_set_kvm
  *
  * @matrix_mdev: a mediated matrix device
@@ -904,8 +934,7 @@ static void vfio_ap_dissociate_queues(struct ap_matrix_mdev *matrix_mdev)
  * In the case a queue could not be found return -ENODEV.
  * Otherwise return 0.
  */
-static __attribute__((unused))
-	int vfio_ap_associate_queues(struct ap_matrix_mdev *matrix_mdev)
+static int vfio_ap_associate_queues(struct ap_matrix_mdev *matrix_mdev)
 {
 	unsigned long apid, apqi;
 	struct vfio_ap_queue *q;
@@ -967,12 +996,32 @@ static int vfio_ap_mdev_open(struct mdev_device *mdev)
 
 	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
 				     &events, &matrix_mdev->group_notifier);
-	if (ret) {
-		module_put(THIS_MODULE);
-		return ret;
-	}
+	if (ret)
+		goto err_group;
+
+	matrix_mdev->iommu_notifier.notifier_call = vfio_ap_mdev_iommu_notifier;
+	events = VFIO_IOMMU_NOTIFY_DMA_UNMAP;
+
+	ret = vfio_register_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+				     &events, &matrix_mdev->iommu_notifier);
+	if (ret)
+		goto err_iommu;
+
+	ret = vfio_ap_associate_queues(matrix_mdev);
+	if (ret)
+		goto err_associate;
 
 	return 0;
+
+err_associate:
+	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+				 &matrix_mdev->iommu_notifier);
+err_iommu:
+	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
+				 &matrix_mdev->group_notifier);
+err_group:
+	module_put(THIS_MODULE);
+	return ret;
 }
 
 static void vfio_ap_mdev_release(struct mdev_device *mdev)
@@ -985,6 +1034,9 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
 	vfio_ap_mdev_reset_queues(mdev);
 	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
 				 &matrix_mdev->group_notifier);
+	vfio_unregister_notifier(mdev_dev(mdev), VFIO_IOMMU_NOTIFY,
+				 &matrix_mdev->iommu_notifier);
+	vfio_ap_dissociate_queues(matrix_mdev);
 	matrix_mdev->kvm = NULL;
 	module_put(THIS_MODULE);
 }
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 10bc8b5..2781720 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -80,7 +80,9 @@ struct ap_matrix_mdev {
 	struct list_head node;
 	struct ap_matrix matrix;
 	struct notifier_block group_notifier;
+	struct notifier_block iommu_notifier;
 	struct kvm *kvm;
+	struct mdev_device *mdev;
 };
 
 extern int vfio_ap_mdev_register(void);
-- 
2.7.4

