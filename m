Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeECLj2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 07:39:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:3772 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751185AbeECLj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 07:39:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="36559215"
Subject: Re: [PATCH 05/12] perf pmu: Fix pmu events parsing rule
To: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20180425160008.3407-1-acme@kernel.org>
 <20180425160008.3407-6-acme@kernel.org>
 <448c4e21-8232-3d04-cac4-49b95c8bca3a@intel.com>
 <20180503103717.GA14776@krava>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <0c33d3f9-4b76-c94c-7306-e93e8cd8d4aa@intel.com>
Date: Thu, 3 May 2018 14:38:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180503103717.GA14776@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/18 13:37, Jiri Olsa wrote:
> On Thu, May 03, 2018 at 11:25:16AM +0300, Adrian Hunter wrote:
>> Hi
>>
>> This breaks Intel PT i.e.
>>
>> $ perf record -e intel_pt//u uname
>> event syntax error: 'intel_pt//u'
>>                              \___ parser error
>> Run 'perf list' for a list of valid events
>>
>>  Usage: perf record [<options>] [<command>]
>>     or: perf record [<options>] -- <command> [<options>]
>>
>>     -e, --event <event>   event selector. use 'perf list' to list available events
>>
>> See below for cause.
>>
>> On 25/04/18 19:00, Arnaldo Carvalho de Melo wrote:
>>> From: Jiri Olsa <jolsa@kernel.org>
>>>
>>> Currently all the event parsing fails end up in the event_pmu rule, and
>>> display misleading help like:
>>>
>>>   $ perf stat -e inst kill
>>>   event syntax error: 'inst'
>>>                        \___ Cannot find PMU `inst'. Missing kernel support?
>>>   ...
>>>
>>> The reason is that the event_pmu is too strong and match also single
>>> string. Changing it to force the '/' separators to be part of the rule,
>>> and getting the proper error now:
>>>
>>>   $ perf stat -e inst kill
>>>   event syntax error: 'inst'
>>>                        \___ parser error
>>>   Run 'perf list' for a list of valid events
>>>   ...
>>>
>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>> Reported-by: Ingo Molnar <mingo@kernel.org>
>>> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>> Cc: David Ahern <dsahern@gmail.com>
>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Link: http://lkml.kernel.org/r/20180423090823.32309-5-jolsa@kernel.org
>>> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>> ---
>>>  tools/perf/util/parse-events.y | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
>>> index 7afeb80cc39e..d14464c42714 100644
>>> --- a/tools/perf/util/parse-events.y
>>> +++ b/tools/perf/util/parse-events.y
>>> @@ -224,15 +224,15 @@ event_def: event_pmu |
>>>  	   event_bpf_file
>>>  
>>>  event_pmu:
>>> -PE_NAME opt_event_config
>>> +PE_NAME '/' event_config '/'
>>
>> These are not equivalent because opt_event_config allows '//'
>> but event_config cannot be an empty string.
> 
> yep, overlooked this one, how about patch below

Seems to work but gives build warnings:

util/parse-events.y: warning: 1 shift/reduce conflict [-Wconflicts-sr]
util/parse-events.y: warning: 1 reduce/reduce conflict [-Wconflicts-rr]


> 
> jirka
> 
> ---
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index d14464c42714..1ed2befeca8a 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -523,6 +523,10 @@ event_term
>  	list_add_tail(&term->list, head);
>  	$$ = head;
>  }
> +|
> +{
> +	$$ = NULL;
> +}
>  
>  event_term:
>  PE_NAME '=' PE_NAME
> 
