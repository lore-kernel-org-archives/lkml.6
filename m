Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94CDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79EB9222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438968AbfBNNvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:51:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45964 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407154AbfBNNvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:51:31 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EDiJvC076057
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:51:30 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qn7x77gk6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:51:28 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 14 Feb 2019 13:51:26 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Feb 2019 13:51:24 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1EDpNEu59113636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Feb 2019 13:51:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB78D4203F;
        Thu, 14 Feb 2019 13:51:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F6324204B;
        Thu, 14 Feb 2019 13:51:22 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.140])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Feb 2019 13:51:22 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: [PATCH v3 8/9] s390: ap: Cleanup on removing the AP device
Date:   Thu, 14 Feb 2019 14:51:08 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19021413-0012-0000-0000-000002F5B482
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021413-0013-0000-0000-0000212D31B6
Message-Id: <1550152269-6317-9-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902140098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the device is remove, we must make sure to
clear the interruption and reset the AP device.

We also need to clear the CRYCB of the guest.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c     | 92 +++++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_ops.c     |  2 +-
 drivers/s390/crypto/vfio_ap_private.h |  2 +
 3 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 03153e6..50428be 100644
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
@@ -64,6 +67,88 @@ static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
 	return 0;
 }
 
+/*
+ * vfio_ap_drain_queue
+ * @q: the queue to drain
+ *
+ * This function waits until the queue is empty.
+ */
+static void vfio_ap_drain_queue(struct vfio_ap_queue *q)
+{
+	struct ap_queue_status status;
+	int retry = 20;
+
+	status = ap_tapq(q->apqn, NULL);
+	while (!status.queue_empty && retry--)  {
+		msleep(200);
+		status = ap_tapq(q->apqn, NULL);
+	}
+	if (retry <= 0) {
+		pr_warn("%s: queue not empty after zapq on apqn 0x%04x\n",
+			__func__, q->apqn);
+	}
+}
+
+/*
+ * vfio_ap_zapq
+ * @q: The queue to zerro
+ *
+ * It is best effort, no return value is done, however on success
+ * we will drain the queue before getting the queue back to the
+ * AP bus.
+ */
+static void vfio_ap_zapq(struct vfio_ap_queue *q)
+{
+	struct ap_queue_status status;
+	int retry = 20;
+
+	do {
+		status = ap_zapq(q->apqn);
+		switch (status.response_code) {
+		case AP_RESPONSE_RESET_IN_PROGRESS:
+		case AP_RESPONSE_BUSY:
+			msleep(20);
+			break;
+		default:
+			pr_warn("%s: zapq error %02x on apqn 0x%04x\n",
+				__func__, status.response_code, q->apqn);
+			return;
+		case AP_RESPONSE_NORMAL:
+			vfio_ap_drain_queue(q);
+			return;
+		}
+	} while (retry--);
+	pr_warn("%s: zapq retry count exceeded code %02x on apqn 0x%04x\n",
+		__func__, status.response_code, q->apqn);
+}
+
+/**
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
+	struct ap_matrix_mdev *matrix_mdev = q->matrix;
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
 /**
  * vfio_ap_queue_dev_remove:
  *
@@ -74,6 +159,13 @@ static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
 	struct vfio_ap_queue *q;
 
 	q = dev_get_drvdata(&apdev->device);
+	if (!q)
+		return;
+
+	vfio_ap_update_crycb(q);
+	vfio_ap_zapq(q);
+
+	vfio_ap_free_irq(q);
 	kfree(q);
 }
 
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 5664cf3..7ec957c 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -85,7 +85,7 @@ static void vfio_ap_put_queue(struct vfio_ap_queue *q)
  * Unregister the ISC from the GIB alert
  * Clear the vfio_ap_queue intern fields
  */
-static void vfio_ap_free_irq(struct vfio_ap_queue *q)
+void vfio_ap_free_irq(struct vfio_ap_queue *q)
 {
 	unsigned long pfn = q->nib >> PAGE_SHIFT;
 
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 16c99e9..d108c6d 100644
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
@@ -95,4 +96,5 @@ struct vfio_ap_queue {
 	unsigned long nib;
 	unsigned char isc;
 };
+void vfio_ap_free_irq(struct vfio_ap_queue *q);
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.7.4

