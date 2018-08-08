Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEA8C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61EE6216E5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 05:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61EE6216E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeHHHn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 03:43:29 -0400
Received: from mx.socionext.com ([202.248.49.38]:4078 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbeHHHn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 03:43:28 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 08 Aug 2018 14:25:33 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id B735E180B37;
        Wed,  8 Aug 2018 14:25:33 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 8 Aug 2018 14:25:33 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 74DF040372;
        Wed,  8 Aug 2018 14:25:33 +0900 (JST)
Received: from aegis.e01.socionext.com (unknown [10.213.134.210])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 4F307120415;
        Wed,  8 Aug 2018 14:25:33 +0900 (JST)
From:   Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-media@vger.kernel.org
Cc:     Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH v2 3/7] media: uniphier: add CSS common file of HSC
Date:   Wed,  8 Aug 2018 14:25:15 +0900
Message-Id: <20180808052519.14528-4-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180808052519.14528-1-suzuki.katsuhiro@socionext.com>
References: <20180808052519.14528-1-suzuki.katsuhiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CSS (Cross Stream Switch) code for connecting and switching the
MPEG2-TS stream path of inner cores of HSC for Socionext UniPhier
SoCs.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

---

Changes from v1:
  - Split from large patches
  - Fix include lines
  - Remove redundant conditions
---
 drivers/media/platform/uniphier/Makefile  |   2 +-
 drivers/media/platform/uniphier/hsc-css.c | 250 ++++++++++++++++++++++
 drivers/media/platform/uniphier/hsc-reg.h |  29 +++
 drivers/media/platform/uniphier/hsc.h     |  17 ++
 4 files changed, 297 insertions(+), 1 deletion(-)
 create mode 100644 drivers/media/platform/uniphier/hsc-css.c

diff --git a/drivers/media/platform/uniphier/Makefile b/drivers/media/platform/uniphier/Makefile
index c3d67a148dbe..59be2edf0c53 100644
--- a/drivers/media/platform/uniphier/Makefile
+++ b/drivers/media/platform/uniphier/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-uniphier-dvb-y += hsc-dma.o
+uniphier-dvb-y += hsc-dma.o hsc-css.o
 
 obj-$(CONFIG_DVB_UNIPHIER) += uniphier-dvb.o
diff --git a/drivers/media/platform/uniphier/hsc-css.c b/drivers/media/platform/uniphier/hsc-css.c
new file mode 100644
index 000000000000..0ab8156b0ffd
--- /dev/null
+++ b/drivers/media/platform/uniphier/hsc-css.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Socionext UniPhier DVB driver for High-speed Stream Controller (HSC).
+// CSS (Cross Stream Switch) connects MPEG2-TS input port and output port.
+//
+// Copyright (c) 2018 Socionext Inc.
+
+#include <linux/bitfield.h>
+#include <linux/kernel.h>
+#include <linux/regmap.h>
+
+#include "hsc.h"
+#include "hsc-reg.h"
+
+int hsc_css_out_to_ts_in(int out)
+{
+	if (out >= HSC_CSS_OUT_TSI0 && out <= HSC_CSS_OUT_TSI9)
+		return HSC_TS_IN0 + (out - HSC_CSS_OUT_TSI0);
+
+	return -1;
+}
+
+int hsc_css_out_to_dpll_src(int out)
+{
+	if (out >= HSC_CSS_OUT_TSI0 && out <= HSC_CSS_OUT_TSI9)
+		return HSC_DPLL_SRC_TSI0 + (out - HSC_CSS_OUT_TSI0);
+
+	return -1;
+}
+
+static bool css_in_is_valid(struct hsc_chip *chip, int in)
+{
+	return in < chip->spec->num_css_in;
+}
+
+static bool css_out_is_valid(struct hsc_chip *chip, int out)
+{
+	return out < chip->spec->num_css_out;
+}
+
+static const struct hsc_spec_css *css_in_get_spec(struct hsc_chip *chip,
+						  int in)
+{
+	const struct hsc_spec_css *spec = chip->spec->css_in;
+
+	if (!css_in_is_valid(chip, in))
+		return NULL;
+
+	return &spec[in];
+}
+
+static const struct hsc_spec_css *css_out_get_spec(struct hsc_chip *chip,
+						   int out)
+{
+	const struct hsc_spec_css *spec = chip->spec->css_out;
+
+	if (!css_out_is_valid(chip, out))
+		return NULL;
+
+	return &spec[out];
+}
+
+int hsc_dpll_get_src(struct hsc_chip *chip, int dpll, int *src)
+{
+	struct regmap *r = chip->regmap;
+	u32 v;
+
+	if (!src || dpll >= HSC_DPLL_NUM)
+		return -EINVAL;
+
+	regmap_read(r, CSS_DPCTRL(dpll), &v);
+	*src = ffs(v & CSS_DPCTRL_DPSEL_MASK) - 1;
+
+	return 0;
+}
+
+/**
+ * Select source clock of DPLL.
+ *
+ * @dpll: ID of DPLL, use one of HSC_DPLL_*
+ * @src : ID of clock source, use one of HSC_DPLL_SRC_* or HSC_DPLL_SRC_NONE
+ *        to disconnect
+ */
+int hsc_dpll_set_src(struct hsc_chip *chip, int dpll, int src)
+{
+	struct regmap *r = chip->regmap;
+	u32 v = 0;
+
+	if (dpll >= HSC_DPLL_NUM || src >= HSC_DPLL_SRC_NUM)
+		return -EINVAL;
+
+	if (src != HSC_DPLL_SRC_NONE)
+		v = 1 << src;
+
+	regmap_write(r, CSS_DPCTRL(dpll), v);
+
+	return 0;
+}
+
+static int hsc_css_get_polarity(struct hsc_chip *chip,
+				const struct hsc_reg_css_pol *pol,
+				bool *sync_bit, bool *val_bit, bool *clk_fall)
+{
+	struct regmap *r = chip->regmap;
+	u32 v;
+
+	if (!sync_bit || !val_bit || !clk_fall || !pol->valid)
+		return -EINVAL;
+
+	regmap_read(r, pol->reg, &v);
+
+	*sync_bit = !!(v & BIT(pol->sft_sync));
+	*val_bit = !!(v & BIT(pol->sft_val));
+	*clk_fall = !!(v & BIT(pol->sft_clk));
+
+	return 0;
+}
+
+/**
+ * Setup signal polarity of TS signals.
+ *
+ * @sync_bit : true : The sync signal keeps only 1bit period.
+ *             false: The sync signal keeps during 8bits period.
+ * @valid_bit: true : The valid signal does not keep during 8bits period.
+ *             false: The valid signal keeps during 8bits period.
+ * @clk_fall : true : Latch the data at falling edge of clock signal.
+ *             false: Latch the data at rising edge of clock signal.
+ */
+static int hsc_css_set_polarity(struct hsc_chip *chip,
+				const struct hsc_reg_css_pol *pol,
+				bool sync_bit, bool val_bit, bool clk_fall)
+{
+	struct regmap *r = chip->regmap;
+	u32 m = 0, v = 0;
+
+	if (!pol->valid)
+		return -EINVAL;
+
+	if (pol->sft_sync != -1) {
+		m |= BIT(pol->sft_sync);
+		if (sync_bit)
+			v |= BIT(pol->sft_sync);
+	}
+
+	if (pol->sft_val != -1) {
+		m |= BIT(pol->sft_val);
+		if (val_bit)
+			v |= BIT(pol->sft_val);
+	}
+
+	if (pol->sft_clk != -1) {
+		m |= BIT(pol->sft_clk);
+		if (clk_fall)
+			v |= BIT(pol->sft_clk);
+	}
+
+	regmap_update_bits(r, pol->reg, m, v);
+
+	return 0;
+}
+
+int hsc_css_in_get_polarity(struct hsc_chip *chip, int in,
+			    bool *sync_bit, bool *val_bit, bool *clk_fall)
+{
+	const struct hsc_spec_css *speci = css_in_get_spec(chip, in);
+
+	if (!speci)
+		return -EINVAL;
+
+	return hsc_css_get_polarity(chip, &speci->pol,
+				    sync_bit, val_bit, clk_fall);
+}
+
+int hsc_css_in_set_polarity(struct hsc_chip *chip, int in,
+			    bool sync_bit, bool val_bit, bool clk_fall)
+{
+	const struct hsc_spec_css *speci = css_in_get_spec(chip, in);
+
+	if (!speci)
+		return -EINVAL;
+
+	return hsc_css_set_polarity(chip, &speci->pol,
+				    sync_bit, val_bit, clk_fall);
+}
+
+int hsc_css_out_get_polarity(struct hsc_chip *chip, int out,
+			     bool *sync_bit, bool *val_bit, bool *clk_fall)
+{
+	const struct hsc_spec_css *speco = css_out_get_spec(chip, out);
+
+	if (!speco)
+		return -EINVAL;
+
+	return hsc_css_get_polarity(chip, &speco->pol,
+				    sync_bit, val_bit, clk_fall);
+}
+
+int hsc_css_out_set_polarity(struct hsc_chip *chip, int out,
+			     bool sync_bit, bool val_bit, bool clk_fall)
+{
+	const struct hsc_spec_css *speco = css_out_get_spec(chip, out);
+
+	if (!speco)
+		return -EINVAL;
+
+	return hsc_css_set_polarity(chip, &speco->pol,
+				    sync_bit, val_bit, clk_fall);
+}
+
+int hsc_css_out_get_src(struct hsc_chip *chip, int *tsi, int out, bool *en)
+{
+	struct regmap *r = chip->regmap;
+	const struct hsc_spec_css *speco = css_out_get_spec(chip, out);
+	u32 v;
+
+	if (!tsi || !en || !speco || !speco->sel.valid)
+		return -EINVAL;
+
+	regmap_read(r, speco->sel.reg, &v);
+	*tsi = (v & speco->sel.mask) >> speco->sel.sft;
+
+	regmap_read(r, CSS_OUTPUTENABLE, &v);
+	*en = !!(v & BIT(out));
+
+	return 0;
+}
+
+/**
+ * Connect the input port and output port using CSS (Cross Stream Switch).
+ *
+ * @in   : Input port number, use one of HSC_CSS_IN_*.
+ * @out  : Output port number, use one of HSC_CSS_OUT_*.
+ * @en   : false: Disable this path.
+ *         true : Enable this path.
+ */
+int hsc_css_out_set_src(struct hsc_chip *chip, int in, int out, bool en)
+{
+	struct regmap *r = chip->regmap;
+	const struct hsc_spec_css *speco = css_out_get_spec(chip, out);
+
+	if (!css_in_is_valid(chip, in) || !speco || !speco->sel.valid)
+		return -EINVAL;
+
+	regmap_update_bits(r, speco->sel.reg, speco->sel.mask,
+			   in << speco->sel.sft);
+
+	regmap_update_bits(r, CSS_OUTPUTENABLE, BIT(out), (en) ? ~0 : 0);
+
+	return 0;
+}
diff --git a/drivers/media/platform/uniphier/hsc-reg.h b/drivers/media/platform/uniphier/hsc-reg.h
index 2d87960c9b97..e5bc87658361 100644
--- a/drivers/media/platform/uniphier/hsc-reg.h
+++ b/drivers/media/platform/uniphier/hsc-reg.h
@@ -115,4 +115,33 @@
 #define CDMBC_CHATPAGED(i, j)        (0x3c10 + ((i) - 1) * 0x48 + (j) * 0x10)
 #define CDMBC_CHATPAGEU(i, j)        (0x3c14 + ((i) - 1) * 0x48 + (j) * 0x10)
 
+/* CSS */
+#define CSS_PTSOCONFIG                   0x1c00
+#define CSS_PTSISIGNALPOL                0x1c04
+#define CSS_SIGNALPOLCH(i)               (0x1c08 + (i) * 0x4)
+#define CSS_OUTPUTENABLE                 0x1c10
+#define CSS_OUTPUTCTRL(i)                (0x1c14 + (i) * 0x4)
+#define CSS_STSOCONFIG                   0x1c2c
+#define CSS_STSOSIGNALPOL                0x1c30
+#define CSS_DMDSIGNALPOL                 0x1c34
+#define CSS_PTSOSIGNALPOL                0x1c38
+#define CSS_PF0CONFIG                    0x1c3c
+#define CSS_PF1CONFIG                    0x1c40
+#define CSS_PFINTENABLE                  0x1c44
+#define CSS_PFINTSTATUS                  0x1c48
+#define CSS_AVOUTPUTCTRL(i)              (0x1c4c + (i) * 0x4)
+#define CSS_DPCTRL(i)                    (0x1c54 + (i) * 0x4)
+#define   CSS_DPCTRL_DPSEL_MASK            GENMASK(22, 0)
+#define   CSS_DPCTRL_DPSEL_PLAY5           BIT(15)
+#define   CSS_DPCTRL_DPSEL_PLAY4           BIT(14)
+#define   CSS_DPCTRL_DPSEL_PLAY3           BIT(13)
+#define   CSS_DPCTRL_DPSEL_PLAY2           BIT(12)
+#define   CSS_DPCTRL_DPSEL_PLAY1           BIT(11)
+#define   CSS_DPCTRL_DPSEL_PLAY0           BIT(10)
+#define   CSS_DPCTRL_DPSEL_TSI4            BIT(4)
+#define   CSS_DPCTRL_DPSEL_TSI3            BIT(3)
+#define   CSS_DPCTRL_DPSEL_TSI2            BIT(2)
+#define   CSS_DPCTRL_DPSEL_TSI1            BIT(1)
+#define   CSS_DPCTRL_DPSEL_TSI0            BIT(0)
+
 #endif /* DVB_UNIPHIER_HSC_REG_H__ */
diff --git a/drivers/media/platform/uniphier/hsc.h b/drivers/media/platform/uniphier/hsc.h
index fddc66df81c7..1cbd17b475bf 100644
--- a/drivers/media/platform/uniphier/hsc.h
+++ b/drivers/media/platform/uniphier/hsc.h
@@ -329,6 +329,23 @@ struct hsc_conf {
 	int dma_out;
 };
 
+/* CSS */
+int hsc_css_out_to_ts_in(int out);
+int hsc_css_out_to_dpll_src(int out);
+
+int hsc_dpll_get_src(struct hsc_chip *chip, int dpll, int *src);
+int hsc_dpll_set_src(struct hsc_chip *chip, int dpll, int src);
+int hsc_css_in_get_polarity(struct hsc_chip *chip, int in,
+			    bool *sync_bit, bool *val_bit, bool *clk_fall);
+int hsc_css_in_set_polarity(struct hsc_chip *chip, int in,
+			    bool sync_bit, bool val_bit, bool clk_fall);
+int hsc_css_out_get_polarity(struct hsc_chip *chip, int out,
+			     bool *sync_bit, bool *val_bit, bool *clk_fall);
+int hsc_css_out_set_polarity(struct hsc_chip *chip, int out,
+			     bool sync_bit, bool val_bit, bool clk_fall);
+int hsc_css_out_get_src(struct hsc_chip *chip, int *in, int out, bool *en);
+int hsc_css_out_set_src(struct hsc_chip *chip, int in, int out, bool en);
+
 /* DMA */
 u64 hsc_rb_cnt(struct hsc_dma_buf *buf);
 u64 hsc_rb_cnt_to_end(struct hsc_dma_buf *buf);
-- 
2.18.0

