Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF67C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C2CB21470
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2CB21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbeHNAdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:33:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39450 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731104AbeHNAdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:33:01 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7DLcsVK100463
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 17:48:49 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kuhxh8h6s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 17:48:48 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.vnet.ibm.com>;
        Mon, 13 Aug 2018 17:48:47 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 Aug 2018 17:48:43 -0400
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7DLmf5m17039462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Aug 2018 21:48:41 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D336124052;
        Mon, 13 Aug 2018 18:49:40 -0400 (EDT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 033EA124053;
        Mon, 13 Aug 2018 18:49:39 -0400 (EDT)
Received: from localhost.localdomain (unknown [9.85.141.105])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTPS;
        Mon, 13 Aug 2018 18:49:38 -0400 (EDT)
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
Subject: [PATCH v9 08/22] s390: vfio-ap: base implementation of VFIO AP device driver
Date:   Mon, 13 Aug 2018 17:48:05 -0400
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1534196899-16987-1-git-send-email-akrowiak@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18081321-0072-0000-0000-000003905D5D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009538; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01073087; UDB=6.00552882; IPR=6.00853043;
 MB=3.00022698; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-13 21:48:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18081321-0073-0000-0000-00004911237F
Message-Id: <1534196899-16987-9-git-send-email-akrowiak@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-13_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808130218
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Krowiak <akrowiak@linux.ibm.com>

Introduces a new AP device driver. This device driver
is built on the VFIO mediated device framework. The framework
provides sysfs interfaces that facilitate passthrough
access by guests to devices installed on the linux host.

The VFIO AP device driver will serve two purposes:

1. Provide the interfaces to reserve AP devices for exclusive
   use by KVM guests. This is accomplished by unbinding the
   devices to be reserved for guest usage from the zcrypt
   device driver and binding them to the VFIO AP device driver.

2. Implements the functions, callbacks and sysfs attribute
   interfaces required to create one or more VFIO mediated
   devices each of which will be used to configure the AP
   matrix for a guest and serve as a file descriptor
   for facilitating communication between QEMU and the
   VFIO AP device driver.

When the VFIO AP device driver is initialized:

* It registers with the AP bus for control of type 10 (CEX4
  and newer) AP queue devices. This limitation was imposed
  due to:

  1. A desire to keep the code as simple as possible;

  2. Some older models are no longer supported by the kernel
     and others are getting close to end of service.

  The probe and remove callbacks will be provided to support
  the binding/unbinding of AP queue devices to/from the VFIO
  AP device driver.

* Creates a matrix device, /sys/devices/vfio_ap/matrix,
  to serve as the parent of the mediated devices created, one
  for each guest, and to hold the APQNs of the AP devices bound to
  the VFIO AP device driver.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Michael Mueller <mimu@linux.ibm.com>
Tested-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 MAINTAINERS                           |   10 +++
 arch/s390/Kconfig                     |   11 +++
 drivers/s390/crypto/Makefile          |    4 +
 drivers/s390/crypto/vfio_ap_drv.c     |  118 +++++++++++++++++++++++++++++++++
 drivers/s390/crypto/vfio_ap_private.h |   30 ++++++++
 5 files changed, 173 insertions(+), 0 deletions(-)
 create mode 100644 drivers/s390/crypto/vfio_ap_drv.c
 create mode 100644 drivers/s390/crypto/vfio_ap_private.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 544cac8..e84c559 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12418,6 +12418,16 @@ W:	http://www.ibm.com/developerworks/linux/linux390/
 S:	Supported
 F:	drivers/s390/crypto/
 
+S390 VFIO AP DRIVER
+M:	Tony Krowiak <akrowiak@linux.ibm.com>
+M:	Pierre Morel <pmorel@linux.ibm.com>
+M:	Halil Pasic <pasic@linux.ibm.com>
+L:	linux-s390@vger.kernel.org
+W:	http://www.ibm.com/developerworks/linux/linux390/
+S:	Supported
+F:	drivers/s390/crypto/vfio_ap_drv.c
+F:	drivers/s390/crypto/vfio_ap_private.h
+
 S390 ZFCP DRIVER
 M:	Steffen Maier <maier@linux.ibm.com>
 M:	Benjamin Block <bblock@linux.ibm.com>
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 4fe5b2a..1097b28 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -778,6 +778,17 @@ config VFIO_CCW
 	  To compile this driver as a module, choose M here: the
 	  module will be called vfio_ccw.
 
+config VFIO_AP
+	def_tristate n
+	prompt "VFIO support for AP devices"
+	depends on ZCRYPT && VFIO_MDEV_DEVICE && KVM
+	help
+		This driver grants access to Adjunct Processor (AP) devices
+		via the VFIO mediated device interface.
+
+		To compile this driver as a module, choose M here: the module
+		will be called vfio_ap.
+
 endmenu
 
 menu "Dump support"
diff --git a/drivers/s390/crypto/Makefile b/drivers/s390/crypto/Makefile
index b59af54..48e466e 100644
--- a/drivers/s390/crypto/Makefile
+++ b/drivers/s390/crypto/Makefile
@@ -15,3 +15,7 @@ obj-$(CONFIG_ZCRYPT) += zcrypt_pcixcc.o zcrypt_cex2a.o zcrypt_cex4.o
 # pkey kernel module
 pkey-objs := pkey_api.o
 obj-$(CONFIG_PKEY) += pkey.o
+
+# adjunct processor matrix
+vfio_ap-objs := vfio_ap_drv.o
+obj-$(CONFIG_VFIO_AP) += vfio_ap.o
diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
new file mode 100644
index 0000000..5069580
--- /dev/null
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * VFIO based AP device driver
+ *
+ * Copyright IBM Corp. 2018
+ *
+ * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
+ */
+
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include "vfio_ap_private.h"
+
+#define VFIO_AP_ROOT_NAME "vfio_ap"
+#define VFIO_AP_DEV_TYPE_NAME "ap_matrix"
+#define VFIO_AP_DEV_NAME "matrix"
+
+MODULE_AUTHOR("IBM Corporation");
+MODULE_DESCRIPTION("VFIO AP device driver, Copyright IBM Corp. 2018");
+MODULE_LICENSE("GPL v2");
+
+static struct ap_driver vfio_ap_drv;
+
+static struct device_type vfio_ap_dev_type = {
+	.name = VFIO_AP_DEV_TYPE_NAME,
+};
+
+struct ap_matrix_dev matrix_dev;
+
+/* Only type 10 adapters (CEX4 and later) are supported
+ * by the AP matrix device driver
+ */
+static struct ap_device_id ap_queue_ids[] = {
+	{ .dev_type = AP_DEVICE_TYPE_CEX4,
+	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
+	{ .dev_type = AP_DEVICE_TYPE_CEX5,
+	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
+	{ .dev_type = AP_DEVICE_TYPE_CEX6,
+	  .match_flags = AP_DEVICE_ID_MATCH_QUEUE_TYPE },
+	{ /* end of sibling */ },
+};
+
+MODULE_DEVICE_TABLE(vfio_ap, ap_queue_ids);
+
+static int vfio_ap_queue_dev_probe(struct ap_device *apdev)
+{
+	return 0;
+}
+
+static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
+{
+	/* Nothing to do yet */
+}
+
+static int vfio_ap_matrix_dev_init(void)
+{
+	int ret;
+	struct device *root_device;
+
+	root_device = root_device_register(VFIO_AP_ROOT_NAME);
+	if (IS_ERR(root_device)) {
+		ret = PTR_ERR(root_device);
+		return ret;
+	}
+
+	matrix_dev.device.type = &vfio_ap_dev_type;
+	dev_set_name(&matrix_dev.device, "%s", VFIO_AP_DEV_NAME);
+	matrix_dev.device.type = &vfio_ap_dev_type;
+	matrix_dev.device.parent = root_device;
+	matrix_dev.device.driver = &vfio_ap_drv.driver;
+
+	ret = device_register(&matrix_dev.device);
+	if (ret) {
+		root_device_unregister(root_device);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void vfio_ap_matrix_dev_destroy(void)
+{
+	device_unregister(&matrix_dev.device);
+	root_device_unregister(matrix_dev.device.parent);
+}
+
+int __init vfio_ap_init(void)
+{
+	int ret;
+
+	ret = vfio_ap_matrix_dev_init();
+	if (ret)
+		return ret;
+
+	memset(&vfio_ap_drv, 0, sizeof(vfio_ap_drv));
+	vfio_ap_drv.probe = vfio_ap_queue_dev_probe;
+	vfio_ap_drv.remove = vfio_ap_queue_dev_remove;
+	vfio_ap_drv.ids = ap_queue_ids;
+
+	ret = ap_driver_register(&vfio_ap_drv, THIS_MODULE, VFIO_AP_DRV_NAME);
+	if (ret) {
+		vfio_ap_matrix_dev_destroy();
+		return ret;
+	}
+
+	return 0;
+}
+
+void __exit vfio_ap_exit(void)
+{
+	ap_driver_unregister(&vfio_ap_drv);
+	vfio_ap_matrix_dev_destroy();
+}
+
+module_init(vfio_ap_init);
+module_exit(vfio_ap_exit);
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
new file mode 100644
index 0000000..30c3e33
--- /dev/null
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Private data and functions for adjunct processor VFIO matrix driver.
+ *
+ * Author(s): Tony Krowiak <akrowiak@linux.ibm.com>
+ *
+ * Copyright IBM Corp. 2018
+ */
+
+#ifndef _VFIO_AP_PRIVATE_H_
+#define _VFIO_AP_PRIVATE_H_
+
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/mdev.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
+
+#include "ap_bus.h"
+
+#define VFIO_AP_MODULE_NAME "vfio_ap"
+#define VFIO_AP_DRV_NAME "vfio_ap"
+
+struct ap_matrix_dev {
+	struct device device;
+};
+
+extern struct ap_matrix_dev matrix_dev;
+
+#endif /* _VFIO_AP_PRIVATE_H_ */
-- 
1.7.1

