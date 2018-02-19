Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519063925; cv=none;
        d=google.com; s=arc-20160816;
        b=ZSJkOWhA5/g70PqrvsIotKuxrYXYgGThheo/nq0H01pDNn8v0c8FOKUAVcMi2hIU8g
         2QJK3nRKxlOjHEy8uLwyBDyKas16yKjG7KTMhfTPBFhUH4nPno63LNs0IC82OGVZQEGD
         QpXnUsyJXDm52kdiiX/wh1OADGMKcK3w+FQ1ua89+jkMPeBlTehg4xj37QJpCOWHrrkC
         OawK864xHFvTalCiMjDjkjOCUBvJGePn8bo+KZDFd5tVAdsDDTMIVLCJO74JzcTcGSuR
         r00oBleC5h8JzRd+vtqI72K5ca8gnC7iI0Picjdfyb8xOVI6Hc1jlVnC5RJbz2qrOw61
         5erg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=BgwuyqUh2PTb9rEqfI8XBvsB/UDFahUgnOfcGv/cjlo=;
        b=iSW1ueHOSwTJ0YNj/ipInKAN/suVY6izZM0LlgXZ/ZZ+T4aBq9Goc92aUv6ip+TeG1
         S4q7Z3TLFFLSzpF/rbQO6XxdmLXekHiFofeZdsqt6c4jRdlrF+dex9wqdxik3DSCOxlV
         E/93LxW1ib79pMGSkOoY/zTLSXjuoWz1oNSoaXn7j0rVTcrynVRpa8cwDJzS98tcBc1k
         Ee6bCMi64vdMHCVX6v+akbz/dnchxTFnWmnIBA64cvXMPrjjhijQISkrHk/sNyTP4/eF
         mhAEvix1QapV6/4GhIYDCcrxI2amPCWN2e6ljdO3VWn08uJLJJLZd6JbFSXOua5S3S3a
         x1Lg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AH8x2271pEGAd38RDdwxRtYWOCU1uCv+FUc6aGy1FJZkNuZocgV3rHtB3BKcYvmhtfZh7xRg8cexCg==
Date: Mon, 19 Feb 2018 12:11:59 -0600
From: Rob Herring <robh@kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: dmitry.torokhov@gmail.com, mark.rutland@arm.com,
	gregkh@linuxfoundation.org, lumotuwe@gmail.com,
	arvind.yadav.cs@gmail.com, josephl@nvidia.com,
	kstewart@linuxfoundation.org, pombredanne@nexb.com,
	tglx@linutronix.de, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	broonie@kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH v2] Input: gpio_keys: Add level trigger support for GPIO
 keys
Message-ID: <20180219181159.tzbhhvbvpc236qma@rob-hp-laptop>
References: <7fc26df245d56fd2014532b56e67630e76e2c513.1518316248.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fc26df245d56fd2014532b56e67630e76e2c513.1518316248.git.baolin.wang@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591902511604872416?=
X-GMAIL-MSGID: =?utf-8?q?1592853974117125449?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 02:55:04PM +0800, Baolin Wang wrote:
> On some platforms (such as Spreadtrum platform), the GPIO keys can only
> be triggered by level type. So this patch introduces one property to
> indicate if the GPIO trigger type is level trigger or edge trigger.

If the parent interrupt controller only supports a certain trigger, then 
it should ignore setting the trigger type.

> 
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes since v1:
>  - Diable the GPIO irq until reversing the GPIO level type.
> ---
>  .../devicetree/bindings/input/gpio-keys.txt        |    2 ++
>  drivers/input/keyboard/gpio_keys.c                 |   26 +++++++++++++++++++-
>  include/linux/gpio_keys.h                          |    1 +
>  3 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
> index a949404..e3104bd 100644
> --- a/Documentation/devicetree/bindings/input/gpio-keys.txt
> +++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
> @@ -29,6 +29,8 @@ Optional subnode-properties:
>  	- linux,can-disable: Boolean, indicates that button is connected
>  	  to dedicated (not shared) interrupt which can be disabled to
>  	  suppress events from the button.
> +	- gpio-key,level-trigger: Boolean, indicates that button's interrupt
> +	  type is level trigger. Otherwise it is edge trigger as default.

No. Just use 'interrupts' instead of 'gpios' and specify the trigger 
type. Or put both if you need to read the state.

>  
>  Example nodes:
>  
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 87e613d..218698a 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -385,6 +385,20 @@ static void gpio_keys_gpio_work_func(struct work_struct *work)
>  	struct gpio_button_data *bdata =
>  		container_of(work, struct gpio_button_data, work.work);
>  
> +	if (bdata->button->level_trigger) {
> +		unsigned int trigger =
> +			irq_get_trigger_type(bdata->irq) & ~IRQF_TRIGGER_MASK;
> +		int state = gpiod_get_raw_value_cansleep(bdata->gpiod);
> +
> +		if (state)
> +			trigger |= IRQF_TRIGGER_LOW;
> +		else
> +			trigger |= IRQF_TRIGGER_HIGH;
> +
> +		irq_set_irq_type(bdata->irq, trigger);
> +		enable_irq(bdata->irq);
> +	}
> +
>  	gpio_keys_gpio_report_event(bdata);
>  
>  	if (bdata->button->wakeup)
> @@ -397,6 +411,9 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
>  
>  	BUG_ON(irq != bdata->irq);
>  
> +	if (bdata->button->level_trigger)
> +		disable_irq_nosync(bdata->irq);
> +
>  	if (bdata->button->wakeup) {
>  		const struct gpio_keys_button *button = bdata->button;
>  
> @@ -566,7 +583,11 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>  		INIT_DELAYED_WORK(&bdata->work, gpio_keys_gpio_work_func);
>  
>  		isr = gpio_keys_gpio_isr;
> -		irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
> +		if (button->level_trigger)
> +			irqflags = gpiod_is_active_low(bdata->gpiod) ?
> +				IRQF_TRIGGER_LOW : IRQF_TRIGGER_HIGH;
> +		else
> +			irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
>  
>  	} else {
>  		if (!button->irq) {
> @@ -721,6 +742,9 @@ static void gpio_keys_close(struct input_dev *input)
>  		button->can_disable =
>  			fwnode_property_read_bool(child, "linux,can-disable");
>  
> +		button->level_trigger =
> +			fwnode_property_read_bool(child, "gpio-key,level-trigger");
> +
>  		if (fwnode_property_read_u32(child, "debounce-interval",
>  					 &button->debounce_interval))
>  			button->debounce_interval = 5;
> diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
> index d06bf77..5095645 100644
> --- a/include/linux/gpio_keys.h
> +++ b/include/linux/gpio_keys.h
> @@ -28,6 +28,7 @@ struct gpio_keys_button {
>  	int wakeup;
>  	int debounce_interval;
>  	bool can_disable;
> +	bool level_trigger;
>  	int value;
>  	unsigned int irq;
>  };
> -- 
> 1.7.9.5
> 
