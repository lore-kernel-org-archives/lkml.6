Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeBHU5F (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:57:05 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36050 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeBHU5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:57:03 -0500
X-Google-Smtp-Source: AH8x227+nUsmgoPO2rGI3DOwxrWfCWwctrr+2L7WBYjmTaynAXSwFRxbB7poBjcI+G1EtLOhVbMO8Q==
Subject: Re: [PATCH] led: core: Fix race on software blink cancellation
To: linux-leds@vger.kernel.org
References: <1516223562-3837-1-git-send-email-jacek.anaszewski@gmail.com>
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz,
        craig.mcqueen@innerrange.com.au, Hans de Goede <hdegoede@redhat.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Matthieu CASTET <matthieu.castet@parrot.com>,
        Dan Murphy <dmurphy@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, Alan Mizrahi <alan@mizrahi.com.ve>,
        Vadim Pasternak <vadimp@mellanox.com>, David Lin <dtwlin@google.com>,
        Joel Stanley <joel@jms.id.au>,
        =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        Willy Tarreau <w@1wt.eu>, Andrew Jeffery <andrew@aj.id.au>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Colin King <colin.king@canonical.com>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <57a6d1f7-c1d0-3871-fed8-84d094dd079f@gmail.com>
Date: Thu, 8 Feb 2018 21:55:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1516223562-3837-1-git-send-email-jacek.anaszewski@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments? I'd like to have some acks before applying
this patch.

Adding more people showing recently interest in the LED subsystem
related development.

Thanks,
Jacek Anaszewski

On 01/17/2018 10:12 PM, Jacek Anaszewski wrote:
> Commit d23a22a74fde ("leds: delay led_set_brightness if stopping soft-blink")
> made a modifications to the LED core allowing for led_set_brightness() to be
> called from hard-irq context when soft blink is being handled in soft-irq.
> 
> Since that time LED core has undergone modifications related to addition of
> generic support for delegating brightness setting to a workqueue as well as
> subsequent fixes for blink setting use cases.
> 
> After that the LED core code became hard to maintain and analyze, especially
> due to the imposed hard-irq context compatibility. It also turned out that
> in some cases a LED remained off after executing following sequence of commands:
> 
> 1. echo timer > trigger
> 2. echo 0 > brightness
> 3. echo 100 > brightness
> 
> The reason was LED_BLINK_DISABLE operation delegated to a set_brightness_work,
> triggered in 2., which was handled after 3. took effect.
> 
> In order to serialize above operations and in the same time avoid
> code overcomplication the hard-irq context compatibility is being removed,
> which allows to use spin_lock_bh() for LED blink setting serialization.
> 
>>From now, if in hard-irq context, users need to delegate led_set_brightness()
> to a workqueue in the place of use.
> 
> Reported-by: Craig McQueen <craig.mcqueen@innerrange.com.au>
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> ---
> Craig,
> 
> It would be great if you could confirm if this fixes your use case.
> 
>  drivers/leds/led-core.c                  | 79 +++++++++++++++++++-------------
>  drivers/leds/trigger/ledtrig-activity.c  |  3 --
>  drivers/leds/trigger/ledtrig-heartbeat.c |  3 --
>  include/linux/leds.h                     |  5 +-
>  4 files changed, 49 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
> index ede4fa0..25d711b 100644
> --- a/drivers/leds/led-core.c
> +++ b/drivers/leds/led-core.c
> @@ -22,6 +22,9 @@
>  DECLARE_RWSEM(leds_list_lock);
>  EXPORT_SYMBOL_GPL(leds_list_lock);
>  
> +DEFINE_SPINLOCK(leds_soft_blink_lock);
> +EXPORT_SYMBOL_GPL(leds_soft_blink_lock);
> +
>  LIST_HEAD(leds_list);
>  EXPORT_SYMBOL_GPL(leds_list);
>  
> @@ -51,26 +54,31 @@ static void led_timer_function(struct timer_list *t)
>  	unsigned long brightness;
>  	unsigned long delay;
>  
> +	spin_lock_bh(&leds_soft_blink_lock);
> +
> +	/*
> +	 * Check if soft blinking wasn't disabled via led_set_brightness()
> +	 * in the meantime.
> +	 */
> +	if (!test_bit(LED_BLINK_SW, &led_cdev->work_flags))
> +		goto unlock;
> +
>  	if (!led_cdev->blink_delay_on || !led_cdev->blink_delay_off) {
>  		led_set_brightness_nosleep(led_cdev, LED_OFF);
>  		clear_bit(LED_BLINK_SW, &led_cdev->work_flags);
> -		return;
> +		goto unlock;
>  	}
>  
>  	if (test_and_clear_bit(LED_BLINK_ONESHOT_STOP,
>  			       &led_cdev->work_flags)) {
>  		clear_bit(LED_BLINK_SW, &led_cdev->work_flags);
> -		return;
> +		goto unlock;
>  	}
>  
>  	brightness = led_get_brightness(led_cdev);
>  	if (!brightness) {
>  		/* Time to switch the LED on. */
> -		if (test_and_clear_bit(LED_BLINK_BRIGHTNESS_CHANGE,
> -					&led_cdev->work_flags))
> -			brightness = led_cdev->new_blink_brightness;
> -		else
> -			brightness = led_cdev->blink_brightness;
> +		brightness = led_cdev->blink_brightness;
>  		delay = led_cdev->blink_delay_on;
>  	} else {
>  		/* Store the current brightness value to be able
> @@ -100,6 +108,9 @@ static void led_timer_function(struct timer_list *t)
>  	}
>  
>  	mod_timer(&led_cdev->blink_timer, jiffies + msecs_to_jiffies(delay));
> +
> +unlock:
> +	spin_unlock_bh(&leds_soft_blink_lock);
>  }
>  
>  static void set_brightness_delayed(struct work_struct *ws)
> @@ -108,11 +119,6 @@ static void set_brightness_delayed(struct work_struct *ws)
>  		container_of(ws, struct led_classdev, set_brightness_work);
>  	int ret = 0;
>  
> -	if (test_and_clear_bit(LED_BLINK_DISABLE, &led_cdev->work_flags)) {
> -		led_cdev->delayed_set_value = LED_OFF;
> -		led_stop_software_blink(led_cdev);
> -	}
> -
>  	ret = __led_set_brightness(led_cdev, led_cdev->delayed_set_value);
>  	if (ret == -ENOTSUPP)
>  		ret = __led_set_brightness_blocking(led_cdev,
> @@ -131,6 +137,8 @@ static void led_set_software_blink(struct led_classdev *led_cdev,
>  {
>  	int current_brightness;
>  
> +	spin_lock_bh(&leds_soft_blink_lock);
> +
>  	current_brightness = led_get_brightness(led_cdev);
>  	if (current_brightness)
>  		led_cdev->blink_brightness = current_brightness;
> @@ -143,18 +151,21 @@ static void led_set_software_blink(struct led_classdev *led_cdev,
>  	/* never on - just set to off */
>  	if (!delay_on) {
>  		led_set_brightness_nosleep(led_cdev, LED_OFF);
> -		return;
> +		goto unlock;
>  	}
>  
>  	/* never off - just set to brightness */
>  	if (!delay_off) {
>  		led_set_brightness_nosleep(led_cdev,
>  					   led_cdev->blink_brightness);
> -		return;
> +		goto unlock;
>  	}
>  
>  	set_bit(LED_BLINK_SW, &led_cdev->work_flags);
>  	mod_timer(&led_cdev->blink_timer, jiffies + 1);
> +
> +unlock:
> +	spin_unlock_bh(&leds_soft_blink_lock);
>  }
>  
>  
> @@ -217,40 +228,46 @@ void led_blink_set_oneshot(struct led_classdev *led_cdev,
>  }
>  EXPORT_SYMBOL_GPL(led_blink_set_oneshot);
>  
> -void led_stop_software_blink(struct led_classdev *led_cdev)
> +void led_stop_software_blink_nolock(struct led_classdev *led_cdev)
>  {
> -	del_timer_sync(&led_cdev->blink_timer);
>  	led_cdev->blink_delay_on = 0;
>  	led_cdev->blink_delay_off = 0;
>  	clear_bit(LED_BLINK_SW, &led_cdev->work_flags);
>  }
> +
> +void led_stop_software_blink(struct led_classdev *led_cdev)
> +{
> +	spin_lock_bh(&leds_soft_blink_lock);
> +	led_stop_software_blink_nolock(led_cdev);
> +	spin_unlock_bh(&leds_soft_blink_lock);
> +}
>  EXPORT_SYMBOL_GPL(led_stop_software_blink);
>  
>  void led_set_brightness(struct led_classdev *led_cdev,
>  			enum led_brightness brightness)
>  {
> -	/*
> -	 * If software blink is active, delay brightness setting
> -	 * until the next timer tick.
> -	 */
> +	if (in_irq()) {
> +		dev_err(led_cdev->dev,
> +			"Cannot set LED brightness from hard irq context!");
> +		WARN_ON(1);
> +		return;
> +	}
> +
> +	spin_lock_bh(&leds_soft_blink_lock);
> +
>  	if (test_bit(LED_BLINK_SW, &led_cdev->work_flags)) {
> -		/*
> -		 * If we need to disable soft blinking delegate this to the
> -		 * work queue task to avoid problems in case we are called
> -		 * from hard irq context.
> -		 */
>  		if (brightness == LED_OFF) {
> -			set_bit(LED_BLINK_DISABLE, &led_cdev->work_flags);
> -			schedule_work(&led_cdev->set_brightness_work);
> +			led_stop_software_blink_nolock(led_cdev);
>  		} else {
> -			set_bit(LED_BLINK_BRIGHTNESS_CHANGE,
> -				&led_cdev->work_flags);
> -			led_cdev->new_blink_brightness = brightness;
> +			led_cdev->blink_brightness = brightness;
> +			goto unlock;
>  		}
> -		return;
>  	}
>  
>  	led_set_brightness_nosleep(led_cdev, brightness);
> +
> +unlock:
> +	spin_unlock_bh(&leds_soft_blink_lock);
>  }
>  EXPORT_SYMBOL_GPL(led_set_brightness);
>  
> diff --git a/drivers/leds/trigger/ledtrig-activity.c b/drivers/leds/trigger/ledtrig-activity.c
> index 5081894..6f62da7 100644
> --- a/drivers/leds/trigger/ledtrig-activity.c
> +++ b/drivers/leds/trigger/ledtrig-activity.c
> @@ -48,9 +48,6 @@ static void led_activity_function(struct timer_list *t)
>  	int cpus;
>  	int i;
>  
> -	if (test_and_clear_bit(LED_BLINK_BRIGHTNESS_CHANGE, &led_cdev->work_flags))
> -		led_cdev->blink_brightness = led_cdev->new_blink_brightness;
> -
>  	if (unlikely(panic_detected)) {
>  		/* full brightness in case of panic */
>  		led_set_brightness_nosleep(led_cdev, led_cdev->blink_brightness);
> diff --git a/drivers/leds/trigger/ledtrig-heartbeat.c b/drivers/leds/trigger/ledtrig-heartbeat.c
> index f0896de..1453352 100644
> --- a/drivers/leds/trigger/ledtrig-heartbeat.c
> +++ b/drivers/leds/trigger/ledtrig-heartbeat.c
> @@ -47,9 +47,6 @@ static void led_heartbeat_function(struct timer_list *t)
>  		return;
>  	}
>  
> -	if (test_and_clear_bit(LED_BLINK_BRIGHTNESS_CHANGE, &led_cdev->work_flags))
> -		led_cdev->blink_brightness = led_cdev->new_blink_brightness;
> -
>  	/* acts like an actual heart beat -- ie thump-thump-pause... */
>  	switch (heartbeat_data->phase) {
>  	case 0:
> diff --git a/include/linux/leds.h b/include/linux/leds.h
> index 5579c64..e520503 100644
> --- a/include/linux/leds.h
> +++ b/include/linux/leds.h
> @@ -51,15 +51,13 @@ struct led_classdev {
>  #define LED_BRIGHT_HW_CHANGED	BIT(21)
>  #define LED_RETAIN_AT_SHUTDOWN	BIT(22)
>  
> -	/* set_brightness_work / blink_timer flags, atomic, private. */
> +	/* blink_timer flags, atomic, private. */
>  	unsigned long		work_flags;
>  
>  #define LED_BLINK_SW			0
>  #define LED_BLINK_ONESHOT		1
>  #define LED_BLINK_ONESHOT_STOP		2
>  #define LED_BLINK_INVERT		3
> -#define LED_BLINK_BRIGHTNESS_CHANGE 	4
> -#define LED_BLINK_DISABLE		5
>  
>  	/* Set LED brightness level
>  	 * Must not sleep. Use brightness_set_blocking for drivers
> @@ -97,7 +95,6 @@ struct led_classdev {
>  	unsigned long		 blink_delay_on, blink_delay_off;
>  	struct timer_list	 blink_timer;
>  	int			 blink_brightness;
> -	int			 new_blink_brightness;
>  	void			(*flash_resume)(struct led_classdev *led_cdev);
>  
>  	struct work_struct	set_brightness_work;
> 
