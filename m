Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753174AbeA3PZb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 10:25:31 -0500
Received: from mga05.intel.com ([192.55.52.43]:23190 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753083AbeA3PZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 10:25:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,435,1511856000";
   d="scan'208";a="14168210"
Subject: Re: [PATCH V3 0/5] bugs fix for large PEBS mmap read and rdpmc read
To: Jiri Olsa <jolsa@redhat.com>
Cc: Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@linux.intel.com>
References: <1517243373-355481-1-git-send-email-kan.liang@linux.intel.com>
 <CABPqkBRjQp62ArVZzuH=TRU3mDPkS93D8_cNev6M=eXTCpBLkA@mail.gmail.com>
 <20180130133917.GC29098@krava>
 <6d708c09-52a7-a906-b651-b133a7b4f189@linux.intel.com>
 <20180130150454.GE29098@krava>
From: "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <35090c62-466a-aec8-b1a3-69def959c1c6@linux.intel.com>
Date: Tue, 30 Jan 2018 10:25:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180130150454.GE29098@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/30/2018 10:04 AM, Jiri Olsa wrote:
> On Tue, Jan 30, 2018 at 09:59:15AM -0500, Liang, Kan wrote:
>>
>>
>> On 1/30/2018 8:39 AM, Jiri Olsa wrote:
>>> On Tue, Jan 30, 2018 at 01:16:39AM -0800, Stephane Eranian wrote:
>>>> Hi,
>>>>
>>>> On Mon, Jan 29, 2018 at 8:29 AM, <kan.liang@linux.intel.com> wrote:
>>>>>
>>>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>>>
>>>>> ------
>>>>>
>>>>> Changes since V2:
>>>>>    - Refined the changelog
>>>>>    - Introduced specific read function for large PEBS.
>>>>>      The previous generic PEBS read function is confusing.
>>>>>      Disabled PMU in pmu::read() path for large PEBS.
>>>>>      Handled the corner case when reload_times == 0.
>>>>>    - Modified the parameter of intel_pmu_save_and_restart_reload()
>>>>>      Discarded local64_cmpxchg
>>>>>    - Added fixes tag
>>>>>    - Added WARN to handle reload_times == 0 || reload_val == 0
>>>>>
>>>>> Changes since V1:
>>>>>    - Check PERF_X86_EVENT_AUTO_RELOAD before call
>>>>>      intel_pmu_save_and_restore()
>>>>
>>>> It is not yet clear to me why PERF_SAMPLE_PERIOD is not allowed
>>>> with large PEBS. Large PEBS requires fixed period. So the kernel could
>>>> make up the period from the event and store it in the sampling buffer.
>>>>
>>>> I tried using large PEBS recently, and despite trying different option
>>>> combination of perf record, I was not able to get it to work.
>>>>
>>>> $ perf record  -c 1  -e cpu/event=0xd1,umask=0x10,period=19936/pp
>>>> --no-timestamp --no-period -a -C 0
>>>>
>>>> But I was able to make this work with a much older kernel.
>>>>
>>>> Another annoyance I ran into is with perf record requiring -c period
>>>> in order not to set
>>>> PERF_SAMPLE_PERIOD in the event.
>>>>
>>>> If I do:
>>>> perf record  -c 1  -e cpu/event=0xd1,umask=0x10,period=19936/pp
>>>> --no-timestamp --no-period -a -C 0
>>>>
>>>> I get
>>>>
>>>> perf_event_attr:
>>>>     type                             4
>>>>     size                             112
>>>>     config                           0x10d1
>>>>     { sample_period, sample_freq }   199936
>>>>     sample_type                      IP|TID|CPU
>>>>
>>>> But if I do:
>>>> perf record  -e cpu/event=0xd1,umask=0x10,period=19936/pp
>>>> --no-timestamp --no-period -a -C 0
>>>>
>>>> I get
>>>>
>>>> perf_event_attr:
>>>>     type                             4
>>>>     size                             112
>>>>     config                           0x10d1
>>>>     { sample_period, sample_freq }   199936
>>>>     sample_type                      IP|TID|CPU|PERIOD
>>>>
>>>> Perf should check if all events have a period=, then it should not
>>>> pass PERF_SAMPLE_PERIOD, even
>>>> more so when only one event is defined.
>>>>
>>>> Also it does not seem to honor --no-period.
>>>
>>> yep, there's a bug in period=x term handling
>>> we did not re/set the sample_type based on that
>>>
>>> attached patch fixes that for me, also takes into account
>>> the --no/-period options
>>>
>>> jirka
>>>
>>>
>>> ---
>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>> index f251e824edac..907267206973 100644
>>> --- a/tools/perf/builtin-record.c
>>> +++ b/tools/perf/builtin-record.c
>>> @@ -1566,7 +1566,8 @@ static struct option __record_options[] = {
>>>    	OPT_BOOLEAN_SET('T', "timestamp", &record.opts.sample_time,
>>>    			&record.opts.sample_time_set,
>>>    			"Record the sample timestamps"),
>>> -	OPT_BOOLEAN('P', "period", &record.opts.period, "Record the sample period"),
>>> +	OPT_BOOLEAN_SET('P', "period", &record.opts.period, &record.opts.period_set,
>>> +			"Record the sample period"),
>>>    	OPT_BOOLEAN('n', "no-samples", &record.opts.no_samples,
>>>    		    "don't sample"),
>>>    	OPT_BOOLEAN_SET('N', "no-buildid-cache", &record.no_buildid_cache,
>>> diff --git a/tools/perf/perf.h b/tools/perf/perf.h
>>> index 2357f4ccc9c7..cfe46236a5e5 100644
>>> --- a/tools/perf/perf.h
>>> +++ b/tools/perf/perf.h
>>> @@ -50,6 +50,7 @@ struct record_opts {
>>>    	bool	     sample_time_set;
>>>    	bool	     sample_cpu;
>>>    	bool	     period;
>>> +	bool	     period_set;
>>>    	bool	     running_time;
>>>    	bool	     full_auxtrace;
>>>    	bool	     auxtrace_snapshot_mode;
>>> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
>>> index 66fa45198a11..ff359c9ece2e 100644
>>> --- a/tools/perf/util/evsel.c
>>> +++ b/tools/perf/util/evsel.c
>>> @@ -745,12 +745,14 @@ static void apply_config_terms(struct perf_evsel *evsel,
>>>    			if (!(term->weak && opts->user_interval != ULLONG_MAX)) {
>>>    				attr->sample_period = term->val.period;
>>>    				attr->freq = 0;
>>> +				perf_evsel__reset_sample_bit(evsel, PERIOD);
>>>    			}
>>>    			break;
>>>    		case PERF_EVSEL__CONFIG_TERM_FREQ:
>>>    			if (!(term->weak && opts->user_freq != UINT_MAX)) {
>>>    				attr->sample_freq = term->val.freq;
>>>    				attr->freq = 1;
>>> +				perf_evsel__set_sample_bit(evsel, PERIOD);
>>>    			}
>>
>> If we do so, some events could be in fixed mode without PERIOD set. Other
>> events could be in freq mode with PERIOD set.
> 
> it also sets the attr->freq, so it's not in fixed mode
> 

I mean the TERM_PERIOD. It probably enable the large PEBS.
 >>>    				attr->freq = 0;
 >>> +				perf_evsel__reset_sample_bit(evsel, PERIOD);

The events in fixed mode could enable large PEBS. Events in freq mode 
should not enable large PEBS.
I think that could be a problem if some events try to enable large PEBS, 
while others not.

Thanks,
Kan
