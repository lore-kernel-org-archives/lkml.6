Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE01C10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0323217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbfBRPVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:21:45 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:57616 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728227AbfBRPVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:21:45 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E4206B24C677EA81498B;
        Mon, 18 Feb 2019 23:16:20 +0800 (CST)
Received: from localhost (10.47.94.189) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Mon, 18 Feb 2019
 23:16:17 +0800
Date:   Mon, 18 Feb 2019 15:16:06 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: light: Add driver for ap3216c
Message-ID: <20190218151606.00000d10@huawei.com>
In-Reply-To: <CAGngYiVGjPSnVfnJhR+0YJg+qOzMQfJM+Cd9ZRe===9pk1_3pA@mail.gmail.com>
References: <89716a4433cd83aea5f4200359b184b0ee2cc8bd.1549828313.git.bobbyeshleman@gmail.com>
        <CAGngYiV6zm12XhB6WChSXNndLMSJ3e4NAB=BLq_mrXtWLKEruQ@mail.gmail.com>
        <20190211212734.01909e62@archlinux>
        <CAGngYiV_6MzKOSomAWs1znp8ThPRAL-e2CVZfn+ZHZOq8DiD0A@mail.gmail.com>
        <20190212204730.16864802@archlinux>
        <CAGngYiVGjPSnVfnJhR+0YJg+qOzMQfJM+Cd9ZRe===9pk1_3pA@mail.gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.94.189]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 23:40:13 -0500
Sven Van Asbroeck <thesven73@gmail.com> wrote:

> On Tue, Feb 12, 2019 at 3:47 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> >
Hi Sven

I think the issue, here is that you are putting guarantees on 'consistency'
that IIO does not imply.  In fact as I mention below, for many sensors
it is not possible to imply them, so there is no reason to put false
complexity in here either.

The read of the sysfs value reads the value as near as possible to now.
That value has no particularly relationship with the state when the event
occurred.

> > Good question on whether it is guaranteed to read in increasing register
> > order (I didn't actually check the addresses are in increasing order
> > but assume they are or you would have pointed that out ;)
> >
> > That strikes me as behaviour that should probably be documented as long
> > as it is true currently.
> >  
> 
> Looking at the datasheet closely... this chip doesn't seem to support
> bulk/raw accesses. At least, it's not documented. So maybe we should
> steer clear of that, and tell the regmap core, via .use_single_read
> and .use_single_write in regmap_config.
> 
> So once these flags are set, we could call regmap_bulk_read() on the
> LO/HI combo registers, and it would probably work. But do we really
> want to? The LO register, when read, cause side-effects
> in the corresponding HI register. That's weird / unexpected for developers.
> Maybe it makes sense to make this explicit, not implicit. In addition,
> bulk_read() behaviour changes in the future may break the register
> reads ?

I suspect that would break lots of devices if it happened, but
fair enough that explicit might be good.  One option would be
to document clearly in regmap the requirement that bulk read is ordered.

> 
> > >  
> >
> > If we clear just the right one, (which I think we can do from
> > the datasheet
> > "1: Software clear after writing 1 into address 0x01 each bit#"
> > However the code isn't writing a 3 in that clear, so I'm not
> > sure if the datasheet is correct or not...
> >
> > and it is a level interrupt (which I think it is?) then we would
> > be safe against this miss.
> >
> > If either we can only globally clear or it's not a level interrupt
> > there isn't much we can do to avoid a miss, it's just a bad hardware
> > design.
> >  
> 
> I think we're in luck, and this would work ! Note 1 on page 12 of the
> datasheet:
> 
> "Note1. The INT pin will be set low and set INT status bit when ALS or
> PS or (ALS+PS) interrupt event occurrence.
> User can clear INT bit and individual status bits when reading the
> register 0xD(ALS) , 0xF(PS) and 0xD+0xF(ALS+PS) respectively."
> 
> >
> >  
> 
> I'm sorry to wear out your patience, but I think there are more
> synchronization issues lurking here.
> 
> The iio_push_event(THRESH) tells interested userspace processes:
> "hey, maybe you want to check if a threshold is crossed", right?
> Is my understanding correct?

Nope. It tells you that it has definitely been crossed.  It doesn't
say it wasn't crossed multiple times (userspace is unlikely to care
for a light sensor).

> 
> If so, I think it's possible that a threshold is crossed, without
> userspace knowing. To see why, let's look at the handler again:
> 
> static irqreturn_t ap3216c_event_handler(int irq, void *p)
> {
>         /* imagine ALS interrupt came in */
>         regmap_read(data->regmap, AP3216C_INT_STATUS, &status);
>         if (status & als) iio_push_event(LIGHT);
> 
>         /* imagine schedule happens here */
>         msleep(...);
>         /* while we are not running, userspace reacts to the event,
>          * reads the new ALS value.
>          * Next, imagine a _new_ ALS interrupt comes in, while we are
>          * still sleeping. the irq does not get re-scheduled, as it's
>          * still running !
>          * Next, we proceed:
>         */
>         ap3216c_clear_als(data);

Need to clear the right bit only then we are fine, because we immediately
get another interrupt, because it's a level interrupt (I think)
and we haven't acknowledged it.

>         /* at this point there has been a new ALS interrupt without
>          * userspace knowing about it.
>          */
> }
> 
> The _chance_ of this happening is very low, as ALS/PS events are quite
> widely spaced. But we're not an RTOS. Question is: do we want to take
> the risk? Idk, perhaps it's ok to trade simplicity for the low chance of
> missing a threshold.

This is the fundamental problem.... The relationship between events and
reading from the sysfs files is not what you think...

Semantics are we got an event that said it was crossed.  This was correctly
reported to userspace.   Userspace doesn't typically care if there are multiple
so close together that we missed one.  We aren't accurately counting how
long it was dark, just noting that it became dark.

> 
> +static int ap3216c_write_event_config(struct iio_dev *indio_dev,
> +                                    const struct iio_chan_spec *chan,
> +                                    enum iio_event_type type,
> +                                    enum iio_event_direction dir, int state)
> +{
> +       struct ap3216c_data *data = iio_priv(indio_dev);
> +
> +       switch (chan->type) {
> +       case IIO_LIGHT:
> +               data->als_thresh_en = state;
> +               return 0;
> +
> +       case IIO_PROXIMITY:
> +               data->prox_thresh_en = state;
> +               return 0;
> +
> +       default:
> +               return -EINVAL;
> +       }
> 
> I think this may not work as intended. One thread (userspace) writes
> a variable, another thread (threaded irq handler) checks it. but there
> is no explicit or implicit memory barrier. So when userspace activates
> thresholding, it may take a long time for the handler to 'see' it !

Yes.  But if userspace took a while to get around to writing this value,
it would also take longer...  It's not time critical exactly when you
enable the event.  One can create cases where someone might
care, but they are pretty obscure.

> 
> One way to guarantee that the irq handler 'sees' this immediately
> is to grab a mutex, which issues an implicit memory barrier.
> 
> >
> >  
> 
> Allow me to suggest a simple, straightforward way to make all the above
> issues go away (if indeed they are issues) :
> 
> First, disable fine-grained regmap locking, by setting .disable_locking
> in regmap_config.
> 
> Next, read ALS and PS _exclusively_ in the irq handler, guard it with
> a mutex:
> 
> static irqreturn_t ap3216c_event_handler(int irq, void *p)
> {
>     int ret = IRQ_NONE;
> 
>     mutex_lock(&data->m);
>     regmap_read(data->regmap, AP3216C_INT_STATUS, &status);
>     if (status & als) {
>         /* mutex m ensures LO and HI are read non-interleaved */
>         regmap_read(data->regmap, ALS_LO, &als_lo);
>         regmap_read(data->regmap, ALS_HI, &als_hi);

No. There is no explicit data gathering in an IIO event.  That's the semantics
we have, and we aren't going to change them for a theoretical race which doesn't
actually have any meaningful effect.

If you get an event, the threshold was passed.  If you read after that
from usersapce you may or may not find the value is above the threshold.
It doesn't matter, you still know it was.

So, lets have a rapidly varying light source to illustrate why this is incredibly
unlikely to matter, because no system can be defined to require that it does...

Light, detecting low because I drew it that way ;)
-------         ---------------
       |_______|


sample   |     |

So did that second one hit the window?  Maybe, maybe not.  However, did one of them
hit the window so we got an interrupt.  Yes, because our read frequency is fast enough.

So the case you are dealing with is trying to ensure you get the right number of
interrupts.   That isn't how these sensors are used.  They aren't that precise and
the real world isn't that precise.

What we need to guarantee is:

1) If the sensor reads on an occasion where the threshold is passed, we do not miss the event
   The event is the threshold being passed, not the existence of the reading, or how many
   readings etc.

2) A data read will result in a value.  There is no guarantee that it will match with the
   event.  All manner of delays could result in new data having occurred before that read.

Many devices run at many times the frequency we read them at, allow detection of fast
transitions, we don't expect them to always give us a reading that 'confirms' the
threshold pass. We should not do so here either.


>         /* mutex m's memory barrier lets userspace 'see' data->als change */
>         data->als = als_lo | (als_hi<<8);
>         /* mutex m's memory barrier lets us 'see' do_thresholding change */
>         if (data->do_thresholding)
>             iio_push_event();
>         /* mutex m prevents userspace from reading the cached value
>          * in between iio_push_event() and als_clear(), which means
>          * userspace never 'misses' interrupts.

Ah.. This kind of makes it clear where the confusion likes.  Why would we care
if it does read it there?  It would read the value, what has the value got
to do with the interrupt?  Nothing whatsoever.  They were generated by
the same actual read, but userspace should not care about that as we don't
make any promises that they were...

>          */
>         als_clear(data);
>         ret = IRQ_HANDLED;
>     }
>     ( ... ps case left out for brevity ... )
>     mutex_unlock(&data->m);
> 
>     return ret;
> }
> 
> Now, ap3216c_read_raw becomes:
> 
> ap3216c_read_raw()
> {
>     mutex_lock(&data->m);
>     switch (mask) {
>         IIO_CHAN_INFO_PROCESSED:
>             switch (chan->type) {
>                 case IIO_LIGHT:
>                     *val = some_function_of(data->als);
Which means that If I come along and read 10 minutes later
I get your latched value?

Why would I want that?  I'm not asking for what was the value when the
interrupt fired, I'm asking what is the value now.

>             }
>     }
>     mutex_unlock(&data->m);
> }
> 
> and ap3216c_write_event_config becomes:
> 
> ap3216c_write_event_config()
> {
>     mutex_lock(&data->m);
>     switch (chan->type) {
>        case IIO_LIGHT:
>                data->als_thresh_en = state;
>                goto out;
>     }
> out:
>     mutex_unlock(&data->m);
> }
> 
> In fact, we'd need mutex_lock around any function that touches the
> regmap, cached data, or threshold enable/disable flags.
There may be potential need for more locking, but not to protect some race
around the value, vs the interrupt...

Jonathan


