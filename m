Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E3CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A4F20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fUxQeKqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfAQJK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:10:56 -0500
Received: from mail-eopbgr40085.outbound.protection.outlook.com ([40.107.4.85]:45177
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbfAQJK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:10:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDuJVbyFgpv3DviJ6gckzI5GGNDQ1uEcSXcOk/VpdnM=;
 b=fUxQeKqQi2U/P5Js/tsf4y7qnVUebWHEJJSikNpbYqkrMaXPJFl1+DTk0lhbyFUE/rs6pdBNnuqlnWbHtbxoJk9kqQTaJC7Y/XZIfrZxTgRkzrxwXTNNmdgrrAw64sZC6gF/vfSDthZKgubeAqpj5O251W2qUUYeOrZko/KeAHA=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2900.eurprd04.prod.outlook.com (10.175.42.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Thu, 17 Jan 2019 09:10:50 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626%2]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 09:10:50 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v2 1/3] usb: ehci: fsl: Update register accessing for
 arm/arm64 platforms
Thread-Topic: [PATCH v2 1/3] usb: ehci: fsl: Update register accessing for
 arm/arm64 platforms
Thread-Index: AQHUrkSK5gjXIA2AjUOFpVeBl/CheA==
Date:   Thu, 17 Jan 2019 09:10:50 +0000
Message-ID: <20190117091135.44209-1-ran.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0043.apcprd03.prod.outlook.com
 (2603:1096:203:2f::31) To AM5PR0402MB2865.eurprd04.prod.outlook.com
 (2603:10a6:203:99::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2900;6:3WRzUqQIwfHrPf2eNiVcUYCgg4c/sVYTC9axSMhvYVUtdIKAO7E3xECxGUl5jRli8/OGYwDCAoa8WYN/DeWk8f65BimiNMD/7/p6G1gLbEsiRU4f5+dqNlXlP+mw4CHZ3+LwDIvhnUVSrzTJdimWbAo/XWdCV/WIv90e8S7fWoWM1mTjHPyCr99x3TQekjQfmxukLHDLbVYt6QwoPeMpLSyZG4Ymqovtg26oxBEJ127DHf8P3AHK/6LXzEExCE9SRtNaf9CZ2Qq/P63cELlMWfDzsXlxNml9mpB+J1W75zQjd9g2aKBvZT1rePlEuXhNsLi5QUYl6dR+iNsrlMgL0LxaWCqzoqxjAaftYAgrysbv09hNHZyAZfTg8Gmz4tKqJWP0GD60NJSZT/WCYx3vfNro1KPzMNqYpBx5QhtEjn4adTOPwQpj5M6AY+T8z2Ad1e6rlPhy48WNOgmtb6n5RQ==;5:UnFwoNgd0ueB+7XFlWx0p2YYar6Kuv14TIISMxDHdIvGzjHBIUHou4BT1BdF+YPs+3AinwC6E9ZMz4ZMN+Ou6IB9dJikZA8hAryohVrDbnjb2WxaX2rgfd++mbLIu0v3BFooADx3QuXHxwE5rDPNRCj1avvOHlcrn4fT9w+VS7mrnc16DeS3Fi2JFogV6IVjeII5mwabAtbe7s4APzSD8g==;7:tOG9tGZ3sGkdDZ27p4rQe88VKaR4wgn5g4fJSpKwmP292hzLszIGhNM+Hk6J2wmzBwUFl4PlPuD9NtCuCdqWM+l+8ytSt8yoE5ahtRIfA9iB0oFkWa462BcJ+3U/zcVIV2dbOf0DMf1rnYeWvjGCzw==
x-ms-office365-filtering-correlation-id: 8702782d-a0be-4cef-b8a6-08d67c5bacb7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2900;
x-ms-traffictypediagnostic: AM5PR0402MB2900:
x-microsoft-antispam-prvs: <AM5PR0402MB2900A72B53C517E847F7CFAAF1830@AM5PR0402MB2900.eurprd04.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(136003)(396003)(376002)(189003)(199004)(102836004)(26005)(2616005)(476003)(2906002)(478600001)(14454004)(6506007)(386003)(71200400001)(71190400001)(1076003)(105586002)(6486002)(106356001)(186003)(52116002)(6436002)(86362001)(50226002)(110136005)(68736007)(66066001)(3846002)(6116002)(8936002)(256004)(81156014)(81166006)(8676002)(54906003)(305945005)(316002)(7736002)(5660300001)(97736004)(4326008)(2171002)(25786009)(99286004)(53936002)(6512007)(14444005)(36756003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2900;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N4WXopvRE1aLAZf0zs/Agwmn1OJPo3/k8QDdWrZlUq6I5Y8lUkrprid/DPyssY1jAzYLbZ+HzmwfSujdiLTPKbWJEXAnn9XuvCaXB0k+735ZDN0aFiDsvfG7KEmrYaqUXHh0HVa57e+mycQjDkpNz112dgrAFUsEwZud7DT5kgvRnQ1vRNlK6MA54RbHH6lIInb8Zfj+9ehmC6+OeLz0dLcw0TF6FMM2bypYfBKUhvY1Ow0HuC8Jpz6rXvFMyXRUC391lFX99xtCNhQ3cHU2qFB6hzSoPbH8GaHULX8Ii5WmEuC+nYT2B6ApWq/gpOpU8W/G//pT8NbyLw8JfTKAcWtwZcAYNuUrTJiv/XJMbU+S1TdqPfZ3dZ3hd28pI6bDcaEzr1yZ5KMdvP9aJEpjaishuPUF7kWBF5CQ/TqQZak=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8702782d-a0be-4cef-b8a6-08d67c5bacb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 09:10:48.1246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2900
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm/arm64's io.h doesn't define clrbits32() and clrsetbits_be32(), which
causing compile failure on some Layerscape Platforms (such as LS1021A and
LS2012A which also integrates FSL EHCI controller). So use
ioread32be()/iowrite32be() instead to make it workable on both
powerpc and arm.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Changes in v2:
  - Recover writel() calling in code of handling pdata->has_fsl_erratum_a00=
7792
  - Remove unnecessary parens
  - Move this patch to be first one to avoid breaking the build on ARM.

 drivers/usb/host/ehci-fsl.c |   62 ++++++++++++++++++++++++++++-----------=
---
 1 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 0a9fd20..0a867d9 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/fsl_devices.h>
 #include <linux/of_platform.h>
+#include <linux/io.h>
=20
 #include "ehci.h"
 #include "ehci-fsl.h"
@@ -50,6 +51,7 @@ static int fsl_ehci_drv_probe(struct platform_device *pde=
v)
 	struct resource *res;
 	int irq;
 	int retval;
+	u32 tmp;
=20
 	pr_debug("initializing FSL-SOC USB Controller\n");
=20
@@ -114,17 +116,22 @@ static int fsl_ehci_drv_probe(struct platform_device =
*pdev)
 	}
=20
 	/* Enable USB controller, 83xx or 8536 */
-	if (pdata->have_sysif_regs && pdata->controller_ver < FSL_USB_VER_1_6)
-		clrsetbits_be32(hcd->regs + FSL_SOC_USB_CTRL,
-				CONTROL_REGISTER_W1C_MASK, 0x4);
-
+	if (pdata->have_sysif_regs && pdata->controller_ver < FSL_USB_VER_1_6) {
+		tmp =3D ioread32be(hcd->regs + FSL_SOC_USB_CTRL);
+		tmp &=3D ~CONTROL_REGISTER_W1C_MASK;
+		tmp |=3D 0x4;
+		iowrite32be(tmp, hcd->regs + FSL_SOC_USB_CTRL);
+	}
 	/*
 	 * Enable UTMI phy and program PTS field in UTMI mode before asserting
 	 * controller reset for USB Controller version 2.5
 	 */
 	if (pdata->has_fsl_erratum_a007792) {
-		clrsetbits_be32(hcd->regs + FSL_SOC_USB_CTRL,
-				CONTROL_REGISTER_W1C_MASK, CTRL_UTMI_PHY_EN);
+		tmp =3D ioread32be(hcd->regs + FSL_SOC_USB_CTRL);
+		tmp &=3D ~CONTROL_REGISTER_W1C_MASK;
+		tmp |=3D CTRL_UTMI_PHY_EN;
+		iowrite32be(tmp, hcd->regs + FSL_SOC_USB_CTRL);
+
 		writel(PORT_PTS_UTMI, hcd->regs + FSL_SOC_USB_PORTSC1);
 	}
=20
@@ -174,7 +181,7 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
 			       enum fsl_usb2_phy_modes phy_mode,
 			       unsigned int port_offset)
 {
-	u32 portsc;
+	u32 portsc, tmp;
 	struct ehci_hcd *ehci =3D hcd_to_ehci(hcd);
 	void __iomem *non_ehci =3D hcd->regs;
 	struct device *dev =3D hcd->self.controller;
@@ -192,11 +199,16 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
 	case FSL_USB2_PHY_ULPI:
 		if (pdata->have_sysif_regs && pdata->controller_ver) {
 			/* controller version 1.6 or above */
-			clrbits32(non_ehci + FSL_SOC_USB_CTRL,
-				  CONTROL_REGISTER_W1C_MASK | UTMI_PHY_EN);
-			clrsetbits_be32(non_ehci + FSL_SOC_USB_CTRL,
-					CONTROL_REGISTER_W1C_MASK,
-					ULPI_PHY_CLK_SEL | USB_CTRL_USB_EN);
+			/* turn off UTMI PHY first */
+			tmp =3D ioread32be(non_ehci + FSL_SOC_USB_CTRL);
+			tmp &=3D ~(CONTROL_REGISTER_W1C_MASK | UTMI_PHY_EN);
+			iowrite32be(tmp, non_ehci + FSL_SOC_USB_CTRL);
+
+			/* then turn on ULPI and enable USB controller */
+			tmp =3D ioread32be(non_ehci + FSL_SOC_USB_CTRL);
+			tmp &=3D ~CONTROL_REGISTER_W1C_MASK;
+			tmp |=3D ULPI_PHY_CLK_SEL | USB_CTRL_USB_EN;
+			iowrite32be(tmp, non_ehci + FSL_SOC_USB_CTRL);
 		}
 		portsc |=3D PORT_PTS_ULPI;
 		break;
@@ -210,16 +222,21 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
 	case FSL_USB2_PHY_UTMI_DUAL:
 		if (pdata->have_sysif_regs && pdata->controller_ver) {
 			/* controller version 1.6 or above */
-			clrsetbits_be32(non_ehci + FSL_SOC_USB_CTRL,
-					CONTROL_REGISTER_W1C_MASK, UTMI_PHY_EN);
+			tmp =3D ioread32be(non_ehci + FSL_SOC_USB_CTRL);
+			tmp &=3D ~CONTROL_REGISTER_W1C_MASK;
+			tmp |=3D UTMI_PHY_EN;
+			iowrite32be(tmp, non_ehci + FSL_SOC_USB_CTRL);
+
 			mdelay(FSL_UTMI_PHY_DLY);  /* Delay for UTMI PHY CLK to
 						become stable - 10ms*/
 		}
 		/* enable UTMI PHY */
-		if (pdata->have_sysif_regs)
-			clrsetbits_be32(non_ehci + FSL_SOC_USB_CTRL,
-					CONTROL_REGISTER_W1C_MASK,
-					CTRL_UTMI_PHY_EN);
+		if (pdata->have_sysif_regs) {
+			tmp =3D ioread32be(non_ehci + FSL_SOC_USB_CTRL);
+			tmp &=3D ~CONTROL_REGISTER_W1C_MASK;
+			tmp |=3D CTRL_UTMI_PHY_EN;
+			iowrite32be(tmp, non_ehci + FSL_SOC_USB_CTRL);
+		}
 		portsc |=3D PORT_PTS_UTMI;
 		break;
 	case FSL_USB2_PHY_NONE:
@@ -241,9 +258,12 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
=20
 	ehci_writel(ehci, portsc, &ehci->regs->port_status[port_offset]);
=20
-	if (phy_mode !=3D FSL_USB2_PHY_ULPI && pdata->have_sysif_regs)
-		clrsetbits_be32(non_ehci + FSL_SOC_USB_CTRL,
-				CONTROL_REGISTER_W1C_MASK, USB_CTRL_USB_EN);
+	if (phy_mode !=3D FSL_USB2_PHY_ULPI && pdata->have_sysif_regs) {
+		tmp =3D ioread32be(non_ehci + FSL_SOC_USB_CTRL);
+		tmp &=3D ~CONTROL_REGISTER_W1C_MASK;
+		tmp |=3D USB_CTRL_USB_EN;
+		iowrite32be(tmp, non_ehci + FSL_SOC_USB_CTRL);
+	}
=20
 	return 0;
 }
--=20
1.7.1

