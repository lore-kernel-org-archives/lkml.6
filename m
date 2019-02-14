Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9B5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5D9222D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407191AbfBNNwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:52:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407118AbfBNNvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:51:25 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EDiSJP113084
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:51:25 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qn94b1wt1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:51:24 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 14 Feb 2019 13:51:22 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Feb 2019 13:51:19 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1EDpITi8323558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Feb 2019 13:51:18 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0635D4204B;
        Thu, 14 Feb 2019 13:51:18 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D3B042049;
        Thu, 14 Feb 2019 13:51:17 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.140])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Feb 2019 13:51:17 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: [PATCH v3 5/9] s390: ap: tools to associate a queue to a matrix
Date:   Thu, 14 Feb 2019 14:51:05 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19021413-0028-0000-0000-000003488C91
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021413-0029-0000-0000-00002406B878
Message-Id: <1550152269-6317-6-git-send-email-pmorel@linux.ibm.com>
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

We need tools to associate a queue and a matrix to be able
later to find the matrix associated with the queue for which
we got the APQN in the register 1 during a PQAP/AQIC instruction
interception.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 66 +++++++++++++++++++++++++++++++++--
 drivers/s390/crypto/vfio_ap_private.h |  1 +
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 2a52c9b..1851b24 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -50,8 +50,7 @@ static int vfio_ap_check_apqn(struct device *dev, void *data)
  *
  * Returns the pointer to the associated vfio_ap_queue
  */
-static  __attribute__((unused))
-	struct vfio_ap_queue *vfio_ap_get_queue(int apqn)
+static struct vfio_ap_queue *vfio_ap_get_queue(int apqn)
 {
 	struct device *dev;
 	struct vfio_ap_queue *q;
@@ -72,7 +71,7 @@ static  __attribute__((unused))
  * put the associated device
  *
  */
-static  __attribute__((unused)) void vfio_ap_put_queue(struct vfio_ap_queue *q)
+static void vfio_ap_put_queue(struct vfio_ap_queue *q)
 {
 	put_device(q->dev);
 	q->dev = NULL;
@@ -867,6 +866,67 @@ static int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
 	return -EBUSY;
 }
 
+/**
+ * vfio_ap_dissociate_queues: Dissociate a matrix mediated device to a queue
+ *
+ * Go through all bits in the AQM and APM and dissociate the queue
+ * from the matrix device.
+ *
+ * No return value we are throwing the mediated device anyway.
+ */
+static void vfio_ap_dissociate_queues(struct ap_matrix_mdev *matrix_mdev)
+{
+	unsigned long apid, apqi;
+	struct vfio_ap_queue *q;
+
+	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
+			     matrix_mdev->matrix.apm_max + 1) {
+		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
+				     matrix_mdev->matrix.aqm_max + 1) {
+			q = vfio_ap_get_queue(AP_MKQID(apid, apqi));
+			if (q) {
+				vfio_ap_mdev_reset_queue(apid, apqi, 1);
+				q->matrix = NULL;
+				vfio_ap_put_queue(q);
+			} else
+				pr_err("%s: no queue for %02lx.%04lx\n",
+				       __func__, apid, apqi);
+		}
+	}
+}
+
+/**
+ * vfio_ap_associate_queues: Associate a matrix mediated device to a queue
+ *
+ * Go through all bits in the AQM and APM and calculate the APQN, and find
+ * the matching queue to associate with the matrix device.
+ *
+ * In the case a queue could not be found return -ENODEV.
+ * Otherwise return 0.
+ */
+static __attribute__((unused))
+	int vfio_ap_associate_queues(struct ap_matrix_mdev *matrix_mdev)
+{
+	unsigned long apid, apqi;
+	struct vfio_ap_queue *q;
+
+	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
+			     matrix_mdev->matrix.apm_max + 1) {
+		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
+				     matrix_mdev->matrix.aqm_max + 1) {
+			q = vfio_ap_get_queue(AP_MKQID(apid, apqi));
+			if (!q)
+				goto error;
+			q->matrix = matrix_mdev;
+			vfio_ap_put_queue(q);
+		}
+	}
+	return 0;
+error:
+	pr_err("%s: no queue for %02lx.%04lx\n", __func__, apid, apqi);
+	vfio_ap_dissociate_queues(matrix_mdev);
+	return -ENODEV;
+}
 static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
 {
 	int ret;
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 081f0d7..10bc8b5 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -89,5 +89,6 @@ extern void vfio_ap_mdev_unregister(void);
 struct vfio_ap_queue {
 	struct device *dev;
 	int	apqn;
+	struct ap_matrix_mdev *matrix;
 };
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.7.4

