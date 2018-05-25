Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964940AbeEYNxL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 09:53:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37871 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935972AbeEYNwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 09:52:44 -0400
X-Google-Smtp-Source: AB8JxZpTE4aI5Iy+ZPwL+lgOtymMVlmmM5548UFcFyhaKkvqUH7w+q2kj0QpUyrUM64kVObC3RVR+g==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] regmap: add missing prototype for devm_init_slimbus
Date: Fri, 25 May 2018 14:50:36 +0100
Message-Id: <20180525135037.30638-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180525135037.30638-1-srinivas.kandagatla@linaro.org>
References: <20180525135037.30638-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.16.2
