Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7218C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A380720675
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 20:52:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="DzJmrvDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfAMUwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 15:52:41 -0500
Received: from vern.gendns.com ([98.142.107.122]:33182 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbfAMUwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 15:52:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Zbc1qDBtT0kpev9b4Xh/gvThwj3HkLwXYK4ivu/axnY=; b=DzJmrvDtt1bAvxp642jXIkUASY
        WFD7Z/wIIyIZjvrLZE/kKZRICt8TRd5G3duNCdrZxDSQy2sr7nH8L+qC+pq0tg1Vmv+UXkEynWi9X
        VYgEjsicOtoRbD/4FyxGwfjOGGjZ96dKWlROj+92qu3dkjd8hC4oEvmABCrdhOGjxf5ThFkOYwIn0
        KO8kEwKhyfNJJWkAJ9Qko7gYCVh/1SZs6eoNdy4gJuswerUrepNFPi3mQG58NaYmL2NDySSP3JkYu
        Ewz7+3MP+oWYSJio384LtP3mJKky636NVueOuILRNU0zTXELQhfg2tV72TUL8IlFIT/ICUFnjLKtA
        ktEEm7NQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:52906 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gimhf-00011U-He; Sun, 13 Jan 2019 15:49:55 -0500
Subject: Re: [PATCH] Revert "spi: omap2-mcspi: Set FIFO DMA trigger level to
 word length"
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Vignesh R <vigneshr@ti.com>, linux-omap@vger.kernel.org
References: <20190113204905.29795-1-david@lechnology.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <7a88c1be-3737-caad-7e8f-5651cbe23248@lechnology.com>
Date:   Sun, 13 Jan 2019 14:52:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190113204905.29795-1-david@lechnology.com>
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

CC: OMAP list for good measure

On 1/13/19 2:49 PM, David Lechner wrote:
> This reverts commit b682cffa3ac6d9d9e16e9b413c45caee3b391fab.
> 
> That commit breaks displays using tinydrm drivers, such as ili9225.
> 
> It causes corruption in the image that is displayed (it looks like only
> 1/2 of the framebuffer data is sent, the other half of the display
> remains blank.)
> 
> The following error appears multiple times:
> 
>      ili9225 spi1.0: EOW timed out
> 
> Eventually, the system locks up without any additional errors.
> 
> Cc: Vignesh R <vigneshr@ti.com>
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>   drivers/spi/spi-omap2-mcspi.c | 26 +++++++++++++++++++-------
>   1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index 2fd8881fcd65..5a3854ff2e08 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -306,7 +306,7 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
>   	struct omap2_mcspi_cs *cs = spi->controller_state;
>   	struct omap2_mcspi *mcspi;
>   	unsigned int wcnt;
> -	int max_fifo_depth, bytes_per_word;
> +	int max_fifo_depth, fifo_depth, bytes_per_word;
>   	u32 chconf, xferlevel;
>   
>   	mcspi = spi_master_get_devdata(master);
> @@ -322,6 +322,10 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
>   		else
>   			max_fifo_depth = OMAP2_MCSPI_MAX_FIFODEPTH;
>   
> +		fifo_depth = gcd(t->len, max_fifo_depth);
> +		if (fifo_depth < 2 || fifo_depth % bytes_per_word != 0)
> +			goto disable_fifo;
> +
>   		wcnt = t->len / bytes_per_word;
>   		if (wcnt > OMAP2_MCSPI_MAX_FIFOWCNT)
>   			goto disable_fifo;
> @@ -329,17 +333,16 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
>   		xferlevel = wcnt << 16;
>   		if (t->rx_buf != NULL) {
>   			chconf |= OMAP2_MCSPI_CHCONF_FFER;
> -			xferlevel |= (bytes_per_word - 1) << 8;
> +			xferlevel |= (fifo_depth - 1) << 8;
>   		}
> -
>   		if (t->tx_buf != NULL) {
>   			chconf |= OMAP2_MCSPI_CHCONF_FFET;
> -			xferlevel |= bytes_per_word - 1;
> +			xferlevel |= fifo_depth - 1;
>   		}
>   
>   		mcspi_write_reg(master, OMAP2_MCSPI_XFERLEVEL, xferlevel);
>   		mcspi_write_chconf0(spi, chconf);
> -		mcspi->fifo_depth = max_fifo_depth;
> +		mcspi->fifo_depth = fifo_depth;
>   
>   		return;
>   	}
> @@ -598,6 +601,7 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
>   	struct dma_slave_config	cfg;
>   	enum dma_slave_buswidth width;
>   	unsigned es;
> +	u32			burst;
>   	void __iomem		*chstat_reg;
>   	void __iomem            *irqstat_reg;
>   	int			wait_res;
> @@ -617,14 +621,22 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
>   	}
>   
>   	count = xfer->len;
> +	burst = 1;
> +
> +	if (mcspi->fifo_depth > 0) {
> +		if (count > mcspi->fifo_depth)
> +			burst = mcspi->fifo_depth / es;
> +		else
> +			burst = count / es;
> +	}
>   
>   	memset(&cfg, 0, sizeof(cfg));
>   	cfg.src_addr = cs->phys + OMAP2_MCSPI_RX0;
>   	cfg.dst_addr = cs->phys + OMAP2_MCSPI_TX0;
>   	cfg.src_addr_width = width;
>   	cfg.dst_addr_width = width;
> -	cfg.src_maxburst = es;
> -	cfg.dst_maxburst = es;
> +	cfg.src_maxburst = burst;
> +	cfg.dst_maxburst = burst;
>   
>   	rx = xfer->rx_buf;
>   	tx = xfer->tx_buf;
> 

