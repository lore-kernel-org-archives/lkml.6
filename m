Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C63C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A474320700
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GhXiueMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfAHGEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 01:04:32 -0500
Received: from mail-eopbgr10049.outbound.protection.outlook.com ([40.107.1.49]:38188
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727794AbfAHGEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 01:04:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jp+KXEpbl4d7YUPFIKZ6lUhbqzUlfLBW98ufX2V6NPY=;
 b=GhXiueMz1aj2Ko4EWhWDOZrSayrpnDeYZfrMyHIRfVHYkpnCqbro1mjZeGAG6iNo7LI/qpa67ZQUxOWvZgzMreKtDUgm3XPPcmCwBpvl2RdCbVebe4KqRnUY3jkm6JDDRQ57cYjduqV+Ac6kEdFl0ONriTm3GQUp54C1v/Epzz8=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2915.eurprd04.prod.outlook.com (10.175.42.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Tue, 8 Jan 2019 06:04:26 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626%2]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 06:04:26 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH 2/3] usb: ehci: fsl: Update register accessing for arm/arm64
 platforms
Thread-Topic: [PATCH 2/3] usb: ehci: fsl: Update register accessing for
 arm/arm64 platforms
Thread-Index: AQHUpxgC6yBGLPIm9UWYEo0ogu0Vcw==
Date:   Tue, 8 Jan 2019 06:04:26 +0000
Message-ID: <20190108060426.11581-2-ran.wang_1@nxp.com>
References: <20190108060426.11581-1-ran.wang_1@nxp.com>
In-Reply-To: <20190108060426.11581-1-ran.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::26) To AM5PR0402MB2865.eurprd04.prod.outlook.com
 (2603:10a6:203:99::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2915;6:qpeCRqndoW2gz1T9d8s8IL4J1dGiSD5pZKJuzId50kKUTdI4yvKOeoX0x7i9HAjFiG3xlsuvpnH2kt6aZY4mDq2hmdw1oKEZ6olCL0ZaaMmB3ziGFvb0QLVg8ofoiEw+ZYFpH1bPF2+41Ec7K+c2vA6HOBsWHxy9DMifohz93lbEvPeThsSNUPwmbzmJzK72iOmBK37FTo8DmoagCXjeV9ScqhH9CF0a9JNxLpv/vNb/DM+6lzVR9L1wSlDZNMt7h+RLSx+p1Me5nslHv/OYoY0UMB6uMKgPk1gpM9+X7QuPtXgguO8j2C1kQOQDi5dCXLEB5xcNnXbBELU6hn0RQ8oby6yMkOoJXVdN4tKLEJBq2lpeo49znsccNxVj/3XbxYwY/NZrUQ1uZDlAUXdA0MbiYbRa4J7wI27XKtl+MeXNThH0pHFWyXg0b9A9b5pwMSlkBtqpT5lGb1uxFq9QkQ==;5:4fI9OJM6kMlq4CFOm5iLWGfKX8IrsCYivEmSMe+Aqf7Zsg4JFHlEBMoYHl5UBOAsAU+vHy9w+aREXM4l6xyrAPgDsXGvzQTgNa7lk6evBzqNOh7y2UrNbPRBhM8rUhgJ70ZXbP8ONINm3vIsykrniSwRtaaPoFr4nb4Wedc0QkUWlaCzC7STWFqEfawWgC3DFjViwAAt6ix6m59pQIn9eg==;7:E1SNKKpfQGkalbGtBzN2ytTLEEt+Sg/8ajC3EgCCpoJ6SfbnaHAO7oKa5EBhQIsqDa9dO8DJaElQO6p7OyLwivgDUqepFTEID5Z2DQqzkNPr7z2Obm/B84OeiLtHFQeuwdkPHgGTIemq6Qv6skdBKw==
x-ms-office365-filtering-correlation-id: 3cac0f20-3149-4c56-af91-08d6752f24e7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2915;
x-ms-traffictypediagnostic: AM5PR0402MB2915:
x-microsoft-antispam-prvs: <AM5PR0402MB2915FCA095D5FA920EE1277AF18A0@AM5PR0402MB2915.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM5PR0402MB2915;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0402MB2915;
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(366004)(136003)(199004)(189003)(68736007)(97736004)(36756003)(478600001)(66066001)(476003)(81156014)(81166006)(25786009)(6436002)(8676002)(2616005)(446003)(11346002)(54906003)(6486002)(110136005)(186003)(1076003)(14444005)(106356001)(256004)(105586002)(2906002)(3846002)(71200400001)(6116002)(486006)(7736002)(71190400001)(14454004)(2171002)(50226002)(4326008)(5660300001)(99286004)(305945005)(102836004)(76176011)(53936002)(52116002)(386003)(6506007)(26005)(8936002)(316002)(86362001)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2915;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pK9OVPmXqXhvt2MiV9JZPjW4G1Ln5Jj0RIQUfvFDQqgUg0RGUC/emc4UZwCvM6517jleYidhfLYb/SREAS4+UJp+eceyWVSlefleHcdaq0Iad0JaXk9WSvI3OvrM7q03vD0Dr8Tt06fQyJ1B6MEZPLINWaVnO+gEOsTZ0LJXYA00FMmERb4SzXcUvObcmT6IaEw5GP9m+D0BSXwvAmkrXR/bMq81hQL3BphgC2d86/wYvlNLG4B0ap79uX0bjwgzuF/m61w1yOXiGpefTJ/fnYAHw478+aHD34zY35HurB5wpMYPRAD4N3rpaIG3/A+X
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cac0f20-3149-4c56-af91-08d6752f24e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 06:04:24.2423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2915
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
 drivers/usb/host/ehci-fsl.c |   64 ++++++++++++++++++++++++++++-----------=
----
 1 files changed, 42 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 0a9fd20..59ebe1b 100644
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
@@ -114,18 +116,23 @@ static int fsl_ehci_drv_probe(struct platform_device =
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
-		writel(PORT_PTS_UTMI, hcd->regs + FSL_SOC_USB_PORTSC1);
+		tmp =3D ioread32be(hcd->regs + FSL_SOC_USB_CTRL);
+		tmp &=3D ~CONTROL_REGISTER_W1C_MASK;
+		tmp |=3D CTRL_UTMI_PHY_EN;
+		iowrite32be(tmp, hcd->regs + FSL_SOC_USB_CTRL);
+
+		iowrite32be(PORT_PTS_UTMI, hcd->regs + FSL_SOC_USB_PORTSC1);
 	}
=20
 	/* Don't need to set host mode here. It will be done by tdi_reset() */
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
+			tmp &=3D ~(CONTROL_REGISTER_W1C_MASK);
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
+			tmp &=3D ~(CONTROL_REGISTER_W1C_MASK);
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

