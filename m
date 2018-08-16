Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE32EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C76521470
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 15:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LsyLzZje"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C76521470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404032AbeHPS1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 14:27:05 -0400
Received: from mail-eopbgr20085.outbound.protection.outlook.com ([40.107.2.85]:13040
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387586AbeHPS1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 14:27:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXf7qO38vaYskqGDfbVulsm2QujivvVj2Ne8jKVWVAk=;
 b=LsyLzZjeGV14rZ9lZpBa5ETc6zQtgQSZwQwtBlp0rBQR70auC42jAFbGbvpRxjym4jRMSq1Cki9oHi7DCTokFhXYH+6VikeE7LuG/7xNgLqLekX53PXodpapL9HmYEYZgcYT86ZFA73ZipL5VZTS50Y6x54ZqWbeBECkw2sp9Yk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 DB5PR04MB1608.eurprd04.prod.outlook.com (2a01:111:e400:5994::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.21; Thu, 16 Aug
 2018 15:27:40 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
Cc:     linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v4 3/5] clk: imx: add SCCG PLL type
Date:   Thu, 16 Aug 2018 18:27:14 +0300
Message-Id: <1534433236-8925-4-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534433236-8925-1-git-send-email-abel.vesa@nxp.com>
References: <1534433236-8925-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: VI1P194CA0020.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:800:be::30) To DB5PR04MB1608.eurprd04.prod.outlook.com
 (2a01:111:e400:5994::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02fdf06f-15ba-49ce-752a-08d6038cceab
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1608;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;3:ZAPyFuMjVXkqZqwvoBWmGXJvVDprDo+UXF4y7im7xVHN198Az8nW3UhjqbY8cubJ+eFnESg83bv8pvgeoXAvgAWvTONPynSDwmTIq5zJ18R2U0WyfHN2oF+hz7CkBfQIzaVbSc1X1ztX1VPjta/vZb1U0Q0LlMyOqyUmg6MF68yT3BdRUfPx9E2y6qLMpQac8NmvQ/aqbutN/B32jwHf0PsEZhejL8Q0yXygkuaRFaLNHnsmvHucYXaZ7eqFFYsj;25:QShYJUbtp9XfElOT8gbxmTqVoo287Ds/Wi4Dq+7rQa3A64Le+RPmWmUYVuT8yswXO0Jqm9eDBNtpY9uapdH187zMpidkWHGrxaryX3xjZjkFMbIDX16jxuJUPfLDlNPDbwFyEnXVdo8u9PSWjyb7+OD+7w4rM4RUNlYKvTUlcIQ1lSmT8DHUFI1wjx0tI+qQLsM/EDqSih8oteSiJh+3b7OBMFRKFGPacxARXcjtymyOO60ZfCCKFvIyVsrTYh8d3v/vIl0sXjbIJRgrixozSbYJgoWQuGyGaXc9zaUN9X6hfWBsTsU5v2uhRq8TP3URgojWo7YkFtrEC1OQV/iaZg==;31:0CffWauvfeYwMETq0AQ1ASTjgJByL53FXRlJ71mUbxkVLaEERW7kU/p4qokBV3CVh0IeBNgTaYR5MBqDL90pd8EvJStSmIqtACQ2OMkRXMydUe4R40ZeuV86UiYBulG2TA1sbImCmqRm1Q/bBcIypOVKfJYRtnlQ97Gog27ApxZkl0x4IrbnGaRLJ40ut50In8a3bvfLXpdOtKCWKUNkeQG9NO5JuXJ4ISQasE1i0aE=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1608:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;20:PqYkyXT/sKsU1vzgIq/rbdSpCeuv5j7n3H0fSWfOVEwPb8K6gKTzdXvg56XXvrepLhpxKdhbS6zBmTYDw0NbQEGkMUP7OBBmpkDu66e8nx5KXUvR471jVzNJKp16KT5+AL5sx3bCpEkSHcx5p3zapdCawS0XwGEnSKR84cCzzNFyQ6Z3VSuYnvU56KNdtUFYJh4nNdjkZFUSrhnJ1n6HFMdxNy3iQRB9Cg1Uy2BVCIHP/WmHSX4bAG0//YfDPEsqXkZzX4flE6umyBnh4zNNzfILeBCiJQvFPBgcczjEk6jWGANiG/tJ/qrPU/KJU5W3SeB7/Bkks8bmFFi8l+gVJ1mJ3pMAoLhtfQWS6jfSriKmusWetNJ0cTVUsQW5p8uU/EQHJZNUDTqyXJjuMIkPdktBRZo1jzQX0eo2a4xOBstKohzabgSp5+OnDSpZ0y7WjCyV1o8OdvpFZmzV+4HNQC1ypzgCUh2J0Eb9OuJ+lut1jNkBVTyauBCNe1khUhep;4:+0KJ5yyAFL5oddeLYsIgj4bQJ5mJ/Eiah84FD3LcyLt0TxBa1600J6o4O6OS/PPbxpp+nq+3QaYlQluZ07czngZlx6t749ofXXxF+MlTIJNyF25/w+mOJeanlQIzpQNyuGTyai77pqYG5n2N+aFCw86kOhYVKXQfUSkIB20I7KTmorUFspqtOk+ztIr2ss2PMTIU3yCXhOT/vKi8qEGexzpAkSB1d/DOdmnfUbD1T/b+t6hk29GrJTCALfeMPAVuRtNrwxPybXuKvOnMj7H/8s7WpfSZ+u/hq5lkaodjG2wWPiCBZZc8h7QzC20gTbBq
X-Microsoft-Antispam-PRVS: <DB5PR04MB16089BB899C3A79A991CE739F63E0@DB5PR04MB1608.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699016);SRVR:DB5PR04MB1608;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1608;
X-Forefront-PRVS: 07665BE9D1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(366004)(396003)(376002)(189003)(199004)(11346002)(36756003)(446003)(14444005)(476003)(47776003)(53936002)(956004)(386003)(6506007)(6512007)(6116002)(105586002)(106356001)(486006)(2616005)(2906002)(3846002)(305945005)(5660300001)(7416002)(6666003)(6636002)(48376002)(50466002)(7736002)(16526019)(76176011)(6486002)(44832011)(26005)(81156014)(81166006)(316002)(8936002)(8676002)(66066001)(51416003)(25786009)(16586007)(86362001)(68736007)(217873002)(110136005)(54906003)(4326008)(52116002)(50226002)(186003)(478600001)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1608;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1608;23:fJIdBsRKsPB6Kc5Wz2f8NMP1E1vIpKn8Dg8ZfHgjW?=
 =?us-ascii?Q?NAPse6ny2a3PJdYMAISy2DX0RnVNQpgzP7UK8Oab8kx5p9wqbCsyP6fP9QZ7?=
 =?us-ascii?Q?5ZoBvtFTX85m1DmDaE/S9EE/uzx6DCCAH4FNHdBDJW2eWKf9kUcK55TMHovm?=
 =?us-ascii?Q?64DYKD+RizeG6ywtzKj2mwZyQ7R8CBlx2ZA2FiC1QDsoREQQ4WwFg2sddWbQ?=
 =?us-ascii?Q?IdoloPKWeZWKhH7eTeUhlaG5oRFUl0EK9ZX7Cs05XhlUjiLyn6LIJAAiWnK5?=
 =?us-ascii?Q?hUIqdtI8VZ6xW5abZ4RZzhQn6oB2rKo3qq4CnO53kbPX2myqBBVdwgtBvYZ1?=
 =?us-ascii?Q?IwHHuEt9bOkbNZKAvG8GkORLH+ke9zAwdtZu4/dkaoE25/WCTqm30pi32/xz?=
 =?us-ascii?Q?Iugf5tKJPJTt1r0W+wAQchcwmZqqhPGL8R2xtHqihV6vcKD5dq0z1/zlpmme?=
 =?us-ascii?Q?C4l9TxL6PH8uGsN81DZ5h3gjf5Hf6VjKHiAOnTimI5rpkGN5wTbDJH0Fo66V?=
 =?us-ascii?Q?9qsN4rCFJ2sVOD1Ov9kDC/QmhNBh9YfAiS3zlJFXrvBOEQ8yTBVvpqTwwL2w?=
 =?us-ascii?Q?um3PSuTnYZd+5r12IX87PfGdcOj4ub2P5c/Wedj554HMEXLLp/Ic7r0dG4pO?=
 =?us-ascii?Q?m5XzuE9tiiwupxyTUDx587AW1AXEnapjhiBxcwQ8Fakdluwuz5SVTFV7mnqy?=
 =?us-ascii?Q?V4H/bXKRnekOBG/FMxK8lqBkuj87HIgoTTaR9KmZPGCZChDzdEu3p/1rPI4a?=
 =?us-ascii?Q?qpHXvjiPm6fb1MWGzdPG0MgnRM115hCngw08ET3Fz1MUKwI3V5iBGYsoVEXe?=
 =?us-ascii?Q?lA3XnTZ0Q2mpEO+seFGreVbChe2n2m1chwgmwGGZyjbMnwVx3BZBj0EsRP/L?=
 =?us-ascii?Q?DECFfne+dCWD0VGPVpDjJiZe4kOrUgO5a3wFVFT2ZsCsuswaiPOjm/B9n55i?=
 =?us-ascii?Q?Vy2bXUQTRuqjgO6Us8NZoCFhvDcPGYBpRGKDhxVlLt5+a8IrR3S+xEyIWE1J?=
 =?us-ascii?Q?vB2xN5tLEWZd/QTSFGOgzMYu7rEsfaG5whylrlv4eg/enHU2NA2LNlGlEC+1?=
 =?us-ascii?Q?LCiRL6PODwqn7XbfLTKTSfIrn8TxCGXvbH7l37wbBPHmE7gMFJvUhYFE37AF?=
 =?us-ascii?Q?OlmYJG41hrKY0Qh/DEYgmdgSdMQ9uEeORiAyeGPJb7odtNp9CZvhvV2BGH0Z?=
 =?us-ascii?Q?0kr8ePSMKu2i3QRUptHKYXXeQXndY1PmrLe/S3YnMBkx6M2K0allkQrTiDVN?=
 =?us-ascii?Q?OWAIeQVLovF1UHNnU+W7E8eX8QWEgU0A3NZLYLqAdH5Y3ypkGnuh977kES4i?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: SuJ7sykvUr3wn3sgY9vIfLvJSHktr0KYfFg5OatJEaV4gFzj/qjFoHMNJJOfrJYSADEdSQ5cpLMee73VxxGrmBzgRTS/LHtOA8dxFXByLZTQaWy1q9gS252FGR/km8Vvf/t2oXCMrKMQQTyS/KHXR7jUhjMv8OHRuMai8ncqCmoSuz5tI6YFWTMLoW5IPSSrjB+BAOqv0TM/yxS/b/0gN5QXLfvm4/jCr+kngqYED+wU7sfK219BHYbmITTJaPokvDm5fIwp+BIsRK+4WP0fp6Qv++83Imb/vWHgzoqD67dtv7dP2DPZgLBR7TIiFeeP3MCKNf0UoFqP5sbR3BRHfqBu1Yg119zavG8VZcSAlgE=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1608;6:jrMXv+TqZHk71O8++bnzCdoR0nPhUJTp39i2pIvd4sW5vs1tpY6HzBAivkiKpbZET6pwinCyCHgJYS2mKTptJShyaDTs6kHRAYvU2RBNNjPVJp59tS3o3fHVzASWBc8GPXPtMTBeXxgJt2Pq3Ij8mh5lgTxH/X1Ng2cVFAHzapczYEjwR8HLyYaHDGfQVaDIOCoy+kLCuIMmU5S5TFitWrDeljCVsmIiX763PC/lkfhcFj/lzHq3YOe5Q4k/qdakjQIXvI9eeV555NGp48mcxbUUKKIT/BzAXafEWOxLMnQBdhS4mzBpTdpk7h9n+OEKYZaaGtA3N6b5dbsK3y+EZce1q4eCWzp0hTExGxl7dutZ2k3Z0QEVoRebiCDblBfP28kZetcwM9jMONCc31aF7nJv6BFBGoMkfYya1Vmly9I6dECTSDVAN72pe6mIwdzaxQAoiuy4glc2NqBT2uiZVA==;5:4h+PiR8uPWU2u4wETlX3JCVGow2vXINzezSleIu1YDuoEzAb6ACnqU4/VZZA9bHfizf77JY1QxlOh+k9uxS4w+C01eXmPanJwIQegcEpEb3bDB4CIMZeyAYMU7pf8jNC7pWhX7fX8H9lehINVAcaCfGNV79oa00xwyB/5MhnAqw=;7:CNjy3t8vm3zxDwyw2PM/7PzhOegYCkaGvIVp0Sem6dp5NpmDmciMRMIo+zJB3bQ0C5AdOpL/g0qofev4PlK9Zv6qbmo4fWO7Y0KDxV157SBySWx7OQvi1/fZR6borSkbqXuSV0qcRZYFCQGl4b9ybFbpNrwhiG2m37E0v+JF1KreGZSSoLeXNyLp3GDKP6YYSIUSeMH4KLjFGnyOPQBs2TvFhNyV8pRXFfpz/+LAxHeEDz9+tuvvbtU/bYKdhiBz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 15:27:40.5588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fdf06f-15ba-49ce-752a-08d6038cceab
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1608
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

