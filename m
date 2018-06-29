Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6D1C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E0E27F4F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 21:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E0E27F4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937527AbeF2VMA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 17:12:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1030443AbeF2VLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 17:11:52 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5TL9Ajs074459
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 17:11:52 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jwujk9s6w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 17:11:52 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Fri, 29 Jun 2018 17:11:50 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 29 Jun 2018 17:11:47 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5TLBjUk3080546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Jun 2018 21:11:45 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5001A124055;
        Fri, 29 Jun 2018 18:13:14 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CDA2124052;
        Fri, 29 Jun 2018 18:13:13 -0400 (EDT)
Received: from localhost.localdomain (unknown [9.85.157.42])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri, 29 Jun 2018 18:13:13 -0400 (EDT)
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
        akrowiak@linux.vnet.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v6 08/21] s390: vfio-ap: register matrix device with VFIO mdev framework
Date:   Fri, 29 Jun 2018 17:11:10 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1530306683-7270-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062921-2213-0000-0000-000002C21E9A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009278; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01054189; UDB=6.00540581; IPR=6.00832111;
 MB=3.00021933; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-29 21:11:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062921-2214-0000-0000-00005AA78653
Message-Id: <1530306683-7270-9-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-29_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806290224
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Registers the matrix device created by the VFIO AP device
driver with the VFIO mediated device framework.
Registering the matrix device will create the sysfs
structures needed to create mediated matrix devices
each of which will be used to configure the AP matrix
for a guest and connect it to the VFIO AP device driver.

Registering the matrix device with the VFIO mediated device
framework will create the following sysfs structures:

/sys/devices/vfio_ap
... [matrix]
...... [mdev_supported_types]
......... [vfio_ap-passthrough]
............ create

To create a mediated device for the AP matrix device, write a UUID
to the create file:

	uuidgen > create

A symbolic link to the mediated device's directory will be created in the
devices subdirectory named after the generated $uuid:

/sys/devices/vfio_ap
... [matrix]
...... [mdev_supported_types]
......... [vfio_ap-passthrough]
............ [devices]
............... [$uuid]

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 MAINTAINERS                           |    1 +
 drivers/s390/crypto/Makefile          |    2 +-
 drivers/s390/crypto/vfio_ap_drv.c     |    9 ++
 drivers/s390/crypto/vfio_ap_ops.c     |  131 +++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |   22 +++++-
 5 files changed, 161 insertions(+), 4 deletions(-)
 create mode 100644 drivers/s390/crypto/vfio_ap_ops.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0515dae..3217803 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12410,6 +12410,7 @@ W:	http://www.ibm.com/developerworks/linux/linux390/
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
index 93db312..b6ff7a4 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -127,11 +127,20 @@ int __init vfio_ap_init(void)
 		return ret;
 	}
 
+	ret = vfio_ap_mdev_register(matrix_dev);
+	if (ret) {
+		ap_driver_unregister(&vfio_ap_drv);
+		vfio_ap_matrix_dev_destroy(matrix_dev);
+
+		return ret;
+	}
+
 	return 0;
 }
 
 void __exit vfio_ap_exit(void)
 {
+	vfio_ap_mdev_unregister(matrix_dev);
 	ap_driver_unregister(&vfio_ap_drv);
 	vfio_ap_matrix_dev_destroy(matrix_dev);
 }
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
new file mode 100644
index 0000000..4e61e33
--- /dev/null
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Adjunct processor matrix VFIO device driver callbacks.
+ *
+ * Copyright IBM Corp. 2018
+ * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
+ *
+ */
+#include <linux/string.h>
+#include <linux/vfio.h>
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/ctype.h>
+
+#include "vfio_ap_private.h"
+
+#define VFOP_AP_MDEV_TYPE_HWVIRT "passthrough"
+#define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
+
+DEFINE_SPINLOCK(mdev_list_lock);
+LIST_HEAD(mdev_list);
+
+static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
+{
+	struct ap_matrix_dev *matrix_dev =
+		to_ap_matrix_dev(mdev_parent_dev(mdev));
+	struct ap_matrix_mdev *matrix_mdev;
+
+	matrix_mdev = kzalloc(sizeof(*matrix_mdev), GFP_KERNEL);
+	if (!matrix_mdev)
+		return -ENOMEM;
+
+	matrix_mdev->name = dev_name(mdev_dev(mdev));
+	mdev_set_drvdata(mdev, matrix_mdev);
+
+	if (atomic_dec_if_positive(&matrix_dev->available_instances) < 0) {
+		kfree(matrix_mdev);
+		return -EPERM;
+	}
+
+	spin_lock_bh(&mdev_list_lock);
+	list_add(&matrix_mdev->list, &mdev_list);
+	spin_unlock_bh(&mdev_list_lock);
+
+	return 0;
+}
+
+static int vfio_ap_mdev_remove(struct mdev_device *mdev)
+{
+	struct ap_matrix_dev *matrix_dev =
+		to_ap_matrix_dev(mdev_parent_dev(mdev));
+	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+
+	spin_lock_bh(&mdev_list_lock);
+	list_del(&matrix_mdev->list);
+	spin_unlock_bh(&mdev_list_lock);
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
+	struct ap_matrix_dev *matrix_dev = to_ap_matrix_dev(dev);
+
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
+	.name = VFOP_AP_MDEV_TYPE_HWVIRT,
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
+int vfio_ap_mdev_register(struct ap_matrix_dev *matrix_dev)
+{
+	int ret;
+
+	ret = mdev_register_device(&matrix_dev->device, &vfio_ap_matrix_ops);
+	if (ret)
+		return ret;
+
+	atomic_set(&matrix_dev->available_instances,
+		   AP_MATRIX_MAX_AVAILABLE_INSTANCES);
+
+	return 0;
+}
+
+void vfio_ap_mdev_unregister(struct ap_matrix_dev *matrix_dev)
+{
+	mdev_unregister_device(&matrix_dev->device);
+}
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 19c0b60..3de1275 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -10,20 +10,36 @@
 #define _VFIO_AP_PRIVATE_H_
 
 #include <linux/types.h>
+#include <linux/device.h>
+#include <linux/mdev.h>
 
 #include "ap_bus.h"
 
 #define VFIO_AP_MODULE_NAME "vfio_ap"
 #define VFIO_AP_DRV_NAME "vfio_ap"
+/**
+ * There must be one mediated matrix device for every guest using AP devices.
+ * If every APQN is assigned to a guest, then the maximum number of guests with
+ * a unique APQN assigned would be 255 adapters x 255 domains = 72351 guests.
+ */
+#define AP_MATRIX_MAX_AVAILABLE_INSTANCES 72351
 
 struct ap_matrix_dev {
 	struct device device;
+	atomic_t available_instances;
+};
+
+struct ap_matrix_mdev {
+	const char *name;
+	struct list_head list;
 };
 
-static inline struct ap_matrix_dev
-*to_ap_matrix_parent_dev(struct device *dev)
+static struct ap_matrix_dev *to_ap_matrix_dev(struct device *dev)
 {
-	return container_of(dev, struct ap_matrix_dev, device.parent);
+	return container_of(dev, struct ap_matrix_dev, device);
 }
 
+extern int vfio_ap_mdev_register(struct ap_matrix_dev *matrix_dev);
+extern void vfio_ap_mdev_unregister(struct ap_matrix_dev *matrix_dev);
+
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
1.7.1

