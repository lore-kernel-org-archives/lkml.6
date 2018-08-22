Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A76C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369C2214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fCPZCLnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369C2214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbeHVROQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:14:16 -0400
Received: from mail-he1eur01on0051.outbound.protection.outlook.com ([104.47.0.51]:19992
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729131AbeHVROP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSJ+OIKc1jVX61H7MMAPr5FkHCzg8bJfLCw618PIuzE=;
 b=fCPZCLntD9c9CieU68FMTe1hFBoU1cc5I1RLgxzMVGiYv9j/OuPm7NXuUVxfS2RaJO/wo8llsvmFGBOm0Xd5PvB4sfXcNy4JzdPGTJokhl+lscLAz71PFZY0N1m6IC4Yw9u00R7ZyKxbZkBg1E6rAoCsa+OXyMU7yLInJfgoiuw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 HE1PR04MB1612.eurprd04.prod.outlook.com (2a01:111:e400:59a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.21; Wed, 22 Aug
 2018 13:48:41 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Cc:     linux-clk@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v6 4/5] clk: imx: add imx composite clock
Date:   Wed, 22 Aug 2018 16:48:22 +0300
Message-Id: <1534945703-4730-5-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534945703-4730-1-git-send-email-abel.vesa@nxp.com>
References: <1534945703-4730-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1PR0202CA0043.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::29) To HE1PR04MB1612.eurprd04.prod.outlook.com
 (2a01:111:e400:59a9::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b365fc1-143e-4025-529a-08d60835f908
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1612;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1612;3:jR/wqnLu4WEnzTDA+RH2/iKP/Hq3u/mqwWGc5r6ATYI+WiomGX8rxvmllOfPykdNCZ8GhvjADy/g6fRGHL3D+zV5kHu6hNi74Q0Lcu0YjRVbzk7iiiVtroH8iriNWkc/XLH8gibjLHFVTgBhO1em/+1wQI2PgU42G6LGFIA9CFwm8BPsWUrCb8vn8QPngckdJayPmzMKS7rd/hnonH7ArvmGxWMHX9m1DobovkkvNFgdPTXq2Is7NI4Yl9Uex/QI;25:mZg1Bvp4R7KZXZ2TgJKq9/Icc8VNXKYCCp6c8wS9uBKVUgVcrDKeyvm3hTijML2Z0Pikuu1tzoz0hBWXsrQUmaiPuafVJU8KkewiXToap7aXAitGS2JuZJjiN9aps4m5PoMmAuvu6CInKK2+VbbGNXzxMUmxJVcq5w1jTZOh/xinUOnm/8dbFg5YYj/bDFVaybM33N8AsJHFiTq07D0kcF7dnAdzKKps135XeZiafVbfmB8ClZwxYfcagDrdinVn0VuEBNAXLzkaT6qlLnXmEWq6NTvvZXZnQdqPOZiyyJFmNFDP9qYhI2lmEVcusVh7z+nAKLPACIdzzUeAOPvQEA==;31:dIy/ok7gyl0YDJknEIIzFMEhvtLLLVX6jtxBxOHkdM303l+IaPOBrN6OjD/pqUMF6Ytdf/erZ2TOopmOA0txCQ9iVInZMOtQviUbZtI8fAc6LQqGQsFldMkaoeofQyFnei4zi/++K3uEK1JVkoxLiX+E0kfhqc9+Swalw+BFFRospmZi07W5i0i4kmqw8zFNm/+i5EZDzDZiiVXn+KS8RAwbv1gB4KLb07PihNUSAH0=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1612:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1612;20:sMzhXG6k9CYBmC9MjTX5Poykgx5Gs9k5hXmOtg4ngSmdHCM0OBQXEBFN9tuBWlWFTT2iljzDd4NXyTC5lmJYFMjyo7B0SkxLey3H7JGuuGu7msGupaG0AsR+tVd3iMuXpjflXlgxKfTvl/E6Zny24CZ9hD9AWss3MDx6xDJp/N8kvwkHrE5ICbOJSNuy/jr+ouWXIxUUELMCCl2s7/Xwc5g1GUsLbgUxbECcROIFm6eq0kRr62OvPwIsclD5NDfCvVwWkUgxMGfIvOGMYPJwzK0CWDM0bzo3HmR3+snGrpYM3+M7jvbvqYtdsOMu+IDuGLhdcVsCMt8Q8rd2U0DG+M88KpZszlKKHybam6xC4702r1zBfd/QM306L8x3O+cpDLog7yUYjZIR5SsVTcq8wE66/4C8YwE+TGgJcIv5j9M8xQ5KU4PuZh+sTvcGmxaqZCVzuT3+TJuy422autjHFFQhggsC860a+pK2/y0TK8sVUN279fv6DiuBzqLuW8TW;4:/cJ5qcmLRqLRLzKrN7CIwZEtGdgLfmcuPrepHH8C9YI0yENU9fcxcLIlniVXYYrdfeV/2iPAl9MmtuSTwU8sRW/CHjW4sipsgB14oATfhUBGrYXdeKXfd7+m3xKA+4ENnDDT00F183Elz8qvJhHtMTmtm5WmTPO20ETlUmTxCNdkw3yHkVAonvzYLk6GaZZzkNBAl+iH/x+tURZVIRm5+OSThRIpM63LNO/gr6fBQUpxV/O6Yj79hEdS6oDSAi1i75ydwB4I5D+n3IHBP2Qf9xHtdqPfoSYZY9wLTlUm802GA1TMIv9EVeH+Hsnwnjfr
X-Microsoft-Antispam-PRVS: <HE1PR04MB16128E87899FE4C6BBFCC881F6300@HE1PR04MB1612.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:HE1PR04MB1612;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1612;
X-Forefront-PRVS: 0772E5DAD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(366004)(136003)(189003)(199004)(36756003)(14444005)(6116002)(186003)(26005)(16526019)(51416003)(386003)(52116002)(316002)(47776003)(66066001)(110136005)(6506007)(50466002)(76176011)(48376002)(8936002)(54906003)(97736004)(478600001)(16586007)(44832011)(105586002)(25786009)(5660300001)(446003)(86362001)(2906002)(11346002)(575784001)(3846002)(6636002)(50226002)(106356001)(6666003)(476003)(486006)(4326008)(7736002)(8676002)(81156014)(68736007)(53936002)(7416002)(2616005)(956004)(81166006)(6512007)(6486002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1612;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1612;23:RI9mVZCYy5T3fcYKx/TCQ2VEZc6x9YXE7Kqc8rdQM?=
 =?us-ascii?Q?Zx7KkVPii5MPEYtocjDaL/CzmXOxAFBSRXKG5V3aSDqIo/fFpjRriUB9RBk4?=
 =?us-ascii?Q?dEOwTID/3VtJNdJk3Q5Kb7dFuGml2FxGWkt0e4Dj1NWr4N9+FxJdIDLbj280?=
 =?us-ascii?Q?v1HizExUIMAx2A1LFeJLndIHHmWduQ5RzBVYxAB3lxt7ZB6UGQPwD3Dnf6DE?=
 =?us-ascii?Q?omrG5RFa6NO3R6mK+MLhB0EbFBNjSQLUyx3Zo/xTSU7e/2nGG8PKylQ7Pb8g?=
 =?us-ascii?Q?vuQbYzHxiIi/vBegWuWCTydWGFg/UOLCaFAQFJM0eHjmkLXr6N20B27ACqq0?=
 =?us-ascii?Q?5lpUtaPfDiYZ/upEDA3gCl+N69Ps1htOo6LKvynVw4fpbo5OzqjqoTpchZYc?=
 =?us-ascii?Q?RFYhwLf2zfibPNsN/5r7nrhs290fNAogqW5S4vi5XWkkZVmj8WqMEZSz7lvA?=
 =?us-ascii?Q?7DG8kJ5bvZP/32cf5fYC1N8vrpj3PWP8brROH5f+g2oqPSwBYtRt3xt7XH5L?=
 =?us-ascii?Q?5ccr6j2m8iJYoi87sZ6vil/q8K7+HktBGeESKWwDrPftofXo4zULhP32YuNT?=
 =?us-ascii?Q?Q45aw4tq6lui/5klNKJp+ySB4pO34kSCKF9qzDNpj++jKpz7zQridAd6jeBQ?=
 =?us-ascii?Q?aQEbVUjWb2JTo4EY8ee+25TPPvw5uxljRihPPh9JlzZ1GesOYXAeCfIW7Mtm?=
 =?us-ascii?Q?ZM+mz0i+nX9XYpb7IuYVF0uuUDt6G+FBKCTQRlmNy1PG8VEE/a7NwwnTDmbe?=
 =?us-ascii?Q?Gv+MlgXUi9ZvhXcaNeYQMz6IZXo6iLNaTB957SxgzoV7j9WP735fzun5JfCm?=
 =?us-ascii?Q?1oWtmpru6XnZinLOSVMB/trXWXhMnENh+oTTN463VYIqHJdrDKy5fILMygne?=
 =?us-ascii?Q?aLbd+x3RHcu78kYAiQZ5+OwPlnGF/ewqWtWVtCaYBwtdr1xWepMZt1iiFW6C?=
 =?us-ascii?Q?s3QIZrVn/CvINnkGN2C1/KePSF4B2aM/yosN+jQjoXom6gOgr5/327gFPKiS?=
 =?us-ascii?Q?dAktVLNem5soF2luCn6Yqh0e8kBfU2zJiMbFAPeOk4J1Nzt6VKbQIUepMM3M?=
 =?us-ascii?Q?+AEY2BKG6EufuW1wFmqsOdDe9s5s3vUKSYnyFZWjgdkDS6Mb84+QtukiyBkK?=
 =?us-ascii?Q?hDjUqd7vj9RV4lxTa23wLltJv+BAjqiUk/LxQ3zu9UcIQVm8wDNxdFJNE1oL?=
 =?us-ascii?Q?LmTQIVbgs959ZMHGLvlEkZvC2G4PCdo5ElQw3KIzXQ4Xmo0NSgLj0uwaZuLb?=
 =?us-ascii?Q?r94OMAFljKBtuN/5HqUBGWIMUdceMtnh9XZZgMhAXB7Vx69j8vQhtaBWfvGM?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: 1ZhfnAFlaASiciq38AEws6BMQrh5zunDDH1S4JESNsl31fQL0lMWMSkZVc903+wZ8a7S2BWobJNUy7Fzoxz0UTPecwJheGF1gFNKHCkx2hCjtf7q1IM3L05Qb4pBWOVzL4vELWnT9XOUrXr4FOS90Gd+mu3poHFDA8wiIxSSutIvChY8Ny7BkfhuWSOcQnAP5749G1G1beNRGQ0B70ZtbKhP+cOc810MRffM7CuUTI5av5GbXzQiwA5Ih136QsMuR9e2/HgUzDgthls3bi01HOaQf/kWa6wPanP2mjQlEYolUqks3HzsLPihynoe1+RJpxa3OyRoVJrG6wfT5IgGRg4LfS0z4Zrvpq5PBddkYoc=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1612;6:rXqAWq38VcRO+TESRBvO7jfnr73BKtZeqQ92dFWj0ymqf48IrVeJz61UUxr7HcHdHZ6MFs5UMri29Olx48NTQ6GRRgmzFPpN/NZmWMLGMj2FixrM3KhYgdbRU97dJHiAr9qmbPABoBvFUfZtDVOV3TOgwBdJxtr7yFQXANYVHRugJm4DM7qIiYIjR/cNUN+wqpPB1oJ34krFJ/je+NfNUg0Xt9E29vDwCWZ5NiVvZsxwNkWWptT3b7RRVMft12q2I0LIeys1fp+7F8S0ejTc6xSeq+7puQ8noYfeJZCWW4+oytnl3L22n9rQBYdHHZJAy5B51Nq1w7WqjzIKgWBZbADIDnHkTVE8kJieHlGRac1OkgdxvLsYSMlZL16q4HR0eWt4PiJovLE+boJ3/lswcsuqnRr0ETeYFwQ/5mdAES5WIrhoW/RB8p9Hn3FwWbHCOkzclLDxfoOktIVus3ocNQ==;5:mlMqtW/6OJbvsXLz2dFk7vDSliKVlGpc7eLAkqt5lXsmld6hMRugKi+N0GtMTav/oWN7PRBsVgCPq5aElUDYG+oEBJrcaOBHAs4rN9y1vzNtGeo/wXxLY1SSdqs6573WQd3mZLB54lbSaY9now3cZiHfg1pXFn4sqi+xcZRemJs=;7:6+8OGKgxHLGNfhdOvPTv1xM/zO5ggWvhaCXBnvOj+wWsW5Za++4OecCq7GnGFwTlAYduo05AvIJcSUJDptDhfrGiWXXSDVJs/4qHTQ6lWajJVtLVcsS3razu/NfMocSDWjxfTfNwLX73Dihse8A9fiLtKKovyZGNSK0R/iXf71vOO/yFdJA+3iXi6qO71X8clGMO87oQ9e3FUXXXmFHqW0NmdHcLyZQT3iN49wqZFNeO+3ysvsVSDdYCN6+KN+xv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2018 13:48:41.2195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b365fc1-143e-4025-529a-08d60835f908
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1612
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
 drivers/clk/imx/clk-composite.c | 157 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h           |   9 +++
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
index 0000000..a5c0080
--- /dev/null
+++ b/drivers/clk/imx/clk-composite.c
@@ -0,0 +1,157 @@
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
+						divider->table, divider->flags,
+						divider->width);
+
+	div_value = clk_readl(divider->reg) >> PCG_DIV_SHIFT;
+	div_value &= clk_div_mask(PCG_DIV_WIDTH);
+
+	return divider_recalc_rate(hw, prediv_rate, div_value, divider->table,
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

