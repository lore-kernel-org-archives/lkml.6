Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCBFC32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A6820825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A6820825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeKHWhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:37:11 -0500
Received: from mail.bootlin.com ([62.4.15.54]:37073 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbeKHWhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:37:11 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 92E61224CD; Thu,  8 Nov 2018 14:01:45 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3B010207B0;
        Thu,  8 Nov 2018 14:01:35 +0100 (CET)
Date:   Thu, 8 Nov 2018 14:01:35 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yogeshnarayan.gaur@nxp.com>, <cyrille.pitchen@wedev4u.fr>
Subject: Re: [PATCH 5/7] mtd: spi_nor: pass DMA-able buffer to
 spi_nor_read_raw()
Message-ID: <20181108140135.09a23152@bbrezillon>
In-Reply-To: <20181108110653.21063-6-tudor.ambarus@microchip.com>
References: <20181108110653.21063-1-tudor.ambarus@microchip.com>
        <20181108110653.21063-6-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2018 11:07:16 +0000
<Tudor.Ambarus@microchip.com> wrote:

> spi_nor_read_raw() calls nor->read() which might be implemented
> by the m25p80 driver. m25p80 uses the spi-mem layer which requires
> DMA-able in/out buffers. Pass kmalloc'ed dma buffer to spi_nor_read_raw().
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 79ca1102faed..2eaa21c85483 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2161,7 +2161,7 @@ spi_nor_set_pp_settings(struct spi_nor_pp_command *pp,
>   * @nor:	pointer to a 'struct spi_nor'
>   * @addr:	offset in the serial flash memory
>   * @len:	number of bytes to read
> - * @buf:	buffer where the data is copied into
> + * @buf:	buffer where the data is copied into (dma-safe memory)
>   *
>   * Return: 0 on success, -errno otherwise.
>   */
> @@ -2868,11 +2868,16 @@ static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt,
>  					 u8 smpt_len)
>  {
>  	const u32 *ret;
> +	u8 *dma_safe;

I'd prefer to have it named buf, data_buf or scratch_buf...

>  	u32 addr;
>  	int err;
>  	u8 i, ncmds, nmaps;
>  	u8 addr_width, read_opcode, read_dummy;
> -	u8 read_data_mask, data_byte, map_id;
> +	u8 read_data_mask, map_id;
> +

... and have a comment here explaining why your allocating the buffer
instead of using a local var placed on the stack.

> +	dma_safe = kmalloc(sizeof(*dma_safe), GFP_KERNEL | GFP_DMA);

Please don't use GFP_DMA, kmalloc() should already return a DMA-safe
buffer (see [1]).

> +	if (!dma_safe)
> +		return ERR_PTR(-ENOMEM);
>  
>  	addr_width = nor->addr_width;
>  	read_dummy = nor->read_dummy;
> @@ -2890,7 +2895,7 @@ static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt,
>  		nor->read_opcode = SMPT_CMD_OPCODE(smpt[i]);
>  		addr = smpt[i + 1];
>  
> -		err = spi_nor_read_raw(nor, addr, 1, &data_byte);
> +		err = spi_nor_read_raw(nor, addr, 1, dma_safe);
>  		if (err) {
>  			ret = ERR_PTR(err);
>  			goto out;
> @@ -2900,7 +2905,7 @@ static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt,
>  		 * Build an index value that is used to select the Sector Map
>  		 * Configuration that is currently in use.
>  		 */
> -		map_id = map_id << 1 | !!(data_byte & read_data_mask);
> +		map_id = map_id << 1 | !!(*dma_safe & read_data_mask);
>  		ncmds++;
>  	}
>  
> @@ -2941,6 +2946,7 @@ static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt,
>  
>  	/* fall through */
>  out:
> +	kfree(dma_safe);
>  	nor->addr_width = addr_width;
>  	nor->read_dummy = read_dummy;
>  	nor->read_opcode = read_opcode;

[1]https://elixir.bootlin.com/linux/latest/source/include/linux/gfp.h#L263
