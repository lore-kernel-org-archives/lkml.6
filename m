Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557D3C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B72C21547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B72C21547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbeI0SAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 14:00:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51102 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727105AbeI0SAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 14:00:21 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3708C208A1; Thu, 27 Sep 2018 13:42:26 +0200 (CEST)
Received: from bbrezillon (guest-nat.fw1.untrust.par1.mozilla.net [185.155.181.200])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0F3D1207CF;
        Thu, 27 Sep 2018 13:42:16 +0200 (CEST)
Date:   Thu, 27 Sep 2018 13:42:16 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2 5/8] mtd: maps: gpio-addr-flash: Replace array with
 an integer
Message-ID: <20180927134216.1952f668@bbrezillon>
In-Reply-To: <20180905143643.9871-6-ricardo.ribalda@gmail.com>
References: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
        <20180905143643.9871-6-ricardo.ribalda@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Sep 2018 16:36:40 +0200
Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:

> By replacing the array with an integer we can avoid completely
> the bit comparison loop if the value has not changed (by far
> the most common case).
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
>  drivers/mtd/maps/gpio-addr-flash.c | 31 +++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
> index 22e100f07112..8f5e3dce9be3 100644
> --- a/drivers/mtd/maps/gpio-addr-flash.c
> +++ b/drivers/mtd/maps/gpio-addr-flash.c
> @@ -43,7 +43,7 @@ struct async_state {
>  	struct map_info map;
>  	size_t gpio_count;
>  	unsigned *gpio_addrs;
> -	int *gpio_values;
> +	unsigned int gpio_values;
>  	unsigned int win_order;
>  };
>  #define gf_map_info_to_state(mi) ((struct async_state *)(mi)->map_priv_1)
> @@ -55,22 +55,25 @@ struct async_state {
>   *
>   * Rather than call the GPIO framework every time, cache the last-programmed
>   * value.  This speeds up sequential accesses (which are by far the most common
> - * type).  We rely on the GPIO framework to treat non-zero value as high so
> - * that we don't have to normalize the bits.
> + * type).
>   */
>  static void gf_set_gpios(struct async_state *state, unsigned long ofs)
>  {
> -	size_t i = 0;
> -	int value;
> +	int i;
>  
>  	ofs >>= state->win_order;
> -	do {
> -		value = ofs & (1 << i);
> -		if (state->gpio_values[i] != value) {
> -			gpio_set_value(state->gpio_addrs[i], value);
> -			state->gpio_values[i] = value;
> -		}
> -	} while (++i < state->gpio_count);
> +
> +	if (ofs == state->gpio_values)
> +		return;
> +
> +	for (i = 0; i < state->gpio_count; i++) {
> +		if ((ofs & BIT(i)) == (state->gpio_values & BIT(i)))

Parens around the xx & BIT(i) operations are unneeded.

> +			continue;
> +
> +		gpio_set_value(state->gpio_addrs[i], !!(ofs & BIT(i)));
> +	}
> +
> +	state->gpio_values = ofs;
>  }
>  
>  /**
> @@ -215,7 +218,7 @@ static int gpio_flash_probe(struct platform_device *pdev)
>  	if (!memory || !gpios || !gpios->end)
>  		return -EINVAL;
>  
> -	arr_size = sizeof(int) * gpios->end;
> +	arr_size = sizeof(state->gpio_addrs[0]) * gpios->end;
>  	state = devm_kzalloc(&pdev->dev, sizeof(*state) + arr_size, GFP_KERNEL);
>  	if (!state)
>  		return -ENOMEM;
> @@ -226,9 +229,7 @@ static int gpio_flash_probe(struct platform_device *pdev)
>  	 */
>  	state->gpio_count     = gpios->end;
>  	state->gpio_addrs     = (void *)(unsigned long)gpios->start;
> -	state->gpio_values    = (void *)(state + 1);
>  	state->win_order      = get_bitmask_order(resource_size(memory)) - 1;
> -	memset(state->gpio_values, 0xff, arr_size);
>  
>  	state->map.name       = DRIVER_NAME;
>  	state->map.read       = gf_read;

