Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751681AbeEBJ56 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 05:57:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40822 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbeEBJ5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 05:57:11 -0400
X-Google-Smtp-Source: AB8JxZoSLrOnWCZ13A3ff65kRIPOk8tVVSHocR5OVqEcVrruBbRoKHOUwQO5DkquK8hUtZpD3lq8zg==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>,
        Suman Anna <s-anna@ti.com>, Aparna Balasubramanian <aparnab@ti.com>,
        Kevin Hilman <khilman@kernel.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/3] remoteproc/davinci: add the missing retval check for clk_enable()
Date: Wed,  2 May 2018 11:56:57 +0200
Message-Id: <20180502095659.3626-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180502095659.3626-1-brgl@bgdev.pl>
References: <20180502095659.3626-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The davinci platform is being switched to using the common clock
framework, where clk_enable() can fail. Add the return value check.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Suman Anna <s-anna@ti.com>
Reviewed-by: David Lechner <david@lechnology.com>
Reviewed-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/remoteproc/da8xx_remoteproc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index bf3b9034c319..2b24291337b7 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -138,6 +138,7 @@ static int da8xx_rproc_start(struct rproc *rproc)
 	struct device *dev = rproc->dev.parent;
 	struct da8xx_rproc *drproc = (struct da8xx_rproc *)rproc->priv;
 	struct clk *dsp_clk = drproc->dsp_clk;
+	int ret;
 
 	/* hw requires the start (boot) address be on 1KB boundary */
 	if (rproc->bootaddr & 0x3ff) {
@@ -148,7 +149,12 @@ static int da8xx_rproc_start(struct rproc *rproc)
 
 	writel(rproc->bootaddr, drproc->bootreg);
 
-	clk_enable(dsp_clk);
+	ret = clk_enable(dsp_clk);
+	if (ret) {
+		dev_err(dev, "clk_enable() failed: %d\n", ret);
+		return ret;
+	}
+
 	davinci_clk_reset_deassert(dsp_clk);
 
 	return 0;
-- 
2.17.0
