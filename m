Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF75C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6FC20879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BxOWQZQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfAUKZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:25:17 -0500
Received: from mail-eopbgr150084.outbound.protection.outlook.com ([40.107.15.84]:46872
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbfAUKZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5kss/Ad4eOgvtbc+kDo3JYGw7YpFBOJxlZn1ClRqhEc=;
 b=BxOWQZQltZQOrqVIs/Wo9b1c28/h8WU4nuysZgFTTsDY/lqOpPFsVVafI4U4QlBoRXJEqlfQZjDx7r/wwCSE8Kzql5SHQCA+fYXIsBS884n9vRUxkD9ijp5BfZ+JojwvSYBff+ZGOWNgUXtJh9AkivVPw6B+QNZTZxuftuArRpU=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB6110.eurprd04.prod.outlook.com (20.179.26.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.27; Mon, 21 Jan 2019 10:25:11 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4%2]) with mapi id 15.20.1537.031; Mon, 21 Jan 2019
 10:25:11 +0000
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
Subject: [PATCH v2 3/6] usb: host: Stops USB controller init if PLL fails to
 lock
Thread-Topic: [PATCH v2 3/6] usb: host: Stops USB controller init if PLL fails
 to lock
Thread-Index: AQHUsXOWYWo9SkwNBE2vWQj5pSmfbw==
Date:   Mon, 21 Jan 2019 10:25:10 +0000
Message-ID: <20190121102601.4735-3-yinbo.zhu@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB6110;6:VTyk2kVag+qECxwhSeqlscwweqF6Bv+jqRyMxG7G0RffF42P0CfU1eLakS2/pGC3+ANTZZtzTtOcvkIcY+nUJHlwXDPFG3i1K8dyoRU1/UOUEVV7yEagGQupGzJwAtXEK6e4vAFgkaxsovvZYEnsqrkKaxjfGN03A0xM1VBdYc0c8vx3DHF4MfHo46SHJ7OXd5Uw5qcn3r5OuO+j+/JN7CwUkqQLAmeKjAVSwxICLc5iNsJXkuXYMeGHveZ6/Q0Ei/TqoN683GmxrxhY3fBKtdZxCVZXJn5gjSNCHS3hDsFLiPukjkPQIBVo+/aKgeszr/vZCR2ircuCYx0sCQPQbZXs2yhkNGdaxCr2yxCXfpSXLWyj2mTbu5b7Qz1e3m7vqzoXhWT9uBgP8UrG/XJtxKE+DXdgRPE8UcxEOdZLNy6mxsR2MeXrAVuevOuPbvUjokOJEbapuEusT9DW4q2jYA==;5:Ho87y+3LtA2lrsRJxnAUdEEmOsbWTFSVTGrn4dqRxLzi+au+c8IOji4uyNXteqEqCfTq+6+5EWlQlsXwrRURmNHjqo82LmoZNSN1mIkJVtx15Ea+ip3XHr3mW5RBYdIh8OGDl0eslD+V2/M2hS2zQbc3sQtZrcksZy9KQWhFRv7bk0OLcxUQoihs9nV7lfo+JmFcusY/zjqfDWO5L01uxQ==;7:tJWRCyL+JNRekIUEHzHvVCBXMH4Th+VrOLIu3rveM7YPYVCvM6IKgYuwhXBiSeSGqZjJXECxJpWSkLkgzy3difPwd5JdqAFqX9oastMmQlF2+4zikL01IOBZ856KO093QCx2G/zhPCWSAyMO+ErI2A==
x-ms-office365-filtering-correlation-id: ac197d14-f1a8-4e6a-9f81-08d67f8ab911
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB6110;
x-ms-traffictypediagnostic: VI1PR04MB6110:
x-microsoft-antispam-prvs: <VI1PR04MB611026532CDA061D0EF0939EE99F0@VI1PR04MB6110.eurprd04.prod.outlook.com>
x-forefront-prvs: 0924C6A0D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(346002)(396003)(39860400002)(199004)(189003)(476003)(2616005)(446003)(11346002)(6486002)(2906002)(1076003)(4326008)(316002)(6916009)(68736007)(7736002)(54906003)(86362001)(71190400001)(305945005)(71200400001)(478600001)(66066001)(6116002)(3846002)(25786009)(8676002)(6506007)(386003)(52116002)(81156014)(81166006)(26005)(76176011)(99286004)(186003)(102836004)(50226002)(14444005)(256004)(14454004)(8936002)(36756003)(486006)(6436002)(105586002)(106356001)(2171002)(6512007)(97736004)(44832011)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6110;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3qWBrMcO+vu00Qzz5olLZVOjuTyP9R5ouYwpraBwE43tojR17IVBCzW9Ept4BfT2iobl5pydFFU6qV9yy+5Rq/X8aFH8gcJGDWSTDZeiHld/wxMbIanJHjUihfL4WdORB85yH3KaiUk7g+CuwUYK/u653hJAD/FzKuxUWI3SqPCD/Rw52eF2IEK9/rEWn3tXyqq8JmitSXOoU5iBq1fA6+kRxWRlgvRPsZUJSbrnqlf4UcO2DWI7WilT9V6YbWypo5jm4qjGdOlt2uOlMNOTcLhChSSQvULST4paPr+Z3k82KjHHkKHkGRgEEtCilS+eNO8PRmiYqD0jtVN3iwqIhKxFJGCmFKZFo9WOXgpnGFbay4doVC+XM1oE5uWgjL5Ht37mF75TtHO7EM3y/QG04pXM8jb9pirkyomEFnC4/0A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac197d14-f1a8-4e6a-9f81-08d67f8ab911
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2019 10:25:06.4626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yinbo.zhu <yinbo.zhu@nxp.com>

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
Change in v2:
		replace Yinbo.Zhu with Yinbo Zhu

 drivers/usb/host/ehci-fsl.c      |    5 +++++
 drivers/usb/host/fsl-mph-dr-of.c |    5 +++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index a28ec1e..6884130 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -224,6 +224,11 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
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
index 677f9d5..7e07701 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -225,6 +225,11 @@ static int fsl_usb2_mph_dr_of_probe(struct platform_de=
vice *ofdev)
 	pdata->has_fsl_erratum_a005697 =3D
 		of_property_read_bool(np, "fsl,usb_erratum-a005697");
=20
+	if (of_get_property(np, "fsl,erratum_a006918", NULL))
+		pdata->has_fsl_erratum_a006918 =3D 1;
+	else
+		pdata->has_fsl_erratum_a006918 =3D 0;
+
 	/*
 	 * Determine whether phy_clk_valid needs to be checked
 	 * by reading property in device tree
--=20
1.7.1

