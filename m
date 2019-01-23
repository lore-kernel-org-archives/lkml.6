Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F725C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A5E20870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZY6a9CQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfAWHFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:05:45 -0500
Received: from mail-eopbgr30042.outbound.protection.outlook.com ([40.107.3.42]:26475
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbfAWHFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:05:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmPp7AtSAc2SmN1pZyzyaGS0c89juhQVNR3mGpKx5HU=;
 b=ZY6a9CQP7SSRTkcpVks2gM3G1Fsd8b9BBlj+KPGFFdGuI2kDLyEsqgfMDDzm7KZc0wUxiptLQEUe90LDtHcWNpc5G4rPqggsq3qW240HbCebdNPYvLZsa/KM5atJdWD9mGIqB5iNNHJmiKw/vs16nico4r+fhEuR1eYif5jGZTA=
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com (52.133.15.33) by
 VI1PR04MB5102.eurprd04.prod.outlook.com (20.177.50.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Wed, 23 Jan 2019 07:05:36 +0000
Received: from VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4]) by VI1PR04MB4158.eurprd04.prod.outlook.com
 ([fe80::257e:f28a:1a8c:c9c4%2]) with mapi id 15.20.1537.031; Wed, 23 Jan 2019
 07:05:36 +0000
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
Subject: [PATCH v3 3/5] usb: host: Stops USB controller init if PLL fails to
 lock
Thread-Topic: [PATCH v3 3/5] usb: host: Stops USB controller init if PLL fails
 to lock
Thread-Index: AQHUsuoKKdpWHwy+YEKqIOJMYFenYg==
Date:   Wed, 23 Jan 2019 07:05:36 +0000
Message-ID: <20190123070615.14462-3-yinbo.zhu@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5102;6:Bl03ocoV0aRKdUF9LTkY8dgioNRkWbwJVhvzVCbiCZjUo9f9Gf54uLRXk53u+SIKqtrqvBOQSrsiyaGm75e8/yV1AZb7EFjVvEdreP8inbgDxQSBQZDadv/HQcPP5KBLgXLThhfsSBNQlS5mCwbvrEOKg0JNLrWMzCJBsDaXDuRxIhkbk4qR1VZzxj63JgyBlQ8d1grp1y7chr9iKxZt/KBR5mgzCR21EfJiQoF/vOe11nwv0WxdabGhM6JAVdsWy0Chm5SiC2Kg+fcz8Vo6vEsqmn5My1d/FI4jmIHMs39r+k4x/Zi77v3hwkNBA5cb6tYRJpIG2fbSGvRR4T10t+MZseJ3km3zsZrEJ5/48bZbW75m1kEyNN2GZIqmwnxTdaBfetfHRir0e73XMfs6S1lGMT9yAi4eEi3Cc3lwUe/tRj8ukrNx/5MtsaOgcZVD+EX82s9bGeOsUF9hCEJ03A==;5:DfqKsNitMI+Vd0cTihcV1nZwmmzbky0m+1TyvH15vSE4J55EZ23rjyBVFWjHk5WwW8XRtLuwPyyz1ao07MX7N8+0EAz09M52HlY99d7OThv1wreAOWyw2BSK0VcUp5iIO0EVVDRvGOvPv6b0YEV3WfLEM1kw6gFy4zLZvTLU/zUlVKY6axeTil2waYp2YUhquPj1ft8Z7iJaHrm9xzibjQ==;7:36bCdUyopxj/vNH3wSF69CB6Qwbx43iemJSlOvHTtUhfGM0hEzObY9E4YbooJKyWE/jq3jMPjzhC7QO6UZyBRSq0ro6ItlVMSjmqBUbUnBx0/C9osNF5kg9v4bXd1st7jb/7sryS1jnY/GIyhDybGg==
x-ms-office365-filtering-correlation-id: 0c337b36-dbeb-449a-7325-08d681012c8b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5102;
x-ms-traffictypediagnostic: VI1PR04MB5102:
x-microsoft-antispam-prvs: <VI1PR04MB51020A1E28453FC0B3805CBBE9990@VI1PR04MB5102.eurprd04.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(136003)(396003)(39860400002)(199004)(189003)(478600001)(1076003)(2171002)(4326008)(14454004)(53936002)(186003)(44832011)(2616005)(446003)(3846002)(6116002)(11346002)(476003)(68736007)(25786009)(486006)(8676002)(81166006)(6506007)(386003)(81156014)(66066001)(8936002)(26005)(102836004)(86362001)(6916009)(76176011)(54906003)(256004)(14444005)(52116002)(6486002)(36756003)(2906002)(305945005)(105586002)(316002)(71190400001)(71200400001)(50226002)(97736004)(106356001)(7736002)(6436002)(6512007)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5102;H:VI1PR04MB4158.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s9tFnpnQ286Xeupgjggk8BT6pWKQPdztgW+MVBCa0qIRyCJo9LK//XPxnw1ha6TSevCxzxunaeLJDfomxss1o+/ARmFOlRSEhjaZtPHrNyjiSMyUo2v6MJtopARsBDfEY2lkdfmZcdcYdj22usJD2l/hwPgl2wNokkOd9LBgMIDsDl7eOvrkL3d0zqORfcqJMqw7vnw1qNxHbYqSAlYA0t/1zSh7RsqabEJtEhDI0Rmi47LxUVCNput6L62FhL02EwXINM+3MauGrVhF3nIzAKHXgGBzo1Qj/4mMWFCKaPLAbqLT19uLdXz2zuo8YQs9DKWBXkpfopcbX1LeW6WX5FpGKQyEOr5yYKtpHVabW/9wZlOycEkcY27gR+hMjdREPLbCrNYRQt78gA7kbnBFEPuOOSVG1C2pCCZ2qMPImNo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c337b36-dbeb-449a-7325-08d681012c8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 07:05:32.3978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5102
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
 drivers/usb/host/fsl-mph-dr-of.c |    4 ++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 8b0f3ed..e276067 100644
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
index 4f8b8a0..bdc8812 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -230,6 +230,10 @@ static int fsl_usb2_mph_dr_of_probe(struct platform_de=
vice *ofdev)
 	else
 		pdata->has_fsl_erratum_14 =3D 0;
=20
+	if (of_get_property(np, "fsl,erratum_a006918", NULL))
+		pdata->has_fsl_erratum_a006918 =3D 1;
+	else
+		pdata->has_fsl_erratum_a006918 =3D 0;
=20
 	/*
 	 * Determine whether phy_clk_valid needs to be checked
--=20
1.7.1

