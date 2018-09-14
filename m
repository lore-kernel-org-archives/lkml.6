Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E7EECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9435720882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9435720882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeINWVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 18:21:40 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37851 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbeINWVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 18:21:40 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7] helo=dude.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1g0rXr-0000yl-Lz; Fri, 14 Sep 2018 19:06:15 +0200
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robin Gong <yibin.gong@nxp.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, patchwork-lst@pengutronix.de
Subject: [PATCH v2 4/4] dmaengine: imx-sdma: use GFP_NOWAIT for dma allocations
Date:   Fri, 14 Sep 2018 19:06:15 +0200
Message-Id: <20180914170615.12659-4-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180914170615.12659-1-l.stach@pengutronix.de>
References: <20180914170615.12659-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA buffer descriptors aren't allocated from atomic context, so they
can use the less heavyweigth GFP_NOWAIT.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/dma/imx-sdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index da41e8fbf151..ac189d3d985c 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1213,7 +1213,7 @@ static int sdma_alloc_bd(struct sdma_desc *desc)
 	int ret = 0;
 
 	desc->bd = dma_zalloc_coherent(NULL, bd_size, &desc->bd_phys,
-					GFP_ATOMIC);
+					GFP_NOWAIT);
 	if (!desc->bd) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.19.0

