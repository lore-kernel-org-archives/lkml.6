Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42266C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE432087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 13:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfAHNvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 08:51:14 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:63162 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbfAHNvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 08:51:11 -0500
Received: from localhost.localdomain (10.18.11.217) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Tue, 8 Jan 2019
 21:51:32 +0800
From:   Jianxin Pan <jianxin.pan@amlogic.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Yixun Lan <yixun.lan@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-clk@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 2/4] clk: meson: add emmc sub clock phase delay driver
Date:   Tue, 8 Jan 2019 21:50:42 +0800
Message-ID: <1546955444-7549-3-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546955444-7549-1-git-send-email-jianxin.pan@amlogic.com>
References: <1546955444-7549-1-git-send-email-jianxin.pan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.11.217]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yixun Lan <yixun.lan@amlogic.com>

Export the emmc sub clock phase delay ops which will be used
by the emmc sub clock driver itself.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
---
 drivers/clk/meson/Makefile          |  1 +
 drivers/clk/meson/clk-phase-delay.c | 73 +++++++++++++++++++++++++++++++++++++
 drivers/clk/meson/clkc.h            |  7 ++++
 3 files changed, 81 insertions(+)
 create mode 100644 drivers/clk/meson/clk-phase-delay.c

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index acd8694..d59620d 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -3,6 +3,7 @@
 #
 
 obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o vid-pll-div.o
+obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-phase-delay.o
 obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-input.o
 obj-$(CONFIG_COMMON_CLK_AMLOGIC) += sclk-div.o
 obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO) += clk-triphase.o
diff --git a/drivers/clk/meson/clk-phase-delay.c b/drivers/clk/meson/clk-phase-delay.c
new file mode 100644
index 0000000..a6e6600
--- /dev/null
+++ b/drivers/clk/meson/clk-phase-delay.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Amlogic Meson MMC Sub Clock Controller Driver
+ *
+ * Copyright (c) 2017 Baylibre SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ *
+ * Copyright (c) 2018 Amlogic, inc.
+ * Author: Yixun Lan <yixun.lan@amlogic.com>
+ * Author: Jianxin Pan <jianxin.pan@amlogic.com>
+ */
+
+#include <linux/clk-provider.h>
+#include "clkc.h"
+
+static inline struct meson_clk_phase_delay_data *
+meson_clk_get_phase_delay_data(struct clk_regmap *clk)
+{
+	return clk->data;
+}
+
+static int meson_clk_phase_delay_get_phase(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_phase_delay_data *ph;
+	unsigned long period_ps, p, d;
+	int degrees;
+
+	ph = meson_clk_get_phase_delay_data(clk);
+	p = meson_parm_read(clk->map, &ph->phase);
+	degrees = p * 360 / (1 << (ph->phase.width));
+
+	period_ps = DIV_ROUND_UP_ULL(NSEC_PER_SEC * 1000ull,
+				     clk_hw_get_rate(hw));
+
+	d = meson_parm_read(clk->map, &ph->delay);
+	degrees += d * ph->delay_step_ps * 360 / period_ps;
+	degrees %= 360;
+
+	return degrees;
+}
+
+static int meson_clk_phase_delay_set_phase(struct clk_hw *hw, int degrees)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_phase_delay_data *ph;
+	unsigned long period_ps, d = 0;
+	unsigned int p;
+
+	ph = meson_clk_get_phase_delay_data(clk);
+	period_ps = DIV_ROUND_UP_ULL(NSEC_PER_SEC * 1000ull,
+				     clk_hw_get_rate(hw));
+
+	/*
+	 * First compute the phase index (p), the remainder (r) is the
+	 * part we'll try to acheive using the delays (d).
+	 */
+	p = 360 / 1 << (ph->phase.width);
+	degrees = degrees / p;
+	d = DIV_ROUND_CLOSEST((degrees % p) * period_ps,
+			      360 * ph->delay_step_ps);
+	d = min(d, PMASK(ph->delay.width));
+
+	meson_parm_write(clk->map, &ph->phase, degrees);
+	meson_parm_write(clk->map, &ph->delay, d);
+	return 0;
+}
+
+const struct clk_ops meson_clk_phase_delay_ops = {
+	.get_phase = meson_clk_phase_delay_get_phase,
+	.set_phase = meson_clk_phase_delay_set_phase,
+};
+EXPORT_SYMBOL_GPL(meson_clk_phase_delay_ops);
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 00b3320..e6f0905 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -118,6 +118,12 @@ struct clk_regmap _name = {						\
 	},								\
 };
 
+struct meson_clk_phase_delay_data {
+	struct parm	phase;
+	struct parm	delay;
+	unsigned int	delay_step_ps;
+};
+
 /* clk_ops */
 extern const struct clk_ops meson_clk_pll_ro_ops;
 extern const struct clk_ops meson_clk_pll_ops;
@@ -127,6 +133,7 @@ struct clk_regmap _name = {						\
 extern const struct clk_ops meson_clk_phase_ops;
 extern const struct clk_ops meson_vid_pll_div_ro_ops;
 extern const struct clk_ops meson_sclk_div_ops;
+extern const struct clk_ops meson_clk_phase_delay_ops;
 
 struct clk_hw *meson_clk_hw_register_input(struct device *dev,
 					   const char *of_name,
-- 
1.9.1

