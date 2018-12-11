Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F18C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C73520672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544542999;
	bh=ySb37fN7qESseO3/QjgNILzU3A15PrGjWQJsHQpWViI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IVSRjiIFuSrVcwj8A36IkEoFoWlAMGbwqOS6m4z0feLlJwEVZf6U5EyaXDDHYnlpx
	 sv1iLmc841DQFUSbj2inrGc1fAGav+Rz4GLSfkY+wE22l5ieiX2Q41Pi/16sy5DVGl
	 TyYBU9BseSfVsmhrCbV2AFUrSgKrKeTQqt2d6HEM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C73520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeLKPnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:43:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:59720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbeLKPnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:43:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0C55208E7;
        Tue, 11 Dec 2018 15:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544542995;
        bh=ySb37fN7qESseO3/QjgNILzU3A15PrGjWQJsHQpWViI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QD18NHb20l41Tm9w1a7isV4iUu1HGgkiXEgaFzZQE7685sGeKgyDYO+CpAYLsKxbT
         5p3Y1acxQ/KtTMk4PGjGes+f8O0GmTUIOtVlnZc7/7ne84WMa3Gf4wMyVs3D5u5vFL
         zKJI00iiKZgqj83+yIFRYcTvntA+HQSTbxNOq+s4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mario Forner <m.forner@be4energy.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 3.18 09/54] dmaengine: at_hdmac: fix memory leak in at_dma_xlate()
Date:   Tue, 11 Dec 2018 16:40:57 +0100
Message-Id: <20181211151546.497323659@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151546.010073210@linuxfoundation.org>
References: <20181211151546.010073210@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1232,6 +1232,12 @@ static void atc_free_chan_resources(stru
 	atchan->status = 0;
 	atchan->remain_desc = 0;
 
+	/*
+	 * Free atslave allocated in at_dma_xlate()
+	 */
+	kfree(chan->private);
+	chan->private = NULL;
+
 	dev_vdbg(chan2dev(chan), "free_chan_resources: done\n");
 }
 
@@ -1266,7 +1272,7 @@ static struct dma_chan *at_dma_xlate(str
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	atslave = devm_kzalloc(&dmac_pdev->dev, sizeof(*atslave), GFP_KERNEL);
+	atslave = kzalloc(sizeof(*atslave), GFP_KERNEL);
 	if (!atslave)
 		return NULL;
 


