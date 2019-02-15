Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DA5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E9E21927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KWcvUzKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbfBORsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:48:52 -0500
Received: from mail-eopbgr130050.outbound.protection.outlook.com ([40.107.13.50]:41470
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728030AbfBORss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtrEmcHgM/bH1bh2KybgVmJuURLvXK5o/Ua8MaHXjlk=;
 b=KWcvUzKolwBjSL02rO9gAPB8W4RYX2wM0eTldsbhRkZyF5gvICb4+ge3c8P+MebbIBHi3z6lrIX45EVPAoeK3oZKdusfIKrK2n31Y9yAclxgUY/rhl8kjF6yrLTDq8IXkCKREfiRhrlZB08SNbVk1AhlcJ+2vsi2z8ZbrTApW2c=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5330.eurprd04.prod.outlook.com (52.134.93.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 15 Feb 2019 17:48:44 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1601.023; Fri, 15 Feb 2019
 17:48:44 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        Rob Herring <robh@kernel.org>
CC:     Anson Huang <anson.huang@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 1/3] clk: imx: imx8mq: Fix the rate propagation for arm pll
Thread-Topic: [PATCH v2 1/3] clk: imx: imx8mq: Fix the rate propagation for
 arm pll
Thread-Index: AQHUxVaxagpP6ZoxDUewlg7OVff+Ug==
Date:   Fri, 15 Feb 2019 17:48:43 +0000
Message-ID: <1550252913-24532-2-git-send-email-abel.vesa@nxp.com>
References: <1550252913-24532-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1550252913-24532-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0502CA0009.eurprd05.prod.outlook.com
 (2603:10a6:209:1::22) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e18a302e-070d-451f-fa20-08d6936dd3e4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5330;
x-ms-traffictypediagnostic: AM0PR04MB5330:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB5330;23:YIJeNNlzDmYsFZWWjYUOGZFcL5qS1GjGz0V3gw5?=
 =?iso-8859-1?Q?cqYj5iB/7G3HwKmsCBQ7G7I45Vrh/hw+QDNIdIkbjrKLCbWGqWdBx16uMp?=
 =?iso-8859-1?Q?NW/Ryl/N+A8mc/LvpkATfLupLduX0eHrvOlr/gFi45FWaMZFzd9Yr+Qcfv?=
 =?iso-8859-1?Q?W7aOaMBlMUE10IJ0nLwOdJko4Eb0o/2Rl04J72fcfMXJQV/y/5FeemrNeE?=
 =?iso-8859-1?Q?j8YCRkq2ejFyxSvHBFcf5EO3W/gQDacPq9QWL5h0LDLo6wSOmrMcjNzwKh?=
 =?iso-8859-1?Q?mvAuJZx0uvaxbiOpYQoBzsUtp6h8KU0aGfZcOFNLMo8Rv3nOEgMynDcYEJ?=
 =?iso-8859-1?Q?r3eIFXcYmMVcfAOhbfzdEGqWEUwAQPmb6aum6BHdOR0UnTgwCaABqoug7h?=
 =?iso-8859-1?Q?xsN/Jvsxy9Lrv5IHvrryQnV92oX8FIhqEsBbgHSuCAzNxb7PYarBz9TotD?=
 =?iso-8859-1?Q?pUNQQNAoi7vClyvrVnto6awPgo5vy/f28NgqIbE59Z1TchEcOJYYO1ezGm?=
 =?iso-8859-1?Q?xSRsBAnsz2v5ugoYIpG9pxc9BT5jf7eYNwmj18VRkmR95E858B2GB2E5/h?=
 =?iso-8859-1?Q?9qYMRRT8SrEm2Jtqg9UCtYwDVIv7vQKP12HytquGX8v/h/QAPwPOoYqsMY?=
 =?iso-8859-1?Q?2N6yNB64P9eQPIIGCxGaRVRn66eo+M3rAxhOXZM2CJVCA58Mlx2hECsYXt?=
 =?iso-8859-1?Q?r9CrIVvHbowVF/IXjMNMHFzipgi5IM47gSw9KKDZLyEBiOqi4V8LTFaaML?=
 =?iso-8859-1?Q?ZEJdntsbIHxG5xn8QJ+9qLxEaUUJZypr3p0p6Hxz6iq3rYScX6ehGEioDZ?=
 =?iso-8859-1?Q?CQGQvoVx64YYqEFvkbuU2FErNfkWj2YfpPnXCHNBoiuG/mR+a3AqDL3TB7?=
 =?iso-8859-1?Q?hOzFH/uHArGbq2G+eOYxqvuBKzCOf237yStNMVib/kxDk5FGpiDAK2nFap?=
 =?iso-8859-1?Q?ESVSeJVnV5lBVPU1v2v31jqoX5aLSm2imoi7Fct31G9tWCiS+KRdEVIqDF?=
 =?iso-8859-1?Q?tpOkHQXQTG21b/uy0psKcNGxJcY9qxYUg0xaJFyfF/hrmjQ58we5G7Juxf?=
 =?iso-8859-1?Q?6tHyYHiEnB7unc5xBTwOMmxTd+ZaYM7oKGWsiTRgt+A5XGNWGvOTOJTy6t?=
 =?iso-8859-1?Q?OvOPXeTBW6IFQlRkq/Kw1JSk4cMpM9EygZOoS4Q/pcKGDnARiusE0bAS1R?=
 =?iso-8859-1?Q?aP3Jq1Y0Q3t1qFRb671+dkbUirv5mh2+/yH+/StXXN3rouzM0w/4c/BJfv?=
 =?iso-8859-1?Q?FTVTzOh9S8Zd2pMHAJDd2nQ+DRIS7iNawxuC2mXq+mVpP8GD9hn9BFbgRT?=
 =?iso-8859-1?Q?tw=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB5330679B1D840751C437EF28F6600@AM0PR04MB5330.eurprd04.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(346002)(396003)(376002)(199004)(189003)(6436002)(14454004)(6116002)(3846002)(97736004)(186003)(478600001)(476003)(110136005)(71200400001)(105586002)(106356001)(26005)(71190400001)(11346002)(68736007)(2616005)(86362001)(446003)(6486002)(50226002)(54906003)(316002)(44832011)(486006)(7416002)(99286004)(81166006)(81156014)(8676002)(53936002)(76176011)(8936002)(66066001)(386003)(6506007)(4326008)(36756003)(25786009)(52116002)(2906002)(305945005)(6512007)(256004)(14444005)(102836004)(7736002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5330;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WIFOJWeLXSwRM14pLHIlLFK015aDWk4k6TFuyyNVBjVkufjnrcWRfrXoZ+92tWPA/MiwT43wBpTVPq+YyS6qiaZEd/+HzGqzNMGx+jiC6KNKbfR0bekI7qU8xRiPPzAOY43kkxgvirwQAB4zm2d3VZhLxdqfwTNVqgE31LUVQI+kV1fnYw75PImc/ZQxRVDX6uxK6c3pwwsEQ/6RULRlFRddmS4MsJ2ZAStOE8DxRnNh5osau5WP4WA/DTORsWoiUTM7EM35f6B6GWwo3uVbJ4mCv/xOl//ZPzC6f0a5AxBx7zUmd2A9AXFOFlFajt6kv1426VN4JcfrlDD49iQreDkx4R7VvRQ1pAUQogd00uEYdyIrt48qYVhjCXaWPrEZbvhnok2jkbKg+KymkmVmUZGwypvBJDsFtFNyp2XKkRg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e18a302e-070d-451f-fa20-08d6936dd3e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 17:48:42.9036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5330
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm pll bypass needs to propagate the rate upwards
in order for the cpufreq to work.

Fixes: b80522040cd3f ("clk: imx: Add clock driver for i.MX8MQ CCM")
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/clk/imx/clk-imx8mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 398ab0b..57499ed 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -340,7 +340,7 @@ static int imx8mq_clocks_probe(struct platform_device *=
pdev)
 	clks[IMX8MQ_DRAM_PLL2_DIV] =3D imx_clk_divider("dram_pll2_div", "dram_pll=
2", base + 0x68, 1, 6);
=20
 	/* PLL bypass out */
-	clks[IMX8MQ_ARM_PLL_BYPASS] =3D imx_clk_mux("arm_pll_bypass", base + 0x28=
, 14, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels));
+	clks[IMX8MQ_ARM_PLL_BYPASS] =3D imx_clk_mux_flags("arm_pll_bypass", base =
+ 0x28, 14, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels), CLK_SE=
T_RATE_PARENT);
 	clks[IMX8MQ_GPU_PLL_BYPASS] =3D imx_clk_mux("gpu_pll_bypass", base + 0x18=
, 14, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels));
 	clks[IMX8MQ_VPU_PLL_BYPASS] =3D imx_clk_mux("vpu_pll_bypass", base + 0x20=
, 14, 1, vpu_pll_bypass_sels, ARRAY_SIZE(vpu_pll_bypass_sels));
 	clks[IMX8MQ_AUDIO_PLL1_BYPASS] =3D imx_clk_mux("audio_pll1_bypass", base =
+ 0x0, 14, 1, audio_pll1_bypass_sels, ARRAY_SIZE(audio_pll1_bypass_sels));
--=20
2.7.4

