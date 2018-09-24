Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEC6ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EB52145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QrNq4yb3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74EB52145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeIXQmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:42:51 -0400
Received: from mail-eopbgr50067.outbound.protection.outlook.com ([40.107.5.67]:14880
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbeIXQmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtHEEvRM2DMReWf5kbqx6ieAhRxAOteOVt4WK4r9rOY=;
 b=QrNq4yb3Q+IcSTLpPJ0jSiUnVnMLw/1IyMdHYs2fOjRelZ2WtDNhnWMqn9ldUrdVYyzXlkI0ivhykCLTO1zJVi6ozXjEDjGn6Pn5DPQUoxp6/ZqpcCF5YrfBKexqYQ9Fjmj3jW/RjpUiBwpdVWnC6/Q0n/6KPxGfPAHlCTGvAmc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 VI1PR04MB1616.eurprd04.prod.outlook.com (2a01:111:e400:596b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Mon, 24 Sep
 2018 10:40:43 +0000
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
Subject: [PATCH v9 2/5] clk: imx: add fractional PLL output clock
Date:   Mon, 24 Sep 2018 13:39:54 +0300
Message-Id: <1537785597-26499-3-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: VI1PR0102CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::16) To VI1PR04MB1616.eurprd04.prod.outlook.com
 (2a01:111:e400:596b::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92dbe092-d77b-46c4-ebed-08d6220a2e1e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1616;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1616;3:o8rZGqQLzBYmrJSH6D5Nc9JEnawbo1qGbogrBtIfnHzFIedUHv2T64TC/t2MKsk50/a8KiIyRo+1gsTPK4W4YaMBSepk5S3lGscxheWup2xZJFqkdI6Rg2tTVlORRvMx2qn1O4ctIWagFJIuv+VDK8a9RSEn5NUAkAG3/09v3CHVXULVdvgPLNU7LOlhlV7e3GtiUZZWPN/X50BW0mPO3JwrK7wzwAgoesr9UFgo/Z+dxw9CAw/xpb6u+sEgq/jm;25:wFjSw5aJQ5tgbbWaKjjwXTsHEWc9MMUyaZ3NftS3BDTuLbTqPlpylp+FZ87HnP8WuilvjJXxLPJo7pjW4eN4bSfkgh96UKPjPPpx7M07pqUoU5Za78WlhFYngr9duTrJ0WvkhXsQkgyK4Hlwh1Mphp6Wdfyc6Q0nn0lvY8EKV+hkaI+kWLboc3IxDoU4dPfVFUkznuAszn6HixOS2NHPs+JE+l9oG55oonpY2tKOoa44Q+NOvCzsaZ8+FVq1RxszEDxL4Qo1ehejmFO/AO5jafLM2g3n2dB6hh5Uq17G0Q83LziVKdpNuQtqXXadaopepKt5G7jYi3C/jYxoOKo6WSA1FK2y4gvS3Ev1896ynwo=;31:ot0+oHFxShkiHpBkngtI4AreUYR7cPPaUqP/38+MTiyULtqy6ARru5vQCVx295VVkmrLQjDLnnTd6YNxk2K5NIDnul3vAk89cgQBW+/eqXa/jn3WeAtkylfx0roRM1qwvU8alnrJwe16Z6mAKACagbm8xBpHedlBVpBYb4rfZQieE95MCch8A2Wzbfa9uXyENf1tLDo8qb+dto+ux6o6condEb9DsqTQ7/XH4TEkEyI=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1616:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1616;20:Mox03TUESuKIcMBKhWfkhPCMTe25wtpoIcjCJ1qsa3kJitccSGwgP4wx4ja6P1y7Eks9+XcfEjXHNQI3n4FkUbPvuUK8sr5HZ/A+IlmENq2UfwhXlAWLi2rmN01cVshMh6zKW2fo1m4nK1dslvPASfGtanuEl+accw5xmcHxML3M9c/RJKr2u5xax26y7TKNyCh/fW7YHdMHSDwxLYECjDXYcap1ljAWlFfGT6s4ppc88x+/i1njmsuUNx3jrGyc45XiPTthRT8hMLC/fTLSwa87m9vCTuKsP6gwxD+VbeIzgOEiC09uTdvJzPfybLWRtD2kusiP+9Pyi1fchQ4nsF4/E4VycdJMS2nuosqO5MJHJG2xjBoxKAoJDjCXX5yr7Z35P+NNB2KZwMEF+cM2y3x6QbIuscv2Ev9iJ42CaKzsNRrqguo5LFSct/uUfWJ01W14mUEdokr9K7xFl6O3R4jI4KJNlSdMDwSdBRbSAA3F776tlkUlJVvmOjwHREgk;4:I6QQ08Zk42rOoOIpNudxvA6LyRIpcjQqARRzVElP/N2+fPSxMrItf2UtJSQ5ufcd4b1NZb6e3GNyWqDJoc1PO3vz70Rhf9DvBcCSDbz+BXcD9RS0TQMDvmmxBRIv5ZpFOuIGg9C2m9QZH/FiN4JZKwyEcwIedbTsJYLzOtyTGYrKbWdbayVMQJwrbPhghIOYMo+lZDGOv2wxk8wcAHejsawRS68IaojZ2z6mndFPS1pvE9RQOBojBe2BKZEiBCXeoiaLsVCvgPkqytHpAP+6A0kvIuEf2SNHfb8dTGfidPysNLhmdFclEygEO0fub9ZR
X-Microsoft-Antispam-PRVS: <VI1PR04MB16164640D896A0FF75B66E3EF6170@VI1PR04MB1616.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:VI1PR04MB1616;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1616;
X-Forefront-PRVS: 0805EC9467
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(136003)(346002)(376002)(199004)(189003)(52116002)(51416003)(14444005)(48376002)(50466002)(36756003)(76176011)(53936002)(6506007)(478600001)(44832011)(4326008)(6486002)(6512007)(25786009)(26005)(186003)(16526019)(386003)(11346002)(446003)(486006)(476003)(2616005)(956004)(8936002)(50226002)(2906002)(68736007)(81156014)(7416002)(81166006)(8676002)(47776003)(66066001)(105586002)(6116002)(3846002)(305945005)(106356001)(97736004)(5660300001)(39060400002)(110136005)(6666003)(54906003)(316002)(86362001)(16586007)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1616;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1616;23:kw6A6PdZu1cwk/OFmohaIJ41vWaz6KPSnPGPZgmO4?=
 =?us-ascii?Q?U1ZWqF+5TvFXWBAFD2InfdaBQHZ7MX1XKWmhUJ3LmHhLFvMfCj/vhaQI0Tco?=
 =?us-ascii?Q?baMLMzFcwPRphkdZ2BdlpoitkfstKySYTFB2twE/wmcKpW05O6xbOMgfEivA?=
 =?us-ascii?Q?5n2xicRPVroSqrgVQmHnOA2W4YTcRwxeK4X9UZgrkmBHerUW0DCf8TuAJShi?=
 =?us-ascii?Q?lJKMwVnhFg8I8pmwCF9oEf/lMrVhRSbynuwNXvSauiHCTvJi5tPr1AD0ZiiS?=
 =?us-ascii?Q?fH0x6kST4mZZE8zXWA9hFW/Cp9ftoOrniUVIw3c2Q0BsxHKnYNsHKF5XkDyo?=
 =?us-ascii?Q?98P7PI3+dhukupakazA/zJwz2K5Y9zmO/KNY6dBxYdgH5U7+bURe94UAa5tl?=
 =?us-ascii?Q?gosQG1vLxPBAt7Sx2f9DI3GQ0WFWqpaHI7RLI4dpelnuSODmTY0CMWTLVi69?=
 =?us-ascii?Q?qLOO4KXZgEZ9WV69jrj+tbfVMqSQk8MA9Qjo+7TcPS4L/STh3vxwTlE0bG2M?=
 =?us-ascii?Q?eh03lGcNl08vUDO20y09c6TN25Nsk+i2pQ5P2NRGmmcmsGFWGstb7Mx1mee/?=
 =?us-ascii?Q?4hVinCH5amxwSksQqbrGei2kRxryKR+QkRlYIZWOqyR7xExMjmMUMEWyrKfQ?=
 =?us-ascii?Q?g6nGOmE6dO+sKeBOGI18CHJFcjathZJ0JYV5ofwJ5JM2/ifoDu0bG62MfnEt?=
 =?us-ascii?Q?KIbvMe8iyDnl/DelyHcehXLp/gm4WQmOMgVZ+bs6M+ryQu3TSD6zlV5zoIdi?=
 =?us-ascii?Q?ZqIggTAca5L7+X4Z29SSGkK4FuJb+LObL3G6rC0mjF9MTej5XnYKzkiohorZ?=
 =?us-ascii?Q?1z0LeYYa4vKYunxZYaw7orTApYhn0CmZsShWInlJClJxmWqfY+umY0WmUUpV?=
 =?us-ascii?Q?vCOFNJCDqDbbjwasHfGHOke8G6TGW1B51wyGCMyGW5Xe6vojFRSHBACBaeJ+?=
 =?us-ascii?Q?OOE1rbXY1i3vpurx5FS5IA08aPD+6mLh/vuDEMIq6SVj3gM85OAB1nP09Aa3?=
 =?us-ascii?Q?c5YN09wc7UmLTRoTyepcPwwCFRVjRvHplJMJ7t6Ew6brxteaHjmZybjRwKBa?=
 =?us-ascii?Q?fZLX0j0DxKlvXoR/ovEI8TUVcETPqaFvCB5OD5IvhwG40YhByB4UMtxY/4+8?=
 =?us-ascii?Q?Uo/0b4wjXhenMwIOloBDic5nlAKl5OpWG6mrJ7oCm/gmF9Gb76hRl+yUZStX?=
 =?us-ascii?Q?elvtaHnZjJc0fll1sHSz4Ukqhg8+2BI5JDH9YRPPA0MJoqAl51JbkOzloeFR?=
 =?us-ascii?Q?JfJbxnJ5HX4AWhXCud/h2oBc056slkA9ZSsuGFq?=
X-Microsoft-Antispam-Message-Info: EWDEfbeCRlTajzNF1z3iyu5JHEo9rpmf7qywSUxmqDgsTnmXxHS8JkorafL704bEPipuqTRTs3sJmi8tHGxSCvZBWlvi1QiGHNIQu2XQUcFq0Hnr13MK7pE+TVCLKPFrGiDbuAb1JfoNQ7L6NFCBf5gb1BtzdqOLajJaoJfh+97JsLHZMNYgn/2t2n1WuV+qSBZHn91ZXLtDLu7LAt4FQvxS0j5wis1kPAuhD+V7uqKF8OHEAXxKi74TsrigjncidLzqG46JbO4wDvkxgTUMKJ1vqYMTCBbMjQyNlyp2PLsIpDp9fK5uA9OY3fYbmQ/tPCITYflPWaW2ye17jtJ2kBcpFlrUPk1gjOQyNyq1tdM=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1616;6:kYIhDgBdbkdeKxBxKBfAChvQrjfRh47TUkZrGH79Hvsin7BUxqW5/Mu4xFrqZ49BzoJAUdtjmcBWWyA/kWHrO8gzzrj0PJNwG0/ukam6ierrlFIJ3gGeW2H7dluUvsxdnL/B8niMdk+tHtLEY4k70P+Cpu/KZz+7g9FcMpEi7TL02uPHFwp577F+amtxgn1auQlEvRoLH8572L4Ggvkcju2NWvTc3JmCO4iQEw64IqGy2PuKDtdyrZR8O6OaBbOyPAFSXq9u6q1ta9xZoFfkwzrm898vPXc61p5ko7sO3WkfJ36PfZJ3zLIdY52wp5l+MuVrY/2QoU7iPbVmw/i5PFO7WFqz9yJLLbiIql0/qlVsCGRW73E/S9Xs7HdpH3Wq9MZdSK+EJRQW93eTtlAuOfEPd6bmsoMEWgjwReQnSGhNKq66ypGXnd/u4jYjQ1CTkCDBUD5PA9md7OXlctVXfw==;5:PW3+Ml8NxQxII5d16I+eDx0kjJq0u6tex/gbaT9CpQ1xw9SriZUC2pZA4a9BGGvrKEdFOfXMKQREZv9+KcepjeSivB4FffKAx/ThL95eXlcHQJWige29CkXG2OgrYB5nnigBX8bT/ipYCIdVCwAuA0aj2sidHqSruPDFJahpUOw=;7:vjDSlaDU2xTUvMVzRbupjPkqMwU2hq0ofzyM25z+hBeFZgPmn/FjJ/DbGHzvVH0CiPvsBpRpIF8W5NSY81Mks5xUNVo+qTrgQjrIfyxSVdW4T1GOUKvCjZj0DZya7D3zejcc3eL46fl/LqEcbEICJ1/Fn63cD6zOO3eFX+H7npLIW0LI7UJeNa/T6+05wQUsb4js/zOZbMKPjKpCyArxPjASd+cyEbmAoFN+KeRBxStx3o6PqXsgp0CbyTJT7wVM
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2018 10:40:43.1393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92dbe092-d77b-46c4-ebed-08d6220a2e1e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1616
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This is a new clock type introduced on i.MX8.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/Makefile       |   1 +
 drivers/clk/imx/clk-frac-pll.c | 215 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h          |   3 +
 3 files changed, 219 insertions(+)
 create mode 100644 drivers/clk/imx/clk-frac-pll.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 8c3baa7..4893c1f 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -6,6 +6,7 @@ obj-y += \
 	clk-cpu.o \
 	clk-fixup-div.o \
 	clk-fixup-mux.o \
+	clk-frac-pll.o \
 	clk-gate-exclusive.o \
 	clk-gate2.o \
 	clk-pllv1.o \
diff --git a/drivers/clk/imx/clk-frac-pll.c b/drivers/clk/imx/clk-frac-pll.c
new file mode 100644
index 0000000..030df76
--- /dev/null
+++ b/drivers/clk/imx/clk-frac-pll.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 NXP.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/jiffies.h>
+#include <linux/slab.h>
+#include <linux/bitfield.h>
+
+#include "clk.h"
+
+#define PLL_CFG0		0x0
+#define PLL_CFG1		0x4
+
+#define PLL_LOCK_STATUS		BIT(31)
+#define PLL_PD_MASK		BIT(19)
+#define PLL_BYPASS_MASK		BIT(14)
+#define PLL_NEWDIV_VAL		BIT(12)
+#define PLL_NEWDIV_ACK		BIT(11)
+#define PLL_FRAC_DIV_MASK	GENMASK(30, 7)
+#define PLL_INT_DIV_MASK	GENMASK(6, 0)
+#define PLL_OUTPUT_DIV_MASK	GENMASK(4, 0)
+#define PLL_FRAC_DENOM		0x1000000
+
+#define PLL_FRAC_LOCK_TIMEOUT	10000
+#define PLL_FRAC_ACK_TIMEOUT	500000
+
+struct clk_frac_pll {
+	struct clk_hw	hw;
+	void __iomem	*base;
+};
+
+#define to_clk_frac_pll(_hw) container_of(_hw, struct clk_frac_pll, hw)
+
+static int clk_wait_lock(struct clk_frac_pll *pll)
+{
+	u32 val;
+
+	return readl_poll_timeout(pll->base, val, val & PLL_LOCK_STATUS, 0,
+					PLL_FRAC_LOCK_TIMEOUT);
+}
+
+static int clk_wait_ack(struct clk_frac_pll *pll)
+{
+	u32 val;
+
+	/* return directly if the pll is in powerdown or in bypass */
+	if (readl_relaxed(pll->base) & (PLL_PD_MASK | PLL_BYPASS_MASK))
+		return 0;
+
+	/* Wait for the pll's divfi and divff to be reloaded */
+	return readl_poll_timeout(pll->base, val, val & PLL_NEWDIV_ACK, 0,
+					PLL_FRAC_ACK_TIMEOUT);
+}
+
+static int clk_pll_prepare(struct clk_hw *hw)
+{
+	struct clk_frac_pll *pll = to_clk_frac_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val &= ~PLL_PD_MASK;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	return clk_wait_lock(pll);
+}
+
+static void clk_pll_unprepare(struct clk_hw *hw)
+{
+	struct clk_frac_pll *pll = to_clk_frac_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val |= PLL_PD_MASK;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+}
+
+static int clk_pll_is_prepared(struct clk_hw *hw)
+{
+	struct clk_frac_pll *pll = to_clk_frac_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	return (val & PLL_PD_MASK) ? 0 : 1;
+}
+
+static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_frac_pll *pll = to_clk_frac_pll(hw);
+	u32 val, divff, divfi, divq;
+	u64 temp64;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	divq = ((val & PLL_OUTPUT_DIV_MASK) + 1) * 2;
+	val = readl_relaxed(pll->base + PLL_CFG1);
+	divff = FIELD_GET(PLL_FRAC_DIV_MASK, val);
+	divfi = (val & PLL_INT_DIV_MASK);
+
+	temp64 = (u64)parent_rate * 8;
+	temp64 *= divff;
+	do_div(temp64, PLL_FRAC_DENOM);
+	temp64 /= divq;
+
+	return parent_rate * 8 * (divfi + 1) / divq + (unsigned long)temp64;
+}
+
+static long clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	unsigned long parent_rate = *prate;
+	u32 divff, divfi;
+	u64 temp64;
+
+	parent_rate *= 8;
+	rate *= 2;
+	divfi = rate / parent_rate;
+	temp64 = (u64)(rate - divfi * parent_rate);
+	temp64 *= PLL_FRAC_DENOM;
+	do_div(temp64, parent_rate);
+	divff = temp64;
+
+	temp64 = (u64)parent_rate;
+	temp64 *= divff;
+	do_div(temp64, PLL_FRAC_DENOM);
+
+	return (parent_rate * divfi + (unsigned long)temp64) / 2;
+}
+
+/*
+ * To simplify the clock calculation, we can keep the 'PLL_OUTPUT_VAL' at zero
+ * (means the PLL output will be divided by 2). So the PLL output can use
+ * the below formula:
+ * pllout = parent_rate * 8 / 2 * DIVF_VAL;
+ * where DIVF_VAL = 1 + DIVFI + DIVFF / 2^24.
+ */
+static int clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct clk_frac_pll *pll = to_clk_frac_pll(hw);
+	u32 val, divfi, divff;
+	u64 temp64;
+	int ret;
+
+	parent_rate *= 8;
+	rate *= 2;
+	divfi = rate / parent_rate;
+	temp64 = (u64) (rate - divfi * parent_rate);
+	temp64 *= PLL_FRAC_DENOM;
+	do_div(temp64, parent_rate);
+	divff = temp64;
+
+	val = readl_relaxed(pll->base + PLL_CFG1);
+	val &= ~(PLL_FRAC_DIV_MASK | PLL_INT_DIV_MASK);
+	val |= ((divff << 7) | (divfi - 1));
+	writel_relaxed(val, pll->base + PLL_CFG1);
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val &= ~0x1f;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	/* Set the NEV_DIV_VAL to reload the DIVFI and DIVFF */
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val |= PLL_NEWDIV_VAL;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	ret = clk_wait_ack(pll);
+
+	/* clear the NEV_DIV_VAL */
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val &= ~PLL_NEWDIV_VAL;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	return ret;
+}
+
+static const struct clk_ops clk_frac_pll_ops = {
+	.prepare	= clk_pll_prepare,
+	.unprepare	= clk_pll_unprepare,
+	.is_prepared	= clk_pll_is_prepared,
+	.recalc_rate	= clk_pll_recalc_rate,
+	.round_rate	= clk_pll_round_rate,
+	.set_rate	= clk_pll_set_rate,
+};
+
+struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
+			     void __iomem *base)
+{
+	struct clk_init_data init;
+	struct clk_frac_pll *pll;
+	struct clk *clk;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->base = base;
+	init.name = name;
+	init.ops = &clk_frac_pll_ops;
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
index 8076ec0..13daf1c 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -27,6 +27,9 @@ struct clk *imx_clk_pllv1(enum imx_pllv1_type type, const char *name,
 struct clk *imx_clk_pllv2(const char *name, const char *parent,
 		void __iomem *base);
 
+struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
+			     void __iomem *base);
+
 enum imx_pllv3_type {
 	IMX_PLLV3_GENERIC,
 	IMX_PLLV3_SYS,
-- 
2.7.4

