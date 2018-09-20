Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A35ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036D220880
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VUWy4zGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036D220880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbeITPuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 11:50:15 -0400
Received: from mail-eopbgr50077.outbound.protection.outlook.com ([40.107.5.77]:51783
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727165AbeITPuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 11:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rC4qgReWlVeM8uhBhAJndkxM5a15OApDARGqfn1YQLM=;
 b=VUWy4zGTp55KbnfKoILozgMREtOxwSlRxAIg2qc+j/JtNuPc3mcUXB1sBXLkTb0ofoWvqG1KtwLdLSC368kBPC/kzqbMW4jGrQB/cAIT8Oet9tDZQTH0bhbB9rOpVuVnddzWNa6oAx6mdwWtAVjuVVMoWXb7aqv8uphqmgb2PTs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 VI1PR04MB1616.eurprd04.prod.outlook.com (2a01:111:e400:596b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Thu, 20 Sep
 2018 10:07:17 +0000
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
Subject: [PATCH v7 4/5] clk: imx: add imx composite clock
Date:   Thu, 20 Sep 2018 13:06:39 +0300
Message-Id: <1537438000-20313-5-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537438000-20313-1-git-send-email-abel.vesa@nxp.com>
References: <1537438000-20313-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM3PR05CA0108.eurprd05.prod.outlook.com
 (2603:10a6:207:1::34) To VI1PR04MB1616.eurprd04.prod.outlook.com
 (2a01:111:e400:596b::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac7544c1-e5a9-4ccf-8b51-08d61ee0d984
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1616;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1616;3:3UBxY7rJV4zEIDtxUoFFmytd9aF0SF3nF0yh8hQh+CO0HLr8nQm9E0jpzC0lHu2zYNAK6ylBfCUMAjla5ktQ67kLiI0Hftro8KUHqlEBTgAn8xMUkx8Yagk/qYyccYZ+QDC5e8pAnaO8Oo/c0FJTrMAonXFngeDelP1H3Fd0KqzfElKH7gs+BTgkuvBJGRI8rZ4xhTUOCxVKUgVFBBeSrJ2ts1m/dERr9vW36DL6SiEK9K8ZGybujL0vBASf+6Jy;25:77H47DG9yo2EKhg7JgH5ZTFip/dnqEHJuGzjUajZa9n0POYY1bS9WLfmABAfKbl3rE4jehctQ71bUruB0hVfUk2sL93CscSFZOtYToib9GEY8UnAFk4gmzJ+SRU7HfrqkdvvXFVpOCTzF4FizmSHcYwRlimKKGuE+NIteII7Azyqb32IHMp7cCJwT/NFwAMpk5J3tmTTETea3hFBD+ZVaAFAl71BMg2DPFkrtxd2M4lWJFk4DuWJjQsgM7ueGcPiQ+ny5Md3NOM154aGAF5rYMvP5yLny0rrahsPTx6gGplydao2snEBWzTo99MMtc4pJ1Q6lCa5SHRuHuflxXZ/Fw==;31:U9tJQ4NnBkW6nPYzpMNViW5HH5GTjJBi6zzjTCRyYkiK2cuQxL5Fz9DfeR8d92Qv4Mhmso/zTGyA8gqm6lqUkE37kmgqBrkaMFxyXHDqOeG+x1CQa4b3RwSspd9+YK5gAHfehK3a3Fk5fpfbggyv2BCAanVdS4xhAM6TbwyQK9PpAOM5ecoXfypoV7af4b7yhy3FmNYmREMz1OggP4G805beVAJlyy85V+DC0uVCg+Q=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1616:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1616;20:Aa1eV1jJqtSkDMkRzaVpTLB4tYN9gXHk/bzJYgH9yW3qozFN4yY5JdwTr08UX0bX51z8iE3DXN5HXjzYmVnDGe2+hDgPZJhaNfzRhXV3VMf3mHsvmLKgMO+rON6Emd3icnA3HzcmamPFd54kfo110syJuOl9yY3TH0W43HGXt7MQdjAL9efizGVGANlZ3kaAmAM8ozOXe0n6FwkPm03LjFaaXs/0LKMKlQk7vWhFwlnRIhG5HuB1jJyC4x6mKA2YJoMMQyt06+wLObXhM7vJU85y4Co4PQuX/796ogOc9t888OjXQ+J19a4YGhIzc9hO4zlmiryhVBeL8mWxotpnuVFJUL6S7qBSmnsjW2m4/ryIuJxxxRVXgY8CfpcZ+S7Wnbz8+QTRY61rqyNz8YKqx3tb3lKTIupwJV28aMcGNRA/xbJR3m31vW2Fb7lcql7nhD0lR2IEDhBONTGz8ZMAwwWdSLI9WXY/lvu9IdZBrc1YLLyDyEDCzu/XWAiPU1Im;4:1ri6+SRUNqVFvI30dCtQ52fxdbKmXo9IXCaGyVQa+H8a+0QgfUz3TjN46iM4wkG0kqdodl8eIlhmkNPOCGwKNnIf583mQMNVRJYn5VpKv6CaVoUKbswBYUKpiBjEkq+mr3cIufeY84wTDGQBS4Mk8do9JlVYwXvriDBBmFbkye8Pnbcqt9S4UgcuUJRyecTKrMz2EILFAhzYX10b5aQG/hnCdWCOErWKesoIWmcpEz4u1BwqDzbzX8L7tYFCsueV/ELUSwzXJKjohSGwH0eCKlpMGTSbppyuVH8hcFZhOps8CEV8LEtBeCf1YsHbV5sI
X-Microsoft-Antispam-PRVS: <VI1PR04MB16167EF5067528C59BBD4790F6130@VI1PR04MB1616.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:VI1PR04MB1616;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1616;
X-Forefront-PRVS: 0801F2E62B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(8676002)(36756003)(6666003)(8936002)(5660300001)(2906002)(50226002)(3846002)(68736007)(50466002)(53936002)(6116002)(66066001)(575784001)(86362001)(478600001)(97736004)(14444005)(39060400002)(6506007)(6512007)(25786009)(316002)(486006)(51416003)(52116002)(6486002)(386003)(476003)(446003)(7736002)(2616005)(4326008)(16586007)(16526019)(47776003)(81156014)(44832011)(7416002)(186003)(48376002)(110136005)(54906003)(26005)(305945005)(81166006)(105586002)(106356001)(76176011)(956004)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1616;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1616;23:qDplKN9bHgfJ4tEv8y/q8vW/wFlolomIVG3fxIXWC?=
 =?us-ascii?Q?hVa7jVy99lCY1Q/nvu3ncq7ltPz/4aQr+zYQZq5lbVHaMi1fgFcVxZmuuP9X?=
 =?us-ascii?Q?/pasGtBZIo9xF+8JylGKT5346ZXbhqaDdn7b2kPUA06tpqFXlQUf8S7qvF15?=
 =?us-ascii?Q?AIR59hO+jcPV6JT/GRonHz0zl6ljPhI1U9L3g1TwKbdePktR9kLYYWHU1JbF?=
 =?us-ascii?Q?VGs3o4lwayZt9sSAl5JzIeH4NA5wdjVw3UnQboUXeZjjRQgM7vM4y6P1KLno?=
 =?us-ascii?Q?WNXF3BTFlBzI06MZVoDTQXEWaUQzNHnXu7BjAsAnSod9Q3auQ3+D4BxliXS5?=
 =?us-ascii?Q?7ggMDUybWZqVLVjzLmfnDTb3UXm54EDwi/0ijt4jPpL9L5zB3//xI/UtWSjP?=
 =?us-ascii?Q?gmG1x8WD3kQMF5JwecDMenDEAu+noUTFr9o3djFp+WpUj587IT0nnvtra66S?=
 =?us-ascii?Q?gI7Uqp0O0chFyS/MNNJ6bfvqrBeViHYRpbnmXs/rXjnCg+SL6bgjIqyKa4Av?=
 =?us-ascii?Q?g3yRzqGBaL5ZwSC+ByCAXTPH/OpYqLjk8+3gP2/R2u2MikP3gzHtNbe35cp2?=
 =?us-ascii?Q?4vIYu2wBYwG1GUBqaXon39yo4ucE9qbGysrpy/JddXFjEk+e/EVUw2pjZhBL?=
 =?us-ascii?Q?18xQXTW5Pwt/HDGZQXvQtT+HayjudgL/kmwb6jiYSgmvuV/XRf7TqoW46++B?=
 =?us-ascii?Q?XM4a9m0RTM9+LU8iWmylcSQ5Yhuj6TxNZI+FppsKSz3AAGo+mccBHh5J6ULx?=
 =?us-ascii?Q?Sz2Z3n6X/y6Dn94+IHnOKrvzXH3dlwNlfd++dTn2QIG2myiHl0QauogtgXub?=
 =?us-ascii?Q?oa5TSM8JdjlLGaR9ZBWp0AdccjVoJ0RbS9LcNLM841wS7OoPNBP3sAmZKLbD?=
 =?us-ascii?Q?pOD10tqZQCKTeaMJxHKuWjeQlBMUlKqeR9xyFCFEHtQO5TMQufl6w4XglWfE?=
 =?us-ascii?Q?CmQmFhq7wUPkfliRAudgG17Aj5DZK/wqLX+erp9/+IN+2Y+MFLOSGBjJpmPV?=
 =?us-ascii?Q?VptKS++vvRl3yKsW+Upe7J+59KjljQyG/euqegrgOIkLxO8XwIAtYy/BFAjz?=
 =?us-ascii?Q?v29B2M2ccbG3X35a19Nv/MkQ9rjB/PDwNu7g76sf6tLOZkMEF7G3PnrcILrQ?=
 =?us-ascii?Q?N67MGuTGFljoW+zqDBYvCpSnCLAhzmex5OY6gFKp/r1run4gs1hMWBECTm0P?=
 =?us-ascii?Q?2QbKDAeNM290qXIYXyQNTmsSmoiVujap13u/YJokS96mKOTRAEdO9CXZYdMt?=
 =?us-ascii?Q?DFZNIBqmc8FC7CT91pRlI031oNwafHS+1jydI2DmQpATkRts9FrryqijOk9A?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: fO5mGYT2iskzbwweRWPMV/I4PC2+fOjPdkbiiEW6JGlDnnKSIwMuy8U34dwzzxxixx+WNjTugybvIukxK9C3ly7PqjenlblIMzn8n8wCF4b/n8pxm1Pb++yDfniDrxEe283iMSAwpGz9Tp9LMCz6Q2lJ5Xk4pM3YTiX3IZKlm7nQ7VHelmU0nMJFbz/bsOa0M9sqrZQCkkVkZGa6JoiGta+5Kz2J/HdBEJ0u92itSDO3/yKmfamXMX3PDSxDmwnLeIMGqDYi4DXjh6zb8PuX49fgXH508R8g1PDMaPCFA9OZES/6M1xi42fKszGmtgmiTfWyuPGpV9Dqs6sbprHBKTq4ObxM0VMviKZ0VQI91V0=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1616;6:SF+LrJ4ck5+v9bDTU3sHWqKiFl/75ewhhP3LOYvNXi0jmkFO9ujaP2LNDKcJU6I5rRYdzZEZfBTFhdpSjCVstYCud88ZPoAg1b3/eMQIyrwdYbDRqF457bd3tKReME9cOuwN6HbQqaBd78XPB8c4axiObDyf6JaBBvrVg8shw9HHu6gPak7TZbz926J6MgNKP1AHKk8brFVtT9SRDFHjILYT25K6mP44A1Up+pQjTtl3os33ni9o59kQ8Lrq8dJPQy3Ms4bP8KGbNiI0+LGuO02HzoS/VWAdkgETmvue/zY++9KR1hXOcnerBM/9BRPINlLm1u5c2EEJXwRmTIDJVP7g0delGy0GkxFV5wbx0S0mN+8SJ/SxVDf7wHDmaG+gFDGaBsr546U80W6pWATl9cVBGx9Sxudb2+11S4R0oGgsoTLk+ZdAXXSROycypf1dnTygmDiBrFOoLb8wed+Mfg==;5:ZAr29qFuEbS3lcdydXODbhqwjW48UcYAaMjitN8H9mm9wE6VFcfe+hLSDnSMdIvBQUpfq7NzGoRsb/QB9678ViEbNOyXeX69fAlQHHDykhJXjTWCztApMDT4Pv30t2FCws7QTYNcXl0BW4WQaNeNXfmB+6XcCoWLQXBFiRxvWqI=;7:GDiUl6GlTtyJh/r3lBwmZZj6pq+/Czd0JBmJf49a55GBStfZwGsxvD/tXhjjTy0xk3e7wsRuBn0GdE0IeWHaVB2jShTHr+tl50NyWbrtxarcyLxBXy5080w1eaYMTSYsOjsiiYsYkxl7X/GTcwhCgF8Hp/DlkYFWA8cxhTW4IplUi0vfCuxfZexQiy51mEySiGf+8Gf16NhvnZUKpqT33FhNaiL/eQR3czk/ORxo2lgFsmiAR9DEcjMeJvaHB72y
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 10:07:17.7643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7544c1-e5a9-4ccf-8b51-08d61ee0d984
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1616
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a lot of clocks on imx8 are formed by a mux, gate, predivider and
divider, the idea here is to combine all of those into one composite clock,
but we need to deal with both predivider and divider at the same time and
therefore we add the imx_clk_composite_divider_ops and register the composite
clock with those.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/imx/Makefile        |   1 +
 drivers/clk/imx/clk-composite.c | 155 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h           |  11 +++
 3 files changed, 167 insertions(+)
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
index 0000000..40c2aa8
--- /dev/null
+++ b/drivers/clk/imx/clk-composite.c
@@ -0,0 +1,155 @@
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
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned long prediv_rate;
+	unsigned int prediv_value;
+	unsigned int div_value;
+
+	prediv_value = clk_readl(divider->reg) >> divider->shift;
+	prediv_value &= clk_div_mask(divider->width);
+
+	prediv_rate = divider_recalc_rate(hw, parent_rate, prediv_value,
+						NULL, divider->flags,
+						divider->width);
+
+	div_value = clk_readl(divider->reg) >> PCG_DIV_SHIFT;
+	div_value &= clk_div_mask(PCG_DIV_WIDTH);
+
+	return divider_recalc_rate(hw, prediv_rate, div_value, NULL,
+				   divider->flags, PCG_DIV_WIDTH);
+}
+
+static long imx_clk_composite_divider_round_rate(struct clk_hw *hw,
+						unsigned long rate,
+						unsigned long *prate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned long prediv_rate;
+
+	prediv_rate = divider_round_rate(hw, rate, prate, divider->table,
+				  divider->width, divider->flags);
+	return divider_round_rate(hw, rate, &prediv_rate, divider->table,
+				  PCG_DIV_WIDTH, divider->flags);
+}
+
+static int imx_clk_composite_divider_set_rate(struct clk_hw *hw,
+					unsigned long rate,
+					unsigned long parent_rate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	unsigned long prediv_rate;
+	unsigned long flags = 0;
+	int prediv_value;
+	int div_value;
+	u32 val;
+
+	prediv_value = divider_get_val(rate, parent_rate, NULL,
+				PCG_PREDIV_WIDTH, CLK_DIVIDER_ROUND_CLOSEST);
+	if (prediv_value < 0)
+		return prediv_value;
+
+	prediv_rate = DIV_ROUND_UP_ULL((u64)parent_rate, prediv_value + 1);
+
+	div_value = divider_get_val(rate, prediv_rate, NULL,
+				PCG_DIV_WIDTH, CLK_DIVIDER_ROUND_CLOSEST);
+	if (div_value < 0)
+		return div_value;
+
+	spin_lock_irqsave(divider->lock, flags);
+
+	val = clk_readl(divider->reg);
+	val &= ~((clk_div_mask(divider->width) << divider->shift) |
+			(clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
+
+	val |= (u32)prediv_value << divider->shift;
+	val |= (u32)div_value << PCG_DIV_SHIFT;
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
index 12b3fd6..74d8d46 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -232,4 +232,15 @@ struct clk *imx_clk_cpu(const char *name, const char *parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
 
+struct clk *imx_clk_composite_flags(const char *name, const char **parent_names,
+		int num_parents, void __iomem *reg, unsigned long flags);
+
+#define imx_clk_composite(name, parent_names, reg) \
+	imx_clk_composite_flags(name, parent_names, ARRAY_SIZE(parent_names), reg, \
+					CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
+
+#define imx_clk_composite_critical(name, parent_names, reg) \
+	imx_clk_composite_flags(name, parent_names, ARRAY_SIZE(parent_names), reg, \
+				CLK_IS_CRITICAL | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
+
 #endif
-- 
2.7.4

