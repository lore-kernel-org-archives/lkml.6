Return-Path: <dmitry.torokhov@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520296213; cv=none;
        d=google.com; s=arc-20160816;
        b=dC+p01WOpCPY0+2WLS+5AN1fIguC4aiqA09RH8eEl/wKxQcHt3rvEb5dil1/7/Llv7
         Hb2K1S199TVUFLGSmQhNjvzfqdKnAmRpG9f8tKk29E/xkh/U39ge8aSvYNpToME7aqMi
         G0IB6bLm8z4oD9TsHyM/NsOoRAssnOdP+L4CI5ynPWoFni01ehSRJhF4b0YBqHg9lA0Q
         R9yfR1qyscEhjFqQroYfdaI8S/ihLiKzLsa8mrFeXX9+cqn/6DIHCxq1U3EapduaxgP/
         jdEmDvx4gb3dVaAVs3QUIdsZM1NwtdbxDaqBdM1Qzw+vgT9lz0QPuk6m+O0fgP48lraD
         smNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Kz9hzpXV/ifSiq7h/h8gEs0hBmA9PqGiBEd3HEfkadg=;
        b=wHMWWzHn6aZNQoR8FmhvF6AMTC6hjiql9qA/Nyi7lpyIhW/N75nrgriwQvNA3m2Twn
         dd93ENebLzhK0HJhr7P0Fl4Y+CXlNKviBIJFoANxhTXwfOotGFl030Kmid6MsEblv5sC
         WZHE1bX1NitYpEKgMeo7jF03NMafdDcgp6Hc+n9d+Yz0/reV1seSZmeM1pvyv+Q40u3q
         H59QOjDbDd1EFLDD01P7tbosS5wiW/odqaEtABd/QHWUpNYLQgl1zwADZAC4YeCa+IT7
         0YHROPprM25qi+RGodQqmrsHuN7uMXUJw7WoVJJ+oI9Vz2d7b9GHAU+tQJ1laEbwuhOb
         D15g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=p3YUpIxL;
       spf=pass (google.com: domain of dmitry.torokhov@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dmitry.torokhov@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=p3YUpIxL;
       spf=pass (google.com: domain of dmitry.torokhov@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=dmitry.torokhov@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsAy+Bv33rsbrYX74km3iq8FuGNaFLzvzGT7TGa4PAHwkIcKQMtNFNHkQpfSeWlByiZKrSFmA==
Date: Mon, 5 Mar 2018 16:30:09 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, briannorris@google.com, heiko@sntech.de,
	dtor@google.com, dianders@google.com,
	Guenter Roeck <linux@roeck-us.net>,
	Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joseph Lo <josephl@nvidia.com>, stephen lu <lumotuwe@gmail.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-input@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH v3 1/3] Input: gpio-keys - add support for wakeup event
 action
Message-ID: <20180306003009.GA2205@dtor-ws>
References: <20180302035102.10084-1-jeffy.chen@rock-chips.com>
 <20180302035102.10084-2-jeffy.chen@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302035102.10084-2-jeffy.chen@rock-chips.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593796398351218110?=
X-GMAIL-MSGID: =?utf-8?q?1594146122332330249?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jeffy,

On Fri, Mar 02, 2018 at 11:51:00AM +0800, Jeffy Chen wrote:
> Add support for specifying event actions to trigger wakeup when using
> the gpio-keys input device as a wakeup source.
> 
> This would allow the device to configure when to wakeup the system. For
> example a gpio-keys input device for pen insert, may only want to wakeup
> the system when ejecting the pen.
> 
> Suggested-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v3:
> Adding more comments as Brian suggested.
> 
> Changes in v2:
> Specify wakeup event action instead of irq trigger type as Brian
> suggested.
> 
>  drivers/input/keyboard/gpio_keys.c     | 39 ++++++++++++++++++++++++++++++++++
>  include/linux/gpio_keys.h              |  2 ++
>  include/uapi/linux/input-event-codes.h |  9 ++++++++
>  3 files changed, 50 insertions(+)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 87e613dc33b8..607f3960c886 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -45,6 +45,8 @@ struct gpio_button_data {
>  	unsigned int software_debounce;	/* in msecs, for GPIO-driven buttons */
>  
>  	unsigned int irq;
> +	unsigned int irq_trigger_type;
> +	unsigned int wakeup_trigger_type;
>  	spinlock_t lock;
>  	bool disabled;
>  	bool key_pressed;
> @@ -540,6 +542,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>  	}
>  
>  	if (bdata->gpiod) {
> +		int active_low = gpiod_is_active_low(bdata->gpiod);
> +
>  		if (button->debounce_interval) {
>  			error = gpiod_set_debounce(bdata->gpiod,
>  					button->debounce_interval * 1000);
> @@ -568,6 +572,22 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>  		isr = gpio_keys_gpio_isr;
>  		irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
>  
> +		switch (button->wakeup_event_action) {
> +		case EV_ACT_ASSERTED:
> +			bdata->wakeup_trigger_type = active_low ?
> +				IRQF_TRIGGER_FALLING : IRQF_TRIGGER_RISING;

				IRQ_TYPE_EDGE_FALLING : IRQ_TYPE_EDGE_RISING;

> +			break;
> +		case EV_ACT_DEASSERTED:
> +			bdata->wakeup_trigger_type = active_low ?
> +				IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
> +			break;

		case EV_ACT_ANY:
> +		default:
> +			/*
> +			 * For other cases, we are OK letting suspend/resume
> +			 * not reconfigure the trigger type.
> +			 */
> +			break;
> +		}
>  	} else {
>  		if (!button->irq) {
>  			dev_err(dev, "Found button without gpio or irq\n");
> @@ -586,6 +606,12 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>  
>  		isr = gpio_keys_irq_isr;
>  		irqflags = 0;
> +
> +		/*
> +		 * For IRQ buttons, the irq trigger type for press and release
> +		 * are the same. So we don't need to reconfigure the trigger
> +		 * type for wakeup.

That is not entirely accurate. Interrupt triggers button press, which is
followed by either immediate or delayed release. There is no interrupt
for release.

> +		 */
>  	}
>  
>  	bdata->code = &ddata->keymap[idx];
> @@ -618,6 +644,8 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>  		return error;
>  	}
>  
> +	bdata->irq_trigger_type = irq_get_trigger_type(bdata->irq);

Why do we need to store the trigger type? It is always both edges for
gpio-based keys and we do not support changing wakeup trigger for
interrupt-based keys.

> +
>  	return 0;
>  }
>  
> @@ -718,6 +746,9 @@ gpio_keys_get_devtree_pdata(struct device *dev)
>  			/* legacy name */
>  			fwnode_property_read_bool(child, "gpio-key,wakeup");
>  
> +		fwnode_property_read_u32(child, "wakeup-event-action",
> +					 &button->wakeup_event_action);
> +
>  		button->can_disable =
>  			fwnode_property_read_bool(child, "linux,can-disable");
>  
> @@ -854,6 +885,10 @@ static int __maybe_unused gpio_keys_suspend(struct device *dev)
>  	if (device_may_wakeup(dev)) {
>  		for (i = 0; i < ddata->pdata->nbuttons; i++) {
>  			struct gpio_button_data *bdata = &ddata->data[i];
> +
> +			if (bdata->button->wakeup && bdata->wakeup_trigger_type)
> +				irq_set_irq_type(bdata->irq,
> +						 bdata->wakeup_trigger_type);

			if (bdata->button->wakeup) {
				if (bdata->wakeup_trigger_type) {
					error = ...;
				}

				enable_irq_wake(bdata->irq);
			}

Might need to be split into a helper; if you add error handling to
enable_irq_wake() that woudl be great too.

>  			if (bdata->button->wakeup)
>  				enable_irq_wake(bdata->irq);
>  			bdata->suspended = true;
> @@ -878,6 +913,10 @@ static int __maybe_unused gpio_keys_resume(struct device *dev)
>  	if (device_may_wakeup(dev)) {
>  		for (i = 0; i < ddata->pdata->nbuttons; i++) {
>  			struct gpio_button_data *bdata = &ddata->data[i];
> +
> +			if (bdata->button->wakeup && bdata->wakeup_trigger_type)
> +				irq_set_irq_type(bdata->irq,
> +						 bdata->irq_trigger_type);

Just use IRQ_TYPE_EDGE_BOTH.

>  			if (bdata->button->wakeup)
>  				disable_irq_wake(bdata->irq);
>  			bdata->suspended = false;
> diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
> index d06bf77400f1..7160df54a6fe 100644
> --- a/include/linux/gpio_keys.h
> +++ b/include/linux/gpio_keys.h
> @@ -13,6 +13,7 @@ struct device;
>   * @desc:		label that will be attached to button's gpio
>   * @type:		input event type (%EV_KEY, %EV_SW, %EV_ABS)
>   * @wakeup:		configure the button as a wake-up source
> + * @wakeup_event_action:	event action to trigger wakeup
>   * @debounce_interval:	debounce ticks interval in msecs
>   * @can_disable:	%true indicates that userspace is allowed to
>   *			disable button via sysfs
> @@ -26,6 +27,7 @@ struct gpio_keys_button {
>  	const char *desc;
>  	unsigned int type;
>  	int wakeup;
> +	int wakeup_event_action;
>  	int debounce_interval;
>  	bool can_disable;
>  	int value;
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 53fbae27b280..d7917b0bd438 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -32,6 +32,15 @@
>  #define INPUT_PROP_CNT			(INPUT_PROP_MAX + 1)
>  
>  /*
> + * Event action types
> + */
> +#define EV_ACT_ANY			0x00	/* asserted or deasserted */
> +#define EV_ACT_ASSERTED			0x01	/* asserted */
> +#define EV_ACT_DEASSERTED		0x02	/* deasserted */

These do not belong here: they are of no interest to userspace but
simply a driver specific quirk. If you want to share symbolic names add
include/dt-bindings/input/gpio-keys.h


> +#define EV_ACT_MAX			0x02
> +#define EV_ACT_CNT			(EV_ACT_MAX+1)

These are not needed at all: you are not defining input bitmasks.

> +
> +/*
>   * Event types
>   */
>  
> -- 
> 2.11.0
> 
> 

Thanks.

-- 
Dmitry
