Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754674AbeBBUCQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:02:16 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44338 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752291AbeBBUCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:02:09 -0500
X-Google-Smtp-Source: AH8x224cIfNl8zVbuyTS99SBD+6wOz5oLPEdaiIsL6xbIFhhWhR0FtdhjlX+kSQfdPWaO9bKfeWZMA==
Date: Fri, 2 Feb 2018 12:02:04 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: =?utf-8?B?5byg5rOi?= <zbsdta@126.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix matrix keypad does not response with matrix_keypad driver in
 specific condition.
Message-ID: <20180202200204.ztyjsrk4uhxc3v2n@dtor-ws>
References: <69331bab.9854.161574424f2.Coremail.zbsdta@126.com>
 <CAHp75Vc-BfnE7ZrZ_R5pdC0OvVUi+iGkh6jj9VbEjP7BZ1_vNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vc-BfnE7ZrZ_R5pdC0OvVUi+iGkh6jj9VbEjP7BZ1_vNw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 09:43:20PM +0200, Andy Shevchenko wrote:
> +Cc: Dmitry
> 
> On Fri, Feb 2, 2018 at 6:05 PM, 张波 <zbsdta@126.com> wrote:
> >
> > in matrix_keypad.c, the function disable_row_irqs() may be called by matrix_keypad_interrupt() or matrix_keypad_stop(), there is race condition to disble irqs.
> >
> >
> > If while matrix_keypad_stop() is calling, and the keypad interrupt is triggered, disable_row_irqs() is called by matrix_keypad_interrupt() and matrix_keypad_stop() at the same time. then disable_row_irqs() is called twice, and the device enter suspend state before keypad->work is executed. At this condition the device will start keypad and enable irq once after resume. and irqs are disabled yet because irqs are disabled twice and only enable once.
> > then the device can't trigger keypad interrupts.
> > this problem could reproduce easily by change code to add time delay in matrix_keypad_interrupt() just before calling schedule_delayed_work.
> >
> 
> Thanks for the patch.
> 
> First of all, fix your email handlers. The patch is mangled quite badly.
> 
> Second, follow the process [1] and don't forget to put your
> Signed-off-by tag (hint `git commit -a -s`).
> 
> [1]: http://elixir.free-electrons.com/linux/latest/source/Documentation/process/submit-checklist.rst

Also, I do not think we need a new flag, simply taking the lock around
"keypad->stopped = true" in matrix_keypad_stop() instead of trying to
rely on mb() should fix the issue, as this will ensure that disabling
interrupts and scheduling the scan works as an atomic operation.

> 
> >
> > diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
> > index 1f316d66e6f7..03224ae9eedb 100644
> > --- a/drivers/input/keyboard/matrix_keypad.c
> > +++ b/drivers/input/keyboard/matrix_keypad.c
> > @@ -36,6 +36,7 @@ struct matrix_keypad {
> >   uint32_t last_key_state[MATRIX_MAX_COLS];
> >   struct delayed_work work;
> >   spinlock_t lock;
> > + int irq_enabled;
> >   bool scan_pending;
> >   bool stopped;
> >   bool gpio_all_disabled;
> > @@ -90,6 +91,12 @@ static void enable_row_irqs(struct matrix_keypad *keypad)
> >  {
> >   const struct matrix_keypad_platform_data *pdata = keypad->pdata;
> >   int i;
> > + unsigned long flags;
> > +
> > + spin_lock_irqsave(&keypad->lock, flags);
> > +
> > + if (keypad->irq_enabled == 1)
> > + goto out;
> >
> >   if (pdata->clustered_irq > 0)
> >   enable_irq(pdata->clustered_irq);
> > @@ -97,19 +104,31 @@ static void enable_row_irqs(struct matrix_keypad *keypad)
> >   for (i = 0; i < pdata->num_row_gpios; i++)
> >   enable_irq(gpio_to_irq(pdata->row_gpios[i]));
> >   }
> > + keypad->irq_enabled = 1;
> > +
> > +out:
> > + spin_unlock_irqrestore(&keypad->lock, flags);
> >  }
> >
> >  static void disable_row_irqs(struct matrix_keypad *keypad)
> >  {
> >   const struct matrix_keypad_platform_data *pdata = keypad->pdata;
> >   int i;
> > + unsigned long flags;
> >
> > + spin_lock_irqsave(&keypad->lock, flags);
> > + if (keypad->irq_enabled == 0)
> > + goto out;
> >   if (pdata->clustered_irq > 0)
> >   disable_irq_nosync(pdata->clustered_irq);
> >   else {
> >   for (i = 0; i < pdata->num_row_gpios; i++)
> >   disable_irq_nosync(gpio_to_irq(pdata->row_gpios[i]));
> >   }
> > + keypad->irq_enabled = 0;
> > +
> > +out:
> > + spin_unlock_irqrestore(&keypad->lock, flags);
> >  }
> >
> >  /*
> > @@ -167,18 +186,13 @@ static void matrix_keypad_scan(struct work_struct *work)
> >   activate_all_cols(pdata, true);
> >
> >   /* Enable IRQs again */
> > - spin_lock_irq(&keypad->lock);
> >   keypad->scan_pending = false;
> >   enable_row_irqs(keypad);
> > - spin_unlock_irq(&keypad->lock);
> >  }
> >
> >  static irqreturn_t matrix_keypad_interrupt(int irq, void *id)
> >  {
> >   struct matrix_keypad *keypad = id;
> > - unsigned long flags;
> > -
> > - spin_lock_irqsave(&keypad->lock, flags);

You really need to take the lock here, since if you are not using
"clustered" interrupt, your interrupt routines may run simultaneously,
which you do not want.

> >
> >   /*
> >   * See if another IRQ beaten us to it and scheduled the
> > @@ -194,7 +208,6 @@ static irqreturn_t matrix_keypad_interrupt(int irq, void *id)
> >   msecs_to_jiffies(keypad->pdata->debounce_ms));
> >
> >  out:
> > - spin_unlock_irqrestore(&keypad->lock, flags);
> >   return IRQ_HANDLED;
> >  }
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko

Thanks.

-- 
Dmitry
