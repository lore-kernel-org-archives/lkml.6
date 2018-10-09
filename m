Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8582AC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E252089D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 08:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C1scFAq/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07E252089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeJIPxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:53:37 -0400
Received: from mail-eopbgr00087.outbound.protection.outlook.com ([40.107.0.87]:11264
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725861AbeJIPxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COrB+aPy4CU8hRNBLNoSxHqR4v0ur72ui0fkc/GaoqI=;
 b=C1scFAq/ak6eS4sLWhaVLkh8hqez0XO7BxSApNZ360hj2wcOt9x2e6VjflAq2fGpCahLXOAcJ37DL5dGa0px7kkx8LyHVJHSRDLYi/UXtHvrFyjPunsrThHj4BP6WI6nehbP9PxPj8xMtmPNSvWi1iava/xWfScFe7EoX0xAotY=
Received: from VI1PR04MB1613.eurprd04.prod.outlook.com (10.164.84.147) by
 VI1PR04MB5343.eurprd04.prod.outlook.com (52.134.123.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Tue, 9 Oct 2018 08:37:32 +0000
Received: from VI1PR04MB1613.eurprd04.prod.outlook.com
 ([fe80::f014:635a:bee7:76b3]) by VI1PR04MB1613.eurprd04.prod.outlook.com
 ([fe80::f014:635a:bee7:76b3%3]) with mapi id 15.20.1207.024; Tue, 9 Oct 2018
 08:37:32 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        "A.s. Dong" <aisheng.dong@nxp.com>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v10 5/5] clk: imx: add clock driver for i.MX8MQ CCM
Thread-Topic: [PATCH v10 5/5] clk: imx: add clock driver for i.MX8MQ CCM
Thread-Index: AQHUX6tRVDvaCs557EK9hSP4xQS0rA==
Date:   Tue, 9 Oct 2018 08:37:32 +0000
Message-ID: <1539074230-27277-6-git-send-email-abel.vesa@nxp.com>
References: <1539074230-27277-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1539074230-27277-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR02CA0058.eurprd02.prod.outlook.com
 (2603:10a6:802:14::29) To VI1PR04MB1613.eurprd04.prod.outlook.com
 (2a01:111:e400:596b::19)
x-originating-ip: [95.76.156.53]
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB5343;6:OoCKh+VPz8dHz5zEMdmiBgtM81WKbGr1wT6Re6cwG0t3InX6jvEWQrM1kG73It2ZDok+WcLMcmNxkmtfRlKMZzArXPVAWfcvVC2+D5e1BxN4Fa2wDHQor7+ycyW3n83H6wiJzjsUgDh4SQPKGN4i5txv+vKakPV6iRpUxlvGCyt4zaQjD4+HdhvYguXMNOsER2pQktClmnz+N7m/bqMgp5tNFXi2LuQdY8qTSttY1v2A/RoGXwIDb5Hd7BJKMd/Xqh1HfbYJNPutavRSKXU03l38cscUuFSEVaooLfhexoY51szwazfGDMf1xqYY/BsDpss+CVXeb+Ted6jPruWjh5Jg2WDMxK7FOKimGQTBWKlmZaZHFemXRKkiwKWnA6Eh27e0z0WI1cIWrR+p6WrLjlnW0sF6tFCDGqQRdmirPysn+LKlDpqlY2CQSE0CPg72siRdvQVlFO28edkHnN6ebg==;5:D1qyEjp8mx2XHIRQWEH5xkmhkHUI7tUxjg2QyxqXYYciWbwCd1Zop2W6dn49ty2KZECij+baWJJmV/DM25sWif6q0uU27EWyAK5bGqfFM1NEEEo0qBDdDsEw8Il7SEPZnlgtpMRGerxtGOAFPIZVXYCjA2zlezqroP+ySQkmkkc=;7:00qSFjP8w5TGeFDfBMRR5kELbqo77SkCPqF/e4uJpRZK479jjGxCzSNw0eHyCfUQ+1gj2D2PQXT1wKoF3hg7s7hK5HGr8OzgbGY89c7A5Y3scJ/yzQPjr5RV0UTTsZq34qN0kw8YHXpltSlyUh5KlxgSImuyKrdOaG0dIQnBK0t2o/Fm2Ee8eMqjSsBElzy3Q5yH0uAgTYIrdk29XOD9GQF9/ZNkBA4oSSFAQnSLfEtGCF4WNlGIhZkZEBHRm40h
x-ms-office365-filtering-correlation-id: c3034802-ccac-4221-fa6f-08d62dc27430
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5343;
x-ms-traffictypediagnostic: VI1PR04MB5343:
x-microsoft-antispam-prvs: <VI1PR04MB53436BFEDB76C43DB1ECBA16F6E70@VI1PR04MB5343.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(6055026)(149066)(150057)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(201708071742011)(7699051)(76991055);SRVR:VI1PR04MB5343;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB5343;
x-forefront-prvs: 08200063E9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(366004)(376002)(199004)(189003)(476003)(486006)(44832011)(6512007)(446003)(6636002)(36756003)(5660300001)(4744004)(2906002)(5250100002)(68736007)(2616005)(11346002)(6116002)(3846002)(106356001)(7736002)(305945005)(105586002)(81166006)(81156014)(8676002)(71190400001)(52116002)(110136005)(71200400001)(25786009)(14454004)(478600001)(256004)(86362001)(6486002)(2900100001)(14444005)(53946003)(16200700003)(4326008)(186003)(6436002)(54906003)(6506007)(8936002)(386003)(66066001)(7416002)(102836004)(6346003)(53936002)(97736004)(99286004)(76176011)(316002)(26005)(579004)(559001)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5343;H:VI1PR04MB1613.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-microsoft-antispam-message-info: I9qXTcTj+SqtXVRkOUa/EGETpSNN4VEvWXoA3lUEfhI7gb/LhZFQ8Zw+JqFxuFrdrVAY5LaSpFx/LvB6052Rqb2SNDmDiPacreGLqhfhfAGGvO3jI4NK68zY1lExytABAbByPfZKjrkrM73lMKGmBywfajv4LgMoAWdqcfMWNz0ieYWsDcqc7I4l/Tpxhqjls7yjTjtFG6I4QMUhXPW8Ux0gua0OujqHsguIu4QQFNO1dMzVZWDaqgZs/jGW6jCQNkHMTt9ByEhjjgoFSze0keSLU25IkhML6L4K4lxaSWNIyCV+YcV4j6AvAOtZpWSV1EkCsXdoIMEDOIezgWGJ04eH0akmeAAtrXp8M9o32rA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3034802-ccac-4221-fa6f-08d62dc27430
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2018 08:37:32.3432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

Add driver for the Clock Control Module found on i.MX8MQ.

This is largely based on the downstream driver from Anson Huang and
Bai Ping at NXP, plus the imx composite clock from Abel Vesa at NXP,
with only some small adaptions to mainline from me.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/clk/imx/Makefile     |   1 +
 drivers/clk/imx/clk-imx8mq.c | 602 +++++++++++++++++++++++++++++++++++++++=
++++
 drivers/clk/imx/clk.h        |  36 +++
 3 files changed, 639 insertions(+)
 create mode 100644 drivers/clk/imx/clk-imx8mq.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 237444b..428548a 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -30,3 +30,4 @@ obj-$(CONFIG_SOC_IMX6SX) +=3D clk-imx6sx.o
 obj-$(CONFIG_SOC_IMX6UL) +=3D clk-imx6ul.o
 obj-$(CONFIG_SOC_IMX7D)  +=3D clk-imx7d.o
 obj-$(CONFIG_SOC_VF610)  +=3D clk-vf610.o
+obj-$(CONFIG_SOC_IMX8MQ) +=3D clk-imx8mq.o
diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
new file mode 100644
index 0000000..062126c
--- /dev/null
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -0,0 +1,602 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 NXP.
+ * Copyright (C) 2017 Pengutronix, Lucas Stach <kernel@pengutronix.de>
+ */
+
+#include <dt-bindings/clock/imx8mq-clock.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/types.h>
+
+#include "clk.h"
+
+static u32 share_count_sai1;
+static u32 share_count_sai2;
+static u32 share_count_sai3;
+static u32 share_count_sai4;
+static u32 share_count_sai5;
+static u32 share_count_sai6;
+static u32 share_count_dcss;
+static u32 share_count_nand;
+
+static struct clk *clks[IMX8MQ_CLK_END];
+
+static const char *pll_ref_sels[] =3D { "osc_25m", "osc_27m", "dummy", "du=
mmy", };
+static const char *arm_pll_bypass_sels[] =3D {"arm_pll", "arm_pll_ref_sel"=
, };
+static const char *gpu_pll_bypass_sels[] =3D {"gpu_pll", "gpu_pll_ref_sel"=
, };
+static const char *vpu_pll_bypass_sels[] =3D {"vpu_pll", "vpu_pll_ref_sel"=
, };
+static const char *audio_pll1_bypass_sels[] =3D {"audio_pll1", "audio_pll1=
_ref_sel", };
+static const char *audio_pll2_bypass_sels[] =3D {"audio_pll2", "audio_pll2=
_ref_sel", };
+static const char *video_pll1_bypass_sels[] =3D {"video_pll1", "video_pll1=
_ref_sel", };
+
+static const char *sys1_pll1_out_sels[] =3D {"sys1_pll1", "sys1_pll1_ref_s=
el", };
+static const char *sys2_pll1_out_sels[] =3D {"sys2_pll1", "sys1_pll1_ref_s=
el", };
+static const char *sys3_pll1_out_sels[] =3D {"sys3_pll1", "sys3_pll1_ref_s=
el", };
+static const char *dram_pll1_out_sels[] =3D {"dram_pll1", "dram_pll1_ref_s=
el", };
+
+static const char *sys1_pll2_out_sels[] =3D {"sys1_pll2_div", "sys1_pll1_r=
ef_sel", };
+static const char *sys2_pll2_out_sels[] =3D {"sys2_pll2_div", "sys2_pll1_r=
ef_sel", };
+static const char *sys3_pll2_out_sels[] =3D {"sys3_pll2_div", "sys2_pll1_r=
ef_sel", };
+static const char *dram_pll2_out_sels[] =3D {"dram_pll2_div", "dram_pll1_r=
ef_sel", };
+
+/* CCM ROOT */
+static const char *imx8mq_a53_sels[] =3D {"osc_25m", "arm_pll_out", "sys2_=
pll_500m", "sys2_pll_1000m",
+					"sys1_pll_800m", "sys1_pll_400m", "audio_pll1_out", "sys3_pll2_out", =
};
+
+static const char *imx8mq_vpu_sels[] =3D {"osc_25m", "arm_pll_out", "sys2_=
pll_500m", "sys2_pll_1000m",
+					"sys1_pll_800m", "sys1_pll_400m", "audio_pll1_out", "vpu_pll_out", };
+
+static const char *imx8mq_gpu_core_sels[] =3D {"osc_25m", "gpu_pll_out", "=
sys1_pll_800m", "sys3_pll2_out",
+					     "sys2_pll_1000m", "audio_pll1_out", "video_pll1_out", "audio_pll=
2_out", };
+
+static const char *imx8mq_gpu_shader_sels[] =3D {"osc_25m", "gpu_pll_out",=
 "sys1_pll_800m", "sys3_pll2_out",
+					       "sys2_pll_1000m", "audio_pll1_out", "video_pll1_out", "audio_p=
ll2_out", };
+
+static const char *imx8mq_main_axi_sels[] =3D {"osc_25m", "sys2_pll_333m",=
 "sys1_pll_800m", "sys2_pll_250m",
+					     "sys2_pll_1000m", "audio_pll1_out", "video_pll1_out", "sys1_pll_=
100m",};
+
+static const char *imx8mq_enet_axi_sels[] =3D {"osc_25m", "sys1_pll_266m",=
 "sys1_pll_800m", "sys2_pll_250m",
+					     "sys2_pll_200m", "audio_pll1_out", "video_pll1_out", "sys3_pll2_=
out", };
+
+static const char *imx8mq_nand_usdhc_sels[] =3D {"osc_25m", "sys1_pll_266m=
", "sys1_pll_800m", "sys2_pll_200m",
+					       "sys1_pll_133m", "sys3_pll2_out", "sys2_pll_250m", "audio_pll1=
_out", };
+
+static const char *imx8mq_vpu_bus_sels[] =3D {"osc_25m", "sys1_pll_800m", =
"vpu_pll_out", "audio_pll2_out", "sys3_pll2_out", "sys2_pll_1000m", "sys2_p=
ll_200m", "sys1_pll_100m", };
+
+static const char *imx8mq_disp_axi_sels[] =3D {"osc_25m", "sys2_pll_125m",=
 "sys1_pll_800m", "sys3_pll2_out", "sys1_pll_400m", "audio_pll2_out", "clk_=
ext1", "clk_ext4", };
+
+static const char *imx8mq_disp_apb_sels[] =3D {"osc_25m", "sys2_pll_125m",=
 "sys1_pll_800m", "sys3_pll2_out",
+					     "sys1_pll_40m", "audio_pll2_out", "clk_ext1", "clk_ext3", };
+
+static const char *imx8mq_disp_rtrm_sels[] =3D {"osc_25m", "sys1_pll_800m"=
, "sys2_pll_200m", "sys1_pll_400m",
+					      "audio_pll1_out", "video_pll1_out", "clk_ext2", "clk_ext3", };
+
+static const char *imx8mq_usb_bus_sels[] =3D {"osc_25m", "sys2_pll_500m", =
"sys1_pll_800m", "sys2_pll_100m",
+					    "sys2_pll_200m", "clk_ext2", "clk_ext4", "audio_pll2_out", };
+
+static const char *imx8mq_gpu_axi_sels[] =3D {"osc_25m", "sys1_pll_800m", =
"gpu_pll_out", "sys3_pll2_out", "sys2_pll_1000m",
+					    "audio_pll1_out", "video_pll1_out", "audio_pll2_out", };
+
+static const char *imx8mq_gpu_ahb_sels[] =3D {"osc_25m", "sys1_pll_800m", =
"gpu_pll_out", "sys3_pll2_out", "sys2_pll_1000m",
+					    "audio_pll1_out", "video_pll1_out", "audio_pll2_out", };
+
+static const char *imx8mq_noc_sels[] =3D {"osc_25m", "sys1_pll_800m", "sys=
3_pll2_out", "sys2_pll_1000m", "sys2_pll_500m",
+					"audio_pll1_out", "video_pll1_out", "audio_pll2_out", };
+
+static const char *imx8mq_noc_apb_sels[] =3D {"osc_25m", "sys1_pll_400m", =
"sys3_pll2_out", "sys2_pll_333m", "sys2_pll_200m",
+					    "sys1_pll_800m", "audio_pll1_out", "video_pll1_out", };
+
+static const char *imx8mq_ahb_sels[] =3D {"osc_25m", "sys1_pll_133m", "sys=
1_pll_800m", "sys1_pll_400m",
+					"sys2_pll_125m", "sys3_pll2_out", "audio_pll1_out", "video_pll1_out",=
 };
+
+static const char *imx8mq_audio_ahb_sels[] =3D {"osc_25m", "sys2_pll_500m"=
, "sys1_pll_800m", "sys2_pll_1000m",
+						  "sys2_pll_166m", "sys3_pll2_out", "audio_pll1_out", "video_pll1_ou=
t", };
+
+static const char *imx8mq_dsi_ahb_sels[] =3D {"osc_25m", "sys2_pll_100m", =
"sys1_pll_80m", "sys1_pll_800m",
+						"sys2_pll_1000m", "sys3_pll2_out", "clk_ext3", "audio_pll2_out"};
+
+static const char *imx8mq_dram_alt_sels[] =3D {"osc_25m", "sys1_pll_800m",=
 "sys1_pll_100m", "sys2_pll_500m",
+						"sys2_pll_250m", "sys1_pll_400m", "audio_pll1_out", "sys1_pll_266m",=
 };
+
+static const char *imx8mq_dram_apb_sels[] =3D {"osc_25m", "sys2_pll_200m",=
 "sys1_pll_40m", "sys1_pll_160m",
+						"sys1_pll_800m", "sys3_pll2_out", "sys2_pll_250m", "audio_pll2_out",=
 };
+
+static const char *imx8mq_vpu_g1_sels[] =3D {"osc_25m", "vpu_pll_out", "sy=
s1_pll_800m", "sys2_pll_1000m", "sys1_pll_100m", "sys2_pll_125m", "sys3_pll=
2_out", "audio_pll1_out", };
+
+static const char *imx8mq_vpu_g2_sels[] =3D {"osc_25m", "vpu_pll_out", "sy=
s1_pll_800m", "sys2_pll_1000m", "sys1_pll_100m", "sys2_pll_125m", "sys3_pll=
2_out", "audio_pll1_out", };
+
+static const char *imx8mq_disp_dtrc_sels[] =3D {"osc_25m", "vpu_pll_out", =
"sys1_pll_800m", "sys2_pll_1000m", "sys1_pll_160m", "sys2_pll_100m", "sys3_=
pll2_out", "audio_pll2_out", };
+
+static const char *imx8mq_disp_dc8000_sels[] =3D {"osc_25m", "vpu_pll_out"=
, "sys1_pll_800m", "sys2_pll_1000m", "sys1_pll_160m", "sys2_pll_100m", "sys=
3_pll2_out", "audio_pll2_out", };
+
+static const char *imx8mq_pcie1_ctrl_sels[] =3D {"osc_25m", "sys2_pll_250m=
", "sys2_pll_200m", "sys1_pll_266m",
+					       "sys1_pll_800m", "sys2_pll_500m", "sys2_pll_250m", "sys3_pll2_=
out", };
+
+static const char *imx8mq_pcie1_phy_sels[] =3D {"osc_25m", "sys2_pll_100m"=
, "sys2_pll_500m", "clk_ext1", "clk_ext2",
+					      "clk_ext3", "clk_ext4", };
+
+static const char *imx8mq_pcie1_aux_sels[] =3D {"osc_25m", "sys2_pll_200m"=
, "sys2_pll_500m", "sys3_pll2_out",
+					      "sys2_pll_100m", "sys1_pll_80m", "sys1_pll_160m", "sys1_pll_200=
m", };
+
+static const char *imx8mq_dc_pixel_sels[] =3D {"osc_25m", "video_pll1_out"=
, "audio_pll2_out", "audio_pll1_out", "sys1_pll_800m", "sys2_pll_1000m", "s=
ys3_pll2_out", "clk_ext4", };
+
+static const char *imx8mq_lcdif_pixel_sels[] =3D {"osc_25m", "video_pll1_o=
ut", "audio_pll2_out", "audio_pll1_out", "sys1_pll_800m", "sys2_pll_1000m",=
 "sys3_pll2_out", "clk_ext4", };
+
+static const char *imx8mq_sai1_sels[] =3D {"osc_25m", "audio_pll1_out", "a=
udio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext1", "=
clk_ext2", };
+
+static const char *imx8mq_sai2_sels[] =3D {"osc_25m", "audio_pll1_out", "a=
udio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext2", "=
clk_ext3", };
+
+static const char *imx8mq_sai3_sels[] =3D {"osc_25m", "audio_pll1_out", "a=
udio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext3", "=
clk_ext4", };
+
+static const char *imx8mq_sai4_sels[] =3D {"osc_25m", "audio_pll1_out", "a=
udio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext1", "=
clk_ext2", };
+
+static const char *imx8mq_sai5_sels[] =3D {"osc_25m", "audio_pll1_out", "a=
udio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext2", "=
clk_ext3", };
+
+static const char *imx8mq_sai6_sels[] =3D {"osc_25m", "audio_pll1_out", "a=
udio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext3", "=
clk_ext4", };
+
+static const char *imx8mq_spdif1_sels[] =3D {"osc_25m", "audio_pll1_out", =
"audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext2",=
 "clk_ext3", };
+
+static const char *imx8mq_spdif2_sels[] =3D {"osc_25m", "audio_pll1_out", =
"audio_pll2_out", "video_pll1_out", "sys1_pll_133m", "osc_27m", "clk_ext3",=
 "clk_ext4", };
+
+static const char *imx8mq_enet_ref_sels[] =3D {"osc_25m", "sys2_pll_125m",=
 "sys2_pll_500m", "sys2_pll_100m",
+					     "sys1_pll_160m", "audio_pll1_out", "video_pll1_out", "clk_ext4",=
 };
+
+static const char *imx8mq_enet_timer_sels[] =3D {"osc_25m", "sys2_pll_100m=
", "audio_pll1_out", "clk_ext1", "clk_ext2",
+					       "clk_ext3", "clk_ext4", "video_pll1_out", };
+
+static const char *imx8mq_enet_phy_sels[] =3D {"osc_25m", "sys2_pll_50m", =
"sys2_pll_125m", "sys2_pll_500m",
+					     "audio_pll1_out", "video_pll1_out", "audio_pll2_out", };
+
+static const char *imx8mq_nand_sels[] =3D {"osc_25m", "sys2_pll_500m", "au=
dio_pll1_out", "sys1_pll_400m",
+					 "audio_pll2_out", "sys3_pll2_out", "sys2_pll_250m", "video_pll1_out"=
, };
+
+static const char *imx8mq_qspi_sels[] =3D {"osc_25m", "sys1_pll_400m", "sy=
s1_pll_800m", "sys2_pll_500m",
+					 "audio_pll2_out", "sys1_pll_266m", "sys3_pll2_out", "sys1_pll_100m",=
 };
+
+static const char *imx8mq_usdhc1_sels[] =3D {"osc_25m", "sys1_pll_400m", "=
sys1_pll_800m", "sys2_pll_500m",
+					 "audio_pll2_out", "sys1_pll_266m", "sys3_pll2_out", "sys1_pll_100m",=
 };
+
+static const char *imx8mq_usdhc2_sels[] =3D {"osc_25m", "sys1_pll_400m", "=
sys1_pll_800m", "sys2_pll_500m",
+					 "audio_pll2_out", "sys1_pll_266m", "sys3_pll2_out", "sys1_pll_100m",=
 };
+
+static const char *imx8mq_i2c1_sels[] =3D {"osc_25m", "sys1_pll_160m", "sy=
s2_pll_50m", "sys3_pll2_out", "audio_pll1_out",
+					 "video_pll1_out", "audio_pll2_out", "sys1_pll_133m", };
+
+static const char *imx8mq_i2c2_sels[] =3D {"osc_25m", "sys1_pll_160m", "sy=
s2_pll_50m", "sys3_pll2_out", "audio_pll1_out",
+					 "video_pll1_out", "audio_pll2_out", "sys1_pll_133m", };
+
+static const char *imx8mq_i2c3_sels[] =3D {"osc_25m", "sys1_pll_160m", "sy=
s2_pll_50m", "sys3_pll2_out", "audio_pll1_out",
+					 "video_pll1_out", "audio_pll2_out", "sys1_pll_133m", };
+
+static const char *imx8mq_i2c4_sels[] =3D {"osc_25m", "sys1_pll_160m", "sy=
s2_pll_50m", "sys3_pll2_out", "audio_pll1_out",
+					 "video_pll1_out", "audio_pll2_out", "sys1_pll_133m", };
+
+static const char *imx8mq_uart1_sels[] =3D {"osc_25m", "sys1_pll_80m", "sy=
s2_pll_200m", "sys2_pll_100m",
+					  "sys3_pll2_out", "clk_ext2", "clk_ext4", "audio_pll2_out", };
+
+static const char *imx8mq_uart2_sels[] =3D {"osc_25m", "sys1_pll_80m", "sy=
s2_pll_200m", "sys2_pll_100m",
+					  "sys3_pll2_out", "clk_ext2", "clk_ext3", "audio_pll2_out", };
+
+static const char *imx8mq_uart3_sels[] =3D {"osc_25m", "sys1_pll_80m", "sy=
s2_pll_200m", "sys2_pll_100m",
+					  "sys3_pll2_out", "clk_ext2", "clk_ext4", "audio_pll2_out", };
+
+static const char *imx8mq_uart4_sels[] =3D {"osc_25m", "sys1_pll_80m", "sy=
s2_pll_200m", "sys2_pll_100m",
+					  "sys3_pll2_out", "clk_ext2", "clk_ext3", "audio_pll2_out", };
+
+static const char *imx8mq_usb_core_sels[] =3D {"osc_25m", "sys1_pll_100m",=
 "sys1_pll_40m", "sys2_pll_100m",
+					     "sys2_pll_200m", "clk_ext2", "clk_ext3", "audio_pll2_out", };
+
+static const char *imx8mq_usb_phy_sels[] =3D {"osc_25m", "sys1_pll_100m", =
"sys1_pll_40m", "sys2_pll_100m",
+					     "sys2_pll_200m", "clk_ext2", "clk_ext3", "audio_pll2_out", };
+
+static const char *imx8mq_ecspi1_sels[] =3D {"osc_25m", "sys2_pll_200m", "=
sys1_pll_40m", "sys1_pll_160m",
+					   "sys1_pll_800m", "sys3_pll2_out", "sys2_pll_250m", "audio_pll2_out=
", };
+
+static const char *imx8mq_ecspi2_sels[] =3D {"osc_25m", "sys2_pll_200m", "=
sys1_pll_40m", "sys1_pll_160m",
+					   "sys1_pll_800m", "sys3_pll2_out", "sys2_pll_250m", "audio_pll2_out=
", };
+
+static const char *imx8mq_pwm1_sels[] =3D {"osc_25m", "sys2_pll_100m", "sy=
s1_pll_160m", "sys1_pll_40m",
+					 "sys3_pll2_out", "clk_ext1", "sys1_pll_80m", "video_pll1_out", };
+
+static const char *imx8mq_pwm2_sels[] =3D {"osc_25m", "sys2_pll_100m", "sy=
s1_pll_160m", "sys1_pll_40m",
+					 "sys3_pll2_out", "clk_ext1", "sys1_pll_80m", "video_pll1_out", };
+
+static const char *imx8mq_pwm3_sels[] =3D {"osc_25m", "sys2_pll_100m", "sy=
s1_pll_160m", "sys1_pll_40m",
+					 "sys3_pll2_out", "clk_ext2", "sys1_pll_80m", "video_pll1_out", };
+
+static const char *imx8mq_pwm4_sels[] =3D {"osc_25m", "sys2_pll_100m", "sy=
s1_pll_160m", "sys1_pll_40m",
+					 "sys3_pll2_out", "clk_ext2", "sys1_pll_80m", "video_pll1_out", };
+
+static const char *imx8mq_gpt1_sels[] =3D {"osc_25m", "sys2_pll_100m", "sy=
s1_pll_400m", "sys1_pll_40m",
+					 "sys1_pll_80m", "audio_pll1_out", "clk_ext1", };
+
+static const char *imx8mq_wdog_sels[] =3D {"osc_25m", "sys1_pll_133m", "sy=
s1_pll_160m", "vpu_pll_out",
+					 "sys2_pll_125m", "sys3_pll2_out", "sys1_pll_80m", "sys2_pll_166m", }=
;
+
+static const char *imx8mq_wrclk_sels[] =3D {"osc_25m", "sys1_pll_40m", "vp=
u_pll_out", "sys3_pll2_out", "sys2_pll_200m",
+					  "sys1_pll_266m", "sys2_pll_500m", "sys1_pll_100m", };
+
+static const char *imx8mq_dsi_core_sels[] =3D {"osc_25m", "sys1_pll_266m",=
 "sys2_pll_250m", "sys1_pll_800m",
+					     "sys2_pll_1000m", "sys3_pll2_out", "audio_pll2_out", "video_pll1=
_out", };
+
+static const char *imx8mq_dsi_phy_sels[] =3D {"osc_25m", "sys2_pll_125m", =
"sys2_pll_100m", "sys1_pll_800m",
+					    "sys2_pll_1000m", "clk_ext2", "audio_pll2_out", "video_pll1_out",=
 };
+
+static const char *imx8mq_dsi_dbi_sels[] =3D {"osc_25m", "sys1_pll_266m", =
"sys2_pll_100m", "sys1_pll_800m",
+					    "sys2_pll_1000m", "sys3_pll2_out", "audio_pll2_out", "video_pll1_=
out", };
+
+static const char *imx8mq_dsi_esc_sels[] =3D {"osc_25m", "sys2_pll_100m", =
"sys1_pll_80m", "sys1_pll_800m",
+					    "sys2_pll_1000m", "sys3_pll2_out", "clk_ext3", "audio_pll2_out", =
};
+
+static const char *imx8mq_csi1_core_sels[] =3D {"osc_25m", "sys1_pll_266m"=
, "sys2_pll_250m", "sys1_pll_800m",
+					      "sys2_pll_1000m", "sys3_pll2_out", "audio_pll2_out", "video_pll=
1_out", };
+
+static const char *imx8mq_csi1_phy_sels[] =3D {"osc_25m", "sys2_pll_125m",=
 "sys2_pll_100m", "sys1_pll_800m",
+					     "sys2_pll_1000m", "clk_ext2", "audio_pll2_out", "video_pll1_out"=
, };
+
+static const char *imx8mq_csi1_esc_sels[] =3D {"osc_25m", "sys2_pll_100m",=
 "sys1_pll_80m", "sys1_pll_800m",
+					     "sys2_pll_1000m", "sys3_pll2_out", "clk_ext3", "audio_pll2_out",=
 };
+
+static const char *imx8mq_csi2_core_sels[] =3D {"osc_25m", "sys1_pll_266m"=
, "sys2_pll_250m", "sys1_pll_800m",
+					      "sys2_pll_1000m", "sys3_pll2_out", "audio_pll2_out", "video_pll=
1_out", };
+
+static const char *imx8mq_csi2_phy_sels[] =3D {"osc_25m", "sys2_pll_125m",=
 "sys2_pll_100m", "sys1_pll_800m",
+					     "sys2_pll_1000m", "clk_ext2", "audio_pll2_out", "video_pll1_out"=
, };
+
+static const char *imx8mq_csi2_esc_sels[] =3D {"osc_25m", "sys2_pll_100m",=
 "sys1_pll_80m", "sys1_pll_800m",
+					     "sys2_pll_1000m", "sys3_pll2_out", "clk_ext3", "audio_pll2_out",=
 };
+
+static const char *imx8mq_pcie2_ctrl_sels[] =3D {"osc_25m", "sys2_pll_250m=
", "sys2_pll_200m", "sys1_pll_266m",
+					       "sys1_pll_800m", "sys2_pll_500m", "sys2_pll_333m", "sys3_pll2_=
out", };
+
+static const char *imx8mq_pcie2_phy_sels[] =3D {"osc_25m", "sys2_pll_100m"=
, "sys2_pll_500m", "clk_ext1",
+					      "clk_ext2", "clk_ext3", "clk_ext4", "sys1_pll_400m", };
+
+static const char *imx8mq_pcie2_aux_sels[] =3D {"osc_25m", "sys2_pll_200m"=
, "sys2_pll_50m", "sys3_pll2_out",
+					      "sys2_pll_100m", "sys1_pll_80m", "sys1_pll_160m", "sys1_pll_200=
m", };
+
+static const char *imx8mq_ecspi3_sels[] =3D {"osc_25m", "sys2_pll_200m", "=
sys1_pll_40m", "sys1_pll_160m",
+					   "sys1_pll_800m", "sys3_pll2_out", "sys2_pll_250m", "audio_pll2_out=
", };
+static const char *imx8mq_dram_core_sels[] =3D {"dram_pll_out", "dram_alt_=
root", };
+
+static const char *imx8mq_clko2_sels[] =3D {"osc_25m", "sys2_pll_200m", "s=
ys1_pll_400m", "sys2_pll_166m", "audio_pll1_out",
+					 "video_pll1_out", "ckil", };
+
+static struct clk_onecell_data clk_data;
+
+static void __init imx8mq_clocks_init(struct device_node *ccm_node)
+{
+	struct device_node *np;
+	void __iomem *base;
+	int i;
+
+	clks[IMX8MQ_CLK_DUMMY] =3D imx_clk_fixed("dummy", 0);
+	clks[IMX8MQ_CLK_32K] =3D of_clk_get_by_name(ccm_node, "ckil");
+	clks[IMX8MQ_CLK_25M] =3D of_clk_get_by_name(ccm_node, "osc_25m");
+	clks[IMX8MQ_CLK_27M] =3D of_clk_get_by_name(ccm_node, "osc_27m");
+	clks[IMX8MQ_CLK_EXT1] =3D of_clk_get_by_name(ccm_node, "clk_ext1");
+	clks[IMX8MQ_CLK_EXT2] =3D of_clk_get_by_name(ccm_node, "clk_ext2");
+	clks[IMX8MQ_CLK_EXT3] =3D of_clk_get_by_name(ccm_node, "clk_ext3");
+	clks[IMX8MQ_CLK_EXT4] =3D of_clk_get_by_name(ccm_node, "clk_ext4");
+
+	np =3D of_find_compatible_node(NULL, NULL, "fsl,imx8mq-anatop");
+	base =3D of_iomap(np, 0);
+	WARN_ON(!base);
+
+	clks[IMX8MQ_ARM_PLL_REF_SEL] =3D imx_clk_mux("arm_pll_ref_sel", base + 0x=
28, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	clks[IMX8MQ_GPU_PLL_REF_SEL] =3D imx_clk_mux("gpu_pll_ref_sel", base + 0x=
18, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	clks[IMX8MQ_VPU_PLL_REF_SEL] =3D imx_clk_mux("vpu_pll_ref_sel", base + 0x=
20, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	clks[IMX8MQ_AUDIO_PLL1_REF_SEL] =3D imx_clk_mux("audio_pll1_ref_sel", bas=
e + 0x0, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	clks[IMX8MQ_AUDIO_PLL2_REF_SEL] =3D imx_clk_mux("audio_pll2_ref_sel", bas=
e + 0x8, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	clks[IMX8MQ_VIDEO_PLL1_REF_SEL] =3D imx_clk_mux("video_pll1_ref_sel", bas=
e + 0x10, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	clks[IMX8MQ_SYS1_PLL1_REF_SEL]	=3D imx_clk_mux("sys1_pll1_ref_sel", base =
+ 0x30, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	clks[IMX8MQ_SYS2_PLL1_REF_SEL]	=3D imx_clk_mux("sys2_pll1_ref_sel", base =
+ 0x3c, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	clks[IMX8MQ_SYS3_PLL1_REF_SEL]	=3D imx_clk_mux("sys3_pll1_ref_sel", base =
+ 0x48, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+	clks[IMX8MQ_DRAM_PLL1_REF_SEL]	=3D imx_clk_mux("dram_pll1_ref_sel", base =
+ 0x60, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
+
+	clks[IMX8MQ_ARM_PLL_REF_DIV]	=3D imx_clk_divider("arm_pll_ref_div", "arm_=
pll_ref_sel", base + 0x28, 5, 6);
+	clks[IMX8MQ_GPU_PLL_REF_DIV]	=3D imx_clk_divider("gpu_pll_ref_div", "gpu_=
pll_ref_sel", base + 0x18, 5, 6);
+	clks[IMX8MQ_VPU_PLL_REF_DIV]	=3D imx_clk_divider("vpu_pll_ref_div", "vpu_=
pll_ref_sel", base + 0x20, 5, 6);
+	clks[IMX8MQ_AUDIO_PLL1_REF_DIV] =3D imx_clk_divider("audio_pll1_ref_div",=
 "audio_pll1_ref_sel", base + 0x0, 5, 6);
+	clks[IMX8MQ_AUDIO_PLL2_REF_DIV] =3D imx_clk_divider("audio_pll2_ref_div",=
 "audio_pll2_ref_sel", base + 0x8, 5, 6);
+	clks[IMX8MQ_VIDEO_PLL1_REF_DIV] =3D imx_clk_divider("video_pll1_ref_div",=
 "video_pll1_ref_sel", base + 0x10, 5, 6);
+	clks[IMX8MQ_SYS1_PLL1_REF_DIV]	=3D imx_clk_divider("sys1_pll1_ref_div", "=
sys1_pll1_ref_sel", base + 0x38, 25, 3);
+	clks[IMX8MQ_SYS2_PLL1_REF_DIV]	=3D imx_clk_divider("sys2_pll1_ref_div", "=
sys2_pll1_ref_sel", base + 0x44, 25, 3);
+	clks[IMX8MQ_SYS3_PLL1_REF_DIV]	=3D imx_clk_divider("sys3_pll1_ref_div", "=
sys3_pll1_ref_sel", base + 0x50, 25, 3);
+	clks[IMX8MQ_DRAM_PLL1_REF_DIV]	=3D imx_clk_divider("dram_pll1_ref_div", "=
dram_pll1_ref_sel", base + 0x68, 25, 3);
+
+	clks[IMX8MQ_ARM_PLL] =3D imx_clk_frac_pll("arm_pll", "arm_pll_ref_div", b=
ase + 0x28);
+	clks[IMX8MQ_GPU_PLL] =3D imx_clk_frac_pll("gpu_pll", "gpu_pll_ref_div", b=
ase + 0x18);
+	clks[IMX8MQ_VPU_PLL] =3D imx_clk_frac_pll("vpu_pll", "vpu_pll_ref_div", b=
ase + 0x20);
+	clks[IMX8MQ_AUDIO_PLL1] =3D imx_clk_frac_pll("audio_pll1", "audio_pll1_re=
f_div", base + 0x0);
+	clks[IMX8MQ_AUDIO_PLL2] =3D imx_clk_frac_pll("audio_pll2", "audio_pll2_re=
f_div", base + 0x8);
+	clks[IMX8MQ_VIDEO_PLL1] =3D imx_clk_frac_pll("video_pll1", "video_pll1_re=
f_div", base + 0x10);
+	clks[IMX8MQ_SYS1_PLL1] =3D imx_clk_sccg_pll("sys1_pll1", "sys1_pll1_ref_d=
iv", base + 0x30, SCCG_PLL1);
+	clks[IMX8MQ_SYS2_PLL1] =3D imx_clk_sccg_pll("sys2_pll1", "sys2_pll1_ref_d=
iv", base + 0x3c, SCCG_PLL1);
+	clks[IMX8MQ_SYS3_PLL1] =3D imx_clk_sccg_pll("sys3_pll1", "sys3_pll1_ref_d=
iv", base + 0x48, SCCG_PLL1);
+	clks[IMX8MQ_DRAM_PLL1] =3D imx_clk_sccg_pll("dram_pll1", "dram_pll1_ref_d=
iv", base + 0x60, SCCG_PLL1);
+
+	clks[IMX8MQ_SYS1_PLL2] =3D imx_clk_sccg_pll("sys1_pll2", "sys1_pll1_out_d=
iv", base + 0x30, SCCG_PLL2);
+	clks[IMX8MQ_SYS2_PLL2] =3D imx_clk_sccg_pll("sys2_pll2", "sys2_pll1_out_d=
iv", base + 0x3c, SCCG_PLL2);
+	clks[IMX8MQ_SYS3_PLL2] =3D imx_clk_sccg_pll("sys3_pll2", "sys3_pll1_out_d=
iv", base + 0x48, SCCG_PLL2);
+	clks[IMX8MQ_DRAM_PLL2] =3D imx_clk_sccg_pll("dram_pll2", "dram_pll1_out_d=
iv", base + 0x60, SCCG_PLL2);
+
+	/* PLL divs */
+	clks[IMX8MQ_SYS1_PLL1_OUT_DIV] =3D imx_clk_divider("sys1_pll1_out_div", "=
sys1_pll1_out", base + 0x38, 19, 6);
+	clks[IMX8MQ_SYS2_PLL1_OUT_DIV] =3D imx_clk_divider("sys2_pll1_out_div", "=
sys2_pll1_out", base + 0x44, 19, 6);
+	clks[IMX8MQ_SYS3_PLL1_OUT_DIV] =3D imx_clk_divider("sys3_pll1_out_div", "=
sys3_pll1_out", base + 0x50, 19, 6);
+	clks[IMX8MQ_DRAM_PLL1_OUT_DIV] =3D imx_clk_divider("dram_pll1_out_div", "=
dram_pll1_out", base + 0x68, 19, 6);
+	clks[IMX8MQ_SYS1_PLL2_DIV] =3D imx_clk_divider("sys1_pll2_div", "sys1_pll=
2", base + 0x38, 1, 6);
+	clks[IMX8MQ_SYS2_PLL2_DIV] =3D imx_clk_divider("sys2_pll2_div", "sys2_pll=
2", base + 0x44, 1, 6);
+	clks[IMX8MQ_SYS3_PLL2_DIV] =3D imx_clk_divider("sys3_pll2_div", "sys3_pll=
2", base + 0x50, 1, 6);
+	clks[IMX8MQ_DRAM_PLL2_DIV] =3D imx_clk_divider("dram_pll2_div", "dram_pll=
2", base + 0x68, 1, 6);
+
+	/* PLL bypass out */
+	clks[IMX8MQ_ARM_PLL_BYPASS] =3D imx_clk_mux("arm_pll_bypass", base + 0x28=
, 14, 1, arm_pll_bypass_sels, ARRAY_SIZE(arm_pll_bypass_sels));
+	clks[IMX8MQ_GPU_PLL_BYPASS] =3D imx_clk_mux("gpu_pll_bypass", base + 0x18=
, 14, 1, gpu_pll_bypass_sels, ARRAY_SIZE(gpu_pll_bypass_sels));
+	clks[IMX8MQ_VPU_PLL_BYPASS] =3D imx_clk_mux("vpu_pll_bypass", base + 0x20=
, 14, 1, vpu_pll_bypass_sels, ARRAY_SIZE(vpu_pll_bypass_sels));
+	clks[IMX8MQ_AUDIO_PLL1_BYPASS] =3D imx_clk_mux("audio_pll1_bypass", base =
+ 0x0, 14, 1, audio_pll1_bypass_sels, ARRAY_SIZE(audio_pll1_bypass_sels));
+	clks[IMX8MQ_AUDIO_PLL2_BYPASS] =3D imx_clk_mux("audio_pll2_bypass", base =
+ 0x8, 14, 1, audio_pll2_bypass_sels, ARRAY_SIZE(audio_pll2_bypass_sels));
+	clks[IMX8MQ_VIDEO_PLL1_BYPASS] =3D imx_clk_mux("video_pll1_bypass", base =
+ 0x10, 14, 1, video_pll1_bypass_sels, ARRAY_SIZE(video_pll1_bypass_sels));
+
+	clks[IMX8MQ_SYS1_PLL1_OUT] =3D imx_clk_mux("sys1_pll1_out", base + 0x30, =
5, 1, sys1_pll1_out_sels, ARRAY_SIZE(sys1_pll1_out_sels));
+	clks[IMX8MQ_SYS2_PLL1_OUT] =3D imx_clk_mux("sys2_pll1_out", base + 0x3c, =
5, 1, sys2_pll1_out_sels, ARRAY_SIZE(sys2_pll1_out_sels));
+	clks[IMX8MQ_SYS3_PLL1_OUT] =3D imx_clk_mux("sys3_pll1_out", base + 0x48, =
5, 1, sys3_pll1_out_sels, ARRAY_SIZE(sys3_pll1_out_sels));
+	clks[IMX8MQ_DRAM_PLL1_OUT] =3D imx_clk_mux("dram_pll1_out", base + 0x60, =
5, 1, dram_pll1_out_sels, ARRAY_SIZE(dram_pll1_out_sels));
+	clks[IMX8MQ_SYS1_PLL2_OUT] =3D imx_clk_mux("sys1_pll2_out", base + 0x30, =
4, 1, sys1_pll2_out_sels, ARRAY_SIZE(sys1_pll2_out_sels));
+	clks[IMX8MQ_SYS2_PLL2_OUT] =3D imx_clk_mux("sys2_pll2_out", base + 0x3c, =
4, 1, sys2_pll2_out_sels, ARRAY_SIZE(sys2_pll2_out_sels));
+	clks[IMX8MQ_SYS3_PLL2_OUT] =3D imx_clk_mux("sys3_pll2_out", base + 0x48, =
4, 1, sys3_pll2_out_sels, ARRAY_SIZE(sys3_pll2_out_sels));
+	clks[IMX8MQ_DRAM_PLL2_OUT] =3D imx_clk_mux("dram_pll2_out", base + 0x60, =
4, 1, dram_pll2_out_sels, ARRAY_SIZE(dram_pll2_out_sels));
+
+	/* unbypass all the plls */
+	clk_set_parent(clks[IMX8MQ_GPU_PLL_BYPASS], clks[IMX8MQ_GPU_PLL]);
+	clk_set_parent(clks[IMX8MQ_VPU_PLL_BYPASS], clks[IMX8MQ_VPU_PLL]);
+	clk_set_parent(clks[IMX8MQ_AUDIO_PLL1_BYPASS], clks[IMX8MQ_AUDIO_PLL1]);
+	clk_set_parent(clks[IMX8MQ_AUDIO_PLL2_BYPASS], clks[IMX8MQ_AUDIO_PLL2]);
+	clk_set_parent(clks[IMX8MQ_VIDEO_PLL1_BYPASS], clks[IMX8MQ_VIDEO_PLL1]);
+	clk_set_parent(clks[IMX8MQ_SYS3_PLL1_OUT], clks[IMX8MQ_SYS3_PLL1]);
+	clk_set_parent(clks[IMX8MQ_SYS3_PLL2_OUT], clks[IMX8MQ_SYS3_PLL2_DIV]);
+
+	/* PLL OUT GATE */
+	clks[IMX8MQ_ARM_PLL_OUT] =3D imx_clk_gate("arm_pll_out", "arm_pll_bypass"=
, base + 0x28, 21);
+	clks[IMX8MQ_GPU_PLL_OUT] =3D imx_clk_gate("gpu_pll_out", "gpu_pll_bypass"=
, base + 0x18, 21);
+	clks[IMX8MQ_VPU_PLL_OUT] =3D imx_clk_gate("vpu_pll_out", "vpu_pll_bypass"=
, base + 0x20, 21);
+	clks[IMX8MQ_AUDIO_PLL1_OUT] =3D imx_clk_gate("audio_pll1_out", "audio_pll=
1_bypass", base + 0x0, 21);
+	clks[IMX8MQ_AUDIO_PLL2_OUT] =3D imx_clk_gate("audio_pll2_out", "audio_pll=
2_bypass", base + 0x8, 21);
+	clks[IMX8MQ_VIDEO_PLL1_OUT] =3D imx_clk_gate("video_pll1_out", "video_pll=
1_bypass", base + 0x10, 21);
+	clks[IMX8MQ_SYS1_PLL_OUT] =3D imx_clk_gate("sys1_pll_out", "sys1_pll2_out=
", base + 0x30, 9);
+	clks[IMX8MQ_SYS2_PLL_OUT] =3D imx_clk_gate("sys2_pll_out", "sys2_pll2_out=
", base + 0x3c, 9);
+	clks[IMX8MQ_SYS3_PLL_OUT] =3D imx_clk_gate("sys3_pll_out", "sys3_pll2_out=
", base + 0x48, 9);
+	clks[IMX8MQ_DRAM_PLL_OUT] =3D imx_clk_gate("dram_pll_out", "dram_pll2_out=
", base + 0x60, 9);
+
+	/* SYS PLL fixed output */
+	clks[IMX8MQ_SYS1_PLL_40M] =3D imx_clk_fixed_factor("sys1_pll_40m", "sys1_=
pll_out", 1, 20);
+	clks[IMX8MQ_SYS1_PLL_80M] =3D imx_clk_fixed_factor("sys1_pll_80m", "sys1_=
pll_out", 1, 10);
+	clks[IMX8MQ_SYS1_PLL_100M] =3D imx_clk_fixed_factor("sys1_pll_100m", "sys=
1_pll_out", 1, 8);
+	clks[IMX8MQ_SYS1_PLL_133M] =3D imx_clk_fixed_factor("sys1_pll_133m", "sys=
1_pll_out", 1, 6);
+	clks[IMX8MQ_SYS1_PLL_160M] =3D imx_clk_fixed_factor("sys1_pll_160m", "sys=
1_pll_out", 1, 5);
+	clks[IMX8MQ_SYS1_PLL_200M] =3D imx_clk_fixed_factor("sys1_pll_200m", "sys=
1_pll_out", 1, 4);
+	clks[IMX8MQ_SYS1_PLL_266M] =3D imx_clk_fixed_factor("sys1_pll_266m", "sys=
1_pll_out", 1, 3);
+	clks[IMX8MQ_SYS1_PLL_400M] =3D imx_clk_fixed_factor("sys1_pll_400m", "sys=
1_pll_out", 1, 2);
+	clks[IMX8MQ_SYS1_PLL_800M] =3D imx_clk_fixed_factor("sys1_pll_800m", "sys=
1_pll_out", 1, 1);
+
+	clks[IMX8MQ_SYS2_PLL_50M] =3D imx_clk_fixed_factor("sys2_pll_50m", "sys2_=
pll_out", 1, 20);
+	clks[IMX8MQ_SYS2_PLL_100M] =3D imx_clk_fixed_factor("sys2_pll_100m", "sys=
2_pll_out", 1, 10);
+	clks[IMX8MQ_SYS2_PLL_125M] =3D imx_clk_fixed_factor("sys2_pll_125m", "sys=
2_pll_out", 1, 8);
+	clks[IMX8MQ_SYS2_PLL_166M] =3D imx_clk_fixed_factor("sys2_pll_166m", "sys=
2_pll_out", 1, 6);
+	clks[IMX8MQ_SYS2_PLL_200M] =3D imx_clk_fixed_factor("sys2_pll_200m", "sys=
2_pll_out", 1, 5);
+	clks[IMX8MQ_SYS2_PLL_250M] =3D imx_clk_fixed_factor("sys2_pll_250m", "sys=
2_pll_out", 1, 4);
+	clks[IMX8MQ_SYS2_PLL_333M] =3D imx_clk_fixed_factor("sys2_pll_333m", "sys=
2_pll_out", 1, 3);
+	clks[IMX8MQ_SYS2_PLL_500M] =3D imx_clk_fixed_factor("sys2_pll_500m", "sys=
2_pll_out", 1, 2);
+	clks[IMX8MQ_SYS2_PLL_1000M] =3D imx_clk_fixed_factor("sys2_pll_1000m", "s=
ys2_pll_out", 1, 1);
+
+	np =3D ccm_node;
+	base =3D of_iomap(np, 0);
+	WARN_ON(!base);
+	/* CORE */
+	clks[IMX8MQ_CLK_A53_SRC] =3D imx_clk_mux2("arm_a53_src", base + 0x8000, 2=
4, 3, imx8mq_a53_sels, ARRAY_SIZE(imx8mq_a53_sels));
+	clks[IMX8MQ_CLK_VPU_SRC] =3D imx_clk_mux2("vpu_src", base + 0x8100, 24, 3=
, imx8mq_vpu_sels, ARRAY_SIZE(imx8mq_vpu_sels));
+	clks[IMX8MQ_CLK_GPU_CORE_SRC] =3D imx_clk_mux2("gpu_core_src", base + 0x8=
180, 24, 3,  imx8mq_gpu_core_sels, ARRAY_SIZE(imx8mq_gpu_core_sels));
+	clks[IMX8MQ_CLK_GPU_SHADER_SRC] =3D imx_clk_mux2("gpu_shader_src", base +=
 0x8200, 24, 3, imx8mq_gpu_shader_sels,  ARRAY_SIZE(imx8mq_gpu_shader_sels)=
);
+	clks[IMX8MQ_CLK_A53_CG] =3D imx_clk_gate3_flags("arm_a53_cg", "arm_a53_sr=
c", base + 0x8000, 28, CLK_IS_CRITICAL);
+	clks[IMX8MQ_CLK_VPU_CG] =3D imx_clk_gate3("vpu_cg", "vpu_src", base + 0x8=
100, 28);
+	clks[IMX8MQ_CLK_GPU_CORE_CG] =3D imx_clk_gate3("gpu_core_cg", "gpu_core_s=
rc", base + 0x8180, 28);
+	clks[IMX8MQ_CLK_GPU_SHADER_CG] =3D imx_clk_gate3("gpu_shader_cg", "gpu_sh=
ader_src", base + 0x8200, 28);
+
+	clks[IMX8MQ_CLK_A53_DIV] =3D imx_clk_divider2("arm_a53_div", "arm_a53_cg"=
, base + 0x8000, 0, 3);
+	clks[IMX8MQ_CLK_VPU_DIV] =3D imx_clk_divider2("vpu_div", "vpu_cg", base +=
 0x8100, 0, 3);
+	clks[IMX8MQ_CLK_GPU_CORE_DIV] =3D imx_clk_divider2("gpu_core_div", "gpu_c=
ore_cg", base + 0x8180, 0, 3);
+	clks[IMX8MQ_CLK_GPU_SHADER_DIV] =3D imx_clk_divider2("gpu_shader_div", "g=
pu_shader_cg", base + 0x8200, 0, 3);
+
+	/* BUS */
+	clks[IMX8MQ_CLK_MAIN_AXI] =3D imx_clk_composite_8m_critical("main_axi", i=
mx8mq_main_axi_sels, base + 0x8800);
+	clks[IMX8MQ_CLK_ENET_AXI] =3D imx_clk_composite_8m("enet_axi", imx8mq_ene=
t_axi_sels, base + 0x8880);
+	clks[IMX8MQ_CLK_NAND_USDHC_BUS] =3D imx_clk_composite_8m("nand_usdhc_bus"=
, imx8mq_nand_usdhc_sels, base + 0x8900);
+	clks[IMX8MQ_CLK_VPU_BUS] =3D imx_clk_composite_8m("vpu_bus", imx8mq_vpu_b=
us_sels, base + 0x8980);
+	clks[IMX8MQ_CLK_DISP_AXI] =3D imx_clk_composite_8m("disp_axi", imx8mq_dis=
p_axi_sels, base + 0x8a00);
+	clks[IMX8MQ_CLK_DISP_APB] =3D imx_clk_composite_8m("disp_apb", imx8mq_dis=
p_apb_sels, base + 0x8a80);
+	clks[IMX8MQ_CLK_DISP_RTRM] =3D imx_clk_composite_8m("disp_rtrm", imx8mq_d=
isp_rtrm_sels, base + 0x8b00);
+	clks[IMX8MQ_CLK_USB_BUS] =3D imx_clk_composite_8m("usb_bus", imx8mq_usb_b=
us_sels, base + 0x8b80);
+	clks[IMX8MQ_CLK_GPU_AXI] =3D imx_clk_composite_8m("gpu_axi", imx8mq_gpu_a=
xi_sels, base + 0x8c00);
+	clks[IMX8MQ_CLK_GPU_AHB] =3D imx_clk_composite_8m("gpu_ahb", imx8mq_gpu_a=
hb_sels, base + 0x8c80);
+	clks[IMX8MQ_CLK_NOC] =3D imx_clk_composite_8m_critical("noc", imx8mq_noc_=
sels, base + 0x8d00);
+	clks[IMX8MQ_CLK_NOC_APB] =3D imx_clk_composite_8m_critical("noc_apb", imx=
8mq_noc_apb_sels, base + 0x8d80);
+
+	/* AHB */
+	clks[IMX8MQ_CLK_AHB] =3D imx_clk_composite_8m("ahb", imx8mq_ahb_sels, bas=
e + 0x9000);
+	clks[IMX8MQ_CLK_AUDIO_AHB] =3D imx_clk_composite_8m("audio_ahb", imx8mq_a=
udio_ahb_sels, base + 0x9100);
+
+	/* IPG */
+	clks[IMX8MQ_CLK_IPG_ROOT] =3D imx_clk_divider2("ipg_root", "ahb", base + =
0x9080, 0, 1);
+	clks[IMX8MQ_CLK_IPG_AUDIO_ROOT] =3D imx_clk_divider2("ipg_audio_root", "a=
udio_ahb", base + 0x9180, 0, 1);
+
+	/* IP */
+	clks[IMX8MQ_CLK_DRAM_CORE] =3D imx_clk_mux2_flags("dram_core_clk", base +=
 0x9800, 24, 1, imx8mq_dram_core_sels, ARRAY_SIZE(imx8mq_dram_core_sels), C=
LK_IS_CRITICAL);
+
+	clks[IMX8MQ_CLK_DRAM_ALT] =3D imx_clk_composite_8m("dram_alt", imx8mq_dra=
m_alt_sels, base + 0xa000);
+	clks[IMX8MQ_CLK_DRAM_APB] =3D imx_clk_composite_8m_critical("dram_apb", i=
mx8mq_dram_apb_sels, base + 0xa080);
+	clks[IMX8MQ_CLK_VPU_G1] =3D imx_clk_composite_8m("vpu_g1", imx8mq_vpu_g1_=
sels, base + 0xa100);
+	clks[IMX8MQ_CLK_VPU_G2] =3D imx_clk_composite_8m("vpu_g2", imx8mq_vpu_g2_=
sels, base + 0xa180);
+	clks[IMX8MQ_CLK_DISP_DTRC] =3D imx_clk_composite_8m("disp_dtrc", imx8mq_d=
isp_dtrc_sels, base + 0xa200);
+	clks[IMX8MQ_CLK_DISP_DC8000] =3D imx_clk_composite_8m("disp_dc8000", imx8=
mq_disp_dc8000_sels, base + 0xa280);
+	clks[IMX8MQ_CLK_PCIE1_CTRL] =3D imx_clk_composite_8m("pcie1_ctrl", imx8mq=
_pcie1_ctrl_sels, base + 0xa300);
+	clks[IMX8MQ_CLK_PCIE1_PHY] =3D imx_clk_composite_8m("pcie1_phy", imx8mq_p=
cie1_phy_sels, base + 0xa380);
+	clks[IMX8MQ_CLK_PCIE1_AUX] =3D imx_clk_composite_8m("pcie1_aux", imx8mq_p=
cie1_aux_sels, base + 0xa400);
+	clks[IMX8MQ_CLK_DC_PIXEL] =3D imx_clk_composite_8m("dc_pixel", imx8mq_dc_=
pixel_sels, base + 0xa480);
+	clks[IMX8MQ_CLK_LCDIF_PIXEL] =3D imx_clk_composite_8m("lcdif_pixel", imx8=
mq_lcdif_pixel_sels, base + 0xa500);
+	clks[IMX8MQ_CLK_SAI1] =3D imx_clk_composite_8m("sai1", imx8mq_sai1_sels, =
base + 0xa580);
+	clks[IMX8MQ_CLK_SAI2] =3D imx_clk_composite_8m("sai2", imx8mq_sai2_sels, =
base + 0xa600);
+	clks[IMX8MQ_CLK_SAI3] =3D imx_clk_composite_8m("sai3", imx8mq_sai3_sels, =
base + 0xa680);
+	clks[IMX8MQ_CLK_SAI4] =3D imx_clk_composite_8m("sai4", imx8mq_sai4_sels, =
base + 0xa700);
+	clks[IMX8MQ_CLK_SAI5] =3D imx_clk_composite_8m("sai5", imx8mq_sai5_sels, =
base + 0xa780);
+	clks[IMX8MQ_CLK_SAI6] =3D imx_clk_composite_8m("sai6", imx8mq_sai6_sels, =
base + 0xa800);
+	clks[IMX8MQ_CLK_SPDIF1] =3D imx_clk_composite_8m("spdif1", imx8mq_spdif1_=
sels, base + 0xa880);
+	clks[IMX8MQ_CLK_SPDIF2] =3D imx_clk_composite_8m("spdif2", imx8mq_spdif2_=
sels, base + 0xa900);
+	clks[IMX8MQ_CLK_ENET_REF] =3D imx_clk_composite_8m("enet_ref", imx8mq_ene=
t_ref_sels, base + 0xa980);
+	clks[IMX8MQ_CLK_ENET_TIMER] =3D imx_clk_composite_8m("enet_timer", imx8mq=
_enet_timer_sels, base + 0xaa00);
+	clks[IMX8MQ_CLK_ENET_PHY_REF] =3D imx_clk_composite_8m("enet_phy", imx8mq=
_enet_phy_sels, base + 0xaa80);
+	clks[IMX8MQ_CLK_NAND] =3D imx_clk_composite_8m("nand", imx8mq_nand_sels, =
base + 0xab00);
+	clks[IMX8MQ_CLK_QSPI] =3D imx_clk_composite_8m("qspi", imx8mq_qspi_sels, =
base + 0xab80);
+	clks[IMX8MQ_CLK_USDHC1] =3D imx_clk_composite_8m("usdhc1", imx8mq_usdhc1_=
sels, base + 0xac00);
+	clks[IMX8MQ_CLK_USDHC2] =3D imx_clk_composite_8m("usdhc2", imx8mq_usdhc2_=
sels, base + 0xac80);
+	clks[IMX8MQ_CLK_I2C1] =3D imx_clk_composite_8m("i2c1", imx8mq_i2c1_sels, =
base + 0xad00);
+	clks[IMX8MQ_CLK_I2C2] =3D imx_clk_composite_8m("i2c2", imx8mq_i2c2_sels, =
base + 0xad80);
+	clks[IMX8MQ_CLK_I2C3] =3D imx_clk_composite_8m("i2c3", imx8mq_i2c3_sels, =
base + 0xae00);
+	clks[IMX8MQ_CLK_I2C4] =3D imx_clk_composite_8m("i2c4", imx8mq_i2c4_sels, =
base + 0xae80);
+	clks[IMX8MQ_CLK_UART1] =3D imx_clk_composite_8m("uart1", imx8mq_uart1_sel=
s, base + 0xaf00);
+	clks[IMX8MQ_CLK_UART2] =3D imx_clk_composite_8m("uart2", imx8mq_uart2_sel=
s, base + 0xaf80);
+	clks[IMX8MQ_CLK_UART3] =3D imx_clk_composite_8m("uart3", imx8mq_uart3_sel=
s, base + 0xb000);
+	clks[IMX8MQ_CLK_UART4] =3D imx_clk_composite_8m("uart4", imx8mq_uart4_sel=
s, base + 0xb080);
+	clks[IMX8MQ_CLK_USB_CORE_REF] =3D imx_clk_composite_8m("usb_core_ref", im=
x8mq_usb_core_sels, base + 0xb100);
+	clks[IMX8MQ_CLK_USB_PHY_REF] =3D imx_clk_composite_8m("usb_phy_ref", imx8=
mq_usb_phy_sels, base + 0xb180);
+	clks[IMX8MQ_CLK_ECSPI1] =3D imx_clk_composite_8m("ecspi1", imx8mq_ecspi1_=
sels, base + 0xb280);
+	clks[IMX8MQ_CLK_ECSPI2] =3D imx_clk_composite_8m("ecspi2", imx8mq_ecspi2_=
sels, base + 0xb300);
+	clks[IMX8MQ_CLK_PWM1] =3D imx_clk_composite_8m("pwm1", imx8mq_pwm1_sels, =
base + 0xb380);
+	clks[IMX8MQ_CLK_PWM2] =3D imx_clk_composite_8m("pwm2", imx8mq_pwm2_sels, =
base + 0xb400);
+	clks[IMX8MQ_CLK_PWM3] =3D imx_clk_composite_8m("pwm3", imx8mq_pwm3_sels, =
base + 0xb480);
+	clks[IMX8MQ_CLK_PWM4] =3D imx_clk_composite_8m("pwm4", imx8mq_pwm4_sels, =
base + 0xb500);
+	clks[IMX8MQ_CLK_GPT1] =3D imx_clk_composite_8m("gpt1", imx8mq_gpt1_sels, =
base + 0xb580);
+	clks[IMX8MQ_CLK_WDOG] =3D imx_clk_composite_8m("wdog", imx8mq_wdog_sels, =
base + 0xb900);
+	clks[IMX8MQ_CLK_WRCLK] =3D imx_clk_composite_8m("wrclk", imx8mq_wrclk_sel=
s, base + 0xb980);
+	clks[IMX8MQ_CLK_CLKO2] =3D imx_clk_composite_8m("clko2", imx8mq_clko2_sel=
s, base + 0xba80);
+	clks[IMX8MQ_CLK_DSI_CORE] =3D imx_clk_composite_8m("dsi_core", imx8mq_dsi=
_core_sels, base + 0xbb00);
+	clks[IMX8MQ_CLK_DSI_PHY_REF] =3D imx_clk_composite_8m("dsi_phy_ref", imx8=
mq_dsi_phy_sels, base + 0xbb80);
+	clks[IMX8MQ_CLK_DSI_DBI] =3D imx_clk_composite_8m("dsi_dbi", imx8mq_dsi_d=
bi_sels, base + 0xbc00);
+	clks[IMX8MQ_CLK_DSI_ESC] =3D imx_clk_composite_8m("dsi_esc", imx8mq_dsi_e=
sc_sels, base + 0xbc80);
+	clks[IMX8MQ_CLK_DSI_AHB] =3D imx_clk_composite_8m("dsi_ahb", imx8mq_dsi_a=
hb_sels, base + 0x9200);
+	clks[IMX8MQ_CLK_CSI1_CORE] =3D imx_clk_composite_8m("csi1_core", imx8mq_c=
si1_core_sels, base + 0xbd00);
+	clks[IMX8MQ_CLK_CSI1_PHY_REF] =3D imx_clk_composite_8m("csi1_phy_ref", im=
x8mq_csi1_phy_sels, base + 0xbd80);
+	clks[IMX8MQ_CLK_CSI1_ESC] =3D imx_clk_composite_8m("csi1_esc", imx8mq_csi=
1_esc_sels, base + 0xbe00);
+	clks[IMX8MQ_CLK_CSI2_CORE] =3D imx_clk_composite_8m("csi2_core", imx8mq_c=
si2_core_sels, base + 0xbe80);
+	clks[IMX8MQ_CLK_CSI2_PHY_REF] =3D imx_clk_composite_8m("csi2_phy_ref", im=
x8mq_csi2_phy_sels, base + 0xbf00);
+	clks[IMX8MQ_CLK_CSI2_ESC] =3D imx_clk_composite_8m("csi2_esc", imx8mq_csi=
2_esc_sels, base + 0xbf80);
+	clks[IMX8MQ_CLK_PCIE2_CTRL] =3D imx_clk_composite_8m("pcie2_ctrl", imx8mq=
_pcie2_ctrl_sels, base + 0xc000);
+	clks[IMX8MQ_CLK_PCIE2_PHY] =3D imx_clk_composite_8m("pcie2_phy", imx8mq_p=
cie2_phy_sels, base + 0xc080);
+	clks[IMX8MQ_CLK_PCIE2_AUX] =3D imx_clk_composite_8m("pcie2_aux", imx8mq_p=
cie2_aux_sels, base + 0xc100);
+	clks[IMX8MQ_CLK_ECSPI3] =3D imx_clk_composite_8m("ecspi3", imx8mq_ecspi3_=
sels, base + 0xc180);
+
+	/*FIXME, the doc is not ready now */
+	clks[IMX8MQ_CLK_ECSPI1_ROOT] =3D imx_clk_gate4("ecspi1_root_clk", "ecspi1=
", base + 0x4070, 0);
+	clks[IMX8MQ_CLK_ECSPI2_ROOT] =3D imx_clk_gate4("ecspi2_root_clk", "ecspi2=
", base + 0x4080, 0);
+	clks[IMX8MQ_CLK_ECSPI3_ROOT] =3D imx_clk_gate4("ecspi3_root_clk", "ecspi3=
", base + 0x4090, 0);
+	clks[IMX8MQ_CLK_ENET1_ROOT] =3D imx_clk_gate4("enet1_root_clk", "enet_axi=
", base + 0x40a0, 0);
+	clks[IMX8MQ_CLK_GPT1_ROOT] =3D imx_clk_gate4("gpt1_root_clk", "gpt1", bas=
e + 0x4100, 0);
+	clks[IMX8MQ_CLK_I2C1_ROOT] =3D imx_clk_gate4("i2c1_root_clk", "i2c1", bas=
e + 0x4170, 0);
+	clks[IMX8MQ_CLK_I2C2_ROOT] =3D imx_clk_gate4("i2c2_root_clk", "i2c2", bas=
e + 0x4180, 0);
+	clks[IMX8MQ_CLK_I2C3_ROOT] =3D imx_clk_gate4("i2c3_root_clk", "i2c3", bas=
e + 0x4190, 0);
+	clks[IMX8MQ_CLK_I2C4_ROOT] =3D imx_clk_gate4("i2c4_root_clk", "i2c4", bas=
e + 0x41a0, 0);
+	clks[IMX8MQ_CLK_MU_ROOT] =3D imx_clk_gate4("mu_root_clk", "ipg_root", bas=
e + 0x4210, 0);
+	clks[IMX8MQ_CLK_OCOTP_ROOT] =3D imx_clk_gate4("ocotp_root_clk", "ipg_root=
", base + 0x4220, 0);
+	clks[IMX8MQ_CLK_PCIE1_ROOT] =3D imx_clk_gate4("pcie1_root_clk", "pcie1_ct=
rl", base + 0x4250, 0);
+	clks[IMX8MQ_CLK_PCIE2_ROOT] =3D imx_clk_gate4("pcie2_root_clk", "pcie2_ct=
rl", base + 0x4640, 0);
+	clks[IMX8MQ_CLK_PWM1_ROOT] =3D imx_clk_gate4("pwm1_root_clk", "pwm1", bas=
e + 0x4280, 0);
+	clks[IMX8MQ_CLK_PWM2_ROOT] =3D imx_clk_gate4("pwm2_root_clk", "pwm2", bas=
e + 0x4290, 0);
+	clks[IMX8MQ_CLK_PWM3_ROOT] =3D imx_clk_gate4("pwm3_root_clk", "pwm3", bas=
e + 0x42a0, 0);
+	clks[IMX8MQ_CLK_PWM4_ROOT] =3D imx_clk_gate4("pwm4_root_clk", "pwm4", bas=
e + 0x42b0, 0);
+	clks[IMX8MQ_CLK_QSPI_ROOT] =3D imx_clk_gate4("qspi_root_clk", "qspi", bas=
e + 0x42f0, 0);
+	clks[IMX8MQ_CLK_RAWNAND_ROOT] =3D imx_clk_gate2_shared2("nand_root_clk", =
"nand", base + 0x4300, 0, &share_count_nand);
+	clks[IMX8MQ_CLK_NAND_USDHC_BUS_RAWNAND_CLK] =3D imx_clk_gate2_shared2("na=
nd_usdhc_rawnand_clk", "nand_usdhc_bus", base + 0x4300, 0, &share_count_nan=
d);
+	clks[IMX8MQ_CLK_SAI1_ROOT] =3D imx_clk_gate2_shared2("sai1_root_clk", "sa=
i1", base + 0x4330, 0, &share_count_sai1);
+	clks[IMX8MQ_CLK_SAI1_IPG] =3D imx_clk_gate2_shared2("sai1_ipg_clk", "ipg_=
audio_root", base + 0x4330, 0, &share_count_sai1);
+	clks[IMX8MQ_CLK_SAI2_ROOT] =3D imx_clk_gate2_shared2("sai2_root_clk", "sa=
i2", base + 0x4340, 0, &share_count_sai2);
+	clks[IMX8MQ_CLK_SAI2_IPG] =3D imx_clk_gate2_shared2("sai2_ipg_clk", "ipg_=
root", base + 0x4340, 0, &share_count_sai2);
+	clks[IMX8MQ_CLK_SAI3_ROOT] =3D imx_clk_gate2_shared2("sai3_root_clk", "sa=
i3", base + 0x4350, 0, &share_count_sai3);
+	clks[IMX8MQ_CLK_SAI3_IPG] =3D imx_clk_gate2_shared2("sai3_ipg_clk", "ipg_=
root", base + 0x4350, 0, &share_count_sai3);
+	clks[IMX8MQ_CLK_SAI4_ROOT] =3D imx_clk_gate2_shared2("sai4_root_clk", "sa=
i4", base + 0x4360, 0, &share_count_sai4);
+	clks[IMX8MQ_CLK_SAI4_IPG] =3D imx_clk_gate2_shared2("sai4_ipg_clk", "ipg_=
audio_root", base + 0x4360, 0, &share_count_sai4);
+	clks[IMX8MQ_CLK_SAI5_ROOT] =3D imx_clk_gate2_shared2("sai5_root_clk", "sa=
i5", base + 0x4370, 0, &share_count_sai5);
+	clks[IMX8MQ_CLK_SAI5_IPG] =3D imx_clk_gate2_shared2("sai5_ipg_clk", "ipg_=
audio_root", base + 0x4370, 0, &share_count_sai5);
+	clks[IMX8MQ_CLK_SAI6_ROOT] =3D imx_clk_gate2_shared2("sai6_root_clk", "sa=
i6", base + 0x4380, 0, &share_count_sai6);
+	clks[IMX8MQ_CLK_SAI6_IPG] =3D imx_clk_gate2_shared2("sai6_ipg_clk", "ipg_=
audio_root", base + 0x4380, 0, &share_count_sai6);
+	clks[IMX8MQ_CLK_UART1_ROOT] =3D imx_clk_gate4("uart1_root_clk", "uart1", =
base + 0x4490, 0);
+	clks[IMX8MQ_CLK_UART2_ROOT] =3D imx_clk_gate4("uart2_root_clk", "uart2", =
base + 0x44a0, 0);
+	clks[IMX8MQ_CLK_UART3_ROOT] =3D imx_clk_gate4("uart3_root_clk", "uart3", =
base + 0x44b0, 0);
+	clks[IMX8MQ_CLK_UART4_ROOT] =3D imx_clk_gate4("uart4_root_clk", "uart4", =
base + 0x44c0, 0);
+	clks[IMX8MQ_CLK_USB1_CTRL_ROOT] =3D imx_clk_gate4("usb1_ctrl_root_clk", "=
usb_core_ref", base + 0x44d0, 0);
+	clks[IMX8MQ_CLK_USB2_CTRL_ROOT] =3D imx_clk_gate4("usb2_ctrl_root_clk", "=
usb_core_ref", base + 0x44e0, 0);
+	clks[IMX8MQ_CLK_USB1_PHY_ROOT] =3D imx_clk_gate4("usb1_phy_root_clk", "us=
b_phy_ref", base + 0x44f0, 0);
+	clks[IMX8MQ_CLK_USB2_PHY_ROOT] =3D imx_clk_gate4("usb2_phy_root_clk", "us=
b_phy_ref", base + 0x4500, 0);
+	clks[IMX8MQ_CLK_USDHC1_ROOT] =3D imx_clk_gate4("usdhc1_root_clk", "usdhc1=
", base + 0x4510, 0);
+	clks[IMX8MQ_CLK_USDHC2_ROOT] =3D imx_clk_gate4("usdhc2_root_clk", "usdhc2=
", base + 0x4520, 0);
+	clks[IMX8MQ_CLK_WDOG1_ROOT] =3D imx_clk_gate4("wdog1_root_clk", "wdog", b=
ase + 0x4530, 0);
+	clks[IMX8MQ_CLK_WDOG2_ROOT] =3D imx_clk_gate4("wdog2_root_clk", "wdog", b=
ase + 0x4540, 0);
+	clks[IMX8MQ_CLK_WDOG3_ROOT] =3D imx_clk_gate4("wdog3_root_clk", "wdog", b=
ase + 0x4550, 0);
+	clks[IMX8MQ_CLK_VPU_G1_ROOT] =3D imx_clk_gate2_flags("vpu_g1_root_clk", "=
vpu_g1", base + 0x4560, 0, CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
+	clks[IMX8MQ_CLK_GPU_ROOT] =3D imx_clk_gate4("gpu_root_clk", "gpu_core_div=
", base + 0x4570, 0);
+	clks[IMX8MQ_CLK_VPU_G2_ROOT] =3D imx_clk_gate2_flags("vpu_g2_root_clk", "=
vpu_g2", base + 0x45a0, 0, CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
+	clks[IMX8MQ_CLK_DISP_ROOT] =3D imx_clk_gate2_shared2("disp_root_clk", "di=
sp_dc8000", base + 0x45d0, 0, &share_count_dcss);
+	clks[IMX8MQ_CLK_DISP_AXI_ROOT]  =3D imx_clk_gate2_shared2("disp_axi_root_=
clk", "disp_axi", base + 0x45d0, 0, &share_count_dcss);
+	clks[IMX8MQ_CLK_DISP_APB_ROOT]  =3D imx_clk_gate2_shared2("disp_apb_root_=
clk", "disp_apb", base + 0x45d0, 0, &share_count_dcss);
+	clks[IMX8MQ_CLK_DISP_RTRM_ROOT] =3D imx_clk_gate2_shared2("disp_rtrm_root=
_clk", "disp_rtrm", base + 0x45d0, 0, &share_count_dcss);
+	clks[IMX8MQ_CLK_TMU_ROOT] =3D imx_clk_gate4_flags("tmu_root_clk", "ipg_ro=
ot", base + 0x4620, 0, CLK_IS_CRITICAL);
+	clks[IMX8MQ_CLK_VPU_DEC_ROOT] =3D imx_clk_gate2_flags("vpu_dec_root_clk",=
 "vpu_bus", base + 0x4630, 0, CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE);
+	clks[IMX8MQ_CLK_CSI1_ROOT] =3D imx_clk_gate4("csi1_root_clk", "csi1_core"=
, base + 0x4650, 0);
+	clks[IMX8MQ_CLK_CSI2_ROOT] =3D imx_clk_gate4("csi2_root_clk", "csi2_core"=
, base + 0x4660, 0);
+	clks[IMX8MQ_CLK_SDMA1_ROOT] =3D imx_clk_gate4("sdma1_clk", "ipg_root", ba=
se + 0x43a0, 0);
+	clks[IMX8MQ_CLK_SDMA2_ROOT] =3D imx_clk_gate4("sdma2_clk", "ipg_audio_roo=
t", base + 0x43b0, 0);
+
+	clks[IMX8MQ_GPT_3M_CLK] =3D imx_clk_fixed_factor("gpt_3m", "osc_25m", 1, =
8);
+	clks[IMX8MQ_CLK_DRAM_ALT_ROOT] =3D imx_clk_fixed_factor("dram_alt_root", =
"dram_alt", 1, 4);
+
+	for (i =3D 0; i < IMX8MQ_CLK_END; i++)
+		if (IS_ERR(clks[i]))
+			pr_err("i.MX8mq clk %u register failed with %ld\n",
+			       i, PTR_ERR(clks[i]));
+
+	clk_data.clks =3D clks;
+	clk_data.clk_num =3D ARRAY_SIZE(clks);
+	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
+
+	clk_set_parent(clks[IMX8MQ_CLK_AHB], clks[IMX8MQ_SYS1_PLL_133M]);
+	clk_set_parent(clks[IMX8MQ_CLK_NAND_USDHC_BUS], clks[IMX8MQ_SYS1_PLL_266M=
]);
+	clk_set_parent(clks[IMX8MQ_CLK_AUDIO_AHB], clks[IMX8MQ_SYS2_PLL_500M]);
+
+	/* config video_pll1 clock */
+	clk_set_parent(clks[IMX8MQ_VIDEO_PLL1_REF_SEL], clks[IMX8MQ_CLK_27M]);
+	clk_set_rate(clks[IMX8MQ_VIDEO_PLL1], 593999999);
+
+	/* increase NOC clock to achieve best DDR access performance */
+	clk_set_rate(clks[IMX8MQ_CLK_NOC], clk_get_rate(clks[IMX8MQ_SYS1_PLL_800M=
]));
+
+	/* set pcie root's parent clk source */
+	clk_set_parent(clks[IMX8MQ_CLK_PCIE1_CTRL], clks[IMX8MQ_SYS2_PLL_250M]);
+	clk_set_parent(clks[IMX8MQ_CLK_PCIE1_PHY], clks[IMX8MQ_SYS2_PLL_100M]);
+	clk_set_parent(clks[IMX8MQ_CLK_PCIE2_CTRL], clks[IMX8MQ_SYS2_PLL_250M]);
+	clk_set_parent(clks[IMX8MQ_CLK_PCIE2_PHY], clks[IMX8MQ_SYS2_PLL_100M]);
+
+	clk_set_parent(clks[IMX8MQ_CLK_CSI1_CORE], clks[IMX8MQ_SYS1_PLL_266M]);
+	clk_set_parent(clks[IMX8MQ_CLK_CSI1_PHY_REF], clks[IMX8MQ_SYS2_PLL_1000M]=
);
+	clk_set_parent(clks[IMX8MQ_CLK_CSI1_ESC], clks[IMX8MQ_SYS1_PLL_800M]);
+	clk_set_parent(clks[IMX8MQ_CLK_CSI2_CORE], clks[IMX8MQ_SYS1_PLL_266M]);
+	clk_set_parent(clks[IMX8MQ_CLK_CSI2_PHY_REF], clks[IMX8MQ_SYS2_PLL_1000M]=
);
+	clk_set_parent(clks[IMX8MQ_CLK_CSI2_ESC], clks[IMX8MQ_SYS1_PLL_800M]);
+}
+
+CLK_OF_DECLARE(imx8mq, "fsl,imx8mq-ccm", imx8mq_clocks_init);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 37c8c4a..0729c65 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -128,6 +128,15 @@ static inline struct clk *imx_clk_divider2(const char =
*name, const char *parent,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
=20
+static inline struct clk *imx_clk_divider2_flags(const char *name,
+		const char *parent, void __iomem *reg, u8 shift, u8 width,
+		unsigned long flags)
+{
+	return clk_register_divider(NULL, name, parent,
+			flags | CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
+			reg, shift, width, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_gate(const char *name, const char *paren=
t,
 		void __iomem *reg, u8 shift)
 {
@@ -195,6 +204,15 @@ static inline struct clk *imx_clk_gate3(const char *na=
me, const char *parent,
 			reg, shift, 0, &imx_ccm_lock);
 }
=20
+static inline struct clk *imx_clk_gate3_flags(const char *name,
+		const char *parent, void __iomem *reg, u8 shift,
+		unsigned long flags)
+{
+	return clk_register_gate(NULL, name, parent,
+			flags | CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
+			reg, shift, 0, &imx_ccm_lock);
+}
+
 static inline struct clk *imx_clk_gate4(const char *name, const char *pare=
nt,
 		void __iomem *reg, u8 shift)
 {
@@ -203,6 +221,15 @@ static inline struct clk *imx_clk_gate4(const char *na=
me, const char *parent,
 			reg, shift, 0x3, 0, &imx_ccm_lock, NULL);
 }
=20
+static inline struct clk *imx_clk_gate4_flags(const char *name,
+		const char *parent, void __iomem *reg, u8 shift,
+		unsigned long flags)
+{
+	return clk_register_gate2(NULL, name, parent,
+			flags | CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
+			reg, shift, 0x3, 0, &imx_ccm_lock, NULL);
+}
+
 static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
 		u8 shift, u8 width, const char **parents, int num_parents)
 {
@@ -228,6 +255,15 @@ static inline struct clk *imx_clk_mux_flags(const char=
 *name,
 			&imx_ccm_lock);
 }
=20
+static inline struct clk *imx_clk_mux2_flags(const char *name,
+		void __iomem *reg, u8 shift, u8 width, const char **parents,
+		int num_parents, unsigned long flags)
+{
+	return clk_register_mux(NULL, name, parents, num_parents,
+			flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE,
+			reg, shift, width, 0, &imx_ccm_lock);
+}
+
 struct clk *imx_clk_cpu(const char *name, const char *parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
--=20
2.7.4

