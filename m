Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF75EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7852080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A7852080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbeKLF47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:56:59 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52140 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727208AbeKLF47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:56:59 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvtD-0000l9-L9; Sun, 11 Nov 2018 19:59:23 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsO-0001Ol-Cg; Sun, 11 Nov 2018 19:58:32 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Tobias Jordan" <Tobias.Jordan@elektrobit.com>,
        "Mark Brown" <broonie@kernel.org>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.493844590@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 034/366] spi: pxa2xx: check clk_prepare_enable()
 return value
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tobias Jordan <Tobias.Jordan@elektrobit.com>

commit 62bbc864d1946c715063bd481bff3641fd1324e2 upstream.

clk_prepare_enable() can fail, so its return value should be checked and
acted upon.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 3343b7a6d2cd ("spi/pxa2xx: convert to the common clk framework")
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/spi/spi-pxa2xx.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1182,7 +1182,9 @@ static int pxa2xx_spi_probe(struct platf
 	}
 
 	/* Enable SOC clock */
-	clk_prepare_enable(ssp->clk);
+	status = clk_prepare_enable(ssp->clk);
+	if (status)
+		goto out_error_dma_irq_alloc;
 
 	drv_data->max_clk_rate = clk_get_rate(ssp->clk);
 
@@ -1221,6 +1223,8 @@ static int pxa2xx_spi_probe(struct platf
 
 out_error_clock_enabled:
 	clk_disable_unprepare(ssp->clk);
+
+out_error_dma_irq_alloc:
 	pxa2xx_spi_dma_release(drv_data);
 	free_irq(ssp->irq, drv_data);
 
@@ -1296,8 +1300,11 @@ static int pxa2xx_spi_resume(struct devi
 	pxa2xx_spi_dma_resume(drv_data);
 
 	/* Enable the SSP clock */
-	if (!pm_runtime_suspended(dev))
-		clk_prepare_enable(ssp->clk);
+	if (!pm_runtime_suspended(dev)) {
+		status = clk_prepare_enable(ssp->clk);
+		if (status)
+			return status;
+	}
 
 	/* Restore LPSS private register bits */
 	lpss_ssp_setup(drv_data);
@@ -1325,9 +1332,10 @@ static int pxa2xx_spi_runtime_suspend(st
 static int pxa2xx_spi_runtime_resume(struct device *dev)
 {
 	struct driver_data *drv_data = dev_get_drvdata(dev);
+	int status;
 
-	clk_prepare_enable(drv_data->ssp->clk);
-	return 0;
+	status = clk_prepare_enable(drv_data->ssp->clk);
+	return status;
 }
 #endif
 

