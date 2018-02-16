Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758584AbeBPQmp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 11:42:45 -0500
Received: from muru.com ([72.249.23.125]:57280 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752318AbeBPQmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 11:42:44 -0500
Date: Fri, 16 Feb 2018 08:42:40 -0800
From: Tony Lindgren <tony@atomide.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / wakeirq: Add wakeup name to dedicated wake irqs
Message-ID: <20180216164240.GU6364@atomide.com>
References: <20180209161456.18951-1-tony@atomide.com>
 <CAJZ5v0iF0M+X5vujyaKmXrEWpBEceQ=PX6bhgcwFf8P-q7Cu-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iF0M+X5vujyaKmXrEWpBEceQ=PX6bhgcwFf8P-q7Cu-Q@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rafael J. Wysocki <rafael@kernel.org> [180216 09:42]:
> On Fri, Feb 9, 2018 at 5:14 PM, Tony Lindgren <tony@atomide.com> wrote:
> > This makes it easy to grep :wakeup /proc/interrupts.
> > diff --git a/drivers/base/power/wakeirq.c b/drivers/base/power/wakeirq.c
> > --- a/drivers/base/power/wakeirq.c
> > +++ b/drivers/base/power/wakeirq.c
> > @@ -112,6 +112,7 @@ void dev_pm_clear_wake_irq(struct device *dev)
> >                 free_irq(wirq->irq, wirq);
> >                 wirq->status &= ~WAKE_IRQ_DEDICATED_MASK;
> >         }
> > +       kfree(wirq->name);
> >         kfree(wirq);
> >  }
> >  EXPORT_SYMBOL_GPL(dev_pm_clear_wake_irq);
> > @@ -175,7 +176,8 @@ static irqreturn_t handle_threaded_wake_irq(int irq, void *_wirq)
> >  int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
> >  {
> >         struct wake_irq *wirq;
> > -       int err;
> > +       int err, namelen;
> > +       const char *postfix = ":wakeup";
> >
> >         if (irq < 0)
> >                 return -EINVAL;
> > @@ -184,6 +186,14 @@ int dev_pm_set_dedicated_wake_irq(struct device *dev, int irq)
> >         if (!wirq)
> >                 return -ENOMEM;
> >
> > +       namelen = strlen(dev_name(dev)) + strlen(postfix) + 1;
> > +       wirq->name = kzalloc(namelen, GFP_KERNEL);
> > +       if (!wirq->name) {
> > +               err = -ENOMEM;
> > +               goto err_free;
> > +       }
> > +
> > +       snprintf(wirq->name, namelen, "%s%s", dev_name(dev), postfix);
> 
> As Andy said you can do
> 
> wirq->name = kasprintf(GFP_KERNEL, "%s:wakeup", dev_name(dev));
> if (!wirq->name) {
>         err = -ENOMEM;
>         goto err_free;
> }
> 
> here and it will allocate the buffer for you.

Yeah great, will update and repost next week. I'll also
give Andy's patch a try, sounds like we may want to do
both though.

Regards,

Tony
