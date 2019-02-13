Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B24C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217A2222D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XAG7OWEG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392418AbfBMTFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:05:21 -0500
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]:5779
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388403AbfBMTFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:05:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VdX3XCQQYS73cg+xTxB4qDqOUN6b4Kn+v3omrf9h3Y=;
 b=XAG7OWEG/Z4iWYoSee1P5TpAiul5iCu159maGNt4DZBntkQYHHYhTiGV2VcK7PQOsB2urvlbg0OzwoFO0qiTPVwWj0FUZJEvi4bNSdYvclz4gfjNFBrHFsJdP+KHZY655shE31cZJWQEmSqrPUetO338jUXmRBhwBkS4vk6Wi5Y=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4515.eurprd04.prod.outlook.com (52.135.148.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Wed, 13 Feb 2019 19:05:12 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1601.023; Wed, 13 Feb 2019
 19:05:12 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        Anson Huang <anson.huang@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 1/5] clk: imx: imx8mq: Fix the rate propagation for arm pll
Thread-Topic: [RFC 1/5] clk: imx: imx8mq: Fix the rate propagation for arm pll
Thread-Index: AQHUw88Lx/34yAmb5k+9Wv1v0WwQCQ==
Date:   Wed, 13 Feb 2019 19:05:12 +0000
Message-ID: <1550084693-9797-2-git-send-email-abel.vesa@nxp.com>
References: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1550084693-9797-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0058.eurprd07.prod.outlook.com
 (2603:10a6:203:2::20) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d0c03d7-6585-4249-6d04-08d691e62e1f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4515;
x-ms-traffictypediagnostic: AM0PR04MB4515:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB4515;23:ZUCDnGzxtslazZ+zfGJCaHN9KebZpCCxDzmrlK0?=
 =?iso-8859-1?Q?G6SVmE8y5/l1ADsYIB9gXGL7t8AWHCDXF2kfcrI4t8c5UZ33IHtCu003fu?=
 =?iso-8859-1?Q?Pwtrpegxym6oIPJ9/XAXUjOce9j8+9XI9ckVaLupZ2s9JmMxD6XkVr4o/f?=
 =?iso-8859-1?Q?+fVtRu7Ok3Bkr70mM2IdFLEjjDRonjphbydJ+U6rCqPaJftBzaSmbNiHR6?=
 =?iso-8859-1?Q?h0GqvMCpTaeprhK4/EqjuYHRlyMIp9kA8+GMhrmLu1G81rPj/r9z60DzaY?=
 =?iso-8859-1?Q?V7KTc7eILN5q8O81EiWzkVlUoOMV4HgtaMiE78jRAQQCN2zxhGtnTsQhu9?=
 =?iso-8859-1?Q?WN64V7yNtuoA8DpICA1LVn5b/oEvXv5Cud4fZsLXbUeYCysIkJf/wffHf0?=
 =?iso-8859-1?Q?Ssy0zbYmTmc+iQT2tP8oCaTxk13fsP4pXSjsfp1kXej3rNk+I02WQt0cy3?=
 =?iso-8859-1?Q?yvNNpCHYrKAhTfBv/qQdq/UZV57WXAHcH1X80ia1leCdY14zKgGS3WIQPS?=
 =?iso-8859-1?Q?sbuRAAfu1Adju9DUmfhBEjku038q2njriAmnL8sECE/ypiFjuhz6my3edr?=
 =?iso-8859-1?Q?k70v49lgACNayiPwe35Xs//deY023EN1Jv1bXJ7uds+8kGL26wnt9uJasN?=
 =?iso-8859-1?Q?X9WCzlm6MKLYjLLFXqYm+FOUWzhr4cjP2JKB6iKUMz7dP1FqICax3cojtQ?=
 =?iso-8859-1?Q?JP50wTd0oh+ZFODMm3pMRTDBp1srxIGrrYm9VbkYYu7nBRVAccXS5ZxJwg?=
 =?iso-8859-1?Q?8pmt3wodYf1HydXYnqheLQxEZNs2P5eodRJbWU7+HTfvcMCI4ft0wZKlKM?=
 =?iso-8859-1?Q?pDo5o1y+6pMecIrbqR5OBqCyiOEgP3WJZkNf+j9lTgo8qxUt/0ZF8EyYgq?=
 =?iso-8859-1?Q?4JrKOz2hH/euBO18N/VkTs3mCvxVYeRw4TLUTRidr9C0ATVvBJYId0cPQZ?=
 =?iso-8859-1?Q?5Ff61K9WyMIMaceQnLlO+nWXlA4JI3FVSbJpFaSssf876EeylwEjwJ7Aii?=
 =?iso-8859-1?Q?JIiCmdlFJ294Ws7t3fS54CchlnNktLU1ClOein82QG68c5LdJ4GrmhktpA?=
 =?iso-8859-1?Q?iKQC4N/gpdIlLJr1qSW84wZ3xSQ5pwjNLyDpbxlwpNfEOauLs7inl1h+zo?=
 =?iso-8859-1?Q?zo64wMf6yvr6EbjQV7iKarr+WlXB99Vo3Z3HHDtBs7MtNAnNAVeliButal?=
 =?iso-8859-1?Q?M+5Iyf4lfhblKQT82aw2EKfJXhGnXxPbHIe22OXgha+KBDWgcV9vUcut+W?=
 =?iso-8859-1?Q?2P6UnzCSdmJv4KDxAmbeRuvSa9ESH4Be3QLvBvrGlE8Ow5R8lDgk6XV6Iu?=
 =?iso-8859-1?Q?x4BC9802NTT42Mfwvx+Crz/?=
x-microsoft-antispam-prvs: <AM0PR04MB451564C4BBA74EFC6D0CD28DF6660@AM0PR04MB4515.eurprd04.prod.outlook.com>
x-forefront-prvs: 094700CA91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(366004)(199004)(189003)(4326008)(52116002)(2906002)(6636002)(3846002)(6116002)(99286004)(106356001)(105586002)(7736002)(305945005)(25786009)(97736004)(14454004)(66066001)(53936002)(8676002)(81156014)(81166006)(68736007)(36756003)(8936002)(478600001)(6486002)(6436002)(6512007)(50226002)(110136005)(54906003)(316002)(486006)(186003)(2616005)(476003)(14444005)(256004)(26005)(102836004)(11346002)(446003)(71200400001)(71190400001)(7416002)(6506007)(76176011)(86362001)(386003)(44832011)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4515;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vwi6uj9bNxifdLmqh19BimaNcnEaOSScqHu/dv2qIWLisGFKqbS3wGz0bMUp1fg7v84ThWer5gCCMhrv0Nd0ybHo5Ib2Xk8m7xrzmi91wddqoAWu+RMgO7qXgbB6SZmosuPMaaRZwpl1Qwq2lchEwW6A/JrmW7/K56Ko+IyYDQ/QAh4w1jyzI2G9NR+9JkXFuanJweGG/9ntIz/Odm6nyiQt0rU1kKL+yapY9zPhFjQnglZwESh0CE410j04CjRCYPM1zVpdP892DMGWQO9nvg5CYeDkAxgH9/VKn/rmjRNZIqyXZGjmbmOxj8FwTWnEXxQj7Jos1sV3mggLHzcNZ1eShG09P8pHbzVdFxwjiSA95LFyDc4QgvXjR4Dc3T7W9QlmPv5BCvzm5CubWgwtWgXkVnBLB1AYE1/Q8aDZKXU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0c03d7-6585-4249-6d04-08d691e62e1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2019 19:05:11.4876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4515
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm pll bypass needs to propagate the rate upwards
in order for the cpufreq to work.

Fixes: b80522040cd3f ("clk: imx: Add clock driver for i.MX8MQ CCM")
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
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

