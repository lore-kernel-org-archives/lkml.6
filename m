Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321D9C43610
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8B520858
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PGe3ep6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8B520858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeKKATu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 19:19:50 -0500
Received: from mail-eopbgr40051.outbound.protection.outlook.com ([40.107.4.51]:8741
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726334AbeKKATu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 19:19:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/JY0Q5vv9j2oH4Cv+0TT1Zub/uHnWM66FdeA6DIX6c=;
 b=PGe3ep6z9Bnmyp151lUUjPKAlcN7cQFRCdE5fRTYKPSaQhjQpLz27LirvY4SRJIhIVsq9T70a5nwadx05bZUxVAYka8H6KMsvNlIS9axh2Yu9QYigKhAHSILp6inlwz/d4qGrRm0KzSSnnB6j9WdShTZ0DSKiweC9sMGEv/I1ec=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4402.eurprd04.prod.outlook.com (52.135.148.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Sat, 10 Nov 2018 14:34:34 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10%2]) with mapi id 15.20.1294.039; Sat, 10 Nov 2018
 14:34:34 +0000
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
Subject: [PATCH V5 5/9] clk: imx: add imx7ulp composite clk support
Thread-Topic: [PATCH V5 5/9] clk: imx: add imx7ulp composite clk support
Thread-Index: AQHUeQJ/JhV54ocwQUOcNDu+7sK0GQ==
Date:   Sat, 10 Nov 2018 14:34:34 +0000
Message-ID: <1541860165-401-6-git-send-email-aisheng.dong@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4402;6:R/90Kc7gSL7xrmO7GqJelOWL4Vzbjm4nW1NAL6jDDE0a6LE9xNmDK758Va1g1JM08LJ/oEqWiieVN3FttNj2m7YItMmRROUS7y06OjdzZgLzu17Uv9zzdDPI6kZ2YgGvs7eSBSQaPV6+jwU3Bsiy8M6wZsKwcx0N2JmsESj5fqYqd/1x6qNOoF2f4dGJ/cNn8NkdHhLZbjlYnjoyQ3own1f3p13rNu7lAb0PMiW//kQuY+eZMML0erz2TXNn3Z48NJ2IeflXsIrxOQF7iOp4xV86hrBNyKNpST4JKSSr0BAGAlCCMmKjzr1AudpZX113R+WxG9YAXyA+EHNIMrQPrtDxqSv17jI79LwJ/jWCx4DQJHMSEicrdxYq31vwLLTplePK4h/okbhfsd2FmpTyO1kF06GSIYsu0yrlyuHO9XPDG7rgNlNjkfHcbTqcJXyhuDHCU42sUxTUu+Qd4kmlkw==;5:c2e7Lm+6nc8aHslM8uSU3ZrU2GyZJdVuBmqWid5nta6Q2VMuYs+2ZHC4wW96f9t43w0ta/gKJh8K0sy5D45oVmA2F/iJ0CFYuPKJ4NZmimcgeYKyxERZLDr5YSclzDNkSNJ4mXfRD3NMCnWJ2OJmsJVL9pOlikh3y1v+hjn/GnE=;7:265+P0GlZ+SE5I1dXWL66RsfELM050KBZkEIWI8ghu6jOpVzMvCC7ia4Aw7NULCyhxV/a9qmXOMTNGccYgdX9O0NZndPfaLZvyGeRN1TPJ6nUFcxUF331h0qPlegJ+enai/dyiV4C5JkbPkywKR2Mw==
x-ms-office365-filtering-correlation-id: 24e151e7-8f42-4873-bf1a-08d64719a224
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4402;
x-ms-traffictypediagnostic: AM0PR04MB4402:
x-microsoft-antispam-prvs: <AM0PR04MB440202AFF686761F0C6F386F80C70@AM0PR04MB4402.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4402;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4402;
x-forefront-prvs: 0852EB6797
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(54534003)(6512007)(478600001)(102836004)(36756003)(4326008)(105586002)(256004)(76176011)(97736004)(71200400001)(71190400001)(106356001)(14454004)(386003)(6506007)(52116002)(2351001)(5660300001)(25786009)(5640700003)(2906002)(81166006)(81156014)(66066001)(6436002)(26005)(186003)(575784001)(6916009)(8676002)(54906003)(8936002)(3846002)(305945005)(486006)(7736002)(6116002)(2900100001)(446003)(11346002)(68736007)(53936002)(476003)(2501003)(99286004)(6486002)(50226002)(2616005)(316002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4402;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4oPZD0dOaRO5zRUN9f/xjxeX5P+uWjSsNJWy2NaApGbeso1iMsdCOSlGXhrQ4a7gF9ZLimrN5zbYNLR9TrKXFybWVA4IbUhlm64GfOZn4ZhIE70azckXvxPLgsKErFUXl+DJQ+y0UrCvdjNW0RXeaHpwqrHHOYLyK0B6i7PLOQtmdoYAgULz+QZA1e27PSaAFV8Fg2wQFalzOxcKJ8WzOXY+4WgdtH3xC07Nwla5at8sPIHTVPQ7SlrzoPgt64zc8IobgUGEeHd+tyeeRVkfc2bTmNtvPcbF86Jx/o/QVApuHvuv+Ff85ZQ1+NnGTux0yl7d7A77IxgcZpEWCZkfNzJ2w2q33VC6ox6B9woNw2A=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e151e7-8f42-4873-bf1a-08d64719a224
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2018 14:34:34.3298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4402
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx composite clk is designed for Peripheral Clock Control (PCC)
module observed in IMX ULP SoC series.

NOTE pcc can only be operated when clk is gated.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Anson Huang <Anson.Huang@nxp.com>
Cc: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v4->v5:
 * rename to clk-composite-7ulp.c as we have another
   clk-composite-8m.c, function name also changed accordingly
v3->v4:
 * no changes
v2->v3:
 * no changes
v1->v2:
 * remove an unneeded blank line change
 * use clk_hw_register
---
 drivers/clk/imx/Makefile             |  1 +
 drivers/clk/imx/clk-composite-7ulp.c | 85 ++++++++++++++++++++++++++++++++=
++++
 drivers/clk/imx/clk.h                |  6 +++
 3 files changed, 92 insertions(+)
 create mode 100644 drivers/clk/imx/clk-composite-7ulp.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index e5b0d42..c44d3d4 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -4,6 +4,7 @@ obj-y +=3D \
 	clk.o \
 	clk-busy.o \
 	clk-cpu.o \
+	clk-composite-7ulp.o \
 	clk-fixup-div.o \
 	clk-fixup-mux.o \
 	clk-gate-exclusive.o \
diff --git a/drivers/clk/imx/clk-composite-7ulp.c b/drivers/clk/imx/clk-com=
posite-7ulp.c
new file mode 100644
index 0000000..22f679c
--- /dev/null
+++ b/drivers/clk/imx/clk-composite-7ulp.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+
+#define PCG_PCS_SHIFT	24
+#define PCG_PCS_MASK	0x7
+#define PCG_CGC_SHIFT	30
+#define PCG_FRAC_SHIFT	3
+#define PCG_FRAC_WIDTH	1
+#define PCG_FRAC_MASK	BIT(3)
+#define PCG_PCD_SHIFT	0
+#define PCG_PCD_WIDTH	3
+#define PCG_PCD_MASK	0x7
+
+struct clk_hw *imx7ulp_clk_composite(const char *name,
+				     const char * const *parent_names,
+				     int num_parents, bool mux_present,
+				     bool rate_present, bool gate_present,
+				     void __iomem *reg)
+{
+	struct clk_hw *mux_hw =3D NULL, *fd_hw =3D NULL, *gate_hw =3D NULL;
+	struct clk_fractional_divider *fd =3D NULL;
+	struct clk_gate *gate =3D NULL;
+	struct clk_mux *mux =3D NULL;
+	struct clk_hw *hw;
+
+	if (mux_present) {
+		mux =3D kzalloc(sizeof(*mux), GFP_KERNEL);
+		if (!mux)
+			return ERR_PTR(-ENOMEM);
+		mux_hw =3D &mux->hw;
+		mux->reg =3D reg;
+		mux->shift =3D PCG_PCS_SHIFT;
+		mux->mask =3D PCG_PCS_MASK;
+	}
+
+	if (rate_present) {
+		fd =3D kzalloc(sizeof(*fd), GFP_KERNEL);
+		if (!fd) {
+			kfree(mux);
+			return ERR_PTR(-ENOMEM);
+		}
+		fd_hw =3D &fd->hw;
+		fd->reg =3D reg;
+		fd->mshift =3D PCG_FRAC_SHIFT;
+		fd->mwidth =3D PCG_FRAC_WIDTH;
+		fd->mmask  =3D PCG_FRAC_MASK;
+		fd->nshift =3D PCG_PCD_SHIFT;
+		fd->nwidth =3D PCG_PCD_WIDTH;
+		fd->nmask =3D PCG_PCD_MASK;
+		fd->flags =3D CLK_FRAC_DIVIDER_ZERO_BASED;
+	}
+
+	if (gate_present) {
+		gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);
+		if (!gate) {
+			kfree(mux);
+			kfree(fd);
+			return ERR_PTR(-ENOMEM);
+		}
+		gate_hw =3D &gate->hw;
+		gate->reg =3D reg;
+		gate->bit_idx =3D PCG_CGC_SHIFT;
+	}
+
+	hw =3D clk_hw_register_composite(NULL, name, parent_names, num_parents,
+				       mux_hw, &clk_mux_ops, fd_hw,
+				       &clk_fractional_divider_ops, gate_hw,
+				       &clk_gate_ops, CLK_SET_RATE_GATE |
+				       CLK_SET_PARENT_GATE);
+	if (IS_ERR(hw)) {
+		kfree(mux);
+		kfree(fd);
+		kfree(gate);
+	}
+
+	return hw;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index a5a9374..55a6434 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -71,6 +71,12 @@ struct clk *imx_clk_busy_mux(const char *name, void __io=
mem *reg, u8 shift,
 			     u8 width, void __iomem *busy_reg, u8 busy_shift,
 			     const char **parent_names, int num_parents);
=20
+struct clk_hw *imx7ulp_clk_composite(const char *name,
+				     const char * const *parent_names,
+				     int num_parents, bool mux_present,
+				     bool rate_present, bool gate_present,
+				     void __iomem *reg);
+
 struct clk *imx_clk_fixup_divider(const char *name, const char *parent,
 				  void __iomem *reg, u8 shift, u8 width,
 				  void (*fixup)(u32 *val));
--=20
2.7.4

