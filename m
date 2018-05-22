Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbeEVLnv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 07:43:51 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:43960 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751778AbeEVLmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 07:42:06 -0400
X-Google-Smtp-Source: AB8JxZrEZCYuwbBCyDFtMp1eXGLLmQn1j6yLiIjxzeXD8vOITsMxjT63/C0UCsDwTjwUEazeguf5BtjVj9Av2DMzF3A=
MIME-Version: 1.0
In-Reply-To: <20180522113844.5rz3skjeck57arft@vireshk-i7>
References: <20180518185501.173552-1-joel@joelfernandes.org>
 <4393838.cQWhzXzUcj@aspire.rjw.lan> <20180522105429.yn2omuz63oa2w3ez@vireshk-i7>
 <6163159.YL3rkaEOau@aspire.rjw.lan> <20180522113844.5rz3skjeck57arft@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 22 May 2018 13:42:05 +0200
X-Google-Sender-Auth: KmEsvl0fcCNU3rdcFV0NuFPU_1U
Message-ID: <CAJZ5v0hP+gCiLa+6YvKHaj7u-DuRfmVq_vjFRMj6CnVktJRxVg@mail.gmail.com>
Subject: Re: [PATCH v2] schedutil: Allow cpufreq requests to be made even when
 kthread kicked
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Joel Fernandes (Google.)" <joelaf@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
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

On Tue, May 22, 2018 at 1:38 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 22-05-18, 13:31, Rafael J. Wysocki wrote:
>> So below is my (compiled-only) version of the $subject patch, obviously based
>> on the Joel's work.
>>
>> Roughly, what it does is to move the fast_switch_enabled path entirely to
>> sugov_update_single() and take the spinlock around sugov_update_commit()
>> in the one-CPU case too.
>>
>> ---
>>  kernel/sched/cpufreq_schedutil.c |   57 ++++++++++++++++++++++++++-------------
>>  1 file changed, 38 insertions(+), 19 deletions(-)
>>
>> Index: linux-pm/kernel/sched/cpufreq_schedutil.c
>> ===================================================================
>> --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
>> +++ linux-pm/kernel/sched/cpufreq_schedutil.c
>> @@ -92,9 +92,6 @@ static bool sugov_should_update_freq(str
>>           !cpufreq_can_do_remote_dvfs(sg_policy->policy))
>>               return false;
>>
>> -     if (sg_policy->work_in_progress)
>> -             return false;
>> -
>>       if (unlikely(sg_policy->need_freq_update))
>>               return true;
>>
>> @@ -103,25 +100,25 @@ static bool sugov_should_update_freq(str
>>       return delta_ns >= sg_policy->freq_update_delay_ns;
>>  }
>>
>> -static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
>> -                             unsigned int next_freq)
>> +static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
>> +                                unsigned int next_freq)
>>  {
>> -     struct cpufreq_policy *policy = sg_policy->policy;
>> -
>>       if (sg_policy->next_freq == next_freq)
>> -             return;
>> +             return false;
>>
>>       sg_policy->next_freq = next_freq;
>>       sg_policy->last_freq_update_time = time;
>>
>> -     if (policy->fast_switch_enabled) {
>> -             next_freq = cpufreq_driver_fast_switch(policy, next_freq);
>> -             if (!next_freq)
>> -                     return;
>> +     return true;
>> +}
>>
>> -             policy->cur = next_freq;
>> -             trace_cpu_frequency(next_freq, smp_processor_id());
>> -     } else {
>> +static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
>> +                             unsigned int next_freq)
>> +{
>> +     if (!sugov_update_next_freq(sg_policy, time, next_freq))
>> +             return;
>> +
>> +     if (!sg_policy->work_in_progress) {
>>               sg_policy->work_in_progress = true;
>>               irq_work_queue(&sg_policy->irq_work);
>>       }
>> @@ -277,6 +274,7 @@ static void sugov_update_single(struct u
>>  {
>>       struct sugov_cpu *sg_cpu = container_of(hook, struct sugov_cpu, update_util);
>>       struct sugov_policy *sg_policy = sg_cpu->sg_policy;
>> +     struct cpufreq_policy *policy = sg_policy->policy;
>>       unsigned long util, max;
>>       unsigned int next_f;
>>       bool busy;
>> @@ -307,7 +305,23 @@ static void sugov_update_single(struct u
>>               sg_policy->cached_raw_freq = 0;
>>       }
>>
>> -     sugov_update_commit(sg_policy, time, next_f);
>> +     if (policy->fast_switch_enabled) {
>
> Why do you assume that fast switch isn't possible in shared policy
> cases ? It infact is already enabled for few drivers.

OK, so the fast_switch thing needs to be left outside of the spinlock
in the single case only.  Fair enough.
