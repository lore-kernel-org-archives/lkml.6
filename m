Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C356C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B4122360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IxNOWJI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B4122360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387429AbeKNXFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 18:05:06 -0500
Received: from mail-eopbgr130053.outbound.protection.outlook.com ([40.107.13.53]:9872
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732983AbeKNXFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 18:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlIMwBuz0NsrB+hzn2lNKULvHD6kv9FZwaTDcvsNiCA=;
 b=IxNOWJI1nqTyHK6Wzt7OIp67csPYuPPnyB8yic99Pr9lbR46B4Tb5Ejlvsn9sUtvI7kakioUXnrR4W7gLnNRVC5/iFw9p5cV42GLoX0pCkeH0mZQcZpTATu0my9hbWV84ChGSCO4tc6heStmk3FY81SASjc3SCStM52pL4sFX0E=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4291.eurprd04.prod.outlook.com (52.134.126.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.28; Wed, 14 Nov 2018 13:01:51 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10%2]) with mapi id 15.20.1294.045; Wed, 14 Nov 2018
 13:01:51 +0000
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
Subject: [PATCH V6 5/9] clk: imx: add imx7ulp composite clk support
Thread-Topic: [PATCH V6 5/9] clk: imx: add imx7ulp composite clk support
Thread-Index: AQHUfBo1nyKTASGGx0KPvEzP7IOh6g==
Date:   Wed, 14 Nov 2018 13:01:51 +0000
Message-ID: <1542200198-3017-6-git-send-email-aisheng.dong@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4291;6:4ZFYnutNFCZ83gcHGBEoFmQVGC61izUsiZDNEhi4OeQgE6R0CyQbSvc6Cc33p5GgsWdmn6XxV7jp4n+ONRoyfUNf+ASVYNVGZ59KotejBUhlWU8bFgUU/Jcd5xlmkvU8t6Ew5LftczGCvzBWaXlXfjdB/4JF5InrCHo+zAvvUJrxv47KGpBL6rzPLdEnlIGPwONjL2ZW6+1ifuRU40wZdTEL9eqbgdrA9HxsOUF/2+Zxb9cNWy1Cke44ahyiWRkmsx2albeAPZML/HVJGz0ytZqYMk+LqIAfF/Iq0H7w0Ih4Xz+cEhwRy/F6WN7/gth3jf+SInaQ7Pf2zCl3cPhtX5YMsd6hVGMbfE9FoB+jVurIkZBrEb4YJWRBIOxq8WARb3f9iIeNPCtfCubBbNjrWzkR5UnuQp8FFvG3YvGR8hnzxIKZYh21OCowPi3IKIaym/e0qV8xxlsu56x65/LQgw==;5:clruvBoarmXjsqs0ZE4BhwPrs0SoSoNoyEEyt2lQ2EFCpFxsfbrlew0GKKgUWd7AXjE0E4WZLCZiDIou4bMpc2cO8N4PxGh/SJljCsfP2HQSb7wRWKHu3bIwvEj2DgkGi1n184UEVvAGwQ2MoDNMAK3+kXzLXrc2xGzmKMcti3g=;7:9IC3kQ16tbkq4+MRWRZJzEFjPMkm7PeCYyBzZBTP2BJ8UDJ2SmVE90Xb3lLYo6hZAqmDb5r4xhRdaxlIUNpPt2MJcZS+HL6n6CaltKAUxHwAbB4svfXu+9sPU8qswuskxpHwdt9ddMjpzXg54QYFGg==
x-ms-office365-filtering-correlation-id: 081ae0dc-7073-4225-e539-08d64a315844
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4291;
x-ms-traffictypediagnostic: AM0PR04MB4291:
x-microsoft-antispam-prvs: <AM0PR04MB4291A18FD2967969B205099180C30@AM0PR04MB4291.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231410)(944501410)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4291;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4291;
x-forefront-prvs: 085634EFF4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(346002)(39860400002)(199004)(189003)(54534003)(476003)(2616005)(11346002)(2906002)(53936002)(486006)(446003)(386003)(52116002)(5640700003)(6512007)(6436002)(2351001)(6486002)(105586002)(305945005)(7736002)(316002)(6506007)(54906003)(106356001)(6116002)(102836004)(99286004)(76176011)(3846002)(81156014)(26005)(5660300001)(186003)(25786009)(86362001)(575784001)(8936002)(97736004)(478600001)(2501003)(66066001)(256004)(71200400001)(71190400001)(81166006)(8676002)(14454004)(6916009)(4326008)(2900100001)(50226002)(36756003)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4291;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: BNhYF3Dm7H/11JQHcIvdBa9GF+GIlHhiyDjE/A//bIRNrMuFjqyDn6mIvGF0/IrhZ8O8KSTZpHMJoTq7A0TO60shyCAyuNsEGwTpQQrWOcH1Ib5DX+cI6Fq8lBZuFTAoPGBG8dCQIK+hrYw+/WKBeEhbmDXtyAjhZvJXDQihTcpkvpT+m74MfuQB9oGK1CTtu9ESZj4JX1jlQnRsH4bbjPAVAyXsZwcBJSwQvLj/AL98AxE8CSy9k/LjsamyBxuY7Q8U+aedbDTaxU9820MQ76ZvG2nDMCb2w1zSxM+181BUb+5wOMi7jKSeWBcAuGCgGb7JVPi3Awb/DgEu4X7U7wjEeDA3DhcxfZbU0yhKGtE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 081ae0dc-7073-4225-e539-08d64a315844
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2018 13:01:51.7239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4291
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
index e7248de..a5cab3e 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -4,6 +4,7 @@ obj-y +=3D \
 	clk.o \
 	clk-busy.o \
 	clk-cpu.o \
+	clk-composite-7ulp.o \
 	clk-divider-gate.o \
 	clk-fixup-div.o \
 	clk-fixup-mux.o \
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
index ebeb754..2e3bcfa 100644
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

