Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeCWJg2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:36:28 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53723 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752042AbeCWJgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:36:21 -0400
X-Google-Smtp-Source: AG47ELtlFzRdqgxDYgIxmI4OmuZCMWAIS2NUfVI+TsDDqyqtNSMSwRM4kSZ+LMpnweQ54UsbF9i8TA==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 4/8] clk: davinci: add a reset lookup table for psc0
Date: Fri, 23 Mar 2018 10:36:05 +0100
Message-Id: <20180323093609.24576-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180323093609.24576-1-brgl@bgdev.pl>
References: <20180323093609.24576-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

In order to be able to use the reset framework in legacy boot mode as
well, add the reset lookup table to the psc driver for da850 variant.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/clk/davinci/psc-da850.c | 8 ++++++++
 drivers/clk/davinci/psc.c       | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/clk/davinci/psc-da850.c b/drivers/clk/davinci/psc-da850.c
index ccc7eb17bf3a..395db4b2c0ee 100644
--- a/drivers/clk/davinci/psc-da850.c
+++ b/drivers/clk/davinci/psc-da850.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/reset-controller.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/init.h>
@@ -66,8 +67,15 @@ LPSC_CLKDEV3(ecap_clkdev,	"fck",	"ecap.0",
 				"fck",	"ecap.1",
 				"fck",	"ecap.2");
 
+static struct reset_control_lookup da850_psc0_reset_lookup_table[] = {
+	RESET_LOOKUP("davinci-rproc.0", NULL, 15),
+};
+
 static int da850_psc0_init(struct device *dev, void __iomem *base)
 {
+	reset_controller_add_lookup("da850-psc0",
+				    da850_psc0_reset_lookup_table,
+				    ARRAY_SIZE(da850_psc0_reset_lookup_table));
 	return davinci_psc_register_clocks(dev, da850_psc0_info, 16, base);
 }
 
diff --git a/drivers/clk/davinci/psc.c b/drivers/clk/davinci/psc.c
index 3b0e59dfbdd7..063df62381ea 100644
--- a/drivers/clk/davinci/psc.c
+++ b/drivers/clk/davinci/psc.c
@@ -425,6 +425,7 @@ __davinci_psc_register_clocks(struct device *dev,
 
 	psc->rcdev.ops = &davinci_psc_reset_ops;
 	psc->rcdev.owner = THIS_MODULE;
+	psc->rcdev.dev = dev;
 	psc->rcdev.of_node = dev->of_node;
 	psc->rcdev.of_reset_n_cells = 1;
 	psc->rcdev.of_xlate = davinci_psc_reset_of_xlate;
-- 
2.16.1
