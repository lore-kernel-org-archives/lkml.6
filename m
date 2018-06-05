Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeFEBc6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 21:32:58 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38334 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751170AbeFEBc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 21:32:56 -0400
X-Google-Smtp-Source: ADUXVKKlVZ0F19cDAoatjbQuebeR7XwNyNrgFnaKCPoBUo/iwHemWS2/kYmN2T1ttpp8hDmLOJfGwQ==
Date: Mon, 4 Jun 2018 18:32:52 -0700
From: Brian Norris <briannorris@chromium.org>
To: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Cc: dmitry.torokhov@gmail.com, lee.jones@linaro.org,
        ravisadineni@google.com, dtor@google.com, tbroch@google.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        rajatja@google.com, bleung@google.com
Subject: Re: [PATCH V2] cros_ec_keyb: Mark cros_ec_keyb driver as wake
 enabled device.
Message-ID: <20180605013250.GA41281@rodete-desktop-imager.corp.google.com>
References: <20180524234213.GE177107@dtor-ws>
 <20180526011440.102417-1-ravisadineni@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180526011440.102417-1-ravisadineni@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 25, 2018 at 06:14:40PM -0700, Ravi Chandra Sadineni wrote:
> Mark cros_ec_keyb has wake enabled by default. If we see a MKBP event
> related to keyboard,  call pm_wakeup_event() to make sure wakeup
> triggers are accounted to keyb during suspend resume path.
> 
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> ---
> V2: Marked the ckdev as wake enabled instead of input devices.

I'm not sure I saw v1? But FYI, if you're not marking the input devices
as wake-enabled, then you only have one knob for disabling wakeup on the
buttons and switches (e.g., power button) vs. the keyboard. I know you
were previously concerned about this, but given that the EC itself
usually has full knowledge of these situations (e.g., it knows to
disable keyboard wakeup when a convertible is in a tablet orientation,
but leave power-button wakeup enabled), this may not be a problem.

Anyway, just wanted to highlight that part.

>  drivers/input/keyboard/cros_ec_keyb.c | 21 +++++++++++++++++----
>  drivers/mfd/cros_ec.c                 | 19 +++++++------------
>  2 files changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index 79eb29550c348..a7c96f0317123 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -245,12 +245,17 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
>  	switch (ckdev->ec->event_data.event_type) {
>  	case EC_MKBP_EVENT_KEY_MATRIX:
>  		/*
> -		 * If EC is not the wake source, discard key state changes
> +		 * If Keyb is not wake enabled, discard key state changes

We can use the full word; text is cheap:

s/Keyb/keyboard/

>  		 * during suspend.
>  		 */
> -		if (queued_during_suspend)
> +		if (queued_during_suspend
> +		    && !device_may_wakeup(ckdev->dev))
>  			return NOTIFY_OK;
>  
> +		if (device_may_wakeup(ckdev->dev))
> +			pm_wakeup_event(ckdev->dev, 0);
> +
> +

I don't think you need two blank lines here. One is enough.

>  		if (ckdev->ec->event_size != ckdev->cols) {
>  			dev_err(ckdev->dev,
>  				"Discarded incomplete key matrix event.\n");
> @@ -265,18 +270,25 @@ static int cros_ec_keyb_work(struct notifier_block *nb,
>  		val = get_unaligned_le32(&ckdev->ec->event_data.data.sysrq);
>  		dev_dbg(ckdev->dev, "sysrq code from EC: %#x\n", val);
>  		handle_sysrq(val);
> +
> +		if (device_may_wakeup(ckdev->dev))
> +			pm_wakeup_event(ckdev->dev, 0);
>  		break;
>  
>  	case EC_MKBP_EVENT_BUTTON:
>  	case EC_MKBP_EVENT_SWITCH:
>  		/*
> -		 * If EC is not the wake source, discard key state
> +		 * If keyb is not wake enabled, discard key state

s/keyb/keyboard/

Or, since this is talking about buttons and switches (which don't
technically require the "keyboard" part of this driver), you might just
leave that off ("If not wake enabled...").

Otherwise, I believe this looks good, though I may have overlooked
something:

Reviewed-by: Brian Norris <briannorris@chromium.org>

And given Lee acked this, and it's mostly a keyboard change, it should
probably go through Dmitry? And I'd expect he'd be a better reviewer
than me anyway.

Brian

>  		 * changes during suspend. Switches will be re-checked in
>  		 * cros_ec_keyb_resume() to be sure nothing is lost.
>  		 */
> -		if (queued_during_suspend)
> +		if (queued_during_suspend
> +		    && !device_may_wakeup(ckdev->dev))
>  			return NOTIFY_OK;
>  
> +		if (device_may_wakeup(ckdev->dev))
> +			pm_wakeup_event(ckdev->dev, 0);
> +
>  		if (ckdev->ec->event_data.event_type == EC_MKBP_EVENT_BUTTON) {
>  			val = get_unaligned_le32(
>  					&ckdev->ec->event_data.data.buttons);
> @@ -639,6 +651,7 @@ static int cros_ec_keyb_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> +	device_init_wakeup(ckdev->dev, true);
>  	return 0;
>  }
>  
> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> index d61024141e2b6..36156a41499c9 100644
> --- a/drivers/mfd/cros_ec.c
> +++ b/drivers/mfd/cros_ec.c
> @@ -229,7 +229,7 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
>  }
>  EXPORT_SYMBOL(cros_ec_suspend);
>  
> -static void cros_ec_drain_events(struct cros_ec_device *ec_dev)
> +static void cros_ec_report_events_during_suspend(struct cros_ec_device *ec_dev)
>  {
>  	while (cros_ec_get_next_event(ec_dev, NULL) > 0)
>  		blocking_notifier_call_chain(&ec_dev->event_notifier,
> @@ -253,21 +253,16 @@ int cros_ec_resume(struct cros_ec_device *ec_dev)
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
> 2.17.0.921.gf22659ad46-goog
> 
