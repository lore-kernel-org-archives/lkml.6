Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19C1C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9801D2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9801D2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732923AbeHWMMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:12:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50260 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeHWMML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:12:11 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6D3FC7F6;
        Thu, 23 Aug 2018 08:43:34 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 085/324] clk: sunxi-ng: replace lib-y with obj-y
Date:   Thu, 23 Aug 2018 09:52:31 +0200
Message-Id: <20180823075000.129025953@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <yamada.masahiro@socionext.com>

[ Upstream commit 12f8c553a503d98b519cca650b188bf51ebdbdbf ]

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
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/Makefile          |    2 +-
 drivers/clk/sunxi-ng/Makefile |   39 +++++++++++++++------------------------
 2 files changed, 16 insertions(+), 25 deletions(-)

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
@@ -37,12 +37,3 @@ obj-$(CONFIG_SUN8I_R40_CCU)	+= ccu-sun8i
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


