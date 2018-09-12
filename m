Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D101FC070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA822133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA822133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbeIMAt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:49:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728193AbeIMAt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:49:56 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8CJY3M0040344
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:43:52 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mf68efg58-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:43:51 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Wed, 12 Sep 2018 13:43:51 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Sep 2018 13:43:47 -0600
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8CJhiec19923030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Sep 2018 12:43:44 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAC4F6A04D;
        Wed, 12 Sep 2018 13:43:44 -0600 (MDT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE3A36A047;
        Wed, 12 Sep 2018 13:43:41 -0600 (MDT)
Received: from localhost.localdomain (unknown [9.80.213.181])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Wed, 12 Sep 2018 13:43:41 -0600 (MDT)
From:   Tony Krowiak <akrowiak@linux.vnet.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        akrowiak@linux.vnet.ibm.com, frankja@linux.ibm.com,
        Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v10 05/26] s390: vfio-ap: register matrix device with VFIO mdev framework
Date:   Wed, 12 Sep 2018 15:42:55 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18091219-0036-0000-0000-00000A3600EE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009709; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01087371; UDB=6.00561488; IPR=6.00867383;
 MB=3.00023256; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-12 19:43:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091219-0037-0000-0000-000048EAD68F
Message-Id: <1536781396-13601-6-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-12_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809120195
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Krowiak <akrowiak@linux.ibm.com>

Registers the matrix device created by the VFIO AP device
driver with the VFIO mediated device framework.
Registering the matrix device will create the sysfs
structures needed to create mediated matrix devices
each of which will be used to configure the AP matrix
for a guest and connect it to the VFIO AP device driver.

Registering the matrix device with the VFIO mediated device
framework will create the following sysfs structures:

/sys/devices/vfio_ap/matrix/
...... [mdev_supported_types]
......... [vfio_ap-passthrough]
............ create

To create a mediated device for the AP matrix device, write a UUID
to the create file:

	uuidgen > create

A symbolic link to the mediated device's directory will be created in the
devices subdirectory named after the generated $uuid:

/sys/devices/vfio_ap/matrix/
...... [mdev_supported_types]
......... [vfio_ap-passthrough]
............ [devices]
............... [$uuid]

A symbolic link to the mediated device will also be created
in the vfio_ap matrix's directory:

/sys/devices/vfio_ap/matrix/[$uuid]

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Michael Mueller <mimu@linux.ibm.com>
Tested-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 MAINTAINERS                           |    1 +
 drivers/s390/crypto/Makefile          |    2 +-
 drivers/s390/crypto/vfio_ap_drv.c     |   19 +++++
 drivers/s390/crypto/vfio_ap_ops.c     |  126 +++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |   49 +++++++++++++
 include/uapi/linux/vfio.h             |    1 +
 6 files changed, 197 insertions(+), 1 deletions(-)
 create mode 100644 drivers/s390/crypto/vfio_ap_ops.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9284283..5a5aa0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12661,6 +12661,7 @@ W:	http://www.ibm.com/developerworks/linux/linux390/
 S:	Supported
 F:	drivers/s390/crypto/vfio_ap_drv.c
 F:	drivers/s390/crypto/vfio_ap_private.h
+F:	drivers/s390/crypto/vfio_ap_ops.c
 
 S390 ZFCP DRIVER
 M:	Steffen Maier <maier@linux.ibm.com>
diff --git a/drivers/s390/crypto/Makefile b/drivers/s390/crypto/Makefile
index 48e466e..8d36b05 100644
--- a/drivers/s390/crypto/Makefile
+++ b/drivers/s390/crypto/Makefile
@@ -17,5 +17,5 @@ pkey-objs := pkey_api.o
 obj-$(CONFIG_PKEY) += pkey.o
 
 # adjunct processor matrix
-vfio_ap-objs := vfio_ap_drv.o
+vfio_ap-objs := vfio_ap_drv.o vfio_ap_ops.o
 obj-$(CONFIG_VFIO_AP) += vfio_ap.o
diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index 3e635f0..75f8bdc 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -76,6 +76,16 @@ static int vfio_ap_matrix_dev_create(void)
 		goto matrix_alloc_err;
 	}
 
+	/* Test if PQAP(QCI) instruction is available */
+	if (test_facility(12)) {
+		ret = ap_qci(&matrix_dev->info);
+		if (ret)
+			goto matrix_alloc_err;
+	}
+
+	mutex_init(&matrix_dev->lock);
+	INIT_LIST_HEAD(&matrix_dev->mdev_list);
+
 	matrix_dev->device.type = &vfio_ap_dev_type;
 	dev_set_name(&matrix_dev->device, "%s", VFIO_AP_DEV_NAME);
 	matrix_dev->device.parent = root_device;
@@ -121,11 +131,20 @@ int __init vfio_ap_init(void)
 		return ret;
 	}
 
+	ret = vfio_ap_mdev_register();
+	if (ret) {
+		ap_driver_unregister(&vfio_ap_drv);
+		vfio_ap_matrix_dev_destroy();
+
+		return ret;
+	}
+
 	return 0;
 }
 
 void __exit vfio_ap_exit(void)
 {
+	vfio_ap_mdev_unregister();
 	ap_driver_unregister(&vfio_ap_drv);
 	vfio_ap_matrix_dev_destroy();
 }
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
new file mode 100644
index 0000000..99ed303
--- /dev/null
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Adjunct processor matrix VFIO device driver callbacks.
+ *
+ * Copyright IBM Corp. 2018
+ *
+ * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
+ *	      Halil Pasic <pasic@linux.ibm.com>
+ *	      Pierre Morel <pmorel@linux.ibm.com>
+ */
+#include <linux/string.h>
+#include <linux/vfio.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/ctype.h>
+#include <asm/zcrypt.h>
+
+#include "vfio_ap_private.h"
+
+#define VFIO_AP_MDEV_TYPE_HWVIRT "passthrough"
+#define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
+
+static void vfio_ap_matrix_init(struct ap_config_info *info,
+				struct ap_matrix *matrix)
+{
+	matrix->apm_max = info->apxa ? info->Na : 63;
+	matrix->aqm_max = info->apxa ? info->Nd : 15;
+	matrix->adm_max = info->apxa ? info->Nd : 15;
+}
+
+static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
+{
+	struct ap_matrix_mdev *matrix_mdev;
+
+	if ((atomic_dec_if_positive(&matrix_dev->available_instances) < 0))
+		return -EPERM;
+
+	matrix_mdev = kzalloc(sizeof(*matrix_mdev), GFP_KERNEL);
+	if (!matrix_mdev) {
+		atomic_inc(&matrix_dev->available_instances);
+		return -ENOMEM;
+	}
+
+	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
+	mdev_set_drvdata(mdev, matrix_mdev);
+	mutex_lock(&matrix_dev->lock);
+	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
+	mutex_unlock(&matrix_dev->lock);
+
+	return 0;
+}
+
+static int vfio_ap_mdev_remove(struct mdev_device *mdev)
+{
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+
+	mutex_lock(&matrix_dev->lock);
+	list_del(&matrix_mdev->node);
+	mutex_unlock(&matrix_dev->lock);
+
+	kfree(matrix_mdev);
+	mdev_set_drvdata(mdev, NULL);
+	atomic_inc(&matrix_dev->available_instances);
+
+	return 0;
+}
+
+static ssize_t name_show(struct kobject *kobj, struct device *dev, char *buf)
+{
+	return sprintf(buf, "%s\n", VFIO_AP_MDEV_NAME_HWVIRT);
+}
+
+MDEV_TYPE_ATTR_RO(name);
+
+static ssize_t available_instances_show(struct kobject *kobj,
+					struct device *dev, char *buf)
+{
+	return sprintf(buf, "%d\n",
+		       atomic_read(&matrix_dev->available_instances));
+}
+
+MDEV_TYPE_ATTR_RO(available_instances);
+
+static ssize_t device_api_show(struct kobject *kobj, struct device *dev,
+			       char *buf)
+{
+	return sprintf(buf, "%s\n", VFIO_DEVICE_API_AP_STRING);
+}
+
+MDEV_TYPE_ATTR_RO(device_api);
+
+static struct attribute *vfio_ap_mdev_type_attrs[] = {
+	&mdev_type_attr_name.attr,
+	&mdev_type_attr_device_api.attr,
+	&mdev_type_attr_available_instances.attr,
+	NULL,
+};
+
+static struct attribute_group vfio_ap_mdev_hwvirt_type_group = {
+	.name = VFIO_AP_MDEV_TYPE_HWVIRT,
+	.attrs = vfio_ap_mdev_type_attrs,
+};
+
+static struct attribute_group *vfio_ap_mdev_type_groups[] = {
+	&vfio_ap_mdev_hwvirt_type_group,
+	NULL,
+};
+
+static const struct mdev_parent_ops vfio_ap_matrix_ops = {
+	.owner			= THIS_MODULE,
+	.supported_type_groups	= vfio_ap_mdev_type_groups,
+	.create			= vfio_ap_mdev_create,
+	.remove			= vfio_ap_mdev_remove,
+};
+
+int vfio_ap_mdev_register(void)
+{
+	atomic_set(&matrix_dev->available_instances, MAX_ZDEV_ENTRIES_EXT);
+
+	return mdev_register_device(&matrix_dev->device, &vfio_ap_matrix_ops);
+}
+
+void vfio_ap_mdev_unregister(void)
+{
+	mdev_unregister_device(&matrix_dev->device);
+}
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 6141420..a2eab78 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -3,6 +3,7 @@
  * Private data and functions for adjunct processor VFIO matrix driver.
  *
  * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
+ *	      Halil Pasic <pasic@linux.ibm.com>
  *
  * Copyright IBM Corp. 2018
  */
@@ -24,11 +25,59 @@
 /**
  * ap_matrix_dev - the AP matrix device structure
  * @device:	generic device structure associated with the AP matrix device
+ * @available_instances: number of mediated matrix devices that can be created
+ * @info:	the struct containing the output from the PQAP(TAPQ) instruction
+ * mdev_list:	the list of mediated matrix devices created
+ * lock:	mutex for locking the AP matrix device. This lock will be
+ *		taken every time we fiddle with state managed by the vfio_ap
+ *		driver, be it using @mdev_list or writing the state of a
+ *		single ap_matrix_mdev device. It's quite coarse but we don't
+ *		expect much contention.
  */
 struct ap_matrix_dev {
 	struct device device;
+	atomic_t available_instances;
+	struct ap_config_info info;
+	struct list_head mdev_list;
+	struct mutex lock;
 };
 
 extern struct ap_matrix_dev *matrix_dev;
 
+/**
+ * The AP matrix is comprised of three bit masks identifying the adapters,
+ * queues (domains) and control domains that belong to an AP matrix. The bits i
+ * each mask, from least significant to most significant bit, correspond to IDs
+ * 0 to 255. When a bit is set, the corresponding ID belongs to the matrix.
+ *
+ * @apm_max: max adapter number in @apm
+ * @apm identifies the AP adapters in the matrix
+ * @aqm_max: max domain number in @aqm
+ * @aqm identifies the AP queues (domains) in the matrix
+ * @adm_max: max domain number in @adm
+ * @adm identifies the AP control domains in the matrix
+ */
+struct ap_matrix {
+	unsigned long apm_max;
+	DECLARE_BITMAP(apm, 256);
+	unsigned long aqm_max;
+	DECLARE_BITMAP(aqm, 256);
+	unsigned long adm_max;
+	DECLARE_BITMAP(adm, 256);
+};
+
+/**
+ * struct ap_matrix_mdev - the mediated matrix device structure
+ * @list:	allows the ap_matrix_mdev struct to be added to a list
+ * @matrix:	the adapters, usage domains and control domains assigned to the
+ *		mediated matrix device.
+ */
+struct ap_matrix_mdev {
+	struct list_head node;
+	struct ap_matrix matrix;
+};
+
+extern int vfio_ap_mdev_register(void);
+extern void vfio_ap_mdev_unregister(void);
+
 #endif /* _VFIO_AP_PRIVATE_H_ */
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 1aa7b82..bfbe2be 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -215,6 +215,7 @@ struct vfio_device_info {
 #define VFIO_DEVICE_API_PLATFORM_STRING		"vfio-platform"
 #define VFIO_DEVICE_API_AMBA_STRING		"vfio-amba"
 #define VFIO_DEVICE_API_CCW_STRING		"vfio-ccw"
+#define VFIO_DEVICE_API_AP_STRING		"vfio-ap"
 
 /**
  * VFIO_DEVICE_GET_REGION_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 8,
-- 
1.7.1

