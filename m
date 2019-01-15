Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC0FC43612
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BAB220651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="HSfDUmwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388010AbfAOQvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:51:38 -0500
Received: from vern.gendns.com ([98.142.107.122]:59584 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730341AbfAOQsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2y4o+6mJsGkK+PV2yCqMO7SbJ2MDZ2GrQ9Zsgwpscko=; b=HSfDUmwYqUKR8HWuJ40/jxQDAl
        Ia9bu//xf6vNmoSX/OCivR18vJbsxEzmEVELXBlwvljFK52CLkYTee3U31+8gb3iKpP2ALn203KgH
        EFria1dl0ee30roLsk3mKiHetSkOScFQs4U4pkVjnQAkMW7csWf8dbqr4/fli9e4+Ry41CF67q5HS
        9R1XQW/xPFcgILxj803lcNzfUlXM1AbQtHCea1SBBE2D/Xe11vSibowy3q3ygIxxjxTNplMOVCXLu
        GAlmYgOYva9bRzbzViOTGNUUOU7K8JLSrkZ20Hn65KR7BBm4xyBd/JlcxmfVkPqfnNjwYz5zT728C
        qdVfV0hQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:52774 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gjRqY-0008La-4u; Tue, 15 Jan 2019 11:45:50 -0500
Subject: Re: [PATCH] spi: omap2-mcspi: Fix DMA and FIFO event trigger size
 mismatch
To:     Vignesh R <vigneshr@ti.com>, Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
References: <20190115065832.23705-1-vigneshr@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <6a923c36-2b61-9f9c-d965-b99dc6831070@lechnology.com>
Date:   Tue, 15 Jan 2019 10:48:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190115065832.23705-1-vigneshr@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/19 12:58 AM, Vignesh R wrote:
> Commit b682cffa3ac6 ("spi: omap2-mcspi: Set FIFO DMA trigger level to word length")
> broke SPI transfers where bits_per_word != 8. This is because of
> mimsatch between McSPI FIFO level event trigger size (SPI word length) and
> DMA request size(word length * maxburst). This leads to data
> corruption, lockup and errors like:
> 
> 	spi1.0: EOW timed out
> 
> Fix this by setting DMA maxburst size to 1 so that
> McSPI FIFO level event trigger size matches DMA request size.
> 
> Fixes: b682cffa3ac6 ("spi: omap2-mcspi: Set FIFO DMA trigger level to word length")
> Cc: stable@vger.kernel.org
> Reported-by: David Lechner <david@lechnology.com>
> Tested-by: David Lechner <david@lechnology.com>
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>   drivers/spi/spi-omap2-mcspi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index 2fd8881fcd65..8be304379628 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -623,8 +623,8 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
>   	cfg.dst_addr = cs->phys + OMAP2_MCSPI_TX0;
>   	cfg.src_addr_width = width;
>   	cfg.dst_addr_width = width;
> -	cfg.src_maxburst = es;
> -	cfg.dst_maxburst = es;
> +	cfg.src_maxburst = 1;
> +	cfg.dst_maxburst = 1;
>   
>   	rx = xfer->rx_buf;
>   	tx = xfer->tx_buf;
> 

Works for me.
