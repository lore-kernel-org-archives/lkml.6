Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932364AbeCOOdC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 10:33:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33813 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbeCOOc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 10:32:59 -0400
X-Google-Smtp-Source: AG47ELu8afkEH7DUgoZpqM2yY8t+uzewPHK+15UBqKD68FRAZcXBdnmOrnRURe8zwjcCkDVVBIJFK2HD08WtkWbldC8=
MIME-Version: 1.0
In-Reply-To: <53bf7dfe-32ee-1861-e6ea-81f667590a43@codeaurora.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
 <1520997629-17361-7-git-send-email-okaya@codeaurora.org> <12150aa0-77ba-878e-31f4-d4f8d6a28ccb@codeaurora.org>
 <2a4f4dec64b7462ae64152f6c2df9754@codeaurora.org> <CAKgT0UcriMiyV0q6y_x9r3-HJRAWp5_CpsK2jTqh3qvOV=Kkzw@mail.gmail.com>
 <d565406d-1bc7-6fb0-3f36-87a28ac69070@codeaurora.org> <CAKgT0UeBHGDmr0uXfuPQJKOomiH9uvXRVYpyDwMOzjkxAZMSYg@mail.gmail.com>
 <53bf7dfe-32ee-1861-e6ea-81f667590a43@codeaurora.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 15 Mar 2018 07:32:56 -0700
Message-ID: <CAKgT0UcBQRoSPPZ73bdu1oEBGqBA8_c3ZAjti20=+9UwEqpXbw@mail.gmail.com>
Subject: Re: [PATCH 7/7] ixgbevf: eliminate duplicate barriers on
 weakly-ordered archs
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Timur Tabi <timur@codeaurora.org>, Netdev <netdev@vger.kernel.org>,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 7:17 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 3/14/2018 9:44 PM, Alexander Duyck wrote:
>> On Wed, Mar 14, 2018 at 3:57 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>>> Hi Alexander,
>>>
>>> On 3/14/2018 5:49 PM, Alexander Duyck wrote:
>>>> On Wed, Mar 14, 2018 at 5:13 AM,  <okaya@codeaurora.org> wrote:
>>>>> On 2018-03-14 01:08, Timur Tabi wrote:
>>>>>>
>>>>>> On 3/13/18 10:20 PM, Sinan Kaya wrote:
>>>
>>>> Actually I would argue this whole patch set is pointless. For starters
>>>> why is it we are only updating the Intel Ethernet drivers here?
>>>
>>> I did a regex search for wmb() followed by writel() in each drivers directory.
>>> I scrubbed the ones I care about and posted this series. Note also that
>>> I have one Infiniband patch in the series.
>>
>> I didn't see it as it I was only looking at the patches that had ended
>> up in intel-wired-lan. Also was there a cover page, I couldn't seem to
>> find that on LKML.
>
> Yeah, I didn't have a cover page. These patches were sitting on my branch
> for a while. I wanted to get them out without putting too much effort into
> it. I'll add it on the next version.
>
>>
>>> I considered "ease of change", "popular usage" and "performance critical
>>> path" as the determining criteria for my filtering.
>>
>> It might be advisable to break things up to subsystem or family. So
>> for example if you are going to update the Intel Ethernet drivers I
>> would focus on that and maybe spin the infiniband patch of into a
>> separate set that can be applied to a separate tree. This is something
>> I would consider more of a driver optimization than a fix. In our case
>> it makes it easier for us to maintain the patches to the Intel drivers
>> if you could submit just those to Jeff and Intel-wired-lan so that we
>> can take care of test and review as well as figure out what other
>> drivers will would still need to update in order to handle all the
>> cases involved in this.
>>
>>>> This
>>>> seems like something that is going to impact the whole kernel tree
>>>> since many of us have been writing drivers for some time assuming x86
>>>> style behavior.
>>>
>>> That's true. We used relaxed API heavily on ARM for a long time but
>>> it did not exist on other architectures. For this reason, relaxed
>>> architectures have been paying double penalty in order to use the common
>>> drivers.
>>>
>>> Now that relaxed API is present on all architectures, we can go and scrub
>>> all drivers to see what needs to change and what can remain.
>>
>> My only real objection is that you are going to be having to scrub
>> pretty much ALL the drivers. It seems a little like trying to fix a
>> bad tire on your car by paving the road to match the shape of the
>> tire.
>
> Or we start with mostly used ones and hope to increase the coverage over time.
> It will take a while to cover all drivers.
>
> We could do several iterations like you are suggesting for each subsystem.
>
>>
>>>>
>>>> It doesn't make sense to be optimizing the drivers for one subset of
>>>> architectures. The scope of the work needed to update the drivers for
>>>> this would be ridiculous. Also I don't see how this could be expected
>>>> to work on any other architecture when we pretty much need to have a
>>>> wmb() before calling the writel on x86 to deal with accesses between
>>>> coherent and non-coherent memory. It seems to me more like somebody
>>>> added what they considered to be an optimization somewhere that is a
>>>> workaround for a poorly written driver. Either that or the barrier is
>>>> serving a different purpose then the one we were using.
>>>
>>> Is there a semantic problem with the definition of wmb() vs. writel() vs.
>>> writel_relaxed()? I thought everything is well described in barriers
>>> document about what to expect from these APIs.
>>>
>>> AFAIK, writel() is equal to writel_relaxed() on x86 architecture.
>>> It doesn't really change anything for x86 but it saves barriers on
>>> other architectures.
>>
>> Yeah. I had to go through and do some review since my concerns have
>> been PowerPC, IA64, and x86 historically. From what I can tell all
>> those architectures are setup the same way so that shouldn't be an
>> issue.
>
> OK, glad that we are in common understanding.
>
>>
>>>>
>>>> It would make more sense to put in the effort making writel and
>>>> writel_relaxed consistent between architectures before we go through
>>>> and start modifying driver code to support different architectures.
>>>>
>>>
>>> Is there an arch problem that I'm not seeing?
>>>
>>> Sinan
>>
>> It isn't really an arch problem I have as a logistical one. It just
>> seems like this is really backwards in terms of how this has been
>> handled. For the x86 we have historically had to deal with the
>> barriers for this kind of stuff ourselves, now for ARM and a couple
>> other architectures they seem to have incorporated the barriers into
>> writel and are expecting everyone to move over to writel_relaxed.
>
> You want to move to writel_relaxed() only if you know that your register
> accesses won't have any side effects.
>
> If you require some memory update to be observable to the HW before
> doing a register write, right thing is to do
>
> wmb() + writel_relaxed()
>
> wmb() + writel() is clearly the wrong choice and that's what the goal of
> this change.
>
> If we know that all writel() adaptations in all architectures guarantee
> observability, another option is to get rid of wmb() and just keep writel().
>
> I'm not so convinced about this and hoping that someone will correct me.
>
> wmb() on x86 seems to have an sfence but writel() seems to have a compiler
> barrier in it. So, the type of barrier wmb() is using is different.
>
> we can't say
>
> (wmb()+ writel_relaxed()) == writel()
>
> for all architectures, but maybe I'm wrong.
>
> We really don't want to convert all writel() to writel_relaxed() blindly
> without giving much thought into it.
>
> This was also another reason why I limited the changes to wmb() + writel()
> combinations only.
>
> If there is wmb() + code + writel() and if we convert this to wmb() + code +
> writel_relaxed(), code will not be observed by the HW and this might break
> the driver.

So that is where things will be a bit trickier to understand from the
perspective of someone who hasn't worked in our drivers for a while.

We tend to do something like:
  update tx_buffer_info
  update tx_desc
  wmb()
  point first tx_buffer_info next_to_watch value at last tx_desc
  update next_to_use
  notify device via writel

We do it this way because we have to synchronize between the Tx
cleanup path and the hardware so we basically lump the two barriers
together. instead of invoking both a smp_wmb and a wmb. Now that I
look at the pseudocode though I wonder if we shouldn't move the
next_to_use update before the wmb, but that might be material for
another patch. Anyway, in the Tx cleanup path we should have an
smp_rmb() after we read the next_to_watch values so that we avoid
reading any of the other fields in the buffer_info if either the field
is NULL or the descriptor pointed to has not been written back.

>> It
>> seems like instead of going that route they should have probably just
>> looked at pushing the ARM drivers to something like a "writel_strict"
>> and adopted the behavior of the other architectures for writel.
>>
>> I'll go back through and review. It looks like a number of items were missed.
>>
>
> OK, I'll take a look at each one. Saw the code concern on the e1000e suggestion.
> I wanted to raise it here first before inspecting the rest.

In the case of the Intel drivers it is pretty straightforward as most
of the drivers wrap the writel usage in a macro with the exception of
hot-path areas. In my review feedback I only focused on the tail
updates for the Tx and Rx rings. We have a few other spots where
writel is used to update the interrupt registers but I figure we can
leave those as-is for now as we would want to guarantee ordering of
the tail writes versus the register writes to re-enable the interrupt
for the queue.
