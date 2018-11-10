Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDE2C43610
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BFE20817
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rBlWIH4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BFE20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbeKKATn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 19:19:43 -0500
Received: from mail-eopbgr40048.outbound.protection.outlook.com ([40.107.4.48]:1837
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726334AbeKKATm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 19:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0EhitKCGo/9Ctx6Tfyde6/OwLLiZHv+XKCM1xHhD6Q=;
 b=rBlWIH4SoapZO0aK1nanWCEcJYJY/94aAjY+G0opHNJFAZWG3Ghspxu2xw5yo7rkBW7pLIpO5qNQWiMGQrgY8zl+2E+26fmZ2E+UrUxTDfblT/XhybIye/LxSgUjxhi+azLvuToSV9euJptEscKi49w9SEksFxzOj0PMZwNUIYI=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4402.eurprd04.prod.outlook.com (52.135.148.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Sat, 10 Nov 2018 14:34:26 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10%2]) with mapi id 15.20.1294.039; Sat, 10 Nov 2018
 14:34:26 +0000
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
Subject: [PATCH V5 3/9] clk: imx: add pllv4 support
Thread-Topic: [PATCH V5 3/9] clk: imx: add pllv4 support
Thread-Index: AQHUeQJ7Vu92z1oG9UG25W6tIuA27A==
Date:   Sat, 10 Nov 2018 14:34:26 +0000
Message-ID: <1541860165-401-4-git-send-email-aisheng.dong@nxp.com>
References: <1541860165-401-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1541860165-401-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::20) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4402;6:QsfVrlqIAa+iLbuSY6NpS0hXIsAwp06j+sw/oOnDbLK9JUAzB5CYt9kVnIXvNeNcbbvO7aOC2D20/rsb+25KQ6/13unFxPIojDIYH8FgEM/qBBUMIHFaNXhstZth1zQCul9NBOjIDhSlXP2NoZpAm6ddZ3WidSC90Uxv6X6beHC8h/oMyIDC7APZfHpYc/XtPYCkkTovGgcqcIrYu03x9BlsSLKZ9TGMqA309O/74dePsZ2A2vlF+D0qCCB4v1H8Ma5sC4Yd65spo8ms+0diS88NxOD5a/fs3jBmfjG+4j+A6fH9k6EFUGiBHIZtxfjDKD0jKTRyz6SBFdHR2O2HLa2IVSOgCLuAk+6sb+IIVfCF5aJFxP0nNVKnS5UwSaLl1/ZBNpC2nG8wehiPxsibyCbhxMepX+uPfxmgLgMMq7xWcVxId06VrUBh9YICx8qwAv8NJtQ827zP2kgSX6MGeA==;5:HHX4pZLBu7SNgAJ5ggDb8gwVl/PazyaiI+MdSOqrGonX0B7F5MsHAP1/pfDOEYT5KyVuTrrDFJjqbyViXMHhebAAz92/oNLzJeumYokd0/G9EPwiXvDagY/I1MfaTa4xcR7LqY4/3TA52KwnL7uD1WsTMpGPgv7rVy8UTJu3C0Q=;7:Hn0AhC8yi6zEIefR89mnR1lXYsthVeQJL0k13D5xzpnovQiRs+eimae9q74QZbCQK6nABWRclIoJlgZLsfOJjhjbLWZuxC1xUMCXm9AibkF4yxYmPt35hOqWEJi8dHTZASo+w+d2j5QigGR9K1B92A==
x-ms-office365-filtering-correlation-id: 1399f85f-a9d9-4783-8f39-08d647199d55
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4402;
x-ms-traffictypediagnostic: AM0PR04MB4402:
x-microsoft-antispam-prvs: <AM0PR04MB4402EC897786635FD8E4273E80C70@AM0PR04MB4402.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4402;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4402;
x-forefront-prvs: 0852EB6797
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(54534003)(6512007)(478600001)(102836004)(36756003)(14444005)(4326008)(105586002)(256004)(76176011)(97736004)(71200400001)(71190400001)(106356001)(14454004)(386003)(6506007)(52116002)(2351001)(5660300001)(25786009)(5640700003)(2906002)(81166006)(81156014)(66066001)(6436002)(26005)(186003)(575784001)(6916009)(8676002)(54906003)(8936002)(3846002)(305945005)(486006)(7736002)(6116002)(2900100001)(446003)(11346002)(68736007)(53936002)(476003)(2501003)(99286004)(6486002)(50226002)(2616005)(316002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4402;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 2MdCrMQ4lXCgWXh6b1pAUEJJ2GPm/vmsO6faeg1qF0KM9XH+rDBR09c9MLxfB7ghWnp/fdI3ixEAFVkAkoVj5gqNhGlRYxcKcaFp7XNS4eLaGr2ftPicfbxWg3frbdMSbRTiLAuRZdyfTpeT45/67BVZI2GlDnvNunsFAqpZmUaIE5R/86/3FAQapBJFYkc9n36s5pk98fEQ5FMO7z0Qm9qP4Eyzhah9usjotoJgbDOJXl0kO3KQQKvTkZyRRmQq2cHuXgkruPO5mXUf6fxspz33FofofB6RHkWZhm+ba5sQZGVLA+UPnzalrCfkUIiK1yYIgKfOV8LjX6kzVLnaWILEgDP19NzhG2iDnYB5fO4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1399f85f-a9d9-4783-8f39-08d647199d55
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2018 14:34:26.3191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4402
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
index 8c3baa7..bfe31bf 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -11,6 +11,7 @@ obj-y +=3D \
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
index 8076ec0..2fb4f1d 100644
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

