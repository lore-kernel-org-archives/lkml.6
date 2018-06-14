Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DDC86C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D5A208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnKczCYB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93D5A208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965060AbeFNOHf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:07:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965022AbeFNOHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:07:31 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25FAA208DB;
        Thu, 14 Jun 2018 14:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985250;
        bh=L2gJNXJRvXdtxoq/D+rcEHZfUHprRsFLmWRIReWVo6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BnKczCYBRoUwbgDZukxcC6hOZXZcMumACGU0QHCd5vs8ocbBl5ZKG6qcDg82LX8Uu
         i2qf0uS5Zk+uX/1rRBKE+MQiLFmIQFtYvKCxj3A9Tb09cTUlsCfyHfPMnIlQ29OfaT
         RnjoIX37HyDZ+LTOt46J+4uqYUgdGtoLjC1UJe5w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.17 27/45] serial: samsung: fix maxburst parameter for DMA transactions
Date:   Thu, 14 Jun 2018 16:04:18 +0200
Message-Id: <20180614132128.260306315@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132126.797006529@linuxfoundation.org>
References: <20180614132126.797006529@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit aa2f80e752c75e593b3820f42c416ed9458fa73e upstream.

The best granularity of residue that DMA engine can report is in the BURST
units, so the serial driver must use MAXBURST = 1 and DMA_SLAVE_BUSWIDTH_1_BYTE
if it relies on exact number of bytes transferred by DMA engine.

Fixes: 62c37eedb74c ("serial: samsung: add dma reqest/release functions")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/samsung.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -862,15 +862,12 @@ static int s3c24xx_serial_request_dma(st
 	dma->rx_conf.direction		= DMA_DEV_TO_MEM;
 	dma->rx_conf.src_addr_width	= DMA_SLAVE_BUSWIDTH_1_BYTE;
 	dma->rx_conf.src_addr		= p->port.mapbase + S3C2410_URXH;
-	dma->rx_conf.src_maxburst	= 16;
+	dma->rx_conf.src_maxburst	= 1;
 
 	dma->tx_conf.direction		= DMA_MEM_TO_DEV;
 	dma->tx_conf.dst_addr_width	= DMA_SLAVE_BUSWIDTH_1_BYTE;
 	dma->tx_conf.dst_addr		= p->port.mapbase + S3C2410_UTXH;
-	if (dma_get_cache_alignment() >= 16)
-		dma->tx_conf.dst_maxburst = 16;
-	else
-		dma->tx_conf.dst_maxburst = 1;
+	dma->tx_conf.dst_maxburst	= 1;
 
 	dma->rx_chan = dma_request_chan(p->port.dev, "rx");
 


