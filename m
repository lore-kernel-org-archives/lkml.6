Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68799C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A9582083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A9582083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388648AbeKFXQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 18:16:31 -0500
Received: from mga17.intel.com ([192.55.52.151]:16294 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388065AbeKFXQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 18:16:31 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 05:51:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,472,1534834800"; 
   d="scan'208";a="89852466"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga008.jf.intel.com with SMTP; 06 Nov 2018 05:51:07 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 06 Nov 2018 15:51:07 +0200
Date:   Tue, 6 Nov 2018 15:51:07 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] drm/i915: Clarify flow for disabling IRQs on
 storms
Message-ID: <20181106135107.GT9144@intel.com>
References: <20181105222011.2913-1-lyude@redhat.com>
 <20181105222011.2913-5-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181105222011.2913-5-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 05:20:10PM -0500, Lyude Paul wrote:
> This is rather confusing to look at as-is:
> dev_priv->display.hpd_irq_setup(dev_priv); in intel_hpd_irq_handler()
> handles disabling the actual HPD IRQ, while
> intel_hpd_irq_storm_disable() handles moving the HPD pin state over from
> MARK_DISABLED to DISABLED along with enabling polling for it.
> 
> Changes since v3:
> - Rename i915_hpd_irq_storm_disable() to
>   i915_hpd_irq_storm_switch_to_polling() - Rodrigo Vivi
> 
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> ---
>  drivers/gpu/drm/i915/intel_hotplug.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_hotplug.c b/drivers/gpu/drm/i915/intel_hotplug.c
> index c11d73de16f2..d642c0795452 100644
> --- a/drivers/gpu/drm/i915/intel_hotplug.c
> +++ b/drivers/gpu/drm/i915/intel_hotplug.c
> @@ -161,7 +161,8 @@ static bool intel_hpd_irq_storm_detect(struct drm_i915_private *dev_priv,
>  	return storm;
>  }
>  
> -static void intel_hpd_irq_storm_disable(struct drm_i915_private *dev_priv)
> +static void
> +intel_hpd_irq_storm_switch_to_polling(struct drm_i915_private *dev_priv)
>  {
>  	struct drm_device *dev = &dev_priv->drm;
>  	struct intel_connector *intel_connector;
> @@ -351,8 +352,8 @@ static void i915_hotplug_work_func(struct work_struct *work)
>  	hpd_event_bits = dev_priv->hotplug.event_bits;
>  	dev_priv->hotplug.event_bits = 0;
>  
> -	/* Disable hotplug on connectors that hit an irq storm. */
> -	intel_hpd_irq_storm_disable(dev_priv);
> +	/* Enable polling for connectors which had HPD IRQ storms */
> +	intel_hpd_irq_storm_switch_to_polling(dev_priv);
>  
>  	spin_unlock_irq(&dev_priv->irq_lock);
>  
> @@ -458,6 +459,10 @@ void intel_hpd_irq_handler(struct drm_i915_private *dev_priv,
>  		}
>  	}
>  
> +	/*
> +	 * Disable any IRQs that storms were detected on. Polling enablement
> +	 * happens later in our hotplug work.
> +	 */
>  	if (storm_detected && dev_priv->display_irqs_enabled)
>  		dev_priv->display.hpd_irq_setup(dev_priv);
>  	spin_unlock(&dev_priv->irq_lock);
> -- 
> 2.19.1

-- 
Ville Syrjälä
Intel
