Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbeEBJ5U (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 05:57:20 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41829 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751503AbeEBJ5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 05:57:12 -0400
X-Google-Smtp-Source: AB8JxZohMalXFBpZYEi52m8cVBsDjmb+3pA+kwt+pvamn6FCV7Lyx2NDKg+ILJX1/KEjdkLjsNz7QA==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>,
        Suman Anna <s-anna@ti.com>, Aparna Balasubramanian <aparnab@ti.com>,
        Kevin Hilman <khilman@kernel.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 2/3] remoteproc/davinci: prepare and unprepare the clock where needed
Date: Wed,  2 May 2018 11:56:58 +0200
Message-Id: <20180502095659.3626-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180502095659.3626-1-brgl@bgdev.pl>
References: <20180502095659.3626-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We're currently switching the platform to using the common clock
framework. We need to explicitly prepare and unprepare the rproc
clock.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Suman Anna <s-anna@ti.com>
Reviewed-by: David Lechner <david@lechnology.com>
Reviewed-by: Sekhar Nori <nsekhar@ti.com>
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
2.17.0
