Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753218AbeDQRbo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:31:44 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37089 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752985AbeDQRa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:30:57 -0400
X-Google-Smtp-Source: AIpwx482TKIiao57z7WTPUH6uNizSwcaH20ENwhRypWSHDG4LNVa7X36ztATRu9lcmsSxGXg6gDW6A==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Suman Anna <s-anna@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
Subject: [PATCH v6 6/7] remoteproc/davinci: use the reset framework
Date: Tue, 17 Apr 2018 19:30:37 +0200
Message-Id: <20180417173038.25510-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417173038.25510-1-brgl@bgdev.pl>
References: <20180417173038.25510-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Switch to using the reset framework instead of handcoded reset routines
we used so far.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/remoteproc/da8xx_remoteproc.c | 34 +++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index b668e32996e2..76c06b70a1c6 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -10,6 +10,7 @@
 
 #include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/reset.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -20,8 +21,6 @@
 #include <linux/platform_device.h>
 #include <linux/remoteproc.h>
 
-#include <mach/clock.h>   /* for davinci_clk_reset_assert/deassert() */
-
 #include "remoteproc_internal.h"
 
 static char *da8xx_fw_name;
@@ -72,6 +71,7 @@ struct da8xx_rproc {
 	struct da8xx_rproc_mem *mem;
 	int num_mems;
 	struct clk *dsp_clk;
+	struct reset_control *dsp_reset;
 	void (*ack_fxn)(struct irq_data *data);
 	struct irq_data *irq_data;
 	void __iomem *chipsig;
@@ -138,6 +138,7 @@ static int da8xx_rproc_start(struct rproc *rproc)
 	struct device *dev = rproc->dev.parent;
 	struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
 	struct clk *dsp_clk = drproc->dsp_clk;
+	struct reset_control *dsp_reset = drproc->dsp_reset;
 	int ret;
 
 	/* hw requires the start (boot) address be on 1KB boundary */
@@ -155,7 +156,12 @@ static int da8xx_rproc_start(struct rproc *rproc)
 		return ret;
 	}
 
-	davinci_clk_reset_deassert(dsp_clk);
+	ret = reset_control_deassert(dsp_reset);
+	if (ret) {
+		dev_err(dev, "reset_control_deassert() failed: %d\n", ret);
+		clk_disable_unprepare(dsp_clk);
+		return ret;
+	}
 
 	return 0;
 }
@@ -163,8 +169,15 @@ static int da8xx_rproc_start(struct rproc *rproc)
 static int da8xx_rproc_stop(struct rproc *rproc)
 {
 	struct da8xx_rproc *drproc = rproc->priv;
+	struct device *dev = rproc->dev.parent;
+	int ret;
+
+	ret = reset_control_assert(drproc->dsp_reset);
+	if (ret) {
+		dev_err(dev, "reset_control_assert() failed: %d\n", ret);
+		return ret;
+	}
 
-	davinci_clk_reset_assert(drproc->dsp_clk);
 	clk_disable_unprepare(drproc->dsp_clk);
 
 	return 0;
@@ -232,6 +245,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 	struct resource *bootreg_res;
 	struct resource *chipsig_res;
 	struct clk *dsp_clk;
+	struct reset_control *dsp_reset;
 	void __iomem *chipsig;
 	void __iomem *bootreg;
 	int irq;
@@ -268,6 +282,15 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 		return PTR_ERR(dsp_clk);
 	}
 
+	dsp_reset = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(dsp_reset)) {
+		if (PTR_ERR(dsp_reset) != -EPROBE_DEFER)
+			dev_err(dev, "unable to get reset control: %ld\n",
+				PTR_ERR(dsp_reset));
+
+		return PTR_ERR(dsp_reset);
+	}
+
 	if (dev->of_node) {
 		ret = of_reserved_mem_device_init(dev);
 		if (ret) {
@@ -287,6 +310,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 	drproc = rproc->priv;
 	drproc->rproc = rproc;
 	drproc->dsp_clk = dsp_clk;
+	drproc->dsp_reset = dsp_reset;
 	rproc->has_iommu = false;
 
 	ret = da8xx_rproc_get_internal_memories(pdev, drproc);
@@ -309,7 +333,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 	 * *not* in reset, but da8xx_rproc_start() needs the DSP to be
 	 * held in reset at the time it is called.
 	 */
-	ret = davinci_clk_reset_assert(drproc->dsp_clk);
+	ret = reset_control_assert(dsp_reset);
 	if (ret)
 		goto free_rproc;
 
-- 
2.17.0
