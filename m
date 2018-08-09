Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C118C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 002C621EA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cEvOJGq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002C621EA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732502AbeHIRLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:11:30 -0400
Received: from mail-eopbgr60044.outbound.protection.outlook.com ([40.107.6.44]:32576
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732072AbeHIRL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXf7qO38vaYskqGDfbVulsm2QujivvVj2Ne8jKVWVAk=;
 b=cEvOJGq3ZFt2rjSi0ghRP0JSUTT6CBXngfy6dd0EjS8IomMgzvhfOTtizp1BjlGpbyWFYbbResRl+KwP686ccW0s+2ABYIptCEKwdbqbULs8KMWvNv/RF3wGxEjPeElnG1CM2d95Q5UNS4zZ4w1P+tIGUejSs0arXtDKl7G6SbQ=
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 HE1PR04MB1611.eurprd04.prod.outlook.com (2a01:111:e400:59a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.18; Thu, 9 Aug
 2018 14:46:01 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v3 3/4] clk: imx: add SCCG PLL type
Date:   Thu,  9 Aug 2018 17:45:40 +0300
Message-Id: <1533825941-17224-4-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533825941-17224-1-git-send-email-abel.vesa@nxp.com>
References: <1533825941-17224-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM3PR04CA0141.eurprd04.prod.outlook.com (2603:10a6:207::25)
 To HE1PR04MB1611.eurprd04.prod.outlook.com (2a01:111:e400:59a9::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb55c6a6-3b13-47b7-4dd0-08d5fe06d46a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1611;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1611;3:WkchbzzIIed0PkVC73Em8kPMhv686tsBSCQX7skkUiyBDbo5BcjJGeIkX6h7Gz2VBEeWp2waaCX9fTazcf5ISb431Yj7K4OICwypalzxtV13y65dSrASE41X22pNIqPgPZCLF+rUNOernUai7wyBXbU+Zzd9CfVz3TpkJpNeS+XWn43CaSk33cAuPd8P6oz7AYnsVkUQZsMDsH8LtAyx6Zf8Pq1+VVOc64BtLTeXWui/Y/BTo/r1WYp9HM+JtLXc;25:QXOP2B5ne0YF6RFphn+j5umjCdaUQommT/baA8iAa4r7vI7crNNNOLx7hDK0BdejGSwkzhj+ZhbOeC88K/1jlvJl4yv7abb1Fw1e+23RwW7CX0O4yaIk0g+q90hSx/Enc0TW636EXW6MTzOowrj1D6VmdUMXBTW9AqiXy1yxCNgzWNt+Dtq3ADXreLgF+fVgWyFFGWP01lCXINl1dkJZBfhbobSILrZ7AgifMjM2d9L1OyeRBDIXnyU6xobTYTqmUsDVjSpDlGuudl5kxAqYSYDni9QMJhT3sDBbWAypSR26XmtJd/BnlVFAamvtr7+mNrBL5jWnkagrTXckaUtBNA==;31:6fZt3ijtB6bX0BgiQYkmdkgiDN5H7wN+fNRlWtzrHe25oz5ICQ1+Wwbxn2/hlGp9l7k9P/tWDbL/01TCEWcTbUS+qyhfjKvzRea4wQs9JFcFNSiTKcAqYsrj18oS2MztEXGA5ggwtn2kiNv3i1ekRK9Jw4iB4Qt6CWg8w6Z1PNzL3cVmRfrjTS/mdjAWtWkJ1MtQJ5F2oTZlEKv7jxAVeUCcclGc50N5Oq3Hwv2eMJw=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1611:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1611;20:sGAJyCnuoC9GtafBYDFmtnfLbu4v0ceeCY+SWW1ij/9NlJloyT135CbFFhIX485ciCvEeVrjptcv78YHYvALSM0I4NsCy9dDWWAdupMlr4Suppi1UQle6eUTaQJTxC6vbBefOZJWjw5K2gadwUVeaPTtr96gYzetpj9wZXCmX3hUy33uXD9PTObOckbFCC+5xhczn2MKFvobq2tg136ITWpKly7I4KG1Aai+60QchSu2Nrl1hMWNiniuk8tPUvi5OBBGO4SutdCzD5EX+zXg6oZxo9aZGl53K8TcpeyU1eRi1clK3PlAMijfRwHRXzUYP3KW7kW6CsVFK8+9TavNtyrYYXi5tNDNYgy/wDMNkoW8AgqS++6jGcxhztCoNDgRGmD1AV5zclUCk5jOU6oo2lqKeNgtLaT7m19fUspZQJe1U1Uy03AxUKbb0BoIjTjVbAOtvZSpNxE5M+qScedOicad1NrXTULUng8FxPgjMUizAdFGLaJ4FYrtEbY0Xwkv;4:/qWsHsRwUCE99y9dC7oop+LjdIvfd/bqs3NvaJ2cjGG7AAgRPleE+iA9gxFv23/DfvI3Z+Y+yMNiUdR8wzgn52rzU2V3rT7StbISRSHpoSXflQNAJRZXmJe8H3d3kSY5C4mP0MX80igT7KJwhf1gV/l0RfS2SmcXrBDeMICWw3syV1yQ/HTfUHvP0v2XLCf9fMoZLfl8vAEmAqaJG3tZPrIwdmVBdgvrWOUgK1D3GzFM5ofxhA4+xSgXhRy54natEso6ZArF6ed1aNa9QWBwW7G0Gr4G8PgvVsmG9OeYwxBGZ6KQlTQpdHvvKES3n0BO
X-Microsoft-Antispam-PRVS: <HE1PR04MB16118E1ED78A91A012ABB899F6250@HE1PR04MB1611.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR04MB1611;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1611;
X-Forefront-PRVS: 0759F7A50A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(366004)(346002)(136003)(189003)(199004)(8936002)(47776003)(50226002)(53936002)(6116002)(81156014)(54906003)(110136005)(81166006)(217873002)(8676002)(16586007)(5660300001)(68736007)(316002)(7736002)(305945005)(14444005)(6666003)(7416002)(51416003)(66066001)(52116002)(76176011)(36756003)(3846002)(25786009)(105586002)(97736004)(6506007)(386003)(106356001)(48376002)(6512007)(186003)(2906002)(16526019)(26005)(4326008)(50466002)(478600001)(476003)(446003)(44832011)(2616005)(6486002)(11346002)(956004)(86362001)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1611;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1611;23:XW9g43fYOLiIanDABS4qJZ5hxMJAQzF2mPFIy7Qyu?=
 =?us-ascii?Q?OYbfGpu/Veq8oXhjhJ8t0am9fbEI65k8wvEMTzHgQLIbC8NyuVi57JyVOew/?=
 =?us-ascii?Q?DjcytXGdbnaPDbqTZMu7xxh7X46KrnEfy1yAGjMUAdU/TBtTNn1ci29JJEi+?=
 =?us-ascii?Q?bLd8ZWT8rFMdzGNbPK64SV0auhy0l0nfh1t8/qylrWNvws60OmIr920hp01N?=
 =?us-ascii?Q?fHi3ltM3gNpQAy3AY+YIiy0ItQqfh0Z+Jb3BasijZYjS2ROQMeDGvIsnti6W?=
 =?us-ascii?Q?ICciw0HmHixgDNnadtiqXF5KR84gunIGvEUuv9Do6aUC5jViD4+WedB9/8lk?=
 =?us-ascii?Q?a3USMue99+zSlia5d3zxgczYOw/vjoz5pssrVfzsdObEukkqy/eCH9IkZToL?=
 =?us-ascii?Q?tB1hqcuy1ifXqf8ozVO2d9yruBBDCIrIx6og1o+dWnlDwrlVYymm7p9+KTXR?=
 =?us-ascii?Q?lXBITlgYQrl0XZFqbrfw8kRJ7690Py4NSftUmZ+tqxkrC10qNlQp8TBEkypL?=
 =?us-ascii?Q?sD6k8fmCrutbfzNq89h23GbJrNgMcKLfN1+ETdmV2ZuL/JyCj2frOdXCbSyb?=
 =?us-ascii?Q?iogMvkZslTAzV3kSaBbQBpHT0+u7uOFJ+c88HVQpDAyA+AZ+OuwMQ8SRHKc3?=
 =?us-ascii?Q?KyfRQcJUw8I/w5zDRDrn8oYyq1Xu0M/DeLZ2H1Y+tvxZEYtrBtDnbCZ5WyMJ?=
 =?us-ascii?Q?GyAE6CTGO4+3/+PsS+X8SsfoM8rcg5llvvGpmLz8EbC4MVpBYIGHDhfRAajj?=
 =?us-ascii?Q?buBB27GetgJmdJPABwGwWXhnJELq01ZK7KRdPhgPa1SCQkeK61DNl2fMb1ym?=
 =?us-ascii?Q?jcxleiVQIQsx2iT1V+UFsPtKJzzp5yVMlaYxVLCdWRLZcrxkG2iJ7vgqkXXF?=
 =?us-ascii?Q?1aeMQf14DyOVOCi0YH/Rppy/NqBK5EHOezKrhcdX7TVIOYI3Hz7fvi62fhoB?=
 =?us-ascii?Q?fl9LKWATGMXalcoFB5wcPH4IVMljlGeJV5FfoVddzsh59GN0eMC7ohceVxWb?=
 =?us-ascii?Q?XB7y6eQDcFkA7HPiYYPiO1itI2P1RLiJv0gVj2DfmaTnC7OJaPaDN70luzjk?=
 =?us-ascii?Q?GBxCyT2zIxKElI1tZvYzatajEFIRPDzOczc2EfTiun+Vh7rCMHEm0xeXwwD/?=
 =?us-ascii?Q?BH4JloA1QSLO8lBCBXO434W3EgC+Tni8t2hIh4XuKKB1adLDR+86php3+LCq?=
 =?us-ascii?Q?XYj1D/9tK6m+0sld3Q+/KMdJZwXZaltzm4oHpozZSa77SXnFnGW81oE7teob?=
 =?us-ascii?Q?9mR5XwR/9qdkTfrh3GOQaNqrCef6UgDZk2bFo74?=
X-Microsoft-Antispam-Message-Info: drqPZHNv1rJayTks1sXrGF10dWB13GAfJTFQy1B6Md85afgmwrYhntOU1PNUME/27EL64pr/4z++kLkexsnOfm6iKU1WgdeUNo3PSKuatKl5dHEasHov/91c4aL+F5SijbuIXJpstwet5El/9yoDZ4I79iM1RvDpY/NWJEBYq23fJACR7W/gmX/ifasAn7hkP4XEFOLFNJInm5miPqvAx3CHGK8GR4JJpBy1uUN2V3hFoBUffmPkPtG6ug7Da0YVdzX09cJIJEMiJWFUVXWsEfwbWO3ghjtFMZL/lKaagUvFbX1liAxe27CTVjcPnOJYuhkFwYlV1TukhEG6REIaC0LULe0QhgcP/N6uoOo4ijw=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1611;6:Wv9f3gtiA7WP7rLLhfAxlub+6w3K2FpmLA5qAw62Y1oMx+fuXUskjYYF1GbqnCCPnF4mYNFeeRKhdKzXRmm0fxRHHZNZPk46hitUzafrjIwzplmApkN5Is7qq5r1nu18N6yULH9wfZX3zNRngiggpUhb3WHthzg0AJj7Nsfr8nhOB1XxcRYJrPq84qzMFBmWdtw4ZdYY4v+A7wKuFbiP73B285JYu3edTTUdqLclDUGNMvV4Lhv0ToWEYsRR3OyT2TcKTayg7xGKdDPBY3ExtM8OXrWdr2CwT+aJfJRzOyyuCN6WUfswK3HlGFFOyJhvfIHVlhRHc4GjmmWvEfs7TTBpU5WVPwrm6IlfGungPfzLDR3MK4jTB65HsSumo4pGu/A2U5+Jbgejfnl4nVQP70BlsR8WQpPmzL+HTBYKDvS8ANwXbb3N8WCcRPmiA1DEtjIWMtWewFuA3B1n/bmlMw==;5:cK5AxmskKUTKW3rQnEWFxGaDzGTMrXBiu1PmIsgBqwxjjO8GNESaYdasuzvbS9YfQcixwa+Gf2ZYon7Ei/7AaKN7dH3svEzfdzeRu92RLl+h2djmQTYuOSTosTOUVe9UhokcKMgdW1V1eZjqZRxKEJPgmh92fQyKv+JBzgxJBUA=;7:4W17GIo/GvkcL8831kU9V1Fr+HMcSLBnpjXjEb7eBW0fodajIXtnTTmD9T2sEyQY5mDz6g+hXeTyiM0PQZu1/Mi1yWTkrqWs/k91JARTs/1o+898tkLxzetqvytJppCGuqbLTITaZJOIgXoKItWwPMtaM8NDthBj8NYrqAImNEb0HGtrNUPzkbHmAFOtCs+5Vy/EoQ2AcJONsOJcNfKggHNqcvjdd6qGtsQX2QeCQg+c3/AikhSkAEqd+xIk26A2
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2018 14:46:01.7308 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb55c6a6-3b13-47b7-4dd0-08d5fe06d46a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1611
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

The SCCG is a new PLL type introduced on i.MX8. Add support for this.
The driver currently misses the PLL lock check, as the preliminary
documentation mentions lock configurations, but is quiet about where
to find the actual lock status signal.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/Makefile       |   3 +-
 drivers/clk/imx/clk-sccg-pll.c | 231 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h          |   9 ++
 3 files changed, 242 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/clk-sccg-pll.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 4893c1f..b87513c 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -12,7 +12,8 @@ obj-y += \
 	clk-pllv1.o \
 	clk-pllv2.o \
 	clk-pllv3.o \
-	clk-pfd.o
+	clk-pfd.o \
+	clk-sccg-pll.o
 
 obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
 obj-$(CONFIG_SOC_IMX21)  += clk-imx21.o
diff --git a/drivers/clk/imx/clk-sccg-pll.c b/drivers/clk/imx/clk-sccg-pll.c
new file mode 100644
index 0000000..886ae03
--- /dev/null
+++ b/drivers/clk/imx/clk-sccg-pll.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2018 NXP.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+
+#include "clk.h"
+
+/* PLL CFGs */
+#define PLL_CFG0	0x0
+#define PLL_CFG1	0x4
+#define PLL_CFG2	0x8
+
+#define PLL_DIVF1_SHIFT	13
+#define PLL_DIVF2_SHIFT	7
+#define PLL_DIVF_MASK	0x3f
+
+#define PLL_DIVR1_SHIFT	25
+#define PLL_DIVR2_SHIFT	19
+#define PLL_DIVR1_MASK	0x3
+#define PLL_DIVR2_MASK	0x3f
+#define PLL_REF_SHIFT	0
+#define PLL_REF_MASK	0x3
+
+#define PLL_LOCK	31
+#define PLL_PD		7
+
+#define OSC_25M		25000000
+#define OSC_27M		27000000
+
+struct clk_sccg_pll {
+	struct clk_hw	hw;
+	void __iomem	*base;
+};
+
+#define to_clk_sccg_pll(_hw) container_of(_hw, struct clk_sccg_pll, hw)
+
+static int clk_pll1_is_prepared(struct clk_hw *hw)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	return (val & (1 << PLL_PD)) ? 0 : 1;
+}
+
+static unsigned long clk_pll1_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val, divf;
+
+	val = readl_relaxed(pll->base + PLL_CFG2);
+	divf = (val >> PLL_DIVF1_SHIFT) & PLL_DIVF_MASK;
+
+	return parent_rate * 2 * (divf + 1);
+}
+
+static long clk_pll1_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	unsigned long parent_rate = *prate;
+	u32 div;
+
+	div = rate / (parent_rate * 2);
+
+	return parent_rate * div * 2;
+}
+
+static int clk_pll1_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+	u32 divf;
+
+	divf = rate / (parent_rate * 2);
+
+	val = readl_relaxed(pll->base + PLL_CFG2);
+	val &= ~(PLL_DIVF_MASK << PLL_DIVF1_SHIFT);
+	val |= (divf - 1) << PLL_DIVF1_SHIFT;
+	writel_relaxed(val, pll->base + PLL_CFG2);
+
+	/* FIXME: PLL lock check */
+
+	return 0;
+}
+
+static int clk_pll1_prepare(struct clk_hw *hw)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base);
+	val &= ~(1 << PLL_PD);
+	writel_relaxed(val, pll->base);
+
+	/* FIXME: PLL lock check */
+
+	return 0;
+}
+
+static void clk_pll1_unprepare(struct clk_hw *hw)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base);
+	val |= (1 << PLL_PD);
+	writel_relaxed(val, pll->base);
+}
+
+static unsigned long clk_pll2_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val, ref, divr1, divf1, divr2, divf2;
+	u64 temp64;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	switch ((val >> PLL_REF_SHIFT) & PLL_REF_MASK) {
+	case 0:
+		ref = OSC_25M;
+		break;
+	case 1:
+		ref = OSC_27M;
+		break;
+	default:
+		ref = OSC_25M;
+		break;
+	}
+
+	val = readl_relaxed(pll->base + PLL_CFG2);
+	divr1 = (val >> PLL_DIVR1_SHIFT) & PLL_DIVR1_MASK;
+	divr2 = (val >> PLL_DIVR2_SHIFT) & PLL_DIVR2_MASK;
+	divf1 = (val >> PLL_DIVF1_SHIFT) & PLL_DIVF_MASK;
+	divf2 = (val >> PLL_DIVF2_SHIFT) & PLL_DIVF_MASK;
+
+	temp64 = ref * 2;
+	temp64 *= (divf1 + 1) * (divf2 + 1);
+
+	do_div(temp64, (divr1 + 1) * (divr2 + 1));
+
+	return (unsigned long)temp64;
+}
+
+static long clk_pll2_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	u32 div;
+	unsigned long parent_rate = *prate;
+
+	div = rate / (parent_rate);
+
+	return parent_rate * div;
+}
+
+static int clk_pll2_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	u32 val;
+	u32 divf;
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+
+	divf = rate / (parent_rate);
+
+	val = readl_relaxed(pll->base + PLL_CFG2);
+	val &= ~(PLL_DIVF_MASK << PLL_DIVF2_SHIFT);
+	val |= (divf - 1) << PLL_DIVF2_SHIFT;
+	writel_relaxed(val, pll->base + PLL_CFG2);
+
+	/* FIXME: PLL lock check */
+
+	return 0;
+}
+
+static const struct clk_ops clk_sccg_pll1_ops = {
+	.is_prepared	= clk_pll1_is_prepared,
+	.recalc_rate	= clk_pll1_recalc_rate,
+	.round_rate	= clk_pll1_round_rate,
+	.set_rate	= clk_pll1_set_rate,
+};
+
+static const struct clk_ops clk_sccg_pll2_ops = {
+	.prepare	= clk_pll1_prepare,
+	.unprepare	= clk_pll1_unprepare,
+	.recalc_rate	= clk_pll2_recalc_rate,
+	.round_rate	= clk_pll2_round_rate,
+	.set_rate	= clk_pll2_set_rate,
+};
+
+struct clk *imx_clk_sccg_pll(const char *name,
+				const char *parent_name,
+				void __iomem *base,
+				enum imx_sccg_pll_type pll_type)
+{
+	struct clk_sccg_pll *pll;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->base = base;
+	init.name = name;
+	switch (pll_type) {
+	case SCCG_PLL1:
+		init.ops = &clk_sccg_pll1_ops;
+		break;
+	case SCCG_PLL2:
+		init.ops = &clk_sccg_pll2_ops;
+		break;
+	}
+
+	init.flags = 0;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	pll->hw.init = &init;
+
+	clk = clk_register(NULL, &pll->hw);
+	if (IS_ERR(clk))
+		kfree(pll);
+
+	return clk;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 13daf1c..12b3fd6 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -21,6 +21,11 @@ enum imx_pllv1_type {
 	IMX_PLLV1_IMX35,
 };
 
+enum imx_sccg_pll_type {
+	SCCG_PLL1,
+	SCCG_PLL2,
+};
+
 struct clk *imx_clk_pllv1(enum imx_pllv1_type type, const char *name,
 		const char *parent, void __iomem *base);
 
@@ -30,6 +35,10 @@ struct clk *imx_clk_pllv2(const char *name, const char *parent,
 struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
 			     void __iomem *base);
 
+struct clk *imx_clk_sccg_pll(const char *name, const char *parent_name,
+			     void __iomem *base,
+			     enum imx_sccg_pll_type pll_type);
+
 enum imx_pllv3_type {
 	IMX_PLLV3_GENERIC,
 	IMX_PLLV3_SYS,
-- 
2.7.4

