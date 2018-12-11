Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C740DC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB7C20879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543026;
	bh=k1d9iG+ciuXA+a0XqECqUPBlLrrKRUH8AJUDJXOweGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QNoo4o7+KtL00M6X0HZiUZgF8nlIX1ZlHI7MtfmHEemvGYcxyZb+0u24WUzylrCTw
	 C6MxFYmcQiGofzF95D/P3O0IZBN4I14ncunqbLu4PWNascQoyfGQ2KzOyYwMNwvILC
	 gIFBOEBvstAS0P4gJOoaZeSQ6DETVO0o+7aWq9ck=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB7C20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeLKPnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:43:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:60290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727230AbeLKPnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:43:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FC2D20672;
        Tue, 11 Dec 2018 15:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543022;
        bh=k1d9iG+ciuXA+a0XqECqUPBlLrrKRUH8AJUDJXOweGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y7Uk4dxUqXypi5SpKBRNTrl2J8n6581tQ5qdxnGTfEPvf2L9dU6nGMa8wJJyL4sGx
         y+DOdQrwjQsCTGk5g9uKe7HHXGisRTBe22ZBRgOVh0IOnn23ufFDroxlUb/2kY3Kbi
         bMc3yWRM326khlF0GuGBIdkD7RzaAWyCMp1wKaYA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 3.18 10/54] dmaengine: at_hdmac: fix module unloading
Date:   Tue, 11 Dec 2018 16:40:58 +0100
Message-Id: <20181211151546.552250582@linuxfoundation.org>
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

commit 77e75fda94d2ebb86aa9d35fb1860f6395bf95de upstream.

of_dma_controller_free() was not called on module onloading.
This lead to a soft lockup:
watchdog: BUG: soft lockup - CPU#0 stuck for 23s!
Modules linked in: at_hdmac [last unloaded: at_hdmac]
when of_dma_request_slave_channel() tried to call ofdma->of_dma_xlate().

Cc: stable@vger.kernel.org
Fixes: bbe89c8e3d59 ("at_hdmac: move to generic DMA binding")
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/at_hdmac.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1565,6 +1565,8 @@ static int at_dma_remove(struct platform
 	struct resource		*io;
 
 	at_dma_off(atdma);
+	if (pdev->dev.of_node)
+		of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&atdma->dma_common);
 
 	dma_pool_destroy(atdma->dma_desc_pool);


