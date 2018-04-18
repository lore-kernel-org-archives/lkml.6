Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbeDROvm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 10:51:42 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:55384 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753087AbeDROuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 10:50:22 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 1/5] clk: Extract OF clock helpers in <linux/of_clk.h>
Date: Wed, 18 Apr 2018 16:50:01 +0200
Message-Id: <1524063005-1716-2-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524063005-1716-1-git-send-email-geert+renesas@glider.be>
References: <1524063005-1716-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of of_clk_get_parent_{count,name}() and of_clk_init() is not
limited to clock providers.

Hence move these helpers into their own header file, so callers that are
not clock providers no longer have to include <linux/clk-provider.h>.

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
v3:
  - Add Reviewed-by,
  - Add SPDX-License-Identifier,
  - Add to clock section in MAINTAINERS (note that Rob is still listed
    as a maintainer, too, due to the include/linux/of*.h catch-all
    rule),

v2:
  - New.
---
 MAINTAINERS                  |  1 +
 include/linux/clk-provider.h | 14 +-------------
 include/linux/of_clk.h       | 30 ++++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/of_clk.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 50927cba875771e8..abf08b50a85d969d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3556,6 +3556,7 @@ F:	drivers/clk/
 X:	drivers/clk/clkdev.c
 F:	include/linux/clk-pr*
 F:	include/linux/clk/
+F:	include/linux/of_clk.h
 
 COMMON INTERNET FILE SYSTEM (CIFS)
 M:	Steve French <sfrench@samba.org>
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 210a890008f9e129..61cb4729f22acd6b 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -13,6 +13,7 @@
 
 #include <linux/io.h>
 #include <linux/of.h>
+#include <linux/of_clk.h>
 
 #ifdef CONFIG_COMMON_CLK
 
@@ -890,13 +891,10 @@ struct clk_hw *of_clk_hw_simple_get(struct of_phandle_args *clkspec,
 struct clk *of_clk_src_onecell_get(struct of_phandle_args *clkspec, void *data);
 struct clk_hw *of_clk_hw_onecell_get(struct of_phandle_args *clkspec,
 				     void *data);
-unsigned int of_clk_get_parent_count(struct device_node *np);
 int of_clk_parent_fill(struct device_node *np, const char **parents,
 		       unsigned int size);
-const char *of_clk_get_parent_name(struct device_node *np, int index);
 int of_clk_detect_critical(struct device_node *np, int index,
 			    unsigned long *flags);
-void of_clk_init(const struct of_device_id *matches);
 
 #else /* !CONFIG_OF */
 
@@ -943,26 +941,16 @@ of_clk_hw_onecell_get(struct of_phandle_args *clkspec, void *data)
 {
 	return ERR_PTR(-ENOENT);
 }
-static inline unsigned int of_clk_get_parent_count(struct device_node *np)
-{
-	return 0;
-}
 static inline int of_clk_parent_fill(struct device_node *np,
 				     const char **parents, unsigned int size)
 {
 	return 0;
 }
-static inline const char *of_clk_get_parent_name(struct device_node *np,
-						 int index)
-{
-	return NULL;
-}
 static inline int of_clk_detect_critical(struct device_node *np, int index,
 					  unsigned long *flags)
 {
 	return 0;
 }
-static inline void of_clk_init(const struct of_device_id *matches) {}
 #endif /* CONFIG_OF */
 
 /*
diff --git a/include/linux/of_clk.h b/include/linux/of_clk.h
new file mode 100644
index 0000000000000000..b27da9f164cbd221
--- /dev/null
+++ b/include/linux/of_clk.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * OF clock helpers
+ */
+
+#ifndef __LINUX_OF_CLK_H
+#define __LINUX_OF_CLK_H
+
+#if defined(CONFIG_COMMON_CLK) && defined(CONFIG_OF)
+
+unsigned int of_clk_get_parent_count(struct device_node *np);
+const char *of_clk_get_parent_name(struct device_node *np, int index);
+void of_clk_init(const struct of_device_id *matches);
+
+#else /* !CONFIG_COMMON_CLK || !CONFIG_OF */
+
+static inline unsigned int of_clk_get_parent_count(struct device_node *np)
+{
+	return 0;
+}
+static inline const char *of_clk_get_parent_name(struct device_node *np,
+						 int index)
+{
+	return NULL;
+}
+static inline void of_clk_init(const struct of_device_id *matches) {}
+
+#endif /* !CONFIG_COMMON_CLK || !CONFIG_OF */
+
+#endif /* __LINUX_OF_CLK_H */
-- 
2.7.4
