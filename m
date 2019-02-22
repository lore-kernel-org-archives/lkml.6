Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E605C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560EC20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 15:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfBVPe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 10:34:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726380AbfBVPe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 10:34:27 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1MFYPeO035144
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 10:34:25 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qtjtwbrux-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 10:32:55 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 22 Feb 2019 15:30:15 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Feb 2019 15:30:12 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1MFUAjg53280946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Feb 2019 15:30:10 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C1075204F;
        Fri, 22 Feb 2019 15:30:10 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.140])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BD3C25204E;
        Fri, 22 Feb 2019 15:30:09 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: [PATCH v4 6/7] s390: ap: Cleanup on removing the AP device
Date:   Fri, 22 Feb 2019 16:29:59 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19022215-0028-0000-0000-0000034BC8B1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022215-0029-0000-0000-0000240A11F1
Message-Id: <1550849400-27152-7-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-22_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902220109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the device is remove, we must make sure to
clear the interruption and reset the AP device.

We also need to clear the CRYCB of the guest.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c     | 35 +++++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c     |  3 ++-
 drivers/s390/crypto/vfio_ap_private.h |  3 +++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index eca0ffc..e5d91ff 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -5,6 +5,7 @@
  * Copyright IBM Corp. 2018
  *
  * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
+ *	      Pierre Morel <pmorel@linux.ibm.com>
  */
 
 #include <linux/module.h>
@@ -12,6 +13,8 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <asm/facility.h>
+#include <linux/bitops.h>
+#include <linux/kvm_host.h>
 #include "vfio_ap_private.h"
 
 #define VFIO_AP_ROOT_NAME "vfio_ap"
@@ -61,6 +64,33 @@ static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
 }
 
 /**
+ * vfio_ap_update_crycb
+ * @q: A pointer to the queue being removed
+ *
+ * We clear the APID of the queue, making this queue unusable for the guest.
+ * After this function we can reset the queue without to fear a race with
+ * the guest to access the queue again.
+ * We do not fear race with the host as we still get the device.
+ */
+static void vfio_ap_update_crycb(struct vfio_ap_queue *q)
+{
+	struct ap_matrix_mdev *matrix_mdev = q->matrix_mdev;
+
+	if (!matrix_mdev)
+		return;
+
+	clear_bit_inv(AP_QID_CARD(q->apqn), matrix_mdev->matrix.apm);
+
+	if (!matrix_mdev->kvm)
+		return;
+
+	kvm_arch_crypto_set_masks(matrix_mdev->kvm,
+				  matrix_mdev->matrix.apm,
+				  matrix_mdev->matrix.aqm,
+				  matrix_mdev->matrix.adm);
+}
+
+/**
  * vfio_ap_queue_dev_remove:
  *
  * Free the associated vfio_ap_queue structure
@@ -70,6 +100,11 @@ static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
 	struct vfio_ap_queue *q;
 
 	q = dev_get_drvdata(&apdev->device);
+	if (!q)
+		return;
+
+	vfio_ap_update_crycb(q);
+	vfio_ap_mdev_reset_queue(q);
 	list_del(&q->list);
 	kfree(q);
 }
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 0196065..5b9bb33 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -59,6 +59,7 @@ int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
 			if (retry <= 0)
 				pr_warn("%s: queue 0x%04x not empty\n",
 					__func__, q->apqn);
+			vfio_ap_free_irq(q);
 			return 0;
 		case AP_RESPONSE_RESET_IN_PROGRESS:
 		case AP_RESPONSE_BUSY:
@@ -83,7 +84,7 @@ int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
  * Unregister the ISC from the GIB alert
  * Clear the vfio_ap_queue intern fields
  */
-static void vfio_ap_free_irq(struct vfio_ap_queue *q)
+void vfio_ap_free_irq(struct vfio_ap_queue *q)
 {
 	if (!q)
 		return;
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index e2fd2c0..cc18215 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -4,6 +4,7 @@
  *
  * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
  *	      Halil Pasic <pasic@linux.ibm.com>
+ *	      Pierre Morel <pmorel@linux.ibm.com>
  *
  * Copyright IBM Corp. 2018
  */
@@ -98,4 +99,6 @@ struct vfio_ap_queue {
 	int	apqn;
 	unsigned char isc;
 };
+void vfio_ap_free_irq(struct vfio_ap_queue *q);
+int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q);
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.7.4

