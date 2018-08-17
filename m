Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCA2C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D6821896
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FAGsGNEp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90D6821896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeHQRPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:15:11 -0400
Received: from mail-he1eur01on0045.outbound.protection.outlook.com ([104.47.0.45]:15904
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727213AbeHQRPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UoHKzRUM4Rc1K65M2cWPvUaeNiIh/eVzAHvLglLFMc=;
 b=FAGsGNEpRnfDqXd+QqFCFWrVWzsIklQ8cgeN6c9PgK6s/YZO3vSfvwL7u9n+4cduiX9bRYdlOUSyfcy0L4xAKi3fyudTmuHnX2cdtappg2l0BXcVi0O+HN38CiGS9+ORksPrEBQec/0fhNWHdXcggmgcgjb/1BLbJ1nnAYMeBP0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 AM4PR04MB1601.eurprd04.prod.outlook.com (2a01:111:e400:59e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.23; Fri, 17 Aug
 2018 14:11:27 +0000
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
Subject: [PATCH v5 2/5] clk: imx: add fractional PLL output clock
Date:   Fri, 17 Aug 2018 17:10:43 +0300
Message-Id: <1534515046-18529-3-git-send-email-abel.vesa@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 25b0b388-f6d0-4f58-e4d2-08d6044b53a2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM4PR04MB1601;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;3:DruGXI1c8ChqmGZFaT1tp4S+XetJuZ01Bbps+QLI0SuMpnpCGVyWydBGB8d4sLEO+NXUjMjhuYWxf4/z04oYf9O2wLrK+nd/BNAI6F8TPhhqT0RDWffGu3dm9riC3zIEvdO/DrME3lL41tEe5qp6AMCeYbtdDhNMQuZO40vTLvZDhGQZTVi2MPxCkVIoo8e+2mTExtjS068IHbQ7d6yhBN5NV3kOCVb2D9sUuxzurA+P9/N9OYTHLcWnfMvOCbW+;25:GplmUkHyjqhfpkC9O9Ol7sRCFxSbiN8zOzSlcKt2fzJjKMj3OomOFNkhB/Ywqg78A/nTf1p4Ni3nmtzSFeM/yrMnfwLGig9BMLbXh6BHtgR4DOpCfRv1Gpu5+rQwp4Hrig45mqEipzCmsBlzgXZ4JpDHr4t/SvSSHfksEavzD2oErXyTYhs5WbiDTxNWpGSSLf9ZKiKxZ0NfR5GmHbKpGPbxISzqbgB7wwytpw9Kw+Iyaptwe46n15WEkxLjlD3io4ah5OQskQRVQrtmfdgirqUhkgos3/ieFdZhBS8EryuvK/e3V8/LOzcrDGsCOpHGTArqtutXRWKrErTzCKJVPw==;31:6oVf2YA9J+ujr7lFyLJGY7flMskYe422RodDbVl3moZyk4FlsSkFd60UBHoXT4c4VeUO2jriJs23D9riRt3A2OFfAkqxLW1G8y3soWAsw8reA6PifxMbOcy2cqCn1EdPejo3sYcg1a+64ldZV60+LGrXFUEmLKWNSkNRmyCLC4WPoDyuXvAFI00SqcQxBOvGuQcazPjtN6oYZyJDBw3WmF6EUmD5OfhBXSMnfXEm2NA=
X-MS-TrafficTypeDiagnostic: AM4PR04MB1601:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;20:rXn8rJILCJTmSo0Wtm7n/yPGWL7f+PiGz7CALCZHsBE8LqNHlCi5fX/oqctT68snMkSAADQq5UY8xAhVHf2G5clY+cNpVs6FAhjwOKqbTLGlr/7uZKbwDthTWV2B4wi9UDgmTV/83mCXSBK9RhvsEM0/W35/B7j4WYSBK5ocvTGp9zlIWEclYymwYn0JZ0jplqash5O4PpT4rkzVPs00v1IShafg80EqWa0ZnxYqzabb2k4lZQvlQsF9bKU+xJXa9RkWXhLyfHDbCJbUn6GMHjKKrumhFggRgHhIIJ6LHflvJiuyfBy9FO2Glt1YHpDdtt5SjmRYmPGIaSm47Fds2Ym+U8rbO5Ck7J1NayCOe9t5Pft2Y8oPc+Y/PW4Lrt00W8eLHx9kHdx+eeWw1SiFN0t410eimRi88Eh+/gZkxKUhbZkog+2EChRPpvwhv2t1jBehjVRDo6v2TGiKsvmmgYNL1h8wgiHlqiUUX/3MrlpDY58rMX5PKp/ycdimjB0r;4:XY/XDvKjk7nHijh1H2iq0quDjhJu6Kp/5RONDGYuqtcdnUbbeOAKRgF3sG/QZTUiOgt6NaX/0jT6LZ0Yyq28HNsU6QsUb9GIymY3Vopk6OoPBsBhTHimmbmQ8LFWrJMsZY1lvDiZXShrQUXv4G1ZtLPGAHYieqP58qcy6t8odrOsIACKcAJFTuRDLLqETTk3a+RBw261yrC5QZRlcUu617ahTacOL1dGT9fZoaVdEwTvegmW+JTbKmvlKrMIkWylKCbrhG8ZGD4UGnbHPAqxg8c/INqxlSNLN3MBt6eJi9tBeR0Vme6PzZIECiYkrtuo
X-Microsoft-Antispam-PRVS: <AM4PR04MB16015B6E12F0C85F1F6A7FC5F63D0@AM4PR04MB1601.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301062)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699016);SRVR:AM4PR04MB1601;BCL:0;PCL:0;RULEID:;SRVR:AM4PR04MB1601;
X-Forefront-PRVS: 076777155F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(136003)(396003)(39860400002)(376002)(199004)(189003)(50226002)(4326008)(50466002)(105586002)(51416003)(52116002)(6512007)(48376002)(76176011)(106356001)(86362001)(6116002)(6506007)(3846002)(68736007)(6486002)(36756003)(386003)(110136005)(478600001)(6636002)(97736004)(66066001)(7736002)(54906003)(956004)(25786009)(6666003)(14444005)(316002)(305945005)(16586007)(16526019)(5660300001)(486006)(476003)(2616005)(26005)(7416002)(186003)(53936002)(2906002)(8676002)(81156014)(44832011)(446003)(8936002)(81166006)(47776003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR04MB1601;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR04MB1601;23:eaI4sJie4xJKYUMusGStDPVTzSU8zYnlJwO7SX9+r?=
 =?us-ascii?Q?SqDAoANE8ArxV5LGuuLbgHgX2KfSyPlG++udbay5cgbHQ4P44hcojOsnObLY?=
 =?us-ascii?Q?pqCm4pyISpG6M3wDl1D6JahQwkFqNbp6ZjIeg7MvTTnJ3WfQMTiZSBPMaXN+?=
 =?us-ascii?Q?3nMEKZYzoJJKVjuhl6XV1pN9B1THJZbXy0KkjrPYphUUhmcyBn+poIPnkAe1?=
 =?us-ascii?Q?qX6EOo21fEb/KQKGABD23HN/esZVCzyQWWEA3wwOcd+f7JUf1EwpfbsSEgK9?=
 =?us-ascii?Q?J9XFI9In8GslUOCwj1MhXN9KR9OVYc0CoJDnZ60aHBiqXYhMGCIiReQ1pW5Y?=
 =?us-ascii?Q?WayWsZoFRy/jXaLotnislkgO3dv60KgZeKdDd4vooGr+szg5h/XXrAHXL8pI?=
 =?us-ascii?Q?ZUGhra1fUtGkbzD+TlHwLkV41/WvIBSNKnqvrv1i+eKuJoKQPFarH5aPCbSR?=
 =?us-ascii?Q?Mh2OsFjNaR1CguSULMXC8qh6Etz4xzSwJOKHr+ockT2NKyu4uxOD4/vy/gdC?=
 =?us-ascii?Q?HrGglRbPlQDJVHFJpJIQX2/vT0FjNdqHhCgfLnG4lXPSeGX6C86ENBU6VYrI?=
 =?us-ascii?Q?0ZuDn/RHNeN63n5E+bmGbbkYc0KtBMOum9MsvrsqpFEQTN/EMBGRr7rx0UQ1?=
 =?us-ascii?Q?l24KWRXOIgW5Hqnt8NAIchZzAmA1pW6BgH85U6iW10mWWS9bdwH0RVCvX4lL?=
 =?us-ascii?Q?+3ESEEhVRzcDksr+ToCl1fcl3qsPDyXLsFUqBp5gR4pgV+yMFddSzqF9Gsmc?=
 =?us-ascii?Q?0Yh71AyGRDHGnL/LeOfjLlnPzt+k0w/+HTJvN/FYMsLaTkA8B6Y6a0hSSdaR?=
 =?us-ascii?Q?mJAH4dokBQ18Wv0bCpB17uqItsbckBRIw/wpfhatpbCYqW8JZL9ssM9HqxxO?=
 =?us-ascii?Q?S0nAK7R9ePF5yjmaYpIEo5LghldCnl4sAvDMXCQeRLxPMuEWBqrV1U05aB14?=
 =?us-ascii?Q?u11iecEqF8UN9UxMk1lziu8YLDXb/a1fcOZmolkeLONJDLuoUvQC+nXEPsBw?=
 =?us-ascii?Q?MB75tKL2od068s3TdQ4ZK0SsmVCY8QHPVK9bYBc3tGBQ3BPZz7UzdYFQNsZH?=
 =?us-ascii?Q?WyQk5Yg4plWv992ag33wv1MtDFDWNXaRK2HmcbdbpsOwE0ZuuwLTZuWKj4ME?=
 =?us-ascii?Q?1bL6MxkFIXuzvtM1myuURYawTzttioA/BJ3Na3ZNObkhFDBeLrsiWaRAaNF2?=
 =?us-ascii?Q?5MG481zwd1Lu+JVtKRBkvy4RMz4vci+fbY7gP5a8C79XduxK9b4OmsloFBIY?=
 =?us-ascii?Q?lPq8pzpFA5tzJKFGVRjAiqn4sjG4NQOeAJfZj8n?=
X-Microsoft-Antispam-Message-Info: PtsdUVNqfX8LRUmwZqnpJI/bLgSQ3MRhX0rCMWcAwJJniPgM5Xizh3kgzFUCGYY0Dm2XaIDyFVwo5BVzZdGvYb0OswOIWNRESyqkeLTb6JxP4YuorD+IoZiabCsqEe3eTzURNjqHCFiFCXJHJi0/eV7vBvB6lq6okL1+aVwfVdDu10+tBwdsitwbB07uyUBjWk8QG9QNBt+tw/zUCSvuMvkHIOutAsswN6MNyO2D99t1U6EPovA5xHXGIacc/EL+OycpDgzX+/TV8nyrr85kvfv7Mmbgdi04swISYkwLkQ0/1VM20a3yNDnnBCsAhKCJjTjd5ilYQoLJzlOIZ6ntDGnhZKLNhiv6I6pkUqErMgg=
X-Microsoft-Exchange-Diagnostics: 1;AM4PR04MB1601;6:QL1yb+pp2XpbwfBtWtoqHxTVYK7LW1oZJrzloVUZgi+EYSjrcHERSG7+fDhTA2kXTuAOcgb3v8ejgLW5VSPq2MW9qZ7oPW7zUscheuMsArCCbgDODtqIoJuGoID8dqV99UL1R8ZxqDHQrbqXki1gE3/Mg1Xu2PfTyD3cNXLTvijtFqeRjVAEPEPCJ9/oCkoC20rlnJaZYeEId5/0fnuQUxvWD//Xf1EGKFCo2jFY268l/y1yIqEpmuzAMKymWnj+TuEqtLX6wLGMgf0cXkbyT6UMRhSQTezNxeurGkMSrEWmyL2aexI0peVw21tZDr+RpjAOctovO0b8zrNgVSkK1ws57VA7tnQLJyaZVCQC5Dv4hitpRSdIOigHb/00hIBgMiUETnWO0sM/x35dvn/6rFZvi9fFadEol0oG9fNe5Hu4DhoYbPadkNZU7qtpludpzB54ixpabpKkl9ufdjkm7Q==;5:YPglM3BRWe6Kxf0RgZQI+LrocT49ybD6oQmk0hbMBwYssP3gt5GjGGHbLXSgz1JwKWOy+ZvObPbUxfiedFX3RK7bHrY3yIm0LgW6VRK6jEt9yP316vKqf/kFzcockhZmyBTM7Z0fTF8rEW6ahrCEVeonYR0jKufNyF3z988JrAE=;7:09U2xB3JLq6Ld6LcjvcGDoV1BOMX/t+3xNlbOgOwQQrDYTXOCY5c/v/n7MZiPc2e76p+HZqlchRlkCv/RwUayN8/y1H6Ii6CKZVUDzTu6xBfVZNIY9w//T+x4tL9IAY3Q+oTZ/3BU+jz0yVe1GQOtYmf3x9h8OKkYHDXG4pz/Gmxk1tP2dJsId9vLA27YH38vCLlqhaPvBZArJV+JuZUk0ZasQzLjcNDQ4VxV9dSlGE5pBEhndrR3KKZdixWHavK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2018 14:11:27.5443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b0b388-f6d0-4f58-e4d2-08d6044b53a2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR04MB1601
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This is a new clock type introduced on i.MX8.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/Makefile       |   1 +
 drivers/clk/imx/clk-frac-pll.c | 230 +++++++++++++++++++++++++++++++++++++++++
 drivers/clk/imx/clk.h          |   3 +
 3 files changed, 234 insertions(+)
 create mode 100644 drivers/clk/imx/clk-frac-pll.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 8c3baa7..4893c1f 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -6,6 +6,7 @@ obj-y += \
 	clk-cpu.o \
 	clk-fixup-div.o \
 	clk-fixup-mux.o \
+	clk-frac-pll.o \
 	clk-gate-exclusive.o \
 	clk-gate2.o \
 	clk-pllv1.o \
diff --git a/drivers/clk/imx/clk-frac-pll.c b/drivers/clk/imx/clk-frac-pll.c
new file mode 100644
index 0000000..c80c6ed
--- /dev/null
+++ b/drivers/clk/imx/clk-frac-pll.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 NXP.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/jiffies.h>
+#include <linux/slab.h>
+
+#include "clk.h"
+
+#define PLL_CFG0		0x0
+#define PLL_CFG1		0x4
+
+#define PLL_LOCK_STATUS		BIT(31)
+#define PLL_PD			19
+#define PLL_PD_MASK		BIT(PLL_PD)
+#define PLL_BYPASS		14
+#define PLL_BYPASS_MASK		BIT(PLL_BYPASS)
+#define PLL_NEWDIV_VAL		BIT(12)
+#define PLL_NEWDIV_ACK		BIT(11)
+#define PLL_FRAC_DIV_MASK	0xffffff
+#define PLL_INT_DIV_MASK	0x7f
+#define PLL_OUTPUT_DIV_MASK	0x1f
+#define PLL_FRAC_DENOM		0x1000000
+
+struct clk_frac_pll {
+	struct clk_hw	hw;
+	void __iomem	*base;
+};
+
+#define to_clk_frac_pll(_hw) container_of(_hw, struct clk_frac_pll, hw)
+
+static int clk_wait_lock(struct clk_frac_pll *pll)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(10);
+	u32 val;
+
+	/* Wait for PLL to lock */
+	do {
+		if (readl_relaxed(pll->base) & PLL_LOCK_STATUS)
+			break;
+		if (time_after(jiffies, timeout))
+			break;
+	} while (1);
+
+	return readl_poll_timeout(pll->base, val,
+					val & PLL_LOCK_STATUS, 0, 1000);
+}
+
+static int clk_wait_ack(struct clk_frac_pll *pll)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(50);
+	u32 val;
+
+	/* return directly if the pll is in powerdown or in bypass */
+	if (readl_relaxed(pll->base) & (PLL_PD_MASK | PLL_BYPASS_MASK))
+		return 0;
+
+	/* Wait for the pll's divfi and divff to be reloaded */
+	do {
+		if (readl_relaxed(pll->base) & PLL_NEWDIV_ACK)
+			break;
+		if (time_after(jiffies, timeout))
+			break;
+	} while (1);
+
+	return readl_poll_timeout(pll->base, val,
+					val & PLL_NEWDIV_ACK, 0, 1000);
+}
+
+static int clk_pll_prepare(struct clk_hw *hw)
+{
+	struct clk_frac_pll *pll = to_clk_frac_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val &= ~PLL_PD_MASK;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	return clk_wait_lock(pll);
+}
+
+static void clk_pll_unprepare(struct clk_hw *hw)
+{
+	struct clk_frac_pll *pll = to_clk_frac_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val |= PLL_PD_MASK;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+}
+
+static int clk_pll_is_prepared(struct clk_hw *hw)
+{
+	struct clk_frac_pll *pll = to_clk_frac_pll(hw);
+	u32 val;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	return (val & PLL_PD_MASK) ? 0 : 1;
+}
+
+static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
+					 unsigned long parent_rate)
+{
+	struct clk_frac_pll *pll = to_clk_frac_pll(hw);
+	u32 val, divff, divfi, divq;
+	u64 temp64;
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	divq = ((val & PLL_OUTPUT_DIV_MASK) + 1) * 2;
+	val = readl_relaxed(pll->base + PLL_CFG1);
+	divff = (val >> 7) & PLL_FRAC_DIV_MASK;
+	divfi = (val & PLL_INT_DIV_MASK);
+
+	temp64 = (u64)parent_rate * 8;
+	temp64 *= divff;
+	do_div(temp64, PLL_FRAC_DENOM);
+	temp64 /= divq;
+
+	return parent_rate * 8 * (divfi + 1) / divq + (unsigned long)temp64;
+}
+
+static long clk_pll_round_rate(struct clk_hw *hw, unsigned long rate,
+			       unsigned long *prate)
+{
+	unsigned long parent_rate = *prate;
+	u32 divff, divfi;
+	u64 temp64;
+
+	parent_rate *= 8;
+	rate *= 2;
+	divfi = rate / parent_rate;
+	temp64 = (u64)(rate - divfi * parent_rate);
+	temp64 *= PLL_FRAC_DENOM;
+	do_div(temp64, parent_rate);
+	divff = temp64;
+
+	temp64 = (u64)parent_rate;
+	temp64 *= divff;
+	do_div(temp64, PLL_FRAC_DENOM);
+
+	return (parent_rate * divfi + (unsigned long)temp64) / 2;
+}
+
+/*
+ * To simplify the clock calculation, we can keep the 'PLL_OUTPUT_VAL' at zero
+ * (means the PLL output will be divided by 2). So the PLL output can use
+ * the below formula:
+ * pllout = parent_rate * 8 / 2 * DIVF_VAL;
+ * where DIVF_VAL = 1 + DIVFI + DIVFF / 2^24.
+ */
+static int clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+			    unsigned long parent_rate)
+{
+	struct clk_frac_pll *pll = to_clk_frac_pll(hw);
+	u32 val, divfi, divff;
+	u64 temp64;
+	int ret;
+
+	parent_rate *= 8;
+	rate *= 2;
+	divfi = rate / parent_rate;
+	temp64 = (u64) (rate - divfi * parent_rate);
+	temp64 *= PLL_FRAC_DENOM;
+	do_div(temp64, parent_rate);
+	divff = temp64;
+
+	val = readl_relaxed(pll->base + PLL_CFG1);
+	val &= ~((PLL_FRAC_DIV_MASK << 7) | (PLL_INT_DIV_MASK));
+	val |= ((divff << 7) | (divfi - 1));
+	writel_relaxed(val, pll->base + PLL_CFG1);
+
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val &= ~0x1f;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	/* Set the NEV_DIV_VAL to reload the DIVFI and DIVFF */
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val |= PLL_NEWDIV_VAL;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	ret = clk_wait_ack(pll);
+
+	/* clear the NEV_DIV_VAL */
+	val = readl_relaxed(pll->base + PLL_CFG0);
+	val &= ~PLL_NEWDIV_VAL;
+	writel_relaxed(val, pll->base + PLL_CFG0);
+
+	return ret;
+}
+
+static const struct clk_ops clk_frac_pll_ops = {
+	.prepare	= clk_pll_prepare,
+	.unprepare	= clk_pll_unprepare,
+	.is_prepared	= clk_pll_is_prepared,
+	.recalc_rate	= clk_pll_recalc_rate,
+	.round_rate	= clk_pll_round_rate,
+	.set_rate	= clk_pll_set_rate,
+};
+
+struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
+			     void __iomem *base)
+{
+	struct clk_init_data init;
+	struct clk_frac_pll *pll;
+	struct clk *clk;
+
+	pll = kzalloc(sizeof(*pll), GFP_KERNEL);
+	if (!pll)
+		return ERR_PTR(-ENOMEM);
+
+	pll->base = base;
+	init.name = name;
+	init.ops = &clk_frac_pll_ops;
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
index 8076ec0..13daf1c 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -27,6 +27,9 @@ struct clk *imx_clk_pllv1(enum imx_pllv1_type type, const char *name,
 struct clk *imx_clk_pllv2(const char *name, const char *parent,
 		void __iomem *base);
 
+struct clk *imx_clk_frac_pll(const char *name, const char *parent_name,
+			     void __iomem *base);
+
 enum imx_pllv3_type {
 	IMX_PLLV3_GENERIC,
 	IMX_PLLV3_SYS,
-- 
2.7.4

