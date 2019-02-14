Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D2EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA03222B6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 13:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407135AbfBNNv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 08:51:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407048AbfBNNvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 08:51:25 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1EDiISB107121
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:51:23 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qn8hf50t2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:51:23 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 14 Feb 2019 13:51:21 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 14 Feb 2019 13:51:18 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1EDpGDu42270880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Feb 2019 13:51:16 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60EA94204C;
        Thu, 14 Feb 2019 13:51:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DA93842045;
        Thu, 14 Feb 2019 13:51:15 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.140])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 14 Feb 2019 13:51:15 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
Subject: [PATCH v3 4/9] s390: ap: tools to find a queue with a specific APQN
Date:   Thu, 14 Feb 2019 14:51:04 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19021413-4275-0000-0000-0000030F7928
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021413-4276-0000-0000-0000381D9526
Message-Id: <1550152269-6317-5-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=884 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902140098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to find the queue with a specific APQN during the
handling of the interception of the PQAP/AQIC instruction.

To handle the AP associated device reference count we keep
track of it in the vfio_ap_queue until we put the device.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 54 +++++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |  1 +
 2 files changed, 55 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 900b9cf..2a52c9b 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -24,6 +24,60 @@
 #define VFIO_AP_MDEV_TYPE_HWVIRT "passthrough"
 #define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
 
+/**
+ * vfio_ap_check_apqn: check if a ap_queue is of a given APQN
+ *
+ * Returns 1 if we have a match.
+ * Otherwise returns 0.
+ */
+static int vfio_ap_check_apqn(struct device *dev, void *data)
+{
+	struct vfio_ap_queue *q = dev_get_drvdata(dev);
+
+	return (q->apqn == *(int *)data);
+}
+
+/**
+ * vfio_ap_get_queue: Retrieve a queue with a specific APQN
+ * @apqn: The queue APQN
+ *
+ * Retrieve a queue with a specific APQN from the list of the
+ * devices associated to the vfio_ap_driver.
+ *
+ * The vfio_ap_queue has been already associated with the device
+ * during the probe.
+ * Store the associated device for reference counting
+ *
+ * Returns the pointer to the associated vfio_ap_queue
+ */
+static  __attribute__((unused))
+	struct vfio_ap_queue *vfio_ap_get_queue(int apqn)
+{
+	struct device *dev;
+	struct vfio_ap_queue *q;
+
+	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL, &apqn,
+				 vfio_ap_check_apqn);
+	if (!dev)
+		return NULL;
+	q = dev_get_drvdata(dev);
+	q->dev = dev;
+	return q;
+}
+
+/**
+ * vfio_ap_put_queue: lower device reference count for a queue
+ * @q: The queue
+ *
+ * put the associated device
+ *
+ */
+static  __attribute__((unused)) void vfio_ap_put_queue(struct vfio_ap_queue *q)
+{
+	put_device(q->dev);
+	q->dev = NULL;
+}
+
 static void vfio_ap_matrix_init(struct ap_config_info *info,
 				struct ap_matrix *matrix)
 {
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 8836f01..081f0d7 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -87,6 +87,7 @@ extern int vfio_ap_mdev_register(void);
 extern void vfio_ap_mdev_unregister(void);
 
 struct vfio_ap_queue {
+	struct device *dev;
 	int	apqn;
 };
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.7.4

