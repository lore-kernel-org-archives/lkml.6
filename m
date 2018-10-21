Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F77ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 13:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D9920843
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 13:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OVl9ZPYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D9920843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbeJUVZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 17:25:33 -0400
Received: from mail-he1eur01on0045.outbound.protection.outlook.com ([104.47.0.45]:64912
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727266AbeJUVZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 17:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyU+rMFcsPtTyoukhBwEe1ULGqpSC4XBpGN0SSGfEz0=;
 b=OVl9ZPYscpoGbrRzCiJqbtj6CB4qhLJYqXy9cdfqqpk7UqHdX43t+9+Gs2Jc/J7wQrIjPl5ivu+7+QtRQAoKYPG2Wxto1ZkgtwUkyQajksHnaGTHKA2LZEpR4BcmSUiJgRLgqZIzev1sZJVsgZJ4s1gTNBblOqVunElF4Clpg3A=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4580.eurprd04.prod.outlook.com (52.135.149.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Sun, 21 Oct 2018 13:11:00 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10%2]) with mapi id 15.20.1250.028; Sun, 21 Oct 2018
 13:11:00 +0000
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
Subject: [PATCH RESEND V4 4/9] clk: imx: add pfdv2 support
Thread-Topic: [PATCH RESEND V4 4/9] clk: imx: add pfdv2 support
Thread-Index: AQHUaT+DMHnOMmhFkEyt0Fr+UuotNA==
Date:   Sun, 21 Oct 2018 13:11:00 +0000
Message-ID: <1540127173-21346-5-git-send-email-aisheng.dong@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4580;6:S38glzR82+wxZjv/jl88gpqx1Xnrj5QhrsoKnq8Qycs+kcDfej6lzjVDDrUu6VJLkbVGUf1XMBqThkuthiIqI9VaKBj4ONpYYyWSQOkhyvDM5z/SzE75vAhK50uDhBeNiPouPdF4/B5dKbjod4uklOrcjUxBcSA5AldRlFq8LBEzXeKWE6j3ou6u7/MO5g+BlnGwlyPo7DSsvzvVL+lThTaqfnFx8g9gt28gZnW17FLBPfoCZJGPdGZDknjEhfOMgcKm9H0MpS2mPY628X4H/AeqR11lAp6DRKiaA60KNZNSjb3O2ubsZ6xhBiAEx6bWEuSpmgScpVo5Q3VgoMgjjZBvP9A344v/V9SHReETCq89Nl7Wrdym/5ru6rg8+7Sb7wqzM5JZaouBG+YntI0xpGJLibNx/Ij/e4MZB7hZTO1B5dHPYzENYyPyxSl+/wuIVfUFrQgCnOzI4JYo8fMUbw==;5:00NqsXOt3s4asXnSFjsZPwqM/VWUOh592B2Qb2G4LCZ4elOK0SvkDT7szpRqy4ylz7U+6yRNC1nSYcBV2dZxaUTxkbzBgnzb1zC2Gp4xcSb97s1imdfQe4o7FEpwKO+N3kvyHwXug/whcRr/XqjbgBvc9tjf7lOaVCSSQren1xw=;7:OhZKqM5Thn9BhjNWxyaIAEsJDL6x7aaMnK08XXrUp91J9LBwhxcEitdlZ76Zc6s1iMeB+ef2ysbC2ZApwJugMlM2c+Z30lMvJgRGTYWBDqDjAxSyjSIC7RuacdSPs0XSnC02qlb7MaZmMuPL1W9ckUv3GiOODfRKrZ7GTqYjLVORG6N4jHANpDNhMvr0wuo9wSlmcSqAQQtpZFDOAuJe/SNBGV/PZWGB1/QWMxXqzKci/nV7RnPMLbVS3uxc9cfz
x-ms-office365-filtering-correlation-id: 36a8239d-9d0b-41a2-aaf4-08d63756a57b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4580;
x-ms-traffictypediagnostic: AM0PR04MB4580:
x-microsoft-antispam-prvs: <AM0PR04MB458030D33A388D67B48008EB80FB0@AM0PR04MB4580.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4580;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4580;
x-forefront-prvs: 083289FD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39850400004)(136003)(54534003)(199004)(189003)(476003)(2616005)(11346002)(446003)(66066001)(54906003)(316002)(26005)(52116002)(99286004)(486006)(186003)(7736002)(386003)(6506007)(305945005)(102836004)(105586002)(76176011)(50226002)(86362001)(106356001)(575784001)(256004)(14444005)(81156014)(81166006)(217873002)(8936002)(8676002)(6916009)(5250100002)(25786009)(2900100001)(2501003)(68736007)(71190400001)(2906002)(5660300001)(14454004)(3846002)(4326008)(6116002)(6512007)(53936002)(2351001)(6486002)(36756003)(71200400001)(478600001)(5640700003)(97736004)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4580;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HKABFTcB/kamfTTiSXmhPYAgCRKrPl2Opzni2xQaU9rsFQH4C9U6sIjZSrFihq4+RgFKg2KUvYaxaIxvgV+joY5Yu/vm6F973b00vN4H4jd0Emr1DB9wt0EFuxJksw0JCxqB5NbhJA8Q06vmYgx711gNCO9BFABovb8XRr/uGYBZ3yNEENXLcR6k5pB3DCePtQeQCCMiG7DaE8jFj7DMvgUXn23FP6LP0i35S8jcxNPAFHgLcMt54QyIvMNERAM9FyjbpdoDENPJq8sYH3EICjTxDwZ3ZRaeHK89siDdeRjTiGlc83PMe5bt/LqhgQ2h0o+oZ+aFHnfieXzi7k8yAuxoE6uJXhdHyNlx4aMLPWQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a8239d-9d0b-41a2-aaf4-08d63756a57b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2018 13:11:00.7564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4580
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pfdv2 is designed for PLL Fractional Divide (PFD) observed in System
Clock Generation (SCG) module in IMX ULP SoC series. e.g. i.MX7ULP.

NOTE pfdv2 can only be operated when clk is gated.

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
 * change to readl_poll_timeout
 * add pfd lock to protect share reg access between rate and enable/disable
   operations and multiple pfd instances.
 * use clk_hw_register
---
 drivers/clk/imx/Makefile    |   3 +-
 drivers/clk/imx/clk-pfdv2.c | 201 ++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/clk/imx/clk.h       |   3 +
 3 files changed, 206 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/clk-pfdv2.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index bfe31bf..e5b0d42 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -12,7 +12,8 @@ obj-y +=3D \
 	clk-pllv2.o \
 	clk-pllv3.o \
 	clk-pllv4.o \
-	clk-pfd.o
+	clk-pfd.o \
+	clk-pfdv2.o
=20
 obj-$(CONFIG_SOC_IMX1)   +=3D clk-imx1.o
 obj-$(CONFIG_SOC_IMX21)  +=3D clk-imx21.o
diff --git a/drivers/clk/imx/clk-pfdv2.c b/drivers/clk/imx/clk-pfdv2.c
new file mode 100644
index 0000000..afb2904
--- /dev/null
+++ b/drivers/clk/imx/clk-pfdv2.c
@@ -0,0 +1,201 @@
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
+/**
+ * struct clk_pfdv2 - IMX PFD clock
+ * @clk_hw:	clock source
+ * @reg:	PFD register address
+ * @gate_bit:	Gate bit offset
+ * @vld_bit:	Valid bit offset
+ * @frac_off:	PLL Fractional Divider offset
+ */
+
+struct clk_pfdv2 {
+	struct clk_hw	hw;
+	void __iomem	*reg;
+	u8		gate_bit;
+	u8		vld_bit;
+	u8		frac_off;
+};
+
+#define to_clk_pfdv2(_hw) container_of(_hw, struct clk_pfdv2, hw)
+
+#define CLK_PFDV2_FRAC_MASK 0x3f
+
+#define LOCK_TIMEOUT_US		USEC_PER_MSEC
+
+static DEFINE_SPINLOCK(pfd_lock);
+
+static int clk_pfdv2_wait(struct clk_pfdv2 *pfd)
+{
+	u32 val;
+
+	return readl_poll_timeout(pfd->reg, val, val & pfd->vld_bit,
+				  0, LOCK_TIMEOUT_US);
+}
+
+static int clk_pfdv2_enable(struct clk_hw *hw)
+{
+	struct clk_pfdv2 *pfd =3D to_clk_pfdv2(hw);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&pfd_lock, flags);
+	val =3D readl_relaxed(pfd->reg);
+	val &=3D ~pfd->gate_bit;
+	writel_relaxed(val, pfd->reg);
+	spin_unlock_irqrestore(&pfd_lock, flags);
+
+	return clk_pfdv2_wait(pfd);
+}
+
+static void clk_pfdv2_disable(struct clk_hw *hw)
+{
+	struct clk_pfdv2 *pfd =3D to_clk_pfdv2(hw);
+	unsigned long flags;
+	u32 val;
+
+	spin_lock_irqsave(&pfd_lock, flags);
+	val =3D readl_relaxed(pfd->reg);
+	val |=3D pfd->gate_bit;
+	writel_relaxed(val, pfd->reg);
+	spin_unlock_irqrestore(&pfd_lock, flags);
+}
+
+static unsigned long clk_pfdv2_recalc_rate(struct clk_hw *hw,
+					   unsigned long parent_rate)
+{
+	struct clk_pfdv2 *pfd =3D to_clk_pfdv2(hw);
+	u64 tmp =3D parent_rate;
+	u8 frac;
+
+	frac =3D (readl_relaxed(pfd->reg) >> pfd->frac_off)
+		& CLK_PFDV2_FRAC_MASK;
+
+	if (!frac) {
+		pr_debug("clk_pfdv2: %s invalid pfd frac value 0\n",
+			 clk_hw_get_name(hw));
+		return 0;
+	}
+
+	tmp *=3D 18;
+	do_div(tmp, frac);
+
+	return tmp;
+}
+
+static long clk_pfdv2_round_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long *prate)
+{
+	u64 tmp =3D *prate;
+	u8 frac;
+
+	tmp =3D tmp * 18 + rate / 2;
+	do_div(tmp, rate);
+	frac =3D tmp;
+
+	if (frac < 12)
+		frac =3D 12;
+	else if (frac > 35)
+		frac =3D 35;
+
+	tmp =3D *prate;
+	tmp *=3D 18;
+	do_div(tmp, frac);
+
+	return tmp;
+}
+
+static int clk_pfdv2_is_enabled(struct clk_hw *hw)
+{
+	struct clk_pfdv2 *pfd =3D to_clk_pfdv2(hw);
+
+	if (readl_relaxed(pfd->reg) & pfd->gate_bit)
+		return 0;
+
+	return 1;
+}
+
+static int clk_pfdv2_set_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long parent_rate)
+{
+	struct clk_pfdv2 *pfd =3D to_clk_pfdv2(hw);
+	unsigned long flags;
+	u64 tmp =3D parent_rate;
+	u32 val;
+	u8 frac;
+
+	tmp =3D tmp * 18 + rate / 2;
+	do_div(tmp, rate);
+	frac =3D tmp;
+	if (frac < 12)
+		frac =3D 12;
+	else if (frac > 35)
+		frac =3D 35;
+
+	spin_lock_irqsave(&pfd_lock, flags);
+	val =3D readl_relaxed(pfd->reg);
+	val &=3D ~(CLK_PFDV2_FRAC_MASK << pfd->frac_off);
+	val |=3D frac << pfd->frac_off;
+	writel_relaxed(val, pfd->reg);
+	spin_unlock_irqrestore(&pfd_lock, flags);
+
+	return 0;
+}
+
+static const struct clk_ops clk_pfdv2_ops =3D {
+	.enable		=3D clk_pfdv2_enable,
+	.disable	=3D clk_pfdv2_disable,
+	.recalc_rate	=3D clk_pfdv2_recalc_rate,
+	.round_rate	=3D clk_pfdv2_round_rate,
+	.set_rate	=3D clk_pfdv2_set_rate,
+	.is_enabled     =3D clk_pfdv2_is_enabled,
+};
+
+struct clk_hw *imx_clk_pfdv2(const char *name, const char *parent_name,
+			     void __iomem *reg, u8 idx)
+{
+	struct clk_init_data init;
+	struct clk_pfdv2 *pfd;
+	struct clk_hw *hw;
+	int ret;
+
+	WARN_ON(idx > 3);
+
+	pfd =3D kzalloc(sizeof(*pfd), GFP_KERNEL);
+	if (!pfd)
+		return ERR_PTR(-ENOMEM);
+
+	pfd->reg =3D reg;
+	pfd->gate_bit =3D 1 << ((idx + 1) * 8 - 1);
+	pfd->vld_bit =3D pfd->gate_bit - 1;
+	pfd->frac_off =3D idx * 8;
+
+	init.name =3D name;
+	init.ops =3D &clk_pfdv2_ops;
+	init.parent_names =3D &parent_name;
+	init.num_parents =3D 1;
+	init.flags =3D CLK_SET_RATE_GATE;
+
+	pfd->hw.init =3D &init;
+
+	hw =3D &pfd->hw;
+	ret =3D clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(pfd);
+		hw =3D ERR_PTR(ret);
+	}
+
+	return hw;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 2fb4f1d..a5a9374 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -60,6 +60,9 @@ struct clk *imx_clk_gate_exclusive(const char *name, cons=
t char *parent,
 struct clk *imx_clk_pfd(const char *name, const char *parent_name,
 		void __iomem *reg, u8 idx);
=20
+struct clk_hw *imx_clk_pfdv2(const char *name, const char *parent_name,
+			     void __iomem *reg, u8 idx);
+
 struct clk *imx_clk_busy_divider(const char *name, const char *parent_name=
,
 				 void __iomem *reg, u8 shift, u8 width,
 				 void __iomem *busy_reg, u8 busy_shift);
--=20
2.7.4

