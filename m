Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753278AbeBUJVF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:21:05 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:54469 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752798AbeBUJVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:21:00 -0500
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH v2 01/10] regmap: mmio: Add function to attach a clock
Date: Wed, 21 Feb 2018 10:20:25 +0100
Message-Id: <1155920db000d014fd1cd604ed48d1b9a8f64ac1.1519204731.git-series.maxime.ripard@bootlin.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.68c39205c8726547449e3df67b549d89380e51a2.1519204731.git-series.maxime.ripard@bootlin.com>
References: <cover.68c39205c8726547449e3df67b549d89380e51a2.1519204731.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <cover.68c39205c8726547449e3df67b549d89380e51a2.1519204731.git-series.maxime.ripard@bootlin.com>
References: <cover.68c39205c8726547449e3df67b549d89380e51a2.1519204731.git-series.maxime.ripard@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@free-electrons.com>

regmap_init_mmio_clk allows to specify a clock that needs to be enabled
while accessing the registers.

However, that clock is retrieved through its clock ID, which means it will
lookup that clock based on the current device that registers the regmap,
and, in the DT case, will only look in that device OF node.

This might be problematic if the clock to enable is stored in another node.
Let's add a function that allows to attach a clock that has already been
retrieved to a regmap in order to fix this.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/base/regmap/regmap-mmio.c | 24 ++++++++++++++++++++++++
 include/linux/regmap.h            |  3 +++
 2 files changed, 27 insertions(+)

diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index 5189fd6182f6..5cadfd3394d8 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -28,6 +28,8 @@
 struct regmap_mmio_context {
 	void __iomem *regs;
 	unsigned val_bytes;
+
+	bool attached_clk;
 	struct clk *clk;
 
 	void (*reg_write)(struct regmap_mmio_context *ctx,
@@ -363,4 +365,26 @@ struct regmap *__devm_regmap_init_mmio_clk(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(__devm_regmap_init_mmio_clk);
 
+int regmap_mmio_attach_clk(struct regmap *map, struct clk *clk)
+{
+	struct regmap_mmio_context *ctx = map->bus_context;
+
+	ctx->clk = clk;
+	ctx->attached_clk = true;
+
+	return clk_prepare(ctx->clk);
+}
+EXPORT_SYMBOL_GPL(regmap_mmio_attach_clk);
+
+void regmap_mmio_detach_clk(struct regmap *map)
+{
+	struct regmap_mmio_context *ctx = map->bus_context;
+
+	clk_unprepare(ctx->clk);
+
+	ctx->attached_clk = false;
+	ctx->clk = NULL;
+}
+EXPORT_SYMBOL_GPL(regmap_mmio_detach_clk);
+
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 6a3aeba40e9e..5f7ad0552c03 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -21,6 +21,7 @@
 #include <linux/lockdep.h>
 
 struct module;
+struct clk;
 struct device;
 struct i2c_client;
 struct irq_domain;
@@ -905,6 +906,8 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 	__regmap_lockdep_wrapper(__devm_regmap_init_sdw, #config,	\
 				sdw, config)
 
+int regmap_mmio_attach_clk(struct regmap *map, struct clk *clk);
+void regmap_mmio_detach_clk(struct regmap *map);
 void regmap_exit(struct regmap *map);
 int regmap_reinit_cache(struct regmap *map,
 			const struct regmap_config *config);
-- 
git-series 0.9.1
