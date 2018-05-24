Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033491AbeEXQHm (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 12:07:42 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:19515 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030546AbeEXQHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 12:07:37 -0400
Date: Thu, 24 May 2018 11:06:58 -0500
From: Benoit Parrot <bparrot@ti.com>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
CC: Tony Lindgren <tony@atomide.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, <ivo.g.dimitrov.75@gmail.com>,
        <abcloriens@gmail.com>, <sre@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <martijn@brixit.nl>, <filip.matijevic.pz@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>, <clayton@craftyguy.net>,
        <linux-omap@vger.kernel.org>, <patrikbachan@gmail.com>,
        <serge@hallyn.com>
Subject: Re: omapdrm regression in v4.17-rc series
Message-ID: <20180524160658.GA31901@ti.com>
References: <20180523220320.GX98604@atomide.com>
 <2f803bfc-3ffe-332a-7b9a-d59a39db4630@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2f803bfc-3ffe-332a-7b9a-d59a39db4630@ti.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Benoit Parrot <bparrot@ti.com>

Tomi Valkeinen <tomi.valkeinen@ti.com> wrote on Thu [2018-May-24 10:58:25 +0300]:
> 
> On 24/05/18 01:03, Tony Lindgren wrote:
> > Hi all,
> > 
> > I bisected the n900 LCD issue to commit 24aac6011f70 ("drm: omapdrm:
> > sdi: Allocate the sdi private data structure dynamically"). Reverting
> > this patch makes LCD work for me again on n900.
> > 
> > Any ideas?
> 
> This should help to get the SDI enabled.
> 
>  Tomi
> 
> From 4e96e6c2dedf366e081331c3825ff6fa8aabd85c Mon Sep 17 00:00:00 2001
> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date: Thu, 24 May 2018 10:53:24 +0300
> Subject: [PATCH] drm/omap: fix NULL deref crash with SDI displays
> 
> Fix a NULL deref bug introduced in commit 24aac6011f70 ("drm: omapdrm:
> sdi: Allocate the sdi private data structure dynamically").
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/gpu/drm/omapdrm/dss/sdi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/sdi.c b/drivers/gpu/drm/omapdrm/dss/sdi.c
> index 68a40ae26f5b..1e2c931f6acf 100644
> --- a/drivers/gpu/drm/omapdrm/dss/sdi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/sdi.c
> @@ -82,7 +82,7 @@ static int sdi_calc_clock_div(struct sdi_device *sdi, unsigned long pclk,
>  			      struct dispc_clock_info *dispc_cinfo)
>  {
>  	int i;
> -	struct sdi_clk_calc_ctx ctx = { .sdi = sdi };
> +	struct sdi_clk_calc_ctx ctx;
>  
>  	/*
>  	 * DSS fclk gives us very few possibilities, so finding a good pixel
> @@ -95,6 +95,9 @@ static int sdi_calc_clock_div(struct sdi_device *sdi, unsigned long pclk,
>  		bool ok;
>  
>  		memset(&ctx, 0, sizeof(ctx));
> +
> +		ctx.sdi = sdi;
> +
>  		if (pclk > 1000 * i * i * i)
>  			ctx.pck_min = max(pclk - 1000 * i * i * i, 0lu);
>  		else
> 
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
