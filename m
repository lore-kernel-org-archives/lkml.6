Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753840AbeAaSKG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 13:10:06 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:53172 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753706AbeAaSJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 13:09:58 -0500
X-Google-Smtp-Source: AH8x226dVMBnRj0bJ/X8BIl/2KtMRX7VHFA+rbHMrkYXQJoBZVoY/vvFRXy70asIS31UNGZ3XaY0Kw==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/19] clk: meson: remove superseded aoclk_gate_regmap
Date: Wed, 31 Jan 2018 19:09:33 +0100
Message-Id: <20180131180945.18025-8-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180131180945.18025-1-jbrunet@baylibre.com>
References: <20180131180945.18025-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aoclk_gate_regmap has been replaced by meson's clk_regmap.
It is no longer necessary so, remove it

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/gxbb-aoclk-regmap.c | 46 -----------------------------------
 drivers/clk/meson/gxbb-aoclk.h        | 10 --------
 2 files changed, 56 deletions(-)
 delete mode 100644 drivers/clk/meson/gxbb-aoclk-regmap.c

diff --git a/drivers/clk/meson/gxbb-aoclk-regmap.c b/drivers/clk/meson/gxbb-aoclk-regmap.c
deleted file mode 100644
index 2515fbfa0467..000000000000
--- a/drivers/clk/meson/gxbb-aoclk-regmap.c
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- * Copyright (c) 2017 BayLibre, SAS.
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- *
- * SPDX-License-Identifier: GPL-2.0+
- */
-
-#include <linux/clk-provider.h>
-#include <linux/bitfield.h>
-#include <linux/regmap.h>
-#include "gxbb-aoclk.h"
-
-static int aoclk_gate_regmap_enable(struct clk_hw *hw)
-{
-	struct aoclk_gate_regmap *gate = to_aoclk_gate_regmap(hw);
-
-	return regmap_update_bits(gate->regmap, AO_RTI_GEN_CNTL_REG0,
-				  BIT(gate->bit_idx), BIT(gate->bit_idx));
-}
-
-static void aoclk_gate_regmap_disable(struct clk_hw *hw)
-{
-	struct aoclk_gate_regmap *gate = to_aoclk_gate_regmap(hw);
-
-	regmap_update_bits(gate->regmap, AO_RTI_GEN_CNTL_REG0,
-			   BIT(gate->bit_idx), 0);
-}
-
-static int aoclk_gate_regmap_is_enabled(struct clk_hw *hw)
-{
-	struct aoclk_gate_regmap *gate = to_aoclk_gate_regmap(hw);
-	unsigned int val;
-	int ret;
-
-	ret = regmap_read(gate->regmap, AO_RTI_GEN_CNTL_REG0, &val);
-	if (ret)
-		return ret;
-
-	return (val & BIT(gate->bit_idx)) != 0;
-}
-
-const struct clk_ops meson_aoclk_gate_regmap_ops = {
-	.enable = aoclk_gate_regmap_enable,
-	.disable = aoclk_gate_regmap_disable,
-	.is_enabled = aoclk_gate_regmap_is_enabled,
-};
diff --git a/drivers/clk/meson/gxbb-aoclk.h b/drivers/clk/meson/gxbb-aoclk.h
index 127d58954cca..0be78383f257 100644
--- a/drivers/clk/meson/gxbb-aoclk.h
+++ b/drivers/clk/meson/gxbb-aoclk.h
@@ -17,16 +17,6 @@
 #define AO_RTC_ALT_CLK_CNTL0	0x94
 #define AO_RTC_ALT_CLK_CNTL1	0x98
 
-struct aoclk_gate_regmap {
-	struct clk_hw hw;
-	unsigned bit_idx;
-	struct regmap *regmap;
-	spinlock_t *lock;
-};
-
-#define to_aoclk_gate_regmap(_hw) \
-	container_of(_hw, struct aoclk_gate_regmap, hw)
-
 extern const struct clk_ops meson_aoclk_gate_regmap_ops;
 
 struct aoclk_cec_32k {
-- 
2.14.3
