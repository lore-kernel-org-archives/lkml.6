Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0370C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4221F2083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4221F2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388337AbeKFXJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:09:08 -0500
Received: from mga14.intel.com ([192.55.52.115]:2080 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388029AbeKFXJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:09:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 05:43:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,472,1534834800"; 
   d="scan'208";a="106321237"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga002.jf.intel.com with SMTP; 06 Nov 2018 05:43:47 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 06 Nov 2018 15:43:46 +0200
Date:   Tue, 6 Nov 2018 15:43:46 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] drm/i915: Fix threshold check in
 intel_hpd_irq_storm_detect()
Message-ID: <20181106134346.GR9144@intel.com>
References: <20181105222011.2913-1-lyude@redhat.com>
 <20181105222011.2913-4-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181105222011.2913-4-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 05:20:09PM -0500, Lyude Paul wrote:
> Currently in intel_hpd_irq_storm_detect() when we detect that the last
> recorded hotplug wasn't within the period defined by
> HPD_STORM_DETECT_DELAY, we make the mistake of resetting the HPD count
> to 0 without incrementing it. This results in us only enabling storm
> detection when we go +2 above the threshold, e.g. an HPD threshold of 5
> would not trigger a storm until we reach a total of 7 hotplugs.
> 
> So: rework the code a bit so we reset the HPD count when
> HPD_STORM_DETECT_DELAY has passed, then increment the count afterwards.
> Also, clean things up a bit to make it easier to undertand.
> 
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>

Looks good to me
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> ---
>  drivers/gpu/drm/i915/intel_hotplug.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_hotplug.c b/drivers/gpu/drm/i915/intel_hotplug.c
> index 8326900a311e..c11d73de16f2 100644
> --- a/drivers/gpu/drm/i915/intel_hotplug.c
> +++ b/drivers/gpu/drm/i915/intel_hotplug.c
> @@ -135,24 +135,27 @@ enum hpd_pin intel_hpd_pin_default(struct drm_i915_private *dev_priv,
>  static bool intel_hpd_irq_storm_detect(struct drm_i915_private *dev_priv,
>  				       enum hpd_pin pin)
>  {
> -	unsigned long start = dev_priv->hotplug.stats[pin].last_jiffies;
> +	struct i915_hotplug *hpd = &dev_priv->hotplug;
> +	unsigned long start = hpd->stats[pin].last_jiffies;
>  	unsigned long end = start + msecs_to_jiffies(HPD_STORM_DETECT_PERIOD);
> -	const int threshold = dev_priv->hotplug.hpd_storm_threshold;
> +	const int threshold = hpd->hpd_storm_threshold;
>  	bool storm = false;
>  
> +	if (!threshold)
> +		return false;
> +
>  	if (!time_in_range(jiffies, start, end)) {
> -		dev_priv->hotplug.stats[pin].last_jiffies = jiffies;
> -		dev_priv->hotplug.stats[pin].count = 0;
> -		DRM_DEBUG_KMS("Received HPD interrupt on PIN %d - cnt: 0\n", pin);
> -	} else if (dev_priv->hotplug.stats[pin].count > threshold &&
> -		   threshold) {
> -		dev_priv->hotplug.stats[pin].state = HPD_MARK_DISABLED;
> +		hpd->stats[pin].last_jiffies = jiffies;
> +		hpd->stats[pin].count = 0;
> +	}
> +
> +	if (++hpd->stats[pin].count > threshold) {
> +		hpd->stats[pin].state = HPD_MARK_DISABLED;
>  		DRM_DEBUG_KMS("HPD interrupt storm detected on PIN %d\n", pin);
>  		storm = true;
>  	} else {
> -		dev_priv->hotplug.stats[pin].count++;
>  		DRM_DEBUG_KMS("Received HPD interrupt on PIN %d - cnt: %d\n", pin,
> -			      dev_priv->hotplug.stats[pin].count);
> +			      hpd->stats[pin].count);
>  	}
>  
>  	return storm;
> -- 
> 2.19.1

-- 
Ville Syrjälä
Intel
