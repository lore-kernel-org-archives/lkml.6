Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753924AbeDRLyB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 07:54:01 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:38992 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753560AbeDRLx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 07:53:59 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w3IBqaYC007367
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-clk@vger.kernel.org
Cc: Stephen Boyd <stephen.boyd@linaro.org>,
        Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] clk: sunxi-ng: replace lib-y with obj-y
Date: Wed, 18 Apr 2018 20:52:31 +0900
Message-Id: <1524052351-14103-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We had commit 06e226c7fb23 ("clk: sunxi-ng: Move all clock types to a
library") and commit 799c43415442 ("kbuild: thin archives make default
for all archs") in the same development cycle, from different trees.

With migration to the thin archive, the entire drivers/clk/sunxi-ng/lib.a
is linked to the vmlinux.  This does not break build, but we do not get
any size saving.

However, we do not need to go back to the individual Kconfig options.
The default configuration pulls in all (or most) of the CCU parts anyway.
Also, once we enable CONFIG_LD_DEAD_CODE_DATA_ELIMINATION, we can simply
list all files with obj-y, and the linker will drop all unused functions
by itself.

After the long discussion [1], people there agreed to fix this, but
nobody sent a patch after all.  I am doing it now.

I lifted up CONFIG_SUNXI_CCU to drivers/clk/Makefile because everything
in drivers/clk/sunxi-ng/ depends on SUNXI_CCU.

[1] https://patchwork.kernel.org/patch/9796521/

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/clk/Makefile          |  2 +-
 drivers/clk/sunxi-ng/Makefile | 39 +++++++++++++++------------------------
 2 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index de6d06a..23a7fdc 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -94,7 +94,7 @@ obj-$(CONFIG_ARCH_SPRD)			+= sprd/
 obj-$(CONFIG_ARCH_STI)			+= st/
 obj-$(CONFIG_ARCH_STRATIX10)		+= socfpga/
 obj-$(CONFIG_ARCH_SUNXI)		+= sunxi/
-obj-$(CONFIG_ARCH_SUNXI)		+= sunxi-ng/
+obj-$(CONFIG_SUNXI_CCU)			+= sunxi-ng/
 obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
 obj-y					+= ti/
 obj-$(CONFIG_CLK_UNIPHIER)		+= uniphier/
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index 128a40e..9ac0fb9 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -1,24 +1,24 @@
 # SPDX-License-Identifier: GPL-2.0
 # Common objects
-lib-$(CONFIG_SUNXI_CCU)		+= ccu_common.o
-lib-$(CONFIG_SUNXI_CCU)		+= ccu_mmc_timing.o
-lib-$(CONFIG_SUNXI_CCU)		+= ccu_reset.o
+obj-y				+= ccu_common.o
+obj-y				+= ccu_mmc_timing.o
+obj-y				+= ccu_reset.o
 
 # Base clock types
-lib-$(CONFIG_SUNXI_CCU)		+= ccu_div.o
-lib-$(CONFIG_SUNXI_CCU)		+= ccu_frac.o
-lib-$(CONFIG_SUNXI_CCU)		+= ccu_gate.o
-lib-$(CONFIG_SUNXI_CCU)		+= ccu_mux.o
-lib-$(CONFIG_SUNXI_CCU)		+= ccu_mult.o
-lib-$(CONFIG_SUNXI_CCU)		+= ccu_phase.o
-lib-$(CONFIG_SUNXI_CCU)		+= ccu_sdm.o
+obj-y				+= ccu_div.o
+obj-y				+= ccu_frac.o
+obj-y				+= ccu_gate.o
+obj-y				+= ccu_mux.o
+obj-y				+= ccu_mult.o
+obj-y				+= ccu_phase.o
+obj-y				+= ccu_sdm.o
 
 # Multi-factor clocks
-lib-$(CONFIG_SUNXI_CCU)		+= ccu_nk.o
-lib-$(CONFIG_SUNXI_CCU)		+= ccu_nkm.o
-lib-$(CONFIG_SUNXI_CCU)		+= ccu_nkmp.o
-lib-$(CONFIG_SUNXI_CCU)		+= ccu_nm.o
-lib-$(CONFIG_SUNXI_CCU)		+= ccu_mp.o
+obj-y				+= ccu_nk.o
+obj-y				+= ccu_nkm.o
+obj-y				+= ccu_nkmp.o
+obj-y				+= ccu_nm.o
+obj-y				+= ccu_mp.o
 
 # SoC support
 obj-$(CONFIG_SUN50I_A64_CCU)	+= ccu-sun50i-a64.o
@@ -37,12 +37,3 @@ obj-$(CONFIG_SUN8I_R40_CCU)	+= ccu-sun8i-r40.o
 obj-$(CONFIG_SUN9I_A80_CCU)	+= ccu-sun9i-a80.o
 obj-$(CONFIG_SUN9I_A80_CCU)	+= ccu-sun9i-a80-de.o
 obj-$(CONFIG_SUN9I_A80_CCU)	+= ccu-sun9i-a80-usb.o
-
-# The lib-y file goals is supposed to work only in arch/*/lib or lib/. In our
-# case, we want to use that goal, but even though lib.a will be properly
-# generated, it will not be linked in, eventually resulting in a linker error
-# for missing symbols.
-#
-# We can work around that by explicitly adding lib.a to the obj-y goal. This is
-# an undocumented behaviour, but works well for now.
-obj-$(CONFIG_SUNXI_CCU)		+= lib.a
-- 
2.7.4
