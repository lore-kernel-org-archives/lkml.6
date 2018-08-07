Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1250C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9268420895
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9268420895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390836AbeHGVNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:13:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40334 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389581AbeHGVNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:13:48 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2ADF92084E; Tue,  7 Aug 2018 20:58:02 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id B051D207E5;
        Tue,  7 Aug 2018 20:57:51 +0200 (CEST)
Date:   Tue, 7 Aug 2018 20:57:52 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-omap@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tony Lindgren <tony@atomide.com>,
        Richard Weinberger <richard@nod.at>,
        linux-gpio@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 07/12] mtd: rawnand: ams-delta: Set port
 direction once per transfer
Message-ID: <20180807205752.32cd3e53@bbrezillon>
In-Reply-To: <20180806222918.12644-8-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
        <20180806222918.12644-1-jmkrzyszt@gmail.com>
        <20180806222918.12644-8-jmkrzyszt@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Aug 2018 00:29:13 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> In its current shape, the driver sets data port direction before each
> byte read/write operation, even during multi-byte transfers.  Since
> performance of the driver is completely not acceptable on Amstrad Delta
> after it has been converted to GPIO bitbang, try to improve things a
> bit by setting the port direction only on first byte of each transfer.
> 
> Resulting performance on Amstrad Delta is still far from acceptable.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
>  drivers/mtd/nand/raw/ams-delta.c | 58 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 47 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
> index 78996ddf82e0..d02c48c013e8 100644
> --- a/drivers/mtd/nand/raw/ams-delta.c
> +++ b/drivers/mtd/nand/raw/ams-delta.c
> @@ -69,6 +69,30 @@ static const struct mtd_partition partition_info[] = {
>  	  .size		=  3 * SZ_256K },
>  };
>  
> +static void ams_delta_write_commit(struct ams_delta_nand *priv)
> +{
> +	gpiod_set_value(priv->gpiod_nwe, 0);
> +	ndelay(40);
> +	gpiod_set_value(priv->gpiod_nwe, 1);
> +}
> +
> +static void ams_delta_write_next_byte(struct mtd_info *mtd, u_char byte)
> +{
> +	struct nand_chip *this = mtd_to_nand(mtd);
> +	struct ams_delta_nand *priv = nand_get_controller_data(this);
> +	struct gpio_descs *data_gpiods = priv->data_gpiods;
> +	unsigned long bits = byte;
> +	int i, value_array[data_gpiods->ndescs];
> +
> +	for (i = 0; i < data_gpiods->ndescs; i++)
> +		value_array[i] = test_bit(i, &bits);
> +
> +	gpiod_set_raw_array_value(data_gpiods->ndescs, data_gpiods->desc,
> +				  value_array);
> +
> +	ams_delta_write_commit(priv);
> +}
> +
>  static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
>  {
>  	struct nand_chip *this = mtd_to_nand(mtd);
> @@ -81,12 +105,10 @@ static void ams_delta_write_byte(struct mtd_info *mtd, u_char byte)
>  		gpiod_direction_output_raw(data_gpiods->desc[i],
>  					   test_bit(i, &bits));
>  
> -	gpiod_set_value(priv->gpiod_nwe, 0);
> -	ndelay(40);
> -	gpiod_set_value(priv->gpiod_nwe, 1);
> +	ams_delta_write_commit(priv);
>  }
>  
> -static u_char ams_delta_read_byte(struct mtd_info *mtd)
> +static u_char ams_delta_read_next_byte(struct mtd_info *mtd)
>  {
>  	struct nand_chip *this = mtd_to_nand(mtd);
>  	struct ams_delta_nand *priv = nand_get_controller_data(this);
> @@ -94,9 +116,6 @@ static u_char ams_delta_read_byte(struct mtd_info *mtd)
>  	unsigned long bits = 0;
>  	int i, value_array[data_gpiods->ndescs];
>  
> -	for (i = 0; i < data_gpiods->ndescs; i++)
> -		gpiod_direction_input(data_gpiods->desc[i]);
> -
>  	gpiod_set_value(priv->gpiod_nre, 0);
>  	ndelay(40);
>  
> @@ -112,21 +131,38 @@ static u_char ams_delta_read_byte(struct mtd_info *mtd)
>  	return bits;
>  }
>  
> +static u_char ams_delta_read_byte(struct mtd_info *mtd)
> +{
> +	struct nand_chip *this = mtd_to_nand(mtd);
> +	struct ams_delta_nand *priv = nand_get_controller_data(this);
> +	struct gpio_descs *data_gpiods = priv->data_gpiods;
> +	int i;
> +
> +	for (i = 0; i < data_gpiods->ndescs; i++)
> +		gpiod_direction_input(data_gpiods->desc[i]);
> +
> +	return ams_delta_read_next_byte(mtd);
> +}
> +
>  static void ams_delta_write_buf(struct mtd_info *mtd, const u_char *buf,
>  				int len)
>  {
>  	int i;
>  
> -	for (i=0; i<len; i++)
> -		ams_delta_write_byte(mtd, buf[i]);
> +	if (len > 0)
> +		ams_delta_write_byte(mtd, buf[0]);
> +	for (i = 1; i < len; i++)
> +		ams_delta_write_next_byte(mtd, buf[i]);
>  }
>  
>  static void ams_delta_read_buf(struct mtd_info *mtd, u_char *buf, int len)
>  {
>  	int i;
>  
> -	for (i=0; i<len; i++)
> -		buf[i] = ams_delta_read_byte(mtd);
> +	if (len > 0)
> +		buf[0] = ams_delta_read_byte(mtd);
> +	for (i = 1; i < len; i++)
> +		buf[i] = ams_delta_read_next_byte(mtd);
>  }

I'd suggest a slightly different approach where the data pins
direction state is stored in the the priv struct and only changed when
required. This way you just have to add a test in
ams_delta_read/write_byte().
