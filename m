Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753101AbeBCTfQ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 14:35:16 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38626 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752628AbeBCTfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 14:35:09 -0500
X-Google-Smtp-Source: AH8x227krcRLxq69PzTp2BkDA/HDT0V1yUKSpmaSjywp8vqXvthHBbQ7i7WgGApXD3j5nk1S/M3Nxg==
Date: Sat, 3 Feb 2018 11:35:04 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Zhang Bo <zbsdta@126.com>
Cc: robh@kernel.org, DRivshin@allworx.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhang.bo19@zte.com.cn,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v2] Input: matrix_keypad - fix keypad does not response
Message-ID: <20180203193504.pnn7qx6zymu5qk5n@dtor-ws>
References: <20180203155816.18221-1-zbsdta@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180203155816.18221-1-zbsdta@126.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhang,

On Sat, Feb 03, 2018 at 11:58:16PM +0800, Zhang Bo wrote:
> If matrix_keypad_stop() is calling and the keypad interrupt is triggered,
> disable_row_irqs() is called by both matrix_keypad_interrupt() and
> matrix_keypad_stop() at the same time. then disable_row_irqs() is called
> twice, and the device enter suspend state before keypad->work is executed.
> At this condition the device will start keypad and enable irq once after
> resume. and then irqs are disabled yet because irqs are disabled twice and
> only enable once.
> 
> Take lock around keypad->stopped and queue delayed work in
> matrix_keypad_start() and matrix_keypad_stop() to ensure irqs operation and
> scheduling scan work are in atomic operation.
> 
> Signed-off-by: Zhang Bo <zbsdta@126.com>
> ---
> Changes in v2:
>   - Change commit message and full name in the signed-off-by tag.
> 
>  drivers/input/keyboard/matrix_keypad.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
> index 1f316d66e6f7..13fe51824637 100644
> --- a/drivers/input/keyboard/matrix_keypad.c
> +++ b/drivers/input/keyboard/matrix_keypad.c
> @@ -169,7 +169,8 @@ static void matrix_keypad_scan(struct work_struct *work)
>  	/* Enable IRQs again */
>  	spin_lock_irq(&keypad->lock);
>  	keypad->scan_pending = false;
> -	enable_row_irqs(keypad);
> +	if (keypad->stopped == false)
> +		enable_row_irqs(keypad);
>  	spin_unlock_irq(&keypad->lock);
>  }
>  
> @@ -202,14 +203,16 @@ static int matrix_keypad_start(struct input_dev *dev)
>  {
>  	struct matrix_keypad *keypad = input_get_drvdata(dev);
>  
> +	spin_lock_irq(&keypad->lock);
>  	keypad->stopped = false;
> -	mb();
>  
>  	/*
>  	 * Schedule an immediate key scan to capture current key state;
>  	 * columns will be activated and IRQs be enabled after the scan.
>  	 */
> -	schedule_delayed_work(&keypad->work, 0);
> +	if (keypad->scan_pending == false)

How can we have the pending scan if the keypad was disabled.

> +		schedule_delayed_work(&keypad->work, 0);
> +	spin_unlock_irq(&keypad->lock);

I do not think the change to matrix_keypad_start() is needed. If device
is quiesced we do not have issue of ISR racing with us here.

>  
>  	return 0;
>  }
> @@ -218,14 +221,17 @@ static void matrix_keypad_stop(struct input_dev *dev)
>  {
>  	struct matrix_keypad *keypad = input_get_drvdata(dev);
>  
> +	spin_lock_irq(&keypad->lock);
>  	keypad->stopped = true;
> -	mb();
> -	flush_work(&keypad->work.work);
>  	/*
>  	 * matrix_keypad_scan() will leave IRQs enabled;
>  	 * we should disable them now.
>  	 */
> -	disable_row_irqs(keypad);
> +	if (keypad->scan_pending == false)
> +		disable_row_irqs(keypad);
> +	spin_unlock_irq(&keypad->lock);
> +
> +	flush_work(&keypad->work.work);

This is wrong, you should not have moved the flush_work() here. The
logic is as follows:

- set the "stopped" flag
- ensure that ISR has completed
- ensure that work item has finished (by doing flush_work()) - this will
  make sure that interrupts are enabled (either ISR noticed "stopped
  flag" and did not touch them, or ISR scheduled work and work item
  re-enabled them)
- finally disable IRQs

Your change breaks this.

As far as I can see, the only change that is needed is this at the
beginning of matrix_keypad_stop():

	spin_lock_irq(&keypad->lock);
	keypad->stopped = true;
	spin_unlock_irq(&keypad->lock);

Thanks.

-- 
Dmitry
