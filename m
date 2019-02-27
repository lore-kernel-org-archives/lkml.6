Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9E6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2284E2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbfB0OYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:24:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:62541 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726795AbfB0OYd (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:24:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 06:24:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,419,1544515200"; 
   d="scan'208";a="137632165"
Received: from jacwang-mobl.ccr.corp.intel.com (HELO [10.254.211.131]) ([10.254.211.131])
  by orsmga002.jf.intel.com with ESMTP; 27 Feb 2019 06:24:29 -0800
Subject: Re: [PATCH v2 1/3] perf diff: Support --time filter option
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <1551183069-5931-1-git-send-email-yao.jin@linux.intel.com>
 <1551183069-5931-2-git-send-email-yao.jin@linux.intel.com>
 <20190227092812.GB22793@krava>
 <2eecb3cf-1dcc-f98f-1ca5-f9c29bd8fd8f@linux.intel.com>
 <20190227131045.GB18893@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <b8cbc6b3-8dea-99b7-68cf-3f07b1893322@linux.intel.com>
Date:   Wed, 27 Feb 2019 22:24:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227131045.GB18893@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/2019 9:10 PM, Jiri Olsa wrote:
> On Wed, Feb 27, 2019 at 08:51:44PM +0800, Jin, Yao wrote:
>>
>>
>> On 2/27/2019 5:28 PM, Jiri Olsa wrote:
>>> On Tue, Feb 26, 2019 at 08:11:07PM +0800, Jin Yao wrote:
>>>
>>> SNIP
>>>
>>>> +		.ordered_events = true,
>>>> +		.ordering_requires_timestamps = true,
>>>> +	},
>>>>    };
>>>>    static struct perf_evsel *evsel_match(struct perf_evsel *evsel,
>>>> @@ -771,19 +788,136 @@ static void data__free(struct data__file *d)
>>>>    	}
>>>>    }
>>>> +static int parse_time_range(struct data__file *d,
>>>> +			    struct perf_time_interval *ptime_range,
>>>> +			    const char *time_str)
>>>> +{
>>>> +	if (perf_time__parse_str(ptime_range,
>>>> +				 time_str) != 0) {
>>>> +		if (d->session->evlist->first_sample_time == 0 &&
>>>> +		    d->session->evlist->last_sample_time == 0) {
>>>> +			pr_err("HINT: no first/last sample time found in perf data.\n"
>>>> +			       "Please use latest perf binary to execute 'perf record'\n"
>>>> +			       "(if '--buildid-all' is enabled, please set '--timestamp-boundary').\n");
>>>> +			return -EINVAL;
>>>> +		}
>>>> +
>>>> +		pdiff.range_num = perf_time__percent_parse_str(
>>>> +				ptime_range, pdiff.range_size, time_str,
>>>> +				d->session->evlist->first_sample_time,
>>>> +				d->session->evlist->last_sample_time);
>>>> +
>>>> +		if (pdiff.range_num < 0) {
>>>> +			pr_err("Invalid time string\n");
>>>> +			return -EINVAL;
>>>> +		}
>>>> +	} else {
>>>> +		pdiff.range_num = 1;
>>>
>>> I dont understand why we set range_num to 1 if there's
>>> not time option set.. it should be 0 and we should take
>>> no action in diff__process_sample_event, right?
>>>
>>> then I checked the report code and we do the same,
>>> could we fix that? I'm assuming we don't need any
>>> time check if the time option is not set.. please
>>> correct me if I miss something
>>>
>>> jirka
>>>
>>
>> We support multiple complicated time strings. :(
>>
>> In parse_time_range(), perf_time__parse_str() returns 0 if the time string
>> is a simple start/stop format. So next, we set the range_num to 1. If the
>> time string contains multiple time percent ranges (e.g. "10%/1,10%/2,..."),
>> perf_time__parse_str() will return with error (<0), then we will continue
>> checking with perf_time__percent_parse_str().
>>
>> So when range_num is set to 1, it just means it's the simple time string.
> 
> why do we need to have time range set if there's no --time
> option set by user?
> 
> jirka
> 

Yes, that could be refined if no --time option set by user. I think I 
can add a new patch to fix these for perf report/script.

Thanks
Jin Yao
