Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbeEVQPk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 12:15:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:27014 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeEVQPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 12:15:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="230694845"
Subject: Re: [RFC] perf: Allow fine-grained PMU access control
To: Peter Zijlstra <peterz@infradead.org>,
        Tvrtko Ursulin <tursulin@ursulin.net>
Cc: linux-kernel@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20180521092549.5349-1-tvrtko.ursulin@linux.intel.com>
 <20180522090527.GP12198@hirez.programming.kicks-ass.net>
 <017c4a20-b597-9c0e-4cf3-c0fd1d7bf3d7@ursulin.net>
 <20180522123213.GR12198@hirez.programming.kicks-ass.net>
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Message-ID: <32b85afb-34f6-7ffd-360e-7abc1d38dad5@linux.intel.com>
Date: Tue, 22 May 2018 17:15:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180522123213.GR12198@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/05/2018 13:32, Peter Zijlstra wrote:
> On Tue, May 22, 2018 at 10:29:29AM +0100, Tvrtko Ursulin wrote:
>>
>> On 22/05/18 10:05, Peter Zijlstra wrote:
>>> On Mon, May 21, 2018 at 10:25:49AM +0100, Tvrtko Ursulin wrote:
>>>> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>>>>
>>>> For situations where sysadmins might want to allow different level of
>>>> of access control for different PMUs, we start creating per-PMU
>>>> perf_event_paranoid controls in sysfs.
>>>
>>> Could you explain how exactly this makes sense?
>>>
>>> For example, how does it make sense for one PMU to reveal kernel data
>>> while another PMU is not allowed.
>>>
>>> Once you allow one PMU to do so, the secret is out.
>>>
>>> So please explain, in excruciating detail, how you want to use this and
>>> how exactly that makes sense from a security pov.
>>
>> Not sure it will be excruciating but will try to explain once again.
>>
>> There are two things:
>>
>> 1. i915 PMU which exports data such as different engine busyness levels.
>> (Perhaps you remember, you helped us implement this from the perf API
>> angle.)
> 
> Right, but I completely forgot everything again.. So thanks for
> reminding.
> 
>> 2. Customers who want to look at those stats in production.
>>
>> They want to use it to answer questions such as:
>>
>> a) How loaded is my server and can it take one more of X type of job?
>> b) What is the least utilised video engine to submit the next packet of work
>> to?
>> c) What is the least utilised server to schedule the next transcoding job
>> on?
> 
> On the other hand, do those counters provide enough information for a
> side-channel (timing) attack on GPGPU workloads? Because, as you say, it
> is a shared resource. So if user A is doing GPGPU crypto, and user B is
> observing, might he infer things from the counters?

This question would need to be looked at by security experts. And maybe 
it would be best to spawn off that effort separately. Because for me the 
most important question here is whether adding per PMU access control 
makes security worse, better, or is neutral? At the moment I cannot see 
that it makes anything worse, since the real-world alternative is to 
turn all security off. Enabling sysadmins to only relax access to a 
subset of PMU's I think can at worst be neutral. And if it is not 
possible to side-channel everything from anything, then it should be 
better overall security.

In terms of what metrics i915 PMU exposes the current list is this:

1. GPU global counters
1.1 Driver requested frequency and actual GPU frequency
1.2 Time spent in RC6 state
1.3 Interrupt count

2. Per GPU engine counters
2.1 Time spent engine was executing something
2.2 Time spent engine was waiting on semaphores
2.3 Time spent engine was waiting on sync events

In the future we are also considering:

2.4 Number of requests queued / runnable / running

>> Current option for them is to turn off the global paranoid setting which
>> then enables unprivileged access to _all_ PMU providers.
> 
> Right.
> 
>> To me it sounded quite logical that it would be better for the paranoid knob
>> to be more fine-grained, so that they can configure their servers so only
>> access to needed data is possible.
> 
> The proposed semantics are a tad awkward though, the moment you prod at
> the sysctl you loose all individual PMU settings. Ideally the per-pmu
> would have a special setting that says follow-global in addition to the
> existing ones.

Hmm.. possibly follow global makes sense for some use cases, but also I 
do not at the moment see awkwardness in the proposed semantics. The 
master knob should be only touched by sysadmins so any override of 
individual settings is a top-level decision, together will all the 
sub-controls, which is as it should be. If we had follow global, I 
suspect we would still need to have top-level override so it is 
basically a discussion on the richness of the controls.

>> I am not sure what do you mean by "Once you allow one PMU to do so, the
>> secret is out."? What secret? Are you implying that enabling unprivileged
>> access to i915 engine busyness data opens up access to CPU PMU's as well via
>> some side channel?
> 
> It was not i915 specific; but if you look at the descriptions:
> 
>   * perf event paranoia level:
>   *  -1 - not paranoid at all
>   *   0 - disallow raw tracepoint access for unpriv
>   *   1 - disallow cpu events for unpriv
>   *   2 - disallow kernel profiling for unpriv
> 
> Then the moment you allow some data to escape, it cannot be put back.
> i915 is fairly special in that (afaict) it doesn't leak kernel specific
> data
> 
> In general I think allowing access to uncore PMUs will leak kernel data.
> Thus in general I'm fairly wary of all this.

Yeah, I guess I don't follow this argument since I am not relaxing any 
security criteria. Just adding ability to apply the existing scale per 
individual PMU provider.

> Is there no other way to expose this information? Can't we do a
> traditional load-avg like thing for the GPU?

We of course could expose the same data in sysfs, or somewhere, and then 
control access to it via the filesystem, but we wanted to avoid 
duplication. Since we picked to export via PMU, ideally we would like to 
maintain only one mechanism to export the same set data.

Also perf uAPI is pretty handy to use from userspace, where you can read 
all the interesting counters in one go together with a matching timestamp.

Furthermore I do not see how that would make a difference security wise? 
If the concern is exposing i915 PMU data to unprivileged users (via 
explicit sysadmin action!), then the mechanism of exposure shouldn't be 
important.

The argument may be that the proposed fine-grained control are 
uninteresting for all other PMU providers, so it is undesirable to 
burden the perf core with extra code, which I would understand.

Regards,

Tvrtko
