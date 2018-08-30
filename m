Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC03DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06DC2082A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06DC2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeH3VjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:39:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:43836 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbeH3VjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:39:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 10:36:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,307,1531810800"; 
   d="scan'208";a="67233957"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga008.fm.intel.com with SMTP; 30 Aug 2018 10:36:04 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 30 Aug 2018 20:36:03 +0300
Date:   Thu, 30 Aug 2018 20:36:03 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/nouveau: Fix nouveau_connector_ddc_detect()
Message-ID: <20180830173603.GP5565@intel.com>
References: <20180830171628.23999-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180830171628.23999-1-lyude@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 01:16:28PM -0400, Lyude Paul wrote:
> It looks like that when we moved over to using
> drm_connector_for_each_possible_encoder() in nouveau, that one rather
> important part of this function got dropped by accident:
> 
> 	/*          Right   v   here */
> 	for (i = 0; nv_encoder = NULL, i < DRM_CONNECTOR_MAX_ENCODER; i++) {
> 		int id = connector->encoder_ids[i];
> 		if (id == 0)
> 			break;
> 
> Since it's rather difficult to notice: the conditional in this loop is
> actually:
> 
> 	nv_encoder = NULL, i < DRM_CONNECTOR_MAX_ENCODER
> 
> Meaning that all early breaks result in nv_encoder keeping it's value,
> otherwise nv_encoder = NULL. Ugh.
> 
> Since this got dropped, nouveau_connector_ddc_detect() now returns an
> encoder for every single connector, regardless of whether or not it's
> detected:
> 
>     [ 1780.056185] nouveau 0000:01:00.0: DRM: DDC responded, but no EDID for DP-2
> 
> So: fix this to ensure we only return an encoder if we actually found
> one, and clean up the rest of the function while we're at it since it's
> nearly impossible to read properly.
> 
> Changes since v1:
> - Don't skip ddc probing for LVDS if we can't switch DDC through
>   vga-switcheroo, just do the DDC probing without calling
>   vga_switcheroo_lock_ddc() - skeggsb
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Fixes: ddba766dd07e ("drm/nouveau: Use drm_connector_for_each_possible_encoder()")
> ---
>  drivers/gpu/drm/nouveau/nouveau_connector.c | 49 ++++++++++++---------
>  1 file changed, 28 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
> index 71c3bd8ff9f8..461111aaedc4 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -414,9 +414,10 @@ nouveau_connector_ddc_detect(struct drm_connector *connector)
>  	struct nouveau_connector *nv_connector = nouveau_connector(connector);
>  	struct nouveau_drm *drm = nouveau_drm(dev);
>  	struct nvkm_gpio *gpio = nvxx_gpio(&drm->client.device);
> -	struct nouveau_encoder *nv_encoder = NULL;
> +	struct nouveau_encoder *nv_encoder = NULL, *found = NULL;
>  	struct drm_encoder *encoder;
> -	int i, panel = -ENODEV;
> +	int i, ret, panel = -ENODEV;
> +	bool switcheroo_ddc = false;
>  
>  	/* eDP panels need powering on by us (if the VBIOS doesn't default it
>  	 * to on) before doing any AUX channel transactions.  LVDS panel power
> @@ -433,37 +434,43 @@ nouveau_connector_ddc_detect(struct drm_connector *connector)
>  	drm_connector_for_each_possible_encoder(connector, encoder, i) {
>  		nv_encoder = nouveau_encoder(encoder);
>  
> -		if (nv_encoder->dcb->type == DCB_OUTPUT_DP) {
> -			int ret = nouveau_dp_detect(nv_encoder);
> +		switch (nv_encoder->dcb->type) {
> +		case DCB_OUTPUT_DP:
> +			ret = nouveau_dp_detect(nv_encoder);
>  			if (ret == NOUVEAU_DP_MST)
>  				return NULL;
> -			if (ret == NOUVEAU_DP_SST)
> -				break;
> -		} else
> -		if ((vga_switcheroo_handler_flags() &
> -		     VGA_SWITCHEROO_CAN_SWITCH_DDC) &&
> -		    nv_encoder->dcb->type == DCB_OUTPUT_LVDS &&
> -		    nv_encoder->i2c) {
> -			int ret;
> -			vga_switcheroo_lock_ddc(dev->pdev);
> -			ret = nvkm_probe_i2c(nv_encoder->i2c, 0x50);
> -			vga_switcheroo_unlock_ddc(dev->pdev);
> -			if (ret)
> +			else if (ret == NOUVEAU_DP_SST)
> +				found = nv_encoder;
> +
> +			break;
> +		case DCB_OUTPUT_LVDS:
> +			switcheroo_ddc = !!(vga_switcheroo_handler_flags() &
> +					    VGA_SWITCHEROO_CAN_SWITCH_DDC);
> +		/* fall-through */
> +		default:
> +			if (!nv_encoder->i2c)
>  				break;
> -		} else
> -		if (nv_encoder->i2c) {
> +
> +			if (switcheroo_ddc)
> +				vga_switcheroo_lock_ddc(dev->pdev);
>  			if (nvkm_probe_i2c(nv_encoder->i2c, 0x50))
> -				break;
> +				found = nv_encoder;
> +			if (switcheroo_ddc)
> +				vga_switcheroo_unlock_ddc(dev->pdev);
> +
> +			break;
>  		}
> +		if (found)
> +			break;

The diff is rather messy due to the change to a switch, but after staring
at it for a while it does look correct to me.

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
and sorry for the mess.

>  	}
>  
>  	/* eDP panel not detected, restore panel power GPIO to previous
>  	 * state to avoid confusing the SOR for other output types.
>  	 */
> -	if (!nv_encoder && panel == 0)
> +	if (!found && panel == 0)
>  		nvkm_gpio_set(gpio, 0, DCB_GPIO_PANEL_POWER, 0xff, panel);
>  
> -	return nv_encoder;
> +	return found;
>  }
>  
>  static struct nouveau_encoder *
> -- 
> 2.17.1

-- 
Ville Syrjälä
Intel
