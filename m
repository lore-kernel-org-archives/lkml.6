Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780A4C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEA52148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VQQPTmVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfA1SFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:05:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35465 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbfA1SE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:04:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so19171449wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JUR8W8hKsfFkxJFYM1wEeTrBndL0qQzv53iIlKiqwe0=;
        b=VQQPTmVe5xTKWPiEPhHSpasmWoYJyMDUs+89vqVX4AjmltGYVkZJTL8gTSPkWAPZhS
         SJlOjoSk9PFeYXgJEJNd4+QnzUUaVOE/U9gy4okz2styboVxC7L+TZtbD2k/KeRab+ti
         dRHq9LLTXjdFYyfcLZVpPufVGNRELuh4F61pafspgoxUv9lUYQvCJSDrEvEUOhPhCEWS
         713fCqs6RF54TKqvkQrjC8pUS/6K26hnvEkFa6wdBubMNIbFagGJiEAUXpWHXOyemY37
         U9vIfwSGNwUwrnrBOruUFKIKgJz7bK55VpnvU2P6bAHlKY9ZHMtZqpvRvMyTs9D1acAZ
         8Pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JUR8W8hKsfFkxJFYM1wEeTrBndL0qQzv53iIlKiqwe0=;
        b=DjkQ9qf/xx30WUjeQSDnEUt/Bq/hOJuXJ82CzkRp6cQrC54ajOnimqRHRrlWoKViMK
         YqpDzjE7Apq9pgiiX+TVwwhvXtvqe29w7X9UmbLOaXo1R11DXi+bcH+shMZLGimi1wzf
         0EXCXKWEjNCA1flJLyGSevvQ36XayOy69vzldy7AzJAy4Rb5VOpVLw/2fi+wxeVL85gs
         B8v6/yU66r0trkw89+aB+DDzMmLLnP83/EInMuJ0iYCM93OhnhNHbKJETR16TvawbKbo
         ZO2Kp7gt6CSf1g679yXHa48DTya2bX/wtEf0tnQaPkQnRwzjWxqCexI2248cPb0yyGKe
         9/bA==
X-Gm-Message-State: AJcUukeLRJuKKPqDrN0OcWx8dNeQyqPC2py57qvuBdbdBzcuS3gwj7D0
        2a8uDc3XDddpCrO2Zs4GAy/9SA==
X-Google-Smtp-Source: ALg8bN5ptqOkDczz4Gl7nJbZhxdu3hNvlXVaK9LMPMfHt9AEJr8jfqZVW2W5tsQfy1LRnLNEkSfOQw==
X-Received: by 2002:adf:ff09:: with SMTP id k9mr21749520wrr.97.1548698695264;
        Mon, 28 Jan 2019 10:04:55 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id p6sm145548193wrx.50.2019.01.28.10.04.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:04:54 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 08/14] clk: meson: merge phase driver and remove from clkc
Date:   Mon, 28 Jan 2019 19:04:24 +0100
Message-Id: <20190128180430.28689-9-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128180430.28689-1-jbrunet@baylibre.com>
References: <20190128180430.28689-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/Makefile       |  2 +-
 drivers/clk/meson/axg-audio.c    |  2 +
 drivers/clk/meson/clk-phase.c    | 75 +++++++++++++++++++++++++++++---
 drivers/clk/meson/clk-phase.h    | 26 +++++++++++
 drivers/clk/meson/clk-triphase.c | 68 -----------------------------
 drivers/clk/meson/clkc-audio.h   |  7 ---
 drivers/clk/meson/clkc.h         |  8 ----
 7 files changed, 99 insertions(+), 89 deletions(-)
 create mode 100644 drivers/clk/meson/clk-phase.h
 delete mode 100644 drivers/clk/meson/clk-triphase.c

diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 8234e92eea38..2b9490dd9878 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -4,7 +4,7 @@
 
 obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-pll.o clk-mpll.o clk-phase.o vid-pll-div.o
 obj-$(CONFIG_COMMON_CLK_AMLOGIC) += clk-input.o clk-dualdiv.o
-obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= clk-triphase.o sclk-div.o
+obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO)	+= sclk-div.o
 obj-$(CONFIG_COMMON_CLK_MESON_AO) += meson-aoclk.o
 obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
 obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o
diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index 8ac3a2295473..45d2abc3351f 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -16,6 +16,8 @@
 
 #include "clkc-audio.h"
 #include "axg-audio.h"
+#include "clk-regmap.h"
+#include "clk-phase.h"
 
 #define AXG_MST_IN_COUNT	8
 #define AXG_SLV_SCLK_COUNT	10
diff --git a/drivers/clk/meson/clk-phase.c b/drivers/clk/meson/clk-phase.c
index cba43748ce3d..80c3ada193a4 100644
--- a/drivers/clk/meson/clk-phase.c
+++ b/drivers/clk/meson/clk-phase.c
@@ -5,7 +5,10 @@
  */
 
 #include <linux/clk-provider.h>
-#include "clkc.h"
+#include <linux/module.h>
+
+#include "clk-regmap.h"
+#include "clk-phase.h"
 
 #define phase_step(_width) (360 / (1 << (_width)))
 
@@ -15,13 +18,12 @@ meson_clk_phase_data(struct clk_regmap *clk)
 	return (struct meson_clk_phase_data *)clk->data;
 }
 
-int meson_clk_degrees_from_val(unsigned int val, unsigned int width)
+static int meson_clk_degrees_from_val(unsigned int val, unsigned int width)
 {
 	return phase_step(width) * val;
 }
-EXPORT_SYMBOL_GPL(meson_clk_degrees_from_val);
 
-unsigned int meson_clk_degrees_to_val(int degrees, unsigned int width)
+static unsigned int meson_clk_degrees_to_val(int degrees, unsigned int width)
 {
 	unsigned int val = DIV_ROUND_CLOSEST(degrees, phase_step(width));
 
@@ -31,7 +33,6 @@ unsigned int meson_clk_degrees_to_val(int degrees, unsigned int width)
 	 */
 	return val % (1 << width);
 }
-EXPORT_SYMBOL_GPL(meson_clk_degrees_to_val);
 
 static int meson_clk_phase_get_phase(struct clk_hw *hw)
 {
@@ -61,3 +62,67 @@ const struct clk_ops meson_clk_phase_ops = {
 	.set_phase	= meson_clk_phase_set_phase,
 };
 EXPORT_SYMBOL_GPL(meson_clk_phase_ops);
+
+/*
+ * This is a special clock for the audio controller.
+ * The phase of mst_sclk clock output can be controlled independently
+ * for the outside world (ph0), the tdmout (ph1) and tdmin (ph2).
+ * Controlling these 3 phases as just one makes things simpler and
+ * give the same clock view to all the element on the i2s bus.
+ * If necessary, we can still control the phase in the tdm block
+ * which makes these independent control redundant.
+ */
+static inline struct meson_clk_triphase_data *
+meson_clk_triphase_data(struct clk_regmap *clk)
+{
+	return (struct meson_clk_triphase_data *)clk->data;
+}
+
+static void meson_clk_triphase_sync(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_triphase_data *tph = meson_clk_triphase_data(clk);
+	unsigned int val;
+
+	/* Get phase 0 and sync it to phase 1 and 2 */
+	val = meson_parm_read(clk->map, &tph->ph0);
+	meson_parm_write(clk->map, &tph->ph1, val);
+	meson_parm_write(clk->map, &tph->ph2, val);
+}
+
+static int meson_clk_triphase_get_phase(struct clk_hw *hw)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_triphase_data *tph = meson_clk_triphase_data(clk);
+	unsigned int val;
+
+	/* Phase are in sync, reading phase 0 is enough */
+	val = meson_parm_read(clk->map, &tph->ph0);
+
+	return meson_clk_degrees_from_val(val, tph->ph0.width);
+}
+
+static int meson_clk_triphase_set_phase(struct clk_hw *hw, int degrees)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_triphase_data *tph = meson_clk_triphase_data(clk);
+	unsigned int val;
+
+	val = meson_clk_degrees_to_val(degrees, tph->ph0.width);
+	meson_parm_write(clk->map, &tph->ph0, val);
+	meson_parm_write(clk->map, &tph->ph1, val);
+	meson_parm_write(clk->map, &tph->ph2, val);
+
+	return 0;
+}
+
+const struct clk_ops meson_clk_triphase_ops = {
+	.init		= meson_clk_triphase_sync,
+	.get_phase	= meson_clk_triphase_get_phase,
+	.set_phase	= meson_clk_triphase_set_phase,
+};
+EXPORT_SYMBOL_GPL(meson_clk_triphase_ops);
+
+MODULE_DESCRIPTION("Amlogic phase driver");
+MODULE_AUTHOR("Jerome Brunet <jbrunet@baylibre.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/meson/clk-phase.h b/drivers/clk/meson/clk-phase.h
new file mode 100644
index 000000000000..5579f9ced142
--- /dev/null
+++ b/drivers/clk/meson/clk-phase.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ */
+
+#ifndef __MESON_CLK_PHASE_H
+#define __MESON_CLK_PHASE_H
+
+#include <linux/clk-provider.h>
+#include "parm.h"
+
+struct meson_clk_phase_data {
+	struct parm ph;
+};
+
+struct meson_clk_triphase_data {
+	struct parm ph0;
+	struct parm ph1;
+	struct parm ph2;
+};
+
+extern const struct clk_ops meson_clk_phase_ops;
+extern const struct clk_ops meson_clk_triphase_ops;
+
+#endif /* __MESON_CLK_PHASE_H */
diff --git a/drivers/clk/meson/clk-triphase.c b/drivers/clk/meson/clk-triphase.c
deleted file mode 100644
index 4a59936251e5..000000000000
--- a/drivers/clk/meson/clk-triphase.c
+++ /dev/null
@@ -1,68 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0 OR MIT)
-/*
- * Copyright (c) 2018 BayLibre, SAS.
- * Author: Jerome Brunet <jbrunet@baylibre.com>
- */
-
-#include <linux/clk-provider.h>
-#include "clkc-audio.h"
-
-/*
- * This is a special clock for the audio controller.
- * The phase of mst_sclk clock output can be controlled independently
- * for the outside world (ph0), the tdmout (ph1) and tdmin (ph2).
- * Controlling these 3 phases as just one makes things simpler and
- * give the same clock view to all the element on the i2s bus.
- * If necessary, we can still control the phase in the tdm block
- * which makes these independent control redundant.
- */
-static inline struct meson_clk_triphase_data *
-meson_clk_triphase_data(struct clk_regmap *clk)
-{
-	return (struct meson_clk_triphase_data *)clk->data;
-}
-
-static void meson_clk_triphase_sync(struct clk_hw *hw)
-{
-	struct clk_regmap *clk = to_clk_regmap(hw);
-	struct meson_clk_triphase_data *tph = meson_clk_triphase_data(clk);
-	unsigned int val;
-
-	/* Get phase 0 and sync it to phase 1 and 2 */
-	val = meson_parm_read(clk->map, &tph->ph0);
-	meson_parm_write(clk->map, &tph->ph1, val);
-	meson_parm_write(clk->map, &tph->ph2, val);
-}
-
-static int meson_clk_triphase_get_phase(struct clk_hw *hw)
-{
-	struct clk_regmap *clk = to_clk_regmap(hw);
-	struct meson_clk_triphase_data *tph = meson_clk_triphase_data(clk);
-	unsigned int val;
-
-	/* Phase are in sync, reading phase 0 is enough */
-	val = meson_parm_read(clk->map, &tph->ph0);
-
-	return meson_clk_degrees_from_val(val, tph->ph0.width);
-}
-
-static int meson_clk_triphase_set_phase(struct clk_hw *hw, int degrees)
-{
-	struct clk_regmap *clk = to_clk_regmap(hw);
-	struct meson_clk_triphase_data *tph = meson_clk_triphase_data(clk);
-	unsigned int val;
-
-	val = meson_clk_degrees_to_val(degrees, tph->ph0.width);
-	meson_parm_write(clk->map, &tph->ph0, val);
-	meson_parm_write(clk->map, &tph->ph1, val);
-	meson_parm_write(clk->map, &tph->ph2, val);
-
-	return 0;
-}
-
-const struct clk_ops meson_clk_triphase_ops = {
-	.init		= meson_clk_triphase_sync,
-	.get_phase	= meson_clk_triphase_get_phase,
-	.set_phase	= meson_clk_triphase_set_phase,
-};
-EXPORT_SYMBOL_GPL(meson_clk_triphase_ops);
diff --git a/drivers/clk/meson/clkc-audio.h b/drivers/clk/meson/clkc-audio.h
index 0a7c157ebf81..8e1de2a72610 100644
--- a/drivers/clk/meson/clkc-audio.h
+++ b/drivers/clk/meson/clkc-audio.h
@@ -9,12 +9,6 @@
 
 #include "clkc.h"
 
-struct meson_clk_triphase_data {
-	struct parm ph0;
-	struct parm ph1;
-	struct parm ph2;
-};
-
 struct meson_sclk_div_data {
 	struct parm div;
 	struct parm hi;
@@ -22,7 +16,6 @@ struct meson_sclk_div_data {
 	struct clk_duty cached_duty;
 };
 
-extern const struct clk_ops meson_clk_triphase_ops;
 extern const struct clk_ops meson_sclk_div_ops;
 
 #endif /* __MESON_CLKC_AUDIO_H */
diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
index 32947bd76bab..e8e4067bfcd5 100644
--- a/drivers/clk/meson/clkc.h
+++ b/drivers/clk/meson/clkc.h
@@ -11,13 +11,6 @@
 #include "clk-regmap.h"
 #include "parm.h"
 
-struct meson_clk_phase_data {
-	struct parm ph;
-};
-
-int meson_clk_degrees_from_val(unsigned int val, unsigned int width);
-unsigned int meson_clk_degrees_to_val(int degrees, unsigned int width);
-
 struct meson_vid_pll_div_data {
 	struct parm val;
 	struct parm sel;
@@ -42,7 +35,6 @@ struct meson_clk_dualdiv_data {
 
 /* clk_ops */
 extern const struct clk_ops meson_clk_cpu_ops;
-extern const struct clk_ops meson_clk_phase_ops;
 extern const struct clk_ops meson_vid_pll_div_ro_ops;
 extern const struct clk_ops meson_clk_dualdiv_ops;
 extern const struct clk_ops meson_clk_dualdiv_ro_ops;
-- 
2.20.1

