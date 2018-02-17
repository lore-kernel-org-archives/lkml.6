Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbeBQFBS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 00:01:18 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:45600 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750951AbeBQFBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 00:01:17 -0500
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: sunxi: Fix multi-cluster SMP support compilation in multi v6/v7 configs
Date: Sat, 17 Feb 2018 13:01:12 +0800
Message-Id: <20180217050112.14619-1-wens@csie.org>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various parts of the assembly code used in the multi-cluster SMP support
requires ARMv7-A. If the kernel config also has multi v6 support enabled,
Kbuild defaults to building for armv6k, which does not support some of
the instructions we use.

Configure the Makefile such that the multi-cluster SMP code is always
built for ARMv7-A. This is also what mach-exynos does for their MC-SMP
code.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

This addresses "[sunxi:sunxi/core-for-4.17 1/4] /tmp/ccSQM2rD.s:438:
Error: selected processor does not support `isb' in ARM mode"
reported by the kbuild test robot for arm-allmodconfig.

Should we apply it, or squash it in the original patch?

---
 arch/arm/mach-sunxi/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sunxi/Makefile b/arch/arm/mach-sunxi/Makefile
index 3e741e959c7c..3c2c4384357a 100644
--- a/arch/arm/mach-sunxi/Makefile
+++ b/arch/arm/mach-sunxi/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_ARCH_SUNXI) += sunxi.o
 obj-$(CONFIG_ARCH_SUNXI_MC_SMP) += mc_smp.o
+CFLAGS_mc_smp.o	+= -march=armv7-a
 obj-$(CONFIG_SMP) += platsmp.o
-- 
2.16.1
