Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751740AbeDXTSn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 15:18:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:8369 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750766AbeDXTSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 15:18:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,324,1520924400";
   d="scan'208";a="223046917"
Subject: Re: [PATCH 5/5] perf stat: Fix duplicate PMU name for interval print
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: mingo@redhat.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, namhyung@kernel.org, ganapatrao.kulkarni@cavium.com,
        zhangshaokun@hisilicon.com, yao.jin@linux.intel.com,
        will.deacon@arm.com, ak@linux.intel.com, agustinv@codeaurora.org
References: <1524594014-79243-1-git-send-email-kan.liang@linux.intel.com>
 <1524594014-79243-5-git-send-email-kan.liang@linux.intel.com>
 <20180424185334.GA4427@kernel.org>
From: "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <2965045c-a6b2-6ec7-26c4-9b1fdabee791@linux.intel.com>
Date: Tue, 24 Apr 2018 15:18:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180424185334.GA4427@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/2018 2:53 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Apr 24, 2018 at 11:20:14AM -0700, kan.liang@linux.intel.com escreveu:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> PMU name is printed repeatedly for interval print, for example:
>>
>>    perf stat --no-merge -e 'unc_m_clockticks' -a -I 1000
>>    #           time             counts unit events
>>       1.001053069        243,702,144      unc_m_clockticks [uncore_imc_4]
>>       1.001053069        244,268,304      unc_m_clockticks [uncore_imc_2]
>>       1.001053069        244,427,386      unc_m_clockticks [uncore_imc_0]
>>       1.001053069        244,583,760      unc_m_clockticks [uncore_imc_5]
>>       1.001053069        244,738,971      unc_m_clockticks [uncore_imc_3]
>>       1.001053069        244,880,309      unc_m_clockticks [uncore_imc_1]
>>       2.002024821        240,818,200      unc_m_clockticks [uncore_imc_4] [uncore_imc_4]
>>       2.002024821        240,767,812      unc_m_clockticks [uncore_imc_2] [uncore_imc_2]
>>       2.002024821        240,764,215      unc_m_clockticks [uncore_imc_0] [uncore_imc_0]
>>       2.002024821        240,759,504      unc_m_clockticks [uncore_imc_5] [uncore_imc_5]
>>       2.002024821        240,755,992      unc_m_clockticks [uncore_imc_3] [uncore_imc_3]
>>       2.002024821        240,750,403      unc_m_clockticks [uncore_imc_1] [uncore_imc_1]
>>
>> For each print, the PMU name is unconditionally appended to the
>> counter->name.
>> Need to check the counter->name first. If the PMU name is already
>> appended, do nothing.
>>
>> Fixes: 8c5421c016a4 ("perf pmu: Display pmu name when printing unmerged events in stat")
>> +++ b/tools/perf/builtin-stat.c
>> @@ -1296,6 +1296,8 @@ static void uniquify_event_name(struct perf_evsel *counter)
>>   			counter->name = new_name;
>>   		}
>>   	} else {
>> +		if (strstr(counter->name, counter->pmu_name))
>> +			return;
>>   		if (asprintf(&new_name,
>>   			     "%s [%s]", counter->name, counter->pmu_name) > 0) {
>>   			free(counter->name);
> 
> Humm, do you have any problem with the patch below instead?

No. The patch as below looks good to me.

Thanks,
Kan

> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 2137c7d11767..8518342c5466 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1261,7 +1261,8 @@ static void uniquify_event_name(struct perf_evsel *counter)
>   	char *new_name;
>   	char *config;
>   
> -	if (!counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
> +	if (counter->uniquified_name ||
> +	    !counter->pmu_name || !strncmp(counter->name, counter->pmu_name,
>   					   strlen(counter->pmu_name)))
>   		return;
>   
> @@ -1279,6 +1280,8 @@ static void uniquify_event_name(struct perf_evsel *counter)
>   			counter->name = new_name;
>   		}
>   	}
> +
> +	counter->uniquified_name = true;
>   }
>   
>   static void collect_all_aliases(struct perf_evsel *counter,
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index d3ee3af618ef..92ec009a292d 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -115,6 +115,7 @@ struct perf_evsel {
>   	unsigned int		sample_size;
>   	int			id_pos;
>   	int			is_pos;
> +	bool			uniquified_name;
>   	bool			snapshot;
>   	bool 			supported;
>   	bool 			needs_swap;
> 
