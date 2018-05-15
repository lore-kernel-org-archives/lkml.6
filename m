Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752932AbeEOTwL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 15:52:11 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:36177 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbeEOTwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 15:52:05 -0400
X-Google-Smtp-Source: AB8JxZreFtLafT/52uedPYGY5y873kiNVtzqmcZsRw/dftqSwBbO2IPWdBAdt06mijnX1zrQ/lloZNYLEJCsPFnnLBA=
MIME-Version: 1.0
In-Reply-To: <20180515180309.GC28489@codeaurora.org>
References: <20180509170159.29682-1-ilina@codeaurora.org> <20180509170159.29682-10-ilina@codeaurora.org>
 <CAD=FV=Xvi8V43+J9v-mosU5WUDQtabg8gUbrkn6SCoNEYFtjUQ@mail.gmail.com>
 <20180514195929.GA22950@codeaurora.org> <CAD=FV=U+6N9LqvAh-V5ZKd_QKL9yTe+P9gVkvH4tr-SsUaMwng@mail.gmail.com>
 <20180515162326.GA28489@codeaurora.org> <CAD=FV=VTG4Y+uHXSR2T8GdRBzZcW4nZ7hExgaC=m3Wsm3KoubQ@mail.gmail.com>
 <20180515180309.GC28489@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 15 May 2018 12:52:02 -0700
X-Google-Sender-Auth: yV9bpkeWwX-VMtjb5FS5aDbEpMg
Message-ID: <CAD=FV=XPhQEk9CWYs4Hd85-Tf8UqMfhV+4YoUzoUzDqys5E-zA@mail.gmail.com>
Subject: Re: [PATCH v8 09/10] drivers: qcom: rpmh: add support for batch RPMH request
To: Lina Iyer <ilina@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, rplsssn@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 15, 2018 at 11:03 AM, Lina Iyer <ilina@codeaurora.org> wrote:
>>> Also, the bus requests have quite a churn during the course of an
>>> usecase. They are setup and invalidated often.
>>> It is faster to have them separate and invalidate the whole lot of the
>>> batch_cache instead of intertwining them with requests from other
>>> drivers and then figuring out which all must be invalidated and rebuilt
>>> when the next batch requests comes in. Remember, that requests may come
>>> from any driver any time and therefore will be mangled if we use the
>>> same data structure. So to be faster and to avoid having mangled requests
>>> in the TCS, I have kept the data structures separate.
>>
>>
>> If you need to find a certain group of requests then can't you just
>> tag them and it's easy to find them?  I'm still not seeing the need
>> for a whole separate code path and data structure.
>>
> Could be done but it will be slower and involve a lot more code than
> separate data structures.

When you say "a lot more code", you mean that you'll have to write a
lot more code or that each request will execute a lot more code?  I
would argue that very little code would need to be added (compared to
your patch) if rpmh_write_batch() was implemented atop
rpmh_write_async().  Even with extra tagging / prioritization it would
be small.  I could try to prototype it I guess.

I think you mean that it would _execute_ a lot more code and thus be
slower.  Is that right?  Is your main argument here that statically
pre-allocating 20 slots in an array is going to be a lot faster than
kzalloc-ing 20 linked list nodes and chaining them together?  If
you're truly worried about the kzalloc calls being slow, I suppose you
could always allocate them with a kmem_cache.  ...but we're talking
fewer than 20 kzalloc calls, right?

I'll also make an argument (with no data to back me up) that
maintaining separate functions for handling the batch cases will slow
down your kernel because your footprint in the icache will be bigger
and you'll be more likely to kick something else out that actually
needs to run fast.


>>>>>>> +       spin_unlock_irqrestore(&ctrlr->lock, flags);
>>>>>>> +
>>>>>>> +       return ret;
>>>>>>> +}
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> As part of my overall confusion about why the batch cache is different
>>>>>> than the normal one: for the normal use case you still call
>>>>>> rpmh_rsc_write_ctrl_data() for things you put in your cache, but you
>>>>>> don't for the batch cache.  I still haven't totally figured out what
>>>>>> rpmh_rsc_write_ctrl_data() does, but it seems strange that you don't
>>>>>> do it for the batch cache but you do for the other one.
>>>>>>
>>>>>>
>>>>> flush_batch does write to the controller using
>>>>> rpmh_rsc_write_ctrl_data()
>>>>
>>>>
>>>>
>>>> My confusion is that they happen at different times.  As I understand
>>>> it:
>>>>
>>>> * For the normal case, you immediately calls
>>>> rpmh_rsc_write_ctrl_data() and then later do the rest of the work.
>>>>
>>>> * For the batch case, you call both later.
>>>>
>>>> Is there a good reason for this, or is it just an arbitrary
>>>> difference?  If there's a good reason, it should be documented.
>>>>
>>>>
>>> In both the cases, the requests are cached in the rpmh library and are
>>> only sent to the controller only when the flushed. I am not sure the
>>> work is any different. The rpmh_flush() flushes out batch requests and
>>> then the requests from other drivers.
>>
>>
>> OK then, here are the code paths I see:
>>
>> rpmh_write
>> => __rpmh_write
>>   => cache_rpm_request()
>>   => (state != RPMH_ACTIVE_ONLY_STATE): rpmh_rsc_send_data()
>>
>> rpmh_write_batch
>> => (state != RPMH_ACTIVE_ONLY_STATE): cache_batch()
>>   => No call to rpmh_rsc_send_data()
>>
>>
>> Said another way:
>>
>> * if you call rpmh_write() for something you're going to defer you
>> will still call cache_rpm_request() _before_ rpmh_write() returns.
>>
>> * if you call rpmh_write_batch() for something you're going to defer
>> then you _don't_ call cache_rpm_request() before rpmh_write_batch()
>> returns.
>>
>>
>> Do you find a fault in my analysis of the current code?  If you see a
>> fault then please point it out.  If you don't see a fault, please say
>> why the behaviors are different.  I certainly understand that
>> eventually you will call cache_rpm_request() for both cases.  It's
>> just that in one case the call happens right away and the other case
>> it is deferred.
>
> True. I see where your confusion is. It is because of an optimization and
> our existential need for saving power at every opportunity.
>
> For rpmh_write path -
> The reason being for the disparity is that, we can vote for a system low
> power mode (modes where we flush the caches and put the entire silicon
> is a low power state) at any point when all the CPUs are idle. If a
> driver has updated its vote for a system resource, it needs to be
> updated in the cache and thats what cache_rpm_request() does. Its
> possible that we may enter a system low power mode immediately after
> that. The rpmh_flush() would be called by the idle driver and we would
> flush the cached values and enter the idle state. By writing immediately
> to the TCS, we avoid increasing the latency of entering an idle state.
>
> For the rpmh_write_batch() path -
> The Bus driver would invalidate the TCS and the batch_cache. The use
> case fills up the batch_cache with values as needed by the use case.
> While during the usecase, the CPUs can go idle and the idle drivers
> would call rpmh_flush(). At that time, we would write the batch_cache
> into the already invalidated TCSes and then write the rest of the cached
> requests from ->cache. We then enter the low power modes.
>
> The optimization of writing the sleep/wake votes in the same context of
> the driver making the request, helps us avoid writing some extra
> registers in the critical idle path.

I don't think I followed all that, but I'll try to read deeper into
RPMh.  ...but one question: could the two paths be changed to be the
same?  AKA would it be bad to call rpmh_rsc_send_data() synchronously
in rpmh_write_batch()?

If the two cases really need to behave differently then it should be
documented in the code.


-Doug
