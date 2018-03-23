Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754704AbeCWLrz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 07:47:55 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46821 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754351AbeCWLrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 07:47:24 -0400
X-Google-Smtp-Source: AG47ELuosgz5rMwHywatqus/l/DJsy3lgaifK1NtFZzpHoP2j91RDJpOHPyWA2K7mp808lcAqHtb0Q==
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
Subject: [PATCH v3 7/8] remoteproc: da8xx: use the reset framework
Date: Fri, 23 Mar 2018 12:47:08 +0100
Message-Id: <20180323114709.20330-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180323114709.20330-1-brgl@bgdev.pl>
References: <20180323114709.20330-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Switch to using the reset framework instead of handcoded reset routines
we used so far.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/remoteproc/da8xx_remoteproc.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index f134192922e0..3689473f8b49 100644
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
@@ -155,7 +156,11 @@ static int da8xx_rproc_start(struct rproc *rproc)
 		return ret;
 	}
 
-	davinci_clk_reset_deassert(dsp_clk);
+	ret = reset_control_deassert(dsp_reset);
+	if (ret) {
+		dev_err(dev, "reset_control_deassert() failed: %d\n", ret);
+		return ret;
+	}
 
 	return 0;
 }
@@ -163,8 +168,15 @@ static int da8xx_rproc_start(struct rproc *rproc)
 static int da8xx_rproc_stop(struct rproc *rproc)
 {
 	struct da8xx_rproc *drproc = rproc->priv;
+	int ret;
+
+	ret = reset_control_assert(drproc->dsp_reset);
+	if (ret) {
+		dev_err(rproc->dev.parent,
+			"reset_control_assert() failed: %d\n", ret);
+		return ret;
+	}
 
-	davinci_clk_reset_assert(drproc->dsp_clk);
 	clk_disable_unprepare(drproc->dsp_clk);
 
 	return 0;
@@ -232,6 +244,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 	struct resource *bootreg_res;
 	struct resource *chipsig_res;
 	struct clk *dsp_clk;
+	struct reset_control *dsp_reset;
 	void __iomem *chipsig;
 	void __iomem *bootreg;
 	int irq;
@@ -268,6 +281,15 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
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
@@ -309,7 +331,7 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 	 * *not* in reset, but da8xx_rproc_start() needs the DSP to be
 	 * held in reset at the time it is called.
 	 */
-	ret = davinci_clk_reset_assert(drproc->dsp_clk);
+	ret = reset_control_assert(dsp_reset);
 	if (ret)
 		goto free_rproc;
 
-- 
2.16.1
