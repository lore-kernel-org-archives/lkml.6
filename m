Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E660C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A76208E1
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 08:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rTjR3EFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A76208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932875AbeGJIoY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 04:44:24 -0400
Received: from mail-eopbgr20078.outbound.protection.outlook.com ([40.107.2.78]:21528
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751328AbeGJIoV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 04:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mt9uqq6u79M/fvEn5WiXzZ/KL/Ln10AmJywbKfOKU7Q=;
 b=rTjR3EFYlFmHepFz5w3Wp2FLdtNFyR+CdsjMuMnW6HbjhS+YgMG4cpCctL3tWRkOrKeCK/4GjCa8KQ4AOEZ3Ok6LLvfgdXRtA1lUaJKvl+6HhdYT8CRPr3i3UCaQ9mdYdzIlIQe7K6pCgGWE/ETb1kfjZKYLyR4iAvu83VO4WNY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 VI1PR04MB1327.eurprd04.prod.outlook.com (2a01:111:e400:5187::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.20; Tue, 10 Jul
 2018 08:44:12 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, robh+dt@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@kernel.org, shengjiu.wang@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] clk: imx: add ocram_s clock for i.mx6sx
Date:   Tue, 10 Jul 2018 16:39:38 +0800
Message-Id: <1531211979-2179-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::13) To VI1PR04MB1327.eurprd04.prod.outlook.com
 (2a01:111:e400:5187::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51269fb9-1343-4a76-bd8f-08d5e6415249
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1327;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;3:rQqkzjHO0wHURtVKX6n3SvmgTguTItUKGnHaadSCzO/3k4jgsGLh1vAJMpWzvPsXVCOJMYepaYz2Z8klCN51o2Emozqrn75JQqBt4E89c3CN+dWV8sgswLpz0PeEA6wgwyiay+QeJR7xNJ7ylQ94Ur20ApaajRxiWMJ5hvKoTOQeti0f6c+VOVmaaM7smUFcEoC0RSHQyN7+lFvGquFQKN6fxEJ4BBKBkRpTtjMweeu8fIMTJpePpoV7GF9T7yDA;25:zzQGFwCB3V/QOqu+cwrCrkzZ95qoTSmuh7m3bWa+eRB9cmAjWv6yDzpE2lISxkWCAia+6lK8jxqMGZoBZmzBJ68dGInXVDPgcKpxzT+NHxNA4E1CSNBJ1CJEgUu3jzWma8gcrERmP/+RdTVxhM3dZF5vhIi0iElqUu+2/C3/TPweuBcDd0pWjJnNMhsZdSU3+HUm6LiaCnuUpSOqZlFd1gP4BnSKddMjmeQ/Mn14ccVBSSHiy0Y2XNLe1U4Fr5tnCN5CQ3IjTvAhCr0iujcfTBWmVKW/sfkKjQomK4XNBErVkGg6j/t8FIZcN7QnClbngnNlbsYRMOTU773fr7qBiA==;31:MW+IBMP1uH38xYGhqKGAAYv2PG1HBSoudaktN1l/gRk8QHePLsDSEwc7YJDIBlbuCAYSpy4mODzqVk8zPdzrRqXVNb5W5cmJezo7T7yLhnJi9axVxJzfgidsUgSRvJRGA6iiNXOXA6wGlnJq9IDH/h6KfgV3LhLRl83EvZdV5vwXjJ/iy4vLVqgwpNgE2e5OrGf4uTwcu6JmnBE+CG8GdnvFkjwByeLDM2I0eMSF8to=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1327:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;20:JXYymlTkK07jOg0DfgajOCCIIJo/QDoaUw5JdJgCAdNWa0NswANUsmj8hC/ANmds7hJkweKsohjn40bcI4bg9Vh30mF2qGjdcDvNWittsVkBhezHMtOsL992Zk4IBcdikaTCD9atgO/kwSrsB33sfpY/GUxL8ayNJtyE6ABUTNTUHbaSc6VyM+LRQI40cJoHkEkD5Xcafx/T9LGXcKmg406d+lBo807qn06TJlXSGR2BaMatZO5Bn1WloM0tZtO1FHRvujVfiS2i7AAJClscB6AJaPuZY0l6aQrcheD+3xMAbdV4ZScx51xwrIvJ9Tu1TqcrXiaJnQ7fqRb69BeuawFyqV1lS02DAuoWfc3Ci3zT3cUUKAjW2lrx59VGykYnG2h2NshNTRiqe2mkl/Sern5iqiFt3wSv8maRAGuBYi7i/EYgfONodHQ1jl6feVfzhW6RYKmoEs+uK1s8DmIlsyvNhGo34kMSAq3VNl5qt0kvbRcpQwMjNbtJmQpIPyBl;4:Igk/kNEiZEHBNsVHEVo9JUnB5eI3yBxuCHjO2OO2mnCF1tdZf+lj/mQcloAS0ONNzrgBuXEgazPfAAo0uu/P8czODdDpYXt2Gn98s8ysvJuDUZfdj2MRB9jh12V3WTryiWCYAUKWaKFOeXLU04Zq39l72inGY0iGw2EdbRPzOEYDxy2gzqR9OjgUqUkPn7HufkdSj1GkjYOD8+8sTUA/4Bt0uwTle4Ixq6KLgFSnyBIsFSaw9aH+ls3epMHYzg+2F35YZdKoGDmzti5s52I7nLGVAoGmyj7gPkkLsGNKyFYPinUpx2QS/nxJd1Qamx+l
X-Microsoft-Antispam-PRVS: <VI1PR04MB132779B17F1551BFAA3C0878F55B0@VI1PR04MB1327.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB1327;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1327;
X-Forefront-PRVS: 0729050452
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(346002)(366004)(396003)(189003)(199004)(25786009)(8676002)(478600001)(16526019)(47776003)(53936002)(106356001)(81156014)(2906002)(66066001)(186003)(6116002)(3846002)(386003)(6506007)(81166006)(105586002)(4326008)(8936002)(26005)(6512007)(316002)(7416002)(36756003)(86362001)(68736007)(97736004)(5660300001)(14444005)(6666003)(2616005)(50466002)(7736002)(305945005)(50226002)(51416003)(6486002)(16586007)(476003)(48376002)(486006)(956004)(52116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1327;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1327;23:NG4nJPScJFJe5H5LrMlf1ZBg8T8NUHhTr72OFtOZM?=
 =?us-ascii?Q?fNmOXcgEJRTUgGkH9H9bSuW0habHmaqjNUcGjdaWdZ+WZdj384QURQSi6OH1?=
 =?us-ascii?Q?qMxnn+Inf+xwwBATcy1T2ksF+NQjgH37THkEPpvUJ3d/Fz/OfZSAsrvE3una?=
 =?us-ascii?Q?h8UZ/m1Bk95K2t+9d7cSAo79Itr38vzWEK5ZG0tuaNYw+JsYNXgGKsVZ9iD6?=
 =?us-ascii?Q?TvPYE/FhJBK9so7/7RWebnO451LEAYrpIxqDnhiDwqcMvPsMF3NlNL9W/Hwq?=
 =?us-ascii?Q?Zfqh/IyHQ0Hb94kQ5TIltGK91dh1WPeKphhZo/8Lb+a/qwCXd5jrORySEfQ+?=
 =?us-ascii?Q?jiHICTD8NSzB8TjqnCBAUFl8uZMFdcHP8Vx/blcLClOVclQ2b9r4QCaZXJCB?=
 =?us-ascii?Q?7BnjqxcGAcps50V9eH990kMZgVRiyBoHwkRa7QYcGJnoPznLec405wuREa/H?=
 =?us-ascii?Q?HnLC6gEzD4SVC5F1dgkkhE6B8Q2gQ18nPzO7+VGenDYOZIytjH2ImvB3EGxH?=
 =?us-ascii?Q?tYWhnSKD54iT7xQBikDZE5yA2GlrhDONFuOI8ZUcf3z0n8+/XafIniy6tQqt?=
 =?us-ascii?Q?XHx2yOpLTp59k4nQY83jGURL63NxCry3Fqb1S8q2/e6LwGlePV8Qr+A2g0dI?=
 =?us-ascii?Q?zp3vXNzse5hKro2u9Q5Z8m5lpowHVg2szyD10hLTV754IRI5a3+4BYOjsDmr?=
 =?us-ascii?Q?UEv3dZMABp+4WpE/lcAiH5bXgS1u/ALB9mGDdWPqRHxd/lOqTSyT4bCFLqfs?=
 =?us-ascii?Q?xRBTNDJvZOFqgUyWk/aIZB+2WHvEj1OudMzvu6fJi2sjWOiEP1O5f8uzyAB+?=
 =?us-ascii?Q?4Dxd64Pd1OJnVtEqILxVwzbz2oZT6cQh+OwNNP866K+MYcTdM/T4bkEPlkZG?=
 =?us-ascii?Q?Yg8WvDoIKTOpn3OmQB6WZ3HIVo9+w4ll0KUmDPm5nWlkWFY4oOEvDL89GzLS?=
 =?us-ascii?Q?Z/a3SIDn4ZekD8pqQ/O0s+isQ/O1Lx6+fqX+7OFE4fy+lk5MLH/EVWg1pHPG?=
 =?us-ascii?Q?6MtK4B3Xuy6DGSJnQCL6CBsUDWuq9xLPYTEmeF7Dczkg32vEpBFjwVXh+4Am?=
 =?us-ascii?Q?MHyr6/zCadNNlrPGgDVpTrCSM6RcacepmtiHayaoonjjZ5h3VyncCnOiVjLx?=
 =?us-ascii?Q?gBAWzh8pvEDMwkeG8WfbABzkr+PmBWgZ0WseeA1Y4vELvIXnphBgw=3D=3D?=
X-Microsoft-Antispam-Message-Info: dzaBYnjergXBJuqkRkdVQMGP1ezoBjJsJAvNsTNs0Ym+S0FWvMIkCzdwNucezQKiUOadfLdOyUfAYX8Dwt6NsFvEYSGPU3xfyxeHCHKeFxtz3jc257J1A+wrYcCd5gnGCiqQUxHzRqCzu9Xn0yDFlcisFWGLa3IPYnxm/rPMT9l8FOCrgogSWpvc+CSz2Rzpe+gTiqxB05npQS1Ni7d4TH4ytV+Lew9XR5I10mG9coW1FCAgZRekXAXuI74w/Rrg2nBC+0t0AbMlRMR2ic2ikUixsM1Ot12bnUbMv1aHCnk5+pqpHQUN6F1zipscZnf6RCvJiYS3/+mlea7yJNymCerj09Im7gm/fzOSVkUePTw=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;6:Zo+ldH+yZJ+y2pmx0AOq2tfRyxQ4brOT+JZenT4JrVj1PusaJqdUDOStLnP23cZdnH9AsqC0hNm6lyP2hqGj3JnLdh0i6cRgkobwqfYz8qm2YJ3r9Vw634LViAJMjC9dbQAA5dauOFT+qGBFsI77o5XsmdQ09YOyilb5BVx8Jx/eNnA7W5m+gL0mFlMLDU5CnYrffiIzxWHGamSfEX6KWDWgazx3VPnTUkjrqKniC3v3RqBNopo1gijZyxBODldhwrflyVM4Vslrq2gwml/43Sug0ljuqyKY8qh7w/y0tfLpHCUMv4/OKPBmvj+qP2NT3BwmVE/EmVuAwJaVtgVLms4hMK6JUjV4yC3IX1ByoqMm0U42uNySEjNgOh8GWepwO0nZ+6p0gpQBBhc2b06cTGavs6wquCXy/akwj1nZpHCCXUyY0Q78ae9dS8jNJRDdfacOaVyGOfTzcBterhi4ug==;5:KxguAzqHAPBiUARN6aMzF1BKd7AzbhDRfnIUNGXZhIEe3AEy5z9rTYcqO7KuYvk5NqQykKJs5zaULc1bBVFthJiywDKUBs1vLZG4lblOiwWtsGqTyvyuq+H8syc19/5HYRLjaxs5atnWhUMLlIGOkNDpWbYOp4aTmdQ2D5HN71s=;24:MhXRZG5Jg9lqsNJ8pBRy2dJBgR6Egpr27WArZTllH43gWHpWCl5qkVkx0vxODBzsxIPijS8gNT9hNVSkffWEecDzwYx2mOcGIyiRPwEIB0I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1327;7:us3OfmnHOkbkpAAoCeSHZk0yGb7XX4C3RBm7PgA1o44Cj9X+A1uTG320FThHEMAQFr+GyqBl3Z/B3mvT8YJ58NEIbejzXbe5s3X1kC0EhJF0TCTB7XGrxSfdmydVHzm/bQA7zCHEVYss8xYkGmRFRKn24jYIWE2hqielsjRPf+uKzByXMbcHEB4mfjd9TruVpQ08bph/OyV7iCoAqxoTPDDK+f1NZECB0nF9omg4GaDnweJObI7wU5JU5pS9O24U
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2018 08:44:12.9289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51269fb9-1343-4a76-bd8f-08d5e6415249
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1327
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
 drivers/clk/imx/clk-imx6sx.c             | 1 +
 include/dt-bindings/clock/imx6sx-clock.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

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
diff --git a/include/dt-bindings/clock/imx6sx-clock.h b/include/dt-bindings/clock/imx6sx-clock.h
index cd2d6c5..c1ccff8 100644
--- a/include/dt-bindings/clock/imx6sx-clock.h
+++ b/include/dt-bindings/clock/imx6sx-clock.h
@@ -279,6 +279,7 @@
 #define IMX6SX_CLK_LVDS2_OUT		266
 #define IMX6SX_CLK_LVDS2_IN		267
 #define IMX6SX_CLK_ANACLK2		268
-#define IMX6SX_CLK_CLK_END		269
+#define IMX6SX_CLK_OCRAM_S		269
+#define IMX6SX_CLK_CLK_END		270
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6SX_H */
-- 
2.7.4

