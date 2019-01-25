Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1DDC282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB2B217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="S/T368i0";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="S/T368i0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfAYCzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 21:55:41 -0500
Received: from node.akkea.ca ([192.155.83.177]:52092 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbfAYCzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 21:55:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 941FC4E2051;
        Fri, 25 Jan 2019 02:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548384937; bh=+JXGIVucnYCY0cluddvyVeHVzItz/VTc2jupzPlE5mk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=S/T368i0EE27Nh6XHcxhO1cbGHBeLDfxuHZ5N8hx6l+DAEHXkNUG6vShI91PFEH7c
         fY2Q6hN0bu9dtF7QyKs+brb281XIiCsHYKwnp6xT7gLLuVOupR6Bb0GjzZnF1WjIQ/
         CLbrNz2JEkVOPgIILCjns859Z4HZn2A+GGi1/Tcw=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yz-2hxMqnySQ; Fri, 25 Jan 2019 02:55:37 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id 8ADFE4E204D;
        Fri, 25 Jan 2019 02:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1548384937; bh=+JXGIVucnYCY0cluddvyVeHVzItz/VTc2jupzPlE5mk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=S/T368i0EE27Nh6XHcxhO1cbGHBeLDfxuHZ5N8hx6l+DAEHXkNUG6vShI91PFEH7c
         fY2Q6hN0bu9dtF7QyKs+brb281XIiCsHYKwnp6xT7gLLuVOupR6Bb0GjzZnF1WjIQ/
         CLbrNz2JEkVOPgIILCjns859Z4HZn2A+GGi1/Tcw=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus@akkea.ca
Cc:     angus.ainslie@puri.sm, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: [PATCH v4 1/5] dmaengine: imx-sdma: add clock ratio 1:1 check
Date:   Thu, 24 Jan 2019 19:55:24 -0700
Message-Id: <20190125025528.15645-2-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190125025528.15645-1-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
 <20190125025528.15645-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On i.mx8 mscale B0 chip, AHB/SDMA clock ratio 2:1 can't be supportted,
since SDMA clock ratio has to be increased to 250Mhz, AHB can't reach
to 500Mhz, so use 1:1 instead.

Based on NXP commit MLK-16841-1 by Robin Gong <yibin.gong@nxp.com>

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/dma/imx-sdma.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 0b3a67ff8e82..5e5ef0b5a973 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -440,6 +440,8 @@ struct sdma_engine {
 	unsigned int			irq;
 	dma_addr_t			bd0_phys;
 	struct sdma_buffer_descriptor	*bd0;
+	/* clock ratio for AHB:SDMA core. 1:1 is 1, 2:1 is 0*/
+	bool				clk_ratio;
 };
 
 static int sdma_config_write(struct dma_chan *chan,
@@ -662,8 +664,14 @@ static int sdma_run_channel0(struct sdma_engine *sdma)
 		dev_err(sdma->dev, "Timeout waiting for CH0 ready\n");
 
 	/* Set bits of CONFIG register with dynamic context switching */
-	if (readl(sdma->regs + SDMA_H_CONFIG) == 0)
-		writel_relaxed(SDMA_H_CONFIG_CSM, sdma->regs + SDMA_H_CONFIG);
+	if ((readl(sdma->regs + SDMA_H_CONFIG) & ~SDMA_H_CONFIG_ACR) == 0) {
+		reg = SDMA_H_CONFIG_CSM;
+
+		if (sdma->clk_ratio)
+			reg |= SDMA_H_CONFIG_ACR;
+
+		writel_relaxed(reg, sdma->regs + SDMA_H_CONFIG);
+	}
 
 	return ret;
 }
@@ -1840,6 +1848,9 @@ static int sdma_init(struct sdma_engine *sdma)
 	if (ret)
 		goto disable_clk_ipg;
 
+	if (clk_get_rate(sdma->clk_ahb) == clk_get_rate(sdma->clk_ipg))
+		sdma->clk_ratio = 1;
+
 	/* Be sure SDMA has not started yet */
 	writel_relaxed(0, sdma->regs + SDMA_H_C0PTR);
 
@@ -1880,8 +1891,10 @@ static int sdma_init(struct sdma_engine *sdma)
 	writel_relaxed(0x4050, sdma->regs + SDMA_CHN0ADDR);
 
 	/* Set bits of CONFIG register but with static context switching */
-	/* FIXME: Check whether to set ACR bit depending on clock ratios */
-	writel_relaxed(0, sdma->regs + SDMA_H_CONFIG);
+	if (sdma->clk_ratio)
+		writel_relaxed(SDMA_H_CONFIG_ACR, sdma->regs + SDMA_H_CONFIG);
+	else
+		writel_relaxed(0, sdma->regs + SDMA_H_CONFIG);
 
 	writel_relaxed(ccb_phys, sdma->regs + SDMA_H_C0PTR);
 
-- 
2.17.1

