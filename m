Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbeEGRFd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 13:05:33 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:42818 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752435AbeEGRFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 13:05:30 -0400
X-Google-Smtp-Source: AB8JxZrYeYD93MguayAllFHnTl9XevhgenAJcfwDCPyPmLigg69+sokaZxRHpHavj6c/e7B3FbfhSg==
Date: Mon, 7 May 2018 10:06:52 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Kiran Gunda <kgunda@codeaurora.org>
Cc: Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH V1 3/5] backlight: qcom-wled: Add support for short
 circuit handling
Message-ID: <20180507170652.GC2259@tuxbook-pro>
References: <1525341432-15818-1-git-send-email-kgunda@codeaurora.org>
 <1525341432-15818-4-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525341432-15818-4-git-send-email-kgunda@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03 May 02:57 PDT 2018, Kiran Gunda wrote:

> Handle the short circuit interrupt and check if the short circuit
> interrupt is valid. Re-enable the module to check if it goes
> away. Disable the module altogether if the short circuit event
> persists.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> ---
>  drivers/video/backlight/qcom-wled.c | 134 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 130 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/backlight/qcom-wled.c b/drivers/video/backlight/qcom-wled.c
> index be8b8d3..2cfba77 100644
> --- a/drivers/video/backlight/qcom-wled.c
> +++ b/drivers/video/backlight/qcom-wled.c
> @@ -10,6 +10,9 @@
>   * GNU General Public License for more details.
>   */
>  
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/ktime.h>
>  #include <linux/kernel.h>
>  #include <linux/backlight.h>
>  #include <linux/module.h>
> @@ -23,7 +26,9 @@
>  
>  #define WLED3_SINK_REG_BRIGHT_MAX			0xFFF
>  
> -/* Control registers */
> +/* WLED3 Control registers */

Minor nit, please move the change of this comment to the previous patch.

> +#define WLED3_CTRL_REG_FAULT_STATUS			0x08

Unused.

> +
>  #define WLED3_CTRL_REG_MOD_EN				0x46
>  #define  WLED3_CTRL_REG_MOD_EN_MASK			BIT(7)
>  
> @@ -36,7 +41,17 @@
>  #define WLED3_CTRL_REG_ILIMIT				0x4e
>  #define  WLED3_CTRL_REG_ILIMIT_MASK			GENMASK(2, 0)
>  
> -/* sink registers */

Please move comment change to previous commit.

> +/* WLED4 control registers */
> +#define WLED4_CTRL_REG_SHORT_PROTECT			0x5e
> +#define  WLED4_CTRL_REG_SHORT_EN_MASK			BIT(7)
> +
> +#define WLED4_CTRL_REG_SEC_ACCESS			0xd0
> +#define  WLED4_CTRL_REG_SEC_UNLOCK			0xa5
> +
> +#define WLED4_CTRL_REG_TEST1				0xe2
> +#define  WLED4_CTRL_REG_TEST1_EXT_FET_DTEST2		0x09
> +
> +/* WLED3 sink registers */
>  #define WLED3_SINK_REG_SYNC				0x47
>  #define  WLED3_SINK_REG_SYNC_MASK			GENMASK(2, 0)
>  #define  WLED4_SINK_REG_SYNC_MASK			GENMASK(3, 0)
> @@ -130,17 +145,23 @@ struct wled_config {
>  	bool cs_out_en;
>  	bool ext_gen;
>  	bool cabc;
> +	bool external_pfet;
>  };
>  
>  struct wled {
>  	const char *name;
>  	struct device *dev;
>  	struct regmap *regmap;
> +	struct mutex lock;	/* Lock to avoid race from ISR */
> +	ktime_t last_short_event;
>  	u16 ctrl_addr;
>  	u16 sink_addr;
>  	u32 brightness;
>  	u32 max_brightness;
> +	u32 short_count;
>  	const int *version;
> +	int short_irq;
> +	bool force_mod_disable;

"bool disabled_by_short" would describe what's going on better.

>  
>  	struct wled_config cfg;
>  	int (*wled_set_brightness)(struct wled *wled, u16 brightness);
> @@ -192,6 +213,9 @@ static int wled_module_enable(struct wled *wled, int val)
>  {
>  	int rc;
>  
> +	if (wled->force_mod_disable)
> +		return 0;
> +

I don't fancy the idea of not telling user space that it's request to
turn on the backlight is ignored. Can we return some error here so that
it's possible for something to do something about this problem?

>  	rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
>  				WLED3_CTRL_REG_MOD_EN,
>  				WLED3_CTRL_REG_MOD_EN_MASK,
> @@ -248,12 +272,13 @@ static int wled_update_status(struct backlight_device *bl)
>  	    bl->props.state & BL_CORE_FBBLANK)
>  		brightness = 0;
>  
> +	mutex_lock(&wled->lock);
>  	if (brightness) {
>  		rc = wled->wled_set_brightness(wled, brightness);
>  		if (rc < 0) {
>  			dev_err(wled->dev, "wled failed to set brightness rc:%d\n",
>  				rc);
> -			return rc;
> +			goto unlock_mutex;
>  		}
>  
>  		rc = wled->wled_sync_toggle(wled);
> @@ -267,15 +292,60 @@ static int wled_update_status(struct backlight_device *bl)
>  		rc = wled_module_enable(wled, !!brightness);
>  		if (rc < 0) {
>  			dev_err(wled->dev, "wled enable failed rc:%d\n", rc);
> -			return rc;
> +			goto unlock_mutex;
>  		}
>  	}
>  
>  	wled->brightness = brightness;
>  
> +unlock_mutex:
> +	mutex_unlock(&wled->lock);
> +
>  	return rc;
>  }
>  
> +#define WLED_SHORT_DLY_MS			20
> +#define WLED_SHORT_CNT_MAX			5
> +#define WLED_SHORT_RESET_CNT_DLY_US	HZ

HZ is in the unit of jiffies, not micro seconds.

> +static irqreturn_t wled_short_irq_handler(int irq, void *_wled)
> +{
> +	struct wled *wled = _wled;
> +	int rc;
> +	s64 elapsed_time;
> +
> +	wled->short_count++;
> +	mutex_lock(&wled->lock);
> +	rc = wled_module_enable(wled, false);
> +	if (rc < 0) {
> +		dev_err(wled->dev, "wled disable failed rc:%d\n", rc);
> +		goto unlock_mutex;
> +	}
> +
> +	elapsed_time = ktime_us_delta(ktime_get(),
> +				      wled->last_short_event);
> +	if (elapsed_time > WLED_SHORT_RESET_CNT_DLY_US)
> +		wled->short_count = 0;
> +
> +	if (wled->short_count > WLED_SHORT_CNT_MAX) {
> +		dev_err(wled->dev, "Short trigged %d times, disabling WLED forever!\n",
> +			wled->short_count);
> +		wled->force_mod_disable = true;
> +		goto unlock_mutex;
> +	}
> +
> +	wled->last_short_event = ktime_get();
> +
> +	msleep(WLED_SHORT_DLY_MS);
> +	rc = wled_module_enable(wled, true);
> +	if (rc < 0)
> +		dev_err(wled->dev, "wled enable failed rc:%d\n", rc);
> +
> +unlock_mutex:
> +	mutex_unlock(&wled->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int wled3_setup(struct wled *wled)
>  {
>  	u16 addr;
> @@ -435,6 +505,21 @@ static int wled4_setup(struct wled *wled)
>  		return rc;
>  	}
>  
> +	if (wled->cfg.external_pfet) {
> +		/* Unlock the secure register access */
> +		rc = regmap_write(wled->regmap, wled->ctrl_addr +
> +				  WLED4_CTRL_REG_SEC_ACCESS,
> +				  WLED4_CTRL_REG_SEC_UNLOCK);
> +		if (rc < 0)
> +			return rc;
> +
> +		rc = regmap_write(wled->regmap,
> +				  wled->ctrl_addr + WLED4_CTRL_REG_TEST1,
> +				  WLED4_CTRL_REG_TEST1_EXT_FET_DTEST2);
> +		if (rc < 0)
> +			return rc;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -446,6 +531,7 @@ static int wled4_setup(struct wled *wled)
>  	.switch_freq = 11,
>  	.enabled_strings = 0xf,
>  	.cabc = false,
> +	.external_pfet = true,

You added the "qcom,external-pfet" boolean to dt, but this forces it to
always be set - i.e. this is either wrong or you can omit the new dt
property.

>  };
>  
>  static const u32 wled3_boost_i_limit_values[] = {
> @@ -628,6 +714,7 @@ static int wled_configure(struct wled *wled)
>  		{ "qcom,cs-out", &cfg->cs_out_en, },
>  		{ "qcom,ext-gen", &cfg->ext_gen, },
>  		{ "qcom,cabc", &cfg->cabc, },
> +		{ "qcom,external-pfet", &cfg->external_pfet, },
>  	};
>  
>  	prop_addr = of_get_address(dev->of_node, 0, NULL, NULL);
> @@ -701,6 +788,39 @@ static int wled_configure(struct wled *wled)
>  	return 0;
>  }
>  
> +static int wled_configure_short_irq(struct wled *wled,
> +				    struct platform_device *pdev)
> +{
> +	int rc = 0;
> +
> +	/* PM8941 doesn't have the short detection support */
> +	if (*wled->version == WLED_PM8941)
> +		return 0;

If you attempt to acquire the "short" irq first in this function you
don't need this check - as "short" won't exist on pm8941.

Otherwise, it would be better if you add a "bool has_short_detect" to
the wled struct and check that, rather than sprinkling version checks
throughout.


Or...is cfg->external_pfet already denoting this?

> +
> +	rc = regmap_update_bits(wled->regmap, wled->ctrl_addr +
> +				WLED4_CTRL_REG_SHORT_PROTECT,
> +				WLED4_CTRL_REG_SHORT_EN_MASK,
> +				WLED4_CTRL_REG_SHORT_EN_MASK);

Do you really want to enable the short protect thing before figuring out
if you have a "short" irq.

> +	if (rc < 0)
> +		return rc;
> +
> +	wled->short_irq = platform_get_irq_byname(pdev, "short");

short_irq isn't used outside this function, so preferably you turn it
into a local variable.

> +	if (wled->short_irq < 0) {
> +		dev_dbg(&pdev->dev, "short irq is not used\n");
> +		return 0;
> +	}
> +
> +	rc = devm_request_threaded_irq(wled->dev, wled->short_irq,
> +				       NULL, wled_short_irq_handler,
> +				       IRQF_ONESHOT,
> +				       "wled_short_irq", wled);
> +	if (rc < 0)
> +		dev_err(wled->dev, "Unable to request short_irq (err:%d)\n",
> +			rc);
> +
> +	return rc;
> +}
> +
>  static const struct backlight_ops wled_ops = {
>  	.update_status = wled_update_status,
>  };
> @@ -733,6 +853,8 @@ static int wled_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> +	mutex_init(&wled->lock);
> +
>  	rc = wled_configure(wled);
>  	if (rc)
>  		return rc;
> @@ -752,6 +874,10 @@ static int wled_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	rc = wled_configure_short_irq(wled, pdev);
> +	if (rc < 0)
> +		return rc;
> +
>  	val = WLED_DEFAULT_BRIGHTNESS;
>  	of_property_read_u32(pdev->dev.of_node, "default-brightness", &val);

Regards,
Bjorn
