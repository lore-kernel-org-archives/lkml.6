Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeBIMQh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:16:37 -0500
Received: from foss.arm.com ([217.140.101.70]:46414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751038AbeBIMQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:16:35 -0500
Subject: Re: [PATCH v2 1/3] sched: Stop nohz stats when decayed
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <morten.rasmussen@foss.arm.com>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <1517944987-343-1-git-send-email-vincent.guittot@linaro.org>
 <1517944987-343-2-git-send-email-vincent.guittot@linaro.org>
 <780a5b3a-4829-4195-c8fd-95da27248a82@arm.com>
 <CAKfTPtC0a1Ku4HxhTKBJFz2bamO+KQL9aCNab=gcd1FeNL1-ww@mail.gmail.com>
 <f9457186-bd80-f97f-dedc-5c15f8183e92@arm.com>
 <CAKfTPtDmjREQLbxd+NSk8Oo8cKV7xfA7Dm6YTudvv2ZsDAX-5w@mail.gmail.com>
From: Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <1827d0e9-523d-9387-9c0a-87b05ed9fcbf@arm.com>
Date: Fri, 9 Feb 2018 12:16:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtDmjREQLbxd+NSk8Oo8cKV7xfA7Dm6YTudvv2ZsDAX-5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2018 11:41 AM, Vincent Guittot wrote:
> On 8 February 2018 at 20:21, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>> On 02/08/2018 01:36 PM, Vincent Guittot wrote:
>>> On 8 February 2018 at 13:46, Valentin Schneider
>>> <valentin.schneider@arm.com> wrote:
>>>> On 02/06/2018 07:23 PM, Vincent Guittot wrote:
>>>>> [...]
> 
>>
>> In summary:
>>
>> 20 iterations per test case
>> All non-mentioned CPUs are idling
>>
>> ---------------------
>> kick_ilb() test case:
>> ---------------------
>>
>> a, b = 100% rt-app tasks
>> - = idling
>>
>> Accumulating load before sleeping
>>         ^
>>         ^
>> CPU1| a a a - - - a
>> CPU2| - - b b b b b
>>               v
>>               v > Periodically kicking ILBs to update nohz blocked load
>>
>> Baseline:
>>     _nohz_idle_balance() takes 39µs in average
>>     nohz_balance_enter_idle() takes 233ns in average
>>
>> W/ cpumask:
>>     _nohz_idle_balance() takes 33µs in average
>>     nohz_balance_enter_idle() takes 283ns in average
>>
>> Diff:
>>     _nohz_idle_balance() -6µs in average (-16%)
>>     nohz_balance_enter_idle() +50ns in average (+21%)
> 
> In your use case, there is no contention when accessing the cpumask.
> Have you tried a use case with tasks that wake ups and go back to idle
> simultaneously on several/all cpus so they will fight to update the
> atomic resources ?
> That would be interesting to see the impact on the runtime of the
> nohz_balance_enter_idle function

No, I haven't tried that yet. For now these tests picture the "best case" 
scenario since all but one CPU is idle. I've been meaning to test busier
scenarios - I'll give your idle/sleep storm a try, thanks for the suggestion.

I also need to work on a test case for the load_balance() call in
idle_balance(). As Peter mentioned, the clearing of has_blocked in 
update_sd_lb_stats() can only be done with atomic ops, so that's another 
thing to profile against the baseline.
