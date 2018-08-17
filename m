Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F9CC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8A021896
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="COfybS2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F8A021896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeHQRPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:15:20 -0400
Received: from mail-he1eur01on0045.outbound.protection.outlook.com ([104.47.0.45]:15904
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727213AbeHQRPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:15:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dV++oeJYvJ+QTsW96ol5AhcKSF+hiBvprwOZ++xwZ2k=;
 b=COfybS2DfwCdL+mko/mXoJn13gfdgpF/x0A4Z8x+pD5zf9KwkFfd/ZCTVpN6h/nI/xce5l0uKQdpS7qoEgYHmpY/PQaqXucYPWoSvv0J79Onh4yqxbmr1CF/Ssa/E5kR5xUeahDrvTTXlseK8Nmd/rViPGB2LtBq+3YE5SjuAYI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 AM4PR04MB1601.eurprd04.prod.outlook.com (2a01:111:e400:59e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.23; Fri, 17 Aug
 2018 14:11:31 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Cc:     linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v5 4/5] clk: imx: add imx composite clock
Date:   Fri, 17 Aug 2018 17:10:45 +0300
Message-Id: <1534515046-18529-5-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534515046-18529-1-git-send-email-abel.vesa@nxp.com>
References: <1534515046-18529-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1PR05CA0200.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::24) To AM4PR04MB1601.eurprd04.prod.outlook.com
 (2a01:111:e400:59e5::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed7cd202-82ac-420f-5a68-08d6044b5611
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR04MB1601;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;3:dzkdbP6TFwAGXtklCjSTNUMtumR2vGLGOOEQBXN/arllvDpAQ8Bu4WMJjKo+6Uzzu5N5XGhiCAlh7vKQM6kA9rZG8ZQhrYWFwl6QlQEnNr12KniNTx4Ar7/7vcxU3LxsvIoJMZ9ahtVf3WoejMb6NJPzXrIwUyhoO9Lxir61sCGZG6XRAiAVOdR7+DqKQxxCXWWtfNdtdayNvyOYZ3TxafykOXpZV+eHsc1RMks8Vc0vsIGHozjZdTg+FT0XAUM2;25:MhCMeiPY44OHfILTvxuKAyaU8RkKUqyKFf6nuYBjXiuwSD77L5sJHx8H9CuWKkVo5XJ1Cm7Qsf4BKcyFl7LOGvfEY+00hmxxPN0WC/+YA0dXTWDekqFppFlWkWI5tB2LWkmy3H/bvjQW3H50WW73Av0GJ9G/QaYhxui76j0OSDi8RURMlyGtQ81AQp2qIepJ8lsbUgwAD862BLqSOUiamtQTuMOJHFepvSlV7lujz+NfcGhpw/rYNd4KEvwXvymdlqBkQLw66ICM6Nrg1oMoNNxAt4pc4eOQsdk5Mi2wXbbD0uPsLf0WAhQ5ZCDSBr4bePkdW/djkPn/Ukj52fhGzA==;31:ii6vMZriupb8K+SKz8gNTrFc4kRN50lsaCvbjL2/3QaDmjVaGN2iHjvJ6tM/qTXE4ltxjHU00mAG/x6J9XwpDoN0VzAxWzHg9MsJ6WgFaTjCdH0Udr6nESzKq6SO9lw/yjL1CKXXB9ja72Usf3+9A8Ckp413o693ju9IccTQOqrwgkdxnA/L+046dhh3OO/oIGweSyvXYeiaAh+hU+Jfj8Lwevsz6EkGQJaN2iuR4Tk=
X-MS-TrafficTypeDiagnostic: AM4PR04MB1601:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;20:ePzNs8s+kYlpb9fNLLUgSdnLO3nEQX+y73WYWPob2R1R9DtGLU9PbiX8wIkz4Nzw5cunfJW2UGtymHMSOQLjjSSvdRGqFf2LmYQwIXsm+j4frGz82ZTsFsR5jllya5wq/ewvuPR80CT+j7DXwl//eMUVMdlACdHQUUvxFg0Ts8RzJVIxMmv2KN4S4kGYbfsCrLUJkKe4Kd7GC2cTKwnfNLEglhHHs/nPwdW/6BUpFW5GlBlIJz+fdGuuXIHWA9tVmrYUmWyLXZB2ZMuSsEAF2Y3LSQSC+W0L7NeEvPxlouTNZQ7ef2d0UsfWbMV1NaC404Q3Ug+zi2YvhjYfghKS0YZID1RYrJRrQsdJpI/Udbrj168CgEC+91UuXoJiLl2x83+qJB/NR1hpPuYCeNIINLip+7+RctqOBXLkLYpAFjOAOgODbPTT7b465EJEu0pfVNWF56xEPG/9o3RtSOJQGWLC4znAdxgyNMH4USoCRg2e+N/q6PQRszQP7sR01u6I;4:S8jKxq8RDQohaqPR5xR8LXSUMQixGfQrHZ+CGVMRfLk9cj+j+iI0D1GuxSZCH949Sbr51TlgVNtSFVVKiclJk79NnU3G8FynR9seMo0OZq3CMbs9nJagLQLCIkKlqxKgT/cu7B7ZOkhKOwJOFJE79z7SUNyULqaFk59fZg/ISYvLmC4nIMWypY8whhTv6W276oUibUrwvTjl36+NOV3a4w07RVAU7CMfLNPVHWpf2WncpABfzKG6MHtKLs3ceopvzxN/PeSfQ53y4blNpCZk5Djv07oOWQrEMG83/ubToOwBVQPe8WpFBAvRteKaqMWW77FIdPtrx7RI84+0V+okkmoALkXWBa8B/R92k/UIvGc=
X-Microsoft-Antispam-PRVS: <AM4PR04MB160173440C0A0D6D275DE16EF63D0@AM4PR04MB1601.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301062)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:AM4PR04MB1601;BCL:0;PCL:0;RULEID:;SRVR:AM4PR04MB1601;
X-Forefront-PRVS: 076777155F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(396003)(39860400002)(376002)(199004)(189003)(575784001)(50226002)(4326008)(50466002)(105586002)(51416003)(52116002)(6512007)(48376002)(76176011)(106356001)(86362001)(6116002)(6506007)(3846002)(68736007)(6486002)(36756003)(386003)(110136005)(478600001)(6636002)(97736004)(66066001)(7736002)(54906003)(956004)(25786009)(6666003)(14444005)(316002)(305945005)(16586007)(16526019)(5660300001)(486006)(476003)(2616005)(26005)(7416002)(186003)(53936002)(2906002)(8676002)(81156014)(44832011)(446003)(8936002)(81166006)(47776003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR04MB1601;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR04MB1601;23:5iWO6bGn1RXFKTZS0XiaN/4bGpOKSJ/XoNgJe6I47?=
 =?us-ascii?Q?TMcLZkwXVCLsDPWIdNwRUxSDWEUdM0rA7vxRSgLRwcF4v2tuT0B/nxdT/8nO?=
 =?us-ascii?Q?hCAKndG1UOyGGAnPDKeGflmCHbqf/8bEftQJO8ZGLhSVtHNmI8+Kb0eaL7rO?=
 =?us-ascii?Q?m1uQtNYVEA7vw2I8RXurAqoLL/ZAFifhVHjfk2aoBpHYd/X1gE8r2u6inhNx?=
 =?us-ascii?Q?bbtDjPeI6F5qJW6cLw+Rpr69CWZ9arHJX0/X2kR/bk4MuV+MSH/wzuSJ8h+F?=
 =?us-ascii?Q?glXxUU16xof+N7dw7PkzPAkzCa3+1znCYNn/1CdlZ+EVc5cGUrMTvkaH2Qys?=
 =?us-ascii?Q?CeJYcLYlHSn7ghhaNX//h1+T/0NIuem+sP1OGYqDSESLgaGZEPUbsNgJgIJa?=
 =?us-ascii?Q?1izKLd+JTxkEZjhoYScL99OBjEUgPzLvB6+TNheLMN+o6qeSToGltZ6OGI13?=
 =?us-ascii?Q?pRu/KCGzDbexDOGnhfykSSpOnUupiYcmtPp6VwS6BJxGI1G7Tn6HPffjGxDy?=
 =?us-ascii?Q?bPwNTo9sT+0vxsc8NdDPOXPSdvVy3WihxPiltC45x5DakzJskDOVxrmPUHjX?=
 =?us-ascii?Q?YShYVklMZEmX9gfdJtdJQs3x6NJJFR1AWXyPfyW8EYCbjPzd3EUlzLUFkh8o?=
 =?us-ascii?Q?R0uezooB+r80J7+48C6IOY/Ni44j+MctfmlpeVKpAPkQydX7/KWH3jPLvzgo?=
 =?us-ascii?Q?HHfNmJ9pJ65pxteXDJhUM/WrydvTZzhrsUS7LqP5Op/yCF42lOgZIVpC2d25?=
 =?us-ascii?Q?XJjqRuZj/kSNIP74B0gBwKE8FbwuQ3SNYqLNtV6i7qeZb+9SpFpQ37Wqnrfd?=
 =?us-ascii?Q?hUzJUPztHONeBPAAZ11LZJWHrCls+tI4SA5bLByVs84bBLwuKwudVDgqgrkt?=
 =?us-ascii?Q?WHhx/+y3EFLCAEnCR/z8Bia+aw+Tpu/cTpZusLW32gaYVxSQYnGbwo1HufyE?=
 =?us-ascii?Q?wqR85aDhfsct7NfVCyTXIIwf24mUeW34VG4b2DrXXFa+8vt7pncKd3/etjG8?=
 =?us-ascii?Q?5uL8yRvzc+acVshBElMemcI/dVxUn3faApEXPCPZxSl7VuiC1wBnvtbJi4kK?=
 =?us-ascii?Q?z1SEngOGrwC/Nxy0gacn20HcIJmkMr7OhKMdR+qUwZSSvRIELWFJb8Tx4Ea4?=
 =?us-ascii?Q?c0qNWnq2IMfwXYhnn91qpSgPjJ82bUMRxeHV8E21+ggnEM3OmotSsFzw0ltW?=
 =?us-ascii?Q?0r8giBw0MygBGk6Bre9pA3JQEPbnop9jQSo+jG69rtZDcy0frt4C/DmbtFmm?=
 =?us-ascii?Q?56ufZpudQyUArm7DNhNYAYxSTly+T58XoMm6aQQu+7PHL71ErLCOSABbaVdp?=
 =?us-ascii?B?QT09?=
X-Microsoft-Antispam-Message-Info: 6LexvcHCqZ0pwZMN8UB2lZYWLk3oNolqcQdyM1f7FksTbbfdawwubgx1ZBHuiMG5USQYJo9psnCA/jYmYpcgd+YFRTD6ZRsTDbtQFa8umTDXZjwjHPHdX1QomkE/PziDX/2eEt9IEGvzGANdyDuCjMNT/cIoo10ee+Bo2mr+ZBq1llmdNt3xVHcW1uEa0vRA7zjdrsYrKdwf4U3y2Uzy5KTu8Sag8MTzEwfQAU+S0LuZM2QVGxhzX9E6vJvZEpPi8Q514Wqk9qIqSMArje4c5LHxLD/o/VAsOgtGtxm4q0qk8uhN22AVys4UQJUG9t93nAl7gGStDXdaZDv6+U6aM1jgd2N3DBw+3IbcKhkRAg8=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;6:aKYYDcxbnb7x6W5C+qfS3e4fYA6To03at1lEIFeuWi3hScva2u9eZj1f6RXNcFoI3MedYjWJkET8hYNobQbmPqdenDrD0daxvdiKQ7bspmO2c3IfFafds7FMrlGrJMk0qZJv++uBtTJ1QhvJ8FlCYIP559Q6U2i4tyr7joqi5qJ7xFhLjBQmwP9MHUm5ALRWvglymCSSr4CJiXj8mSKHLm3XUj3AoJruOPVH5vbPLciJRpFtp+KdjEpz02e+7oNx5NkOBmenWqoYjwcti57mFnLDkNpbu62EROkDs5tmrTFyL8v+ZxxRv519MpubWzU0FzCyLrQhYAJphvUwT6WdvhT2Jcp+dyg027XLzIXQdYd+ikrCB2aIu8ja9MT0nmcXONekDBf8/J8vEmYl7UlzDFPQj/dfGYckNfyxLQzahEdYjUdNAp26YEPFcd6or97A4RSwLqtWXtqUfH8h3SjCiA==;5:uwl7264UObDnQus1AMnNCiGWFJTuG6m2B40iHalm7LrgdshGmF82rsJVpyXGZqct4Har1rFjIAdYmuPNQlrK+pFOjYhu2JY1RiOFziZTiAXdiD0J/ZaggJZJCxcZJ1lC9rmQ4euqmPJtm0lSY/IkJL4IoEtsysa2LS99PYqaSc8=;7:E5GVEljMoZZ9A7Bw0mMMe4d7HojAdKd4SlgmIfrfvBGCpbowDb+5kWdPNCoruyh6gtZS8hg5f5MtBMq04wpERgYJVTGi04jrbK6x9EVmPBTlraCWSg5+sBJIv1uiOohmfHIdBH3euvUnWnh3jrl4ZKsHmvoDiAPDbD/9Ct/ThPHq/5aBxybGchrBQEdOGlf/wT6jP9hPHHXIeWHymaTsHX0ikxz0px6kqcciU7p7jvi/HmmpBEMMrkpoHpMXPDTk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 14:11:31.6286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7cd202-82ac-420f-5a68-08d6044b5611
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR04MB1601
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a lot of clocks on imx8 are formed by a mux, gate, predivider and
divider, the idea here is to combine all of those into one more complex
clock type, therefore moving the complexity inside the composite clock and
outside of the SoC specific clock driver.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/imx/Makefile        |   1 +
 drivers/clk/imx/clk-composite.c | 126 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h           |   9 +++
 3 files changed, 136 insertions(+)
 create mode 100644 drivers/clk/imx/clk-composite.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index b87513c..4fabb0a 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -3,6 +3,7 @@
 obj-y += \
 	clk.o \
 	clk-busy.o \
+	clk-composite.o \
 	clk-cpu.o \
 	clk-fixup-div.o \
 	clk-fixup-mux.o \
diff --git a/drivers/clk/imx/clk-composite.c b/drivers/clk/imx/clk-composite.c
new file mode 100644
index 0000000..717c6f1
--- /dev/null
+++ b/drivers/clk/imx/clk-composite.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 NXP
+ */
+
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/clk-provider.h>
+#include <linux/clk.h>
+
+#include "clk.h"
+
+#define PCG_PREDIV_SHIFT	16
+#define PCG_PREDIV_WIDTH	3
+
+#define PCG_DIV_SHIFT		0
+#define PCG_DIV_WIDTH		6
+
+#define PCG_PCS_SHIFT		24
+#define PCG_PCS_MASK		0x7
+
+#define PCG_CGC_SHIFT		28
+
+static unsigned long imx_clk_composite_divider_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	return clk_divider_ops.recalc_rate(hw, parent_rate);
+}
+
+static long imx_clk_composite_divider_round_rate(struct clk_hw *hw,
+						unsigned long rate,
+						unsigned long *prate)
+{
+	return clk_divider_ops.round_rate(hw, rate, prate);
+}
+
+static int imx_clk_composite_divider_set_rate(struct clk_hw *hw,
+					unsigned long rate,
+					unsigned long parent_rate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	int value;
+	unsigned long flags = 0;
+	u32 val;
+
+	value = divider_get_val(rate, parent_rate, NULL,
+				PCG_PREDIV_WIDTH, CLK_DIVIDER_ROUND_CLOSEST);
+	if (value < 0)
+		return value;
+
+	spin_lock_irqsave(divider->lock, flags);
+
+	val = clk_readl(divider->reg);
+	val &= ~((clk_div_mask(divider->width) << divider->shift) |
+			(clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
+
+	val |= (u32)value << divider->shift;
+	val |= (u32)value << PCG_DIV_SHIFT;
+	clk_writel(val, divider->reg);
+
+	spin_unlock_irqrestore(divider->lock, flags);
+
+	return 0;
+}
+
+static const struct clk_ops imx_clk_composite_divider_ops = {
+	.recalc_rate = imx_clk_composite_divider_recalc_rate,
+	.round_rate = imx_clk_composite_divider_round_rate,
+	.set_rate = imx_clk_composite_divider_set_rate,
+};
+
+struct clk *imx_clk_composite_flags(const char *name,
+					const char **parent_names,
+					int num_parents, void __iomem *reg,
+					unsigned long flags)
+{
+	struct clk_hw *mux_hw = NULL, *div_hw = NULL, *gate_hw = NULL;
+	struct clk_divider *div = NULL;
+	struct clk_gate *gate = NULL;
+	struct clk_mux *mux = NULL;
+	struct clk *clk;
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		return ERR_PTR(-ENOMEM);
+	mux_hw = &mux->hw;
+	mux->reg = reg;
+	mux->shift = PCG_PCS_SHIFT;
+	mux->mask = PCG_PCS_MASK;
+
+	div = kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div) {
+		kfree(mux);
+		return ERR_PTR(-ENOMEM);
+	}
+	div_hw = &div->hw;
+	div->reg = reg;
+	div->shift = PCG_PREDIV_SHIFT;
+	div->width = PCG_PREDIV_WIDTH;
+	div->lock = &imx_ccm_lock;
+	div->flags = CLK_DIVIDER_ROUND_CLOSEST;
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate) {
+		kfree(mux);
+		kfree(div);
+		return ERR_PTR(-ENOMEM);
+	}
+	gate_hw = &gate->hw;
+	gate->reg = reg;
+	gate->bit_idx = PCG_CGC_SHIFT;
+
+	flags |= CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE;
+
+	clk = clk_register_composite(NULL, name, parent_names, num_parents,
+					mux_hw, &clk_mux_ops, div_hw,
+					&imx_clk_composite_divider_ops, gate_hw,
+					&clk_gate_ops, flags);
+	if (IS_ERR(clk)) {
+		kfree(mux);
+		kfree(div);
+		kfree(gate);
+	}
+
+	return clk;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 12b3fd6..9dbb680 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -232,4 +232,13 @@ struct clk *imx_clk_cpu(const char *name, const char *parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
 
+struct clk *imx_clk_composite_flags(const char *name, const char **parent_names,
+		int num_parents, void __iomem *reg, unsigned long flags);
+
+#define imx_clk_composite(name, parent_names, reg) \
+	imx_clk_composite_flags(name, parent_names, ARRAY_SIZE(parent_names), reg, 0)
+
+#define imx_clk_composite_critical(name, parent_names, reg) \
+	imx_clk_composite_flags(name, parent_names, ARRAY_SIZE(parent_names), reg, CLK_IS_CRITICAL)
+
 #endif
-- 
2.7.4

