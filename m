Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752240AbeBCX5d (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 18:57:33 -0500
Received: from m50-112.126.com ([123.125.50.112]:52795 "EHLO m50-112.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750905AbeBCX50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 18:57:26 -0500
Message-ID: <1517702239.2189.20.camel@126.com>
Subject: Re: [PATCH v2] Input: matrix_keypad - fix keypad does not response
From: Zhang Bo <zbsdta@126.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: robh@kernel.org, DRivshin@allworx.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhang.bo19@zte.com.cn,
        andy.shevchenko@gmail.com
Date: Sun, 04 Feb 2018 07:57:19 +0800
In-Reply-To: <20180203193504.pnn7qx6zymu5qk5n@dtor-ws>
References: <20180203155816.18221-1-zbsdta@126.com>
         <20180203193504.pnn7qx6zymu5qk5n@dtor-ws>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: j9KowAAnkTRfTHZa1eKvAA--.5842S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGryDuw1kWF13CFy5WF4xXrb_yoWrXr4rpr
        WrJ3Wqkr4UGw109wsFqrs29asYkw4vqry2grn5X348t3s0vr17Grn3K3ySga4DAr4Iyanr
        Zr4kZrZ8JryqyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnEfOUUUUU=
X-Originating-IP: [123.139.75.126]
X-CM-SenderInfo: h2evv3bd6rjloofrz/1tbiThbhSVpD4gFwEwAAsp
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-02-03 at 11:35 -0800, Dmitry Torokhov wrote:
Hi Dmitry Torokhov
> > If matrix_keypad_stop() is calling and the keypad interrupt is
> > triggered,
> > disable_row_irqs() is called by both matrix_keypad_interrupt() and
> > matrix_keypad_stop() at the same time. then disable_row_irqs() is
> > called
> > twice, and the device enter suspend state before keypad->work is
> > executed.
> > At this condition the device will start keypad and enable irq once
> > after
> > resume. and then irqs are disabled yet because irqs are disabled
> > twice and
> > only enable once.
> > 
> > Take lock around keypad->stopped and queue delayed work in
> > matrix_keypad_start() and matrix_keypad_stop() to ensure irqs
> > operation and
> > scheduling scan work are in atomic operation.
> > 
> > Signed-off-by: Zhang Bo <zbsdta@126.com>
> > ---
> > Changes in v2:
> >   - Change commit message and full name in the signed-off-by tag.
> > 
> >  drivers/input/keyboard/matrix_keypad.c | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/input/keyboard/matrix_keypad.c
> > b/drivers/input/keyboard/matrix_keypad.c
> > index 1f316d66e6f7..13fe51824637 100644
> > --- a/drivers/input/keyboard/matrix_keypad.c
> > +++ b/drivers/input/keyboard/matrix_keypad.c
> > @@ -169,7 +169,8 @@ static void matrix_keypad_scan(struct
> > work_struct *work)
> >  	/* Enable IRQs again */
> >  	spin_lock_irq(&keypad->lock);
> >  	keypad->scan_pending = false;
> > -	enable_row_irqs(keypad);
> > +	if (keypad->stopped == false)
> > +		enable_row_irqs(keypad);
> >  	spin_unlock_irq(&keypad->lock);
> >  }
> >  
> > @@ -202,14 +203,16 @@ static int matrix_keypad_start(struct
> > input_dev *dev)
> >  {
> >  	struct matrix_keypad *keypad = input_get_drvdata(dev);
> >  
> > +	spin_lock_irq(&keypad->lock);
> >  	keypad->stopped = false;
> > -	mb();
> >  
> >  	/*
> >  	 * Schedule an immediate key scan to capture current key
> > state;
> >  	 * columns will be activated and IRQs be enabled after the
> > scan.
> >  	 */
> > -	schedule_delayed_work(&keypad->work, 0);
> > +	if (keypad->scan_pending == false)
> 
> How can we have the pending scan if the keypad was disabled.
> 
> > +		schedule_delayed_work(&keypad->work, 0);
> > +	spin_unlock_irq(&keypad->lock);
> 
> I do not think the change to matrix_keypad_start() is needed. If
> device
> is quiesced we do not have issue of ISR racing with us here.
> 
you are right, irqs are disabled and worker is finished in
matrix_keypad_stop(), so
there is no pending scaning and the if condition here and lock are not
needed.
> >  
> >  	return 0;
> >  }
> > @@ -218,14 +221,17 @@ static void matrix_keypad_stop(struct
> > input_dev *dev)
> >  {
> >  	struct matrix_keypad *keypad = input_get_drvdata(dev);
> >  
> > +	spin_lock_irq(&keypad->lock);
> >  	keypad->stopped = true;
> > -	mb();
> > -	flush_work(&keypad->work.work);
> >  	/*
> >  	 * matrix_keypad_scan() will leave IRQs enabled;
> >  	 * we should disable them now.
> >  	 */
> > -	disable_row_irqs(keypad);
> > +	if (keypad->scan_pending == false)
> > +		disable_row_irqs(keypad);
> > +	spin_unlock_irq(&keypad->lock);
> > +
> > +	flush_work(&keypad->work.work);
> 
> This is wrong, you should not have moved the flush_work() here. The
> logic is as follows:
> 
> - set the "stopped" flag
> - ensure that ISR has completed
> - ensure that work item has finished (by doing flush_work()) - this
> will
>   make sure that interrupts are enabled (either ISR noticed "stopped
>   flag" and did not touch them, or ISR scheduled work and work item
>   re-enabled them)
> - finally disable IRQs
> 
> Your change breaks this.
> 
> As far as I can see, the only change that is needed is this at the
> beginning of matrix_keypad_stop():
> 
> 	spin_lock_irq(&keypad->lock);
> 	keypad->stopped = true;
> 	spin_unlock_irq(&keypad->lock);
> 
> Thanks.
> 
yes, only protecting keypad->stopped ensures irqs are disabled only
once.
