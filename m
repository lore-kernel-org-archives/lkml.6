Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5305C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9617D2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfBUOPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:15:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725880AbfBUOPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:15:06 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1LEEkU0022572
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 09:15:05 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qswk300ee-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 09:15:02 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 21 Feb 2019 14:15:00 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Feb 2019 14:14:57 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1LEEuQm14155886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Feb 2019 14:14:56 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40024A4051;
        Thu, 21 Feb 2019 14:14:56 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C61F9A4040;
        Thu, 21 Feb 2019 14:14:55 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.152.224.140])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 21 Feb 2019 14:14:55 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     borntraeger@de.ibm.com
Cc:     cohuck@redhat.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        freude@linux.ibm.com
Subject: [PATCH v3 1/1] s390: vfio_ap: link the vfio_ap devices to the vfio_ap bus subsystem
Date:   Thu, 21 Feb 2019 15:14:54 +0100
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550758494-28227-1-git-send-email-pmorel@linux.ibm.com>
References: <1550758494-28227-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19022114-0016-0000-0000-0000025935C8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022114-0017-0000-0000-000032B38635
Message-Id: <1550758494-28227-2-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902210104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Libudev relies on having a subsystem link for non-root devices. To
avoid libudev (and potentially other userspace tools) choking on the
matrix device let us introduce a matrix bus and with it the matrix
bus subsytem. Also make the matrix device reside within the matrix
bus.

Doing this we remove the forced link from the matrix device to the
vfio_ap driver and the device_type we do not need anymore.

Since the associated matrix driver is not the vfio_ap driver any more,
we have to change the search for the devices on the vfio_ap driver in
the function vfio_ap_verify_queue_reserved.

Fixes: 1fde573413b5 ("s390: vfio-ap: base implementation of VFIO AP device driver")

Cc: stable@vger.kernel.org

Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_drv.c     | 44 ++++++++++++++++++++++++++++-------
 drivers/s390/crypto/vfio_ap_ops.c     |  4 ++--
 drivers/s390/crypto/vfio_ap_private.h |  1 +
 3 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 31c6c84..e9824c3 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -15,7 +15,6 @@
 #include "vfio_ap_private.h"
 
 #define VFIO_AP_ROOT_NAME "vfio_ap"
-#define VFIO_AP_DEV_TYPE_NAME "ap_matrix"
 #define VFIO_AP_DEV_NAME "matrix"
 
 MODULE_AUTHOR("IBM Corporation");
@@ -24,10 +23,6 @@ MODULE_LICENSE("GPL v2");
 
 static struct ap_driver vfio_ap_drv;
 
-static struct device_type vfio_ap_dev_type = {
-	.name = VFIO_AP_DEV_TYPE_NAME,
-};
-
 struct ap_matrix_dev *matrix_dev;
 
 /* Only type 10 adapters (CEX4 and later) are supported
@@ -62,6 +57,22 @@ static void vfio_ap_matrix_dev_release(struct device *dev)
 	kfree(matrix_dev);
 }
 
+static int matrix_bus_match(struct device *dev, struct device_driver *drv)
+{
+	return 1;
+}
+
+static struct bus_type matrix_bus = {
+	.name = "matrix",
+	.match = &matrix_bus_match,
+};
+
+static struct device_driver matrix_driver = {
+	.name = "vfio_ap",
+	.bus = &matrix_bus,
+	.suppress_bind_attrs = true,
+};
+
 static int vfio_ap_matrix_dev_create(void)
 {
 	int ret;
@@ -71,6 +82,10 @@ static int vfio_ap_matrix_dev_create(void)
 	if (IS_ERR(root_device))
 		return PTR_ERR(root_device);
 
+	ret = bus_register(&matrix_bus);
+	if (ret)
+		goto bus_register_err;
+
 	matrix_dev = kzalloc(sizeof(*matrix_dev), GFP_KERNEL);
 	if (!matrix_dev) {
 		ret = -ENOMEM;
@@ -87,30 +102,41 @@ static int vfio_ap_matrix_dev_create(void)
 	mutex_init(&matrix_dev->lock);
 	INIT_LIST_HEAD(&matrix_dev->mdev_list);
 
-	matrix_dev->device.type = &vfio_ap_dev_type;
 	dev_set_name(&matrix_dev->device, "%s", VFIO_AP_DEV_NAME);
 	matrix_dev->device.parent = root_device;
+	matrix_dev->device.bus = &matrix_bus;
 	matrix_dev->device.release = vfio_ap_matrix_dev_release;
-	matrix_dev->device.driver = &vfio_ap_drv.driver;
+	matrix_dev->vfio_ap_drv = &vfio_ap_drv;
 
 	ret = device_register(&matrix_dev->device);
 	if (ret)
 		goto matrix_reg_err;
 
+	ret = driver_register(&matrix_driver);
+	if (ret)
+		goto matrix_drv_err;
+
 	return 0;
 
+matrix_drv_err:
+	device_unregister(&matrix_dev->device);
 matrix_reg_err:
 	put_device(&matrix_dev->device);
 matrix_alloc_err:
+	bus_unregister(&matrix_bus);
+bus_register_err:
 	root_device_unregister(root_device);
-
 	return ret;
 }
 
 static void vfio_ap_matrix_dev_destroy(void)
 {
+	struct device *root_device = matrix_dev->device.parent;
+
+	driver_unregister(&matrix_driver);
 	device_unregister(&matrix_dev->device);
-	root_device_unregister(matrix_dev->device.parent);
+	bus_unregister(&matrix_bus);
+	root_device_unregister(root_device);
 }
 
 static int __init vfio_ap_init(void)
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 272ef42..900b9cf 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -198,8 +198,8 @@ static int vfio_ap_verify_queue_reserved(unsigned long *apid,
 	qres.apqi = apqi;
 	qres.reserved = false;
 
-	ret = driver_for_each_device(matrix_dev->device.driver, NULL, &qres,
-				     vfio_ap_has_queue);
+	ret = driver_for_each_device(&matrix_dev->vfio_ap_drv->driver, NULL,
+				     &qres, vfio_ap_has_queue);
 	if (ret)
 		return ret;
 
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 5675492..76b7f98 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -40,6 +40,7 @@ struct ap_matrix_dev {
 	struct ap_config_info info;
 	struct list_head mdev_list;
 	struct mutex lock;
+	struct ap_driver  *vfio_ap_drv;
 };
 
 extern struct ap_matrix_dev *matrix_dev;
-- 
2.7.4

