Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751666AbeCOCRt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 22:17:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50226 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbeCOCRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 22:17:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 358DC60316
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH 7/7] ixgbevf: eliminate duplicate barriers on
 weakly-ordered archs
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Timur Tabi <timur@codeaurora.org>, Netdev <netdev@vger.kernel.org>,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1520997629-17361-1-git-send-email-okaya@codeaurora.org>
 <1520997629-17361-7-git-send-email-okaya@codeaurora.org>
 <12150aa0-77ba-878e-31f4-d4f8d6a28ccb@codeaurora.org>
 <2a4f4dec64b7462ae64152f6c2df9754@codeaurora.org>
 <CAKgT0UcriMiyV0q6y_x9r3-HJRAWp5_CpsK2jTqh3qvOV=Kkzw@mail.gmail.com>
 <d565406d-1bc7-6fb0-3f36-87a28ac69070@codeaurora.org>
 <CAKgT0UeBHGDmr0uXfuPQJKOomiH9uvXRVYpyDwMOzjkxAZMSYg@mail.gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <53bf7dfe-32ee-1861-e6ea-81f667590a43@codeaurora.org>
Date: Wed, 14 Mar 2018 22:17:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKgT0UeBHGDmr0uXfuPQJKOomiH9uvXRVYpyDwMOzjkxAZMSYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/2018 9:44 PM, Alexander Duyck wrote:
> On Wed, Mar 14, 2018 at 3:57 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>> Hi Alexander,
>>
>> On 3/14/2018 5:49 PM, Alexander Duyck wrote:
>>> On Wed, Mar 14, 2018 at 5:13 AM,  <okaya@codeaurora.org> wrote:
>>>> On 2018-03-14 01:08, Timur Tabi wrote:
>>>>>
>>>>> On 3/13/18 10:20 PM, Sinan Kaya wrote:
>>
>>> Actually I would argue this whole patch set is pointless. For starters
>>> why is it we are only updating the Intel Ethernet drivers here?
>>
>> I did a regex search for wmb() followed by writel() in each drivers directory.
>> I scrubbed the ones I care about and posted this series. Note also that
>> I have one Infiniband patch in the series.
> 
> I didn't see it as it I was only looking at the patches that had ended
> up in intel-wired-lan. Also was there a cover page, I couldn't seem to
> find that on LKML.

Yeah, I didn't have a cover page. These patches were sitting on my branch
for a while. I wanted to get them out without putting too much effort into
it. I'll add it on the next version.

> 
>> I considered "ease of change", "popular usage" and "performance critical
>> path" as the determining criteria for my filtering.
> 
> It might be advisable to break things up to subsystem or family. So
> for example if you are going to update the Intel Ethernet drivers I
> would focus on that and maybe spin the infiniband patch of into a
> separate set that can be applied to a separate tree. This is something
> I would consider more of a driver optimization than a fix. In our case
> it makes it easier for us to maintain the patches to the Intel drivers
> if you could submit just those to Jeff and Intel-wired-lan so that we
> can take care of test and review as well as figure out what other
> drivers will would still need to update in order to handle all the
> cases involved in this.
> 
>>> This
>>> seems like something that is going to impact the whole kernel tree
>>> since many of us have been writing drivers for some time assuming x86
>>> style behavior.
>>
>> That's true. We used relaxed API heavily on ARM for a long time but
>> it did not exist on other architectures. For this reason, relaxed
>> architectures have been paying double penalty in order to use the common
>> drivers.
>>
>> Now that relaxed API is present on all architectures, we can go and scrub
>> all drivers to see what needs to change and what can remain.
> 
> My only real objection is that you are going to be having to scrub
> pretty much ALL the drivers. It seems a little like trying to fix a
> bad tire on your car by paving the road to match the shape of the
> tire.

Or we start with mostly used ones and hope to increase the coverage over time.
It will take a while to cover all drivers.

We could do several iterations like you are suggesting for each subsystem.

> 
>>>
>>> It doesn't make sense to be optimizing the drivers for one subset of
>>> architectures. The scope of the work needed to update the drivers for
>>> this would be ridiculous. Also I don't see how this could be expected
>>> to work on any other architecture when we pretty much need to have a
>>> wmb() before calling the writel on x86 to deal with accesses between
>>> coherent and non-coherent memory. It seems to me more like somebody
>>> added what they considered to be an optimization somewhere that is a
>>> workaround for a poorly written driver. Either that or the barrier is
>>> serving a different purpose then the one we were using.
>>
>> Is there a semantic problem with the definition of wmb() vs. writel() vs.
>> writel_relaxed()? I thought everything is well described in barriers
>> document about what to expect from these APIs.
>>
>> AFAIK, writel() is equal to writel_relaxed() on x86 architecture.
>> It doesn't really change anything for x86 but it saves barriers on
>> other architectures.
> 
> Yeah. I had to go through and do some review since my concerns have
> been PowerPC, IA64, and x86 historically. From what I can tell all
> those architectures are setup the same way so that shouldn't be an
> issue.

OK, glad that we are in common understanding.

> 
>>>
>>> It would make more sense to put in the effort making writel and
>>> writel_relaxed consistent between architectures before we go through
>>> and start modifying driver code to support different architectures.
>>>
>>
>> Is there an arch problem that I'm not seeing?
>>
>> Sinan
> 
> It isn't really an arch problem I have as a logistical one. It just
> seems like this is really backwards in terms of how this has been
> handled. For the x86 we have historically had to deal with the
> barriers for this kind of stuff ourselves, now for ARM and a couple
> other architectures they seem to have incorporated the barriers into
> writel and are expecting everyone to move over to writel_relaxed. 

You want to move to writel_relaxed() only if you know that your register
accesses won't have any side effects. 

If you require some memory update to be observable to the HW before
doing a register write, right thing is to do 

wmb() + writel_relaxed()

wmb() + writel() is clearly the wrong choice and that's what the goal of
this change.

If we know that all writel() adaptations in all architectures guarantee
observability, another option is to get rid of wmb() and just keep writel().

I'm not so convinced about this and hoping that someone will correct me. 

wmb() on x86 seems to have an sfence but writel() seems to have a compiler
barrier in it. So, the type of barrier wmb() is using is different. 

we can't say

(wmb()+ writel_relaxed()) == writel()

for all architectures, but maybe I'm wrong.

We really don't want to convert all writel() to writel_relaxed() blindly
without giving much thought into it.

This was also another reason why I limited the changes to wmb() + writel()
combinations only.

If there is wmb() + code + writel() and if we convert this to wmb() + code +
writel_relaxed(), code will not be observed by the HW and this might break
the driver.

> It
> seems like instead of going that route they should have probably just
> looked at pushing the ARM drivers to something like a "writel_strict"
> and adopted the behavior of the other architectures for writel.
> 
> I'll go back through and review. It looks like a number of items were missed.
> 

OK, I'll take a look at each one. Saw the code concern on the e1000e suggestion.
I wanted to raise it here first before inspecting the rest.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
