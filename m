Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4021C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A6D20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="H0yyq8R2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A6D20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbeIGFPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:42 -0400
Received: from mail-sn1nam02on0091.outbound.protection.outlook.com ([104.47.36.91]:3440
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726596AbeIGFPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJsi6zuOfY+fLEoIeWr0oIIYdfe0rEs/NVrkGJ2sJVU=;
 b=H0yyq8R2fXnzoh+vbYDMQbQBV3vJPCMHSuVV266BEHyAYWWVX+J5jksvGG5uxh9wmiskJUscofCG38rIROJ3PR0ot8fq9HV+AWMi7xNj8WeP4/g0mUpAci0pTKmCfD8Y0PP8lcCu358tSlbSR31CV9EYqAa4JVwk24hZ8mpqd+g=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0118.namprd21.prod.outlook.com (10.173.189.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:37:31 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:31 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Leonard Crestez <leonard.crestez@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 65/88] reset: imx7: Fix always writing bits as 0
Thread-Topic: [PATCH AUTOSEL 4.18 65/88] reset: imx7: Fix always writing bits
 as 0
Thread-Index: AQHURkLWRfdvEAQudEymjRGQNxEFHA==
Date:   Fri, 7 Sep 2018 00:36:38 +0000
Message-ID: <20180907003547.57567-65-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0118;6:asjzxdL9HGuAD4JsZT7LQHHcVcel+nRhjM6vjtTFMcmJ33hLRiIepjGTCigI7cdiBiBadoaF6rgwq1lYvBdozoH5YtiQXmOQTkTJHJe+5OayX1w6t80WimHUUeiT2TxD2XK7kCTOXHrfrWoEJKnNw9e1OaHNPma8DH5lfw5FDx8L4TO8P2CJ7G7bcecmym7+N1ld8U74G8U0Lm4fj6YV1DYFz3DqKeUfEZtv31qR4NWS9jxNBeMZ6AGdaV2qhwdIbcrNfMg8Wjxy+Cb97qYPOuy9JSsX7N4n074EZN/23SDwuj1S1Z/cgMUUXsrehu1YtjMvBFT53ZbN8C9A9aLdDq3ZKx1+L+/JgNpTZ+vAEVMLko3d+5xOoBFkJ1J5Lo65GDM54MCRHdkC9jJYSmGZP51hZ5alrjs3UOiVNWSDp3e9f5R7XAAupZbPl36yznGA58HECnIvhjdQtxLJuNMp2A==;5:iYz6sMsB5mGi2K6gvkk8adMnYVDjS4124CBTedUuchOkTHUYyt4urja6l1IFScrqm6OGlHQjikVKCpITA4NVBwIux4yKBA1GI09256aqdshLq8iz+n+YoqSpLGCoa0mlTQ9QTN6SPztMSxOc1wP/rI1oE092GzXEuCH0hC4kZJU=;7:4oxZaNj8UUztCBV2QsiwLta+iNh8vUajDz6bfE80Q0bKltR2Ko67f9izlIZEN2iskRhnUwu6jm+H99pKwbhRfb660xmGH4beE32OmyhPqKjiNWZMNy8+BhkuFOfq+28HfBdpXEVHZUAuZiwiqsZsMvPkCtxK3pEH2nSY5YxpmPO6T7kOzgclwdyGHHMXKl27FH/n2A6LnFXupV/ZWzuJIG44Vdxf7A41JZ6jQqpnKbGbNeeL2KVV0uWKvvC1JWwB
x-ms-office365-filtering-correlation-id: 37c2a333-77d6-402c-1efd-08d6145a1912
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0118;
x-ms-traffictypediagnostic: CY4PR21MB0118:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0118B5FC8E673B8A5504F2D4FB000@CY4PR21MB0118.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0118;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0118;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(39860400002)(136003)(366004)(189003)(199004)(97736004)(2900100001)(53936002)(316002)(86612001)(25786009)(86362001)(2906002)(6512007)(68736007)(110136005)(54906003)(107886003)(4326008)(10290500003)(14454004)(81156014)(81166006)(66066001)(8936002)(8676002)(478600001)(6116002)(3846002)(72206003)(305945005)(7736002)(1076002)(106356001)(105586002)(36756003)(99286004)(186003)(26005)(5250100002)(14444005)(446003)(256004)(217873002)(10090500001)(76176011)(5660300001)(6436002)(11346002)(6486002)(6506007)(102836004)(2501003)(22452003)(476003)(486006)(2616005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0118;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: M4p7HvuFcdf024YEEYWNhCOuLvp5pfiycaUlnM1C7LjRBEp3zc9PnpI3PrdWQfXfOGixPu37kehyHG+pxIQF5jCIqjTKBlGlHTWHQER8cswJFf+61x4ybsXlxQhEfAEPs1ye40vWDGw4/JXd395bDnzBm3TVbGsmoJu6urbjG5GMbkTu5zC49kWR1NDd+zhZdxMw6c+eGdwhe8qsbQHBTi1xFxX0e7m89IZddarskH92bI2OAPFF741xEuIaZbFS6jyI7pQg988HbIgj5NkyLPF1dGYpchOwYsZylkE+qtxOqEjg4Ww0z2xna8NqTjuVLMsjvFWViFS4jhRm/d/LmhVjJjCI/MSUSmMxYjcElig=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c2a333-77d6-402c-1efd-08d6145a1912
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:38.8903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

[ Upstream commit 26fce0557fa639fb7bbc33e31a57cff7df25c3a0 ]

Right now the only user of reset-imx7 is pci-imx6 and the
reset_control_assert and deassert calls on pciephy_reset don't toggle
the PCIEPHY_BTN and PCIEPHY_G_RST bits as expected. Fix this by writing
1 or 0 respectively.

The reference manual is not very clear regarding SRC_PCIEPHY_RCR but for
other registers like MIPIPHY and HSICPHY the bits are explicitly
documented as "1 means assert, 0 means deassert".

The values are still reversed for IMX7_RESET_PCIE_CTRL_APPS_EN.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/reset/reset-imx7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index 4db177bc89bc..fdeac1946429 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -80,7 +80,7 @@ static int imx7_reset_set(struct reset_controller_dev *rc=
dev,
 {
 	struct imx7_src *imx7src =3D to_imx7_src(rcdev);
 	const struct imx7_src_signal *signal =3D &imx7_src_signals[id];
-	unsigned int value =3D 0;
+	unsigned int value =3D assert ? signal->bit : 0;
=20
 	switch (id) {
 	case IMX7_RESET_PCIEPHY:
--=20
2.17.1
