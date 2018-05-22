Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751371AbeEVNBg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 09:01:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:16359 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751192AbeEVNBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 09:01:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="42982223"
Subject: Re: [RFC] perf: Allow fine-grained PMU access control
To: Peter Zijlstra <peterz@infradead.org>,
        Tvrtko Ursulin <tursulin@ursulin.net>
Cc: linux-kernel@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
References: <20180521092549.5349-1-tvrtko.ursulin@linux.intel.com>
 <20180522090527.GP12198@hirez.programming.kicks-ass.net>
 <017c4a20-b597-9c0e-4cf3-c0fd1d7bf3d7@ursulin.net>
 <20180522123213.GR12198@hirez.programming.kicks-ass.net>
From: Alexey Budankov <alexey.budankov@linux.intel.com>
Message-ID: <88a005e3-e090-33c1-0107-5c04a4d8f97f@linux.intel.com>
Date: Tue, 22 May 2018 16:01:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180522123213.GR12198@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On 22.05.2018 15:32, Peter Zijlstra wrote:
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
> 
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
> 
>> I am not sure what do you mean by "Once you allow one PMU to do so, the
>> secret is out."? What secret? Are you implying that enabling unprivileged
>> access to i915 engine busyness data opens up access to CPU PMU's as well via
>> some side channel?
> 
> It was not i915 specific; but if you look at the descriptions:
> 
>  * perf event paranoia level:
>  *  -1 - not paranoid at all
>  *   0 - disallow raw tracepoint access for unpriv
>  *   1 - disallow cpu events for unpriv
>  *   2 - disallow kernel profiling for unpriv
> 
> Then the moment you allow some data to escape, it cannot be put back.
> i915 is fairly special in that (afaict) it doesn't leak kernel specific
> data
> 
> In general I think allowing access to uncore PMUs will leak kernel data.

IMHO, it is unsafe for CBOX pmu but could IMC, UPI pmus be an exception here?
Because currently perf stat -I from IMC, UPI counters is only allowed when 
system wide monitoring is permitted and this prevents joint perf record and 
perf stat -I in cluster environments where users usually lack ability to 
modify paranoid. Adding Andi who may have more ideas regarding all that.

> Thus in general I'm fairly wary of all this.

Second this. Extra care is required here so some security related folks 
need to be involved into the discussion.

> 
> Is there no other way to expose this information? Can't we do a
> traditional load-avg like thing for the GPU?
> 

Thanks,
Alexey
