Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D541FECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 13:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836B120878
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 13:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bjJpBX76"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836B120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeJUVZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 17:25:36 -0400
Received: from mail-he1eur01on0045.outbound.protection.outlook.com ([104.47.0.45]:64912
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727308AbeJUVZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 17:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqMNlDTTHeHcqp7CH+JDxai7NGjqxNrT0a4grwXdlpc=;
 b=bjJpBX76/BPpVSRMWNAcTEyuyYfy1wz/tcvvMPRb7vYoR5A6SMq423wIfOoQGB+bgic5oFfJzZYVrpG6JRy3zIvzYhnlUW3d0+XFB90aYoF6pKb5gvd88B9/qlHqjDPGwg0LLfeZIMUzEVf/cQg1f1qzrAXj067S0EX3O1gt9H4=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4580.eurprd04.prod.outlook.com (52.135.149.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Sun, 21 Oct 2018 13:11:04 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10%2]) with mapi id 15.20.1250.028; Sun, 21 Oct 2018
 13:11:04 +0000
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
Subject: [PATCH RESEND V4 5/9] clk: imx: add composite clk support
Thread-Topic: [PATCH RESEND V4 5/9] clk: imx: add composite clk support
Thread-Index: AQHUaT+FxGL+5syanUWBrgxRcn9DVA==
Date:   Sun, 21 Oct 2018 13:11:04 +0000
Message-ID: <1540127173-21346-6-git-send-email-aisheng.dong@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4580;6:Qkm812Y9Dq/KqQ8cDfEpIlYLVsRuNuKw0BBPJGibbyZoAS4pgDrj+dWX5k9SSU1/EzLDQzJkQG2IdczoJ0/FvUxhjG2faRYzh8zslY3mfToE6GJtJZeinvxEvcpn/TTyNsoA/4fJynm4W3VRmD157apfjXLWe5bqsBoAhlW0lSh51vZDzKo7mpN0cyVas2VDjRP8FST7sCvQ9FOoGRNLykIA9mpT17iImpn1YuEsPxWHUwX21FjTw+pc+SYx/2SSUCq3bXHXG1v5UtFyqtzx9hF5GL8UHrnbrz5vK2Bw1f1muLaFkWageMQe8QaHy5OfRdj8RbxYss6Cw2YfazGRyrgNh2wjQAqKo0AR9xz+fgAi1vJGdVGMcqwbpIXl5wD931tND3yP/rCOKVR7SWg/2qvcIezvzV9YmZlQ7PCK5I6HiXHbEOF+OINSOYoxFqNG4Mpxp81gKo2NP665uYpzPg==;5:OsawYcg6kmpnbDCSVCu+TR9xqa7+O4cFamp3cvh0EVQaXoU5a2AT/CAYe8adS16j4XoRsfD8fZF+k7oBjKhrSVVSk4Pa7S0avIzJnZICXdWPciN3XNYhXejTg9EmPeIwiwRKDzLxFClRc5JqBl/Kr72MIsTbnTuxez+Po5H4qKA=;7:eApHXeb4CIfGW6Udyzs0/qxOQ8bBYnINGJI/RW9Ro0/l3XR2jciMcj7ZpKL+6uWD6LKvOp33jTGoNU95V3/xvDy9dOEhWdRrM0GmRxR+NixMepW6muTuBDmBvSXS/Pa15mBBRDTYpoJJWyE5a0gDyamBM3wS1Q1hATVTgl+v9SHeJ/0yWuF9ON62xLoSKOQhiCE8UiBo5eRhaSgiyUBiiwoSDwPaSGaTHhwKuYD0IXZW/JNZBgUIssoHU7KKc5ID
x-ms-office365-filtering-correlation-id: ef63096d-5627-476a-5331-08d63756a7ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4580;
x-ms-traffictypediagnostic: AM0PR04MB4580:
x-microsoft-antispam-prvs: <AM0PR04MB4580D27F0C270B1B57B1A34780FB0@AM0PR04MB4580.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4580;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4580;
x-forefront-prvs: 083289FD26
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39850400004)(136003)(54534003)(199004)(189003)(476003)(2616005)(11346002)(446003)(66066001)(54906003)(316002)(26005)(52116002)(99286004)(486006)(186003)(7736002)(386003)(6506007)(305945005)(102836004)(105586002)(76176011)(50226002)(86362001)(106356001)(575784001)(256004)(81156014)(81166006)(217873002)(8936002)(8676002)(6916009)(5250100002)(25786009)(2900100001)(2501003)(68736007)(71190400001)(2906002)(5660300001)(14454004)(3846002)(4326008)(6116002)(6512007)(53936002)(2351001)(6486002)(36756003)(71200400001)(478600001)(5640700003)(97736004)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4580;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XZQJG0usChUvmvcbFyaymau4zOnzVQHLkokl30+EqX2WdEEpYENS5EABaPnBihue08mF+eUNxRJT2HxhYU+jIXcLIsI8kOOXsrt1p+4HaPB0nvvgPt3Lo4Dqx5mJtk6j2+zNbYLSVogCA4VLxNtLar2n3cBPcL7XUxnLS8zgfLkmnWO1wNygfAH8K3fmR2QXWeyanAL2BpxSZWCymgQBCIKcpQCpnjq13t99P5dCXD/9kfjmd9kvylz5W4KHITftvwjlWZ38iAeVlJezkwB+I8cyPUurHrW22RTAmzxhbezXmZlfUG6wASXOgBbdL3Yinu1mA/zzvZ45c32uuiNXJyAv2L3CVWd44IdDO8o5QfY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef63096d-5627-476a-5331-08d63756a7ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2018 13:11:04.6626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4580
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx composite clk is designed for Peripheral Clock Control (PCC)
module observed in IMX ULP SoC series. e.g. i.MX7ULP.

NOTE pcc can only be operated when clk is gated.

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
 * remove an unneeded blank line change
 * use clk_hw_register
---
 drivers/clk/imx/Makefile        |  1 +
 drivers/clk/imx/clk-composite.c | 85 +++++++++++++++++++++++++++++++++++++=
++++
 drivers/clk/imx/clk.h           |  6 +++
 3 files changed, 92 insertions(+)
 create mode 100644 drivers/clk/imx/clk-composite.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index e5b0d42..f4da12c 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -4,6 +4,7 @@ obj-y +=3D \
 	clk.o \
 	clk-busy.o \
 	clk-cpu.o \
+	clk-composite.o \
 	clk-fixup-div.o \
 	clk-fixup-mux.o \
 	clk-gate-exclusive.o \
diff --git a/drivers/clk/imx/clk-composite.c b/drivers/clk/imx/clk-composit=
e.c
new file mode 100644
index 0000000..297974b
--- /dev/null
+++ b/drivers/clk/imx/clk-composite.c
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
+struct clk_hw *imx_clk_composite(const char *name,
+			      const char * const *parent_names,
+			      int num_parents, bool mux_present,
+			      bool rate_present, bool gate_present,
+			      void __iomem *reg)
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
index a5a9374..bc43f68 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -71,6 +71,12 @@ struct clk *imx_clk_busy_mux(const char *name, void __io=
mem *reg, u8 shift,
 			     u8 width, void __iomem *busy_reg, u8 busy_shift,
 			     const char **parent_names, int num_parents);
=20
+struct clk_hw *imx_clk_composite(const char *name,
+				 const char * const *parent_names,
+				 int num_parents, bool mux_present,
+				 bool rate_present, bool gate_present,
+				 void __iomem *reg);
+
 struct clk *imx_clk_fixup_divider(const char *name, const char *parent,
 				  void __iomem *reg, u8 shift, u8 width,
 				  void (*fixup)(u32 *val));
--=20
2.7.4

