Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932237AbeDZOJD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:09:03 -0400
Received: from hermes.aosc.io ([199.195.250.187]:45824 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932214AbeDZOI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:08:59 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 1/3] mmc: sunxi: add support for the MMC controller on H6
Date: Thu, 26 Apr 2018 22:07:26 +0800
Message-Id: <20180426140728.43155-2-icenowy@aosc.io>
In-Reply-To: <20180426140728.43155-1-icenowy@aosc.io>
References: <20180426140728.43155-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new Allwinner H6 SoC have 3 MMC controllers. The first and second
ones are similar to the ones on A64, but the third one adds EMCE
(Embedded Crypto Engine) support which does hardware transparent crypto
on the eMMC.

As we still do not have support for EMCE, and the support of it is
disabled by defualt, we just duplicate the A64 mmc configurations and
change the compatible string.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 Documentation/devicetree/bindings/mmc/sunxi-mmc.txt |  2 ++
 drivers/mmc/host/sunxi-mmc.c                        | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
index 132e0007d7d6..e6aa5c7a5e12 100644
--- a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
@@ -16,6 +16,8 @@ Required properties:
    * "allwinner,sun9i-a80-mmc"
    * "allwinner,sun50i-a64-emmc"
    * "allwinner,sun50i-a64-mmc"
+   * "allwinner,sun50i-h6-emmc"
+   * "allwinner,sun50i-h6-mmc"
  - reg : mmc controller base registers
  - clocks : a list with 4 phandle + clock specifier pairs
  - clock-names : must contain "ahb", "mmc", "output" and "sample"
diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 97c6b79b7d6f..05e2b5fd7aa4 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1168,6 +1168,20 @@ static const struct sunxi_mmc_cfg sun50i_a64_emmc_cfg = {
 	.can_calibrate = true,
 };
 
+static const struct sunxi_mmc_cfg sun50i_h6_cfg = {
+	.idma_des_size_bits = 16,
+	.clk_delays = NULL,
+	.can_calibrate = true,
+	.mask_data0 = true,
+	.needs_new_timings = true,
+};
+
+static const struct sunxi_mmc_cfg sun50i_h6_emmc_cfg = {
+	.idma_des_size_bits = 13,
+	.clk_delays = NULL,
+	.can_calibrate = true,
+};
+
 static const struct of_device_id sunxi_mmc_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-mmc", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun5i-a13-mmc", .data = &sun5i_a13_cfg },
@@ -1176,6 +1190,8 @@ static const struct of_device_id sunxi_mmc_of_match[] = {
 	{ .compatible = "allwinner,sun9i-a80-mmc", .data = &sun9i_a80_cfg },
 	{ .compatible = "allwinner,sun50i-a64-mmc", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-a64-emmc", .data = &sun50i_a64_emmc_cfg },
+	{ .compatible = "allwinner,sun50i-h6-mmc", .data = &sun50i_h6_cfg },
+	{ .compatible = "allwinner,sun50i-h6-emmc", .data = &sun50i_h6_emmc_cfg },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sunxi_mmc_of_match);
-- 
2.15.1
