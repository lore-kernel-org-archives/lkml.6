Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752639AbeC3PaM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 11:30:12 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:56117 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeC3P3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 11:29:08 -0400
X-Google-Smtp-Source: AIpwx48pOSIvzY892HtfXjafWzulgE+h5hho9yLiKz6mHP/xnyQ4fzPN+QjTORN/xdgtM6qdJYYY1Q==
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
Subject: [PATCH v5 5/8] remoteproc/davinci: prepare and unprepare the clock where needed
Date: Fri, 30 Mar 2018 17:28:53 +0200
Message-Id: <20180330152856.12297-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180330152856.12297-1-brgl@bgdev.pl>
References: <20180330152856.12297-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We're currently switching the platform to using the common clock
framework. We need to explicitly prepare and unprepare the rproc
clock.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/da8xx_remoteproc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index 2b24291337b7..f134192922e0 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -149,9 +149,9 @@ static int da8xx_rproc_start(struct rproc *rproc)
 
 	writel(rproc->bootaddr, drproc->bootreg);
 
-	ret = clk_enable(dsp_clk);
+	ret = clk_prepare_enable(dsp_clk);
 	if (ret) {
-		dev_err(dev, "clk_enable() failed: %d\n", ret);
+		dev_err(dev, "clk_prepare_enable() failed: %d\n", ret);
 		return ret;
 	}
 
@@ -165,7 +165,7 @@ static int da8xx_rproc_stop(struct rproc *rproc)
 	struct da8xx_rproc *drproc = rproc->priv;
 
 	davinci_clk_reset_assert(drproc->dsp_clk);
-	clk_disable(drproc->dsp_clk);
+	clk_disable_unprepare(drproc->dsp_clk);
 
 	return 0;
 }
-- 
2.16.3
