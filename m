Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967601AbeEYRhB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 13:37:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50808 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967542AbeEYRg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 13:36:57 -0400
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Applied "regmap: add missing prototype for devm_init_slimbus" to the regmap tree
In-Reply-To: <20180525135037.30638-2-srinivas.kandagatla@linaro.org>
Message-Id: <E1fMGe7-00085k-KS@debutante>
Date: Fri, 25 May 2018 18:36:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: add missing prototype for devm_init_slimbus

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

>From ed24d568bd9190cee046ae64df5890494dea2ca4 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Fri, 25 May 2018 14:50:36 +0100
Subject: [PATCH] regmap: add missing prototype for devm_init_slimbus

For some reason the devm variant of slimbus init is not added
into the header eventhough this __devm_regmap_init_slimbus()
is an exported function.

This patch adds this. This also fixes below warning in regmap-slimbus.c
regmap-slimbus.c:65:15: warning: symbol '__devm_regmap_init_slimbus'
 was not declared. Should it be static?
regmap-slimbus.c:65:16: warning: no previous prototype for
 '__devm_regmap_init_slimbus' [-Wmissing-prototypes]

Fixes: 7d6f7fb053ad ("regmap: add SLIMbus support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/regmap.h | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index b6865f070464..4f38068ffb71 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -588,7 +588,10 @@ struct regmap *__devm_regmap_init_sdw(struct sdw_slave *sdw,
 				 const struct regmap_config *config,
 				 struct lock_class_key *lock_key,
 				 const char *lock_name);
-
+struct regmap *__devm_regmap_init_slimbus(struct slim_device *slimbus,
+				 const struct regmap_config *config,
+				 struct lock_class_key *lock_key,
+				 const char *lock_name);
 /*
  * Wrapper for regmap_init macros to include a unique lockdep key and name
  * for each call. No-op if CONFIG_LOCKDEP is not set.
@@ -907,6 +910,19 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 	__regmap_lockdep_wrapper(__devm_regmap_init_sdw, #config,	\
 				sdw, config)
 
+/**
+ * devm_regmap_init_slimbus() - Initialise managed register map
+ *
+ * @slimbus: Device that will be interacted with
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer
+ * to a struct regmap. The regmap will be automatically freed by the
+ * device management code.
+ */
+#define devm_regmap_init_slimbus(slimbus, config)			\
+	__regmap_lockdep_wrapper(__devm_regmap_init_slimbus, #config,	\
+				slimbus, config)
 int regmap_mmio_attach_clk(struct regmap *map, struct clk *clk);
 void regmap_mmio_detach_clk(struct regmap *map);
 void regmap_exit(struct regmap *map);
-- 
2.17.0
