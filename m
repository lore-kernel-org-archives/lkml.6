Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E53C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C9B2081D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jG0mzUC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C9B2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeLAWFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 17:05:10 -0500
Received: from mail-eopbgr30068.outbound.protection.outlook.com ([40.107.3.68]:30848
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726416AbeLAWFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 17:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9oLdGrbrumszVQP77qQN7tHMWaLYSe8v/cMPZ7dqFY=;
 b=jG0mzUC17mEJ6ECbFbmUD6hUQIwqAMeZX6W/+W1x8UG24gdwRiT3uKF0WR053Zt9ZaYroGf5UjxbVj908/3g6EnAc2a7rRdrFMO8UP+4G768VMHovwIl3f9gOnfe3SBMh+hlzFIv6YbBdI8h2u0mPivEULGR0ChsZ146+TNVHEk=
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com (52.133.28.145) by
 AM6PR0402MB3622.eurprd04.prod.outlook.com (52.133.20.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.20; Sat, 1 Dec 2018 10:52:14 +0000
Received: from AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d]) by AM6PR0402MB3654.eurprd04.prod.outlook.com
 ([fe80::c46b:915c:7a03:123d%3]) with mapi id 15.20.1339.036; Sat, 1 Dec 2018
 10:52:14 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v15 4/5] clk: imx: Add imx composite clock
Thread-Topic: [PATCH v15 4/5] clk: imx: Add imx composite clock
Thread-Index: AQHUiWPrFjWICst1hEOkPNFe63f7mw==
Date:   Sat, 1 Dec 2018 10:52:14 +0000
Message-ID: <1543661502-18573-5-git-send-email-abel.vesa@nxp.com>
References: <1543661502-18573-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1543661502-18573-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR0402CA0017.eurprd04.prod.outlook.com
 (2603:10a6:209::30) To AM6PR0402MB3654.eurprd04.prod.outlook.com
 (2603:10a6:209:19::17)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR0402MB3622;6:qAdhjhIb1KIcRe6gNxo/fUmn7PRZiyOHqmxLvPccpacmHz1hDxmp8I1a0DlBp9S/aOgCHcT6xHgKtRagH8n8cla/u46dNOaxaZc5E1OLjbUCLMdDGQZjL5+HFmuh1ZapWeVtgAPdCVMNe7KeavBmThfMyWhQwLE03SzoEVHHx0GPwn2o+CctWDm8VhuauL7SxwvC1CKLbn+m9pa+kstS4ktzAfXQPsB/MJiATC7/GpneJ0lEh8zjDfttTmpilrKnT7eS+ngAX6HjryTFOelAL3p6gr0tyOQUpD+TeWMv+XuwBg+grFES8O3cwPLhk8Yf5kHxldtmmiFiZh1Tnr6PddRyvZ+4KCSzMa2uC6rYyAGZjNlQDkfyjYnvdu1rDqunGYit99wclaVwZo+1DoBC4v2ugTkUr7rxdHMwFXGu1YNq4PgoIum56VePq1zEG8nDw5o58ltZziV2Q+3QSfWm6g==;5:QgdbUkHZ8l2La1SL2nDpc8LlWSeFIFCDGJnt/iAVQRiS00tI6QUndkqQ5KF71fbX97qlUcP0mnhderihdlnJrE+bnLA5tpz00W7AY00IH1L1rIHctuD/Mx9X85MmiDO8ltAqvr8ufe/7x5Rj/9tS/AkzYlgMimQprTHJO8KJMGE=;7:8jfjyrr9iWiPjGTO6Ag6qte9eS0HZXY551rwuDs2db9+TDv8itOy7aAvr+Bf10pbIv+09swRU3771tgU92EDs6kOo/e61FuFGnl0ICqJfe5XonHM8ACIUIKuZm2Fws8c0ZuCfW+hbFJQWUgzOoVXxw==
x-ms-office365-filtering-correlation-id: 082f8fdc-4a61-4a55-5e73-08d6577b0d8b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR0402MB3622;
x-ms-traffictypediagnostic: AM6PR0402MB3622:
x-microsoft-antispam-prvs: <AM6PR0402MB3622169F5704E50FAAE53158F6AC0@AM6PR0402MB3622.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231454)(999002)(944501410)(52105112)(93006095)(93001095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM6PR0402MB3622;BCL:0;PCL:0;RULEID:;SRVR:AM6PR0402MB3622;
x-forefront-prvs: 087396016C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(396003)(346002)(376002)(189003)(199004)(305945005)(76176011)(53936002)(316002)(52116002)(99286004)(54906003)(3846002)(6116002)(575784001)(86362001)(6512007)(106356001)(110136005)(81156014)(81166006)(8676002)(2906002)(14454004)(476003)(11346002)(2616005)(446003)(105586002)(256004)(8936002)(478600001)(66066001)(71200400001)(44832011)(486006)(97736004)(6486002)(6436002)(14444005)(26005)(186003)(102836004)(7416002)(5660300001)(71190400001)(4326008)(36756003)(68736007)(7736002)(386003)(6506007)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR0402MB3622;H:AM6PR0402MB3654.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: DHDZ2oP2tQSOIXgne8oXqau95q0hV97Axqs5PKe/5THmob+mgLyITiJnx7RJMV0483gHsFfKbNDj4nSddUGGFeFVHEUYPsUG2Mno/LuUIbBUVjVDL0DaHcGvCPjR79VMk6a30NXu0kYIIu1hRhwuOJatdFshed7nxAkhfKhmVL4ICehPFoYOpvC6UrSDbo2L1BEo4RCzgoNix1ejWlfrWFJ+NfSM+hzpQbrkSdoFTU907pxgDi0DKSDV7LvoxNHapYfiqD0mszIVCmQsnMMjDWFOnQLkwEvEpu9m9XK0syF0agZfnOdo8ZBc6QcDrJfMggdCHkIaemi8kGAt03Aeb300SMUhqVh+36EHCmzzDXw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082f8fdc-4a61-4a55-5e73-08d6577b0d8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2018 10:52:14.2147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a lot of clocks on imx8m are formed by a mux, gate, predivider and
divider, the idea here is to combine all of those into one composite clock,
but we need to deal with both predivider and divider at the same time and
therefore we add the imx8m_clk_composite_divider_ops and register
the composite clock with those.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/imx/Makefile           |   1 +
 drivers/clk/imx/clk-composite-8m.c | 178 +++++++++++++++++++++++++++++++++=
++++
 drivers/clk/imx/clk.h              |  16 ++++
 3 files changed, 195 insertions(+)
 create mode 100644 drivers/clk/imx/clk-composite-8m.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index b87513c..237444b 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -3,6 +3,7 @@
 obj-y +=3D \
 	clk.o \
 	clk-busy.o \
+	clk-composite-8m.o \
 	clk-cpu.o \
 	clk-fixup-div.o \
 	clk-fixup-mux.o \
diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-compo=
site-8m.c
new file mode 100644
index 0000000..6d9d371
--- /dev/null
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 NXP
+ */
+
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/clk-provider.h>
+
+#include "clk.h"
+
+#define PCG_PREDIV_SHIFT	16
+#define PCG_PREDIV_WIDTH	3
+#define PCG_PREDIV_MAX		8
+
+#define PCG_DIV_SHIFT		0
+#define PCG_DIV_WIDTH		6
+#define PCG_DIV_MAX		64
+
+#define PCG_PCS_SHIFT		24
+#define PCG_PCS_MASK		0x7
+
+#define PCG_CGC_SHIFT		28
+
+static unsigned long imx8m_clk_composite_divider_recalc_rate(struct clk_hw=
 *hw,
+						unsigned long parent_rate)
+{
+	struct clk_divider *divider =3D to_clk_divider(hw);
+	unsigned long prediv_rate;
+	unsigned int prediv_value;
+	unsigned int div_value;
+
+	prediv_value =3D readl(divider->reg) >> divider->shift;
+	prediv_value &=3D clk_div_mask(divider->width);
+
+	prediv_rate =3D divider_recalc_rate(hw, parent_rate, prediv_value,
+						NULL, divider->flags,
+						divider->width);
+
+	div_value =3D readl(divider->reg) >> PCG_DIV_SHIFT;
+	div_value &=3D clk_div_mask(PCG_DIV_WIDTH);
+
+	return divider_recalc_rate(hw, prediv_rate, div_value, NULL,
+				   divider->flags, PCG_DIV_WIDTH);
+}
+
+static int imx8m_clk_composite_compute_dividers(unsigned long rate,
+						unsigned long parent_rate,
+						int *prediv, int *postdiv)
+{
+	int div1, div2;
+	int error =3D INT_MAX;
+	int ret =3D -EINVAL;
+
+	*prediv =3D 1;
+	*postdiv =3D 1;
+
+	for (div1 =3D 1; div1 <=3D PCG_PREDIV_MAX; div1++) {
+		for (div2 =3D 1; div2 <=3D PCG_DIV_MAX; div2++) {
+			int new_error =3D ((parent_rate / div1) / div2) - rate;
+
+			if (abs(new_error) < abs(error)) {
+				*prediv =3D div1;
+				*postdiv =3D div2;
+				error =3D new_error;
+				ret =3D 0;
+			}
+		}
+	}
+	return ret;
+}
+
+static long imx8m_clk_composite_divider_round_rate(struct clk_hw *hw,
+						unsigned long rate,
+						unsigned long *prate)
+{
+	int prediv_value;
+	int div_value;
+
+	imx8m_clk_composite_compute_dividers(rate, *prate,
+						&prediv_value, &div_value);
+	rate =3D DIV_ROUND_UP(*prate, prediv_value);
+
+	return DIV_ROUND_UP(rate, div_value);
+
+}
+
+static int imx8m_clk_composite_divider_set_rate(struct clk_hw *hw,
+					unsigned long rate,
+					unsigned long parent_rate)
+{
+	struct clk_divider *divider =3D to_clk_divider(hw);
+	unsigned long flags =3D 0;
+	int prediv_value;
+	int div_value;
+	int ret =3D 0;
+	u32 val;
+
+	ret =3D imx8m_clk_composite_compute_dividers(rate, parent_rate,
+						&prediv_value, &div_value);
+	if (ret)
+		return -EINVAL;
+
+	spin_lock_irqsave(divider->lock, flags);
+
+	val =3D readl(divider->reg);
+	val &=3D ~((clk_div_mask(divider->width) << divider->shift) |
+			(clk_div_mask(PCG_DIV_WIDTH) << PCG_DIV_SHIFT));
+
+	val |=3D (u32)(prediv_value  - 1) << divider->shift;
+	val |=3D (u32)(div_value - 1) << PCG_DIV_SHIFT;
+	writel(val, divider->reg);
+
+	spin_unlock_irqrestore(divider->lock, flags);
+
+	return ret;
+}
+
+static const struct clk_ops imx8m_clk_composite_divider_ops =3D {
+	.recalc_rate =3D imx8m_clk_composite_divider_recalc_rate,
+	.round_rate =3D imx8m_clk_composite_divider_round_rate,
+	.set_rate =3D imx8m_clk_composite_divider_set_rate,
+};
+
+struct clk *imx8m_clk_composite_flags(const char *name,
+					const char **parent_names,
+					int num_parents, void __iomem *reg,
+					unsigned long flags)
+{
+	struct clk_hw *hw =3D ERR_PTR(-ENOMEM), *mux_hw;
+	struct clk_hw *div_hw, *gate_hw;
+	struct clk_divider *div =3D NULL;
+	struct clk_gate *gate =3D NULL;
+	struct clk_mux *mux =3D NULL;
+
+	mux =3D kzalloc(sizeof(*mux), GFP_KERNEL);
+	if (!mux)
+		goto fail;
+
+	mux_hw =3D &mux->hw;
+	mux->reg =3D reg;
+	mux->shift =3D PCG_PCS_SHIFT;
+	mux->mask =3D PCG_PCS_MASK;
+
+	div =3D kzalloc(sizeof(*div), GFP_KERNEL);
+	if (!div)
+		goto fail;
+
+	div_hw =3D &div->hw;
+	div->reg =3D reg;
+	div->shift =3D PCG_PREDIV_SHIFT;
+	div->width =3D PCG_PREDIV_WIDTH;
+	div->lock =3D &imx_ccm_lock;
+	div->flags =3D CLK_DIVIDER_ROUND_CLOSEST;
+
+	gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		goto fail;
+
+	gate_hw =3D &gate->hw;
+	gate->reg =3D reg;
+	gate->bit_idx =3D PCG_CGC_SHIFT;
+
+	hw =3D clk_hw_register_composite(NULL, name, parent_names, num_parents,
+			mux_hw, &clk_mux_ops, div_hw,
+			&imx8m_clk_composite_divider_ops,
+			gate_hw, &clk_gate_ops, flags);
+	if (IS_ERR(hw))
+		goto fail;
+
+	return hw->clk;
+
+fail:
+	kfree(gate);
+	kfree(div);
+	kfree(mux);
+	return ERR_CAST(hw);
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 864cd8a..cb3e92c 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -239,4 +239,20 @@ struct clk *imx_clk_cpu(const char *name, const char *=
parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
=20
+struct clk *imx8m_clk_composite_flags(const char *name,
+					const char **parent_names,
+					int num_parents, void __iomem *reg,
+					unsigned long flags);
+
+#define __imx8m_clk_composite(name, parent_names, reg, flags) \
+	imx8m_clk_composite_flags(name, parent_names, \
+		ARRAY_SIZE(parent_names), reg, \
+		flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
+
+#define imx8m_clk_composite(name, parent_names, reg) \
+	__imx8m_clk_composite(name, parent_names, reg, 0)
+
+#define imx8m_clk_composite_critical(name, parent_names, reg) \
+	__imx8m_clk_composite(name, parent_names, reg, CLK_IS_CRITICAL)
+
 #endif
--=20
2.7.4

