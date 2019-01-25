Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36DDC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CCF218D2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L2G+c9up"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfAYGDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 01:03:44 -0500
Received: from mail-eopbgr00076.outbound.protection.outlook.com ([40.107.0.76]:34823
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726897AbfAYGDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 01:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=stMSGU4D2zxXCPDnQBenMF7UzvJa1CpNkFi2MyOpy/4=;
 b=L2G+c9upj/FL/OE3D3fCcurT91dvgw31n5flYNfUDN2Onu24TkgIW7U2MssLa5lgXMKXKePjVlm/AKMDLCVl+DHnfAriBXk6oyepGtDrGVtPm9oQczGChv3Muf5HWx69M/WdZyMjKUPgEbV7pOtIsMGJTowo9BAD51dARNd7rsg=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB5455.eurprd04.prod.outlook.com (20.178.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.18; Fri, 25 Jan 2019 06:03:06 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4%2]) with mapi id 15.20.1537.031; Fri, 25 Jan 2019
 06:03:06 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 4/5] usb: host: Stops USB controller init if PLL fails to
 lock
Thread-Topic: [PATCH v4 4/5] usb: host: Stops USB controller init if PLL fails
 to lock
Thread-Index: AQHUtHOjEng1K+NiYU6bfiLuvdUQdg==
Date:   Fri, 25 Jan 2019 06:03:06 +0000
Message-ID: <20190125060356.14294-4-yinbo.zhu@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5455;6:6ygwJO/VXBeK1WM7usK3mehqyBtq0OnmeEwPid21qZrQrC0J0ZOnEoA4AkhoMAvTcwvRXDQQJ9wQ9HYp5rqtf1Haz2xPVQhh966rgs2G2GzOVyjH5rOG/g5JVstn8lC9/TtKKdtJMgr3gtK5UiQ4dG2pgPv/WLwWA1HBBMSUEUD7DudVp7jspQJy0jcMqYm6pGklxc9qxsKmFgidf4DnhjpW3AguaVeurw/UlUEKG7Dq+aHKspoM2tq6tATDkK4cRk9qQwryhzvMCSKnissx623bl7VgE55JWRnag1SMi3uoN+sV8T50eZCHNNtTlIpQanthzVJEN0NBjEGZfgVESGfrh8vJ32RRUeo7AhTndasQyUVkvzkbi8fxUMIO0FOVNSTIBgGEaVp7QHWUPPkg38GQqvISCyIDZ5QONenM2LrbWzRJRZdpWgYdy95lp5lJ92vBdnq2HmE8DZ0PSWw+hA==;5:EkO23krb6GT9n8eBnYcqyCwJW0eFOh6MMJjsclQx9GoQBakgvjSGYJqAp86SenKFI8uXb5aJAwZolNamo8liVsE9hQL3W+pKQ+XUEm5nFnuqSnoNHbW0k8qDiTXOLWwg1dLzlL2Z+I0g01cUzkU6FNnRX7lrl52ZPXz0OuW4BEG0GgdzwFLt/+vYOdT86/uthvjfdwRdHy1gUH5bfHdjLA==;7:Wt7rUUKsR9t2nXWWpEGt9pxaTA3aBGYngevZGlZ3aPWSZj08W7viibAdbCsj6PyYxvFrA1zy9J3dtORRZuWdOz73ERkxmkuA7nqiDP4HI5Ru4wUlwMU9kpNNjE/YlCeSB0nwAkruQvlJ9Kbm5UOfcA==
x-ms-office365-filtering-correlation-id: 10137209-9421-4df7-57b8-08d6828ac610
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5455;
x-ms-traffictypediagnostic: VI1PR04MB5455:
x-microsoft-antispam-prvs: <VI1PR04MB5455B8BADCA422F564A9EA6FE99B0@VI1PR04MB5455.eurprd04.prod.outlook.com>
x-forefront-prvs: 0928072091
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(366004)(346002)(189003)(199004)(6916009)(486006)(4326008)(105586002)(106356001)(52116002)(1076003)(14454004)(2616005)(6486002)(446003)(44832011)(76176011)(11346002)(6436002)(476003)(316002)(478600001)(25786009)(3846002)(6116002)(2171002)(50226002)(305945005)(7736002)(8936002)(26005)(186003)(256004)(14444005)(86362001)(54906003)(71190400001)(71200400001)(99286004)(102836004)(36756003)(2906002)(386003)(6512007)(97736004)(8676002)(81156014)(81166006)(66066001)(68736007)(6506007)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5455;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a2bB3sJ504OnSnFkm/lIXAyXBwOezMpUCDwEf3HIFbxF+a/mL5KtJn/H+WCFMSMJl/lUXdX4aCyKv02ugd9NypznROFiQ1B5V9EVd1lQLcBb0nHzFEsZZ8Fwu6jWKksU8es+zov4EssnhYk3a00TuKJNXwYZo7RS1g4zNgx1xPVOgkm3255VCL98KYW/KrjpungfLzToqTQB0c/AuHD9KEymmUyWrxYHxxCyMsrMMlTmAWsrp0yUCaZokvBbSKwCkg0P1TT/fDThKoNRTULXEJksGsS0HR6UDZ0D1Er2T/FpUhzwFs4tyhMNjbkfwPNUnM5bX/qhO8MyVBQss9IojfvW7vdgtuT8/kQ19mxfG6WB33EMJxKol0eJs5bYdWBWS5oO4qw307ji28h4D8lZI5kQ/IcmpWF1Z7ts3JfYkgI=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10137209-9421-4df7-57b8-08d6828ac610
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2019 06:03:02.0967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramneek Mehresh <ramneek.mehresh@freescale.com>

USB erratum-A006918 workaround tries to start internal PHY inside
uboot (when PLL fails to lock). However, if the workaround also
fails, then USB initialization is also stopped inside Linux.
Erratum-A006918 workaround failure creates "fsl,erratum_a006918"
node in device-tree. Presence of this node in device-tree is
used to stop USB controller initialization in Linux

Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
Signed-off-by: Suresh Gupta <suresh.gupta@freescale.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
---
 drivers/usb/host/ehci-fsl.c      |    5 +++++
 drivers/usb/host/fsl-mph-dr-of.c |    3 ++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 373a816..8b47277 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -236,6 +236,11 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
 		portsc |=3D PORT_PTS_PTW;
 		/* fall through */
 	case FSL_USB2_PHY_UTMI:
+		if (pdata->has_fsl_erratum_a006918) {
+			pr_warn("fsl-ehci: USB PHY clock invalid\n");
+			return -EINVAL;
+		}
+
 	case FSL_USB2_PHY_UTMI_DUAL:
 		/* PHY_CLK_VALID bit is de-featured from all controller
 		 * versions below 2.4 and is to be checked only for
diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr=
-of.c
index 4f8b8a0..762b976 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -224,13 +224,14 @@ static int fsl_usb2_mph_dr_of_probe(struct platform_d=
evice *ofdev)
 		of_property_read_bool(np, "fsl,usb-erratum-a005275");
 	pdata->has_fsl_erratum_a005697 =3D
 		of_property_read_bool(np, "fsl,usb_erratum-a005697");
+	pdata->has_fsl_erratum_a006918 =3D
+		of_property_read_bool(np, "fsl,usb_erratum-a006918");
=20
 	if (of_get_property(np, "fsl,usb_erratum_14", NULL))
 		pdata->has_fsl_erratum_14 =3D 1;
 	else
 		pdata->has_fsl_erratum_14 =3D 0;
=20
-
 	/*
 	 * Determine whether phy_clk_valid needs to be checked
 	 * by reading property in device tree
--=20
1.7.1

