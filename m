Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B56C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453F723DD1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="meGtpnuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453F723DD1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751341AbeFVGgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 02:36:54 -0400
Received: from mail-he1eur01on0058.outbound.protection.outlook.com ([104.47.0.58]:19671
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751291AbeFVGgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 02:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7zKcKW0dgUD1Alx0+prru+eIVE/nUMSWbtnCULeO5E=;
 b=meGtpnuPzBn4mfRSXbK+SFH6vz8VmwVdHL8iWfT+Q9hwhn1U18dPqJaqoSLEiWbuep6rQHjJg2fMqkWdczRVJ2vEQOjjcZH90BdbAeqQw6pIwh/iW0eEfjM6DPwvxAqJvcAw/+3191CN/+Xb7hLs6kYt/uad9h9XsRcdh9XK4Lc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 HE1PR04MB1321.eurprd04.prod.outlook.com (2a01:111:e400:5889::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Fri, 22 Jun
 2018 06:36:38 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@kernel.org, aisheng.dong@nxp.com,
        ping.bai@nxp.com
Cc:     Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 1/2] clk: imx6sll: add GPIO LPCGs
Date:   Fri, 22 Jun 2018 14:32:33 +0800
Message-Id: <1529649154-5724-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:36::24) To HE1PR04MB1321.eurprd04.prod.outlook.com
 (2a01:111:e400:5889::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28ae1c85-fa8c-4262-7226-08d5d80a84b9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1321;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1321;3:IJunh27EnX5vTW7fhz+7IVt01nH8Dw7tYRoc3HtKcVuvyf5lVYRqby6FtSTSJcjfJwiCrxfLziMhJG+ZCGqFzmih5he5xV8P5qCJUWJ9gf5/yyi3F4041i38Ar9/0GowkQqkOOOzrTMppBZ2USCQYLsRld9WKGhVgRqnnCBWZoK+LqXt2Pnw1Bo1dIj4slaYxNJQehhnvzFHUBNPJZ6SvOqwz7D36hj1zbgmj1wGZuNqz05Z6suURAoUHwnOvJE+;25:BK8vlS3BheeHTDGeFb6FlQWTiL1N/czRZ4yjVEdiOUTMxbbVH6iQEmhr0MlWLExaGKndIb0DstuEZdvXWRaf2rKq8QrbTXLJhVIaGrxqTWRTHS/P7WUmVqtrWRI9fLqE3ZO2x4pHpj96jLrPOUyLSyK8Dxx3zvmfmaeRuWlUrlDTMaz23CEFD4Ox5Z68ElX6SFiYJSRqU5HyFhcyP++/W1yshaWmBh9wAnrjA0/ugppbED6CvoJiDT/BBOwNYRA8l9kElfPRCh2BwABQ5XBZM2i+el8HBDX/SrUDQHMuPqwmC6L4DOU577P7pl64395nvy8WiMUjcbOixCwzFcd/DQ==;31:OrVPI9yfKfpZ2iPstdSmEK0ubr+gmnRQx5XQrnHSYqP2qufs6Es5Gm1UIZnyOlobHb3Z99ihO0Ehxx18Im2wNcZJofewE/es9N5jAGqAalE2EInr4PKFjmIYxd/KJOZ1E7ZiSccSMYiC9UKoaJj0VmRVodagevpG4AXrmoZ4yiGR+Lx8MAmCuBQrcGRN3B21InisH50qbNglZVVUSPhF7c+B8XR/4Gye8qOASfkyH2g=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1321:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1321;20:h4Di5pekTZiRzpjZ42P31mqGUeneeuFPct8AQj464xu/0lIMk5krBZ96Pt+2p/814Q5lOXLnBjxjAbSemn7tUwrKsAb9FPfgv/3ZIgY1ZDjzy2YD6U6Eka0b8x9X2csC4QklwEUy80UadoTTXKnv92oVhblsjX0eJAFKC+CAoXfUAFI+5eNqyVTUGdtSzEMBJ9RWjJjLiQVRcc7cl3+S8P+Tni270Mge9ft0deRKDMLJo6/JCPOmh6cy6EjdO97sNx2F+JTgigYefmysNEfAjnYrDJW/xR44EMXejwZRLnzQVkEFO5TfZQpEVqEVzTuXWP52BdhoZ9StBd7UwQhxDjFu0/UvZaE01SUomVk6f6ZoTOnAG0dWTnfhEVtBB1D/Iecn4U8UKFBmkymdLYb2W7EJYTTqANHBLCnSOBp/OqGsuK6xBGJzNXAY/xQD1WNSXqbuhwGwdp5hm/W0SQrH+UTq34OGJ6yiWt/5I7v5LXdPoaKnRCy685l8z/dZrQui;4:CLsglv0q7K7gL2hbhjfQOosq92cc5Xm7SaIzekbatRRKSFEa6zFBGp8fQYoop0inc5OYVongCgfVpeoH4hVJJngxnbYM/lfqPq2C3a+ZNYAwKfqTNLhZFswoQESavjPmvkAZ4ocSD6UmbWzRu9Ktjvfr8+PTGWFw0tAMSvJ9s6EED4UqJ7/Q9u7fRon4FE8OZuE40BqC2mjpDjl46d0sLxSmbrUD6GmgAt/KRdu1rfjd7kMb1Km8mn9EViwM//sqbIAPEv2RERTOq/VTQiuPR/zJlyauDHnNkIhzaKhv2VDlZ7oA1s4NkZ382ahZwDPQ
X-Microsoft-Antispam-PRVS: <HE1PR04MB132176CC7FF69345288D1F54F5750@HE1PR04MB1321.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1321;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1321;
X-Forefront-PRVS: 071156160B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(366004)(39860400002)(376002)(396003)(199004)(189003)(16586007)(50466002)(97736004)(956004)(2616005)(8936002)(476003)(6666003)(2906002)(6636002)(6486002)(48376002)(478600001)(50226002)(316002)(486006)(305945005)(186003)(5660300001)(7416002)(106356001)(6506007)(52116002)(7736002)(4326008)(25786009)(386003)(36756003)(86362001)(53936002)(47776003)(81156014)(6512007)(3846002)(8676002)(6116002)(81166006)(68736007)(26005)(66066001)(105586002)(16526019)(51416003)(59450400001)(17423001)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1321;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1321;23:M41yk96Awnx9j0RNBdYR7Gxj3P/tyV89h8w4I2Jgp?=
 =?us-ascii?Q?gjJEogCV3V8vFOfHHy3SkY8iQfWzLgq+5cqZWXuydu57C5twzA4uJ6LJP2cs?=
 =?us-ascii?Q?q0mTpqxhQVvgs++LMO5kng01e1VjChQPN/FCWzhxuEnZijkYKOMSmcYP4mIU?=
 =?us-ascii?Q?qYoyHnWQxZucbACcqT32OwRbC30rsUwItxHPaJb3H6JrYh3tnc3PFZ/qkz6L?=
 =?us-ascii?Q?LkZa+kQtSBFx0z+UZ08NUMhruD8KgGYft4m+n9gDMa50BN1farJ4wNDm68a0?=
 =?us-ascii?Q?RKsoXFbmjXx4k6kNae5JRdcKtO5hfA8YABrrSYO/k2aN0cmQkDL1lCxnr1e3?=
 =?us-ascii?Q?DApvbAyszR7wMSv0qDmytMHKNQBYSzN66M9Mk4bo777/i2o7nUr2iDMi0fqe?=
 =?us-ascii?Q?aLrlDWNAYncW49nCPOaxZZ+fKbI4XaYfEbWc5Hm18q+A3vmJWv+OM/nxo1pW?=
 =?us-ascii?Q?M2GyRXcZ/DVhjtEUuK3OU658r7wok+8vaN3JsQCfB8+0FosUFPRLqJebty4c?=
 =?us-ascii?Q?QkMrBc2wQEaUtMNbeiNtvyToXDFFM4bddbRvC+9Pmt4sjGqVCf0R4dC72MMN?=
 =?us-ascii?Q?d575/D40bnDL2pYoxEnBSYS2BbdYZFMGbqetwqb1mkQ3q1Ek1MlY65ZD92DL?=
 =?us-ascii?Q?gr8nASLDH3VRKf+un2O9powLHBt7sobruBIiX4xAmb1yMSXn3jR2RymTwfC5?=
 =?us-ascii?Q?CV+7rCJzz6A/bACuFVNuRQbm+HDAvxYkFjpIWAVZ3ArCE7cjFnpbHGsAWu7G?=
 =?us-ascii?Q?ZffzdsNu2cX6rFQZBgOAy0ChNJtt/zabuxHp+tfvWntc8jrstxTAIhMtFi/b?=
 =?us-ascii?Q?QA8hfHnyyruWAHGeXjcWjYfVfw7FF9tB9t0sAeLjKEMWQnLcorEXRNuUa9XB?=
 =?us-ascii?Q?KJUP5m1QaQ4zqw25rPc8Mr8weug1dm67hvSibYbxTUiOsMNmbwBGYuI4BV+i?=
 =?us-ascii?Q?nNUKB/RqmhcQgRycERyQ/72gWZjgZFscCwp+yfbt2C24Ayw/Ix4KdAJ4u/aW?=
 =?us-ascii?Q?jBTb7wnmeIgmHI7U0tNON3F84gm+rs3SQefPh84YhlgNzlGv4RDsKP1jAj8r?=
 =?us-ascii?Q?tmQ1OHYYSDSECP8+JYSIGmLNCzehJTpoiYrjmtm7vDWsp8Ao1FzLbBeCj0HA?=
 =?us-ascii?Q?rIetAcBZTvNnLb/WsAGk7QkqfdGm0QvFTK2PUBn9udVhAWIZ+aHWGKiWIfNH?=
 =?us-ascii?Q?3H2kbNIu35bl4SVrwXbUronAEiXOe057abxFCPvyvi4PyeVVqk2viaFkkvmv?=
 =?us-ascii?Q?RPkL0WL7+56KfuQphc=3D?=
X-Microsoft-Antispam-Message-Info: LQH7ja4JeDN3F56pgCbFISaiSogs7EMMneyqJ46suFS06zLrbQlGCWw0vahK65vxeQzds369SaZYG2SzcSh+yNtMiD4ew/o3rp/QRO49AJIVhoilP7GZhVBUKLoK/mihkOGQq9whRzhPcf+E2ymFO62z8wP9nWweqvocgbeE+qxvGwMDTUJUjBcpiKNoRqhbGJzDT7DZNRCK3MJWzzfP1Lyq5rSQDNvFCmIvRB3lVEsysVAOawb8z58QoftrRGX4sF9+IpdAatmSlGYzVjt9ee27YGYb9EF9cWejhn19hy58uz/Cj499j7vHjbqWnjdkxNtvUlhqiviDOgeboQmWpw==
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1321;6:f6HPep0sDC7moS20XMVEIRwYpJrVdpSnMYDY2qNuIrQSz+U0gZPPZL5m01FL01rpQYrHLUsdU2IiYccjjA10a4TmPWPDjG0hm+FXdxx5USI2mIycH5u5zcMWA4m3CaZjl2HX1FCmFFG9RxMraSzPrBuAo9C3IKz/aORfII4UJ6D1wWyvGEWLRNquObEjbD8KShRJvdoQL9pjJeVm77w3Fn9KYhahnAOnoE+16WCqp65CjSwXDB7R311p9uo69iqvYybTj9ZBQnqM2xeVIhS9KjxLJA1M8xsCCZhX02LEkFjgGwguHN+GacHKlQJYpXxVotcnSUFTCzvPHvBJcjgwr6LhYnzHa36ByfJ17DFv68zYd+xHVoi92NCTfUPyRocjEV+buJ+kHRcEhU/lDrtUAOMFPnL1LE/AWVXcXId0XFRhvFPIYrEue5gRetZxnqp7VmTlU0Tpj+zPqph/5Eqd8A==;5:3DrmBKP+Kk/e5990nEbWi86RklBzvL3wBftDtI+fYay6EdmD5jBV+TasWScA7Bu4MR//I52ZsAV7tr9xTjP0Q9ZKs+xMdXzr2pW/jBiUr2Ba6iMTc6Qz9NY8Se9T+EZNezH+TQb3dNsTvcc8fSldgdkvSARcGCKv+2Qhfbfofmc=;24:P/BP43r2jyF6K/8oqXW6U0qtg93lG1lWHBzYShI38hfQ1jg+LmJOysRyL22lGQq0f/Lxw16OOuTAKI7OplKdNcHCBHlmBTX/KMO6Bz2bWfc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1321;7:+oXJ4ll83PV+3pLhz/hO1hO7AEvxBgDhswzVvpaZUuqbGg7kWns71j/p486Rt3ZbK/ewUvz9J6c5ksjfbd4hhSHl/KguXBqGIX8/cwr3GJ795lbeeJiVBSGMPZ93mG0E5o4yGLOY3C0YrqeyyIXR9rj4LcCkDo2VJV+s2KzfthJ2Qef0y4YKqv71V4dGq7/JPuB71cvlvWGwy+FH4o4LSMRX3W0HUfPlSnLUwd1J8WdqznJBp4GsCDUe+o6fgX/E
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2018 06:36:38.3539
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ae1c85-fa8c-4262-7226-08d5d80a84b9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1321
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Reference Manual Rev.0, 06/2017,
there are GPIO LPCGs defined in CCM CCGRs,
add them into clock tree.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx6sll.c             | 6 ++++++
 include/dt-bindings/clock/imx6sll-clock.h | 9 ++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6sll.c b/drivers/clk/imx/clk-imx6sll.c
index 3651c77..6270645 100644
--- a/drivers/clk/imx/clk-imx6sll.c
+++ b/drivers/clk/imx/clk-imx6sll.c
@@ -253,6 +253,7 @@ static void __init imx6sll_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SLL_CLK_DCP]		= imx_clk_gate2("dcp", "ahb", base + 0x68, 10);
 	clks[IMX6SLL_CLK_UART2_IPG]	= imx_clk_gate2("uart2_ipg", "ipg", base + 0x68, 28);
 	clks[IMX6SLL_CLK_UART2_SERIAL]	= imx_clk_gate2("uart2_serial",	"uart_podf", base + 0x68, 28);
+	clks[IMX6SLL_CLK_GPIO2]		= imx_clk_gate2("gpio2", "ipg", base + 0x68, 30);
 
 	/* CCGR1 */
 	clks[IMX6SLL_CLK_ECSPI1]	= imx_clk_gate2("ecspi1",	"ecspi_podf", base + 0x6c, 0);
@@ -267,13 +268,17 @@ static void __init imx6sll_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SLL_CLK_GPT_SERIAL]	= imx_clk_gate2("gpt1_serial",	"perclk", base + 0x6c, 22);
 	clks[IMX6SLL_CLK_UART4_IPG]	= imx_clk_gate2("uart4_ipg",	"ipg", base + 0x6c, 24);
 	clks[IMX6SLL_CLK_UART4_SERIAL]	= imx_clk_gate2("uart4_serail",	"uart_podf", base + 0x6c, 24);
+	clks[IMX6SLL_CLK_GPIO1]		= imx_clk_gate2("gpio1",	"ipg", base + 0x6c, 26);
+	clks[IMX6SLL_CLK_GPIO5]		= imx_clk_gate2("gpio5",	"ipg", base + 0x6c, 30);
 
 	/* CCGR2 */
+	clks[IMX6SLL_CLK_GPIO6]		= imx_clk_gate2("gpio6",	"ipg",    base + 0x70, 0);
 	clks[IMX6SLL_CLK_CSI]		= imx_clk_gate2("csi",		"axi",    base + 0x70,	2);
 	clks[IMX6SLL_CLK_I2C1]		= imx_clk_gate2("i2c1",		"perclk", base + 0x70,	6);
 	clks[IMX6SLL_CLK_I2C2]		= imx_clk_gate2("i2c2",		"perclk", base + 0x70,	8);
 	clks[IMX6SLL_CLK_I2C3]		= imx_clk_gate2("i2c3",		"perclk", base + 0x70,	10);
 	clks[IMX6SLL_CLK_OCOTP]		= imx_clk_gate2("ocotp",	"ipg",    base + 0x70,	12);
+	clks[IMX6SLL_CLK_GPIO3]		= imx_clk_gate2("gpio3",	"ipg",    base + 0x70,	26);
 	clks[IMX6SLL_CLK_LCDIF_APB]	= imx_clk_gate2("lcdif_apb",	"axi",    base + 0x70,	28);
 	clks[IMX6SLL_CLK_PXP]		= imx_clk_gate2("pxp",		"axi",    base + 0x70,	30);
 
@@ -283,6 +288,7 @@ static void __init imx6sll_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SLL_CLK_EPDC_AXI]	= imx_clk_gate2("epdc_aclk",	"axi",		base + 0x74, 4);
 	clks[IMX6SLL_CLK_EPDC_PIX]	= imx_clk_gate2("epdc_pix",	"epdc_podf",	base + 0x74, 4);
 	clks[IMX6SLL_CLK_LCDIF_PIX]	= imx_clk_gate2("lcdif_pix",	"lcdif_podf",	base + 0x74, 10);
+	clks[IMX6SLL_CLK_GPIO4]		= imx_clk_gate2("gpio4",	"ipg",		base + 0x74, 12);
 	clks[IMX6SLL_CLK_WDOG1]		= imx_clk_gate2("wdog1",	"ipg",		base + 0x74, 16);
 	clks[IMX6SLL_CLK_MMDC_P0_FAST]	= imx_clk_gate_flags("mmdc_p0_fast", "mmdc_podf",  base + 0x74,	20, CLK_IS_CRITICAL);
 	clks[IMX6SLL_CLK_MMDC_P0_IPG]	= imx_clk_gate2_flags("mmdc_p0_ipg", "ipg",	   base + 0x74,	24, CLK_IS_CRITICAL);
diff --git a/include/dt-bindings/clock/imx6sll-clock.h b/include/dt-bindings/clock/imx6sll-clock.h
index 151111e..1036475 100644
--- a/include/dt-bindings/clock/imx6sll-clock.h
+++ b/include/dt-bindings/clock/imx6sll-clock.h
@@ -197,6 +197,13 @@
 #define IMX6SLL_CLK_EXTERN_AUDIO_PODF   171
 #define IMX6SLL_CLK_EXTERN_AUDIO        172
 
-#define IMX6SLL_CLK_END			173
+#define IMX6SLL_CLK_GPIO1               173
+#define IMX6SLL_CLK_GPIO2               174
+#define IMX6SLL_CLK_GPIO3               175
+#define IMX6SLL_CLK_GPIO4               176
+#define IMX6SLL_CLK_GPIO5               177
+#define IMX6SLL_CLK_GPIO6               178
+
+#define IMX6SLL_CLK_END			179
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6SLL_H */
-- 
2.7.4

