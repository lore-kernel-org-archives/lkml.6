Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E43AC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AE820872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="X/ciAeJ5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OSQlrh/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30AE820872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753760AbeFTMhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:37:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58816 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeFTMhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:37:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 76BBC608C1; Wed, 20 Jun 2018 12:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529498260;
        bh=UUzMuotPv03ook7iSJu6uH5mZ/LtLk+UVduDWov36k8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X/ciAeJ5VwJxV5RQlMkmNXTBTvEZzHsTpvq1HeD0nibR7AU5KJ0f/46Dc38AJPky1
         5uWgqvCIO9jfOUb+zE8DYODvC7BhmxasTiq1g7uBGgv0HQOgihgaNkhK2C6lbKQoS9
         On6DMDkE57gLTdTYF9Fyh7Bt8uahQdjye3NeFkyE=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 479E860227;
        Wed, 20 Jun 2018 12:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529498259;
        bh=UUzMuotPv03ook7iSJu6uH5mZ/LtLk+UVduDWov36k8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OSQlrh/T9eGu8l0yerLayFj07TxGWPPsOrxGEIcnP36Elb55tqdU/S5E5aFpQI+D/
         UTlum4SpxNWMcTyspVSKO77lXXicyfVTzpUkOXTAhbtQGfjKvvyqHUg3TwrZY19Z8x
         tLU/9sDeMQNylKqdNbRZ3nUtwF9DcKn01b4e6z8c=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 20 Jun 2018 18:07:39 +0530
From:   kgunda@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     jingoohan1@gmail.com, lee.jones@linaro.org,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V3 7/7] backlight: qcom-wled: Add auto string detection
 logic
In-Reply-To: <20180620062256.GK15126@tuxbook-pro>
References: <1529406822-15379-1-git-send-email-kgunda@codeaurora.org>
 <1529406822-15379-8-git-send-email-kgunda@codeaurora.org>
 <20180620062256.GK15126@tuxbook-pro>
Message-ID: <f93eafc1faadc1e0357d24cba7392fad@codeaurora.org>
X-Sender: kgunda@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-20 11:52, Bjorn Andersson wrote:
> On Tue 19 Jun 04:13 PDT 2018, Kiran Gunda wrote:
> 
>> The auto string detection algorithm checks if the current WLED
>> sink configuration is valid. It tries enabling every sink and
>> checks if the OVP fault is observed. Based on this information
>> it detects and enables the valid sink configuration.
>> Auto calibration will be triggered when the OVP fault interrupts
>> are seen frequently thereby it tries to fix the sink configuration.
>> 
>> The auto-detection also kicks in when the connected LED string
>> of the display-backlight malfunctions (because of damage) and
>> requires the damaged string to be turned off to prevent the
>> complete panel and/or board from being damaged.
>> 
>> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
>> ---
>>  drivers/video/backlight/qcom-wled.c | 408 
>> +++++++++++++++++++++++++++++++++++-
>>  1 file changed, 403 insertions(+), 5 deletions(-)
>> 
>> diff --git a/drivers/video/backlight/qcom-wled.c 
>> b/drivers/video/backlight/qcom-wled.c
>> index e87ba70..6bc627c 100644
>> --- a/drivers/video/backlight/qcom-wled.c
>> +++ b/drivers/video/backlight/qcom-wled.c
>> @@ -25,13 +25,23 @@
>>  #define WLED_MAX_STRINGS				4
>> 
>>  #define WLED_DEFAULT_BRIGHTNESS				2048
>> -
>> +#define WLED_SOFT_START_DLY_US				10000
>>  #define WLED3_SINK_REG_BRIGHT_MAX			0xFFF
>> 
>>  /* WLED3 control registers */
>> +#define WLED3_CTRL_REG_FAULT_STATUS			0x08
>> +#define  WLED3_CTRL_REG_ILIM_FAULT_BIT			BIT(0)
>> +#define  WLED3_CTRL_REG_OVP_FAULT_BIT			BIT(1)
>> +#define  WLED4_CTRL_REG_SC_FAULT_BIT			BIT(2)
>> +
>> +#define WLED3_CTRL_REG_INT_RT_STS			0x10
>> +#define  WLED3_CTRL_REG_OVP_FAULT_STATUS		BIT(1)
>> +
> 
> These seems to be used in both WLED 3 and 4, so please drop the 3 from
> the name.
> 
Sure. I will change it in the next series.
>>  #define WLED3_CTRL_REG_MOD_EN				0x46
>>  #define  WLED3_CTRL_REG_MOD_EN_MASK			BIT(7)
>> 
>> +#define WLED3_CTRL_REG_FEEDBACK_CONTROL			0x48
>> +
>>  #define WLED3_CTRL_REG_FREQ				0x4c
>>  #define  WLED3_CTRL_REG_FREQ_MASK			GENMASK(3, 0)
>> 
>> @@ -146,6 +156,7 @@ struct wled_config {
>>  	bool ext_gen;
>>  	bool cabc;
>>  	bool external_pfet;
>> +	bool auto_detection_enabled;
>>  };
>> 
>>  struct wled {
>> @@ -154,16 +165,22 @@ struct wled {
>>  	struct regmap *regmap;
>>  	struct mutex lock;	/* Lock to avoid race from ISR */
>>  	ktime_t last_short_event;
>> +	ktime_t start_ovp_fault_time;
>>  	u16 ctrl_addr;
>>  	u16 sink_addr;
>> +	u16 auto_detection_ovp_count;
>>  	u32 brightness;
>>  	u32 max_brightness;
>>  	u32 short_count;
>> +	u32 auto_detect_count;
>>  	const int *version;
>>  	bool disabled_by_short;
>>  	bool has_short_detect;
>> +	int ovp_irq;
>> +	bool ovp_irq_disabled;
>> 
>>  	struct wled_config cfg;
>> +	struct delayed_work ovp_work;
>>  	int (*wled_set_brightness)(struct wled *wled, u16 brightness);
>>  	int (*wled_sync_toggle)(struct wled *wled);
>>  };
>> @@ -209,6 +226,27 @@ static int wled4_set_brightness(struct wled 
>> *wled, u16 brightness)
>>  	return 0;
>>  }
>> 
>> +static void wled_ovp_work(struct work_struct *work)
>> +{
>> +	u32 val;
>> +	int rc;
>> +
>> +	struct wled *wled = container_of(work,
>> +					 struct wled, ovp_work.work);
>> +
>> +	rc = regmap_read(wled->regmap, wled->ctrl_addr + 
>> WLED3_CTRL_REG_MOD_EN,
>> +			 &val);
>> +	if (rc < 0)
>> +		return;
>> +
>> +	if (val & WLED3_CTRL_REG_MOD_EN_MASK) {
> 
> The way you implement this now makes this a "delayed enable_irq" 
> worker,
> as such you shouldn't need to check if the hardware is enabled here but
> just blindly enable_irq() and then in module_enable() you can check the
> return value of cancel_delayed_work() to know if enable_irq() has been
> called.
> 
Ok. I will modify as per your suggestion in the next series.
>> +		if (wled->ovp_irq > 0 && wled->ovp_irq_disabled) {
>> +			enable_irq(wled->ovp_irq);
>> +			wled->ovp_irq_disabled = false;
>> +		}
>> +	}
>> +}
>> +
>>  static int wled_module_enable(struct wled *wled, int val)
>>  {
>>  	int rc;
>> @@ -220,7 +258,20 @@ static int wled_module_enable(struct wled *wled, 
>> int val)
>>  				WLED3_CTRL_REG_MOD_EN,
>>  				WLED3_CTRL_REG_MOD_EN_MASK,
>>  				WLED3_CTRL_REG_MOD_EN_MASK);
>> -	return rc;
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	if (val) {
>> +		schedule_delayed_work(&wled->ovp_work, WLED_SOFT_START_DLY_US);
>> +	} else {
>> +		cancel_delayed_work(&wled->ovp_work);
> 
> I recommend using cancel_delayed_work_sync() to ensure that htis isn't
> racing with the worker.
> 
Sure. I will modify it in next series.
>> +		if (wled->ovp_irq > 0 && !wled->ovp_irq_disabled) {
>> +			disable_irq(wled->ovp_irq);
>> +			wled->ovp_irq_disabled = true;
>> +		}
>> +	}
>> +
>> +	return 0;
>>  }
>> 
>>  static int wled3_sync_toggle(struct wled *wled)
>> @@ -346,6 +397,305 @@ static irqreturn_t wled_short_irq_handler(int 
>> irq, void *_wled)
>>  	return IRQ_HANDLED;
>>  }
>> 
>> +#define AUTO_DETECT_BRIGHTNESS		200
>> +static int wled_auto_string_detection(struct wled *wled)
> 
> You don't care about the return value of this function in any of the
> callers.
> 
I will make it void in the next series.
>> +{
>> +	int rc = 0, i;
>> +	u32 sink_config = 0, int_sts;
>> +	u8 sink_test = 0, sink_valid = 0, val;
>> +
>> +	/* read configured sink configuration */
>> +	rc = regmap_read(wled->regmap, wled->sink_addr +
>> +			 WLED4_SINK_REG_CURR_SINK, &sink_config);
>> +	if (rc < 0) {
>> +		pr_err("Failed to read SINK configuration rc=%d\n", rc);
>> +		goto failed_detect;
>> +	}
>> +
>> +	/* disable the module before starting detection */
>> +	rc = regmap_update_bits(wled->regmap,
>> +				wled->ctrl_addr + WLED3_CTRL_REG_MOD_EN,
>> +				WLED3_CTRL_REG_MOD_EN_MASK, 0);
>> +	if (rc < 0) {
>> +		pr_err("Failed to disable WLED module rc=%d\n", rc);
>> +		goto failed_detect;
>> +	}
>> +
>> +	/* set low brightness across all sinks */
>> +	rc = wled4_set_brightness(wled, AUTO_DETECT_BRIGHTNESS);
>> +	if (rc < 0) {
>> +		pr_err("Failed to set brightness for auto detection rc=%d\n",
>> +		       rc);
>> +		goto failed_detect;
>> +	}
>> +
>> +	if (wled->cfg.cabc) {
>> +		for (i = 0; i < wled->cfg.num_strings; i++) {
>> +			rc = regmap_update_bits(wled->regmap, wled->sink_addr +
>> +						WLED4_SINK_REG_STR_CABC(i),
>> +						WLED4_SINK_REG_STR_CABC_MASK,
>> +						0);
>> +			if (rc < 0)
>> +				goto failed_detect;
>> +		}
>> +	}
>> +
>> +	/* disable all sinks */
>> +	rc = regmap_write(wled->regmap,
>> +			  wled->sink_addr + WLED4_SINK_REG_CURR_SINK, 0);
>> +	if (rc < 0) {
>> +		pr_err("Failed to disable all sinks rc=%d\n", rc);
>> +		goto failed_detect;
>> +	}
>> +
>> +	/* iterate through the strings one by one */
>> +	for (i = 0; i < wled->cfg.num_strings; i++) {
>> +		sink_test = BIT((WLED4_SINK_REG_CURR_SINK_SHFT + i));
>> +
>> +		/* Enable feedback control */
>> +		rc = regmap_write(wled->regmap, wled->ctrl_addr +
>> +				  WLED3_CTRL_REG_FEEDBACK_CONTROL, i + 1);
>> +		if (rc < 0) {
>> +			pr_err("Failed to enable feedback for SINK %d rc = %d\n",
>> +			       i + 1, rc);
>> +			goto failed_detect;
>> +		}
>> +
>> +		/* enable the sink */
>> +		rc = regmap_write(wled->regmap, wled->sink_addr +
>> +				  WLED4_SINK_REG_CURR_SINK, sink_test);
>> +		if (rc < 0) {
>> +			pr_err("Failed to configure SINK %d rc=%d\n", i + 1,
>> +			       rc);
>> +			goto failed_detect;
>> +		}
>> +
>> +		/* Enable the module */
>> +		rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
>> +					WLED3_CTRL_REG_MOD_EN,
>> +					WLED3_CTRL_REG_MOD_EN_MASK,
>> +					WLED3_CTRL_REG_MOD_EN_MASK);
>> +		if (rc < 0) {
>> +			pr_err("Failed to enable WLED module rc=%d\n", rc);
>> +			goto failed_detect;
>> +		}
>> +
>> +		usleep_range(WLED_SOFT_START_DLY_US,
>> +			     WLED_SOFT_START_DLY_US + 1000);
>> +
>> +		rc = regmap_read(wled->regmap, wled->ctrl_addr +
>> +				 WLED3_CTRL_REG_INT_RT_STS, &int_sts);
>> +		if (rc < 0) {
>> +			pr_err("Error in reading WLED3_CTRL_INT_RT_STS rc=%d\n",
>> +			       rc);
> 
> You should probably do something about the state of the hardware if it
> fail here.
> 
This is a spmi read and it is very unlikely to fail. If it fails it 
leads the complete
system to go in to bad state.
>> +			goto failed_detect;
>> +		}
>> +
>> +		if (int_sts & WLED3_CTRL_REG_OVP_FAULT_STATUS)
>> +			pr_debug("WLED OVP fault detected with SINK %d\n",
>> +				 i + 1);
>> +		else
>> +			sink_valid |= sink_test;
>> +
>> +		/* Disable the module */
>> +		rc = regmap_update_bits(wled->regmap,
>> +					wled->ctrl_addr + WLED3_CTRL_REG_MOD_EN,
>> +					WLED3_CTRL_REG_MOD_EN_MASK, 0);
>> +		if (rc < 0) {
>> +			pr_err("Failed to disable WLED module rc=%d\n", rc);
>> +			goto failed_detect;
>> +		}
>> +	}
>> +
>> +	if (sink_valid == sink_config) {
>> +		pr_debug("WLED auto-detection complete, default sink-config=%x 
>> OK!\n",
>> +			 sink_config);
> 
> It's not the "default" sink config we're using, it's whatever was
> configured before this function was called.
> 
I will correct it in the next series.
>> +	} else {
>> +		pr_warn("Invalid WLED default sink config=%x changing it to=%x\n",
> 
> Use dev_warn(), and as it's not the "default sink config" that's 
> invalid
> write something like "New WLED string configuration found: %x". Perhaps
> you can print it using %*pbl ?
> 
I will modify it in the next series. I missed to modify here.
>> +			sink_config, sink_valid);
>> +		sink_config = sink_valid;
>> +	}
>> +
>> +	if (!sink_config) {
>> +		pr_err("No valid WLED sinks found\n");
> 
> dev_err() and move this above the other prints, there's no reason to
> first say that you found an "invalid WLED default" and then say that 
> you
> didn't findd a valid config.
> 
Sure. I will move it in the next series.
>> +		wled->disabled_by_short = true;
>> +		goto failed_detect;
>> +	}
>> +
>> +	/* write the new sink configuration */
>> +	rc = regmap_write(wled->regmap,
>> +			  wled->sink_addr + WLED4_SINK_REG_CURR_SINK,
>> +			  sink_config);
>> +	if (rc < 0) {
>> +		pr_err("Failed to reconfigure the default sink rc=%d\n", rc);
>> +		goto failed_detect;
>> +	}
>> +
>> +	/* Enable valid sinks */
>> +	for (i = 0; i < wled->cfg.num_strings; i++) {
>> +		if (wled->cfg.cabc) {
>> +			rc = regmap_update_bits(wled->regmap, wled->sink_addr +
>> +						WLED4_SINK_REG_STR_CABC(i),
>> +						WLED4_SINK_REG_STR_CABC_MASK,
>> +						WLED4_SINK_REG_STR_CABC_MASK);
>> +			if (rc < 0)
>> +				goto failed_detect;
>> +		}
>> +
>> +		if (sink_config & BIT(WLED4_SINK_REG_CURR_SINK_SHFT + i))
>> +			val = WLED4_SINK_REG_STR_MOD_MASK;
>> +		else
>> +			val = 0x0; /* disable modulator_en for unused sink */
>> +
>> +		rc = regmap_write(wled->regmap, wled->sink_addr +
>> +				  WLED4_SINK_REG_STR_MOD_EN(i), val);
>> +		if (rc < 0) {
>> +			pr_err("Failed to configure MODULATOR_EN rc=%d\n", rc);
>> +			goto failed_detect;
>> +		}
>> +	}
>> +
>> +	/* restore the feedback setting */
>> +	rc = regmap_write(wled->regmap,
>> +			  wled->ctrl_addr + WLED3_CTRL_REG_FEEDBACK_CONTROL, 0);
>> +	if (rc < 0) {
>> +		pr_err("Failed to restore feedback setting rc=%d\n", rc);
>> +		goto failed_detect;
>> +	}
>> +
>> +	/* restore  brightness */
> 
> Extra space
> 
Will remove it in the next series.
>> +	rc = wled4_set_brightness(wled, wled->brightness);
>> +	if (rc < 0) {
>> +		pr_err("Failed to set brightness after auto detection rc=%d\n",
>> +		       rc);
>> +		goto failed_detect;
>> +	}
>> +
>> +	rc = regmap_update_bits(wled->regmap,
>> +				wled->ctrl_addr + WLED3_CTRL_REG_MOD_EN,
>> +				WLED3_CTRL_REG_MOD_EN_MASK,
>> +				WLED3_CTRL_REG_MOD_EN_MASK);
>> +	if (rc < 0) {
>> +		pr_err("Failed to enable WLED module rc=%d\n", rc);
>> +		goto failed_detect;
>> +	}
>> +
>> +failed_detect:
>> +	return rc;
>> +}
>> +
>> +#define WLED_AUTO_DETECT_OVP_COUNT		5
>> +#define WLED_AUTO_DETECT_CNT_DLY_US		USEC_PER_SEC
>> +static bool wled_auto_detection_required(struct wled *wled)
>> +{
>> +	s64 elapsed_time_us;
>> +
>> +	if (*wled->version == WLED_PM8941 || 
>> !wled->cfg.auto_detection_enabled)
> 
> Ensure that auto_detection_enabled can't be enabled for pm8941, so that
> you don't need to check the first part.
> 
I will change it in the next series.
>> +		return false;
>> +
>> +	/*
>> +	 * Check if the OVP fault was an occasional one
>> +	 * or if it's firing continuously, the latter qualifies
>> +	 * for an auto-detection check.
>> +	 */
>> +	if (!wled->auto_detection_ovp_count) {
>> +		wled->start_ovp_fault_time = ktime_get();
>> +		wled->auto_detection_ovp_count++;
>> +	} else {
>> +		elapsed_time_us = ktime_us_delta(ktime_get(),
>> +						 wled->start_ovp_fault_time);
>> +		if (elapsed_time_us > WLED_AUTO_DETECT_CNT_DLY_US)
>> +			wled->auto_detection_ovp_count = 0;
>> +		else
>> +			wled->auto_detection_ovp_count++;
>> +
>> +		if (wled->auto_detection_ovp_count >=
>> +				WLED_AUTO_DETECT_OVP_COUNT) {
>> +			wled->auto_detection_ovp_count = 0;
>> +			return true;
>> +		}
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static int wled_auto_detection_at_init(struct wled *wled)
>> +{
>> +	int rc;
>> +	u32 fault_status = 0, rt_status = 0;
> 
> No need to initialize these, they will be filled out if regmap_read
> return successfully.
> 
I will remove it in the next series.
>> +
>> +	if (!wled->cfg.auto_detection_enabled)
>> +		return 0;
>> +
> [..]
>> @@ -836,6 +1192,42 @@ static int wled_configure_short_irq(struct wled 
>> *wled,
>>  	return rc;
>>  }
>> 
>> +static int wled_configure_ovp_irq(struct wled *wled,
>> +				  struct platform_device *pdev)
>> +{
>> +	int rc = 0;
> 
> No need to initialize rc here.
> 
I will remove it in the next series.
>> +	u32 val;
>> +
>> +	wled->ovp_irq = platform_get_irq_byname(pdev, "ovp");
>> +	if (wled->ovp_irq < 0) {
>> +		dev_dbg(&pdev->dev, "ovp irq is not used\n");
>> +		return 0;
>> +	}
>> +
>> +	rc = devm_request_threaded_irq(wled->dev, wled->ovp_irq, NULL,
>> +				       wled_ovp_irq_handler, IRQF_ONESHOT,
>> +				       "wled_ovp_irq", wled);
>> +	if (rc < 0) {
>> +		dev_err(wled->dev, "Unable to request ovp_irq (err:%d)\n",
>> +			rc);
>> +		wled->ovp_irq = 0;
>> +		return 0;
>> +	}
>> +
>> +	rc = regmap_read(wled->regmap, wled->ctrl_addr +
>> +			 WLED3_CTRL_REG_MOD_EN, &val);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	/* Keep OVP irq disabled until module is enabled */
>> +	if (!rc && !(val & WLED3_CTRL_REG_MOD_EN_MASK)) {
> 
> If rc isn't 0 we returned above.
> 
I will remove it in the next series.
>> +		disable_irq(wled->ovp_irq);
>> +		wled->ovp_irq_disabled = true;
>> +	}
>> +
>> +	return rc;
> 
> As such, it is always 0 here.
> 
I will modify it in the next series.
>> +}
>> +
> 
> Regards,
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
