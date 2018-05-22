Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeEVJ3f (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 05:29:35 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39363 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeEVJ3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 05:29:32 -0400
X-Google-Smtp-Source: AB8JxZonbx4iSLsiRHJeoMpxJNNVJTk4Iu+Qnx/am8fNfUm3MfN1OoHswlKs4zGTYbQ9HHA2/HnD3w==
Subject: Re: [RFC] perf: Allow fine-grained PMU access control
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
References: <20180521092549.5349-1-tvrtko.ursulin@linux.intel.com>
 <20180522090527.GP12198@hirez.programming.kicks-ass.net>
From: Tvrtko Ursulin <tursulin@ursulin.net>
Message-ID: <017c4a20-b597-9c0e-4cf3-c0fd1d7bf3d7@ursulin.net>
Date: Tue, 22 May 2018 10:29:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180522090527.GP12198@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 22/05/18 10:05, Peter Zijlstra wrote:
> On Mon, May 21, 2018 at 10:25:49AM +0100, Tvrtko Ursulin wrote:
>> From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>>
>> For situations where sysadmins might want to allow different level of
>> of access control for different PMUs, we start creating per-PMU
>> perf_event_paranoid controls in sysfs.
> 
> Could you explain how exactly this makes sense?
> 
> For example, how does it make sense for one PMU to reveal kernel data
> while another PMU is not allowed.
> 
> Once you allow one PMU to do so, the secret is out.
> 
> So please explain, in excruciating detail, how you want to use this and
> how exactly that makes sense from a security pov.

Not sure it will be excruciating but will try to explain once again.

There are two things:

1. i915 PMU which exports data such as different engine busyness levels. 
(Perhaps you remember, you helped us implement this from the perf API 
angle.)

2. Customers who want to look at those stats in production.

They want to use it to answer questions such as:

a) How loaded is my server and can it take one more of X type of job?
b) What is the least utilised video engine to submit the next packet of 
work to?
c) What is the least utilised server to schedule the next transcoding 
job on?

Current option for them is to turn off the global paranoid setting which 
then enables unprivileged access to _all_ PMU providers.

To me it sounded quite logical that it would be better for the paranoid 
knob to be more fine-grained, so that they can configure their servers 
so only access to needed data is possible.

I am not sure what do you mean by "Once you allow one PMU to do so, the 
secret is out."? What secret? Are you implying that enabling 
unprivileged access to i915 engine busyness data opens up access to CPU 
PMU's as well via some side channel?

Regards,

Tvrtko

>> These work in equivalent fashion as the existing perf_event_paranoid
>> sysctl, which now becomes the parent control for each PMU.
>>
>> On PMU registration the global/parent value will be inherited by each PMU,
>> as it will be propagated to all registered PMUs when the sysctl is
>> updated.
>>
>> At any later point individual PMU access controls, located in
>> <sysfs>/device/<pmu-name>/perf_event_paranoid, can be adjusted to achieve
>> fine grained access control.
>>
> 
