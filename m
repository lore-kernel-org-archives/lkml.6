Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51907C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16ACB222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550004460;
	bh=RMYvxcpdbkWwkfSb0HhnxMOR1COqv+w3oURw2YQwRpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jZPwlYcw9VDiHU9neYZL1vhEyjkPUi4mELj6hvlevS4ZLJKAMl/WLQlMRo0rL3Jca
	 xYEjmIKVFI5pDhgI7UGbU1FTfsd0VZb4OnzQvPwHRENOj4e1u6x4l3bWSwAt+N+r64
	 94/bTabcP3IDlYUuqsFu3D+tAXkQhJa/KLWeTsFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbfBLUri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:47:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:54190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbfBLUrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:47:37 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58DD0222BE;
        Tue, 12 Feb 2019 20:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550004455;
        bh=RMYvxcpdbkWwkfSb0HhnxMOR1COqv+w3oURw2YQwRpo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JOuTspN87qK7vajIxAtMj0y7enZMH/QuP2GIMb1eXsCNIvZTfjtKbinoX+ZmZJyWJ
         JgSbhWEiSP24b7Sbs6l4iDxngT4bMSSd930fjscK9PypzE3IULxkKx7O2Jd27/15mS
         WlQmeTdPngC2VWK5rUe6/JzVY2opShnO39cJ5y3Q=
Date:   Tue, 12 Feb 2019 20:47:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Robert Eshleman <bobbyeshleman@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: light: Add driver for ap3216c
Message-ID: <20190212204730.16864802@archlinux>
In-Reply-To: <CAGngYiV_6MzKOSomAWs1znp8ThPRAL-e2CVZfn+ZHZOq8DiD0A@mail.gmail.com>
References: <89716a4433cd83aea5f4200359b184b0ee2cc8bd.1549828313.git.bobbyeshleman@gmail.com>
        <CAGngYiV6zm12XhB6WChSXNndLMSJ3e4NAB=BLq_mrXtWLKEruQ@mail.gmail.com>
        <20190211212734.01909e62@archlinux>
        <CAGngYiV_6MzKOSomAWs1znp8ThPRAL-e2CVZfn+ZHZOq8DiD0A@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 17:30:18 -0500
Sven Van Asbroeck <thesven73@gmail.com> wrote:

> On Mon, Feb 11, 2019 at 4:27 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > Agreed.  Or potentially just use regmap_bulk_read and rely on
> > the regmap internal locking to do it for you.  
> 
> Neat solution. But it may only work correctly iff regmap_bulk_read()
> reads the low
> address first. I'm not sure if this function has that guarantee. If
> somebody changes
> the read order, the driver will break. But I think I'm being overly
> paranoid here :)

Good question on whether it is guaranteed to read in increasing register
order (I didn't actually check the addresses are in increasing order
but assume they are or you would have pointed that out ;)

That strikes me as behaviour that should probably be documented as long
as it is true currently.

> 
> > So yes, it's more than possible that userspace won't get the same number
> > of events as samples taken over the limit, but I don't know why we care.
> > We can about missing a threshold being passed entirely, not about knowing
> > how many samples we were above it for.  
> 
> I suspect that we run a small risk of losing an event, like so:
> 
> PS (12.5 ms)
> --> interrupt -> iio event  
More interesting if this one never happened, so we got a one off proximity
event missed.

> ALS (100 ms)
> --> interrupt -> iio event  
> PS (12.5 ms)
> --> interrupt ========= no iio event generated  
> ALS (100 ms)
> --> interrupt -> iio event  
> 
> To see why, imagine that the scheduler decides to move away from the
> threaded interrupt
> handler right before ap3216c_clear_int(). Say 20ms, which I know is a
> loooong time,
> but bear with me, the point is that it _could_ happen as we're not a RTOS.
> 
> static irqreturn_t ap3216c_event_handler(int irq, void *p)
> {
>         /* imagine ALS interrupt came in, INT_STATUS is 0b01 */
>         regmap_read(data->regmap, AP3216C_INT_STATUS, &status);
>         if (status & mask1) iio_push_event(PROX);
>         if (status & mask2) iio_push_event(LIGHT);
> 
>         /* imagine schedule happens here */
>         msleep(20);
>         /* while we were not running, PS interrupt came in
>            INT_STATUS is now 0b11
>            yet no new interrupt is generated, as we are ONESHOT
>         */
>         ap3216c_clear_int(data);
>         /* clears both bits, interrupt line goes low.
>             knowledge that the PS interrupt came in is now lost */
> }
> 
> Not sure if that's acceptable driver behaviour. In real life it
> probably wouldn't matter much,
> except for occasional added latency maybe ?
Good point, I'd missed that a single clear was clearing both bits
rather than just the one we thought had fired.

If we clear just the right one, (which I think we can do from
the datasheet
"1: Software clear after writing 1 into address 0x01 each bit#"
However the code isn't writing a 3 in that clear, so I'm not
sure if the datasheet is correct or not...

and it is a level interrupt (which I think it is?) then we would
be safe against this miss.

If either we can only globally clear or it's not a level interrupt
there isn't much we can do to avoid a miss, it's just a bad hardware
design.

Jonathan
