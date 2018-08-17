Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98B2C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0902185A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UXx5E+xV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0902185A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeHQRPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:15:16 -0400
Received: from mail-he1eur01on0045.outbound.protection.outlook.com ([104.47.0.45]:15904
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727410AbeHQRPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXf7qO38vaYskqGDfbVulsm2QujivvVj2Ne8jKVWVAk=;
 b=UXx5E+xVCUhdZua6V1QgUSlgLCpW8YR6oyKNa8/xs2batOORacimQOCFvaQ+mdISzfzzjcipBCaxysk0AJnVJW3KsyXgVfMH6dKss7hN5+QLS97u+2hbSIGO0D68wrRjtArn0cxM92tonY/IOWBGvPbEAQgUcPPaDCSqmga0gXE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 AM4PR04MB1601.eurprd04.prod.outlook.com (2a01:111:e400:59e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.23; Fri, 17 Aug
 2018 14:11:29 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Cc:     linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v5 3/5] clk: imx: add SCCG PLL type
Date:   Fri, 17 Aug 2018 17:10:44 +0300
Message-Id: <1534515046-18529-4-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534515046-18529-1-git-send-email-abel.vesa@nxp.com>
References: <1534515046-18529-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1PR05CA0200.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::24) To AM4PR04MB1601.eurprd04.prod.outlook.com
 (2a01:111:e400:59e5::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1c4c3c8-5366-4b8c-1459-08d6044b54e0
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR04MB1601;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;3:qF6RDWJGHUMgj55ZhTeZTcGbdQL2QrXMeQMdGHtjIni4rrXQw5+0PkQwKrEVZXUuzlZpyTQpL1Q7ZY836rnAfTaM48P9gOH1msKiYDmET1w7Y0dgLzy1JlBaZ3rY4wOxtCP+pRnO6/gmpxnZ3wGQogFowyDbOOhYQuY8faGDvNVBBLB8/RW3cOqnwdHjXpK/3i+fVZ7qKDDiTtOvxK8ipDqgh3A9PveBFnNuI0XJBMCpmtKwzPD/QAZ4KF7ejYiR;25:830q38nVaixm7YXgzVXGUyDiK4l0WGN4XIhakfITsy3qiMy1h4DA4MTbA+0+tYRf9vT1/B2nduNoRBrQ+qiS+S8J/NxQj+9z+w1imlcULyFFhNF6k/u9kaFKMifut7JBxqXBTZ6CVQwuxzVr0/E8hJDn4jCSNY7H2G2NAp96nyPPhG/wHZrYHprEX4oWP5tIZP6eAV630BreB+CGqwVpdfg+889mveY0q9MOSRmfpZu3WAvHI25rgUDjHrJE6+4tZYNfjgTBq923x9t2mFwRJV2G+d6tATK2QR7jIFkXd3DEwcyqzB+IP2p93HwTaxJKP84ows/ZDPY58NPGh6WhRg==;31:3sEo48tRf7CMmrvBP099bhCB0upkxd0xhRQjzNn2V5X86rXpybhl9ltoTJTn9klQ9oZEyyC7puFsNkpsLwaoSMIrbUk8Oj3O7unHceuT6c0FtNeHn9Qneb4MQqBr7sUiHYo+BGpXDYH+VPSbeTjm4y1X3Z0bdnrYwTZghZnRY0RrLceDV2IGY7Qc140b8azn2vfshoi9ptrBxdM2SW/l1au17VY3pvUM/mkZEDakj50=
X-MS-TrafficTypeDiagnostic: AM4PR04MB1601:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;20:inxEtBNZLduoCdfv9sd+TzSGFLmKYR/I3qKh206QoZW8SwjfI+c+CKV24jgtbO77G63HuRlTRTcLW/KkxeoSIGrXnsidqzFOSiGDXH16KGHtaKeGJtMpsUnmJEA6PO4bd9kupzHR+OtzC6Is6ep9/I5BuCEtc2E5bS1ZpmH0PN8k1ziYoyJyuq8i7/W4VqTGzGi+JxpqlKTG/P83oPOjiN10vKbhiaBBCsuLwOZtR5UiNTYmX4mjvYuzCA9LCcUOe2kBKy+anzcMN0bOe4Z/HS+aNIzBj9qq8/dB+MX2X1CJu4nsN1DNDxaT5OE9gtZyp5AtBQDcrrp4zCE3dg84D71r4ZKx88uhIuzapP2S9cRkU0tAgaotXACht5DnvAXLd3DzTgLRlsImG2dRACzQtv7qQSkk5ScPZ5/SuiVEhZuNvXZ74R4PIj1YJmql4qJevqZ0ytznr1Q5j5JaJlxxUS2Dg8G2ADsgbrmH2+EHaMhQJktR4hWbum5A/rsTcOdE;4:h7TgtfbTvHpnw9u57QNyyKxm7nPC3trmmImfNl/0eKAZa/NAHMfbHk/jvBZb+Fh74Cr4ilXPSmO8+EER99C94q9rZBOsXusLm23FGfoPc8Nq1vDpMN0Q+WMV0kwLJtsX+R4z/knfZpONUtc/TW6PB9RqeKFvMvv4dZOT+XCbfJPrgiu7A4YfkEPaGjYH/Fnty+Ua7jC7cJ74oMUpjoQDcqGpZw/z549MWn4hP9nawP9lWNxPVgdaril938Ie7Pa2sYuBuDABqD975QRQWN1q3SJEPsVzBkcDPqjWd1NXTQGPqTGcjJ2S1ZefN4TsKT9S
X-Microsoft-Antispam-PRVS: <AM4PR04MB16012C3DC343D4E2EEEC1C37F63D0@AM4PR04MB1601.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301062)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:AM4PR04MB1601;BCL:0;PCL:0;RULEID:;SRVR:AM4PR04MB1601;
X-Forefront-PRVS: 076777155F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(396003)(39860400002)(376002)(199004)(189003)(50226002)(4326008)(50466002)(105586002)(51416003)(52116002)(6512007)(48376002)(76176011)(106356001)(86362001)(6116002)(6506007)(3846002)(68736007)(6486002)(36756003)(386003)(110136005)(478600001)(6636002)(97736004)(66066001)(7736002)(54906003)(956004)(25786009)(6666003)(14444005)(316002)(305945005)(16586007)(16526019)(5660300001)(217873002)(486006)(476003)(2616005)(26005)(7416002)(186003)(53936002)(2906002)(8676002)(81156014)(44832011)(446003)(8936002)(81166006)(47776003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR04MB1601;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR04MB1601;23:8jKHruNuCkcnMGuL0ttdPwEILGGcc4poXn++iWbZe?=
 =?us-ascii?Q?86hg2bL32sQOkiy2zTPUD6I45qkToCB8Bfeq50RD3gsE0QHRJVjchSUDwPTj?=
 =?us-ascii?Q?RIw3GehWfHvmsCVNmS+Yb5qkFLta4U+qOU3D0DDRyi86/BuE3HDucxKTgXkQ?=
 =?us-ascii?Q?Ic8ksU9IubJo+lCVUQ8hdcSaOaFTypqiv1QV6SsXyRT//VEYhlc1T0Il12Ej?=
 =?us-ascii?Q?ajqKTyWy7y8eYR96OnNTUmv6aV8pGmpbM1Sudi1syRmV6a2/7Lq6pTzQ+c+B?=
 =?us-ascii?Q?vt1M/KFlpA5gUjyA47+HShdW6iY4sziFSB3NjTVwEBTV+hjyfBx2qRKay8sv?=
 =?us-ascii?Q?reMoLam6pvZXhzPISZYU6Yqz0mgW0hDJ41j2Lf08Dgutp7QWV9NJLpHp49Pa?=
 =?us-ascii?Q?6IBRfArJUXkCm+2mpaGdQ7sNlON3XSURFbToewPYogQhsNlpCJQ3HeS40hWg?=
 =?us-ascii?Q?rspn/2WUb5iMUwXadjvg3Dtc+eRe4bwets8YTR6XfI1ubzli72X4Ed9J6o8+?=
 =?us-ascii?Q?mELG0kP3Ijmu3tuZhptYqY6IZucEVw3Sj41T9m+jRwef/eXFBgIu53Gf9f1z?=
 =?us-ascii?Q?KwX8He/Qufa2qJt9cH6Ax6vFmtq9LHLypnHxGUz85bxZjtKP2MtcbJrOZbm2?=
 =?us-ascii?Q?PvEp6hIezQVNIy1XqkLOxGDpRgdZ8KhUPICUICRegrKXRCJ4j0W+tq5jeyh9?=
 =?us-ascii?Q?a7bDhLch0wtm6Kg5EedBNtvVOQ2CZLxSrNeYNRjEkebQyNo0SRy/1/V81Elx?=
 =?us-ascii?Q?tQEs2NqHEJ3O4YcSsfDMIflc9lCbjxFp7eYLG9Rcod14Cyga8oTwru2lL1nN?=
 =?us-ascii?Q?BIQhcuxUjKuzpdpRbtZ2qQI1lYIaFGoNgBVbsEwaBEvRMvR6BU3TtgBrFDJ/?=
 =?us-ascii?Q?9ScAkSy7+y3l/oxfjrThu3lemxZ1fmB5trETOs1OYs6NiUqU7g/8HZZzpJ7s?=
 =?us-ascii?Q?uTznHPp8Ik1kisV7fNKRh7tXI0aqB0p/JqI+KU6BN+ouatrJ6JD6ab7tWu9k?=
 =?us-ascii?Q?5juwuwO1z6QX/ZHYFyvFFxg0UA63BuRM92iOd6hVcpHYb/oJF8uTDXrjad6s?=
 =?us-ascii?Q?gyhAZbPLf8ONBnSU1RaqPhIb+zMJoyR4oO5eDnVf2wE0eBJ0f7NhEWo8hBBV?=
 =?us-ascii?Q?0Ys95HyEcOUG8y+0+VrPhtkUBCDQWg7Pu2Ml5EpKEAjjNXstsPCYsgkvka0R?=
 =?us-ascii?Q?RBkwJewK74VQqd6BpUGW+ijB8eWzqZsVNxcB7OTNrjAbB4DVThGIVvUxxJlw?=
 =?us-ascii?Q?TZ24nia1lz94rQzQ60u+hA3IRCFwz5u4Nt9XXbWFZf2KSS9zQSdQVAmjS0wB?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: kko0eTwwu+i5t4gvQ5D/OH3tPNnYoI+KeCPzaataDW4qCgjT/dpRWl4HiUWkT9iywZaEt9jZBKGegMXyBBstRPh7llerI6XSjfyZJLiKvwWtSaHi/no54j5gHeNJwNSFC08L8PbTrMTX8DLm7VtiuBGv+jQ880/NyyLgYNjlPhWC161ZUfLuwHGWCTKr8311kRZSf34STPdq5CsP6i414zl64Viqmb0BpaGD0aVx2xKDcmeLJ65RNCwJSgiXkIYJV+GldnLuUK2acGA0iF+swDt2e+Xwl0IdZG7J9msprs4fd/+VWrLtqRMJ+pFaazoE22j5zevXqLfVdhvdvgXPAaT5C6pRTKYxcLda/WRlsBQ=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;6:5MpwLdmLvG+tB8wu85q0t2UBo5+NubTn1cqEgdxdOjJZX4u/pE55f+lFA5DaQvy1QEFoMNV1p+3PzOury/NOmrmf1KnPjZgFSBlh1KHSLs6+4YCfAoNrDmhAR949nzMmq1b5J7V077E9diXDkxc2f5M9BxVVrEiJoJJab6Akxour7yHc0OPPssIEeA4s7Y3RNzP+wGFHdop8Ztpm61TCJXuPIFdxL8bt/CWY0qDSdlo2guIQuxZVWvIWAcgOmJJMr5j1dfS3HZyIt4SvKUXU3uoQB9L9830K90gBBuemgmMxyudU6L84xyurY8pwcmm1XEd+fKuQulr7tTytD9kc4pzbgMzz6FcieqrB6FGC6qoaJPE4qhb0vUGCyohQi/wM48B2XazMPeS97qBCrui4aL4HK+1LtVtKlKkMmpzWOjU+uoL1sNKx3LNRY3WfmYOm5yvDBxAy+8ngnsaxEhacuQ==;5:nZxCAocziWOjPeHZXJeRU5LCE6TowFPCLzJU/940xPLpWpDh+gat13PxlpBPISO886uIQwQOZLd8CjwVE3kYL4ktUmNCbB8S3dS3GRoxUv6lLuZoOhXPeHx3/EcfxYBZ018SvaD7CLAY6m4fP4Pvyn7XHSGvLW5QwY3hSYGdYWc=;7:QqJqGy4jvp0IDQJx2w+6YsLUZTkAlDV8wNA0Pt4uUPsfQUk9mbhUpoqif4UfjtGoGawhrt1mh0Y/ibTdsOtBahdqRT4Uf0ZI24DKDp9uVeeLOtYNNTUMVx0zl1qtcTdgjDIJBJGEYChM/QhewCmruU++ng8UFTnuAu5/0LGqN/qwJJP/kIV8ctYsFzVt7WAGPmRuL3Xlp1Cf004KNDVzybahNMmx0v27cGGa+7q8lTAVtL1PB2mBqIV4Ts8G9r9T
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 14:11:29.5879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c4c3c8-5366-4b8c-1459-08d6044b54e0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR04MB1601
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

The SCCG is a new PLL type introduced on i.MX8. Add support for this.
The driver currently misses the PLL lock check, as the preliminary
documentation mentions lock configurations, but is quiet about where
to find the actual lock status signal.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/Makefile       |   3 +-
 drivers/clk/imx/clk-sccg-pll.c | 231 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h          |   9 ++
 3 files changed, 242 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/clk-sccg-pll.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 4893c1f..b87513c 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -12,7 +12,8 @@ obj-y += \
 	clk-pllv1.o \
 	clk-pllv2.o \
 	clk-pllv3.o \
-	clk-pfd.o
+	clk-pfd.o \
+	clk-sccg-pll.o
 
 obj-$(CONFIG_SOC_IMX1)   += clk-imx1.o
 obj-$(CONFIG_SOC_IMX21)  += clk-imx21.o
diff --git a/drivers/clk/imx/clk-sccg-pll.c b/drivers/clk/imx/clk-sccg-pll.c
new file mode 100644
index 0000000..886ae03
--- /dev/null
+++ b/drivers/clk/imx/clk-sccg-pll.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2018 NXP.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+
+#include "clk.h"
+
+/* PLL CFGs */
+#define PLL_CFG0	0x0
+#define PLL_CFG1	0x4
+#define PLL_CFG2	0x8
+
+#define PLL_DIVF1_SHIFT	13
+#define PLL_DIVF2_SHIFT	7
+#define PLL_DIVF_MASK	0x3f
+
+#define PLL_DIVR1_SHIFT	25
+#define PLL_DIVR2_SHIFT	19
+#define PLL_DIVR1_MASK	0x3
+#define PLL_DIVR2_MASK	0x3f
+#define PLL_REF_SHIFT	0
+#define PLL_REF_MASK	0x3
+
+#define PLL_LOCK	31
+#define PLL_PD		7
+
+#define OSC_25M		25000000
+#define OSC_27M		27000000
+
+struct clk_sccg_pll {
+	struct clk_hw	hw;
+	void __iomem	*base;
+};
+
+#define to_clk_sccg_pll(_hw) container_of(_hw, struct clk_sccg_pll, hw)
+
+static int clk_pll1_is_prepared(struct clk_hw *hw)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	return (val & (1 << PLL_PD)) ? 0 : 1;
+}
+
+static unsigned long clk_pll1_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val, divf;
+
+	val = readl_relaxed(pll->base + PLL_CFG2);
+	divf = (val >> PLL_DIVF1_SHIFT) & PLL_DIVF_MASK;
+
+	return parent_rate * 2 * (divf + 1);
+}
+
+static long clk_pll1_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	unsigned long parent_rate = *prate;
+	u32 div;
+
+	div = rate / (parent_rate * 2);
+
+	return parent_rate * div * 2;
+}
+
+static int clk_pll1_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+	u32 divf;
+
+	divf = rate / (parent_rate * 2);
+
+	val = readl_relaxed(pll->base + PLL_CFG2);
+	val &= ~(PLL_DIVF_MASK << PLL_DIVF1_SHIFT);
+	val |= (divf - 1) << PLL_DIVF1_SHIFT;
+	writel_relaxed(val, pll->base + PLL_CFG2);
+
+	/* FIXME: PLL lock check */
+
+	return 0;
+}
+
+static int clk_pll1_prepare(struct clk_hw *hw)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base);
+	val &= ~(1 << PLL_PD);
+	writel_relaxed(val, pll->base);
+
+	/* FIXME: PLL lock check */
+
+	return 0;
+}
+
+static void clk_pll1_unprepare(struct clk_hw *hw)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base);
+	val |= (1 << PLL_PD);
+	writel_relaxed(val, pll->base);
+}
+
+static unsigned long clk_pll2_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+	u32 val, ref, divr1, divf1, divr2, divf2;
+	u64 temp64;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	switch ((val >> PLL_REF_SHIFT) & PLL_REF_MASK) {
+	case 0:
+		ref = OSC_25M;
+		break;
+	case 1:
+		ref = OSC_27M;
+		break;
+	default:
+		ref = OSC_25M;
+		break;
+	}
+
+	val = readl_relaxed(pll->base + PLL_CFG2);
+	divr1 = (val >> PLL_DIVR1_SHIFT) & PLL_DIVR1_MASK;
+	divr2 = (val >> PLL_DIVR2_SHIFT) & PLL_DIVR2_MASK;
+	divf1 = (val >> PLL_DIVF1_SHIFT) & PLL_DIVF_MASK;
+	divf2 = (val >> PLL_DIVF2_SHIFT) & PLL_DIVF_MASK;
+
+	temp64 = ref * 2;
+	temp64 *= (divf1 + 1) * (divf2 + 1);
+
+	do_div(temp64, (divr1 + 1) * (divr2 + 1));
+
+	return (unsigned long)temp64;
+}
+
+static long clk_pll2_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	u32 div;
+	unsigned long parent_rate = *prate;
+
+	div = rate / (parent_rate);
+
+	return parent_rate * div;
+}
+
+static int clk_pll2_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	u32 val;
+	u32 divf;
+	struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
+
+	divf = rate / (parent_rate);
+
+	val = readl_relaxed(pll->base + PLL_CFG2);
+	val &= ~(PLL_DIVF_MASK << PLL_DIVF2_SHIFT);
+	val |= (divf - 1) << PLL_DIVF2_SHIFT;
+	writel_relaxed(val, pll->base + PLL_CFG2);
+
+	/* FIXME: PLL lock check */
+
+	return 0;
+}
+
+static const struct clk_ops clk_sccg_pll1_ops = {
+	.is_prepared	= clk_pll1_is_prepared,
+	.recalc_rate	= clk_pll1_recalc_rate,
+	.round_rate	= clk_pll1_round_rate,
+	.set_rate	= clk_pll1_set_rate,
+};
+
+static const struct clk_ops clk_sccg_pll2_ops = {
+	.prepare	= clk_pll1_prepare,
+	.unprepare	= clk_pll1_unprepare,
+	.recalc_rate	= clk_pll2_recalc_rate,
+	.round_rate	= clk_pll2_round_rate,
+	.set_rate	= clk_pll2_set_rate,
+};
+
+struct clk *imx_clk_sccg_pll(const char *name,
+				const char *parent_name,
+				void __iomem *base,
+				enum imx_sccg_pll_type pll_type)
+{
+	struct clk_sccg_pll *pll;
+	struct clk *clk;
+	struct clk_init_data init;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->base = base;
+	init.name = name;
+	switch (pll_type) {
+	case SCCG_PLL1:
+		init.ops = &clk_sccg_pll1_ops;
+		break;
+	case SCCG_PLL2:
+		init.ops = &clk_sccg_pll2_ops;
+		break;
+	}
+
+	init.flags = 0;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	pll->hw.init = &init;
+
+	clk = clk_register(NULL, &pll->hw);
+	if (IS_ERR(clk))
+		kfree(pll);
+
+	return clk;
+}
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 13daf1c..12b3fd6 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -21,6 +21,11 @@ enum imx_pllv1_type {
 	IMX_PLLV1_IMX35,
 };
 
+enum imx_sccg_pll_type {
+	SCCG_PLL1,
+	SCCG_PLL2,
+};
+
 struct clk *imx_clk_pllv1(enum imx_pllv1_type type, const char *name,
 		const char *parent, void __iomem *base);
 
@@ -30,6 +35,10 @@ struct clk *imx_clk_pllv2(const char *name, const char *parent,
 struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
 			     void __iomem *base);
 
+struct clk *imx_clk_sccg_pll(const char *name, const char *parent_name,
+			     void __iomem *base,
+			     enum imx_sccg_pll_type pll_type);
+
 enum imx_pllv3_type {
 	IMX_PLLV3_GENERIC,
 	IMX_PLLV3_SYS,
-- 
2.7.4

