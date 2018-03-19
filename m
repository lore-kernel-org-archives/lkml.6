Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972375AbeCSWOU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 18:14:20 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:44984 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S972327AbeCSWON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 18:14:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Mar 2018 23:14:11 +0100
From: Stefan Agner <stefan@agner.ch>
To: broonie@kernel.org
Cc: geert+renesas@glider.be, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: rspi: use correct enum for DMA transfer direction
In-Reply-To: <20180319214231.15529-1-stefan@agner.ch>
References: <20180319214231.15529-1-stefan@agner.ch>
Message-ID: <8da7711094622e4c84316ce1d5a96d0c@agner.ch>
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.03.2018 22:42, Stefan Agner wrote:
> Use enum dma_transfer_direction as required by dmaengine_prep_slave_sg
> instead of enum dma_data_direction.
> 
> This fixes two warnings when building with clang:
>   drivers/spi/spi-rspi.c:538:26: warning: implicit conversion from enumeration
>       type 'enum dma_data_direction' to different enumeration type
>       'enum dma_transfer_direction' [-Wenum-conversion]
>                                         rx->sgl, rx->nents, DMA_FROM_DEVICE,
>                                                             ^~~~~~~~~~~~~~~
>   drivers/spi/spi-rspi.c:558:26: warning: implicit conversion from enumeration
>       type 'enum dma_data_direction' to different enumeration type
>       'enum dma_transfer_direction' [-Wenum-conversion]
>                                         tx->sgl, tx->nents, DMA_TO_DEVICE,
>                                                             ^~~~~~~~~~~~~
> 

Please ignore this patch, I managed to mix up the direction. Will send a
v2.

--
Stefan

> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  drivers/spi/spi-rspi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
> index 0835a8d88fb8..3e5a31d338fe 100644
> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -535,7 +535,7 @@ static int rspi_dma_transfer(struct rspi_data
> *rspi, struct sg_table *tx,
>  	/* First prepare and submit the DMA request(s), as this may fail */
>  	if (rx) {
>  		desc_rx = dmaengine_prep_slave_sg(rspi->master->dma_rx,
> -					rx->sgl, rx->nents, DMA_FROM_DEVICE,
> +					rx->sgl, rx->nents, DMA_MEM_TO_DEV,
>  					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>  		if (!desc_rx) {
>  			ret = -EAGAIN;
> @@ -555,7 +555,7 @@ static int rspi_dma_transfer(struct rspi_data
> *rspi, struct sg_table *tx,
>  
>  	if (tx) {
>  		desc_tx = dmaengine_prep_slave_sg(rspi->master->dma_tx,
> -					tx->sgl, tx->nents, DMA_TO_DEVICE,
> +					tx->sgl, tx->nents, DMA_DEV_TO_MEM,
>  					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>  		if (!desc_tx) {
>  			ret = -EAGAIN;
