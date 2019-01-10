Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18295C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26A9214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547141370;
	bh=q6nzpHw6PA14SiZLCIxsAslUipB3CPV2u5tQO8zhUJo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MPApchREOoNdlpTjaXiVzZqRk4FYkB0CifazXsMSHz64ViFFlgkSfMfN5Z0pkrzKY
	 /o+uvDu1oU8GMrx1FHgSCg7txS1Ogz/NDf48+395ACNyXrzYFgjgxKSZZmmg397kdW
	 vy4zgLE0gWzkWLaEFL1Q8XmJfaq7svuYcOQ7WyoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbfAJR33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:29:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:43240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730008AbfAJR31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:29:27 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3E4920675;
        Thu, 10 Jan 2019 17:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547141366;
        bh=q6nzpHw6PA14SiZLCIxsAslUipB3CPV2u5tQO8zhUJo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RyJWpk8pjrRaAOV75OxxxUhQ+LA0rxZMfWmPJJZ7OjrEnAEwq8s6QyjuSkyCAo0fi
         OnBSl1kMX6h5NGG8myMlqn2DdZ+xV9EOFCU40DwFdZpPXFKzBdNshsfwzwSslLnhG1
         v6b7NpG7nLVXNNhOVuT0TVJio9TgIvMHRllUEaGI=
Date:   Thu, 10 Jan 2019 18:29:17 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/4] drm/atmel-hlcdc: do not immediately disable planes,
 wait for next frame
Message-ID: <20190110182904.5efd08f2@bbrezillon>
In-Reply-To: <20190110151020.30468-5-peda@axentia.se>
References: <20190110151020.30468-1-peda@axentia.se>
        <20190110151020.30468-5-peda@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 15:10:48 +0000
Peter Rosin <peda@axentia.se> wrote:

> The A2Q and UPDATE bits have no effect in the channel disable registers.
> However, since they are present, assume that the intention is to disable
> planes, not immediately as indicated by the RST bit, but on the next
> frame shift since that is what A2Q and UPDATE means in the channel enable
> registers.
> 
> Disabling the plane on the next frame shift is done with the EN bit,
> so use that.

It's been a long time, but I think I had a good reason for forcing a
reset. IIRC, when you don't do that and the CRTC is disabled before the
plane, the EN bit stays around, and next time you queue a plane update,
you'll start with an invalid buf pointer.

> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> index 05519e8c6586..f2f570642f84 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
> @@ -728,9 +728,7 @@ static void atmel_hlcdc_plane_atomic_disable(struct drm_plane *p,
>  
>  	/* Disable the layer */
>  	atmel_hlcdc_layer_write_reg(&plane->layer, ATMEL_HLCDC_LAYER_CHDR,
> -				    ATMEL_HLCDC_LAYER_RST |
> -				    ATMEL_HLCDC_LAYER_A2Q |
> -				    ATMEL_HLCDC_LAYER_UPDATE);
> +				    ATMEL_HLCDC_LAYER_EN);
>  
>  	/* Clear all pending interrupts */
>  	atmel_hlcdc_layer_read_reg(&plane->layer, ATMEL_HLCDC_LAYER_ISR);

