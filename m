Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4C8C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5D82150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5D82150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731577AbeISSEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 14:04:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:26903 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731343AbeISSEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 14:04:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 05:27:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,393,1531810800"; 
   d="scan'208";a="91430850"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.72.61])
  by fmsmga001.fm.intel.com with ESMTP; 19 Sep 2018 05:26:58 -0700
From:   Jani Nikula <jani.nikula@intel.com>
To:     Chris Chiu <chiu@endlessm.com>, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Chris Chiu <chiu@endlessm.com>
Subject: Re: [PATCH] drm/i915: re-check the hotplug with a delayed work
In-Reply-To: <20180919112933.47382-1-chiu@endlessm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180919112933.47382-1-chiu@endlessm.com>
Date:   Wed, 19 Sep 2018 15:27:05 +0300
Message-ID: <87h8ily8o6.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Sep 2018, Chris Chiu <chiu@endlessm.com> wrote:
> I have few ASUS laptops, X705FD(Intel i7-8565), X560UD(Intel i5-8250U)
> and X530UN(Intel i7-8550U) share the same problem. The HDMI connector
> status stays 'connected' even the HDMI cable has been unplugged.
> Then the status in sysfs would never change since then until we
> do 'xrandr' to reprobe the devices. It would also cause the audio
> output path cannot correctly swicth based on the connector status.
>
> This commit kicks off a delayed work when the status remains unchanged
> in the first hotplug event handling, which may not be the perfect
> timing in some special cases.

Please see [1].

BR,
Jani.


[1] http://patchwork.freedesktop.org/patch/msgid/87k1nhy9ie.fsf@intel.com

>
> Signed-off-by: Chris Chiu <chiu@endlessm.com>
> ---
>  drivers/gpu/drm/i915/i915_drv.h      |  1 +
>  drivers/gpu/drm/i915/intel_hotplug.c | 35 +++++++++++++++++++++++++++++++----
>  2 files changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
> index d51d8574a679..78e2cf09cc10 100644
> --- a/drivers/gpu/drm/i915/i915_drv.h
> +++ b/drivers/gpu/drm/i915/i915_drv.h
> @@ -286,6 +286,7 @@ struct i915_hotplug {
>  	} stats[HPD_NUM_PINS];
>  	u32 event_bits;
>  	struct delayed_work reenable_work;
> +	struct delayed_work recheck_work;
>  
>  	struct intel_digital_port *irq_port[I915_MAX_PORTS];
>  	u32 long_port_mask;
> diff --git a/drivers/gpu/drm/i915/intel_hotplug.c b/drivers/gpu/drm/i915/intel_hotplug.c
> index 43aa92beff2a..089a24588ec8 100644
> --- a/drivers/gpu/drm/i915/intel_hotplug.c
> +++ b/drivers/gpu/drm/i915/intel_hotplug.c
> @@ -349,14 +349,15 @@ static void i915_digport_work_func(struct work_struct *work)
>  	}
>  }
>  
> +#define HPD_RECHECK_DELAY        (2 * 1000)
> +
>  /*
>   * Handle hotplug events outside the interrupt handler proper.
>   */
> -static void i915_hotplug_work_func(struct work_struct *work)
> +static void do_i915_hotplug_check(struct work_struct *work,
> +				   struct drm_i915_private *dev_priv,
> +				   struct drm_device *dev, bool do_recheck)
>  {
> -	struct drm_i915_private *dev_priv =
> -		container_of(work, struct drm_i915_private, hotplug.hotplug_work);
> -	struct drm_device *dev = &dev_priv->drm;
>  	struct intel_connector *intel_connector;
>  	struct intel_encoder *intel_encoder;
>  	struct drm_connector *connector;
> @@ -396,8 +397,31 @@ static void i915_hotplug_work_func(struct work_struct *work)
>  
>  	if (changed)
>  		drm_kms_helper_hotplug_event(dev);
> +	else if (do_recheck) {
> +		spin_lock_irq(&dev_priv->irq_lock);
> +		dev_priv->hotplug.event_bits |= hpd_event_bits;
> +		spin_unlock_irq(&dev_priv->irq_lock);
> +		schedule_delayed_work(&dev_priv->hotplug.recheck_work, msecs_to_jiffies(HPD_RECHECK_DELAY));
> +	}
>  }
>  
> +static void i915_hotplug_work_func(struct work_struct *work)
> +{
> +	struct drm_i915_private *dev_priv =
> +		container_of(work, struct drm_i915_private, hotplug.hotplug_work);
> +	struct drm_device *dev = &dev_priv->drm;
> +
> +	do_i915_hotplug_check(work, dev_priv, dev, true);
> +}
> +
> +static void i915_hotplug_recheck_func(struct work_struct *work)
> +{
> +	struct drm_i915_private *dev_priv =
> +		container_of(work, struct drm_i915_private, hotplug.recheck_work.work);
> +	struct drm_device *dev = &dev_priv->drm;
> +
> +	do_i915_hotplug_check(work, dev_priv, dev, false);
> +}
>  
>  /**
>   * intel_hpd_irq_handler - main hotplug irq handler
> @@ -619,6 +643,8 @@ void intel_hpd_init_work(struct drm_i915_private *dev_priv)
>  	INIT_WORK(&dev_priv->hotplug.poll_init_work, i915_hpd_poll_init_work);
>  	INIT_DELAYED_WORK(&dev_priv->hotplug.reenable_work,
>  			  intel_hpd_irq_storm_reenable_work);
> +	INIT_DELAYED_WORK(&dev_priv->hotplug.recheck_work,
> +			  i915_hotplug_recheck_func);
>  }
>  
>  void intel_hpd_cancel_work(struct drm_i915_private *dev_priv)
> @@ -635,6 +661,7 @@ void intel_hpd_cancel_work(struct drm_i915_private *dev_priv)
>  	cancel_work_sync(&dev_priv->hotplug.hotplug_work);
>  	cancel_work_sync(&dev_priv->hotplug.poll_init_work);
>  	cancel_delayed_work_sync(&dev_priv->hotplug.reenable_work);
> +	cancel_delayed_work_sync(&dev_priv->hotplug.recheck_work);
>  }
>  
>  bool intel_hpd_disable(struct drm_i915_private *dev_priv, enum hpd_pin pin)

-- 
Jani Nikula, Intel Open Source Graphics Center
