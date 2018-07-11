Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB00C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0151D20936
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a5xTLQwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0151D20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732340AbeGKBFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 21:05:25 -0400
Received: from mail-ve1eur01on0082.outbound.protection.outlook.com ([104.47.1.82]:15488
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732263AbeGKBFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 21:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs3C0tu9z2kNhzD/UeJAAybHP2i3CGw/vFXnCjowuzk=;
 b=a5xTLQwLuHy4kx1aLUko3gbPaQCYElHWO3f5x3yxjkk4PJsw+NdJy/XohlVdlVtIJbIEdqe4nJME/k0/amHdmYEDrPcipFmxsY2vfCtVAP8GPbozHF/EGSJxbNXwBWdHB552l8WVyenX3ewjENEKiG9oguTCSJ8e3DBrrg/zRps=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 HE1PR04MB1324.eurprd04.prod.outlook.com (2a01:111:e400:588a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.21; Wed, 11 Jul
 2018 01:03:32 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@kernel.org, shengjiu.wang@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 1/2] clk: imx: add ocram_s clock for i.mx6sx
Date:   Wed, 11 Jul 2018 08:58:58 +0800
Message-Id: <1531270739-3075-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0018.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:18::30) To HE1PR04MB1324.eurprd04.prod.outlook.com
 (2a01:111:e400:588a::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67bc26f5-f85f-4aea-6259-08d5e6ca21a1
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1324;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;3:HO30YZtWAxmPUX1fAfeYwRUDG4ZTc/bVSKkbmOJ6lUEmQ2ymVDEyqIZsT4dONJCUCkap8Ch/HiUQcOpvzUWDUfMopqmzpDGQFuR9a9TTFCPhZlxoX5uDuPLaAV1bZ1OGgewFrHzAz0u0aGdR/fNB/YcQia1F228kMw4c72MaG6EsEDmuQss95XOdbeFbITgGZaJMIOLg4csegmR1BMKX/Kov//gLPgjIjGNKg4oXrITdYyYRhrqCEY1peUisimEE;25:jgWOI/J3XdjXhHbSS2xXf95cFdJJ/fQihgyoGrxSwB39J7trbzD32iwVIsh1xlo/gi/FIlxNTN1+3EwmRwgn+kvzHhI3J8hPoxQejqgmkxTGUt40w87bz81yZgIkOdE/NujiEFTpgiXdwi1WRA13z71soM7tTG8mkelLQDws40LvItQEB8FVCqmO8InTvA1SOL5WcxZKvka/34NqHGOR764NVcCgBwPtz+w6Nn88Yf5KKaet8g3LGoAahFqNisgluaQ/t9r5AEHZI5auxZysrumscSRuaJxpzNlohRIAJMPc5V2UhngEQyETKvPYXLELOZ8jUegxoWjyruKDYmbK9w==;31:Gfo0ofxwDHJgh/KDjfQXbkJYZOqRRGepyMJEajZop83in0m8z4EIke0wF2w2kIhR3K6qJW50Fmdei++b2pI3fXNHOfJLSaDT1cXH7hWEhOp9V2vMa8ig87tMQXamwMwHqW2XG23qaxfRYpLhsE6+ZCtM7NPaR8RwvVbyGK0cBBzoIcOirYih8rp5YPI6oGquzUOKY22U/Lxh/8aap1ceCAoJArpeQpBnF2BvUSJb8C8=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1324:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;20:Ti2eDpesO3or2/AifU6AvCByRzxTo7wZ6mBa3GLfr9Mzyj4UtXLgSsc+f88gxR0X2J9rxfImQSBxY+oT/wI2AeImedPC2QIHnjDIQnO1sImgUQx5Aphx569z207z9ylQhhndJlMHYAzr0RUMzUqrLyrW4AI7mcZzA6jcfzY+SkjYDcO0p5wAkRDFo4k5baar4UPU3d8AZYGFGXm/09w9eoDn7gUoVTtOnvyzet1fq4XVBrC7HvjCv7hmuQ/zFzCnkjA8ploXSsl+3dh01ZUB4NjNqYbjSYTXpOY+ajE/XeJoYm/j6KcHWPmwedBYlPXZ5uLp+nOf4xJ0bAitIMlkVU5YIUOvr3+BU1sAgSK9zSk2z/9jXrBZAE47gbd/0Yyhk76fhLbTkuzQTB7FVcZVk9c68MVZqXkqhJcUARo7ucyE+XE29ipD4/JHcQBt41IrUsriSgAlpfesabWuREeypcvv7aWwZNf8L627HxFPfOVH7cLfM9zNxPHJFUHpHU1c;4:qGG5CKzjV0y6ZMRta0LxwUJVVNTUsxW0fYSON/Php9QNnwsIomuIQGqm+SWSOAIORV61To7Q3oXwnBHr24SAX4Ul94fdo03Mu61s3sRIwWFbENXly+eZpIoywwqKlWeCgy9Efhyk0g+/H6vF8LhPILWzqD22b0l+O7echsvTTAqUWktMbx45Kgye0QgVJXq0KX6eIT8ja8k1NzxqdJVY9vgAJ7c9sKTqv8o+6zEz2d3WuCOlmB9qpjk+0Cq5kVKqwUdTzcPnxe38EGcUOOaFfF7nKE0HBIbXFfFSozPpXrdgdBIm+CGkD7DV0eaV4EMi
X-Microsoft-Antispam-PRVS: <HE1PR04MB1324ED54E7AE5609B0CEFB3CF55A0@HE1PR04MB1324.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1324;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1324;
X-Forefront-PRVS: 0730093765
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(366004)(199004)(189003)(105586002)(97736004)(6486002)(7736002)(36756003)(106356001)(14444005)(305945005)(5660300001)(4326008)(53936002)(6512007)(486006)(25786009)(956004)(2616005)(7416002)(476003)(8936002)(50466002)(48376002)(6116002)(478600001)(47776003)(3846002)(316002)(16586007)(26005)(66066001)(86362001)(16526019)(186003)(50226002)(2906002)(51416003)(81156014)(8676002)(81166006)(68736007)(386003)(6506007)(52116002)(6666003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1324;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1324;23:rQi5bAe+IZGinQwu6eRa5fSHloTI10UHtmZtYNqfK?=
 =?us-ascii?Q?YsQ5tFn5b7PGNo+EB/2uU2B0ut/yl6CutfqPGpEOVMJn34yn3Lz5gIYg2m1S?=
 =?us-ascii?Q?w3Cx2tdBmISSDlKW02ARR4m8lfAkja4lnGTmVetpiBr90CkI9Zy5L+rF6p0O?=
 =?us-ascii?Q?Kuiit8cpwhTPhL1ocDRlxOe/xsxC4++TY7/XW+8A5XYeBGX4nV+s9mrqxZV5?=
 =?us-ascii?Q?Cs9is6t8R1CBKe5r+K1sNmBX1FWbdCMVB1msGVHGiO9MYHjgyE1492BPebRD?=
 =?us-ascii?Q?go4I6SByYtx+xZEafWS/SWy9LMWFm3C6xg+TDepEZRhehd6YGO5x4EAz7U/X?=
 =?us-ascii?Q?EM0zP3JUxxCp3zU9jxGzBsBPXqiXsq+Zx/iRkBZ7GZ651J1Y2wg+gIj11G2C?=
 =?us-ascii?Q?YYBGJ3vNXtdl4d8CucouQM4EzlIJ4zCF6SvgoDPIKMSfopgQNXWB343p2WXB?=
 =?us-ascii?Q?dxCjHJpj1Erwe4TOpE208bghc2JFDx0RHUzYl1q8DH/a79aikUsrbB0XZVW7?=
 =?us-ascii?Q?MXR3EVYHRaaZYBnDxwgwjg5ntAt+dgiI6hg4y5uaqN3FqLhYkFMyJIpdvXZU?=
 =?us-ascii?Q?Z3MePd3J+zeR8VUYzxvTIVvw2OeAYvc+BVP6UoenTBHsmdQzrJE1SHsn9Trj?=
 =?us-ascii?Q?bOvkZ5O4woLrp8fKRIbz8h1swm1UesrsUb1nHcDwTHr+eCXTj7YeeW/stFnl?=
 =?us-ascii?Q?CjfMW5RQol+EgNwb9p9qnHTlfhMhg09dsXjlnCcVsvM/HRo1tHfa0TMfpuTu?=
 =?us-ascii?Q?OjskAAwrR76aJ7YHi/DMYLMVZLGOjUiN6ReHLDxOQvfrxpHTSXbljK8KZcLR?=
 =?us-ascii?Q?TgwfD5mA7C2fKf9v3sD2zFqtgvx/2TFUeNq2dI6XZ10lYW9skT6fogmnYP1A?=
 =?us-ascii?Q?KCPf7zYeUaX3xhTTOA1R/RsuhdEn3SmK9ZpdpP02fs/xuuLZRceQ6g9PUj60?=
 =?us-ascii?Q?mSm/9dA734jd/8QFYKKReyCaOoNjnAScuI80kuAiw/ZF0mOhs77RMfG6KSdK?=
 =?us-ascii?Q?OunS5BBQoQ4v537sT37hyinNj20Qo+Rv8qs2qe+OV3hbj/3POrG5ykDD9FxJ?=
 =?us-ascii?Q?nAZOxXQny6LY5shZRmlBz6VK8MHiIjzNxlvilxndTvtz063emaL22lVWpvSs?=
 =?us-ascii?Q?w2wg1DLxBC2DyFgsBymRz9q3SoY3N3SJU21tLfdt86nMHf75L21hA=3D=3D?=
X-Microsoft-Antispam-Message-Info: /rQXT5JeexVKc5dq0ATgJO4ilkmVqhvX6+6g4Zr8rmJjKaBhz35Yv2rOiStfhFlsDKJ1hKk4t6Bn5pYg7euF4wf9oPA6aniPIloGuC0G33Nf4RupAJCCR4qOsgWXswrdwdnt85pwdlrZsCQTS5m3kdMF36HvDF5yqnXqQ12TbZHuOAENAqjSDNuT0RbWtyLQ9vIU+QI5wsdeSFXZvSrwmGbX9i+t+XHWrFyU2wjG0ExhKmOY7NEIeS9MeN2tOaUL1QtDWsR0vHPhSMgAtIzZvUCHIgieWuy8WLViTrXvKkUCmPL42hVrrQAPfoPUzDp3t644RGy94m0+k3hMJovhfMvcA9aOP6YKr+cA4lhUm84=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;6:nenVPrOJnMOOr1+Gh0v+2rspm0rfxKnxtXrv65Vln1s8bLnNPGStU/xqS9mMZgBx+T/ynC53NCdaJaTwRNzsnQcz9IQ9GtlY04NXNN6BU8u7wwkGiZY0mUjiCUwgmkHewNFO7oO196hL1Fi83FjPU0wAt6k+XjWsUatQ8V4kKTieqmJLr/8rV44TnKlXbQ7OmVHJAHn2RNv1vezA3mWsK/M3tQxUdqOK0lyX5u69KZvKezpKd5v2bEm5Qf/SksJ1i+AhxK2uw6/7EuOx6eRzQkVq0Nj3HhQTDXEfBrBESobbGoPtaKV5nFPa89XhC5oS+o0rZk7n/sB8ZZvxmY/eMGYU4gngkaGzl9IpUwfBvWPoTMHdKfxqOBQGhVHeLPSirjesWfDSw8KVfIf/A1Frm/TDU6Q/Opvb+kBkFxW5TSv4kJGFpZEA1eKzAhNjb72G0e6bbLe0U8EAz+PdNuDGjA==;5:eE7o+v6PBNAWGO0u4KAOVdil422f4jKmT/UxS3cN5XDgKhhpfy0tjDUyqXjgN4eBa3YfW5KkCN1reI3Cbk7NLnf7izE0wS1IPyS0g8Z1s4BYe3srb0VqpXCxXZLb0rIdmrTERADWqBOJAwnA0MbKtvMMTgIRtkLBF2gq2xeQhyw=;24:Bbul1wwW5CkPf3PbYasA/MdvPOVxu/Yd4SIdntzoX7UNcnzbaxCO+mBDwdqdxuFWE68SJ9avWiRzKZEBI/v/TiQMukZxGWz87S1cbnW1+Og=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1324;7:4NFfwp4orOJ9g2c1kj2II0lddSkIZJXyfQRcNuYHsON92s/8lJBJfdJuEHDh6JVP116dKvetmCoVedcI7tYob74lQipSohlVZiPKtGM3QkFL4wUQgaNI520CP20ATrtDv66+zRpg6e9WULTCwhYu3jkFnS7M+Yo/eNaijR4GKFeIKiMYbO1VvYGekOVIZEJY1KXVnUyTLXmpXlnvpIkfGrsCrWxaHR/583LINhW1vXRwOVUwFT6aRr/QRtpirLnv
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2018 01:03:32.2622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67bc26f5-f85f-4aea-6259-08d5e6ca21a1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1324
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6SX has a 16KB always-on ocram bank called
ocram_s, and its clock gate in CCM CCGR1 CG14
needs to be enabled before access, add it to
clock tree.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	remove redefinition of IMX6SX_CLK_OCRAM_S to avoid build warning
 drivers/clk/imx/clk-imx6sx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index 10c771b..691db26 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -411,6 +411,7 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SX_CLK_GPT_BUS]      = imx_clk_gate2("gpt_bus",       "perclk",            base + 0x6c, 20);
 	clks[IMX6SX_CLK_GPT_SERIAL]   = imx_clk_gate2("gpt_serial",    "perclk",            base + 0x6c, 22);
 	clks[IMX6SX_CLK_GPU]          = imx_clk_gate2("gpu",           "gpu_core_podf",     base + 0x6c, 26);
+	clks[IMX6SX_CLK_OCRAM_S]      = imx_clk_gate2("ocram_s",       "ahb",               base + 0x6c, 28);
 	clks[IMX6SX_CLK_CANFD]        = imx_clk_gate2("canfd",         "can_podf",          base + 0x6c, 30);
 
 	/* CCGR2 */
-- 
2.7.4

