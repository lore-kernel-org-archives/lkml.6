Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BB2C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F1820879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ID8Cembu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfAUKZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:25:13 -0500
Received: from mail-eopbgr20056.outbound.protection.outlook.com ([40.107.2.56]:11429
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbfAUKZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kY9O2+bEuEHpKzzY/RzsErRorf1+4Qbj7g9oiRjOCI8=;
 b=ID8CembuOjBdwxU5yiN9EQxl8AJ8RS8BfId4Sr8OeWcfaQnPT3YOj0qqN/4zG4uQMZMwnFDraphU6AKEGcRIDsWC9176TczKK+qN7ivvcf72DgK/kmtBSxtMO2ibtUYcKgmP3qJa5jW7huSBVAjNa2emmc7c7LNAPaWShGpv8B0=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB6110.eurprd04.prod.outlook.com (20.179.26.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Mon, 21 Jan 2019 10:25:06 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4%2]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 10:25:06 +0000
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
Subject: [PATCH v2 2/6] usb: phy: Workaround for USB erratum-A005728
Thread-Topic: [PATCH v2 2/6] usb: phy: Workaround for USB erratum-A005728
Thread-Index: AQHUsXOTxtawB/GUl029QzXbRLQa/g==
Date:   Mon, 21 Jan 2019 10:25:06 +0000
Message-ID: <20190121102601.4735-2-yinbo.zhu@nxp.com>
References: <20190121102601.4735-1-yinbo.zhu@nxp.com>
In-Reply-To: <20190121102601.4735-1-yinbo.zhu@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:202:2e::15) To VI1PR04MB4158.eurprd04.prod.outlook.com
 (2603:10a6:803:46::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yinbo.zhu@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB6110;6:z6/z59IuB3eZs+iIoyAF6cVrFk4SImUwG856mp+4WRLORQqrn1N5sN8olF+1qxQ90qH0RYu6VEIzqXApeKI7itU4N23j1VsnSI351Qqp4obONlaFyca32d4OWwFw5wxI9/gLYPVj0B/EKEvjxtgjAPPt2l9l8eW0gmQutqEXVyQDi13KfeK+J8Rr8tjM4yrrx3UUXaksbDTMOV79CnkUpsa4IZqKF4qRrcMfIUYFTBml2KAWNdO5q4VQleFQ8/nVTBssZa/HhzQtt8eC1ANrTa5dcbxfCyNdPUqX2ELvPq1jDkVCXqNSnjeA7SdiPBduoHep2cI3pnKTrCynEzw4jQvl9AHZpfUo/OQGUbRe80UmALohxTVkdVzATs/dxjGmlM6vrVzJyrUkTcXeXlI+dlB7+Z62cAi+NnmYKR6ZMJSRlYhlwwDKZ+exqkX6Ven5VqyxlW/+PBn1xBctMntJsg==;5:veLs8IUauhpLIImYlRT//C+d4tODf98HRiyrl92SjBAt9ESlCQzWgVSAqNURJK+nCTYktwRvftCnesKF/8qoDH31v/6jgsFxeGD8H7R3RKZw3CHF6j9ZJbq4ChbL2Rq40L2pQ4KGZRPmW41M9SRTEDGteVDEHRNeBs2HCdP1M/58vRQn0q00tkWcwLzM5285iq5Q34OEzav+AbVw+54i5A==;7:/nz96PjIZ+vom3ayvJ8VG7opefcCLd6WjI/4y7mVt6mnkeF9OvyG7m2b3Bx+pKS0gqfAmAg92eZWvrf5mdbuC6PCwlZglIW2nn1IUbE16cv/ZcUljcsaKtu5OzQWw4FSYE1LYCn/8Z52lxaxqGNC6Q==
x-ms-office365-filtering-correlation-id: 6cc94379-5d56-44e8-8567-08d67f8ab62e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB6110;
x-ms-traffictypediagnostic: VI1PR04MB6110:
x-microsoft-antispam-prvs: <VI1PR04MB611067693A06EFDE0D5B81E2E99F0@VI1PR04MB6110.eurprd04.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(396003)(39860400002)(199004)(189003)(476003)(2616005)(446003)(11346002)(6486002)(2906002)(1076003)(4326008)(316002)(6916009)(68736007)(7736002)(54906003)(86362001)(71190400001)(305945005)(71200400001)(478600001)(66066001)(6116002)(3846002)(25786009)(8676002)(6506007)(386003)(52116002)(81156014)(81166006)(26005)(76176011)(99286004)(186003)(102836004)(50226002)(256004)(14454004)(8936002)(36756003)(486006)(6436002)(105586002)(106356001)(2171002)(6512007)(97736004)(107886003)(44832011)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6110;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YuQ5hMEWx63qDgFvWYnRD7ifQsYbbNUAdX8GhEKbASTM42AD8pWrnsfZj08kbciNMViOk+R3bxOKKyTJ4Ij4uKzlR7DeewObbBqWzA7eeqdpykLo4/WG522G/gKdU1d/QWasPPP3tdLmzshyFyjO/SYHbKUNHOKuurhRQ+RfL7KmyD3i5q2MGkmfbZPWFf4P+m1RFMxFMl0v0wSAGmH8yFQfa17wgqml3pd6ALrVa4iKUo59+EjD1EokO52EpM3ilax9cYWs/DR/OvQYxU8bRJnPqGITNeyTaiUr7UcT1o0Y4NGOt3Pss2v6cOU9qznkAR+k1WADGs8M27LKr7mZVAEjzr/ANtvwuioJGBCvTVzAmsFWwnMYlGw2cksrgmKv/aIIq6zl3UJRGOReaaKcbCC+Tr3CMKtyWC+HTrek4bY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cc94379-5d56-44e8-8567-08d67f8ab62e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 10:25:01.2907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6110
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
Change in v2:
		replace Yinbo.Zhu with Yinbo Zhu

 drivers/usb/host/ehci-fsl.c |   37 ++++++++++++++++++++++++++-----------
 drivers/usb/host/ehci-fsl.h |    3 +++
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 71c4661..a28ec1e 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -176,6 +176,17 @@ static int fsl_ehci_drv_probe(struct platform_device *=
pdev)
 	return retval;
 }
=20
+static bool usb_phy_clk_valid(struct usb_hcd *hcd)
+{
+	void __iomem *non_ehci =3D hcd->regs;
+	bool ret =3D true;
+
+	if (!(in_be32(non_ehci + FSL_SOC_USB_CTRL) & PHY_CLK_VALID))
+		ret =3D false;
+
+	return ret;
+}
+
 static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
 			       enum fsl_usb2_phy_modes phy_mode,
 			       unsigned int port_offset)
@@ -214,6 +225,16 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
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
 			clrsetbits_be32(non_ehci + FSL_SOC_USB_CTRL,
@@ -232,17 +253,11 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
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

