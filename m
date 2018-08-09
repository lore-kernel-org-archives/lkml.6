Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51B9C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7E521B31
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D7E521B31
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbeHIJcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:32:13 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:46993 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbeHIJcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:32:13 -0400
Received: from ofmlt.linux-actions.org (10.18.20.235) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Thu, 9 Aug 2018
 15:09:00 +0800
From:   Yixun Lan <yixun.lan@amlogic.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
CC:     Yixun Lan <yixun.lan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jian Hu <jian.hu@amlogic.com>, <linux-clk@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/3] clk: meson: add emmc sub clock phase delay driver
Date:   Thu, 9 Aug 2018 15:07:21 +0800
Message-ID: <20180809070724.11935-2-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180809070724.11935-1-yixun.lan@amlogic.com>
References: <20180809070724.11935-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.235]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the emmc sub clock phase delay ops which will be used
by the emmc sub clock driver itself.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 drivers/clk/meson/Makefile          |  2 +-
 drivers/clk/meson/clk-phase-delay.c | 96 +++++++++++++++++++++++++++++
 drivers/clk/meson/clkc.h            | 13 ++++
 3 files changed, 110 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/meson/clk-phase-delay.c

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 72ec8c40d848..39ce5661b654 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Meson specific clk
 #
 
-obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o
+obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o clk-phase-delay.o
 obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= clk-triphase.o sclk-div.o
 obj-$(CONFIG_COMMON_CLK_MESON_AO) += meson-aoclk.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
diff --git a/drivers/clk/meson/clk-phase-delay.c b/drivers/clk/meson/clk-phase-delay.c
new file mode 100644
index 000000000000..6f226814cfec
--- /dev/null
+++ b/drivers/clk/meson/clk-phase-delay.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Amlogic Meson MMC Sub Clock Controller Driver
+ *
+ * Copyright (c) 2017 Baylibre SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ *
+ * Copyright (c) 2018 Amlogic, inc.
+ * Author: Yixun Lan <yixun.lan@amlogic.com>
+ */
+
+#include <linux/clk-provider.h>
+#include "clkc.h"
+
+#define SD_EMMC_CLOCK			0
+
+static int meson_clk_phase_delay_get_phase(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_phase_delay_data *ph =
+		meson_clk_get_phase_delay_data(clk);
+	unsigned int phase_num = 1 <<  hweight_long(ph->phase_mask);
+	unsigned long period_ps, p, d;
+	int degrees;
+	u32 val;
+
+	regmap_read(clk->map, SD_EMMC_CLOCK, &val);
+	p = (val & ph->phase_mask) >> __ffs(ph->phase_mask);
+	degrees = p * 360 / phase_num;
+
+	if (ph->delay_mask) {
+		period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,
+					 clk_hw_get_rate(hw));
+		d = (val & ph->delay_mask) >> __ffs(ph->delay_mask);
+		degrees += d * ph->delay_step_ps * 360 / period_ps;
+		degrees %= 360;
+	}
+
+	return degrees;
+}
+
+static void meson_clk_apply_phase_delay(struct clk_regmap *clk,
+					unsigned int phase,
+					unsigned int delay)
+{
+	struct meson_clk_phase_delay_data *ph = clk->data;
+	u32 val;
+
+	regmap_read(clk->map, SD_EMMC_CLOCK, &val);
+
+	val &= ~ph->phase_mask;
+	val |= phase << __ffs(ph->phase_mask);
+
+	if (ph->delay_mask) {
+		val &= ~ph->delay_mask;
+		val |= delay << __ffs(ph->delay_mask);
+	}
+
+	regmap_write(clk->map, SD_EMMC_CLOCK, val);
+}
+
+static int meson_clk_phase_delay_set_phase(struct clk_hw *hw, int degrees)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_phase_delay_data *ph =
+		meson_clk_get_phase_delay_data(clk);
+	unsigned int phase_num = 1 <<  hweight_long(ph->phase_mask);
+	unsigned long period_ps, d = 0, r;
+	u64 p;
+
+	p = degrees % 360;
+
+	if (!ph->delay_mask) {
+		p = DIV_ROUND_CLOSEST_ULL(p, 360 / phase_num);
+	} else {
+		period_ps = DIV_ROUND_UP((unsigned long)NSEC_PER_SEC * 1000,
+					 clk_hw_get_rate(hw));
+
+		/* First compute the phase index (p), the remainder (r) is the
+		 * part we'll try to acheive using the delays (d).
+		 */
+		r = do_div(p, 360 / phase_num);
+		d = DIV_ROUND_CLOSEST(r * period_ps,
+				      360 * ph->delay_step_ps);
+		d = min(d, ph->delay_mask >> __ffs(ph->delay_mask));
+	}
+
+	meson_clk_apply_phase_delay(clk, p, d);
+	return 0;
+}
+
+const struct clk_ops meson_clk_phase_delay_ops = {
+	.get_phase = meson_clk_phase_delay_get_phase,
+	.set_phase = meson_clk_phase_delay_set_phase,
+};
+EXPORT_SYMBOL_GPL(meson_clk_phase_delay_ops);
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 24cec16b6038..499834dd34f2 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -113,6 +113,18 @@ struct clk_regmap _name = {						\
 	},								\
 };
 
+struct meson_clk_phase_delay_data {
+	unsigned long			phase_mask;
+	unsigned long			delay_mask;
+	unsigned int			delay_step_ps;
+};
+
+static inline struct meson_clk_phase_delay_data *
+meson_clk_get_phase_delay_data(struct clk_regmap *clk)
+{
+	return (struct meson_clk_phase_delay_data *)clk->data;
+}
+
 /* clk_ops */
 extern const struct clk_ops meson_clk_pll_ro_ops;
 extern const struct clk_ops meson_clk_pll_ops;
@@ -120,5 +132,6 @@ extern const struct clk_ops meson_clk_cpu_ops;
 extern const struct clk_ops meson_clk_mpll_ro_ops;
 extern const struct clk_ops meson_clk_mpll_ops;
 extern const struct clk_ops meson_clk_phase_ops;
+extern const struct clk_ops meson_clk_phase_delay_ops;
 
 #endif /* __CLKC_H */
-- 
2.17.1

