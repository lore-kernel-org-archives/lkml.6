Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752907AbeDSNM6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:12:58 -0400
Received: from agrajag.zerfleddert.de ([88.198.237.222]:55590 "EHLO
        agrajag.zerfleddert.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752326AbeDSNMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:12:55 -0400
Date: Thu, 19 Apr 2018 15:02:54 +0200
From: Stefan Potyra <Stefan.Potyra@elektrobit.com>
To: Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org
Cc: ldv-project@linuxtesting.org, sil2review@lists.osadl.org
Subject: [PATCH] Enable clock before calling clk_get_rate() on it.
Message-ID: <20180419130254.7nriykiybpyi6j2g@agrajag.zerfleddert.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the API, you may only call clk_get_rate() after actually
enabling it.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: a5fd9139f74c w1: add 1-wire master driver for i.MX27 / i.MX31
Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
---
 drivers/w1/masters/mxc_w1.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/w1/masters/mxc_w1.c b/drivers/w1/masters/mxc_w1.c
index 74f2e6e6202a..a9599027d4ef 100644
--- a/drivers/w1/masters/mxc_w1.c
+++ b/drivers/w1/masters/mxc_w1.c
@@ -112,6 +112,10 @@ static int mxc_w1_probe(struct platform_device *pdev)
 	if (IS_ERR(mdev->clk))
 		return PTR_ERR(mdev->clk);
 
+	err = clk_prepare_enable(mdev->clk);
+	if (err)
+		return err;
+
 	clkrate = clk_get_rate(mdev->clk);
 	if (clkrate < 10000000)
 		dev_warn(&pdev->dev,
@@ -128,10 +132,6 @@ static int mxc_w1_probe(struct platform_device *pdev)
 	if (IS_ERR(mdev->regs))
 		return PTR_ERR(mdev->regs);
 
-	err = clk_prepare_enable(mdev->clk);
-	if (err)
-		return err;
-
 	/* Software reset 1-Wire module */
 	writeb(MXC_W1_RESET_RST, mdev->regs + MXC_W1_RESET);
 	writeb(0, mdev->regs + MXC_W1_RESET);
-- 
2.17.0
