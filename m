Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755269AbeCHMlc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 07:41:32 -0500
Received: from foss.arm.com ([217.140.101.70]:37274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751355AbeCHMl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 07:41:29 -0500
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>, Lina Iyer <ilina@codeaurora.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal: of: Allow selection of thermal governor in DT
To: Amit Kucheria <amit.kucheria@linaro.org>
References: <cover.1520274879.git.amit.kucheria@linaro.org>
 <3b80853abb45a9e067cf7a16754b07bb67712457.1520274879.git.amit.kucheria@linaro.org>
 <6d5aeab8-aafe-fa3b-585e-953a34864e7d@arm.com>
 <CAP245DVwaY84+fZrbne1RLK9gKsfSTE2TELDAC0RkZGMzFkpWg@mail.gmail.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <c80c25a0-46df-7cda-ad77-6a25642a641d@arm.com>
Date: Thu, 8 Mar 2018 12:41:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAP245DVwaY84+fZrbne1RLK9gKsfSTE2TELDAC0RkZGMzFkpWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/03/18 10:59, Amit Kucheria wrote:
> On Tue, Mar 6, 2018 at 6:02 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>>
>>
>> On 05/03/18 18:36, Amit Kucheria wrote:
>>> From: Ram Chandrasekar <rkumbako@codeaurora.org>
>>>
>>> There is currently no way for the governor to be selected for each thermal
>>> zone in devicetree.
>>
>> How is that any different from cpufreq, cpuidle or devfreq subsystems ?
> 
> Cpufreq/cpuidle are designed to control a single parameter while
> thermal framework is trying to mitigate heat from several disparate
> sources that are throttled in different ways. Besides, cpufreq/cpuidle
> have somewhat mature governors. Cpuidle has only one governor (for
> tickless) - menu governor, cpufreq has ondemand in mainline, replaced
> by interactive in android and hopefully soon both will be replaced by
> schedutil.
> 

While I agree on the facts, I don't think adding this information to DT
because thermal governors are not so mature compared to cpufreq/idle is
acceptable. It's give more reason not to add as new governors may get
added as things mature.

> Badly configured cpufreq/cpuidle/devfreq only leads to wasted power,
> while badly configured thermal zone leads to the loss of operation
> e.g. reboots, too hot to touch, etc.
> 

As Viresh pointed out, if the default hardware or firmware configuration
causes that then it's no good platform to use. If adding more
functionality in Linux(like cpufreq and others) causes this then Linux
needs to deal with it. If default thermal can't help in preventing such
damage then it shouldn't be default.

>>> This results in the default governor being used for all
>>> thermal zones even though no such restriction exists in the core code.
>>>
>>
>> What restrictions ?
> 
> I said "no such restriction exists". IOW, the core code does allow the
> governor to be changed.
> 

Ah ok.

>>> Add support for specifying the thermal governor to be used for a thermal
>>> zone in the devicetree.
>>
>> Then what prevents us from doing the same for other subsystems with so
>> called /inefficient default/ governors ?
> 
> Nothing? :-)
> 

Cool problem solved, just kidding.

> It depends on how closely we want the board DT to represent a
> production-ready setup. If a platform maintainer wants to ship a
> well-tested configuration in DT, is that really a problem?
>

You mean configuration + policy ? Then yes policy in DT is no-no.

> If however, you are requiring them to ship magic runes for userspace
> daemons (e.g. per-board thermald config) to tweak the various
> governors in sysfs, it takes a bit more work to get to a
> production-ready setup.
> 

Fair enough.

> We should of course continue to improve our govenors to arrive at the
> one true governor, but that'll take some time and might never even
> happen in the case of thermal IMHO.
> 

I am not sure about "one true governor" as different users have
different needs.

>>> The devicetree config should specify the governor
>>> name as a string that matches any available governors. If not specified, we
>>> maintain the current behaviour of using the default governor.
>>
>> If one is specified, can the user change it from sysfs ? If
>> yes, then why do we need this binding at all ? If no, we are basically
>> restricting, then what would happen if the DT was shipped with wrong
>> governor specified because the firmware author didn't know about any
>> other governor ?
> 
> The governor can be changed from sysfs today. So it is all override-able.
> 
> I guess your main worry is an unmodifiable DT with this option being
> shipped in firmware, right? That is a fair point, though that could be
> worked around from sysfs.
> 

Yes, and Viresh's point triggered more question to me. If DT has some
governor like interactive which will not in mainline or not configure in
the default build what will be done. If in such case default governor is
good enough to boot without burning or any other issues, why not always?

>> IMO, having this in DT is bad idea as it may cause more issues than
>> gain. We already have sysfs support like other PM subsystems and
>> userspace can deal with it.
> 
> As mentioned above, I think thermal is a bit special because bad
> configuration may lead to loss of operation. But iff we're strictly
> enforcing the rule about no policy in board DTs, then I concede.
> 

As I said IMO I see more issues with that, so I don't like it.

> Personally, I'd like mainline board DTs to have enough policy to
> provide a stable system so I don't have to futz around with userspace
> to set it all up correctly (in 3 different distros).
> 

Sysfs is more flexible than DT and requires some fuzzing to get the best
out of the platform if you need.

-- 
Regards,
Sudeep
