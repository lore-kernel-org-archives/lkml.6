Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B526ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 13:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC1920843
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 13:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vs4pqBi9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC1920843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbeJUVZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 17:25:30 -0400
Received: from mail-he1eur01on0045.outbound.protection.outlook.com ([104.47.0.45]:64912
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727477AbeJUVZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 17:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U0EhitKCGo/9Ctx6Tfyde6/OwLLiZHv+XKCM1xHhD6Q=;
 b=vs4pqBi93/cUgaMBsv9cpVnXG1N2g5KGuIir6m9XrjC4l69gAx5/RxRG42ZRxECcix0yv+V1JDPKsRrmg5mXK7hVjwxgPm8HM3+L5swt2hpjhaqdtZQs7fEyKPVLtPdbDa9Y6bEn8zLgt7GaP+oIFIZ1O+oYFbmTctjgjkD1LF8=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4580.eurprd04.prod.outlook.com (52.135.149.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Sun, 21 Oct 2018 13:10:56 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10%2]) with mapi id 15.20.1250.028; Sun, 21 Oct 2018
 13:10:56 +0000
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
Subject: [PATCH RESEND V4 3/9] clk: imx: add pllv4 support
Thread-Topic: [PATCH RESEND V4 3/9] clk: imx: add pllv4 support
Thread-Index: AQHUaT+ARhoGQHwUVEmK8lzIfdE+yg==
Date:   Sun, 21 Oct 2018 13:10:56 +0000
Message-ID: <1540127173-21346-4-git-send-email-aisheng.dong@nxp.com>
References: <1540127173-21346-1-git-send-email-aisheng.dong@nxp.com>
In-Reply-To: <1540127173-21346-1-git-send-email-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::22) To AM0PR04MB4211.eurprd04.prod.outlook.com
 (2603:10a6:208:66::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4580;6:3cJLf6ReHJ+UXxy3hQjTJC2NRhtb0ji0BJwxlP0yuuwHUTiqcMdtFWHRCdAh0EtofIkC5xzTZcnxvFd5PmaCX+jdaNxw0B6BYJKEXB2wLQc/opdPT7EkaRfrPeSO33k4/wMRfvt+YIs5RQYvds2RJUZ2bRYSSqyx8um54htaB/1X5OzpMJV/myW1C+ca2q8oTxHYMfItkk8bNX5N+edWTPE1IIoEp+18ccsuRyuRco9WgicaEBqjEMhXUy/8qqKZz4Dz7wWgvTV9J8toTeQlxvL62aZiSnrYTQhTB4howEpGj7VKW2bLntMSY6v5zP306L6Uya0hh79NlASkiRac3HXl9WPMOyTsolfZZrBXS0glUrjaq6d+ogyExWvpeKgWqaji5JNrt4VzbmjGB5JZzYwGekghXQEW5HZ5pPF3Zkg3AnL1V1dD889NlWWK/+pfBEns6UYl5JZjtV47aGde6w==;5:/Zh0yf5IdSr+azoeUDnTP58rrxmfJzNCePEEcg+q1m/i4XHTmHbYYL8AdP3OB4bd1u2iaG16QmCdzWJB0oEOyueYHv+fTVHxUR59Hs+MYYlSzkVECDmZVmv9ZSjNR9cGtHAbLf91wNpcxXZ8ci6aBUBpS1SwPk3hMY+QQerDaK4=;7:HgbXb76ewSXga87JDniFb5bV8ybZofCUp8nbi0J19kq1pGbDPS3E9uFqawrZNwodw8fAWQj+WqQx12pziRbwezF5bbv6zL93yrhu59YzI3gJVc+5AMo5SG9WRl1oovRYYfSYGPtoHOEcAPEO7qq1RjOxj1ATmEsb7QtCVAKjWpZy0y9pExH2u3iK7Mc6TslzscMED4yw2HQIBtotzzFB5X9eY09qb8CXHO6fZz2nrwclS/HlDs5gFE/2IosaKE7I
x-ms-office365-filtering-correlation-id: 41497a27-b309-4d99-dba8-08d63756a303
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4580;
x-ms-traffictypediagnostic: AM0PR04MB4580:
x-microsoft-antispam-prvs: <AM0PR04MB45802ABEA9EEC35AA6F5CD7080FB0@AM0PR04MB4580.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4580;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4580;
x-forefront-prvs: 083289FD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39850400004)(136003)(54534003)(199004)(189003)(476003)(2616005)(11346002)(446003)(66066001)(54906003)(316002)(26005)(52116002)(99286004)(486006)(186003)(7736002)(386003)(6506007)(305945005)(102836004)(105586002)(76176011)(50226002)(86362001)(106356001)(575784001)(256004)(14444005)(81156014)(81166006)(217873002)(8936002)(8676002)(6916009)(5250100002)(25786009)(2900100001)(2501003)(68736007)(71190400001)(2906002)(5660300001)(14454004)(3846002)(4326008)(6116002)(6512007)(53936002)(2351001)(6486002)(36756003)(71200400001)(478600001)(5640700003)(97736004)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4580;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: g/uIMIyX+7lPFDw0c7jVJfHLXzdBtrJQzPl6PPpWXpEWVMP27Z0UrSicPoMOkXPGCbL1TY6aaObPbN0hm1EoI1sH8nV8UU4jJYyhiWHV8lJqtuQCGjD+l9VPcuusq+LFZB4U4/jQumShn1AHBbNFMlVnGrcMwhagX9W76l/Hc0r8obsSBGKzYuvxNvYCK/9NPx/jcIU8uWXDII4Bgn+bh6Qz1pM/lXGPoRB1hYiVF8aYkEp8FRu0kOg572y+6UUI6rkR9LbjT2YazUouE+7DQmtM4IlK4cLSt4zh+st05+msFY6A2vblWW3NvW02c5T+5n0sKECh2aWH6eCkdn0FSQtKpfLipkl/CvRbnHPcELw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41497a27-b309-4d99-dba8-08d63756a303
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2018 13:10:56.7564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4580
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

