Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097F9C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932642168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932642168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbeHXMlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:41:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45098 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726686AbeHXMlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:41:08 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7A53620732; Fri, 24 Aug 2018 11:07:25 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3F9C920711;
        Fri, 24 Aug 2018 11:07:15 +0200 (CEST)
Date:   Fri, 24 Aug 2018 11:07:13 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] drm/atmel-hlcdc: allow selecting a higher
 pixel-clock that requested
Message-ID: <20180824110713.3c801034@bbrezillon>
In-Reply-To: <20180824085501.9740-3-peda@axentia.se>
References: <20180824085501.9740-1-peda@axentia.se>
        <20180824085501.9740-3-peda@axentia.se>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 10:55:01 +0200
Peter Rosin <peda@axentia.se> wrote:

> But only if the highest pixel-clock frequency lower than requested
> is significantly much less accurate that the lowest frequency higher
> than requested.
> 
> I pulled "10 times" as the discriminator out of the hat, and went with
> that.

Okay, let's go with that until we have a way to properly expose display
tolerance.

> 
> This is useful, if e.g. the target pixel-clock is 65MHz and the sys_clk
> is 132MHz. In this case the highest possible pixel-clock lower than the
> requested 65MHz is 52.8MHz, which is almost 20% off (and outside the
> spec for the panel). The lowest possible pixel-clock higher than 65MHz
> is 66MHz, which is a *much* better match, and only 1.5% off.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index 71c9cd90d2ae..0c2717ed4ac6 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> @@ -116,6 +116,19 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
>  		div = DIV_ROUND_UP(prate, mode_rate);
>  		if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK)
>  			div = ATMEL_HLCDC_CLKDIV_MASK;
> +	} else {
> +		int div_low = prate / mode_rate;
> +
> +		if (div_low >= 2 &&
> +		    ((prate / div_low - mode_rate) <
> +		     10 * (mode_rate - prate / div)))
> +			/*
> +			 * At least 10 times better when
> +			 * using a higher frequency than
> +			 * requested, instead of a lower.
> +			 * So, go with that.
> +			 */
> +			div = div_low;
>  	}
>  
>  	cfg |= ATMEL_HLCDC_CLKDIV(div);

