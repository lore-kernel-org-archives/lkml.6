Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeDQG2z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 02:28:55 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:39665 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbeDQG2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 02:28:54 -0400
X-Google-Smtp-Source: AIpwx485vASrFZy6qRIY2TtCOQx4EWyOX481rpxv8J5xAodYMjvaGu576uZv5olTjNXHHaKCmhDAOw==
Message-ID: <1523946530.2601.76.camel@baylibre.com>
Subject: Re: [PATCH 1/3] clk: add duty cycle support
From: Jerome Brunet <jbrunet@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 17 Apr 2018 08:28:50 +0200
In-Reply-To: <152394381701.51482.13679537430987320563@swboyd.mtv.corp.google.com>
References: <20180416175743.20826-1-jbrunet@baylibre.com>
         <20180416175743.20826-2-jbrunet@baylibre.com>
         <152394381701.51482.13679537430987320563@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-16 at 22:43 -0700, Stephen Boyd wrote:
> Quoting Jerome Brunet (2018-04-16 10:57:41)
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index 7af555f0e60c..fff7890ae355 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -68,6 +68,8 @@ struct clk_core {
> >         unsigned long           max_rate;
> >         unsigned long           accuracy;
> >         int                     phase;
> > +       unsigned int            duty_num;
> > +       unsigned int            duty_den;
> 
> Maybe this can be a struct?
> 
> 	struct duty {
> 		unsigned int num;
> 		unsigned int den;
> 	};
> 
> Or even more generically, a struct frac?

Sure, I'll look into it

> 
> >         struct hlist_head       children;
> >         struct hlist_node       child_node;
> >         struct hlist_head       clks;
> > @@ -2401,6 +2403,164 @@ int clk_get_phase(struct clk *clk)
> >  }
> >  EXPORT_SYMBOL_GPL(clk_get_phase);
> >  
> > +static int clk_core_update_duty_cycle_nolock(struct clk_core *core)
> > +{
> > +       int ret;
> > +       unsigned int num, den;
> > +
> > +       if (!core || !core->ops->get_duty_cycle)
> 
> Does !core happen?

With the passthrough mechanism, it does

> 
> > +               return 0;
> > +
> > +       /* Update the duty cycle if the callback is available */
> > +       ret = core->ops->get_duty_cycle(core->hw, &num, &den);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* Don't trust the clock provider too much */
> > +       if (den == 0 || (num > den))
> 
> Drop useless parenthesis please.

Sure

> 
> > +               return -EINVAL;
> > +
> > +       core->duty_num = num;
> > +       core->duty_den = den;
> > +
> > +       return 0;
> > +}
> > +
> > +static int clk_core_get_duty_cycle_nolock(struct clk_core *core,
> > +                                         unsigned int *num,
> > +                                         unsigned int *den)
> > +{
> > +       int ret;
> > +
> > +       if (!core)
> > +               return 0;
> 
> Shouldn't this return 50%? At least it seems like the "no clk" case
> should be the default 50% duty cycle case.

Can't hurt, It is certainly better than leaving whatever was there.

> 
> > +
> > +       ret = clk_core_update_duty_cycle_nolock(core);
> > +
> > +       if (!ret) {
> > +               *num = core->duty_num;
> > +               *den = core->duty_den;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static int clk_core_set_duty_cycle_nolock(struct clk_core *core,
> > +                                         unsigned int num,
> > +                                         unsigned int den)
> > +{
> > +       int ret;
> > +
> > +       lockdep_assert_held(&prepare_lock);
> > +
> > +       if (!core || !core->ops->set_duty_cycle)
> 
> Does the !core case happen?
yep

> 
> > +               return 0;
> > +
> > +       if (clk_core_rate_is_protected(core))
> > +               return -EBUSY;
> > +
> > +       trace_clk_set_duty_cycle(core, num, den);
> > +
> > +       ret = core->ops->set_duty_cycle(core->hw, num, den);
> 
> Is the assumption that we aren't going to need to adjust the duty cycle
> of any parent clks when we set the duty cycle on a clk?

I'm not sure I understand what you mean, but I don't make any assumption about
the parent, Did I miss something ?

> 
> > +       if (ret)
> > +               return ret;
> > +
> > +       core->duty_num = num;
> > +       core->duty_den = den;
> > +
> > +       trace_clk_set_duty_cycle_complete(core, num, den);
> > +
> > +       return ret;
> > +}
> > +
> > +/**
> > + * clk_set_duty_cycle - adjust the duty cycle ratio of a clock signal
> > + * @clk: clock signal source
> > + * @ratio: duty cycle ratio in milli-percent
> 
> This doesn't match anymore.
> 
> > + *
> > + * ADD BLURB HERE
> 
> Please do! :)

Oops ... sorry about that.

> 
> > + */
> > +int clk_set_duty_cycle(struct clk *clk, unsigned int num, unsigned int den)
> > +{
> > +       int ret;
> > +
> > +       if (!clk)
> > +               return 0;
> > +
> > +       /* sanity check the ratio */
> > +       if (den == 0 || (num > den))
> 
> Drop useless parenthesis please.
sure

> 
> > +               return -EINVAL;
> > +
> > +       clk_prepare_lock();
> > +
> > +       if (clk->exclusive_count)
> > +               clk_core_rate_unprotect(clk->core);
> > +
> > +       ret = clk_core_set_duty_cycle_nolock(clk->core, num, den);
> > +
> > +       if (clk->exclusive_count)
> > +               clk_core_rate_protect(clk->core);
> > +
> > +       clk_prepare_unlock();
> > +
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(clk_set_duty_cycle);
> > +
> > +static unsigned int clk_core_get_scaled_duty_cycle(struct clk_core *core,
> > +                                                  unsigned int scale)
> > +{
> > +       int ret;
> > +       unsigned int duty;
> > +
> > +       clk_prepare_lock();
> > +       ret = clk_core_update_duty_cycle_nolock(core);
> > +       if (ret)
> > +               return 0;
> > +
> > +       duty = DIV_ROUND_CLOSEST_ULL((u64)core->duty_num * scale,
> > +                                    core->duty_den);
> 
> Just use mult_frac() instead of casting and rounding to closest? I
> haven't looked closely so feel free to correct me if that doesn't make
> sense.
> 
> > +
> > +       clk_prepare_unlock();
> > +
> > +       return duty;
> > +}
> > +
> > +/**
> > + * clk_get_scaled_duty_cycle - return the duty cycle ratio of a clock signal
> > + * @clk: clock signal source
> > + * @scale: scaling factor to be applied to represent the ratio as an integer
> > + *
> > + * Returns the duty cycle ratio of a clock node multiplied by the provided
> > + * scaling factor.
> > + */
> > +unsigned int clk_get_scaled_duty_cycle(struct clk *clk, unsigned int scale)
> > +{
> > +       if (!clk)
> > +               return 0;
> > +
> > +       return clk_core_get_scaled_duty_cycle(clk->core, scale);
> > +}
> > +EXPORT_SYMBOL_GPL(clk_get_scaled_duty_cycle);
> > +
> > +int __clk_set_duty_cycle_passthrough(struct clk_hw *hw, unsigned int num,
> > +                                    unsigned int den)
> > +{
> > +       struct clk_core *parent = hw->core->parent;
> > +
> > +       return clk_core_set_duty_cycle_nolock(parent, num, den);
> 
> Ah I see. So a pass through clk will do the parent traversal itself? And
> more complicated cases could even adjust their phase and then call to
> the parent to do some other adjustment?

Actually, it is more a delegation. Either the clock
* can't do anything (fixed duty)
* or, can the duty cycle
* or, it a "wire" a provides whatever the parent provides

I'm not sure if making something more complicated makes sense. Duty cycle does
not seem to be a function of the parent duty cycle, unlike the rate.

I'm not against the suggestion, but I don't see the use case. Could you give a
hint ?

> 
> If we ever want to make the prepare lock more fine grained then we'll
> want the framework to be in control or at least aware of the traversal
> that's going on,

If/when it gets done, I suspect this new lock would have tight relationship with
the core structure, no ? I guess putting the lock where lockdep_assert_held() is
 in clk_core_get_duty_cycle_nolock() and clk_core_set_duty_cycle_nolock() would
do the trick.

>  so it would be better to design it more like how
> clk_set_rate() works today, 

you mean with a recalc(), determine() and set() callback ?
I thought about it, but it seemed a bit too much for a v1 ... 

Even with this, as far as I understand, the clock does tree traversal for rate
in the same way, in determine()/round() instead of set().

in clk-divider.c:clk_divider_bestdiv()
- parent_rate = clk_hw_round_rate(parent, rate * i);

Seems to be the same thing/issue.
Did you mean something else ? like core flag (CLK_SET_DUTY_PASSTHROUGH) ?

> even if that is only to direct the traversal
> upwards to the parent until we find the last parent to actually change
> duty cycle on. 
> Then we can more easily lock the right clk subtree
> without having to worry about clk providers traversing the tree
> themselves.
> 
> > +}
> > +EXPORT_SYMBOL_GPL(__clk_set_duty_cycle_passthrough);
> > +
> > +int __clk_get_duty_cycle_passthrough(struct clk_hw *hw, unsigned int *num,
> > +                                    unsigned int *den)
> > +{
> > +       struct clk_core *parent = hw->core->parent;
> > +
> > +       return clk_core_get_duty_cycle_nolock(parent, num, den);
> > +}
> > +EXPORT_SYMBOL_GPL(__clk_get_duty_cycle_passthrough);
> > +
> >  /**
> >   * clk_is_match - check if two clk's point to the same hardware clock
> >   * @p: clk compared against q
> > @@ -2638,6 +2801,16 @@ static int clk_debug_create_one(struct clk_core *core, struct dentry *pdentry)
> >         if (!d)
> >                 goto err_out;
> >  
> > +       d = debugfs_create_u32("clk_duty_num", 0444, core->dentry,
> 
> Can we spell it out? clk_duty_numerator?
sure

> 
> > +                              &core->duty_num);
> > +       if (!d)
> > +               goto err_out;
> > +
> > +       d = debugfs_create_u32("clk_duty_den", 0444, core->dentry,
> 
> And clk_duty_denominator? Or have a two entry file that reads both so
> that there isn't a "debugfs race" where the duty is half updated while
> we read the numerator and denominator changes or something.

I thought it was best keep it simple to parse, with just one value.
I prefer to have this in a single file, I'll do it.

> 
> > +                              &core->duty_den);
> > +       if (!d)
> > +               goto err_out;
> > +
> >         d = debugfs_create_file("clk_flags", 0444, core->dentry, core,
> >                                 &clk_flags_fops);
> >         if (!d)
> > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> > index 1d25e149c1c5..91e0e37e736b 100644
> > --- a/include/linux/clk-provider.h
> > +++ b/include/linux/clk-provider.h
> > @@ -168,6 +168,15 @@ struct clk_rate_request {
> >   *             by the second argument. Valid values for degrees are
> >   *             0-359. Return 0 on success, otherwise -EERROR.
> >   *
> > + * @get_duty_cycle: Queries the hardware to get the current duty cycle ratio
> > + *              of a clock. Returned values denominator cannot be 0 and must be
> > + *              superior or egal to the numerator.
> 
> equal?
> 
> > + *
> > + * @set_duty_cycle: Apply the duty cycle ratio to this clock signal specified by
> > + *              the numerator (2nd argurment) and denominator (3rd  argument).
> > + *              Argument must be a valid ratio (denominator > 0
> > + *              and >= numerator) Return 0 on success, otherwise -EERROR.
> > + *
> >   * @init:      Perform platform-specific initialization magic.
> >   *             This is not not used by any of the basic clock types.
> >   *             Please consider other ways of solving initialization problems
