Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F18C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396C620817
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 14:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SAiII26N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 396C620817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeKKAUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 19:20:09 -0500
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:35840
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726283AbeKKAUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 19:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdV2E0J/t3fH3As2uXgWKb0IhaOyvn7lmXH6GMr36PM=;
 b=SAiII26NdccQOCVC5pTi4iFaeZQbIFKFbPcrf0Y5PIlUNZhc2o/g1xtYhw9vUmtqLR0gRoZxIlhu1gABYr8UVIaYz0vkFWCxRIdBTwgUGHbqah2rXtAIaMn0g24Q0XIX7zU12RqVjAZ0Er+256Zde63dgfy4R5CrzuIQTmtQ+bo=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.126.21) by
 AM0PR04MB4402.eurprd04.prod.outlook.com (52.135.148.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.30; Sat, 10 Nov 2018 14:34:51 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::797a:f972:9281:6d10%2]) with mapi id 15.20.1294.039; Sat, 10 Nov 2018
 14:34:51 +0000
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
Subject: [PATCH V5 9/9] clk: imx: add imx7ulp clk driver
Thread-Topic: [PATCH V5 9/9] clk: imx: add imx7ulp clk driver
Thread-Index: AQHUeQKJ1AOVT/482EKBh/QYB6RIog==
Date:   Sat, 10 Nov 2018 14:34:50 +0000
Message-ID: <1541860165-401-10-git-send-email-aisheng.dong@nxp.com>
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
x-microsoft-exchange-diagnostics: 1;AM0PR04MB4402;6:vDYlYcXv55SiUXFUkohKo6D6wcTESs8SXg86GjSvKRFcttFWbE7NW06jITfOc2edFvOi4w9Gjoi26eO7Xl2+N66hUwuoM5P58qlmVghJafFNnkMRQSXJzZhVLjuXDXifbkKLBJJdPP8xELsg4VFge1CBykc8vXYmEF+4tSuHjfMSM663VXHRWbycoz5kvzwMmYOQx95Ipw/BUYzlM8wr60UpeTRMt9WkwY9b1vJjh9YsKSgzIFvfWUif9v99MX68Hen8vZdiapIsljz2FpwyYJ/MSOYXrO43oUMAmVMPHYOs8JfGHqMfQKIuREtUrCXO98sNvkO8T2/R/7jmj+qFJzTMxQkQiV6dA/+u3RChaGrlGDUPotC2fl6qnTQi8c9HTQEeLbuTDU5mZ/OiSn3XsU0xcqiSIU4qoLfuEFEYgd3HPJfL2Q/rs9a7aECU6pMLsmF2eLAAo2tC47E1EugASg==;5:gpRPQJnaUY3M0p4d6JgPmoyUn0BdHRr1UqStlBw8RJXC0AgYLAWf7Js8GCa8tid5xXsPiwR32EE4RfHrlxgqa8DHdBqVUDxDivv3uoG4YmioMjiBBqsXfw97cYK7RUkOFC8bAQk7/7Sv/C/IWDnyfntR1wygDcDm5kzSzZv4aII=;7:zup/HcySDnrt0j/GvfwfDVerG0BiUKstGBaHkAkIuZ8VPsGGoiiVpDW5cUR/uG4sCx5yONINAm158sxwvWQm2OcNizTKhx4LuKntRHIKf39pTanyPgveWN2nWoOAmvEccZCUkkKvPTR8aOGNx+em/w==
x-ms-office365-filtering-correlation-id: 17437e2c-cb46-470f-e971-08d64719ac11
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390040)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4402;
x-ms-traffictypediagnostic: AM0PR04MB4402:
x-microsoft-antispam-prvs: <AM0PR04MB440248913A18074B6CF5DEB780C70@AM0PR04MB4402.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(269456686620040)(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231382)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB4402;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4402;
x-forefront-prvs: 0852EB6797
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(346002)(376002)(136003)(199004)(189003)(54534003)(6512007)(478600001)(102836004)(36756003)(14444005)(4326008)(105586002)(256004)(76176011)(97736004)(71200400001)(71190400001)(106356001)(14454004)(386003)(6506007)(52116002)(2351001)(4744004)(5660300001)(25786009)(5640700003)(2906002)(81166006)(81156014)(66066001)(6436002)(26005)(186003)(6916009)(8676002)(54906003)(8936002)(3846002)(305945005)(53946003)(486006)(7736002)(6116002)(2900100001)(446003)(11346002)(68736007)(53936002)(476003)(2501003)(99286004)(6486002)(50226002)(2616005)(316002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4402;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: um0emKf1YTa5TcaBBJVJCSC7PStOiaRH4tYig091nyk+ojUZlrDOEMMVfX0n6cVmfY0B1CxOIY7xYXAOYpsIGV0E6aC8E0CPqtgM6a6Ry19Uf7H+6wcDOfVkpmAPmkRrCBJBDgBPrL6Yol0DV0+kuG3SVq5CBAIAz4o7wsT0//m5NAP2VFI0va34nLXEp8yWhDGZ2txP5kJ+RLhr/UPUcsXF4FAxUk1+k1a+bf16C/+RbyQfBt76pkXm/ykDP3DMT9Jct/Ypxb+pGj/iNy4PZHdclYv9iv/nFS26ff0QyoOFa2hNo5eLr8tjKTSEpDtfCXhNGMkvCMKEC1BrH9xDld2Gyx9eFSDTB+iAo1ooABs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17437e2c-cb46-470f-e971-08d64719ac11
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2018 14:34:50.9765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4402
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX7ULP Clock functions are under joint control of the System
Clock Generation (SCG) modules, Peripheral Clock Control (PCC)
modules, and Core Mode Controller (CMC)1 blocks

The clocking scheme provides clear separation between M4 domain
and A7 domain. Except for a few clock sources shared between two
domains, such as the System Oscillator clock, the Slow IRC (SIRC),
and and the Fast IRC clock (FIRCLK), clock sources and clock
management are separated and contained within each domain.

M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.

This driver only adds clock support in A7 domain.

Note that most clocks required to be operated when gated, e.g. pll,
pfd, pcc. And more special cases that scs/ddr/nic mux selecting
different clock source requires that clock to be enabled first,
then we need set CLK_OPS_PARENT_ENABLE flag for them properly.

Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Anson Huang <Anson.Huang@nxp.com>
Cc: Bai Ping <ping.bai@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
v4->v5:
 * clk-composite API name changed accordingly
v3->v4:
 * update after changing scg and pcc into separete nodes according to
   Rob's suggestion
v2->v3:
 * no changes
v1->v2:
 * use of_clk_add_hw_provider instead
 * split the clocks register process into two parts: early part for possibl=
e
   timers clocks registered by CLK_OF_DECLARE_DRIVER and the later part for
   the left normal peripheral clocks registered by a platform driver.
---
 drivers/clk/imx/Makefile      |   1 +
 drivers/clk/imx/clk-imx7ulp.c | 209 ++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 210 insertions(+)
 create mode 100644 drivers/clk/imx/clk-imx7ulp.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index c44d3d4..98ec8ed 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -29,4 +29,5 @@ obj-$(CONFIG_SOC_IMX6SLL) +=3D clk-imx6sll.o
 obj-$(CONFIG_SOC_IMX6SX) +=3D clk-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) +=3D clk-imx6ul.o
 obj-$(CONFIG_SOC_IMX7D)  +=3D clk-imx7d.o
+obj-$(CONFIG_SOC_IMX7ULP) +=3D clk-imx7ulp.o
 obj-$(CONFIG_SOC_VF610)  +=3D clk-vf610.o
diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
new file mode 100644
index 0000000..6d2e3ef
--- /dev/null
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2016 Freescale Semiconductor, Inc.
+ * Copyright 2017~2018 NXP
+ *
+ * Author: Dong Aisheng <aisheng.dong@nxp.com>
+ *
+ */
+
+#include <dt-bindings/clock/imx7ulp-clock.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "clk.h"
+
+static const char * const pll_pre_sels[]	=3D { "sosc", "firc", };
+static const char * const spll_pfd_sels[]	=3D { "spll_pfd0", "spll_pfd1", =
"spll_pfd2", "spll_pfd3", };
+static const char * const spll_sels[]		=3D { "spll", "spll_pfd_sel", };
+static const char * const apll_pfd_sels[]	=3D { "apll_pfd0", "apll_pfd1", =
"apll_pfd2", "apll_pfd3", };
+static const char * const apll_sels[]		=3D { "apll", "apll_pfd_sel", };
+static const char * const scs_sels[]		=3D { "dummy", "sosc", "sirc", "firc=
", "dummy", "apll_sel", "spll_sel", "upll", };
+static const char * const ddr_sels[]		=3D { "apll_pfd_sel", "upll", };
+static const char * const nic_sels[]		=3D { "firc", "ddr_clk", };
+static const char * const periph_plat_sels[]	=3D { "dummy", "nic1_bus_clk"=
, "nic1_clk", "ddr_clk", "apll_pfd2", "apll_pfd1", "apll_pfd0", "upll", };
+static const char * const periph_bus_sels[]	=3D { "dummy", "sosc_bus_clk",=
 "mpll", "firc_bus_clk", "rosc", "nic1_bus_clk", "nic1_clk", "spll_bus_clk"=
, };
+
+static void __init imx7ulp_clk_scg1_init(struct device_node *np)
+{
+	struct clk_hw_onecell_data *clk_data;
+	struct clk_hw **clks;
+	void __iomem *base;
+
+	clk_data =3D kzalloc(sizeof(*clk_data) + sizeof(*clk_data->hws) *
+			   IMX7ULP_CLK_SCG1_END, GFP_KERNEL);
+	if (!clk_data)
+		return;
+
+	clk_data->num =3D IMX7ULP_CLK_SCG1_END;
+	clks =3D clk_data->hws;
+
+	clks[IMX7ULP_CLK_DUMMY]		=3D imx_clk_hw_fixed("dummy", 0);
+
+	clks[IMX7ULP_CLK_ROSC]		=3D imx_obtain_fixed_clk_hw(np, "rosc");
+	clks[IMX7ULP_CLK_SOSC]		=3D imx_obtain_fixed_clk_hw(np, "sosc");
+	clks[IMX7ULP_CLK_SIRC]		=3D imx_obtain_fixed_clk_hw(np, "sirc");
+	clks[IMX7ULP_CLK_FIRC]		=3D imx_obtain_fixed_clk_hw(np, "firc");
+	clks[IMX7ULP_CLK_MIPI_PLL]	=3D imx_obtain_fixed_clk_hw(np, "mpll");
+	clks[IMX7ULP_CLK_UPLL]		=3D imx_obtain_fixed_clk_hw(np, "upll");
+
+	/* SCG1 */
+	base =3D of_iomap(np, 0);
+	WARN_ON(!base);
+
+	/* NOTE: xPLL config can't be changed when xPLL is enabled */
+	clks[IMX7ULP_CLK_APLL_PRE_SEL]	=3D imx_clk_hw_mux_flags("apll_pre_sel", b=
ase + 0x508, 0, 1, pll_pre_sels, ARRAY_SIZE(pll_pre_sels), CLK_SET_PARENT_G=
ATE);
+	clks[IMX7ULP_CLK_SPLL_PRE_SEL]	=3D imx_clk_hw_mux_flags("spll_pre_sel", b=
ase + 0x608, 0, 1, pll_pre_sels, ARRAY_SIZE(pll_pre_sels), CLK_SET_PARENT_G=
ATE);
+
+	/*							   name		    parent_name	   reg			shift	width	flags */
+	clks[IMX7ULP_CLK_APLL_PRE_DIV]	=3D imx_clk_hw_divider_flags("apll_pre_div=
", "apll_pre_sel", base + 0x508,	8,	3,	CLK_SET_RATE_GATE);
+	clks[IMX7ULP_CLK_SPLL_PRE_DIV]	=3D imx_clk_hw_divider_flags("spll_pre_div=
", "spll_pre_sel", base + 0x608,	8,	3,	CLK_SET_RATE_GATE);
+
+	/*						name	 parent_name	 base */
+	clks[IMX7ULP_CLK_APLL]		=3D imx_clk_pllv4("apll",  "apll_pre_div", base +=
 0x500);
+	clks[IMX7ULP_CLK_SPLL]		=3D imx_clk_pllv4("spll",  "spll_pre_div", base +=
 0x600);
+
+	/* APLL PFDs */
+	clks[IMX7ULP_CLK_APLL_PFD0]	=3D imx_clk_pfdv2("apll_pfd0", "apll", base +=
 0x50c, 0);
+	clks[IMX7ULP_CLK_APLL_PFD1]	=3D imx_clk_pfdv2("apll_pfd1", "apll", base +=
 0x50c, 1);
+	clks[IMX7ULP_CLK_APLL_PFD2]	=3D imx_clk_pfdv2("apll_pfd2", "apll", base +=
 0x50c, 2);
+	clks[IMX7ULP_CLK_APLL_PFD3]	=3D imx_clk_pfdv2("apll_pfd3", "apll", base +=
 0x50c, 3);
+
+	/* SPLL PFDs */
+	clks[IMX7ULP_CLK_SPLL_PFD0]	=3D imx_clk_pfdv2("spll_pfd0", "spll", base +=
 0x60C, 0);
+	clks[IMX7ULP_CLK_SPLL_PFD1]	=3D imx_clk_pfdv2("spll_pfd1", "spll", base +=
 0x60C, 1);
+	clks[IMX7ULP_CLK_SPLL_PFD2]	=3D imx_clk_pfdv2("spll_pfd2", "spll", base +=
 0x60C, 2);
+	clks[IMX7ULP_CLK_SPLL_PFD3]	=3D imx_clk_pfdv2("spll_pfd3", "spll", base +=
 0x60C, 3);
+
+	/* PLL Mux */
+	clks[IMX7ULP_CLK_APLL_PFD_SEL]	=3D imx_clk_hw_mux_flags("apll_pfd_sel", b=
ase + 0x508, 14, 2, apll_pfd_sels, ARRAY_SIZE(apll_pfd_sels), CLK_SET_RATE_=
PARENT | CLK_SET_PARENT_GATE);
+	clks[IMX7ULP_CLK_SPLL_PFD_SEL]	=3D imx_clk_hw_mux_flags("spll_pfd_sel", b=
ase + 0x608, 14, 2, spll_pfd_sels, ARRAY_SIZE(spll_pfd_sels), CLK_SET_RATE_=
PARENT | CLK_SET_PARENT_GATE);
+	clks[IMX7ULP_CLK_APLL_SEL]	=3D imx_clk_hw_mux_flags("apll_sel", base + 0x=
508, 1, 1, apll_sels, ARRAY_SIZE(apll_sels), CLK_SET_RATE_PARENT | CLK_SET_=
PARENT_GATE);
+	clks[IMX7ULP_CLK_SPLL_SEL]	=3D imx_clk_hw_mux_flags("spll_sel", base + 0x=
608, 1, 1, spll_sels, ARRAY_SIZE(spll_sels), CLK_SET_RATE_PARENT | CLK_SET_=
PARENT_GATE);
+
+	clks[IMX7ULP_CLK_SPLL_BUS_CLK]	=3D clk_hw_register_divider(NULL, "spll_bu=
s_clk", "spll_sel", CLK_SET_RATE_GATE, base + 0x604, 8, 3, CLK_DIVIDER_ONE_=
BASED | CLK_DIVIDER_ZERO_GATE, &imx_ccm_lock);
+
+	/* scs/ddr/nic select different clock source requires that clock to be en=
abled first */
+	clks[IMX7ULP_CLK_SYS_SEL]	=3D imx_clk_hw_mux2("scs_sel", base + 0x14, 24,=
 4, scs_sels, ARRAY_SIZE(scs_sels));
+	clks[IMX7ULP_CLK_NIC_SEL]	=3D imx_clk_hw_mux2("nic_sel", base + 0x40, 28,=
 1, nic_sels, ARRAY_SIZE(nic_sels));
+	clks[IMX7ULP_CLK_DDR_SEL]	=3D imx_clk_hw_mux_flags("ddr_sel", base + 0x30=
, 24, 1, ddr_sels, ARRAY_SIZE(ddr_sels), CLK_SET_RATE_PARENT | CLK_OPS_PARE=
NT_ENABLE);
+
+	clks[IMX7ULP_CLK_CORE_DIV]	=3D imx_clk_hw_divider_flags("divcore",	"scs_s=
el",  base + 0x14, 16, 4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+
+	clks[IMX7ULP_CLK_DDR_DIV]	=3D clk_hw_register_divider(NULL, "ddr_clk", "d=
dr_sel", CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, base + 0x30, 0, 3,
+								  CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ZERO_GATE, &imx_ccm_lock);
+
+	clks[IMX7ULP_CLK_NIC0_DIV]	=3D imx_clk_hw_divider_flags("nic0_clk",		"nic=
_sel",  base + 0x40, 24, 4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+	clks[IMX7ULP_CLK_NIC1_DIV]	=3D imx_clk_hw_divider_flags("nic1_clk",		"nic=
0_clk", base + 0x40, 16, 4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+	clks[IMX7ULP_CLK_NIC1_BUS_DIV]	=3D imx_clk_hw_divider_flags("nic1_bus_clk=
",	"nic1_clk", base + 0x40, 4,  4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
+
+	clks[IMX7ULP_CLK_GPU_DIV]	=3D imx_clk_hw_divider("gpu_clk", "nic0_clk", b=
ase + 0x40, 20, 4);
+
+	clks[IMX7ULP_CLK_SOSC_BUS_CLK]	=3D clk_hw_register_divider(NULL, "sosc_bu=
s_clk", "sosc", 0, base + 0x104, 8, 3,
+								  CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ZERO=
_GATE, &imx_ccm_lock);
+	clks[IMX7ULP_CLK_FIRC_BUS_CLK]	=3D clk_hw_register_divider(NULL, "firc_bu=
s_clk", "firc", 0, base + 0x304, 8, 3,
+								  CLK_DIVIDER_READ_ONLY | CLK_DIVIDER_ONE_BASED | CLK_DIVIDER_ZERO=
_GATE, &imx_ccm_lock);
+
+	imx_check_clk_hws(clks, clk_data->num);
+
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
+}
+CLK_OF_DECLARE(imx7ulp_clk_scg1, "fsl,imx7ulp-scg1", imx7ulp_clk_scg1_init=
);
+
+static void __init imx7ulp_clk_pcc2_init(struct device_node *np)
+{
+	struct clk_hw_onecell_data *clk_data;
+	struct clk_hw **clks;
+	void __iomem *base;
+
+	clk_data =3D kzalloc(sizeof(*clk_data) + sizeof(*clk_data->hws) *
+			   IMX7ULP_CLK_PCC2_END, GFP_KERNEL);
+	if (!clk_data)
+		return;
+
+	clk_data->num =3D IMX7ULP_CLK_PCC2_END;
+	clks =3D clk_data->hws;
+
+	/* PCC2 */
+	base =3D of_iomap(np, 0);
+	WARN_ON(!base);
+
+	clks[IMX7ULP_CLK_DMA1]		=3D imx_clk_hw_gate("dma1", "nic1_clk", base + 0x=
20, 30);
+	clks[IMX7ULP_CLK_RGPIO2P1]	=3D imx_clk_hw_gate("rgpio2p1", "nic1_bus_clk"=
, base + 0x3c, 30);
+	clks[IMX7ULP_CLK_DMA_MUX1]	=3D imx_clk_hw_gate("dma_mux1", "nic1_bus_clk"=
, base + 0x84, 30);
+	clks[IMX7ULP_CLK_SNVS]		=3D imx_clk_hw_gate("snvs", "nic1_bus_clk", base =
+ 0x8c, 30);
+	clks[IMX7ULP_CLK_CAAM]		=3D imx_clk_hw_gate("caam", "nic1_clk", base + 0x=
90, 30);
+	clks[IMX7ULP_CLK_LPTPM4]	=3D imx7ulp_clk_composite("lptpm4",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x94);
+	clks[IMX7ULP_CLK_LPTPM5]	=3D imx7ulp_clk_composite("lptpm5",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x98);
+	clks[IMX7ULP_CLK_LPIT1]		=3D imx7ulp_clk_composite("lpit1",   periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x9c);
+	clks[IMX7ULP_CLK_LPSPI2]	=3D imx7ulp_clk_composite("lpspi2",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xa4);
+	clks[IMX7ULP_CLK_LPSPI3]	=3D imx7ulp_clk_composite("lpspi3",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xa8);
+	clks[IMX7ULP_CLK_LPI2C4]	=3D imx7ulp_clk_composite("lpi2c4",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xac);
+	clks[IMX7ULP_CLK_LPI2C5]	=3D imx7ulp_clk_composite("lpi2c5",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb0);
+	clks[IMX7ULP_CLK_LPUART4]	=3D imx7ulp_clk_composite("lpuart4", periph_bus=
_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb4);
+	clks[IMX7ULP_CLK_LPUART5]	=3D imx7ulp_clk_composite("lpuart5", periph_bus=
_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb8);
+	clks[IMX7ULP_CLK_FLEXIO1]	=3D imx7ulp_clk_composite("flexio1", periph_bus=
_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xc4);
+	clks[IMX7ULP_CLK_USB0]		=3D imx7ulp_clk_composite("usb0",    periph_plat_=
sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xcc);
+	clks[IMX7ULP_CLK_USB1]		=3D imx7ulp_clk_composite("usb1",    periph_plat_=
sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xd0);
+	clks[IMX7ULP_CLK_USB_PHY]	=3D imx_clk_hw_gate("usb_phy", "nic1_bus_clk", =
base + 0xd4, 30);
+	clks[IMX7ULP_CLK_USDHC0]	=3D imx7ulp_clk_composite("usdhc0",  periph_plat=
_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xdc);
+	clks[IMX7ULP_CLK_USDHC1]	=3D imx7ulp_clk_composite("usdhc1",  periph_plat=
_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xe0);
+	clks[IMX7ULP_CLK_WDG1]		=3D imx7ulp_clk_composite("wdg1",    periph_bus_s=
els, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0xf4);
+	clks[IMX7ULP_CLK_WDG2]		=3D imx7ulp_clk_composite("sdg2",    periph_bus_s=
els, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0x10c);
+
+	imx_check_clk_hws(clks, clk_data->num);
+
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
+}
+CLK_OF_DECLARE(imx7ulp_clk_pcc2, "fsl,imx7ulp-pcc2", imx7ulp_clk_pcc2_init=
);
+
+static void __init imx7ulp_clk_pcc3_init(struct device_node *np)
+{
+	struct clk_hw_onecell_data *clk_data;
+	struct clk_hw **clks;
+	void __iomem *base;
+
+	clk_data =3D kzalloc(sizeof(*clk_data) + sizeof(*clk_data->hws) *
+			   IMX7ULP_CLK_PCC3_END, GFP_KERNEL);
+	if (!clk_data)
+		return;
+
+	clk_data->num =3D IMX7ULP_CLK_PCC3_END;
+	clks =3D clk_data->hws;
+
+	/* PCC3 */
+	base =3D of_iomap(np, 0);
+	WARN_ON(!base);
+
+	clks[IMX7ULP_CLK_LPTPM6]	=3D imx7ulp_clk_composite("lptpm6",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x84);
+	clks[IMX7ULP_CLK_LPTPM7]	=3D imx7ulp_clk_composite("lptpm7",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x88);
+
+	clks[IMX7ULP_CLK_MMDC]		=3D clk_hw_register_gate(NULL, "mmdc", "nic1_clk"=
, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
+							       base + 0xac, 30, 0, &imx_ccm_lock);
+	clks[IMX7ULP_CLK_LPI2C6]	=3D imx7ulp_clk_composite("lpi2c6",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x90);
+	clks[IMX7ULP_CLK_LPI2C7]	=3D imx7ulp_clk_composite("lpi2c7",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x94);
+	clks[IMX7ULP_CLK_LPUART6]	=3D imx7ulp_clk_composite("lpuart6", periph_bus=
_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x98);
+	clks[IMX7ULP_CLK_LPUART7]	=3D imx7ulp_clk_composite("lpuart7", periph_bus=
_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x9c);
+	clks[IMX7ULP_CLK_DSI]		=3D imx7ulp_clk_composite("dsi",     periph_bus_se=
ls, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0xa4);
+	clks[IMX7ULP_CLK_LCDIF]		=3D imx7ulp_clk_composite("lcdif",   periph_plat=
_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xa8);
+
+	clks[IMX7ULP_CLK_VIU]		=3D imx_clk_hw_gate("viu",   "nic1_clk",	   base +=
 0xa0, 30);
+	clks[IMX7ULP_CLK_PCTLC]		=3D imx_clk_hw_gate("pctlc", "nic1_bus_clk", bas=
e + 0xb8, 30);
+	clks[IMX7ULP_CLK_PCTLD]		=3D imx_clk_hw_gate("pctld", "nic1_bus_clk", bas=
e + 0xbc, 30);
+	clks[IMX7ULP_CLK_PCTLE]		=3D imx_clk_hw_gate("pctle", "nic1_bus_clk", bas=
e + 0xc0, 30);
+	clks[IMX7ULP_CLK_PCTLF]		=3D imx_clk_hw_gate("pctlf", "nic1_bus_clk", bas=
e + 0xc4, 30);
+
+	clks[IMX7ULP_CLK_GPU3D]		=3D imx7ulp_clk_composite("gpu3d",   periph_plat=
_sels, ARRAY_SIZE(periph_plat_sels), true, false, true, base + 0x140);
+	clks[IMX7ULP_CLK_GPU2D]		=3D imx7ulp_clk_composite("gpu2d",   periph_plat=
_sels, ARRAY_SIZE(periph_plat_sels), true, false, true, base + 0x144);
+
+	imx_check_clk_hws(clks, clk_data->num);
+
+	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
+}
+CLK_OF_DECLARE(imx7ulp_clk_pcc3, "fsl,imx7ulp-pcc3", imx7ulp_clk_pcc3_init=
);
--=20
2.7.4

