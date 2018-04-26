Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756674AbeDZQse (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:48:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:31321 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754544AbeDZQsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:48:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,330,1520924400";
   d="scan'208";a="51065579"
Subject: Re: [V3 PATCH] perf parse-events: Specially handle uncore event alias
 in small groups
To: Jiri Olsa <jolsa@redhat.com>
Cc: acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        ganapatrao.kulkarni@cavium.com, zhangshaokun@hisilicon.com,
        yao.jin@linux.intel.com, will.deacon@arm.com, ak@linux.intel.com,
        agustinv@codeaurora.org
References: <1524679123-150715-1-git-send-email-kan.liang@linux.intel.com>
 <20180426161410.GC2122@krava>
From: "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <aa201f0f-f3fb-90ae-9578-8e44dcec09bb@linux.intel.com>
Date: Thu, 26 Apr 2018 12:48:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180426161410.GC2122@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/2018 12:14 PM, Jiri Olsa wrote:
> On Wed, Apr 25, 2018 at 10:58:43AM -0700, kan.liang@linux.intel.com wrote:
> 
> SNIP
> 
>> -void parse_events__set_leader(char *name, struct list_head *list)
>> +/*
>> + * Check if the two uncore PMUs are from the same uncore block
>> + * The format of the uncore PMU name is uncore_#blockname_#pmuidx
>> + */
>> +static bool is_same_uncore_block(const char *pmu_name_a, const char *pmu_name_b)
>> +{
>> +	char *end_a, *end_b;
>> +
>> +	end_a = strrchr(pmu_name_a, '_');
>> +	end_b = strrchr(pmu_name_b, '_');
>> +
>> +	if (!end_a || !end_b)
>> +		return false;
>> +
>> +	if ((end_a - pmu_name_a) != (end_b - pmu_name_b))
>> +		return false;
>> +
>> +	return (strncmp(pmu_name_a, pmu_name_b, end_a - pmu_name_a) == 0);
>> +}
>> +
>> +static int
>> +parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
>> +					   struct parse_events_state *parse_state)
>> +{
>> +	struct perf_evsel *evsel, *leader;
>> +	uintptr_t *leaders;
>> +	bool is_leader = true;
>> +	int i = 0, nr_pmu = 0, total_members, ret = 0;
>> +
>> +	leader = list_entry(list->next, struct perf_evsel, node);
>> +	evsel = list_entry(list->prev, struct perf_evsel, node);
> 
> could you please use list_last_entry and list_first_entry in here?
>

Sure.


>> +	total_members = evsel->idx - leader->idx + 1;
>> +
>> +	leaders = calloc(total_members, sizeof(uintptr_t));
>> +	if (!leaders)
>> +		return ret;
> 
> returns 0 in here

OK

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
> 
> setting "is_leader = false" basically breaks the loop,
> because of that !leader check above, so why continue?
>

Because the evsel doesn't belong to leader anymore.
We should not add it into leaders[].

>> +			continue;
>> +		}
>> +		/* The name is always alias name */
>> +		WARN_ON(strcmp(leader->name, evsel->name));
>> +
>> +		leaders[nr_pmu++] = (uintptr_t) evsel;
>> +	}
>> +
>> +	/* only one event alias */
>> +	if (nr_pmu == total_members) {
>> +		parse_state->nr_groups--;
>> +		goto handled;
>> +	}
>> +
>> +	__evlist__for_each_entry(list, evsel) {
>> +		if (i >= nr_pmu)
>> +			i = 0;
>> +		evsel->leader = (struct perf_evsel *) leaders[i++];
>> +	}
> 
> it's not so obvious from the code how the groups
> are set.. please describe that logic in the comment
>

Sure. I will add more comments.

Thanks,
Kan


> thanks,
> jirka
> 
>> +
>> +	for (i = 0; i < nr_pmu; i++) {
>> +		evsel = (struct perf_evsel *) leaders[i];
>> +		evsel->nr_members = total_members / nr_pmu;
>> +		evsel->group_name = name ? strdup(name) : NULL;
>> +	}
>> +
>> +	parse_state->nr_groups += nr_pmu - 1;
>> +
>> +handled:
>> +	ret = 1;
>> +out:
>> +	free(leaders);
>> +	return ret;
>> +}
