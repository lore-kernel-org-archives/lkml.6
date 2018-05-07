Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbeEGSJY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 14:09:24 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35501 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752389AbeEGSJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 14:09:21 -0400
X-Google-Smtp-Source: AB8JxZo5dHJ1LvhgVe1YCkzUTYlXdZN3jKJq5nZOXBhGn1Gc3MTYgHVzYzMwyNnvQsHqeq/4Vk8J5w==
Date: Mon, 7 May 2018 11:10:44 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH V1 5/5] backlight: qcom-wled: Add auto string detection
 logic
Message-ID: <20180507181044.GE2259@tuxbook-pro>
References: <1525341432-15818-1-git-send-email-kgunda@codeaurora.org>
 <1525341432-15818-6-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525341432-15818-6-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03 May 02:57 PDT 2018, Kiran Gunda wrote:

[..]
> +
> +#define WLED_AUTO_DETECT_OVP_COUNT		5
> +#define WLED_AUTO_DETECT_CNT_DLY_US		HZ /* 1 second */
> +static bool wled_auto_detection_required(struct wled *wled)

So cfg.auto_detection_enabled is set, but we didn't have a fault during
wled_auto_detection_at_init(), which I presume indicates that the boot
loader configured the strings appropriately (or didn't enable the BL).
Then first time we try to enable the backlight we will hit the ovp irq,
which will  enter here a few times to figure out that the strings are
incorrectly configured and then we will do the same thing that would
have been done if we probed with a fault.

This is convoluted!

If auto-detection is a feature allowing the developer to omit the string
configuration then just do the auto detection explicitly in probe when
the developer did so and then never do it again.

> +{
> +	s64 elapsed_time_us;
> +
> +	if (*wled->version == WLED_PM8941)
> +		return false;
> +	/*
> +	 * Check if the OVP fault was an occasional one
> +	 * or if it's firing continuously, the latter qualifies
> +	 * for an auto-detection check.
> +	 */
> +	if (!wled->auto_detection_ovp_count) {
> +		wled->start_ovp_fault_time = ktime_get();
> +		wled->auto_detection_ovp_count++;
> +	} else {
> +		elapsed_time_us = ktime_us_delta(ktime_get(),
> +						 wled->start_ovp_fault_time);
> +		if (elapsed_time_us > WLED_AUTO_DETECT_CNT_DLY_US)
> +			wled->auto_detection_ovp_count = 0;
> +		else
> +			wled->auto_detection_ovp_count++;
> +
> +		if (wled->auto_detection_ovp_count >=
> +				WLED_AUTO_DETECT_OVP_COUNT) {
> +			wled->auto_detection_ovp_count = 0;
> +			return true;
> +		}
> +	}
> +
> +	return false;
> +}
> +
> +static int wled_auto_detection_at_init(struct wled *wled)
> +{
> +	int rc;
> +	u32 fault_status = 0, rt_status = 0;
> +
> +	if (*wled->version == WLED_PM8941)
> +		return 0;

cfg.auto_detection_enabled will be false in this case, so there's no
need for the extra check.

> +
> +	if (!wled->cfg.auto_detection_enabled)
> +		return 0;
> +
> +	rc = regmap_read(wled->regmap,
> +			 wled->ctrl_addr + WLED3_CTRL_REG_INT_RT_STS,
> +			 &rt_status);
> +	if (rc < 0) {
> +		pr_err("Failed to read RT status rc=%d\n", rc);
> +		return rc;
> +	}
> +
> +	rc = regmap_read(wled->regmap,
> +			 wled->ctrl_addr + WLED3_CTRL_REG_FAULT_STATUS,
> +			 &fault_status);
> +	if (rc < 0) {
> +		pr_err("Failed to read fault status rc=%d\n", rc);
> +		return rc;
> +	}
> +
> +	if ((rt_status & WLED3_CTRL_REG_OVP_FAULT_STATUS) ||
> +	    (fault_status & WLED3_CTRL_REG_OVP_FAULT_BIT)) {

So this would only happen if the boot loader set an invalid string
configuration, as we have yet to enable the module here?

> +		mutex_lock(&wled->lock);
> +		rc = wled_auto_string_detection(wled);
> +		if (!rc)
> +			wled->auto_detection_done = true;
> +		mutex_unlock(&wled->lock);
> +	}
> +
> +	return rc;
> +}
> +
> +static void handle_ovp_fault(struct wled *wled)
> +{
> +	if (!wled->cfg.auto_detection_enabled)

As this is the only reason for requesting the ovp_irq, how about just
not requesting it in this case?

> +		return;
> +
> +	mutex_lock(&wled->lock);
> +	if (wled->ovp_irq > 0 && !wled->ovp_irq_disabled) {

The logic here is unnecessary, the only way handle_ovp_fault() is ever
executed is if wled_ovp_irq_handler() was called, which is a really good
indication that ovp_irq is valid and !ovp_irq_disabled. So this is
always going to be entered.

> +		disable_irq_nosync(wled->ovp_irq);
> +		wled->ovp_irq_disabled = true;
> +	}
> +
> +	if (wled_auto_detection_required(wled))
> +		wled_auto_string_detection(wled);
> +
> +	if (wled->ovp_irq > 0 && wled->ovp_irq_disabled) {

Again, ovp_irq is valid and we entered the function with either
ovp_irq_disabled = true due to some bug or it was set to true above. So
this check is useless - which renders ovp_irq_disabled unnecessary as
well.

> +		enable_irq(wled->ovp_irq);
> +		wled->ovp_irq_disabled = false;
> +	}
> +	mutex_unlock(&wled->lock);
> +}
> +
>  static irqreturn_t wled_ovp_irq_handler(int irq, void *_wled)
>  {
>  	struct wled *wled = _wled;
> @@ -413,6 +706,9 @@ static irqreturn_t wled_ovp_irq_handler(int irq, void *_wled)
>  		dev_dbg(wled->dev, "WLED OVP fault detected, int_sts=%x fault_sts= %x\n",
>  			int_sts, fault_sts);
>  
> +	if (fault_sts & WLED3_CTRL_REG_OVP_FAULT_BIT)
> +		handle_ovp_fault(wled);

Just inline handle_ovp_fault() here and make things less "generic".

> +
>  	return IRQ_HANDLED;
>  }
>  
> @@ -575,6 +871,10 @@ static int wled4_setup(struct wled *wled)
>  		return rc;
>  	}
>  
> +	rc = wled_auto_detection_at_init(wled);
> +	if (rc < 0)
> +		return rc;
> +
>  	if (wled->cfg.external_pfet) {
>  		/* Unlock the secure register access */
>  		rc = regmap_write(wled->regmap, wled->ctrl_addr +
> @@ -602,6 +902,7 @@ static int wled4_setup(struct wled *wled)
>  	.enabled_strings = 0xf,
>  	.cabc = false,
>  	.external_pfet = true,
> +	.auto_detection_enabled = false,
>  };
>  
>  static const u32 wled3_boost_i_limit_values[] = {
> @@ -785,6 +1086,7 @@ static int wled_configure(struct wled *wled)
>  		{ "qcom,ext-gen", &cfg->ext_gen, },
>  		{ "qcom,cabc", &cfg->cabc, },
>  		{ "qcom,external-pfet", &cfg->external_pfet, },
> +		{ "qcom,auto-string-detection", &cfg->auto_detection_enabled, },
>  	};

So afaict the auto detect logic is triggered by two things:

* Boot loader enabled backlight with an invalid string configuration,
  which will make wled_auto_detection_at_init() do the detection.

* Once we the driver tries to enable the module, ovp faults will start
  arriving and we will trigger the auto detection.

But I think you can integrate this in a much more direct way. If the
module is enabled and there are no faults you should be able to just
read the config from the hardware (if auto detect is enabled!) and if
the module is not enabled you can just call auto detect from probe().

This will give you flicker free "auto detection" in the event that the
boot loader did its job and very clean logic in the other cases.

Regards,
Bjorn
