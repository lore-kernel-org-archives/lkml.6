Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CD3C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D635208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543158;
	bh=/uO9LvegOskOtYpNYJAyqXYSD9VwhWhBLsjwCBTgZJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H/i9BVigz5Pkn0SMRnL/ngVsQ7P2ERwHDwUUMraybUL6rgL+4t0rS+iW6DBBIUVfJ
	 4Yq3ijoSoEA/CrWQdZLnyiOJ4UrOlryULrOuICUpJJ/b+/rLC7KDVdbNfrRtxbvyWK
	 +F/Qylgl9WO7OfuMAwqYgr5CX02SMZU4fV1s7WZQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D635208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeLKPp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:45:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:34252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728199AbeLKPpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:45:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 051252087F;
        Tue, 11 Dec 2018 15:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543153;
        bh=/uO9LvegOskOtYpNYJAyqXYSD9VwhWhBLsjwCBTgZJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EHki8lFyWAIZBOm/+GEz6hrdVDZl92xrtwsv+PAuJZEKlkIkoOsdmnRkP2BI8LLJ0
         JXMWzVr2tgjYzA19jTL30/F855pTpd2k6rMuR2C57xOJfK68R6hc+WQciAvHS4Mrhp
         sepPvLEQ7HUoD4h8dF1c45erxxUpQ/ldnLAE8q8c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mario Forner <m.forner@be4energy.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4.4 15/91] dmaengine: at_hdmac: fix memory leak in at_dma_xlate()
Date:   Tue, 11 Dec 2018 16:40:34 +0100
Message-Id: <20181211151607.136130436@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Genoud <richard.genoud@gmail.com>

commit 98f5f932254b88ce828bc8e4d1642d14e5854caa upstream.

The leak was found when opening/closing a serial port a great number of
time, increasing kmalloc-32 in slabinfo.

Each time the port was opened, dma_request_slave_channel() was called.
Then, in at_dma_xlate(), atslave was allocated with devm_kzalloc() and
never freed. (Well, it was free at module unload, but that's not what we
want).
So, here, kzalloc is more suited for the job since it has to be freed in
atc_free_chan_resources().

Cc: stable@vger.kernel.org
Fixes: bbe89c8e3d59 ("at_hdmac: move to generic DMA binding")
Reported-by: Mario Forner <m.forner@be4energy.com>
Suggested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/at_hdmac.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1781,6 +1781,12 @@ static void atc_free_chan_resources(stru
 	atchan->descs_allocated = 0;
 	atchan->status = 0;
 
+	/*
+	 * Free atslave allocated in at_dma_xlate()
+	 */
+	kfree(chan->private);
+	chan->private = NULL;
+
 	dev_vdbg(chan2dev(chan), "free_chan_resources: done\n");
 }
 
@@ -1815,7 +1821,7 @@ static struct dma_chan *at_dma_xlate(str
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	atslave = devm_kzalloc(&dmac_pdev->dev, sizeof(*atslave), GFP_KERNEL);
+	atslave = kzalloc(sizeof(*atslave), GFP_KERNEL);
 	if (!atslave)
 		return NULL;
 


