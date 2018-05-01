Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755155AbeEAMbM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 08:31:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:54409 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754827AbeEAMbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 08:31:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,351,1520924400";
   d="scan'208";a="224806764"
Subject: Re: [V4 PATCH] perf parse-events: Specially handle uncore event alias
 in small groups
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        ganapatrao.kulkarni@cavium.com, zhangshaokun@hisilicon.com,
        yao.jin@linux.intel.com, will.deacon@arm.com, ak@linux.intel.com,
        agustinv@codeaurora.org
References: <1524768379-157997-1-git-send-email-kan.liang@linux.intel.com>
 <20180501091512.GA4813@krava>
From: "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <d2b94d2c-1bbb-bf7c-2aa6-102660bf4a7d@linux.intel.com>
Date: Tue, 1 May 2018 08:31:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501091512.GA4813@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> +static int
>> +parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
>> +					   struct parse_events_state *parse_state)
>> +{
>> +	struct perf_evsel *evsel, *leader;
>> +	uintptr_t *leaders;
>> +	bool is_leader = true;
>> +	int i, nr_pmu = 0, total_members, ret = 0;
>> +
>> +	leader = list_first_entry(list, struct perf_evsel, node);
>> +	evsel = list_last_entry(list, struct perf_evsel, node);
>> +	total_members = evsel->idx - leader->idx + 1;
>> +
>> +	leaders = calloc(total_members, sizeof(uintptr_t));
>> +	if (!leaders)
>> +		return 0;
> 
> I see.. I meant we should return -ENOMEM in here, but
> we don't check it in the called anyway.. so perhaps
> 
> 	if (WARN_ON(!leaders))
> 		return 0;
>

Sure. I will change it in V5.

> 
>> +
>> +	 __evlist__for_each_entry(list, evsel) {
>> +
>> +		/* Only split the uncore group which members use alias */
>> +		if (!evsel->use_uncore_alias)
>> +			goto out;
>> +
>> +		/* The events must be from the same uncore block */
>> +		if (!is_same_uncore_block(leader->pmu_name, evsel->pmu_name))
>> +			goto out;
>> +
>> +		if (!is_leader)
>> +			continue;
>> +		/*
>> +		 * If the event's PMU name starts to repeat, it must be a new
>> +		 * event. That can be used to distinguish the leader from
>> +		 * other members, even they have the same event name.
>> +		 */
>> +		if ((leader != evsel) && (leader->pmu_name == evsel->pmu_name)) {
>> +			is_leader = false;
>> +			continue;
>> +		}
> 
> I still don't get why you don't 'break' in here.. you set is_leader to false,
> then the loop will never get pass the !is_leader condition above
>

All the members must use alias, and be from the same uncore block.
We have to go through the whole group to check the events.

Thanks,
Kan
