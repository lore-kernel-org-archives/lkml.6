Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeEKUOz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 16:14:55 -0400
Received: from mail-ua0-f170.google.com ([209.85.217.170]:44143 "EHLO
        mail-ua0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbeEKUOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 16:14:53 -0400
X-Google-Smtp-Source: AB8JxZrFUq2fa2ZIGiqALuTqrdqpf6rf+9qCRAzrbHkjGoy7L2bK9B7HvsGqr6hlJS2WIcseSd0iPrNjpn6EH5eX14k=
MIME-Version: 1.0
In-Reply-To: <20180511150611.GA30504@codeaurora.org>
References: <20180502193749.31004-1-ilina@codeaurora.org> <20180502193749.31004-5-ilina@codeaurora.org>
 <CAD=FV=VVrqHnVTATzbXYsZgj8gA9sO=Ky_HRvztfRmjLZoq0=Q@mail.gmail.com>
 <ccd6a8e7a11b55f1e54737712facf064@codeaurora.org> <CAD=FV=X2k-g_LLuVZEbyJvc=_e68gcXREPRCOvvD=Fz566_Bgg@mail.gmail.com>
 <20180511150611.GA30504@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 11 May 2018 13:14:51 -0700
X-Google-Sender-Auth: R3Or4P_govi0u03jhdCWZHdLCpE
Message-ID: <CAD=FV=XTV0zF1Hmf5CTx3_+dfhK-nWRZwqWznFp5ASe4E_TyUQ@mail.gmail.com>
Subject: Re: [PATCH v7 04/10] drivers: qcom: rpmh: add RPMH helper functions
To: Lina Iyer <ilina@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 11, 2018 at 8:06 AM, Lina Iyer <ilina@codeaurora.org> wrote:
>> As I've said I haven't reviewed RPMh in any amount of detail and so
>> perhaps I don't understand something.
>>
>> OK, I dug a little more and coded up something for you.  Basically
>> you're doing a whole bunch of iteration / extra work here to try to
>> come up with a way to associate an extra bit of data with each "struct
>> rsc_drv".  Rather than that, just add an extra field into "struct
>> rsc_drv".  Problem solved.
>>
>> See http://crosreview.com/1054646 for what I mean.
>>
> I tried to avoid such pointer references and keep it object oriented
> with this approach. I agree that we run through a list of 2 (at the max)
> RSC to get the drv* from the rpmh_ctrlr. It is not going to be
> expensive.

Even if you wanted to keep things "object oriented" then IMHO your
code still should change.  Sure, it's not computationally expensive to
iterate through this list, but it adds an extra level of complexity
that doesn't seem justified.

If you _really_ needed an abstraction barrier then at least add a
"void *client_data" to "struct rsc_drv.c".  At least you'd get rid of
the ugly global list and store your pointer directly in the correct
structure rather than creating an external entity.  Now it becomes
100% obvious that there is exactly 1 "struct rpmh_ctrlr" for each
controller.  ...but IMO there's enough intertwining between "rpmh.c"
and "rpmh-rsc.c" that it would just be a waste because now you'd need
to do extra memory allocation and freeing.  ...and if you just
allocated the pointer in get_rpmh_ctrlr() it would also seem non-ideal
because this one-time allocation (that affects _all_ RPMh clients)
happens whenever one client happens to do the first access.  This is
one-time init so it makes sense to do it at init time.

I say that there's intertwining between "rpmh.c" and "rpmh-rsc.c"
because both C files call directly into one another and have intimate
knowledge of how the other works.  They aren't really separate things.
Specifically I see that "rpmh-rsc" directly calls into "rpmh.c" when
it calls rpmh_tx_done(), and of coruse "rpmh-rsc.c" directly calls
into "rpmh.c".


OK, so I've been browsing through the source code more so I can be a
little more informed here.  As far as I can tell "rpmh.c"'s goal is:

1. Put a simpler API atop "rpmh-rsc.c".  ...but why not just put that
API directly into "rpmh-rsc.c" anyway?  If there was someone that
needed the more complex API then having a "simpler" wrapper makes
sense, but that's not the case, is it?

2. Add caching atop "rpmh-rsc"


I'll respond to some of your other patches too, but I think that the
amount of code for caching is not very much.  I don't see the benefit
of trying to split the code into two files.  Put them into one and
then delete all the extra code you needed just the try to maintain
some abstraction.


> Another things this helps with is that, if the driver is not a child of
> the RSC nodes in DT, then the drvdata of the parent would not a RSC node
> and accessing that would result in a crash. This offers a cleaner exit
> path for the error case.

Why would the driver not be a child of the RSC nodes?  That's kinda
like saying "if you try to instantiate an i2c device as a platform
device then its probe will crash".  Yeah, it will.  Doctor, it hurts
if I poke myself in my eye with this sharp stick, do you have any
medicine that can help fix that?


>>>> I'll try to dig into this more so I could just be confused, but in
>>>> general it seems really odd to have a spinlock and something called a
>>>> "cache" at this level.  If we need some sort of mutual exclusion or
>>>> caching it seems like it should be stored in memory directly
>>>> associated with the RPMh device, not some external global.
>>>>
>>> The idea behind the locking is not to avoid the race between rpmh.c and
>>> rpmh-rsc.c. From the DT, the devices that are dependent on the RSCs are
>>> probed following the probe of the controller. And init is not that we are
>>> worried about.
>>> The condition here is to prevent the rpmh_rsc[] from being modified
>>> concurrently by drivers.
>>
>>
>> OK, I see the point of the locking now, but not the list still.
>> Sounds like Matthias agrees with me that the list isn't useful.  Seems
>> like you should squash my patch at http://crosreview.com/1042883 into
>> yours.
>>
> I saw your approach. I am okay with it for your tree,

I'm not okay with it for the Chrome OS tree.  We need to match
upstream, not fork for style reasons.  I'd rather take a driver that I
think it overly complex but matches upstream than a private driver.


> my approach comes
> out of experiences in qcom platforms and how things tend to shape up in
> the future. I would want you to consider my reasoning as well, before we
> go forward.

I suppose we can get advice from others who have worked in qcom
platforms and see what they think.  My opinions come out of years of
experience working with Linux drivers, so I guess we both have some
experience under our belts that we're trying to leverage.

-Doug
