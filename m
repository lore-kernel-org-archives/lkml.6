Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEEDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C46B20869
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bSKYU7N7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C46B20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390188AbeKQEJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:09:29 -0500
Received: from mail-eopbgr20082.outbound.protection.outlook.com ([40.107.2.82]:27157
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727490AbeKQEJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:09:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzEvP9grU0l2rhRASsCrEwXXCryL9Bu226Joe1VIepg=;
 b=bSKYU7N7gtwzxcEDCyBQFMrUDs9jeu9PAN2sfC5OGmLkiwB0P/0dCyb+W8HXVJh3ZT9y4STGij1eoKA/9w7yRDIVCQYRQFsMxu/uCMVylG38UIMOeBp4MsjJDw+1qU1QTRVPg8yPT3Sx+DMKwc7RyELE2qXewLjEesvnqD3tASU=
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com (10.172.255.18) by
 VI1PR0402MB3712.eurprd04.prod.outlook.com (52.134.15.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.20; Fri, 16 Nov 2018 17:55:41 +0000
Received: from VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9]) by VI1PR0402MB2800.eurprd04.prod.outlook.com
 ([fe80::78a4:e54f:f26:36d9%7]) with mapi id 15.20.1294.045; Fri, 16 Nov 2018
 17:55:41 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev-owner@vger.kernel.org" <netdev-owner@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Leo Li <leoyang.li@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 2/4] bus: fsl-mc: add fsl-mc userspace support
Thread-Topic: [PATCH v2 2/4] bus: fsl-mc: add fsl-mc userspace support
Thread-Index: AQHUfdWWsu9NfPdpDEipLgPtUDhagA==
Date:   Fri, 16 Nov 2018 17:55:41 +0000
Message-ID: <1542390890-3270-3-git-send-email-ioana.ciornei@nxp.com>
References: <1542390890-3270-1-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1542390890-3270-1-git-send-email-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR10CA0120.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::49) To VI1PR0402MB2800.eurprd04.prod.outlook.com
 (2603:10a6:800:ad::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR0402MB3712;6:okeeCzOYf2iVy6dyCmFr5lN8QBJjl4refA3ivhNnSWSEXBzkpmQasccTViNC1REViUwl7jHiWcY2rdbiKdN4V4H//ML5kUHYcTG/fElN1Iapm17SOyKjrjErjxgjLRTgsy3f3+Eq2j2WRuz08JaFIY1lQHVmJmcwardcGcvLM3rCRQKbW95Jogb8jlePu/NzWM6H9aiskq65CYppbFnrTnWa+XGYPY5eNltjtHKJy4VCrkeR2TROlek9T/daAbYlD9MBgspWi7zJWixuMO84rLmI6UQ6CAVVpIfAPJlfYGaIUQdPXnrjvq7RKgHMvt0VzOhikPycuhKKpdJdyU1CI0QKfkqUTCa9zcVAyVLFYDkgghJwdFVsJ5eCJQjI28kW3fyskJZV24FUOvL2IKpBv1WVRc3igq6A5/pVAIm/i24AaRUMJp2Hddoz0qG6o63w3HPjzQpYqjeY2twTHRAfZg==;5:79j39AFubwcNGkQ+P7UNef0sEeloiUpiVgtdk2JdxL1glwd64Cira+pmntRp61PxHDo9eKN1f7ivt6RnDsT89/xsbDfJBx+m0X8U40eAuxsll5KgYVqtPY/ETyScJiKOy0XtNgfBvsDMiibjCNdJGT8t7nrtnklMUXcYIb3L9ik=;7:p2EHYruLKRelY3aFcCPausbMcI4PcEkEe7DNZNId8Ww0dtWlaYQXYx5nYYF2G3dOlSSKauhfphcq4k/pxwWEIXP7buW8Zr10eMELxDZgflanEJMJVtv8jzYzzIZrzzUiAxoy5E3+mqPDvBscbsKRRg==
x-ms-office365-filtering-correlation-id: bb66983f-05ba-4505-740a-08d64becb91b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(4534185)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3712;
x-ms-traffictypediagnostic: VI1PR0402MB3712:
x-microsoft-antispam-prvs: <VI1PR0402MB371290F572465E8B80DDA996E0DD0@VI1PR0402MB3712.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231415)(944501410)(52105112)(10201501046)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:VI1PR0402MB3712;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0402MB3712;
x-forefront-prvs: 0858FF8026
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(396003)(136003)(199004)(189003)(6486002)(71190400001)(71200400001)(25786009)(14454004)(6436002)(44832011)(6512007)(36756003)(2616005)(105586002)(99286004)(4744004)(2906002)(68736007)(14444005)(106356001)(478600001)(256004)(575784001)(86362001)(3846002)(54906003)(2501003)(8936002)(316002)(102836004)(26005)(5660300001)(52116002)(6116002)(386003)(97736004)(110136005)(6506007)(76176011)(305945005)(8676002)(6636002)(7736002)(81166006)(4326008)(81156014)(53936002)(2900100001)(476003)(11346002)(486006)(186003)(66066001)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3712;H:VI1PR0402MB2800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5VK7i6hLI7Tuu7Rvrbi4OmozfuMKG1PkeVLseaYpT2Vz7vt3YkGjnP+u0XWx0ItYPOcV8Orj/MwNrz7bSokRjbSSm8prBAWjvsgpzsaVo0o/gCmB8/BeSFVX0Csx1wut0F4r1yEVB8X4QhNlXM1+Y0PKxkPQxKjX2eAowh04Vf3JJH4RmNmWp+vnFj3s9RLm0lmw8SQFgn8mIh9ZUPPVY7ZNw5ZPkufEecaGYelJWTJhZQex2/rWYpqJ0nIYaJQUUyysB7lELcGo80IFRAjNkpM5e4nSrhcLKI2GUvnR93GqcI4GeGwfjHNtcc4SCnnTc9neSqIK4EsjvA49w+POZMIKOJ9oEIv3yK0S+OVQH3E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb66983f-05ba-4505-740a-08d64becb91b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2018 17:55:41.3316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3712
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding userspace support for the MC (Management Complex) means exporting
an ioctl capable device file representing the root resource container.

This new functionality in the fsl-mc bus driver intends to provide
userspace applications an interface to interact with the MC firmware.

Commands that are composed in userspace are sent to the MC firmware
through the FSL_MC_SEND_MC_COMMAND ioctl.  By default the implicit MC
I/O portal is used for this operation, but if the implicit one is busy,
a dynamic portal is allocated and then freed upon execution.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
Changes in v2:
   - use root dprc MC portal by default
   - create the uapi misc device from the root dprc probe function

 Documentation/ioctl/ioctl-number.txt |   1 +
 drivers/bus/fsl-mc/Kconfig           |   7 ++
 drivers/bus/fsl-mc/Makefile          |   3 +
 drivers/bus/fsl-mc/dprc-driver.c     |  14 ++-
 drivers/bus/fsl-mc/fsl-mc-private.h  |  41 ++++++++
 drivers/bus/fsl-mc/fsl-mc-uapi.c     | 179 +++++++++++++++++++++++++++++++=
++++
 include/uapi/linux/fsl_mc.h          |   9 ++
 7 files changed, 253 insertions(+), 1 deletion(-)
 create mode 100644 drivers/bus/fsl-mc/fsl-mc-uapi.c

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioc=
tl-number.txt
index af6f6ba..eaae7bf 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -171,6 +171,7 @@ Code  Seq#(hex)	Include File		Comments
 'R'	00-1F	linux/random.h		conflict!
 'R'	01	linux/rfkill.h		conflict!
 'R'	C0-DF	net/bluetooth/rfcomm.h
+'R'	E0	uapi/linux/fsl_mc.h
 'S'	all	linux/cdrom.h		conflict!
 'S'	80-81	scsi/scsi_ioctl.h	conflict!
 'S'	82-FF	scsi/scsi.h		conflict!
diff --git a/drivers/bus/fsl-mc/Kconfig b/drivers/bus/fsl-mc/Kconfig
index c23c77c..cde6f40 100644
--- a/drivers/bus/fsl-mc/Kconfig
+++ b/drivers/bus/fsl-mc/Kconfig
@@ -14,3 +14,10 @@ config FSL_MC_BUS
 	  architecture.  The fsl-mc bus driver handles discovery of
 	  DPAA2 objects (which are represented as Linux devices) and
 	  binding objects to drivers.
+
+config FSL_MC_UAPI_SUPPORT
+	bool "Management Complex (MC) userspace support"
+	depends on FSL_MC_BUS
+	help
+	  Provides userspace support for creating/destroying/configuring
+	  DPAA2 objects in the Management Complex.
diff --git a/drivers/bus/fsl-mc/Makefile b/drivers/bus/fsl-mc/Makefile
index 3c518c7..4ae292a 100644
--- a/drivers/bus/fsl-mc/Makefile
+++ b/drivers/bus/fsl-mc/Makefile
@@ -16,3 +16,6 @@ mc-bus-driver-objs :=3D fsl-mc-bus.o \
 		      fsl-mc-allocator.o \
 		      fsl-mc-msi.o \
 		      dpmcp.o
+
+# MC userspace support
+obj-$(CONFIG_FSL_MC_UAPI_SUPPORT) +=3D fsl-mc-uapi.o
diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-dri=
ver.c
index 52c7e15..3919d9b 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -593,6 +593,7 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
 	struct fsl_mc_bus *mc_bus =3D to_fsl_mc_bus(mc_dev);
 	bool mc_io_created =3D false;
 	bool msi_domain_set =3D false;
+	bool uapi_created =3D false;
 	u16 major_ver, minor_ver;
=20
 	if (!is_fsl_mc_bus_dprc(mc_dev))
@@ -647,6 +648,11 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
 		} else {
 			dev_set_msi_domain(&mc_dev->dev, mc_msi_domain);
 			msi_domain_set =3D true;
+
+			error =3D fsl_mc_uapi_create_device_file(mc_bus);
+			if (error < 0)
+				goto error_cleanup_msi_domain;
+			uapi_created =3D true;
 		}
 	}
=20
@@ -654,7 +660,7 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
 			  &mc_dev->mc_handle);
 	if (error < 0) {
 		dev_err(&mc_dev->dev, "dprc_open() failed: %d\n", error);
-		goto error_cleanup_msi_domain;
+		goto error_cleanup_uapi;
 	}
=20
 	error =3D dprc_get_attributes(mc_dev->mc_io, 0, mc_dev->mc_handle,
@@ -706,6 +712,10 @@ static int dprc_probe(struct fsl_mc_device *mc_dev)
 error_cleanup_open:
 	(void)dprc_close(mc_dev->mc_io, 0, mc_dev->mc_handle);
=20
+error_cleanup_uapi:
+	if (uapi_created)
+		fsl_mc_uapi_remove_device_file(mc_bus);
+
 error_cleanup_msi_domain:
 	if (msi_domain_set)
 		dev_set_msi_domain(&mc_dev->dev, NULL);
@@ -774,6 +784,8 @@ static int dprc_remove(struct fsl_mc_device *mc_dev)
 	if (!fsl_mc_is_root_dprc(&mc_dev->dev)) {
 		fsl_destroy_mc_io(mc_dev->mc_io);
 		mc_dev->mc_io =3D NULL;
+	} else {
+		fsl_mc_uapi_remove_device_file(mc_bus);
 	}
=20
 	dev_info(&mc_dev->dev, "DPRC device unbound from driver");
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-m=
c-private.h
index ea11b4f..16902f9 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -10,6 +10,8 @@
=20
 #include <linux/fsl/mc.h>
 #include <linux/mutex.h>
+#include <linux/ioctl.h>
+#include <linux/miscdevice.h>
=20
 /*
  * Data Path Management Complex (DPMNG) General API
@@ -492,6 +494,24 @@ struct fsl_mc_resource_pool {
 };
=20
 /**
+ * struct fsl_mc_uapi - information associated with a device file
+ * @misc: struct miscdevice linked to the root dprc
+ * @device: newly created device in /dev
+ * @mutex: mutex lock to serialize the open/release operations
+ * @local_instance_in_use: local MC I/O instance in use or not
+ * @dynamic_instance_count: number of dynamically created MC I/O instances
+ * @static_mc_io: pointer to the static MC I/O object
+ */
+struct fsl_mc_uapi {
+	struct miscdevice misc;
+	struct device *device;
+	struct mutex mutex; /* serialize open/release operations */
+	u32 local_instance_in_use;
+	u32 dynamic_instance_count;
+	struct fsl_mc_io *static_mc_io;
+};
+
+/**
  * struct fsl_mc_bus - logical bus that corresponds to a physical DPRC
  * @mc_dev: fsl-mc device for the bus device itself.
  * @resource_pools: array of resource pools (one pool per resource type)
@@ -500,6 +520,7 @@ struct fsl_mc_resource_pool {
  * @irq_resources: Pointer to array of IRQ objects for the IRQ pool
  * @scan_mutex: Serializes bus scanning
  * @dprc_attr: DPRC attributes
+ * @uapi_misc: struct that abstracts the interaction with userspace
  */
 struct fsl_mc_bus {
 	struct fsl_mc_device mc_dev;
@@ -507,6 +528,7 @@ struct fsl_mc_bus {
 	struct fsl_mc_device_irq *irq_resources;
 	struct mutex scan_mutex;    /* serializes bus scanning */
 	struct dprc_attributes dprc_attr;
+	struct fsl_mc_uapi uapi_misc;
 };
=20
 #define to_fsl_mc_bus(_mc_dev) \
@@ -561,4 +583,23 @@ int __must_check fsl_create_mc_io(struct device *dev,
=20
 bool fsl_mc_is_root_dprc(struct device *dev);
=20
+#ifdef CONFIG_FSL_MC_UAPI_SUPPORT
+
+int fsl_mc_uapi_create_device_file(struct fsl_mc_bus *mc_bus);
+
+void fsl_mc_uapi_remove_device_file(struct fsl_mc_bus *mc_bus);
+
+#else
+
+static inline int fsl_mc_uapi_create_device_file(struct fsl_mc_bus *mc_bus=
)
+{
+	return 0;
+}
+
+static inline void fsl_mc_uapi_remove_device_file(struct fsl_mc_bus *mc_bu=
s)
+{
+}
+
+#endif
+
 #endif /* _FSL_MC_PRIVATE_H_ */
diff --git a/drivers/bus/fsl-mc/fsl-mc-uapi.c b/drivers/bus/fsl-mc/fsl-mc-u=
api.c
new file mode 100644
index 0000000..8c9debb
--- /dev/null
+++ b/drivers/bus/fsl-mc/fsl-mc-uapi.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Management Complex (MC) userspace support
+ *
+ * Copyright 2018 NXP
+ *
+ */
+
+#include <linux/slab.h>
+#include <linux/fs.h>
+#include <linux/uaccess.h>
+#include <linux/miscdevice.h>
+
+#include "fsl-mc-private.h"
+
+struct uapi_priv_data {
+	struct fsl_mc_uapi *uapi;
+	struct fsl_mc_io *mc_io;
+};
+
+static int fsl_mc_uapi_send_command(unsigned long arg,
+				    struct fsl_mc_io *mc_io)
+{
+	struct fsl_mc_command mc_cmd;
+	int error;
+
+	error =3D copy_from_user(&mc_cmd, (void __user *)arg, sizeof(mc_cmd));
+	if (error)
+		return -EFAULT;
+
+	error =3D mc_send_command(mc_io, &mc_cmd);
+	if (error)
+		return error;
+
+	error =3D copy_to_user((void __user *)arg, &mc_cmd, sizeof(mc_cmd));
+	if (error)
+		return -EFAULT;
+
+	return 0;
+}
+
+static int fsl_mc_uapi_dev_open(struct inode *inode, struct file *filep)
+{
+	struct fsl_mc_device *root_mc_device;
+	struct uapi_priv_data *priv_data;
+	struct fsl_mc_io *dynamic_mc_io;
+	struct fsl_mc_uapi *mc_uapi;
+	struct fsl_mc_bus *mc_bus;
+	int error;
+
+	priv_data =3D kzalloc(sizeof(*priv_data), GFP_KERNEL);
+	if (!priv_data)
+		return -ENOMEM;
+
+	mc_uapi =3D container_of(filep->private_data, struct fsl_mc_uapi, misc);
+	mc_bus =3D container_of(mc_uapi, struct fsl_mc_bus, uapi_misc);
+	root_mc_device =3D &mc_bus->mc_dev;
+
+	mutex_lock(&mc_uapi->mutex);
+
+	if (!mc_uapi->local_instance_in_use) {
+		priv_data->mc_io =3D mc_uapi->static_mc_io;
+		mc_uapi->local_instance_in_use =3D true;
+	} else {
+		error =3D fsl_mc_portal_allocate(root_mc_device, 0,
+					       &dynamic_mc_io);
+		if (error) {
+			pr_err("Could not allocate MC portal\n");
+			goto error_portal_allocate;
+		}
+
+		mc_uapi->dynamic_instance_count++;
+		priv_data->mc_io =3D dynamic_mc_io;
+	}
+	priv_data->uapi =3D mc_uapi;
+	filep->private_data =3D priv_data;
+
+	mutex_unlock(&mc_uapi->mutex);
+
+	return 0;
+
+error_portal_allocate:
+	mutex_unlock(&mc_uapi->mutex);
+
+	return error;
+}
+
+static int fsl_mc_uapi_dev_release(struct inode *inode, struct file *filep=
)
+{
+	struct uapi_priv_data *priv_data;
+	struct fsl_mc_uapi *mc_uapi;
+	struct fsl_mc_io *mc_io;
+
+	priv_data =3D filep->private_data;
+	mc_uapi =3D priv_data->uapi;
+	mc_io =3D priv_data->mc_io;
+
+	mutex_lock(&mc_uapi->mutex);
+
+	if (WARN_ON(!mc_uapi->local_instance_in_use &&
+		    mc_uapi->dynamic_instance_count =3D=3D 0)) {
+		mutex_unlock(&mc_uapi->mutex);
+		return -EINVAL;
+	}
+
+	if (mc_io =3D=3D mc_uapi->static_mc_io) {
+		mc_uapi->local_instance_in_use =3D false;
+	} else {
+		fsl_mc_portal_free(mc_io);
+		mc_uapi->dynamic_instance_count--;
+	}
+
+	kfree(filep->private_data);
+	filep->private_data =3D  NULL;
+
+	mutex_unlock(&mc_uapi->mutex);
+
+	return 0;
+}
+
+static long fsl_mc_uapi_dev_ioctl(struct file *file,
+				  unsigned int cmd,
+				  unsigned long arg)
+{
+	struct uapi_priv_data *priv_data =3D file->private_data;
+	int error;
+
+	switch (cmd) {
+	case FSL_MC_SEND_MC_COMMAND:
+		error =3D fsl_mc_uapi_send_command(arg, priv_data->mc_io);
+		break;
+	default:
+		pr_err("%s: unexpected ioctl call number\n", __func__);
+		error =3D -EINVAL;
+	}
+
+	return error;
+}
+
+static const struct file_operations fsl_mc_uapi_dev_fops =3D {
+	.owner =3D THIS_MODULE,
+	.open =3D fsl_mc_uapi_dev_open,
+	.release =3D fsl_mc_uapi_dev_release,
+	.unlocked_ioctl =3D fsl_mc_uapi_dev_ioctl,
+};
+
+int fsl_mc_uapi_create_device_file(struct fsl_mc_bus *mc_bus)
+{
+	struct fsl_mc_device *mc_dev =3D &mc_bus->mc_dev;
+	struct fsl_mc_uapi *mc_uapi =3D &mc_bus->uapi_misc;
+	int error;
+
+	mc_uapi->misc.minor =3D MISC_DYNAMIC_MINOR;
+	mc_uapi->misc.name =3D dev_name(&mc_dev->dev);
+	mc_uapi->misc.fops =3D &fsl_mc_uapi_dev_fops;
+
+	error =3D misc_register(&mc_uapi->misc);
+	if (error)
+		return -EPROBE_DEFER;
+
+	mc_uapi->static_mc_io =3D mc_bus->mc_dev.mc_io;
+
+	mutex_init(&mc_uapi->mutex);
+
+	return 0;
+}
+
+void fsl_mc_uapi_remove_device_file(struct fsl_mc_bus *mc_bus)
+{
+	struct fsl_mc_uapi *mc_uapi =3D &mc_bus->uapi_misc;
+
+	if (WARN_ON(mc_uapi->local_instance_in_use))
+		return;
+
+	if (WARN_ON(mc_uapi->dynamic_instance_count !=3D 0))
+		return;
+
+	misc_deregister(&mc_uapi->misc);
+}
diff --git a/include/uapi/linux/fsl_mc.h b/include/uapi/linux/fsl_mc.h
index 6c19cfc..4989c1b 100644
--- a/include/uapi/linux/fsl_mc.h
+++ b/include/uapi/linux/fsl_mc.h
@@ -16,10 +16,19 @@
  * struct fsl_mc_command - Management Complex (MC) command structure
  * @header: MC command header
  * @params: MC command parameters
+ *
+ * Used by FSL_MC_SEND_MC_COMMAND
  */
 struct fsl_mc_command {
 	__le64 header;
 	__le64 params[MC_CMD_NUM_OF_PARAMS];
 };
=20
+#define FSL_MC_SEND_CMD_IOCTL_TYPE	'R'
+#define FSL_MC_SEND_CMD_IOCTL_SEQ	0xE0
+
+#define FSL_MC_SEND_MC_COMMAND \
+	_IOWR(FSL_MC_SEND_CMD_IOCTL_TYPE, FSL_MC_SEND_CMD_IOCTL_SEQ, \
+	struct fsl_mc_command)
+
 #endif /* _UAPI_FSL_MC_H_ */
--=20
1.9.1

