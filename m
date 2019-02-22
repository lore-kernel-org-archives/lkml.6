Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEFDC10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747802077B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ip80BSJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfBVJma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:42:30 -0500
Received: from mail-eopbgr60064.outbound.protection.outlook.com ([40.107.6.64]:37905
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbfBVJm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wCXjZWWTXpTq/Jkjq25DkWcAajMly9q6Le+yHkubYY=;
 b=Ip80BSJ68zJU/wgWrURaiahoQ6f3LPmJj25mhslQ/XG4PX1qxyrJmwiP4+tOplCsTnKVqZCx4pdOa0gF14XBBGMPsNQVoKqEIrTZiTOKaBDot/dOK9iGAzbcyzsNuUICG1jaTv5yRyynIQpcyXA4qq07AchnIY2Pqjgcz8MpaQ8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3756.eurprd04.prod.outlook.com (52.134.73.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 22 Feb 2019 09:42:22 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.016; Fri, 22 Feb 2019
 09:42:22 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/3] clk: imx8mq: initialize clock tree earlier
Thread-Topic: [PATCH 1/3] clk: imx8mq: initialize clock tree earlier
Thread-Index: AQHUypLopgE4RdwU6k2TGErI1f+TZw==
Date:   Fri, 22 Feb 2019 09:42:22 +0000
Message-ID: <1550828264-9962-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0161.apcprd02.prod.outlook.com
 (2603:1096:201:1f::21) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b550de65-dcaf-4b87-16ea-08d698aa0b45
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3756;
x-ms-traffictypediagnostic: DB3PR0402MB3756:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3756;23:j1BliHKcQScUS+/zGynQUx145Q2+OFt4j9oF8?=
 =?iso-8859-1?Q?A7F+94rPaUKeiXtKf5QiJn8JQoAcjVR7AGrbPJZA/hI9ckwQ7XuI6B8P+v?=
 =?iso-8859-1?Q?BAjEtYp3Ha7vwuZ2A4hLZJMGzjyfYOxFg6O58qCBZlnjemCiKKlWiFUa4R?=
 =?iso-8859-1?Q?Dr7IO2b7M85+dPJqgPNHwSCm/voojpbHecaAEWjKqSnI86h1e/mly1n8iG?=
 =?iso-8859-1?Q?Nxr9sSsxLwbWKjwIRjWPb24/yHeVzTDdSoMhL3nRYU864RLJh8uu+6ZwjC?=
 =?iso-8859-1?Q?QZ8gNBqGBzymt7GCQx6ea3JNIsfzQTNWzkcUItGmT4I14jHZmdH5nXa+zn?=
 =?iso-8859-1?Q?JX7IzL7c/rDtc4rE2wFxaj8fM6V/r4BgfCYDadAoKitnHjKGFY7aRX1jmM?=
 =?iso-8859-1?Q?iaT7hF8mfiQPc0V+bgUeEwkiCJsoJ32m8WO80we4TzfYRqlWRXER9UuWld?=
 =?iso-8859-1?Q?9i0vYkaEs3Cd3TgCnUZQFp/ZGb1CUkJmf59LSfTLk4oCobAbAh5iE1v7rZ?=
 =?iso-8859-1?Q?glFyUhyYIogZhQiqTA6AdbuTJ+YSW3DXJNW52WBBx/fQhBWtO6rEWXh+Vv?=
 =?iso-8859-1?Q?d0f/MfJHzQM0XEw2t1M1HY4hAD2Mo94z2rj8U22iNQPEa+U3mRguAK0RIR?=
 =?iso-8859-1?Q?dVJt2eskwkfYYy4YyGlIM7gh198ocQUH85g8pAZ7CNyqsJMiu/F5p45V58?=
 =?iso-8859-1?Q?h8P8au4CzyEo0lGC1V8eltN1mMPty5fMjUVXCCVr9ChupUGCOdeSDyATqj?=
 =?iso-8859-1?Q?3nByrtqL1TBaVIlX4fXsYJpJunyvq4FZM9ov56KfeRbbgkKBF8PwshamgX?=
 =?iso-8859-1?Q?gF0vP29I9FrhZORM1CTpdqFwfD3jnWX5m+Fnv/Q+Xh3OqtlkxnD3RCQJ3G?=
 =?iso-8859-1?Q?SHADuhIHStHKjTAwn5Ok3hhEeA5kt3j6jgkc+Z4swng3ZKWIw5qGutae7O?=
 =?iso-8859-1?Q?aDujTh2ibBb7nTAc6e86zrrmZIqTpUrAl6H2sZbGAu1Dlokf+wjfu2/R0Q?=
 =?iso-8859-1?Q?3sohUb26pvdXO5qlfphuSC2ogeF09MF+h2upwobnZFxn+THjGDZmcxUV0b?=
 =?iso-8859-1?Q?nUcMS+1TSgmay+Fu28/lW154wh4mVfoUqdJj0+H/rmnqNXEw9F23xMh7ka?=
 =?iso-8859-1?Q?sbT2gJ5GBZMdt0mFbHRqsvf8S8+V007t/5G/cvk1zbrxigKqAf7lrNvvYu?=
 =?iso-8859-1?Q?cC1J7RZjAvG0PmKOdO2JggOLMzSC4661f8BcHZ9DeDpNdtS7a77VZN+Do2?=
 =?iso-8859-1?Q?ZrDvQxl8zacyi/bQToLhSxU7B3IxqbSsGiUzbGtUg=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3756A35E01D94D3E015DB67DF57F0@DB3PR0402MB3756.eurprd04.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(366004)(136003)(199004)(189003)(476003)(14454004)(102836004)(106356001)(478600001)(486006)(186003)(316002)(2616005)(99286004)(386003)(105586002)(6506007)(52116002)(26005)(2501003)(66066001)(2906002)(110136005)(68736007)(97736004)(36756003)(7416002)(5660300002)(8936002)(256004)(50226002)(25786009)(6486002)(71190400001)(71200400001)(86362001)(6116002)(53936002)(3846002)(305945005)(6436002)(81166006)(81156014)(8676002)(7736002)(6512007)(4326008)(2201001)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3756;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KSS9Y5WploMXhQKab8E6O3NcX7C5Mte0HRlQNZFmIpBwDbguJh1HFgNEfmAxAFuGIZc0NsTZXGKUSiW6cdtbzKPhZ/r1NyVJdbix1b38riTFcY3u94knUr6MHtJxjUt+zRKaefHNbNoknZnz28dIoD9uG5oENnYNE5dGimI+3SW8Okb99nUKKW4bQ4kuOxQzmmGFfwOq4pZ/dq04kwD6Q15wLz+m27UQ86JaAxl1HTe0SLM3cj1rkLyYEG3+g+WiL33Wox2rADDRtRL4uhBTf0T3TBw56snIy1MfFBONMb/bPHMIlbtlEiFTYLif/D0/EvrfuYHJPeFeILA68o4YiwBlABR3YYHNmhWJBL24YI+rES29GMytndVTRx+sIYDbqy0QLqM8ZRcpgpWFwk7CU9TRpP7a3ymTs9mQ7CvgidA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b550de65-dcaf-4b87-16ea-08d698aa0b45
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 09:42:16.8986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on i.MX8MQ platform, clock driver is probed
later than GPIO driver, and GPIO driver does NOT have
defer probe mechanism since the GPIO clock is optional,
some platforms have GPIO clocks and some are NOT. So
it is an issue that on i.MX8MQ platform, there are GPIO
clocks defined, but due to clock tree is NOT ready during
GPIO driver probe, the GPIO clock management will fail
and cause system hang if GPIO clocks are OFF by default.

This patch changes the i.MX8MQ clock tree initialization
using CLK_OF_DECLARE instead of platform driver model to
make clock tree ready earlier than GPIO driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx8mq.c | 33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 26b57f4..2df1575 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -269,10 +269,9 @@ static const char *imx8mq_clko2_sels[] =3D {"osc_25m",=
 "sys2_pll_200m", "sys1_pll_
=20
 static struct clk_onecell_data clk_data;
=20
-static int imx8mq_clocks_probe(struct platform_device *pdev)
+static void __init imx8mq_clocks_init(struct device_node *np)
 {
-	struct device *dev =3D &pdev->dev;
-	struct device_node *np =3D dev->of_node;
+	struct device_node *anatop_np;
 	void __iomem *base;
 	int err;
 	int i;
@@ -286,10 +285,10 @@ static int imx8mq_clocks_probe(struct platform_device=
 *pdev)
 	clks[IMX8MQ_CLK_EXT3] =3D of_clk_get_by_name(np, "clk_ext3");
 	clks[IMX8MQ_CLK_EXT4] =3D of_clk_get_by_name(np, "clk_ext4");
=20
-	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx8mq-anatop");
-	base =3D of_iomap(np, 0);
+	anatop_np =3D of_find_compatible_node(NULL, NULL, "fsl,imx8mq-anatop");
+	base =3D of_iomap(anatop_np, 0);
 	if (WARN_ON(!base))
-		return -ENOMEM;
+		return;
=20
 	clks[IMX8MQ_ARM_PLL_REF_SEL] =3D imx_clk_mux("arm_pll_ref_sel", base + 0x=
28, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
 	clks[IMX8MQ_GPU_PLL_REF_SEL] =3D imx_clk_mux("gpu_pll_ref_sel", base + 0x=
18, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
@@ -389,10 +388,9 @@ static int imx8mq_clocks_probe(struct platform_device =
*pdev)
 	clks[IMX8MQ_SYS2_PLL_500M] =3D imx_clk_fixed_factor("sys2_pll_500m", "sys=
2_pll_out", 1, 2);
 	clks[IMX8MQ_SYS2_PLL_1000M] =3D imx_clk_fixed_factor("sys2_pll_1000m", "s=
ys2_pll_out", 1, 1);
=20
-	np =3D dev->of_node;
 	base =3D of_iomap(np, 0);
 	if (WARN_ON(!base))
-		return -ENOMEM;
+		return;
=20
 	/* CORE */
 	clks[IMX8MQ_CLK_A53_SRC] =3D imx_clk_mux2("arm_a53_src", base + 0x8000, 2=
4, 3, imx8mq_a53_sels, ARRAY_SIZE(imx8mq_a53_sels));
@@ -568,22 +566,5 @@ static int imx8mq_clocks_probe(struct platform_device =
*pdev)
=20
 	err =3D of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
 	WARN_ON(err);
-
-	return err;
 }
-
-static const struct of_device_id imx8mq_clk_of_match[] =3D {
-	{ .compatible =3D "fsl,imx8mq-ccm" },
-	{ /* Sentinel */ },
-};
-MODULE_DEVICE_TABLE(of, imx8mq_clk_of_match);
-
-
-static struct platform_driver imx8mq_clk_driver =3D {
-	.probe =3D imx8mq_clocks_probe,
-	.driver =3D {
-		.name =3D "imx8mq-ccm",
-		.of_match_table =3D of_match_ptr(imx8mq_clk_of_match),
-	},
-};
-module_platform_driver(imx8mq_clk_driver);
+CLK_OF_DECLARE(imx8mq, "fsl,imx8mq-ccm", imx8mq_clocks_init);
--=20
2.7.4

