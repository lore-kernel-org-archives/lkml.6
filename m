Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755425AbeCSJF7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:05:59 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:28659 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbeCSJF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:05:56 -0400
Subject: Re: [PATCH] drm/tilcdc: Fix setting clock divider for omap-l138
To: David Lechner <david@lechnology.com>,
        <dri-devel@lists.freedesktop.org>
CC: Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>
References: <1521068325-15077-1-git-send-email-david@lechnology.com>
From: Jyri Sarha <jsarha@ti.com>
Message-ID: <fe2866d2-6dd4-f6e4-ea0e-72d8a9334075@ti.com>
Date: Mon, 19 Mar 2018 11:05:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521068325-15077-1-git-send-email-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,
I'll pick this for v4.18.

Best regards,
Jyri

On 15/03/18 00:58, David Lechner wrote:
> This fixes setting the clock divider on the TI OMAP-L138 LCDK board.
> 
> The clock drivers for OMAP-L138 are being covernted to the common clock
> framework. When this happens, clk_set_rate() will no longer return an
> error. However, on this SoC, the clock rate cannot actually be changed
> because the clock has to maintain a fixed ratio to the ARM clock. So
> after attempting to set the clock rate, we need to check to see if the
> new rate is actually close enough. If not, then follow the previous
> error path to adjust the divider in LCDC IP block to compensate for not
> being able to change the parent clock rate.
> 
> Tested working on a TI OMAP-L138 LCDK board.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> index 8bf6bb9..6931777 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> @@ -224,7 +224,7 @@ static void tilcdc_crtc_set_clk(struct drm_crtc *crtc)
>  
>  	ret = clk_set_rate(priv->clk, req_rate * clkdiv);
>  	clk_rate = clk_get_rate(priv->clk);
> -	if (ret < 0) {
> +	if (ret < 0 || tilcdc_pclk_diff(req_rate, clk_rate) > 5) {
>  		/*
>  		 * If we fail to set the clock rate (some architectures don't
>  		 * use the common clock framework yet and may not implement
> 


-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
