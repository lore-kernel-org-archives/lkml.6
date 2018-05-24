Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968822AbeEXXmV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 19:42:21 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37317 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964936AbeEXXmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 19:42:18 -0400
X-Google-Smtp-Source: AB8JxZr7OIfZy1vdNO8v485ikT5sTtAD8K2t8FkoIDONniLGsbsdx4uIsq9/UXtI4wACGuJT7nT7ew==
Date: Thu, 24 May 2018 16:42:13 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc: lee.jones@linaro.org, ravisadineni@google.com, dtor@google.com,
        tbroch@google.com, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, rajatja@google.com, bleung@google.com
Subject: Re: [PATCH] cros_ec_keyb: Increment the wakeup count to the specific
 mfd device.
Message-ID: <20180524234213.GE177107@dtor-ws>
References: <20180523182958.25195-1-ravisadineni@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523182958.25195-1-ravisadineni@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ravi,

On Wed, May 23, 2018 at 11:29:58AM -0700, Ravi Chandra Sadineni wrote:
> If the IRQ is processed during resume, increment the wakeup count to the
> specific mfd device based on the event, if the mfd device is wake enabled.
> This helps in identifying the specific device that caused the wake.
> 
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> ---
>  drivers/input/keyboard/cros_ec_keyb.c | 20 +++++++++++++++-----
>  drivers/mfd/cros_ec.c                 | 25 +++++++++++--------------
>  2 files changed, 26 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index 79eb29550c348..9b39289774405 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -245,12 +245,16 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
>  	switch (ckdev->ec->event_data.event_type) {
>  	case EC_MKBP_EVENT_KEY_MATRIX:
>  		/*
> -		 * If EC is not the wake source, discard key state changes
> -		 * during suspend.
> +		 * If keyb input device is not wake enabled, discard key
> +		 * state changes during suspend.
>  		 */
> -		if (queued_during_suspend)
> +		if (queued_during_suspend && ckdev->idev
> +		    && !device_may_wakeup(&ckdev->idev->dev))
>  			return NOTIFY_OK;
>  
> +		else if (queued_during_suspend && ckdev->idev)
> +			pm_wakeup_event(&ckdev->idev->dev, 0);

Are we reporting wakeup event on the right device? Normally we only
report wakeups on hardware device whereas here we using input devices
which are logical abstractions...

In any case this can be collapsed a bit:

		if (queued_during_suspend && ckdev->idev) {
			if (!device_may_wakeup(&ckdev->idev->dev)
				return NOTIFY_OK;

			pm_wakeup_event(&ckdev->idev->dev, 0);
		}

But I think you should actually look at ckdev->dev device here.

Also, why do we ignore EC_MKBP_EVENT_SYSRQ event?

> +
>  		if (ckdev->ec->event_size != ckdev->cols) {
>  			dev_err(ckdev->dev,
>  				"Discarded incomplete key matrix event.\n");
> @@ -270,13 +274,17 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
>  	case EC_MKBP_EVENT_BUTTON:
>  	case EC_MKBP_EVENT_SWITCH:
>  		/*
> -		 * If EC is not the wake source, discard key state
> +		 * If bs is not wake enabled, discard key state
>  		 * changes during suspend. Switches will be re-checked in
>  		 * cros_ec_keyb_resume() to be sure nothing is lost.
>  		 */
> -		if (queued_during_suspend)
> +		if (queued_during_suspend && ckdev->bs_idev
> +		    && !device_may_wakeup(&ckdev->bs_idev->dev))
>  			return NOTIFY_OK;
>  
> +		else if (queued_during_suspend && ckdev->bs_idev)
> +			pm_wakeup_event(&ckdev->bs_idev->dev, 0);
> +
>  		if (ckdev->ec->event_data.event_type == EC_MKBP_EVENT_BUTTON) {
>  			val = get_unaligned_le32(
>  					&ckdev->ec->event_data.data.buttons);
> @@ -522,6 +530,7 @@ static int cros_ec_keyb_register_bs(struct cros_ec_keyb *ckdev)
>  		return ret;
>  	}
>  
> +	device_init_wakeup(&idev->dev, true);
>  	return 0;
>  }
>  
> @@ -598,6 +607,7 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
>  		return err;
>  	}
>  
> +	device_init_wakeup(&idev->dev, true);
>  	return 0;
>  }
>  
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index d61024141e2b6..df9520365e54b 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -64,12 +64,14 @@ static irqreturn_t ec_irq_thread(int irq, void *data)
>  	 * cros_ec_get_next_event() returned an error (default value for
>  	 * wake_event is true)
>  	 */
> -	if (wake_event && device_may_wakeup(ec_dev->dev))
> +	if (device_may_wakeup(ec_dev->dev) && wake_event
> +	    && ec_dev->wake_enabled)
>  		pm_wakeup_event(ec_dev->dev, 0);
>  
>  	if (ret > 0)
>  		blocking_notifier_call_chain(&ec_dev->event_notifier,
> -					     0, ec_dev);
> +					     wake_event && ec_dev->wake_enabled,
> +					     ec_dev);
>  	return IRQ_HANDLED;
>  }
>  
> @@ -229,7 +231,7 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
>  }
>  EXPORT_SYMBOL(cros_ec_suspend);
>  
> -static void cros_ec_drain_events(struct cros_ec_device *ec_dev)
> +static void cros_ec_report_events_during_suspend(struct cros_ec_device *ec_dev)
>  {
>  	while (cros_ec_get_next_event(ec_dev, NULL) > 0)
>  		blocking_notifier_call_chain(&ec_dev->event_notifier,
> @@ -253,21 +255,16 @@ int cros_ec_resume(struct cros_ec_device *ec_dev)
>  		dev_dbg(ec_dev->dev, "Error %d sending resume event to ec",
>  			ret);
>  
> -	/*
> -	 * In some cases, we need to distinguish between events that occur
> -	 * during suspend if the EC is not a wake source. For example,
> -	 * keypresses during suspend should be discarded if it does not wake
> -	 * the system.
> -	 *
> -	 * If the EC is not a wake source, drain the event queue and mark them
> -	 * as "queued during suspend".
> -	 */
>  	if (ec_dev->wake_enabled) {
>  		disable_irq_wake(ec_dev->irq);
>  		ec_dev->wake_enabled = 0;
> -	} else {
> -		cros_ec_drain_events(ec_dev);
>  	}
> +	/*
> +	 * Let the mfd devices know about events that occur during
> +	 * suspend. This way the clients know what to do with them.
> +	 */
> +	cros_ec_report_events_during_suspend(ec_dev);
> +
>  
>  	return 0;
>  }
> -- 
> 2.17.0.441.gb46fe60e1d-goog
> 

-- 
Dmitry
