Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4B5C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF0520817
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FcSqNjvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF0520817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeKKATr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 19:19:47 -0500
Received: from mail-eopbgr40086.outbound.protection.outlook.com ([40.107.4.86]:48608
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726334AbeKKATq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 19:19:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyU+rMFcsPtTyoukhBwEe1ULGqpSC4XBpGN0SSGfEz0=;
 b=FcSqNjvsTSJZSbxcYZqMl4s2G6N93y8skBipN2qMWBI8OAmX3nPQu2p52bNA/NpkFmMdTFq7vIMYVw1duuP3/Z9s4puFHgqPRv07PuydnA/E9S/gTfMBOM14fR0ZPxu9YObTM7NE3VAppkrfOe2P4AIY6eYSudpmLc3FszBfmNI=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4402.eurprd04.prod.outlook.com (52.135.148.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Sat, 10 Nov 2018 14:34:30 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10%2]) with mapi id 15.20.1294.039; Sat, 10 Nov 2018
 14:34:30 +0000
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
Subject: [PATCH V5 4/9] clk: imx: add pfdv2 support
Thread-Topic: [PATCH V5 4/9] clk: imx: add pfdv2 support
Thread-Index: AQHUeQJ9ueOUK+njeEuBeKpYaoZtGQ==
Date:   Sat, 10 Nov 2018 14:34:30 +0000
Message-ID: <1541860165-401-5-git-send-email-aisheng.dong@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4402;6:0/Xla/3jFQTU/JOSdAeUTohjIy0K73CAOwd3qMnKI8O3CpG5UgvxwlWeNnyTW5NUlRnepwz09ZGJWQPUki5VNia6YSCFVEKkNbleYnkLWi0wr1QDBna7jbWFtAZPduwIC1sAYqrjarGmIl2xEF2EMr632eGPbQ/Nk0fTGaWkHMiudXlGfBQxdlAjXYULuppMMtQlU1NlfdaxsTTdE1cvLCBKdNa0IGqapOglYK9tABm+OV3vRsdRzHmQpih39Mc9zYQ8KuKruNBiQe8Vijh1vH/pB3Ky4xAvyBcd8mVauaG3b+xvvlaQJ4AyZY6rFz0R2DH3cErN63NgXFUWNwK9utSMX5P5CkeHb7KFfZcmrjBImk/i93yuTTKI3bSJpFiAW4bV7nh0a1psJCJrliQM/sMGBI0HCmWzA/GUnJEZPhtTebcT/LkE6URERw3000uYCulTBwjMg5POCv3lskkT0w==;5:LG+d3AJcSEqUiWK4+Zszfc01EhRmj8Qnh/UidO9OuAPPdwTS9xUD07Gx7tHednWe2Z8JeHd7z5C0c0g8rQnnIbF4NL3hAEpowNQdLvmg2duv/kVEBPA7H744kIRANraheCSMXuoIBL/QJNgaVZgjHAlsI7KMijBHPe8R5hAwEWM=;7:cO3tBvNhb0czYAm41snGE4jxArAkT9uKSo8POIsylNBcLOKncp40xhXl4wlreJO9LAr6bvu1JyyBAb4SmhOd4qctPXDaeoXgXZ8RDpxvrp5tpQmW1RZjqNacChxP4mU/2c/ak+RQZvqSREySZBRogQ==
x-ms-office365-filtering-correlation-id: 811bada1-a50b-4f11-5a12-08d647199fc1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4402;
x-ms-traffictypediagnostic: AM0PR04MB4402:
x-microsoft-antispam-prvs: <AM0PR04MB4402DBABAD3F6E1FC8B3592980C70@AM0PR04MB4402.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4402;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4402;
x-forefront-prvs: 0852EB6797
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(54534003)(6512007)(478600001)(102836004)(36756003)(14444005)(4326008)(105586002)(256004)(76176011)(97736004)(71200400001)(71190400001)(106356001)(14454004)(386003)(6506007)(52116002)(2351001)(5660300001)(25786009)(5640700003)(2906002)(81166006)(81156014)(66066001)(6436002)(26005)(186003)(575784001)(6916009)(8676002)(54906003)(8936002)(3846002)(305945005)(486006)(7736002)(6116002)(2900100001)(446003)(11346002)(68736007)(53936002)(476003)(2501003)(99286004)(6486002)(50226002)(2616005)(316002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4402;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mM1wX5MSIT6GWNReXrE/lGV8rGUX8r6tp9Nm9mETumY6mBwjO6p3Su+l8fYdrHAKuad629I69v1A/WlBSa/rszbV/Gvc7TJUlF0ScNRQ4OTL76hz2GcRRQOyOwr+DYF3HtyAvnUR4VL1pyNxQKw2xu7RUoIX4Qck5ZVopCRfJt4W/XQG8/DCaWzc5jtj+v6W/KZ4X2VTnShVHbN6Jy/7LT8LL+ovBKLe0E22SzYE6fpEbEcJGSUo9RJ2A6cNjgkQyTLkILOByXI88JX1zMH8YorXTj5VSVSQCWH2hT5DcldsC967e7xN2qZzzsDkQQQTAKy9pOQRGXtSLeSSxJYGDfnIBaqZXrprBYqmmRV17Dc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 811bada1-a50b-4f11-5a12-08d647199fc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2018 14:34:30.1858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4402
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

