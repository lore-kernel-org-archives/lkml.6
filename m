Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CB8C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B43214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sqk83wd/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B43214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbeLDLGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:06:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:55328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbeLDLGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:06:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9776F214ED;
        Tue,  4 Dec 2018 11:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921603;
        bh=HaMUVOMSfgU0COGJcmxXSJBmnWgyu7kI4u12bqiOYWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sqk83wd/l3xwLdHCW49DzA99YlXKQ6xxLrpGVQV5RX6KlgjhA5yRvSv7QNQQ6XGHG
         6G4cx6DY9+G5EMpHjqU3EQ4b/W44oyMLs0y9aEQ2iQvEoNp/96peVWzefzDS8hhRmU
         q+gMuw17Qm6SP/t1Nj3rX1BlgaJlsQe8VyozhyOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Richard Genoud <richard.genoud@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 4.14 134/146] dmaengine: at_hdmac: fix module unloading
Date:   Tue,  4 Dec 2018 11:50:20 +0100
Message-Id: <20181204103732.218690857@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2006,6 +2006,8 @@ static int at_dma_remove(struct platform
 	struct resource		*io;
 
 	at_dma_off(atdma);
+	if (pdev->dev.of_node)
+		of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&atdma->dma_common);
 
 	dma_pool_destroy(atdma->memset_pool);


