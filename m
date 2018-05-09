Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756102AbeEIFRf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 01:17:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33048 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752802AbeEIFRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 01:17:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 09 May 2018 10:47:31 +0530
From: kgunda@codeaurora.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: bjorn.andersson@linaro.org, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH V2 4/5] backlight: qcom-wled: Add support for OVP
 interrupt handling
In-Reply-To: <20180508103944.qib7ax3sgzhzacmb@holly.lan>
References: <1525342352-25072-1-git-send-email-kgunda@codeaurora.org>
 <1525342352-25072-5-git-send-email-kgunda@codeaurora.org>
 <20180508103944.qib7ax3sgzhzacmb@holly.lan>
Message-ID: <db3411e9fea2deda73ed1bb829349eef@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-08 16:09, Daniel Thompson wrote:
> On Thu, May 03, 2018 at 03:42:31PM +0530, Kiran Gunda wrote:
>> WLED peripheral has over voltage protection(OVP) circuitry and the OVP
>> fault is notified through an interrupt. Though this fault condition 
>> rising
>> is due to an incorrect hardware configuration is mitigated in the 
>> hardware,
>> it still needs to be detected and handled. Add support for it.
> 
> Why detect and handle it? The interrupt handler doesn't appear to do
> anything other than clear the interrupt... and it appears that the
> interrupt can be masked.
> 
> 
Planing to squash this patch with the auto-string-detection patch in the 
next series,
where the OVP is used for the right string detection.
>> When WLED module is enabled, keep OVP fault interrupt disabled for 10 
>> ms to
>> account for soft start delay.
>> 
>> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
>> ---
>>  drivers/video/backlight/qcom-wled.c | 118 
>> +++++++++++++++++++++++++++++++++++-
>>  1 file changed, 116 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/video/backlight/qcom-wled.c 
>> b/drivers/video/backlight/qcom-wled.c
>> index 2cfba77..80ae084 100644
>> --- a/drivers/video/backlight/qcom-wled.c
>> +++ b/drivers/video/backlight/qcom-wled.c
>> @@ -23,14 +23,20 @@
>> 
>>  /* From DT binding */
>>  #define WLED_DEFAULT_BRIGHTNESS				2048
>> -
>> +#define WLED_SOFT_START_DLY_US				10000
>>  #define WLED3_SINK_REG_BRIGHT_MAX			0xFFF
>> 
>>  /* WLED3 Control registers */
>>  #define WLED3_CTRL_REG_FAULT_STATUS			0x08
>> +#define  WLED3_CTRL_REG_ILIM_FAULT_BIT			BIT(0)
>> +#define  WLED3_CTRL_REG_OVP_FAULT_BIT			BIT(1)
>> +#define  WLED4_CTRL_REG_SC_FAULT_BIT			BIT(2)
>> +
>> +#define WLED3_CTRL_REG_INT_RT_STS			0x10
>> 
>>  #define WLED3_CTRL_REG_MOD_EN				0x46
>>  #define  WLED3_CTRL_REG_MOD_EN_MASK			BIT(7)
>> +#define  WLED3_CTRL_REG_MOD_EN_BIT			BIT(7)
>> 
>>  #define WLED3_CTRL_REG_FREQ				0x4c
>>  #define  WLED3_CTRL_REG_FREQ_MASK			GENMASK(3, 0)
>> @@ -161,9 +167,12 @@ struct wled {
>>  	u32 short_count;
>>  	const int *version;
>>  	int short_irq;
>> +	int ovp_irq;
>>  	bool force_mod_disable;
>> +	bool ovp_irq_disabled;
>> 
>>  	struct wled_config cfg;
>> +	struct delayed_work ovp_work;
>>  	int (*wled_set_brightness)(struct wled *wled, u16 brightness);
>>  	int (*wled_sync_toggle)(struct wled *wled);
>>  };
>> @@ -209,6 +218,32 @@ static int wled4_set_brightness(struct wled 
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
>> +	if (val & WLED3_CTRL_REG_MOD_EN_BIT) {
>> +		if (wled->ovp_irq > 0 && wled->ovp_irq_disabled) {
>> +			enable_irq(wled->ovp_irq);
>> +			wled->ovp_irq_disabled = false;
>> +		}
>> +	} else {
>> +		if (wled->ovp_irq > 0 && !wled->ovp_irq_disabled) {
>> +			disable_irq(wled->ovp_irq);
>> +			wled->ovp_irq_disabled = true;
>> +		}
>> +	}
>> +}
>> +
>>  static int wled_module_enable(struct wled *wled, int val)
>>  {
>>  	int rc;
>> @@ -220,7 +255,12 @@ static int wled_module_enable(struct wled *wled, 
>> int val)
>>  				WLED3_CTRL_REG_MOD_EN,
>>  				WLED3_CTRL_REG_MOD_EN_MASK,
>>  				WLED3_CTRL_REG_MOD_EN_MASK);
>> -	return rc;
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	schedule_delayed_work(&wled->ovp_work, WLED_SOFT_START_DLY_US);
>> +
>> +	return 0;
>>  }
>> 
>>  static int wled3_sync_toggle(struct wled *wled)
>> @@ -346,6 +386,36 @@ static irqreturn_t wled_short_irq_handler(int 
>> irq, void *_wled)
>>  	return IRQ_HANDLED;
>>  }
>> 
>> +static irqreturn_t wled_ovp_irq_handler(int irq, void *_wled)
>> +{
>> +	struct wled *wled = _wled;
>> +	int rc;
>> +	u32 int_sts, fault_sts;
>> +
>> +	rc = regmap_read(wled->regmap,
>> +			 wled->ctrl_addr + WLED3_CTRL_REG_INT_RT_STS, &int_sts);
>> +	if (rc < 0) {
>> +		dev_err(wled->dev, "Error in reading WLED3_INT_RT_STS rc=%d\n",
>> +			rc);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	rc = regmap_read(wled->regmap, wled->ctrl_addr +
>> +			 WLED3_CTRL_REG_FAULT_STATUS, &fault_sts);
>> +	if (rc < 0) {
>> +		dev_err(wled->dev, "Error in reading WLED_FAULT_STATUS rc=%d\n",
>> +			rc);
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	if (fault_sts &
>> +		(WLED3_CTRL_REG_OVP_FAULT_BIT | WLED3_CTRL_REG_ILIM_FAULT_BIT))
>> +		dev_dbg(wled->dev, "WLED OVP fault detected, int_sts=%x fault_sts= 
>> %x\n",
>> +			int_sts, fault_sts);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>>  static int wled3_setup(struct wled *wled)
>>  {
>>  	u16 addr;
>> @@ -821,6 +891,44 @@ static int wled_configure_short_irq(struct wled 
>> *wled,
>>  	return rc;
>>  }
>> 
>> +static int wled_configure_ovp_irq(struct wled *wled,
>> +				  struct platform_device *pdev)
>> +{
>> +	int rc = 0;
>> +	u32 val;
>> +
>> +	if (*wled->version == WLED_PM8941)
>> +		return 0;
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
>> +		disable_irq(wled->ovp_irq);
>> +		wled->ovp_irq_disabled = true;
>> +	}
>> +
>> +	return rc;
>> +}
>> +
>>  static const struct backlight_ops wled_ops = {
>>  	.update_status = wled_update_status,
>>  };
>> @@ -874,10 +982,16 @@ static int wled_probe(struct platform_device 
>> *pdev)
>>  		}
>>  	}
>> 
>> +	INIT_DELAYED_WORK(&wled->ovp_work, wled_ovp_work);
>> +
>>  	rc = wled_configure_short_irq(wled, pdev);
>>  	if (rc < 0)
>>  		return rc;
>> 
>> +	rc = wled_configure_ovp_irq(wled, pdev);
>> +	if (rc < 0)
>> +		return rc;
>> +
>>  	val = WLED_DEFAULT_BRIGHTNESS;
>>  	of_property_read_u32(pdev->dev.of_node, "default-brightness", &val);
>> 
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
>> Forum,
>>  a Linux Foundation Collaborative Project
>> 
