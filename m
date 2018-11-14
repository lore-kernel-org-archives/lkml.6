Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E71C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3C622360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kQAd8bGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3C622360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733294AbeKNXE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 18:04:58 -0500
Received: from mail-eopbgr130059.outbound.protection.outlook.com ([40.107.13.59]:38198
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733173AbeKNXE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 18:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFrrADcLt19He8jwv+0xQpVTtf9iJbuc1/RVuqYJ+m8=;
 b=kQAd8bGIRa2+hxwh5bo4ElkKYUsHGZfGopjTUqhTVyU8UGtMpN2tFoOSjm3Ounmlwt73i9TA8D50oNeCVy41UCKzjDralZXkbZsse3bNDL92+nN/R/7ty3O2y8kpeX8gyEFtUyAwuzrnbc2FpUDOwiuJ9/1k2gLbCNjTWJ9GvLA=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB5985.eurprd04.prod.outlook.com (20.178.114.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Wed, 14 Nov 2018 13:01:43 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10%2]) with mapi id 15.20.1294.045; Wed, 14 Nov 2018
 13:01:43 +0000
From:   "A.s. Dong" <aisheng.dong@nxp.com>
To:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH V6 3/9] clk: imx: add pllv4 support
Thread-Topic: [PATCH V6 3/9] clk: imx: add pllv4 support
Thread-Index: AQHUfBoxnh/BCQ7HKEuiz9x2izjkfg==
Date:   Wed, 14 Nov 2018 13:01:43 +0000
Message-ID: <1542200198-3017-4-git-send-email-aisheng.dong@nxp.com>
References: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0057.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::21) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5985;6:IMdgrbHuJPSOC2MTkC2XrJhQh1Do9IMsaSvodshaGxAYQJEwWYznGRO/pAkQN4R6NYYsclCEhh90uWYE4hehkGsW3WSqeP1SJOvSc/R+aCQjBRxkHKCv/LG5bZheUuGyP4+osYUOOjj4+W+n79m2vYNi2YYl2R0pvEl4f4iEW06alPd9hWhDcXlcMwgnX3OHqeMi7wAnUWQ+Q5bA9ApIpvnT+q08ZBhxZCr21IRhqDWwZD+QU84tbUt4Mw+ONgUaB+I4TNhfYWSVdZkZgRFvtXF4FhWU0n1X9jHc6/aI2x2Pb4Dq21JDwjyx+iqnMuxO3lu7Dwbh4exfc52FhvPo/3RU+n+RIy4YT3YTgNa2OQHQehBF7wQf+YLELMYy5Au/+wJdIoHW0s0pqVLEJhOYelkfk+4/JR3vdYHn9u69xf8LEJOUZKGg1kvYDe7lZmEN9/xXd5zww7jV7RJrdZ+BgA==;5:PjVck8IYLi0/VBk3JruG5m1JMZlCpeJwjqAviradeMj6h+ZMVFvdNSd2Mg2NcM83BnkEm6pSZTnoK5bP6Aku24067mZZqe6GcpYoCV6mUYxrM3fkuwxZHNnPBVr7TfJ1LMClAU4aBb4bRcqeOkOuLCKjxHPnXshRq0IXfvn7Fkk=;7:uvRTwq0FGmAicoYwDv7Pgf+j4Z78erYcsqYw6SLtJdTo8BUnQjbfSwxpd/Wfd53wquy1tlDh4mjUgwFiqRU5eB7D0ibC820Uy5dcOybIKm967gy8tRLXHBFKyT0cOrvawARr9uaA3Qa+LL556W2L1A==
x-ms-office365-filtering-correlation-id: 54ccf6ab-ff94-46c2-e4b6-08d64a315349
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5985;
x-ms-traffictypediagnostic: AM0PR04MB5985:
x-microsoft-antispam-prvs: <AM0PR04MB59854AB96A0FA1B6EF17DF7980C30@AM0PR04MB5985.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(944501410)(52105112)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5985;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5985;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(366004)(39860400002)(376002)(54534003)(189003)(199004)(6916009)(305945005)(316002)(446003)(54906003)(476003)(14454004)(2616005)(68736007)(5660300001)(11346002)(53936002)(14444005)(8676002)(486006)(105586002)(7736002)(256004)(186003)(25786009)(4326008)(2906002)(99286004)(6512007)(6116002)(52116002)(81156014)(66066001)(81166006)(3846002)(76176011)(5640700003)(50226002)(386003)(6506007)(102836004)(71200400001)(71190400001)(26005)(86362001)(575784001)(106356001)(2351001)(2900100001)(2501003)(6436002)(6486002)(97736004)(8936002)(36756003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5985;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OSiuw9LNZZjnVnT2xuNYvJnndgax4BucCAmpDIm2DCLMBHmNLZN+wUylAW+9GptTZeTJpmcGRBozln0JPsdi33YNCiyj7jB4sy3S9NbgafU/Luxva+G5M3hF3DZUG/JqY/wTsS7V1J+HCHq82VptgoGAjgvIHg91ylWSQ+pW1zn+eNta6irMfuoIi9eYnj/T0CvpvTRpNQcXpLPbG6sibKfb5YEjLr6Kqh7WhujHCM1+XzoJtGvsJJTlLrg+V+25tLPChJQMYdr1WaVNqaFVzSppIenz10hxJ1IRxFGlsrTZS38Mu/BvjI85wcfpGIE3py4L1Xm8trqNh3bPrLKN6ee2J5XznN/Tba3/PXwFPNo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ccf6ab-ff94-46c2-e4b6-08d64a315349
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 13:01:43.5131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5985
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pllv4 is designed for System Clock Generation (SCG) module observed
in IMX ULP SoC series. e.g. i.MX7ULP.

The SCG modules generates clock used to derive processor, system,
peripheral bus and external memory interface clocks while this patch
intends to support the PLL part.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Anson Huang <Anson.Huang@nxp.com>
Cc: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v3->v4:
 * no changes
v2->v3:
 * no changes
v1->v2:
 * remove clk_pllv4_is_enabled() check in set_rate, instead it will
   be handled by core later.
 * use readl_poll_timeout
 * use clk_hw_register instead of clk_register
 * other minor changes
---
 drivers/clk/imx/Makefile    |   1 +
 drivers/clk/imx/clk-pllv4.c | 182 ++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/clk/imx/clk.h       |   3 +
 3 files changed, 186 insertions(+)
 create mode 100644 drivers/clk/imx/clk-pllv4.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 077e732..4cac28b 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -12,6 +12,7 @@ obj-y +=3D \
 	clk-pllv1.o \
 	clk-pllv2.o \
 	clk-pllv3.o \
+	clk-pllv4.o \
 	clk-pfd.o
=20
 obj-$(CONFIG_SOC_IMX1)   +=3D clk-imx1.o
diff --git a/drivers/clk/imx/clk-pllv4.c b/drivers/clk/imx/clk-pllv4.c
new file mode 100644
index 0000000..67c64c7
--- /dev/null
+++ b/drivers/clk/imx/clk-pllv4.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *
+ * Author: Dong Aisheng <aisheng.dong@nxp.com>
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/iopoll.h>
+#include <linux/slab.h>
+
+/* PLL Control Status Register (xPLLCSR) */
+#define PLL_CSR_OFFSET		0x0
+#define PLL_VLD			BIT(24)
+#define PLL_EN			BIT(0)
+
+/* PLL Configuration Register (xPLLCFG) */
+#define PLL_CFG_OFFSET		0x08
+#define BP_PLL_MULT		16
+#define BM_PLL_MULT		(0x7f << 16)
+
+/* PLL Numerator Register (xPLLNUM) */
+#define PLL_NUM_OFFSET		0x10
+
+/* PLL Denominator Register (xPLLDENOM) */
+#define PLL_DENOM_OFFSET	0x14
+
+struct clk_pllv4 {
+	struct clk_hw	hw;
+	void __iomem	*base;
+};
+
+/* Valid PLL MULT Table */
+static const int pllv4_mult_table[] =3D {33, 27, 22, 20, 17, 16};
+
+#define to_clk_pllv4(__hw) container_of(__hw, struct clk_pllv4, hw)
+
+#define LOCK_TIMEOUT_US		USEC_PER_MSEC
+
+static inline int clk_pllv4_wait_lock(struct clk_pllv4 *pll)
+{
+	u32 csr;
+
+	return readl_poll_timeout(pll->base  + PLL_CSR_OFFSET,
+				  csr, csr & PLL_VLD, 0, LOCK_TIMEOUT_US);
+}
+
+static int clk_pllv4_is_enabled(struct clk_hw *hw)
+{
+	struct clk_pllv4 *pll =3D to_clk_pllv4(hw);
+
+	if (readl_relaxed(pll->base) & PLL_EN)
+		return 1;
+
+	return 0;
+}
+
+static unsigned long clk_pllv4_recalc_rate(struct clk_hw *hw,
+					   unsigned long parent_rate)
+{
+	struct clk_pllv4 *pll =3D to_clk_pllv4(hw);
+	u32 div;
+
+	div =3D readl_relaxed(pll->base + PLL_CFG_OFFSET);
+	div &=3D BM_PLL_MULT;
+	div >>=3D BP_PLL_MULT;
+
+	return parent_rate * div;
+}
+
+static long clk_pllv4_round_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long *prate)
+{
+	unsigned long parent_rate =3D *prate;
+	unsigned long round_rate, i;
+
+	for (i =3D 0; i < ARRAY_SIZE(pllv4_mult_table); i++) {
+		round_rate =3D parent_rate * pllv4_mult_table[i];
+		if (rate >=3D round_rate)
+			return round_rate;
+	}
+
+	return round_rate;
+}
+
+static bool clk_pllv4_is_valid_mult(unsigned int mult)
+{
+	int i;
+
+	/* check if mult is in valid MULT table */
+	for (i =3D 0; i < ARRAY_SIZE(pllv4_mult_table); i++) {
+		if (pllv4_mult_table[i] =3D=3D mult)
+			return true;
+	}
+
+	return false;
+}
+
+static int clk_pllv4_set_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long parent_rate)
+{
+	struct clk_pllv4 *pll =3D to_clk_pllv4(hw);
+	u32 val, mult;
+
+	mult =3D rate / parent_rate;
+
+	if (!clk_pllv4_is_valid_mult(mult))
+		return -EINVAL;
+
+	val =3D readl_relaxed(pll->base + PLL_CFG_OFFSET);
+	val &=3D ~BM_PLL_MULT;
+	val |=3D mult << BP_PLL_MULT;
+	writel_relaxed(val, pll->base + PLL_CFG_OFFSET);
+
+	return 0;
+}
+
+static int clk_pllv4_enable(struct clk_hw *hw)
+{
+	u32 val;
+	struct clk_pllv4 *pll =3D to_clk_pllv4(hw);
+
+	val =3D readl_relaxed(pll->base);
+	val |=3D PLL_EN;
+	writel_relaxed(val, pll->base);
+
+	return clk_pllv4_wait_lock(pll);
+}
+
+static void clk_pllv4_disable(struct clk_hw *hw)
+{
+	u32 val;
+	struct clk_pllv4 *pll =3D to_clk_pllv4(hw);
+
+	val =3D readl_relaxed(pll->base);
+	val &=3D ~PLL_EN;
+	writel_relaxed(val, pll->base);
+}
+
+static const struct clk_ops clk_pllv4_ops =3D {
+	.recalc_rate	=3D clk_pllv4_recalc_rate,
+	.round_rate	=3D clk_pllv4_round_rate,
+	.set_rate	=3D clk_pllv4_set_rate,
+	.enable		=3D clk_pllv4_enable,
+	.disable	=3D clk_pllv4_disable,
+	.is_enabled	=3D clk_pllv4_is_enabled,
+};
+
+struct clk_hw *imx_clk_pllv4(const char *name, const char *parent_name,
+			  void __iomem *base)
+{
+	struct clk_pllv4 *pll;
+	struct clk_hw *hw;
+	struct clk_init_data init;
+	int ret;
+
+	pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->base =3D base;
+
+	init.name =3D name;
+	init.ops =3D &clk_pllv4_ops;
+	init.parent_names =3D &parent_name;
+	init.num_parents =3D 1;
+	init.flags =3D CLK_SET_RATE_GATE;
+
+	pll->hw.init =3D &init;
+
+	hw =3D &pll->hw;
+	ret =3D clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(pll);
+		hw =3D ERR_PTR(ret);
+	}
+
+	return hw;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 8e65282..1e11eb7 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -42,6 +42,9 @@ enum imx_pllv3_type {
 struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
 		const char *parent_name, void __iomem *base, u32 div_mask);
=20
+struct clk_hw *imx_clk_pllv4(const char *name, const char *parent_name,
+			     void __iomem *base);
+
 struct clk *clk_register_gate2(struct device *dev, const char *name,
 		const char *parent_name, unsigned long flags,
 		void __iomem *reg, u8 bit_idx, u8 cgr_val,
--=20
2.7.4

