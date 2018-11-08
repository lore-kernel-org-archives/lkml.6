Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E100C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3289520827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3289520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeKHWaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:30:22 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36920 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726781AbeKHWaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:30:22 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4920E224CF; Thu,  8 Nov 2018 13:54:58 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-30-49.w90-88.abo.wanadoo.fr [90.88.15.49])
        by mail.bootlin.com (Postfix) with ESMTPSA id EB13B224CC;
        Thu,  8 Nov 2018 13:54:47 +0100 (CET)
Date:   Thu, 8 Nov 2018 13:54:47 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yogeshnarayan.gaur@nxp.com>, <cyrille.pitchen@wedev4u.fr>
Subject: Re: [PATCH 3/7] mtd: spi-nor: add restriction for nmaps in smpt
 parser
Message-ID: <20181108135447.36a0314c@bbrezillon>
In-Reply-To: <20181108110653.21063-4-tudor.ambarus@microchip.com>
References: <20181108110653.21063-1-tudor.ambarus@microchip.com>
        <20181108110653.21063-4-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2018 11:07:11 +0000
<Tudor.Ambarus@microchip.com> wrote:

> The map selector is limited to a maximum of 8 bits, allowing
> for a maximum of 256 possible map configurations. The total
> number of map configurations should be addressable by the
> total number of bits described by the detection commands.
> 
> For example: if there are five to eight possible sector map
> configurations, at least three configuration detection commands
> will be needed to extract three bits of configuration selection
> information from the device in order to identify which configuration
> is currently in use.
> 
> Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>

I don't remember suggesting this :-).

> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 59dcedb08691..bd1866d714f2 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -2868,7 +2868,7 @@ static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt,
>  	const u32 *ret = NULL;
>  	u32 addr;
>  	int err;
> -	u8 i;
> +	u8 i, ncmds, nmaps;
>  	u8 addr_width, read_opcode, read_dummy;
>  	u8 read_data_mask, data_byte, map_id;
>  
> @@ -2877,6 +2877,7 @@ static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt,
>  	read_opcode = nor->read_opcode;
>  
>  	map_id = 0;
> +	ncmds = 0;
>  	/* Determine if there are any optional Detection Command Descriptors */
>  	for (i = 0; i < smpt_len; i += 2) {
>  		if (smpt[i] & SMPT_DESC_TYPE_MAP)
> @@ -2896,6 +2897,7 @@ static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt,
>  		 * Configuration that is currently in use.
>  		 */
>  		map_id = map_id << 1 | !!(data_byte & read_data_mask);
> +		ncmds++;
>  	}
>  
>  	/*
> @@ -2905,7 +2907,16 @@ static const u32 *spi_nor_get_map_in_use(struct spi_nor *nor, const u32 *smpt,
>  	 *
>  	 * Find the matching configuration map.
>  	 */
> -	while (i < smpt_len) {
> +	for (nmaps = 0; i < smpt_len; nmaps++) {
> +		/*
> +		 * The map selector is limited to a maximum of 8 bits, allowing
> +		 * for a maximum of 256 possible map configurations. The total
> +		 * number of map configurations should be addressable by the
> +		 * total number of bits described by the detection commands.
> +		 */
> +		if (ncmds && nmaps >= (1 << (ncmds + 1)))
> +			break;
> +

Maybe I missed something but it sounds like this change is just
optimizing the SPMT parsing a bit, and to be honest, I'm not sure this
is really needed. Most of the time, smpt_len will be rather small, so
trying to bail out earlier is not bringing much perf improvements.

>  		if (SMPT_MAP_ID(smpt[i]) == map_id) {
>  			ret = smpt + i;
>  			break;

