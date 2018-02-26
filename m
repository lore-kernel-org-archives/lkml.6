Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752880AbeBZLSQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:18:16 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52280 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752258AbeBZLSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:18:04 -0500
From: Mark Brown <broonie@kernel.org>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Applied "regmap: mmio: Add function to attach a clock" to the regmap tree
In-Reply-To: <1155920db000d014fd1cd604ed48d1b9a8f64ac1.1519204731.git-series.maxime.ripard@bootlin.com>
Message-Id: <E1eqGmz-0005ZC-LJ@debutante>
Date: Mon, 26 Feb 2018 11:17:49 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: mmio: Add function to attach a clock

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 31895662f9ba81e8ea9ef05abf8edcb29d4b9c18 Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 21 Feb 2018 10:20:25 +0100
Subject: [PATCH] regmap: mmio: Add function to attach a clock

regmap_init_mmio_clk allows to specify a clock that needs to be enabled
while accessing the registers.

However, that clock is retrieved through its clock ID, which means it will
lookup that clock based on the current device that registers the regmap,
and, in the DT case, will only look in that device OF node.

This might be problematic if the clock to enable is stored in another node.
Let's add a function that allows to attach a clock that has already been
retrieved to a regmap in order to fix this.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.16.1
