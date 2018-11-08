Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99984C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8DC2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8DC2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeKHW0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:26:02 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36827 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbeKHW0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:26:02 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0B46F207B0; Thu,  8 Nov 2018 13:50:39 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8F51B206D8;
        Thu,  8 Nov 2018 13:50:38 +0100 (CET)
Date:   Thu, 8 Nov 2018 13:50:38 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yogeshnarayan.gaur@nxp.com>, <cyrille.pitchen@wedev4u.fr>
Subject: Re: [PATCH 2/7] mtd: spi-nor: fix iteration over smpt array
Message-ID: <20181108135038.3fb9e995@bbrezillon>
In-Reply-To: <20181108110653.21063-3-tudor.ambarus@microchip.com>
References: <20181108110653.21063-1-tudor.ambarus@microchip.com>
        <20181108110653.21063-3-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2018 11:07:09 +0000
<Tudor.Ambarus@microchip.com> wrote:

> Iterate over smpt array using its starting address and length
> instead of the blindly iterations that used data found in the array.

		 ^blind

> 
> This prevents possible memory accesses outside of the smpt array
> boundaries in case software, or manufacturers, misrepresent smpt
> array fields.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

I think we should consider this patch as a fix. Would you mind adding a
Fixes tag?

> ---
>  drivers/mtd/spi-nor/spi-nor.c | 39 +++++++++++++++++++++++++++++----------
>  1 file changed, 29 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 2cdf96013689..59dcedb08691 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2860,12 +2860,15 @@ static u8 spi_nor_smpt_read_dummy(const struct spi_nor *nor, const u32 settings)
>   * spi_nor_get_map_in_use() - get the configuration map in use
>   * @nor:	pointer to a 'struct spi_nor'
>   * @smpt:	pointer to the sector map parameter table
> + * @smpt_len:	sector map parameter table length
>   */
> -static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt)
> +static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt,
> +					 u8 smpt_len)
>  {
>  	const u32 *ret = NULL;
> -	u32 i, addr;
> +	u32 addr;
>  	int err;
> +	u8 i;
>  	u8 addr_width, read_opcode, read_dummy;
>  	u8 read_data_mask, data_byte, map_id;
>  
> @@ -2874,9 +2877,10 @@ static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt)
>  	read_opcode = nor->read_opcode;
>  
>  	map_id = 0;
> -	i = 0;
>  	/* Determine if there are any optional Detection Command Descriptors */
> -	while (!(smpt[i] & SMPT_DESC_TYPE_MAP)) {
> +	for (i = 0; i < smpt_len; i += 2) {
> +		if (smpt[i] & SMPT_DESC_TYPE_MAP)
> +			break;

nit: add a blank line here.

>  		read_data_mask = SMPT_CMD_READ_DATA(smpt[i]);
>  		nor->addr_width = spi_nor_smpt_addr_width(nor, smpt[i]);
>  		nor->read_dummy = spi_nor_smpt_read_dummy(nor, smpt[i]);
> @@ -2892,18 +2896,33 @@ static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt)
>  		 * Configuration that is currently in use.
>  		 */
>  		map_id = map_id << 1 | !!(data_byte & read_data_mask);
> -		i = i + 2;
>  	}
>  
> -	/* Find the matching configuration map */
> -	while (SMPT_MAP_ID(smpt[i]) != map_id) {
> +	/*
> +	 * If command descriptors are provided, they always precede map
> +	 * descriptors in the table. There is no need to start the iteration
> +	 * over smpt array all over again.
> +	 *
> +	 * Find the matching configuration map.
> +	 */
> +	while (i < smpt_len) {
> +		if (SMPT_MAP_ID(smpt[i]) == map_id) {
> +			ret = smpt + i;
> +			break;
> +		}
> +
> +		/*
> +		 * If there are no more configuration map descriptors and no
> +		 * configuration ID matched the configuration identifier, the
> +		 * sector address map is unknown.
> +		 */
>  		if (smpt[i] & SMPT_DESC_END)
> -			goto out;
> +			break;
> +
>  		/* increment the table index to the next map */
>  		i += SMPT_MAP_REGION_COUNT(smpt[i]) + 1;
>  	}
>  
> -	ret = smpt + i;
>  	/* fall through */
>  out:
>  	nor->addr_width = addr_width;
> @@ -3025,7 +3044,7 @@ static int spi_nor_parse_smpt(struct spi_nor *nor,
>  	for (i = 0; i < smpt_header->length; i++)
>  		smpt[i] = le32_to_cpu(smpt[i]);
>  
> -	sector_map = spi_nor_get_map_in_use(nor, smpt);
> +	sector_map = spi_nor_get_map_in_use(nor, smpt, smpt_header->length);
>  	if (!sector_map) {
>  		ret = -EINVAL;
>  		goto out;

