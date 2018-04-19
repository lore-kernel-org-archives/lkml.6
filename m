Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeDSKpw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 06:45:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34720 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbeDSKpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 06:45:47 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Apr 2018 16:15:44 +0530
From: kgunda@codeaurora.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V1 4/4] qcom: spmi-wled: Add auto-calibration logic
 support
In-Reply-To: <20171205054004.GG28761@minitux>
References: <1510834717-21765-1-git-send-email-kgunda@codeaurora.org>
 <1510834717-21765-5-git-send-email-kgunda@codeaurora.org>
 <20171205054004.GG28761@minitux>
Message-ID: <d5ab425e78957fd59145f7d49fd897e6@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2017-12-05 11:10, Bjorn Andersson wrote:
> On Thu 16 Nov 04:18 PST 2017, Kiran Gunda wrote:
> 
>> The auto-calibration algorithm checks if the current WLED sink
>> configuration is valid. It tries enabling every sink and checks
>> if the OVP fault is observed. Based on this information it
>> detects and enables the valid sink configuration. Auto calibration
>> will be triggered when the OVP fault interrupts are seen frequently
>> thereby it tries to fix the sink configuration.
>> 
> 
> So it's not auto "calibration" it's auto "detection" of strings?
> 
Hi Bjorn,
Sorry for late response. Please find my answers.

Correct. This is the auto detection, This is the name given by the 
HW/systems team.
> When is this feature needed?
> 
This feature is needed if the string configuration is given wrong in the 
DT node by the
user.
>> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
>> ---
>>  .../bindings/leds/backlight/qcom-spmi-wled.txt     |   5 +
>>  drivers/video/backlight/qcom-spmi-wled.c           | 304 
>> ++++++++++++++++++++-
>>  2 files changed, 306 insertions(+), 3 deletions(-)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt 
>> b/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt
>> index d39ee93..f06c0cd 100644
>> --- 
>> a/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt
>> +++ 
>> b/Documentation/devicetree/bindings/leds/backlight/qcom-spmi-wled.txt
>> @@ -94,6 +94,11 @@ The PMIC is connected to the host processor via 
>> SPMI bus.
>>  	Definition: Interrupt names associated with the interrupts.
>>  		    Currently supported interrupts are "sc-irq" and "ovp-irq".
>> 
>> +- qcom,auto-calibration
> 
> qcom,auto-string-detect?
> 
ok. Will address in the next patch.
>> +	Usage:      optional
>> +	Value type: <bool>
>> +	Definition: Enables auto-calibration of the WLED sink configuration.
>> +
>>  Example:
>> 
>>  qcom-wled@d800 {
>> diff --git a/drivers/video/backlight/qcom-spmi-wled.c 
>> b/drivers/video/backlight/qcom-spmi-wled.c
>> index 8b2a77a..aee5c56 100644
>> --- a/drivers/video/backlight/qcom-spmi-wled.c
>> +++ b/drivers/video/backlight/qcom-spmi-wled.c
>> @@ -38,11 +38,14 @@
>>  #define  QCOM_WLED_CTRL_SC_FAULT_BIT		BIT(2)
>> 
>>  #define QCOM_WLED_CTRL_INT_RT_STS		0x10
>> +#define  QCOM_WLED_CTRL_OVP_FLT_RT_STS_BIT	BIT(1)
> 
> The use of BIT() makes this a mask and not a bit number, so if you just
> drop that you can afford to spell out the "FAULT" like the data sheet
> does. Perhaps even making it QCOM_WLED_CTRL_OVP_FAULT_STATUS ?
> 
ok. Will change it in the next series.
>> 
>>  #define QCOM_WLED_CTRL_MOD_ENABLE		0x46
>>  #define  QCOM_WLED_CTRL_MOD_EN_MASK		BIT(7)
>>  #define  QCOM_WLED_CTRL_MODULE_EN_SHIFT		7
>> 
>> +#define QCOM_WLED_CTRL_FDBK_OP			0x48
> 
> This is called WLED_CTRL_FEEDBACK_CONTROL, why the need to make it
> unreadable?
> 
Ok. Will address it in next series.
>> +
>>  #define QCOM_WLED_CTRL_SWITCH_FREQ		0x4c
>>  #define  QCOM_WLED_CTRL_SWITCH_FREQ_MASK	GENMASK(3, 0)
>> 
>> @@ -99,6 +102,7 @@ struct qcom_wled_config {
>>  	int ovp_irq;
>>  	bool en_cabc;
>>  	bool ext_pfet_sc_pro_en;
>> +	bool auto_calib_enabled;
>>  };
>> 
>>  struct qcom_wled {
>> @@ -108,18 +112,25 @@ struct qcom_wled {
>>  	struct mutex lock;
>>  	struct qcom_wled_config cfg;
>>  	ktime_t last_sc_event_time;
>> +	ktime_t start_ovp_fault_time;
>>  	u16 sink_addr;
>>  	u16 ctrl_addr;
>> +	u16 auto_calibration_ovp_count;
>>  	u32 brightness;
>>  	u32 sc_count;
>>  	bool prev_state;
>>  	bool ovp_irq_disabled;
>> +	bool auto_calib_done;
>> +	bool force_mod_disable;
>>  };
>> 
>>  static int qcom_wled_module_enable(struct qcom_wled *wled, int val)
>>  {
>>  	int rc;
>> 
>> +	if (wled->force_mod_disable)
>> +		return 0;
>> +
>>  	rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
>>  			QCOM_WLED_CTRL_MOD_ENABLE, QCOM_WLED_CTRL_MOD_EN_MASK,
>>  			val << QCOM_WLED_CTRL_MODULE_EN_SHIFT);
>> @@ -187,12 +198,10 @@ static int qcom_wled_set_brightness(struct 
>> qcom_wled *wled, u16 brightness)
>>  	v[1] = (brightness >> 8) & 0xf;
>> 
>>  	for (i = 0; (string_cfg >> i) != 0; i++) {
>> -		if (string_cfg & BIT(i)) {
> 
> Why was this check here in the first place, if it's now fine to
> configure the brightness of all strings?
> 
> Also, a single-string config of 0b0001 will only set brightness on the
> first string, while 0b1000 will set brightness on all strings.
> 
I will correct/remove it next series.
>>  			rc = regmap_bulk_write(wled->regmap, wled->sink_addr +
>>  					QCOM_WLED_SINK_BRIGHT_LSB_REG(i), v, 2);
>>  			if (rc < 0)
>>  				return rc;
>> -		}
>>  	}
>> 
>>  	return 0;
>> @@ -294,6 +303,262 @@ static irqreturn_t qcom_wled_sc_irq_handler(int 
>> irq, void *_wled)
>>  	return IRQ_HANDLED;
>>  }
>> 
>> +#define AUTO_CALIB_BRIGHTNESS		200
>> +static int qcom_wled_auto_calibrate(struct qcom_wled *wled)
>> +{
>> +	int rc = 0, i;
>> +	u32 sink_config = 0, int_sts;
>> +	u8 reg = 0, sink_test = 0, sink_valid = 0;
>> +	u8 string_cfg = wled->cfg.string_cfg;
>> +
>> +	/* read configured sink configuration */
>> +	rc = regmap_read(wled->regmap, wled->sink_addr +
>> +			QCOM_WLED_SINK_CURR_SINK_EN, &sink_config);
>> +	if (rc < 0) {
>> +		pr_err("Failed to read SINK configuration rc=%d\n", rc);
>> +		goto failed_calib;
>> +	}
>> +
>> +	/* disable the module before starting calibration */
>> +	rc = regmap_update_bits(wled->regmap,
>> +			wled->ctrl_addr + QCOM_WLED_CTRL_MOD_ENABLE,
>> +			QCOM_WLED_CTRL_MOD_EN_MASK, 0);
>> +	if (rc < 0) {
>> +		pr_err("Failed to disable WLED module rc=%d\n",	rc);
>> +		goto failed_calib;
>> +	}
> 
> Any error handling beyond this point seems to leave the backlight off
> (indefinitely?), this does seem like potentially bad user experience...
Ok. will address in next series.
> 
> In particular I wonder about the case when this would happen at some
> random time, minutes, hours, days, months after the device was booted.
> 
This will happen for every reboot.
>> +
>> +	/* set low brightness across all sinks */
>> +	rc = qcom_wled_set_brightness(wled, AUTO_CALIB_BRIGHTNESS);
>> +	if (rc < 0) {
>> +		pr_err("Failed to set brightness for calibration rc=%d\n", rc);
>> +		goto failed_calib;
>> +	}
>> +
>> +	if (wled->cfg.en_cabc) {
>> +		for (i = 0; (string_cfg >> i) != 0; i++) {
>> +			reg = 0;
>> +			rc = regmap_update_bits(wled->regmap, wled->sink_addr +
>> +					QCOM_WLED_SINK_CABC_REG(i),
>> +					QCOM_WLED_SINK_CABC_MASK, reg);
> 
> Just replace "reg" with 0.
Ok. will address in next series.
> 
>> +			if (rc < 0)
>> +				goto failed_calib;
>> +		}
>> +	}
>> +
>> +	/* disable all sinks */
>> +	rc = regmap_write(wled->regmap,
>> +			wled->sink_addr + QCOM_WLED_SINK_CURR_SINK_EN, 0);
>> +	if (rc < 0) {
>> +		pr_err("Failed to disable all sinks rc=%d\n", rc);
>> +		goto failed_calib;
>> +	}
>> +
>> +	/* iterate through the strings one by one */
>> +	for (i = 0; (string_cfg >> i) != 0; i++) {
>> +		sink_test = 1 << (QCOM_WLED_SINK_CURR_SINK_SHFT + i);
> 
> BIT(QCOM_WLED_SINK_CURR_SINK_SHFT + i);
> 
Will address in next series.
>> +
>> +		/* Enable feedback control */
>> +		rc = regmap_write(wled->regmap, wled->ctrl_addr +
>> +				QCOM_WLED_CTRL_FDBK_OP, i + 1);
>> +		if (rc < 0) {
>> +			pr_err("Failed to enable feedback for SINK %d rc = %d\n",
>> +				i + 1, rc);
>> +			goto failed_calib;
>> +		}
>> +
>> +		/* enable the sink */
>> +		rc = regmap_write(wled->regmap, wled->sink_addr +
>> +				QCOM_WLED_SINK_CURR_SINK_EN, sink_test);
>> +		if (rc < 0) {
>> +			pr_err("Failed to configure SINK %d rc=%d\n",
>> +						i + 1, rc);
>> +			goto failed_calib;
>> +		}
>> +
>> +		/* Enable the module */
>> +		rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
>> +				QCOM_WLED_CTRL_MOD_ENABLE,
>> +				QCOM_WLED_CTRL_MOD_EN_MASK,
>> +				QCOM_WLED_CTRL_MOD_EN_MASK);
> 
> I like the use of regmap_update_bits(..., MASK, MASK) it's clean, but
> makes me wonder why it's done differently in qcom_wled_module_enable().
> 
will address it in the next series.
>> +		if (rc < 0) {
>> +			pr_err("Failed to enable WLED module rc=%d\n", rc);
>> +			goto failed_calib;
>> +		}
>> +
>> +		usleep_range(QCOM_WLED_SOFT_START_DLY_US,
>> +				QCOM_WLED_SOFT_START_DLY_US + 1000);
>> +
>> +		rc = regmap_read(wled->regmap, wled->ctrl_addr +
>> +				QCOM_WLED_CTRL_INT_RT_STS, &int_sts);
>> +		if (rc < 0) {
>> +			pr_err("Error in reading WLED_INT_RT_STS rc=%d\n", rc);
>> +			goto failed_calib;
>> +		}
>> +
>> +		if (int_sts & QCOM_WLED_CTRL_OVP_FAULT_BIT)
>> +			pr_debug("WLED OVP fault detected with SINK %d\n",
>> +						i + 1);
>> +		else
>> +			sink_valid |= sink_test;
>> +
>> +		/* Disable the module */
>> +		rc = regmap_update_bits(wled->regmap,
>> +				wled->ctrl_addr + QCOM_WLED_CTRL_MOD_ENABLE,
>> +				QCOM_WLED_CTRL_MOD_EN_MASK, 0);
>> +		if (rc < 0) {
>> +			pr_err("Failed to disable WLED module rc=%d\n", rc);
>> +			goto failed_calib;
>> +		}
>> +	}
>> +
>> +	if (sink_valid == sink_config) {
>> +		pr_debug("WLED auto-calibration complete, default sink-config=%x 
>> OK!\n",
>> +						sink_config);
>> +	} else {
>> +		pr_warn("Invalid WLED default sink config=%x changing it to=%x\n",
>> +						sink_config, sink_valid);
>> +		sink_config = sink_valid;
>> +	}
>> +
>> +	if (!sink_config) {
>> +		pr_warn("No valid WLED sinks found\n");
>> +		wled->force_mod_disable = true;
>> +		goto failed_calib;
>> +	}
>> +
>> +	/* write the new sink configuration */
>> +	rc = regmap_write(wled->regmap,
>> +			wled->sink_addr + QCOM_WLED_SINK_CURR_SINK_EN,
>> +			sink_config);
>> +	if (rc < 0) {
>> +		pr_err("Failed to reconfigure the default sink rc=%d\n", rc);
>> +		goto failed_calib;
>> +	}
>> +
>> +	/* MODULATOR_EN setting for valid sinks */
> 
> "Enable valid sinks"
> 
Will address it in the next series.
>> +	for (i = 0; (string_cfg >> i) != 0; i++) {
>> +		if (wled->cfg.en_cabc) {
>> +			reg = QCOM_WLED_SINK_CABC_EN;
> 
> "reg" is a bad name of a variable holding the "value" to be written to 
> a
> register.
> 
Will address it in the next series.
>> +			rc = regmap_update_bits(wled->regmap, wled->sink_addr +
>> +					QCOM_WLED_SINK_CABC_REG(i),
>> +					QCOM_WLED_SINK_CABC_MASK, reg);
> 
> Again, just inline the value in the function call.
> 
Will address it in the next series.
>> +			if (rc < 0)
>> +				goto failed_calib;
>> +		}
>> +
>> +		if (sink_config & (1 << (QCOM_WLED_SINK_CURR_SINK_SHFT + i)))
> 
> BIT(QCOM_WLED_SINK_CURR_SINK_SHFT + i)
> 
Will address it in the next series.
>> +			reg = QCOM_WLED_SINK_REG_STR_MOD_EN;
>> +		else
>> +			reg = 0x0; /* disable modulator_en for unused sink */
>> +
>> +		rc = regmap_write(wled->regmap, wled->sink_addr +
>> +				QCOM_WLED_SINK_MOD_EN_REG(i), reg);
>> +		if (rc < 0) {
>> +			pr_err("Failed to configure MODULATOR_EN rc=%d\n", rc);
>> +			goto failed_calib;
>> +		}
>> +	}
>> +
>> +	/* restore the feedback setting */
>> +	rc = regmap_write(wled->regmap,
>> +			wled->ctrl_addr + QCOM_WLED_CTRL_FDBK_OP, 0);
>> +	if (rc < 0) {
>> +		pr_err("Failed to restore feedback setting rc=%d\n", rc);
>> +		goto failed_calib;
>> +	}
>> +
>> +	/* restore  brightness */
>> +	rc = qcom_wled_set_brightness(wled, wled->brightness);
>> +	if (rc < 0) {
>> +		pr_err("Failed to set brightness after calibration rc=%d\n",
>> +			rc);
>> +		goto failed_calib;
>> +	}
>> +
>> +	rc = regmap_update_bits(wled->regmap,
>> +			wled->ctrl_addr + QCOM_WLED_CTRL_MOD_ENABLE,
>> +			QCOM_WLED_CTRL_MOD_EN_MASK,
>> +			QCOM_WLED_CTRL_MOD_EN_MASK);
>> +	if (rc < 0) {
>> +		pr_err("Failed to enable WLED module rc=%d\n", rc);
>> +		goto failed_calib;
>> +	}
>> +
>> +	/* delay for WLED soft-start */
> 
> What comes after this that you want to delay?
> 
> This delay is used to make the OVP IRQ not fire immediately, but as
> we've now successfully executed the string auto detection run we're
> never going to do anything in the OVP handler.
> 
Will correct it in the next series.
>> +	usleep_range(QCOM_WLED_SOFT_START_DLY_US,
>> +			QCOM_WLED_SOFT_START_DLY_US + 1000);
>> +
>> +failed_calib:
>> +	return rc;
>> +}
>> +
>> +#define WLED_AUTO_CAL_OVP_COUNT		5
>> +#define WLED_AUTO_CAL_CNT_DLY_US	1000000	/* 1 second */
>> +static bool qcom_wled_auto_cal_required(struct qcom_wled *wled)
>> +{
>> +	s64 elapsed_time_us;
>> +
>> +	/*
>> +	 * Check if the OVP fault was an occasional one
>> +	 * or if its firing continuously, the latter qualifies
>> +	 * for an auto-calibration check.
>> +	 */
>> +	if (!wled->auto_calibration_ovp_count) {
>> +		wled->start_ovp_fault_time = ktime_get();
>> +		wled->auto_calibration_ovp_count++;
>> +	} else {
>> +		elapsed_time_us = ktime_us_delta(ktime_get(),
>> +				wled->start_ovp_fault_time);
>> +		if (elapsed_time_us > WLED_AUTO_CAL_CNT_DLY_US)
>> +			wled->auto_calibration_ovp_count = 0;
>> +		else
>> +			wled->auto_calibration_ovp_count++;
>> +
>> +		if (wled->auto_calibration_ovp_count >=
>> +				WLED_AUTO_CAL_OVP_COUNT) {
>> +			wled->auto_calibration_ovp_count = 0;
>> +			return true;
>> +		}
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static int qcom_wled_auto_calibrate_at_init(struct qcom_wled *wled)
> 
> I presume this function is expected to detect if there is a invalid
> configuration at boot and try to figure out which strings are actually
> wired.
> 
Correct.
>> +{
>> +	int rc;
>> +	u32 fault_status = 0, rt_status = 0;
>> +
>> +	if (!wled->cfg.auto_calib_enabled)
>> +		return 0;
>> +
>> +	rc = regmap_read(wled->regmap,
>> +			wled->ctrl_addr + QCOM_WLED_CTRL_INT_RT_STS,
>> +			&rt_status);
>> +	if (rc < 0)
>> +		pr_err("Failed to read RT status rc=%d\n", rc);
>> +
>> +	rc = regmap_read(wled->regmap,
>> +			wled->ctrl_addr + QCOM_WLED_CTRL_FAULT_STATUS,
>> +			&fault_status);
>> +	if (rc < 0)
>> +		pr_err("Failed to read fault status rc=%d\n", rc);
>> +
>> +	if ((rt_status & QCOM_WLED_CTRL_OVP_FLT_RT_STS_BIT) ||
>> +			(fault_status & QCOM_WLED_CTRL_OVP_FAULT_BIT)) {
> 
> You should be able to drop the extra () around these.
> 
Ok. Will remove it in the next series.
>> +		mutex_lock(&wled->lock);
>> +		rc = qcom_wled_auto_calibrate(wled);
>> +		if (rc < 0)
>> +			pr_err("Failed auto-calibration rc=%d\n", rc);
> 
> qcom_wled_auto_calibrate() did already print, no need to repeat this.
> 
Ok. Will remove this in the next series.
>> +		else
>> +			wled->auto_calib_done = true;
>> +		mutex_unlock(&wled->lock);
>> +	}
>> +
>> +	return rc;
>> +}
>> +
>>  static irqreturn_t qcom_wled_ovp_irq_handler(int irq, void *_wled)
>>  {
>>  	struct qcom_wled *wled = _wled;
>> @@ -319,6 +584,33 @@ static irqreturn_t qcom_wled_ovp_irq_handler(int 
>> irq, void *_wled)
>>  		pr_err("WLED OVP fault detected, int_sts=%x fault_sts= %x\n",
>>  			int_sts, fault_sts);
>> 
>> +	if (fault_sts & QCOM_WLED_CTRL_OVP_FAULT_BIT) {
>> +		if (wled->cfg.auto_calib_enabled && !wled->auto_calib_done) {
>> +			if (qcom_wled_auto_cal_required(wled)) {
> 
> So this will be invoked only once, iff we didn't boot with a faulty
> configuration in which case the qcom_wled_auto_calibrate_at_init() has
> already done this step and set auto_calib_done.
> 
> 
> Which also would mean that all logic in this handler, beyond the
> printouts, are only ever going to be executed zero or one times.
> 
> Why don't you just do auto-detection during probe (iff the flag is set
> in DT) and you can remove all this extra logic?
> 
I think we have seen a issue, where the OVP interrupt is not getting set
some times during the execution of this function at boot. In that case 
the auto calibration is
done bit later. That's why this code is added.
>> +				mutex_lock(&wled->lock);
>> +				if (wled->cfg.ovp_irq > 0 &&
>> +						!wled->ovp_irq_disabled) {
>> +					disable_irq_nosync(wled->cfg.ovp_irq);
>> +					wled->ovp_irq_disabled = true;
>> +				}
>> +
>> +				rc = qcom_wled_auto_calibrate(wled);
>> +				if (rc < 0)
>> +					pr_err("Failed auto-calibration rc=%d\n",
>> +						rc);
> 
> qcom_wled_auto_calibrate() did already print.
> 
Ok. I will remove it in the next series.
>> +				else
>> +					wled->auto_calib_done = true;
>> +
>> +				if (wled->cfg.ovp_irq > 0 &&
>> +						wled->ovp_irq_disabled) {
>> +					enable_irq(wled->cfg.ovp_irq);
>> +					wled->ovp_irq_disabled = false;
>> +				}
>> +				mutex_unlock(&wled->lock);
>> +			}
>> +		}
>> +	}
>> +
> 
> Regards,
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
