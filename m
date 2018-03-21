Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752024AbeCUMJY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 08:09:24 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:47097 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751883AbeCUMIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 08:08:36 -0400
X-Google-Smtp-Source: AG47ELtH8s8pBsuVOrRQbhj1Bd01g2CktdHBkJfv+DudDvFSaDN5urtda1sKqasAaiH4Uu1UMZpZMg==
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
Subject: [PATCH 6/8] remoteproc: da8xx: prepare and unprepare the clock where needed
Date: Wed, 21 Mar 2018 13:08:05 +0100
Message-Id: <20180321120807.18032-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180321120807.18032-1-brgl@bgdev.pl>
References: <20180321120807.18032-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We're currently switching the platform to using the common clock
framework. We need to explicitly prepare and unprepare the rproc
clock.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/remoteproc/da8xx_remoteproc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index 592bf0fc52e8..83f2d66ad3a9 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -149,9 +149,9 @@ static int da8xx_rproc_start(struct rproc *rproc)
 
 	writel(rproc->bootaddr, drproc->bootreg);
 
-	rv = clk_enable(dsp_clk);
+	rv = clk_prepare_enable(dsp_clk);
 	if (rv) {
-		dev_err(dev, "clk_enable() failed: %d\n", rv);
+		dev_err(dev, "clk_prepare_enable() failed: %d\n", rv);
 		return rv;
 	}
 
@@ -165,7 +165,7 @@ static int da8xx_rproc_stop(struct rproc *rproc)
 	struct da8xx_rproc *drproc = rproc->priv;
 
 	davinci_clk_reset_assert(drproc->dsp_clk);
-	clk_disable(drproc->dsp_clk);
+	clk_disable_unprepare(drproc->dsp_clk);
 
 	return 0;
 }
-- 
2.16.1
