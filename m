Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E586AC65BA7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87874208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 16:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cwp+tyEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87874208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbeJEXqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 19:46:35 -0400
Received: from mail-he1eur01on0057.outbound.protection.outlook.com ([104.47.0.57]:37568
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728341AbeJEXqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 19:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3LJkaKyKi+2Xz/Z+dIrMWMDUtMWQ2c3ZQXSgw3SI2Y=;
 b=Cwp+tyEQJ6jdVAPX3r9SGXPrSbQyAaPyYMpn1Utl0j+LzI1rndFsVLEuInHQP+im0mW5GtsBjbkfmwNpt9y+B4ufhob0y4Mn3sIKq0SYr1JNKpkJcmt7ySYXm3UcOpD6HbPJrrGUrJpWpPj4rnGB14M6J/t6IRQ91EmUaAheUj8=
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com (10.165.45.135) by
 AM4PR0401MB1940.eurprd04.prod.outlook.com (10.166.130.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.21; Fri, 5 Oct 2018 16:46:54 +0000
Received: from AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::b18e:798b:a9c9:bc72]) by AM4PR0401MB2354.eurprd04.prod.outlook.com
 ([fe80::b18e:798b:a9c9:bc72%7]) with mapi id 15.20.1207.018; Fri, 5 Oct 2018
 16:46:54 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev-owner@vger.kernel.org" <netdev-owner@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "andrew@lunn.ch" <andrew@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 2/4] bus: fsl-mc: add fsl-mc userspace support
Thread-Topic: [PATCH 2/4] bus: fsl-mc: add fsl-mc userspace support
Thread-Index: AQHUXMsFbR2jX4lHJE+dzMaMy5YSlw==
Date:   Fri, 5 Oct 2018 16:46:54 +0000
Message-ID: <b1b4c641b9dfa994ae77d8243ea78625f35656f5.1538757337.git.ioana.ciornei@nxp.com>
References: <cover.1538757337.git.ioana.ciornei@nxp.com>
In-Reply-To: <cover.1538757337.git.ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0049.eurprd09.prod.outlook.com
 (2603:10a6:802:28::17) To AM4PR0401MB2354.eurprd04.prod.outlook.com
 (2603:10a6:200:51::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ioana.ciornei@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM4PR0401MB1940;6:38JCA2rl2RX0ZjH7wiz0mnAhxzq1i+qeYZW7cHjdUeeypKZ3/VOvvEzPovwvfvoCfocbg2lR4vg2v9qjJJxKIB/mRoik6S9K+FxIwVs6MgJtRdwoVm1RPGUgw21oCwyJiUAZDWbpInLtqEufwssPWnHE1TmLSBVa3nWhRvvBchIyeIEgkcn6iuoKGpZyoASRWMDQbr28ZLWImQjJcwB0TZpz71SyfO4AMHAfb7ot6+jZ4wNMropimW+ftBE/GbjN+VLsub51aN3ZpxYeSWV5ubtOjd7E+iLOHjFslgEoMkLXqV4KoyvR1Ecd44OVTiBGrR4lDMm32lzUeiuqamgwbzvx9BBaPsTTx06gb4C2PynARmInjmbLjhB0uZWcP3TLf86KIJcVrvnFfyPGU7VASCebwigXRQQuf5xFyHfpT3+v1K4/H4QEYL9770QwUKeyyF5WBaw+roU26hwyN5FKSQ==;5:26pgGnxL+bVON3pbGqSCfclBBk0Ao5/U21N6GJ2xaEnY3CzdpKxWDMG7VbbzIhH8jrtOXpJz8/IfwOgR/FhHQOXoZszDKZG6SFSrPLmUiIOY4nIFKsX5wFxXRApQICrI8d98eyaTyQQjvtDI26cybt8cVb2HaxGdntd1CiOmHiw=;7:qo+qep+ROCksznEbYlltxz0eGEQ8tN02nRCkRd4k+iEXIdmBo2cZKxNZX/a32DqWG22+S36tPtDP5mBPq60sbTwesKBnDSADTo9M4SAIMjSXLGHGTlwiYUAh1qfNr6ulEbGiFJwrL2QkxpuGpViGh7i694FoRUg6ZB4qV7hDGbuTgPvjrzhTYOROnWGpbXgOzmJ9tJQoNnh0PfO/fg2wOeOD/2l1SlLmDOfATiGN3WxX56ffeB/zup+dwbigFWpK
x-ms-office365-filtering-correlation-id: c59a913b-c57a-4354-1124-08d62ae227ed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB1940;
x-ms-traffictypediagnostic: AM4PR0401MB1940:
x-microsoft-antispam-prvs: <AM4PR0401MB194095585B2E89355579D232E0EB0@AM4PR0401MB1940.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(278428928389397)(35073007944872)(275809806118684)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:AM4PR0401MB1940;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB1940;
x-forefront-prvs: 0816F1D86E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(575784001)(97736004)(316002)(6512007)(68736007)(53936002)(81166006)(11346002)(86362001)(8676002)(186003)(446003)(476003)(486006)(2616005)(44832011)(102836004)(5250100002)(8936002)(6436002)(81156014)(26005)(7736002)(305945005)(256004)(14444005)(6486002)(2900100001)(2501003)(105586002)(106356001)(52116002)(6506007)(2906002)(99286004)(76176011)(71200400001)(71190400001)(4744004)(54906003)(110136005)(14454004)(6116002)(3846002)(386003)(4326008)(25786009)(5660300001)(66066001)(118296001)(6636002)(36756003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB1940;H:AM4PR0401MB2354.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gm7cZv+BWORH0KuWnZeV/Fxv4O568uEG4Ow3MG4PWa6JMASdTL05JRcpAkqZ2uhzmIqmd0K4vEtkLAYrQHuyC9A4DlC4NQZ/Zku6SoL1Mqy1I6FiTHV+05dIMo36NWWzmgXkg/ra41rdu2uiFRzOj7aJbsS3YggA5V2zfhHEs3SZbdVaMQBwwtRNwn/U5aobypKrsyuTcKIMc09KZaFE7T3gFjz4aqoIh0ummdNrS+roP2l3dkxFdbA5jmv18z/3Oi3ZStX+lkn/pShxc0G0cTZJ5fHGPhGHzYRs8eYZsmzaeI4Csjv7PPD6YHKbEHCeu8UWLXggMvnSM+WzY9ofFSePZDStF2AzwWLgq8Edr54=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c59a913b-c57a-4354-1124-08d62ae227ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2018 16:46:54.3764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB1940
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
 Documentation/ioctl/ioctl-number.txt |   1 +
 drivers/bus/fsl-mc/Kconfig           |   7 ++
 drivers/bus/fsl-mc/Makefile          |   3 +
 drivers/bus/fsl-mc/fsl-mc-bus.c      |  12 +++
 drivers/bus/fsl-mc/fsl-mc-private.h  |  41 ++++++++
 drivers/bus/fsl-mc/fsl-mc-uapi.c     | 175 +++++++++++++++++++++++++++++++=
++++
 include/uapi/linux/fsl_mc.h          |   9 ++
 7 files changed, 248 insertions(+)
 create mode 100644 drivers/bus/fsl-mc/fsl-mc-uapi.c

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioc=
tl-number.txt
index 13a7c99..b29a213 100644
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
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bu=
s.c
index 5d8266c..5f862f1 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -792,6 +792,7 @@ static int fsl_mc_bus_probe(struct platform_device *pde=
v)
 	struct fsl_mc *mc;
 	struct fsl_mc_device *mc_bus_dev =3D NULL;
 	struct fsl_mc_io *mc_io =3D NULL;
+	struct fsl_mc_bus *mc_bus =3D NULL;
 	int container_id;
 	phys_addr_t mc_portal_phys_addr;
 	u32 mc_portal_size;
@@ -863,9 +864,18 @@ static int fsl_mc_bus_probe(struct platform_device *pd=
ev)
 	if (error < 0)
 		goto error_cleanup_mc_io;
=20
+	mc_bus =3D to_fsl_mc_bus(mc_bus_dev);
+	error =3D fsl_mc_uapi_create_device_file(mc_bus);
+	if (error < 0)
+		goto error_cleanup_device;
+
 	mc->root_mc_bus_dev =3D mc_bus_dev;
+
 	return 0;
=20
+error_cleanup_device:
+	fsl_mc_device_remove(mc_bus_dev);
+
 error_cleanup_mc_io:
 	fsl_destroy_mc_io(mc_io);
 	return error;
@@ -878,10 +888,12 @@ static int fsl_mc_bus_probe(struct platform_device *p=
dev)
 static int fsl_mc_bus_remove(struct platform_device *pdev)
 {
 	struct fsl_mc *mc =3D platform_get_drvdata(pdev);
+	struct fsl_mc_bus *mc_bus =3D to_fsl_mc_bus(mc->root_mc_bus_dev);
=20
 	if (!fsl_mc_is_root_dprc(&mc->root_mc_bus_dev->dev))
 		return -EINVAL;
=20
+	fsl_mc_uapi_remove_device_file(mc_bus);
 	fsl_mc_device_remove(mc->root_mc_bus_dev);
=20
 	fsl_destroy_mc_io(mc->root_mc_bus_dev->mc_io);
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
index 0000000..388e646
--- /dev/null
+++ b/drivers/bus/fsl-mc/fsl-mc-uapi.c
@@ -0,0 +1,175 @@
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
+	struct fsl_mc_uapi *mc_uapi;
+	struct fsl_mc_bus *mc_bus;
+	struct fsl_mc_io *dynamic_mc_io;
+	int error;
+
+	mc_uapi =3D container_of(filep->private_data, struct fsl_mc_uapi, misc);
+	mc_bus =3D container_of(mc_uapi, struct fsl_mc_bus, uapi_misc);
+	root_mc_device =3D &mc_bus->mc_dev;
+
+	mutex_lock(&mc_uapi->mutex);
+
+	if (!mc_uapi->local_instance_in_use) {
+		filep->private_data =3D mc_uapi->static_mc_io;
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
+		filep->private_data =3D dynamic_mc_io;
+	}
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
+	struct fsl_mc_device *root_mc_device;
+	struct fsl_mc_uapi *mc_uapi;
+	struct fsl_mc_bus *mc_bus;
+	struct fsl_mc_io *mc_io;
+
+	mc_io =3D filep->private_data;
+	root_mc_device =3D container_of(mc_io->dev, struct fsl_mc_device, dev);
+	mc_bus =3D to_fsl_mc_bus(root_mc_device);
+	mc_uapi =3D &mc_bus->uapi_misc;
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
+	filep->private_data =3D  NULL;
+	mutex_unlock(&mc_uapi->mutex);
+
+	return 0;
+}
+
+static long fsl_mc_uapi_dev_ioctl(struct file *file,
+				  unsigned int cmd,
+				  unsigned long arg)
+{
+	int error;
+
+	switch (cmd) {
+	case FSL_MC_SEND_MC_COMMAND:
+		error =3D fsl_mc_uapi_send_command(arg, file->private_data);
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
+	error =3D fsl_mc_portal_allocate(mc_dev, 0, &mc_uapi->static_mc_io);
+	if (error) {
+		pr_err("%s: cannot allocate MC portal\n", __func__);
+		goto error_alloc_static_io;
+	}
+
+	mutex_init(&mc_uapi->mutex);
+
+	return 0;
+
+error_alloc_static_io:
+	misc_deregister(&mc_uapi->misc);
+
+	return error;
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

