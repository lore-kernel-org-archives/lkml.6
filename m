Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A091C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360382081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 360382081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730288AbeKFGAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:00:08 -0500
Received: from mga17.intel.com ([192.55.52.151]:11818 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbeKFGAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:00:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2018 12:38:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,469,1534834800"; 
   d="scan'208";a="105631566"
Received: from rdvivi-vienna.jf.intel.com (HELO intel.com) ([10.7.196.65])
  by orsmga001.jf.intel.com with ESMTP; 05 Nov 2018 12:38:40 -0800
Date:   Mon, 5 Nov 2018 12:38:40 -0800
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH v3 4/5] drm/i915: Clarify flow for disabling
 IRQs on storms
Message-ID: <20181105203840.GC4208@intel.com>
References: <20181103001909.23645-1-lyude@redhat.com>
 <20181103001909.23645-5-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181103001909.23645-5-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 08:19:07PM -0400, Lyude Paul wrote:
> This is rather confusing to look at as-is:
> dev_priv->display.hpd_irq_setup(dev_priv); in intel_hpd_irq_handler()
> handles disabling the actual HPD IRQ, while
> intel_hpd_irq_storm_disable() handles moving the HPD pin state over from
> MARK_DISABLED to DISABLED along with enabling polling for it.

what about also changing the name of the function?

> 
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/i915/intel_hotplug.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_hotplug.c b/drivers/gpu/drm/i915/intel_hotplug.c
> index c11d73de16f2..e5e3eeb7e482 100644
> --- a/drivers/gpu/drm/i915/intel_hotplug.c
> +++ b/drivers/gpu/drm/i915/intel_hotplug.c
> @@ -351,7 +351,7 @@ static void i915_hotplug_work_func(struct work_struct *work)
>  	hpd_event_bits = dev_priv->hotplug.event_bits;
>  	dev_priv->hotplug.event_bits = 0;
>  
> -	/* Disable hotplug on connectors that hit an irq storm. */
> +	/* Enable polling for connectors which had HPD IRQ storms */
>  	intel_hpd_irq_storm_disable(dev_priv);

This now gets confusing to my brain...
comment says "enable" function name is "disable".

>
>  	spin_unlock_irq(&dev_priv->irq_lock);
> @@ -458,6 +458,10 @@ void intel_hpd_irq_handler(struct drm_i915_private *dev_priv,
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
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx
