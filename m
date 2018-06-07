Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vQ4lHilHGVvQOwAAmS7hNA
	; Thu, 07 Jun 2018 14:55:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 610956074D; Thu,  7 Jun 2018 14:55:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A7F5A601C3;
	Thu,  7 Jun 2018 14:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A7F5A601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964783AbeFGOzI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:55:08 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41042 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935441AbeFGOzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:55:04 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbs-0005Zs-N8; Thu, 07 Jun 2018 15:09:52 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb1-0002p7-9A; Thu, 07 Jun 2018 15:08:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Mark Brown" <broonie@kernel.org>,
        "Stefan Agner" <stefan@agner.ch>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.560584185@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 098/410] spi: imx: do not access registers while
 clocks disabled
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Agner <stefan@agner.ch>

commit d593574aff0ab846136190b1729c151c736727ec upstream.

Since clocks are disabled except during message transfer clocks
are also disabled when spi_imx_remove gets called. Accessing
registers leads to a freeeze at least on a i.MX 6ULL. Enable
clocks before disabling accessing the MXC_CSPICTRL register.

Fixes: 9e556dcc55774 ("spi: spi-imx: only enable the clocks when we start to transfer a message")
Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Mark Brown <broonie@kernel.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/spi/spi-imx.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -943,12 +943,23 @@ static int spi_imx_remove(struct platfor
 {
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
+	int ret;
 
 	spi_bitbang_stop(&spi_imx->bitbang);
 
+	ret = clk_enable(spi_imx->clk_per);
+	if (ret)
+		return ret;
+
+	ret = clk_enable(spi_imx->clk_ipg);
+	if (ret) {
+		clk_disable(spi_imx->clk_per);
+		return ret;
+	}
+
 	writel(0, spi_imx->base + MXC_CSPICTRL);
-	clk_unprepare(spi_imx->clk_ipg);
-	clk_unprepare(spi_imx->clk_per);
+	clk_disable_unprepare(spi_imx->clk_ipg);
+	clk_disable_unprepare(spi_imx->clk_per);
 	spi_master_put(master);
 
 	return 0;
