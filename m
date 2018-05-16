Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752407AbeEPJPN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 05:15:13 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33109 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbeEPJPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 05:15:11 -0400
X-Google-Smtp-Source: AB8JxZqo+7BCn3tY25lV+ifdWQ28/6kqiIm57I6Rmwg9Uf16yzP2d6mZXywlcOSP/V6C4kO71zT6E49Kntp/dsravl0=
MIME-Version: 1.0
In-Reply-To: <20180516072202.GV12217@hirez.programming.kicks-ass.net>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
 <20180516044911.28797-4-srinivas.pandruvada@linux.intel.com> <20180516072202.GV12217@hirez.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 May 2018 11:15:09 +0200
X-Google-Sender-Auth: voSa1Q1eTZ7msLEEpHdtJ79oU5U
Message-ID: <CAJZ5v0iaRFO5GWRZAHVWWVMmF8FQps1CowpE5r6zj_tFO7W+jg@mail.gmail.com>
Subject: Re: [RFC/RFT] [PATCH 03/10] cpufreq: intel_pstate: Utility functions
 to boost HWP performance limits
To: Peter Zijlstra <peterz@infradead.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 9:22 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, May 15, 2018 at 09:49:04PM -0700, Srinivas Pandruvada wrote:
>> Setup necessary infrastructure to be able to boost HWP performance on a
>> remote CPU. First initialize data structure to be able to use
>> smp_call_function_single_async(). The boost up function simply set HWP
>> min to HWP max value and EPP to 0. The boost down function simply restores
>> to last cached HWP Request value.
>>
>> To avoid reading HWP Request MSR during dynamic update, the HWP Request
>> MSR value is cached in the local memory. This caching is done whenever
>> HWP request MSR is modified during driver init on in setpolicy() callback
>> path.
>
> The patch does two independent things; best to split that.
>
>
>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
>> index f686bbe..dc7dfa9 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -221,6 +221,9 @@ struct global_params {
>>   *                   preference/bias
>>   * @epp_saved:               Saved EPP/EPB during system suspend or CPU offline
>>   *                   operation
>> + * @hwp_req_cached:  Cached value of the last HWP request MSR
>
> That's simply not true given the code below.

It looks like the last "not boosted EPP" value.

>> @@ -763,6 +768,7 @@ static void intel_pstate_hwp_set(unsigned int cpu)
>>               intel_pstate_set_epb(cpu, epp);
>>       }
>>  skip_epp:
>> +     cpu_data->hwp_req_cached = value;
>>       wrmsrl_on_cpu(cpu, MSR_HWP_REQUEST, value);
>>  }
>>
>> @@ -1381,6 +1387,39 @@ static void intel_pstate_get_cpu_pstates(struct cpudata *cpu)
>>       intel_pstate_set_min_pstate(cpu);
>>  }
>>
>> +
>> +static inline void intel_pstate_hwp_boost_up(struct cpudata *cpu)
>> +{
>> +     u64 hwp_req;
>> +     u8 max;
>> +
>> +     max = (u8) (cpu->hwp_req_cached >> 8);
>> +
>> +     hwp_req = cpu->hwp_req_cached & ~GENMASK_ULL(31, 24);
>> +     hwp_req = (hwp_req & ~GENMASK_ULL(7, 0)) | max;
>> +
>> +     wrmsrl(MSR_HWP_REQUEST, hwp_req);
>> +}
>> +
>> +static inline void intel_pstate_hwp_boost_down(struct cpudata *cpu)
>> +{
>> +     wrmsrl(MSR_HWP_REQUEST, cpu->hwp_req_cached);
>> +}
>
> This is not a traditional msr shadow; that would be updated on every
> wrmsr. There is not a comment in sight explaining why this one is
> different.

So if the "cached" thing is the last "not boosted EPP", that's why it
is not updated here.
