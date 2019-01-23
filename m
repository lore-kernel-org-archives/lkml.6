Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E00CC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F2AC20870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O044ruWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfAWHFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:05:37 -0500
Received: from mail-eopbgr00040.outbound.protection.outlook.com ([40.107.0.40]:15536
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbfAWHFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:05:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aN37nJrgIPgE7ZPr3xCbwczcG7b3LgUhcqSPB8QwGss=;
 b=O044ruWIWIJw6Jreuk6JDpichfwteodkerEIGj8CmU/jjH1zIdAsCb1yMG4xBG5L9gjF/eB8vlnsp8ygfZWzd70iXODkciMZmeu+2Y6x6vz6dFz1w7VnDdha9faJjWbFrvMPczouDEYFineQ5mAvOxu6YcK39IE+VfShYUArrlk=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB4717.eurprd04.prod.outlook.com (20.177.48.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Wed, 23 Jan 2019 07:05:32 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4%2]) with mapi id 15.20.1537.031; Wed, 23 Jan 2019
 07:05:32 +0000
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
Subject: [PATCH v3 2/5] usb: phy: Workaround for USB erratum-A005728
Thread-Topic: [PATCH v3 2/5] usb: phy: Workaround for USB erratum-A005728
Thread-Index: AQHUsuoHYXec1yvzwEqcp9dc5KDs6w==
Date:   Wed, 23 Jan 2019 07:05:31 +0000
Message-ID: <20190123070615.14462-2-yinbo.zhu@nxp.com>
References: <20190123070615.14462-1-yinbo.zhu@nxp.com>
In-Reply-To: <20190123070615.14462-1-yinbo.zhu@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR0302CA0022.apcprd03.prod.outlook.com
 (2603:1096:202::32) To VI1PR04MB4158.eurprd04.prod.outlook.com
 (2603:10a6:803:46::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4717;6:0NdOA6Iia4bYUJUCKzLPh00VbMVdjrOyePkS0dx1uPewyXEuCRbKZyAnNOSltJJE65gFkyzuT8+BLWFwwsMSavGIFxdMHDLV5UfECmvl3mfk3ybt8/LvXJH7EzIP8vMTc5y4w/DAE+z8JIsgS93Kf7IYgg5JlCyNjDcHJWaoyMeiYrC8Cdhx2YZ75qh2VyKKnrhrMpa1tf8Mb4JlI169xjRYntCVeTSJu7gqoEM1vaTBnY8AgM0T1L3E0bfd2lLg2JIwYVuYjJo6bMokBxFCwkEmD4D3Vefnr2wkrO2O578beg1MtzZrQW801Wa0tD8wJ0GZWteptnNaZL8zT8lZ3Bdio9FctjykhSVlopA90OG4vMpCTHOMAJ+wDpkCe/gWsPiBUHPH7yc9RF9b17DXe4McJR8R5Vu41CKWmbZyuT4g4bKdv8UiS84u40ZYEbYV8vvugQEB2rw/1w1F30oFTQ==;5:ugQIpXvgiWAaZyF9KKTax8gxC9KbICS137i28dueZCADY9ck5/scoxAo3SpUSnRbRiSYhgTVG8MLutgWphgLwa1+/9AvjUQKrXxHhw5rEQNTcBj/3VmxvSSuTbSnDmmkOxtEaJBiYUycjM4VjLIe/iE+8I2AjxzTKpyoT4gYBcGj5a/9njIcdisZWt2Cf4slUruh0aS7UGH2W9nOT38biw==;7:4bN3/h2CTc19Y95uEb26ERD6UJj9rVbhHNZpxP6x4jszQ5nLQjBn21yb5upB6iBxXY9ecVZO/PxbAQVqu29nm4ZI6Yff3R9/n8L6ux4otdgImHSBdeT4qWGKzg78sbJVNkgUHDiD7TmGFKv1WGSh8A==
x-ms-office365-filtering-correlation-id: 184e5e63-4e8d-480f-43ae-08d6810129d3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4717;
x-ms-traffictypediagnostic: VI1PR04MB4717:
x-microsoft-antispam-prvs: <VI1PR04MB4717CB5AB50C3C14F9DACB3DE9990@VI1PR04MB4717.eurprd04.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(376002)(396003)(39860400002)(366004)(346002)(199004)(189003)(36756003)(99286004)(386003)(53936002)(6506007)(6486002)(7736002)(71190400001)(305945005)(6916009)(102836004)(71200400001)(81156014)(86362001)(52116002)(446003)(2171002)(25786009)(81166006)(6436002)(6512007)(4326008)(66066001)(11346002)(8676002)(97736004)(486006)(256004)(106356001)(316002)(105586002)(68736007)(2906002)(2616005)(478600001)(26005)(54906003)(186003)(6116002)(1076003)(107886003)(3846002)(14454004)(8936002)(44832011)(76176011)(476003)(50226002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4717;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: U4dq8F+y/0S9NtfwzF1H84YrcBUWMRsPkCeg9kptKNwa63uy7Z1NLzRBnR6AVRhIuWFrLKutIw1pAOyYYA/9rDXpGpzDn+gNM1xnjlg2L+OXKWyqLLhRODLzFFoajPBXwwSN5JrF5SeCPyeu3z13/gZ4xMFbir+SxenSYWr85ebqV/qxpX0OZG1WKAy7vu7yVbEbZLDwXrOxdPLQXZU0ynWaiRcZEBrEhiWTnd+QS5pvvu631kMUzfaZgjSeX6no7jLizR6kkXLnZ7h/oiR+M2/xE9dIgnZGPBkfvmgE+Ggza/zqd6YiTs3OpBo6Im/SwR4fjJ9jkCVqTOdX29UG4udxKy66lRB5oOf7RtedfXKHN45Xbvmfr6jZh6AFcYMZrJYLidsaIOCbG+2FBYI9Je1z8JaMg6IW/KPyvzxWSAk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 184e5e63-4e8d-480f-43ae-08d6810129d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 07:05:27.5227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4717
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
Change in v3:
		replace in_be32 with ioread32be

 drivers/usb/host/ehci-fsl.c |   37 ++++++++++++++++++++++++++-----------
 drivers/usb/host/ehci-fsl.h |    3 +++
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index ea7e17b..8b0f3ed 100644
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
@@ -226,6 +237,16 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
 		/* fall through */
 	case FSL_USB2_PHY_UTMI:
 	case FSL_USB2_PHY_UTMI_DUAL:
+		/* PHY_CLK_VALID bit is de-featured from all controller
+		 * versions below 2.4 and is to be checked only for
+		 * internal UTMI phy
+		 */
+		if (pdata->controller_ver > FSL_USB_VER_2_4 &&
+			pdata->have_sysif_regs && !usb_phy_clk_valid(hcd)) {
+			pr_err("fsl-ehci: USB PHY clock invalid\n");
+			return -EINVAL;
+		}
+
 		if (pdata->have_sysif_regs && pdata->controller_ver) {
 			/* controller version 1.6 or above */
 			tmp =3D ioread32be(non_ehci + FSL_SOC_USB_CTRL);
@@ -249,17 +270,11 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
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
+		pdata->controller_ver > FSL_USB_VER_1_6 &&
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

