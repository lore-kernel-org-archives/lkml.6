Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752451AbeERVRJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 17:17:09 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41659 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752224AbeERVRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 17:17:06 -0400
X-Google-Smtp-Source: AB8JxZqbjffvH5yFnUkewsoH0cbisB98bDYo5o/pMTH7TpvCmk5xYxgQW/pzltHgayKA4SfsyMgSEtkuTsJO03RHE3k=
MIME-Version: 1.0
In-Reply-To: <5AFF41F9.6050300@codeaurora.org>
References: <20180518185501.173552-1-joel@joelfernandes.org> <5AFF41F9.6050300@codeaurora.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 18 May 2018 23:17:05 +0200
X-Google-Sender-Auth: H7RneGRbFoVbYkmaswkne1u3NQ4
Message-ID: <CAJZ5v0hG7Y7=nFZfhZzNF0C+g4MUj85PUG8YohCvtSLL7VqPNA@mail.gmail.com>
Subject: Re: [PATCH v2] schedutil: Allow cpufreq requests to be made even when
 kthread kicked
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Joel Fernandes (Google.)" <joelaf@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>, Todd Kjos <tkjos@google.com>,
        Claudio Scordino <claudio@evidence.eu.com>, kernel-team@android.com,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 11:13 PM, Saravana Kannan
<skannan@codeaurora.org> wrote:
> On 05/18/2018 11:55 AM, Joel Fernandes (Google.) wrote:
>>
>> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
>>
>> Currently there is a chance of a schedutil cpufreq update request to be
>> dropped if there is a pending update request. This pending request can
>> be delayed if there is a scheduling delay of the irq_work and the wake
>> up of the schedutil governor kthread.
>>
>> A very bad scenario is when a schedutil request was already just made,
>> such as to reduce the CPU frequency, then a newer request to increase
>> CPU frequency (even sched deadline urgent frequency increase requests)
>> can be dropped, even though the rate limits suggest that its Ok to
>> process a request. This is because of the way the work_in_progress flag
>> is used.
>>
>> This patch improves the situation by allowing new requests to happen
>> even though the old one is still being processed. Note that in this
>> approach, if an irq_work was already issued, we just update next_freq
>> and don't bother to queue another request so there's no extra work being
>> done to make this happen.
>>
>> I had brought up this issue at the OSPM conference and Claudio had a
>> discussion RFC with an alternate approach [1]. I prefer the approach as
>> done in the patch below since it doesn't need any new flags and doesn't
>> cause any other extra overhead.
>>
>> [1] https://patchwork.kernel.org/patch/10384261/
>>
>> LGTMed-by: Viresh Kumar <viresh.kumar@linaro.org>
>> LGTMed-by: Juri Lelli <juri.lelli@redhat.com>
>> CC: Viresh Kumar <viresh.kumar@linaro.org>
>> CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> CC: Peter Zijlstra <peterz@infradead.org>
>> CC: Ingo Molnar <mingo@redhat.com>
>> CC: Patrick Bellasi <patrick.bellasi@arm.com>
>> CC: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Luca Abeni <luca.abeni@santannapisa.it>
>> CC: Joel Fernandes <joelaf@google.com>
>> CC: Todd Kjos <tkjos@google.com>
>> CC: claudio@evidence.eu.com
>> CC: kernel-team@android.com
>> CC: linux-pm@vger.kernel.org
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> ---
>> v1 -> v2: Minor style related changes.
>>
>>   kernel/sched/cpufreq_schedutil.c | 34 ++++++++++++++++++++++++--------
>>   1 file changed, 26 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/sched/cpufreq_schedutil.c
>> b/kernel/sched/cpufreq_schedutil.c
>> index e13df951aca7..5c482ec38610 100644
>> --- a/kernel/sched/cpufreq_schedutil.c
>> +++ b/kernel/sched/cpufreq_schedutil.c
>> @@ -92,9 +92,6 @@ static bool sugov_should_update_freq(struct sugov_policy
>> *sg_policy, u64 time)
>>             !cpufreq_can_do_remote_dvfs(sg_policy->policy))
>>                 return false;
>>
>> -       if (sg_policy->work_in_progress)
>> -               return false;
>> -
>>         if (unlikely(sg_policy->need_freq_update)) {
>>                 sg_policy->need_freq_update = false;
>>                 /*
>> @@ -128,7 +125,7 @@ static void sugov_update_commit(struct sugov_policy
>> *sg_policy, u64 time,
>>
>>                 policy->cur = next_freq;
>>                 trace_cpu_frequency(next_freq, smp_processor_id());
>> -       } else {
>> +       } else if (!sg_policy->work_in_progress) {
>
>
> Not really something you added, but if you are modifying it:
> Do we really need this work_in_progress flag? irq_work_queue() already
> checks if the work is pending and then returns true/false.
>
> Wouldn't the issue you are trying to fix be resolved just by dropping this
> flag check entirely?

You've missed the entire discussion on that several days ago, sorry.

Thanks,
Rafael
