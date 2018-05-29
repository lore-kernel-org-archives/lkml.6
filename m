Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936803AbeE2Bbw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 21:31:52 -0400
Received: from gate.crashing.org ([63.228.1.57]:38838 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935112AbeE2Bbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 21:31:51 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 05/15] fsi/fsi-master-gpio: Add "no-gpio-delays" option
Date: Tue, 29 May 2018 11:30:34 +1000
Message-Id: <20180529013044.23815-6-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529013044.23815-1-benh@kernel.crashing.org>
References: <20180529013044.23815-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for an optional device-tree property that
makes the driver skip all the delays around clocking the
GPIOs and set it in the device-tree of common POWER9 based
OpenPower platforms.

This useful on chips like the AST2500 where the GPIO block is
running at a fairly low clock frequency (25Mhz typically). In
this case, the delays are unnecessary and due to the low
precision of the timers, actually quite harmful in terms of
performance.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reviewed-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
---
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts  |  1 +
 .../boot/dts/aspeed-bmc-opp-witherspoon.dts   |  1 +
 arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts    |  1 +
 drivers/fsi/fsi-master-gpio.c                 | 20 +++++++++++++++----
 4 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
index 3a93ae77cde3..71cb9317d624 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
@@ -53,6 +53,7 @@
 		compatible = "fsi-master-gpio", "fsi-master";
 		#address-cells = <2>;
 		#size-cells = <0>;
+		no-gpio-delays;
 
 		clock-gpios = <&gpio ASPEED_GPIO(AA, 0) GPIO_ACTIVE_HIGH>;
 		data-gpios = <&gpio ASPEED_GPIO(AA, 2) GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
index dab467463c99..97cf819309b5 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts
@@ -126,6 +126,7 @@
 		compatible = "fsi-master-gpio", "fsi-master";
 		#address-cells = <2>;
 		#size-cells = <0>;
+		no-gpio-delays;
 
 		clock-gpios = <&gpio ASPEED_GPIO(AA, 0) GPIO_ACTIVE_HIGH>;
 		data-gpios = <&gpio ASPEED_GPIO(E, 0) GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
index f3bc89a4262f..71a64730f080 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-zaius.dts
@@ -86,6 +86,7 @@
 		compatible = "fsi-master-gpio", "fsi-master";
 		#address-cells = <2>;
 		#size-cells = <0>;
+		no-gpio-delays;
 
 		trans-gpios = <&gpio ASPEED_GPIO(O, 6) GPIO_ACTIVE_HIGH>;
 		enable-gpios = <&gpio ASPEED_GPIO(D, 0) GPIO_ACTIVE_HIGH>;
diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index d6508bbad1fb..c82bbd35276e 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -62,6 +62,7 @@ struct fsi_master_gpio {
 	struct gpio_desc	*gpio_enable;	/* FSI enable */
 	struct gpio_desc	*gpio_mux;	/* Mux control */
 	bool			external_mode;
+	bool			no_delays;
 };
 
 #define CREATE_TRACE_POINTS
@@ -79,9 +80,11 @@ static void clock_toggle(struct fsi_master_gpio *master, int count)
 	int i;
 
 	for (i = 0; i < count; i++) {
-		ndelay(FSI_GPIO_STD_DLY);
+		if (!master->no_delays)
+			ndelay(FSI_GPIO_STD_DLY);
 		gpiod_set_value(master->gpio_clk, 0);
-		ndelay(FSI_GPIO_STD_DLY);
+		if (!master->no_delays)
+			ndelay(FSI_GPIO_STD_DLY);
 		gpiod_set_value(master->gpio_clk, 1);
 	}
 }
@@ -90,10 +93,12 @@ static int sda_clock_in(struct fsi_master_gpio *master)
 {
 	int in;
 
-	ndelay(FSI_GPIO_STD_DLY);
+	if (!master->no_delays)
+		ndelay(FSI_GPIO_STD_DLY);
 	gpiod_set_value(master->gpio_clk, 0);
 	in = gpiod_get_value(master->gpio_data);
-	ndelay(FSI_GPIO_STD_DLY);
+	if (!master->no_delays)
+		ndelay(FSI_GPIO_STD_DLY);
 	gpiod_set_value(master->gpio_clk, 1);
 	return in ? 1 : 0;
 }
@@ -677,6 +682,13 @@ static int fsi_master_gpio_probe(struct platform_device *pdev)
 	}
 	master->gpio_mux = gpio;
 
+	/*
+	 * Check if GPIO block is slow enought that no extra delays
+	 * are necessary. This improves performance on ast2500 by
+	 * an order of magnitude.
+	 */
+	master->no_delays = device_property_present(&pdev->dev, "no-gpio-delays");
+
 	master->master.n_links = 1;
 	master->master.flags = FSI_MASTER_FLAG_SWCLOCK;
 	master->master.read = fsi_master_gpio_read;
-- 
2.17.0
