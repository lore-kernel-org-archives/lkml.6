Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AB88C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3264218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ljRLu5HO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfAYGDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 01:03:46 -0500
Received: from mail-eopbgr00079.outbound.protection.outlook.com ([40.107.0.79]:49753
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726097AbfAYGDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 01:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NrIrxG/4vatlyji+mL63j0o3lNCoAPqVETdonTkdUWs=;
 b=ljRLu5HOpiY3J4iew7ERc7ez2sv1u8w87mV96w7Hzqz/ZUEJyWhjzivoPIUt8WeLSW/Bq2RZiB230y2sqwORfoP9Bw7zzuAQK0yp8O1PWcgiL6jTK6acdXpCfSARZnELxh1z0nVZH2az688Q5U0VlA1CB/kwHZvO4jpq5gh5GaQ=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB5455.eurprd04.prod.outlook.com (20.178.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Fri, 25 Jan 2019 06:02:57 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4%2]) with mapi id 15.20.1537.031; Fri, 25 Jan 2019
 06:02:57 +0000
From:   Yinbo Zhu <yinbo.zhu@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Yinbo Zhu <yinbo.zhu@nxp.com>, Xiaobo Xie <xiaobo.xie@nxp.com>,
        Jerry Huang <jerry.huang@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Suresh Gupta <suresh.gupta@freescale.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Suresh Gupta <B42813@freescale.com>
Subject: [PATCH v4 2/5] usb: phy: Workaround for USB erratum-A005728
Thread-Topic: [PATCH v4 2/5] usb: phy: Workaround for USB erratum-A005728
Thread-Index: AQHUtHOesohGAmkVu06RgZ2b3quwfA==
Date:   Fri, 25 Jan 2019 06:02:57 +0000
Message-ID: <20190125060356.14294-2-yinbo.zhu@nxp.com>
References: <20190125060356.14294-1-yinbo.zhu@nxp.com>
In-Reply-To: <20190125060356.14294-1-yinbo.zhu@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0145.apcprd02.prod.outlook.com
 (2603:1096:202:16::29) To VI1PR04MB4158.eurprd04.prod.outlook.com
 (2603:10a6:803:46::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5455;6:bxcl8qTKuf936wjOaEpC5lA1nNYQzGfn5AcvgwHNjNT8t3G0bYb1CZ1UlsjN7lRBqHS2fcABefTnHC0FiOnDdv7n/RR6+vZX28RBlJAVXJeH5c3ztYQIyM/bshZq2jlcsV2Tuyv+zeZstVZBmGUofuJdtfxiefnFgxYyakZG/3TYTpazdEJ/Gpum7Z765ql6MTXUb6NPODuOI+jhMnS8AJ0SRghXatU4/uJWnAmRu3s+7twdiLG9B6FuUoWBq3sXupsiXhwy/M3SEEHB/ner1Ed1rCvZX4dvOZgbyyprDhFKHmJJRFMx9IcATnlOkJqSw++SSUR/5hnJMiRCB8QLWgPRUwvaOSU8WQ1gsVAi1LYBgE6d/FU7bKvKR3OQfQ/c1pzjswQzBrBA88miJ4In7r7NsKj9c/wFC/R1Oh369KBP4jllViAQwC22KllCMqP6D/HgKhm1AJztETQ9DRvACg==;5:VbchI1j6TN4T4q3ghSBOU31cFuau8+2ZxL7X+4d9C7YWt5+OXaBVo/hMsUFJPyrx4vowhrpRHuFHpbjsDX0amRxGECttI0KsOnYvvRUSuh7OxIaYI8Gw8eTZIYBg5FEpZjggVuJJMH+RXf0nJsAry+hbTcviMt+1EmvPfQWadecwY8XyWA6V7pnKJ3LHKwDs8oVJbh5BJruCuMmnFWz8rQ==;7:rO23CQABg4Zss+VOQarehnDFjqhWYJXNKnOcwew9GMLtK6ei4rC+goFZUFuRRaUPiCa1Snnz/0vFkcFWoCgeXZAoyH2uTElvEtVPo8DbAMs2TA0z3h9n8pUhtEu32cfPaIbl71sHdKDjhsLbe14rkA==
x-ms-office365-filtering-correlation-id: 33078a64-21b0-441b-5a0d-08d6828ac0a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5455;
x-ms-traffictypediagnostic: VI1PR04MB5455:
x-microsoft-antispam-prvs: <VI1PR04MB54558817091D8FE6B3D482FFE99B0@VI1PR04MB5455.eurprd04.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(366004)(346002)(189003)(199004)(6916009)(486006)(4326008)(105586002)(106356001)(52116002)(1076003)(14454004)(2616005)(6486002)(446003)(44832011)(76176011)(11346002)(6436002)(476003)(316002)(478600001)(25786009)(3846002)(107886003)(6116002)(2171002)(50226002)(305945005)(7736002)(8936002)(26005)(186003)(256004)(86362001)(54906003)(71190400001)(71200400001)(99286004)(102836004)(36756003)(2906002)(386003)(6512007)(97736004)(8676002)(81156014)(81166006)(66066001)(68736007)(6506007)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5455;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: i7CR+Ud2yl3NqH5wL/XNy7OU0pUAluBs8NrM+IzW4UqMrH3Lw/ikRxm14L8hX6uLGYgCzNbjMNC7oJO0qdihsqBFd4mKpUEACrsKoj4Sm1j8nV3T9I5eZofK9+7aVuGT0xLerQk7AKKTWIx8Sf5+T+SLHebuORBEdhhrisFy9XaPYJszYhFjH0gcQmi/oawHYcRIPWiBO7qdLcfoGM3OvFrwyoFn1uIDNEPUglS8eJLm/nfdu0enGl6dm8J7lApsUosDBH+2mh4e5z5sME6aYxEwCWh11mW9XydqR3qDNfJx6fw9+I2sU/geRDHlSzKis03U85Uisjws0u/jaOvVEPMM36hv1IAqw5pJyXBW3c4EpolzwB4dnJUmgIB8wiz29nrvTDoyOSR7p7iRSOJ4TslVtzTr4/wjSWx/9noEXRk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33078a64-21b0-441b-5a0d-08d6828ac0a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 06:02:51.7685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suresh Gupta <B42813@freescale.com>

PHY_CLK_VALID bit for UTMI PHY in USBDR does not set even
if PHY is providing valid clock. Workaround for this
involves resetting of PHY and check PHY_CLK_VALID bit
multiple times. If PHY_CLK_VALID bit is still not set even
after 5 retries, it would be safe to deaclare that PHY
clock is not available.
This erratum is applicable for USBDR less then ver 2.4.

Signed-off-by: Suresh Gupta <B42813@freescale.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
Change in v4:
		Incorrect indentation of the continuation line.
		replace pr_err with dev_err.

 drivers/usb/host/ehci-fsl.c |   38 +++++++++++++++++++++++++++-----------
 drivers/usb/host/ehci-fsl.h |    3 +++
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 38674b7..373a816 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -183,6 +183,17 @@ static int fsl_ehci_drv_probe(struct platform_device *=
pdev)
 	return retval;
 }
=20
+static bool usb_phy_clk_valid(struct usb_hcd *hcd)
+{
+	void __iomem *non_ehci =3D hcd->regs;
+	bool ret =3D true;
+
+	if (!(ioread32be(non_ehci + FSL_SOC_USB_CTRL) & PHY_CLK_VALID))
+		ret =3D false;
+
+	return ret;
+}
+
 static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
 			       enum fsl_usb2_phy_modes phy_mode,
 			       unsigned int port_offset)
@@ -226,6 +237,17 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
 		/* fall through */
 	case FSL_USB2_PHY_UTMI:
 	case FSL_USB2_PHY_UTMI_DUAL:
+		/* PHY_CLK_VALID bit is de-featured from all controller
+		 * versions below 2.4 and is to be checked only for
+		 * internal UTMI phy
+		 */
+		if (pdata->controller_ver > FSL_USB_VER_2_4 &&
+		    pdata->have_sysif_regs && !usb_phy_clk_valid(hcd)) {
+			dev_err(dev,
+				"%s: USB PHY clock invalid\n", dev_name(dev));
+			return -EINVAL;
+		}
+
 		if (pdata->have_sysif_regs && pdata->controller_ver) {
 			/* controller version 1.6 or above */
 			tmp =3D ioread32be(non_ehci + FSL_SOC_USB_CTRL);
@@ -249,17 +271,11 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
 		break;
 	}
=20
-	/*
-	 * check PHY_CLK_VALID to determine phy clock presence before writing
-	 * to portsc
-	 */
-	if (pdata->check_phy_clk_valid) {
-		if (!(ioread32be(non_ehci + FSL_SOC_USB_CTRL) &
-		    PHY_CLK_VALID)) {
-			dev_warn(hcd->self.controller,
-				 "USB PHY clock invalid\n");
-			return -EINVAL;
-		}
+	if (pdata->have_sysif_regs &&
+	    pdata->controller_ver > FSL_USB_VER_1_6 &&
+		!usb_phy_clk_valid(hcd)) {
+		dev_warn(hcd->self.controller, "USB PHY clock invalid\n");
+		return -EINVAL;
 	}
=20
 	ehci_writel(ehci, portsc, &ehci->regs->port_status[port_offset]);
diff --git a/drivers/usb/host/ehci-fsl.h b/drivers/usb/host/ehci-fsl.h
index cbc4220..9d18c6e 100644
--- a/drivers/usb/host/ehci-fsl.h
+++ b/drivers/usb/host/ehci-fsl.h
@@ -50,4 +50,7 @@
 #define UTMI_PHY_EN             (1<<9)
 #define ULPI_PHY_CLK_SEL        (1<<10)
 #define PHY_CLK_VALID		(1<<17)
+
+/* Retry count for checking UTMI PHY CLK validity */
+#define UTMI_PHY_CLK_VALID_CHK_RETRY 5
 #endif				/* _EHCI_FSL_H */
--=20
1.7.1

