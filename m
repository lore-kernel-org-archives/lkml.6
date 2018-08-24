Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A398C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4FC21710
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE4FC21710
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeHXMdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:33:33 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44858 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbeHXMdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:33:33 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 93C13206DE; Fri, 24 Aug 2018 10:59:51 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4DC4C206DE;
        Fri, 24 Aug 2018 10:59:41 +0200 (CEST)
Date:   Fri, 24 Aug 2018 10:59:39 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] drm/atmel-hlcdc: prefer a higher rate clock as
 pixel-clock base
Message-ID: <20180824105939.24fe8013@bbrezillon>
In-Reply-To: <20180824085501.9740-2-peda@axentia.se>
References: <20180824085501.9740-1-peda@axentia.se>
        <20180824085501.9740-2-peda@axentia.se>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 10:55:00 +0200
Peter Rosin <peda@axentia.se> wrote:

> If the divider used to get the pixel-clock is small, the granularity
> of the frequencies possible for the pixel-clock is quite coarse. E.g.
> requesting a pixel-clock of 65MHz with a sys_clk of 132MHz results
> in the divider being set to 3 ending up with 44MHz.
> 
> By preferring the doubled sys_clk as base, the divider instead ends
> up as 5 yielding a pixel-clock of 52.8Mhz, which is a definite
> improvement.
> 
> While at it, clamp the divider so that it does not overflow in case
> it gets big.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index c38a479ada98..71c9cd90d2ae 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> @@ -101,18 +101,22 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
>  		     (adj->crtc_hdisplay - 1) |
>  		     ((adj->crtc_vdisplay - 1) << 16));
>  
> -	cfg = 0;
> +	cfg = ATMEL_HLCDC_CLKSEL;
>  
> -	prate = clk_get_rate(crtc->dc->hlcdc->sys_clk);
> +	prate = 2 * clk_get_rate(crtc->dc->hlcdc->sys_clk);
>  	mode_rate = adj->crtc_clock * 1000;
> -	if ((prate / 2) < mode_rate) {
> -		prate *= 2;
> -		cfg |= ATMEL_HLCDC_CLKSEL;
> -	}
>  
>  	div = DIV_ROUND_UP(prate, mode_rate);
>  	if (div < 2)
>  		div = 2;

I'm nitpicking, but can you add braces around the if() block?

Looks good otherwise.

> +	else if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK) {
> +		/* the divider ended up too big, try a lower base rate */
> +		cfg &= ~ATMEL_HLCDC_CLKSEL;
> +		prate /= 2;
> +		div = DIV_ROUND_UP(prate, mode_rate);
> +		if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK)
> +			div = ATMEL_HLCDC_CLKDIV_MASK;
> +	}
>  
>  	cfg |= ATMEL_HLCDC_CLKDIV(div);
>  

