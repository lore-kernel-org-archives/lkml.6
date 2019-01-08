Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5D8C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF69C218AD
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 08:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="NnSIYE0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfAHIKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 03:10:52 -0500
Received: from mail-eopbgr150101.outbound.protection.outlook.com ([40.107.15.101]:29204
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727958AbfAHIKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 03:10:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGpd4gC/cRD1ZfB+4Bl31Q02MtY1jHQCLu8mF2QFs6U=;
 b=NnSIYE0k+ISTKvmsM1eNiSpkZ73Jlu6HoyZeN/3ZzVsECDEov6d9ODrlbMH+BdEkNzUzhqJnby0qhxTCFC8LjpHmYuz6qS94waR+DiMpmlF5l7lyBVf2BaIr3QjFM6Y7nX85lzuaY1A/vLs4UFZI4zZILHbCVHJGleuwd49t24s=
Received: from AM6PR0702MB3799.eurprd07.prod.outlook.com (52.133.24.160) by
 AM6PR0702MB3736.eurprd07.prod.outlook.com (52.133.25.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.3; Tue, 8 Jan 2019 08:10:45 +0000
Received: from AM6PR0702MB3799.eurprd07.prod.outlook.com
 ([fe80::356d:ce77:fa30:c04b]) by AM6PR0702MB3799.eurprd07.prod.outlook.com
 ([fe80::356d:ce77:fa30:c04b%5]) with mapi id 15.20.1516.010; Tue, 8 Jan 2019
 08:10:45 +0000
From:   "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] EDAC: add ARM Cortex A15 L2 internal asynchronous error
 detection driver
Thread-Topic: [PATCH 2/2] EDAC: add ARM Cortex A15 L2 internal asynchronous
 error detection driver
Thread-Index: AdSCPskxr2Sna9MEQ4KkOAtgpIpvmg==
Date:   Tue, 8 Jan 2019 08:10:45 +0000
Message-ID: <AM6PR0702MB379953E130CC1E1DEE18B79BFA8A0@AM6PR0702MB3799.eurprd07.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.189]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0702MB3736;6:gCF6e1IKSUV12M78veIetZKRKNYHmucBL792E/ruVO9et4An72UsRKoQ6jL/BzEANbyCXOycPZAWbwsDPz/AZL8Pnhbieax+xD2C7+iUf8C5R0bOQ2S/nVF8qsVNtZk/lHXtQj6PbDbqsB8VYXFnCzSyDFxeKlw2JwChZfidSKqX2ILgSg/JQLBWC5C8j74avKk4wUyu4At3EY1YMR4JRjnzpYbxA7lKS9bnss9E0nFlOsn8c83RRjf597TFea4/UrKZHjmkkEXUDcN0Bu7n59FStddteZewdKhuXLFeB166l89vTkULFuX2cZSDQzXdi1KYK8Vyn5DgI1jYZ2ha7XNE09ewOwW8bG5kkb5y1+TkTOWG/S1zSEVv9mkEDULdhhtkZUD0EWWx798ok4ETlNXzSNsO5HRI3R4FfvbGpzWGgQvrL4+Vg1hEwFCsd1LcyuoffSrGXidRYi+Hke8Peg==;5:1oQ6Q62BEn/UjxPy1BuLDoAiu5Vbql+kz98QMJe87Yq0UOktl2N73gImNlUZEQx8eFF1Sfl13gRw8CA/NMOI+wppnmDNMkZUZ6JvfbkZzAMBVcSZR6c/9ZmlPOdppRGj8j6RbFrp2HP5F3019MeBJL5xZqMJ2y0j5alQHNo9lxZITbqJejXMnUrRvB74TdSB+LWsc/k9MydULJCwxS1O6Q==;7:fnXaHfCb57DlhWYprbNNwST6g7TpZHY2E3AhCcbbI3eVTiYphai08iAMPa3hPDCPNqfPfGJg++pt6j+CTP7MxixjLGIFAfaGect6+cTEinukHZEdrixJ489OzHaw1h2NccKZZ6jBb/X0JuCUvXui5Q==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39860400002)(366004)(376002)(136003)(396003)(346002)(189003)(199004)(99286004)(97736004)(6306002)(9686003)(86362001)(5660300001)(2201001)(7416002)(71200400001)(71190400001)(316002)(74316002)(68736007)(8936002)(55016002)(8676002)(110136005)(81166006)(53936002)(186003)(26005)(6346003)(54906003)(6506007)(3846002)(102836004)(6116002)(81156014)(478600001)(476003)(6636002)(6436002)(7696005)(14454004)(66066001)(33656002)(305945005)(25786009)(2906002)(14444005)(4326008)(256004)(106356001)(105586002)(486006)(2501003)(7736002)(2004002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR0702MB3736;H:AM6PR0702MB3799.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 9fa6b7cc-89dc-45c1-e7c2-08d67540ca69
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7193020);SRVR:AM6PR0702MB3736;
x-ms-traffictypediagnostic: AM6PR0702MB3736:
x-microsoft-antispam-prvs: <AM6PR0702MB37364306372869A7CCFAC81BFA8A0@AM6PR0702MB3736.eurprd07.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(11241501185)(806100)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0702MB3736;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0702MB3736;
x-forefront-prvs: 0911D5CE78
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wladislav.wiebe@nokia.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9Df4QI4TGKl0m8QyCU3ig0OlcZ8fEOQJN/lcJ5Aj+qJ1ItJYmDl/yVC2GmfxJcQsLhfQ9WRGp1V1BeebtXz2KPdonYOXjg6YtzVWpDDVgZmm6B+S49iJ1YqlTo+Z4KcCqO7qIgIuGB57Bl8jm7W7SiDw8MDqExjImhB+XPGzxCTsllPyVP+ieySIUCvlv/+nBn+HjjZwAoGkL1rWhbqhvZXfIf3raQ+y0u8CCFc3Mq8VzxODEZ2eDyLNmbhFgEBy6Ls4AxtSI5Ut1vBWmtteE4r8r7/t307/pvlf3rsA0LDFc359eD7oZnKtey7tMFWk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa6b7cc-89dc-45c1-e7c2-08d67540ca69
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 08:10:45.2577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0702MB3736
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver adds support for L2 internal asynchronous error detection
caused by L2 RAM double-bit ECC error or illegal writes to the
Interrupt Controller memory-map region on the Cortex A15.

Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>
---
 MAINTAINERS                             |   1 +
 drivers/edac/Kconfig                    |  11 +++
 drivers/edac/Makefile                   |   1 +
 drivers/edac/cortex_a15_l2_async_edac.c | 134 ++++++++++++++++++++++++++++=
++++
 4 files changed, 147 insertions(+)
 create mode 100644 drivers/edac/cortex_a15_l2_async_edac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0796ad6e6490..84dc501b2582 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1100,6 +1100,7 @@ L:	linux-edac@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/edac/cortex_a15_l2_async_edac.txt
+F:	drivers/edac/cortex_a15_l2_async_edac.c
=20
 ARM INTEGRATOR, VERSATILE AND REALVIEW SUPPORT
 M:	Linus Walleij <linus.walleij@linaro.org>
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 41c9ccdd20d6..8722203948e0 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -475,4 +475,15 @@ config EDAC_QCOM
 	  For debugging issues having to do with stability and overall system
 	  health, you should probably say 'Y' here.
=20
+config EDAC_CORTEX_A15_L2_ASYNC
+	tristate "Cortex A15 ASYNC L2 & illegal GIC write error detection"
+	depends on ARM
+	help
+	  Support for L2 internal asynchronous error detection caused by L2 RAM
+	  double-bit ECC error or illegal writes to the Interrupt Controller
+	  memory-map region on the Cortex A15.
+
+	  This driver works in interrupt mode triggered by the nINTERRIRQ and
+	  reports only uncorrectable errors.
+
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 716096d08ea0..12d15cf5ff4e 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -78,3 +78,4 @@ obj-$(CONFIG_EDAC_SYNOPSYS)		+=3D synopsys_edac.o
 obj-$(CONFIG_EDAC_XGENE)		+=3D xgene_edac.o
 obj-$(CONFIG_EDAC_TI)			+=3D ti_edac.o
 obj-$(CONFIG_EDAC_QCOM)			+=3D qcom_edac.o
+obj-$(CONFIG_EDAC_CORTEX_A15_L2_ASYNC)	+=3D cortex_a15_l2_async_edac.o
diff --git a/drivers/edac/cortex_a15_l2_async_edac.c b/drivers/edac/cortex_=
a15_l2_async_edac.c
new file mode 100644
index 000000000000..26252568e961
--- /dev/null
+++ b/drivers/edac/cortex_a15_l2_async_edac.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Nokia Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along=
 with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+
+#include "edac_module.h"
+
+#define DRIVER_NAME "cortex_a15_l2_async_edac"
+
+#define L2ECTLR_L2_ASYNC_ERR BIT(30)
+
+static irqreturn_t cortex_a15_l2_async_edac_err_handler(int irq, void *dev=
_id)
+{
+	struct edac_device_ctl_info *dci =3D dev_id;
+	u32 status =3D 0;
+
+	/*
+	 * Read and clear L2ECTLR L2 ASYNC error bit caused by INTERRIRQ.
+	 * Reason could be a L2 RAM double-bit ECC error or illegal writes
+	 * to the Interrupt Controller memory-map region.
+	 */
+	asm("mrc p15, 1, %0, c9, c0, 3" : "=3Dr" (status));
+	if (status & L2ECTLR_L2_ASYNC_ERR) {
+		status &=3D ~L2ECTLR_L2_ASYNC_ERR;
+		asm("mcr p15, 1, %0, c9, c0, 3" : : "r" (status));
+		edac_printk(KERN_EMERG, DRIVER_NAME,
+			    "L2 internal asynchronous error occurred!\n");
+		edac_device_handle_ue(dci, 0, 0, dci->ctl_name);
+
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int cortex_a15_l2_async_edac_probe(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *dci;
+	struct device_node *np =3D pdev->dev.of_node;
+	char *ctl_name =3D (char *)np->name;
+	int i =3D 0, ret =3D 0, err_irq =3D 0, irq_count =3D 0;
+
+	/* We can have multiple CPU clusters with one INTERRIRQ per cluster */
+	irq_count =3D platform_irq_count(pdev);
+	if (irq_count < 0) {
+		edac_printk(KERN_ERR, DRIVER_NAME,
+			    "No L2 ASYNC error IRQ found!\n");
+		return -EINVAL;
+	}
+
+	dci =3D edac_device_alloc_ctl_info(0, ctl_name, 1, ctl_name,
+					 irq_count, 0, NULL, 0,
+					 edac_device_alloc_index());
+	if (!dci)
+		return -ENOMEM;
+
+	dci->dev =3D &pdev->dev;
+	dci->mod_name =3D DRIVER_NAME;
+	dci->ctl_name =3D ctl_name;
+	dci->dev_name =3D dev_name(&pdev->dev);
+	platform_set_drvdata(pdev, dci);
+
+	if (edac_device_add_device(dci))
+		goto err;
+
+	for (i =3D 0; i < irq_count; i++) {
+		err_irq =3D platform_get_irq(pdev, i);
+		ret =3D devm_request_irq(&pdev->dev, err_irq,
+				       cortex_a15_l2_async_edac_err_handler, 0,
+				       dev_name(&pdev->dev), dci);
+
+		if (ret < 0) {
+			edac_printk(KERN_ERR, DRIVER_NAME,
+				    "Failed to register L2 ASYNC error IRQ %d\n",
+				     err_irq);
+			goto err2;
+		}
+	}
+
+	return 0;
+err2:
+	edac_device_del_device(&pdev->dev);
+err:
+	edac_device_free_ctl_info(dci);
+
+	return ret;
+}
+
+static int cortex_a15_l2_async_edac_remove(struct platform_device *pdev)
+{
+	struct edac_device_ctl_info *dci =3D platform_get_drvdata(pdev);
+
+	edac_device_del_device(&pdev->dev);
+	edac_device_free_ctl_info(dci);
+
+	return 0;
+}
+
+static const struct of_device_id cortex_a15_l2_async_edac_of_match[] =3D {
+	{ .compatible =3D "arm,cortex-a15-l2-async-edac", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cortex_a15_l2_async_edac_of_match);
+
+static struct platform_driver cortex_a15_l2_async_edac_driver =3D {
+	.probe =3D cortex_a15_l2_async_edac_probe,
+	.remove =3D cortex_a15_l2_async_edac_remove,
+	.driver =3D {
+		.name =3D DRIVER_NAME,
+		.of_match_table =3D cortex_a15_l2_async_edac_of_match,
+	},
+};
+module_platform_driver(cortex_a15_l2_async_edac_driver);
+
+MODULE_AUTHOR("Wladislav Wiebe <wladislav.wiebe@nokia.com>");
+MODULE_DESCRIPTION("ARM Cortex A15 L2 internal asynchronous error detectio=
n");
+MODULE_LICENSE("GPL v2");
--=20
2.16.1
