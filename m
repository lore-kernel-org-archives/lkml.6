Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE5CC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 289A62073D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbfBCO3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:29:25 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55424 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728678AbfBCOUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:20:30 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIdJ-0006JZ-47; Sun, 03 Feb 2019 14:20:29 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9n-0007L0-RC; Sun, 03 Feb 2019 14:49:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Richard Genoud" <richard.genoud@gmail.com>,
        "Vinod Koul" <vkoul@kernel.org>,
        "Ludovic Desroches" <ludovic.desroches@microchip.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.288037895@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 248/305] dmaengine: at_hdmac: fix module unloading
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Genoud <richard.genoud@gmail.com>

commit 77e75fda94d2ebb86aa9d35fb1860f6395bf95de upstream.

of_dma_controller_free() was not called on module onloading.
This lead to a soft lockup:
watchdog: BUG: soft lockup - CPU#0 stuck for 23s!
Modules linked in: at_hdmac [last unloaded: at_hdmac]
when of_dma_request_slave_channel() tried to call ofdma->of_dma_xlate().

Fixes: bbe89c8e3d59 ("at_hdmac: move to generic DMA binding")
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/dma/at_hdmac.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1564,6 +1564,8 @@ static int at_dma_remove(struct platform
 	struct resource		*io;
 
 	at_dma_off(atdma);
+	if (pdev->dev.of_node)
+		of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&atdma->dma_common);
 
 	dma_pool_destroy(atdma->dma_desc_pool);

