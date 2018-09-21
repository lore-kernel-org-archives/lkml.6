Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F930C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E3221523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="psSecIkh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E3221523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389670AbeIUSBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:01:23 -0400
Received: from mail-ve1eur01on0040.outbound.protection.outlook.com ([104.47.1.40]:64768
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389022AbeIUSBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYnsxzx8+u2/NB+qR8nsrdqebMlyvbM5dffhCsbk/Ow=;
 b=psSecIkhrOSrcSanvK0LC5JlSDjIz3m6ii2G+kxBjGZxW+OToMJKUEDBeMqrUHqgi+SObwgxewe5WsJYss+7g10OVY4yWIErU4OpYbWkQkDfNYzvyKhKua58C5f278IjeVq/3aeeVKtUryhh7ghqk1mYkkqJyXE5H4Bn9+ZYYCc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 VI1PR04MB1614.eurprd04.prod.outlook.com (2a01:111:e400:596b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Fri, 21 Sep
 2018 12:12:08 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-imx@nxp.com, Abel Vesa <abelvesa@linux.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE),
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK)
Subject: [PATCH v8 3/5] clk: imx: add SCCG PLL type
Date:   Fri, 21 Sep 2018 15:11:32 +0300
Message-Id: <1537531894-18499-4-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537531894-18499-1-git-send-email-abel.vesa@nxp.com>
References: <1537531894-18499-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: VI1PR0602CA0014.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::24) To VI1PR04MB1614.eurprd04.prod.outlook.com
 (2a01:111:e400:596b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 034269f9-e379-4e14-cacf-08d61fbb7499
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1614;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1614;3:Pms3X+hqKP3HOg/xkmxfP3w1hd78mn/tIbAG0odPCroXq/9FRUmR7jjiOQVrwxlRXtzUKELWVajaoZiXWgwi51/Qw02jDMUUWtf5DD8FL/Itb0+MIDbfwNmv6GYOE055hnX3JBIJv+ld4xApGhy7mAIE/uH7/zGXybsqkCRSZX2ahDUd7ueBugjxki5GjCL6JAOPOYItFDLB3UCxL2cNaVKpv62/nGuhnlEW013C0vKJI9BgjD4aDhue8xzZPgYU;25:UfhX1aR0qEqDQCmlSPYjNcQQZoU6y848kvK2jD8IGGTXLCjtk9NoPjNx5OjwN5yjwi886Xvcd4mmKceVZCAdgkE4UEvsTlDTAe25+hFEOco02ixoekyfQPxLXYgZuDhh4tax8FyQtPbeRZXivTs+PeuG1y6hn53UXdRmA8c8OZAxG/esvpoHDCe+Gp/2GeIwINQsY8Xq3yBHd0pFpnnK595BtpcuGhbk+0x7aEBByBNq7YunvBmrBJtkO0pkBup8/ziLFgFOeKmYBGDB5MD3+HYtRwyf1RR8008EMGhfiu2+hL2ihEFIcmH6aJlVa9n9W5Jz06zz9dMhj4AFR5lOgg==;31:WFqwVpnZBCsZZzi+Bb3TG1R1xrA/tFhH/Dqt0G5UXk4q4svoJxOzr8MBGBQTKgeaVp9KIRIjO6a5i/nR93ZNW+Fbn0YYEbi1CvSMs035k6Sb4XHbfqWxUNChyGw1NoQDtVhlApNKqrEvD3GHCYSkaH+zfy5KDwSBS/YOqDEIQYK3Z6fAc6jjlLwG4aD5RzYJdPbQqyACPUVzSkHFuI/RQ7b7PfGCh1VMtmEeBOKiB/8=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1614:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1614;20:BQ8u8PDNRj2jst01X0k5AxPJQZYgnUbcl9TsnYVj5mknMu3UFTHZYOihSJRCYnI+Dp87Y12vIiP6P6QGRh5K/1vUQJqfVJVaaDsQLYAzshSp/Y5OVJIgg3BijB9dshQpBanjS1aYNiT65QYcHua8QMy/1E7mXbthvc89MzDP/lkC5CmAHFrd6BjvpkiT3LoPjIBvNw1e4yKmwj1D/FFnhFtvTld8msHIQZbkRJyKrRNVXJKlkRkvvuuSfl7hN2m5njMEsFcnSI086ElFHext3voz9b3RvPi7RvDDnqO4BF0g+ROlDlqXUR6vwdnHwdmmG56TuFmJTviPI3mBuq+jjYBpRDNhGRYRCSud5Z0pcDtZcATk8OjKndOyglfvzQedF4QTdhZ8F4m1DZa26isQbM1ARK38nj4R44OMIj1WP9eXQueqUEpFmCeAN1P1jEufETWk6Rhs6w9czw713ji+NlPiwGgKUC7vefXUzG3VMuc58pKfqrj4GzTPKL+JLIA5;4:HXQ+fQz/gf3VVLuzMP3FtjdgEJGhSgldaQryT8U4YztN7CB5S974IS0uxXRJrLDmVBtm0U0zRyXPgLPDf+/SkchpUF0gj3LFUkktdLA1go75DHvKjrxZuYYI+o7GZzq4H+vkH7JbtdPbwx/3dB557hZoUF2TUajus7O9GYmiOQSMJPAylH6GA6kmUmovnTW+PXoijDm/f5o/OF44uijZksR63YT93zJYXakJ2WODrMxQ3I+DrNU3w/GB3W0nx6F62hXULMkRYlzdfQ93v4Fko9CMIjxvsym6J70Xg4+FzHjD+inEvH2F47wrkvmFtBFa
X-Microsoft-Antispam-PRVS: <VI1PR04MB1614BF6C3621DB9050D21563F6120@VI1PR04MB1614.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB1614;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1614;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(376002)(366004)(189003)(199004)(97736004)(36756003)(4326008)(6666003)(25786009)(6512007)(186003)(16526019)(2906002)(47776003)(8936002)(81156014)(81166006)(8676002)(16586007)(66066001)(50226002)(6486002)(6116002)(478600001)(54906003)(217873002)(110136005)(14444005)(68736007)(3846002)(51416003)(486006)(76176011)(26005)(7416002)(106356001)(386003)(6506007)(44832011)(52116002)(86362001)(5660300001)(316002)(2616005)(956004)(476003)(105586002)(11346002)(446003)(39060400002)(48376002)(50466002)(53936002)(305945005)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1614;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1614;23:El/OxQgo8H2vEWamloMxM+dWh02FCaQHizmlDCL4c?=
 =?us-ascii?Q?Y7MK1qGlyniJ953AUK00cxrgISJOE5inbppb2GPB9FGtQUd8fZvFT4mKdYcR?=
 =?us-ascii?Q?157znHiH9ioMBRrje6/zxkopS4fVSl6RRXsV7l4ClrRdTIPSTOrcNpo81KVA?=
 =?us-ascii?Q?LsHGqKskY0onctmVdWwW4OdXGM5+LZFsMk3Ofa+Q3+cQyb2J8AEq0rQdxFBH?=
 =?us-ascii?Q?45dXvyUn57cqzOUD+n1myGwhG/UNFCzES9gXOo/LFN8noqmELedo8D7bUys5?=
 =?us-ascii?Q?HkT6nh3UqbYWLQcCYB3Yd9fq70H6rfUpQKsWJhS5D8bCnQcCoPlMXDe78RNv?=
 =?us-ascii?Q?JQyldO0+MxKr7Qo+FSlHNm7kn/K5lxVqjh5VMdEd6vLUwQvXB0kJKAufDOzk?=
 =?us-ascii?Q?wIcdzNSfwJeiMxMFdiEKXE0nyEonvpXhtuqMDIE7nLxLDT9MD+5SdT/vexlp?=
 =?us-ascii?Q?xzoKnKWq1puOdUOYt9E7eukBnTawLwmp1Kuc1hzcQiLOAPGQZ20+AQZkSMsZ?=
 =?us-ascii?Q?W1K326uPdU0O3pJvW5gP6HqBR8P6kbXiTtBrneIcsGEriStN2u5xZrnOXDEh?=
 =?us-ascii?Q?CW5auyEFSjdeBYhOBXEHTCRj93kvDPc1X+QriPWa+8djzlVggpTlz7NuxsxR?=
 =?us-ascii?Q?fbc+6K19UoxlPy0xVX1j8R5v+lQ7b5BkMad3UG3DOW1OnC0J14iTLlHyw0ob?=
 =?us-ascii?Q?X3wMxfwVkEiA4KiN6l7AEqAL3y/qOypRzBtF0vU8TSly/Yg0RJ9tlRO87fZW?=
 =?us-ascii?Q?V0DCQ59VI+7+Z0lIZ8XgJJw0rnezdZ3AWHa4cYmTL7M1wvEYB4lAtYGtiTHn?=
 =?us-ascii?Q?kegj1I2MRwgEGI4DYcNc+ZQFSbuYU7fR1pYh5mFALYzn6ngN80I8/iUNmTJF?=
 =?us-ascii?Q?SnW+Jp4OC712erzSPr5w/CpX9jPIHso8ncIusD2PSyk1goFVmX08SY0eUCiL?=
 =?us-ascii?Q?rb40E3Cp7uKZWBhuof0lNALOvpJByrJOKhjRCezzjcamgaROBNtQphflVKF7?=
 =?us-ascii?Q?34jYFpLuC5qWW7wyTuC0M3QhTKmXDNd4SJKVmwMEpGA7fkXlnx11xsRSJG3w?=
 =?us-ascii?Q?oUQiJqVS3u6eCypYs5DxaC6GFlS12WkBBoQ6BH7eUxrnUO1VvizhTT6kbq9I?=
 =?us-ascii?Q?YMtR1HUkXc9YyqBXbIgEI/FHCkS1swF5tWx1zMhghUrxLKbTbwfOgRx1wke4?=
 =?us-ascii?Q?0Hvw/9KdmYi/q+UsWyhLl0YTvgzhSf026KbbjCIYpDYXnc9v6wyOppmbZJxG?=
 =?us-ascii?Q?5YyWeVUAV4gStqqdFGjE0dECpI7NvkyPRwsBCfhRwisCX4uFgA9+x8x4MNqq?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: rPa5MrspJPLC/ImTRlhz6+ZjbxAF6kVSm9tLv32NEpgxpCCOSvp/C5rcpxnQPqZ8+4Vf4TqjK6kNnbKCfxnaGAb53pucmx5PVSw/oG87U1+KnbZ/EwSN8HnYcsl2atSToLpEbBdDeLAgg6fE8meTDSwjuKO+Y4JLGPs3IqjB5PgS2iazm+P/wg/qG/BQABwVDni8Mg+NtTyll4NIGMA3jdDfsKIdNQ3AaryjwHwC5BCsuG8v4xq2kl/UNpU4ffeA1FnMcv6JSTb4ez7YIpLtzrhWT/cP9jstcjnJ+5KouPpKD0x2NPp5M/IVYbI2TM/PShLW0kN94g3iyQWeDWY9GQ==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1614;6:nCT6nzeXUcntlvGmpv6Dm70trSUoDbYDwJUdzc3scRQqmhcaODYwIP27w0E+brbujUk10c7HDQDSi3PeDPqWN1+uK5HpoblqjEAbcuMwpR6++6M6MeuqwkvTMKVClsenN8W5hhKlnE1FY+xwu/gFhoXLYFrJHrdJ+u5bT5GNJfbV2Ok8odnTrCRcyBssaIWUoxWqiOQdyxgxe/6Wlt0o589n2TdrJbb5CDJdXts0ER7AnAlwadV/424mCjVMG80+bIT8RtCbxlOOThshJ1ne09lBaMLcKizOo3E+FAjuaiESHXKiqtoi/tdWGfhIcn6CuaAXwzgDwbhaaf9LV14GM1wH4ww7mP4+jgfhoGrdM+h8LTw4B+SjdnOezib4/B/+4JReQFacsesXcuVeVWcO4DxZyzYczpjqxsdV1WizJ/29sIRo0DMx0X+2mTV+T2lQZ4uNF5bRQw1jl27jX1pylw==;5:cBHfBeHMy3g1t3+5ivD6WgJ1ziZnpeQTFW9iQmduEFtribaFuPT/8POzSTkN6XlxEtpNEF1+4XWO73Al9w18lEMVzskijo8R6ps/7H0LzrqomgMNdbAd6XkWq9dSc/Idln4rwhtSQJsKL0Hgp5xH3JskELoOqYNhvA2FuEcsv3M=;7:KeUvt/MDs3A5xxXjtT46SNjNJeIOEGv+OXp8jJIM1sfKhXUIyjr+p7oDBA/N4/pZycus+SPxDG8num4ThUZDUvHBmtToGjFVJuu3OFmGvaXYGKMGLy4jjsOPHhNzP0tfa+wSLznWltUm6uqd/ElurOi/8qU954bpaBBddZUmpE7AaQhsrbf8jMErPoKXorf06bN8cJ66EoD91owShC+iwfDMkRTCDEBJTGezt9bG6583SDqDn+IjuTezZuaDxf4c
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 12:12:08.8053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 034269f9-e379-4e14-cacf-08d61fbb7499
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1614
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
 drivers/clk/imx/clk-sccg-pll.c | 237 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h          |   9 ++
 3 files changed, 248 insertions(+), 1 deletion(-)
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
index 0000000..a9837fa
--- /dev/null
+++ b/drivers/clk/imx/clk-sccg-pll.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2018 NXP.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/bitfield.h>
+
+#include "clk.h"
+
+/* PLL CFGs */
+#define PLL_CFG0		0x0
+#define PLL_CFG1		0x4
+#define PLL_CFG2		0x8
+
+#define PLL_DIVF1_MASK		GENMASK(18, 13)
+#define PLL_DIVF2_MASK		GENMASK(12, 7)
+#define PLL_DIVR1_MASK		GENMASK(27, 25)
+#define PLL_DIVR2_MASK		GENMASK(24, 19)
+#define PLL_REF_MASK		GENMASK(2, 0)
+
+#define PLL_LOCK_MASK		BIT(31)
+#define PLL_PD_MASK		BIT(7)
+
+#define OSC_25M			25000000
+#define OSC_27M			27000000
+
+#define PLL_SCCG_LOCK_TIMEOUT	70
+
+struct clk_sccg_pll {
+	struct clk_hw	hw;
+	void __iomem	*base;
+};
+
+#define to_clk_sccg_pll(_hw) container_of(_hw, struct clk_sccg_pll, hw)
+
+static int clk_pll_wait_lock(struct clk_sccg_pll *pll)
+{
+	u32 val;
+
+	return readl_poll_timeout(pll->base, val, val & PLL_LOCK_MASK, 0,
+					PLL_SCCG_LOCK_TIMEOUT);
+}
+
+static int clk_pll1_is_prepared(struct clk_hw *hw)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	return (val & PLL_PD_MASK) ? 0 : 1;
+}
+
+static unsigned long clk_pll1_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val, divf;
+
+	val = readl_relaxed(pll->base + PLL_CFG2);
+	divf = FIELD_GET(PLL_DIVF1_MASK, val);
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
+	val &= ~PLL_DIVF1_MASK;
+	val |= FIELD_PREP(PLL_DIVF1_MASK, divf - 1);
+	writel_relaxed(val, pll->base + PLL_CFG2);
+
+	return clk_pll_wait_lock(pll);
+}
+
+static int clk_pll1_prepare(struct clk_hw *hw)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val &= ~PLL_PD_MASK;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	return clk_pll_wait_lock(pll);
+}
+
+static void clk_pll1_unprepare(struct clk_hw *hw)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val |= PLL_PD_MASK;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
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
+	switch (FIELD_GET(PLL_REF_MASK, val)) {
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
+	divr1 = FIELD_GET(PLL_DIVR1_MASK, val);
+	divr2 = FIELD_GET(PLL_DIVR2_MASK, val);
+	divf1 = FIELD_GET(PLL_DIVF1_MASK, val);
+	divf2 = FIELD_GET(PLL_DIVF2_MASK, val);
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
+	val &= ~PLL_DIVF2_MASK;
+	val |= FIELD_PREP(PLL_DIVF2_MASK, divf - 1);
+	writel_relaxed(val, pll->base + PLL_CFG2);
+
+	return clk_pll_wait_lock(pll);
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
+	default:
+		kfree(pll);
+		return ERR_PTR(-EINVAL);
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

