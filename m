Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755542AbeEAJPV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 05:15:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755089AbeEAJPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 05:15:17 -0400
Date: Tue, 1 May 2018 11:15:12 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: kan.liang@linux.intel.com
Cc: acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        ganapatrao.kulkarni@cavium.com, zhangshaokun@hisilicon.com,
        yao.jin@linux.intel.com, will.deacon@arm.com, ak@linux.intel.com,
        agustinv@codeaurora.org
Subject: Re: [V4 PATCH] perf parse-events: Specially handle uncore event
 alias in small groups
Message-ID: <20180501091512.GA4813@krava>
References: <1524768379-157997-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524768379-157997-1-git-send-email-kan.liang@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 11:46:19AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Perf stat doesn't count the uncore event aliases from the same uncore
> block in a group, for example:
> 
>   perf stat -e '{unc_m_cas_count.all,unc_m_clockticks}' -a -I 1000
>   #           time             counts unit events
>        1.000447342      <not counted>      unc_m_cas_count.all
>        1.000447342      <not counted>      unc_m_clockticks
>        2.000740654      <not counted>      unc_m_cas_count.all
>        2.000740654      <not counted>      unc_m_clockticks
> 
> The output is very misleading. It gives a wrong impression that the
> uncore event doesn't work.
> 
> An uncore block could be composed by several PMUs. An uncore event alias
> is a joint name which means the same event runs on all PMUs of a block.
> Perf doesn't support mixed events from different PMUs in the same group.
> It is wrong to put uncore event aliases in a big group.
> 
> The right way is to split the big group into multiple small groups which
> only include the events from the same PMU.
> Only uncore event aliases from the same uncore block should be specially
> handled here. It doesn't make sense to mix the uncore events with other
> uncore events from different blocks or even core events in a group.
> 
> With the patch:
>   #           time             counts unit events
>      1.001557653            140,833      unc_m_cas_count.all
>      1.001557653      1,330,231,332      unc_m_clockticks
>      2.002709483             85,007      unc_m_cas_count.all
>      2.002709483      1,429,494,563      unc_m_clockticks
> 
> Reported-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
> 
> Changes since V3
> - Add more comments in parse_events__set_leader_for_uncore_aliase
> - Using list_first_entry and list_last_entry to replace list_entry
> - Change the ret to 0 in alloc failed path
> - Move "i = 0" closer to where it is used
> 
>  tools/perf/util/evsel.h        |   1 +
>  tools/perf/util/parse-events.c | 125 ++++++++++++++++++++++++++++++++++++++++-
>  tools/perf/util/parse-events.h |   7 ++-
>  tools/perf/util/parse-events.y |   8 +--
>  4 files changed, 132 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 92ec009..b13f5f2 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -127,6 +127,7 @@ struct perf_evsel {
>  	bool			precise_max;
>  	bool			ignore_missing_thread;
>  	bool			forced_leader;
> +	bool			use_uncore_alias;
>  	/* parse modifier helper */
>  	int			exclude_GH;
>  	int			nr_members;
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 2fb0272..0f5c1ab 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1219,13 +1219,16 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
>  
>  int parse_events_add_pmu(struct parse_events_state *parse_state,
>  			 struct list_head *list, char *name,
> -			 struct list_head *head_config, bool auto_merge_stats)
> +			 struct list_head *head_config,
> +			 bool auto_merge_stats,
> +			 bool use_alias)
>  {
>  	struct perf_event_attr attr;
>  	struct perf_pmu_info info;
>  	struct perf_pmu *pmu;
>  	struct perf_evsel *evsel;
>  	struct parse_events_error *err = parse_state->error;
> +	bool use_uncore_alias;
>  	LIST_HEAD(config_terms);
>  
>  	pmu = perf_pmu__find(name);
> @@ -1244,11 +1247,14 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  		memset(&attr, 0, sizeof(attr));
>  	}
>  
> +	use_uncore_alias = (pmu->is_uncore && use_alias);
> +
>  	if (!head_config) {
>  		attr.type = pmu->type;
>  		evsel = __add_event(list, &parse_state->idx, &attr, NULL, pmu, NULL, auto_merge_stats);
>  		if (evsel) {
>  			evsel->pmu_name = name;
> +			evsel->use_uncore_alias = use_uncore_alias;
>  			return 0;
>  		} else {
>  			return -ENOMEM;
> @@ -1282,6 +1288,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  		evsel->metric_expr = info.metric_expr;
>  		evsel->metric_name = info.metric_name;
>  		evsel->pmu_name = name;
> +		evsel->use_uncore_alias = use_uncore_alias;
>  	}
>  
>  	return evsel ? 0 : -ENOMEM;
> @@ -1317,7 +1324,8 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
>  				list_add_tail(&term->list, head);
>  
>  				if (!parse_events_add_pmu(parse_state, list,
> -							  pmu->name, head, true)) {
> +							  pmu->name, head,
> +							  true, true)) {
>  					pr_debug("%s -> %s/%s/\n", str,
>  						 pmu->name, alias->str);
>  					ok++;
> @@ -1339,7 +1347,115 @@ int parse_events__modifier_group(struct list_head *list,
>  	return parse_events__modifier_event(list, event_mod, true);
>  }
>  
> -void parse_events__set_leader(char *name, struct list_head *list)
> +/*
> + * Check if the two uncore PMUs are from the same uncore block
> + * The format of the uncore PMU name is uncore_#blockname_#pmuidx
> + */
> +static bool is_same_uncore_block(const char *pmu_name_a, const char *pmu_name_b)
> +{
> +	char *end_a, *end_b;
> +
> +	end_a = strrchr(pmu_name_a, '_');
> +	end_b = strrchr(pmu_name_b, '_');
> +
> +	if (!end_a || !end_b)
> +		return false;
> +
> +	if ((end_a - pmu_name_a) != (end_b - pmu_name_b))
> +		return false;
> +
> +	return (strncmp(pmu_name_a, pmu_name_b, end_a - pmu_name_a) == 0);
> +}
> +
> +static int
> +parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
> +					   struct parse_events_state *parse_state)
> +{
> +	struct perf_evsel *evsel, *leader;
> +	uintptr_t *leaders;
> +	bool is_leader = true;
> +	int i, nr_pmu = 0, total_members, ret = 0;
> +
> +	leader = list_first_entry(list, struct perf_evsel, node);
> +	evsel = list_last_entry(list, struct perf_evsel, node);
> +	total_members = evsel->idx - leader->idx + 1;
> +
> +	leaders = calloc(total_members, sizeof(uintptr_t));
> +	if (!leaders)
> +		return 0;

I see.. I meant we should return -ENOMEM in here, but
we don't check it in the called anyway.. so perhaps

	if (WARN_ON(!leaders))
		return 0;


> +
> +	 __evlist__for_each_entry(list, evsel) {
> +
> +		/* Only split the uncore group which members use alias */
> +		if (!evsel->use_uncore_alias)
> +			goto out;
> +
> +		/* The events must be from the same uncore block */
> +		if (!is_same_uncore_block(leader->pmu_name, evsel->pmu_name))
> +			goto out;
> +
> +		if (!is_leader)
> +			continue;
> +		/*
> +		 * If the event's PMU name starts to repeat, it must be a new
> +		 * event. That can be used to distinguish the leader from
> +		 * other members, even they have the same event name.
> +		 */
> +		if ((leader != evsel) && (leader->pmu_name == evsel->pmu_name)) {
> +			is_leader = false;
> +			continue;
> +		}

I still don't get why you don't 'break' in here.. you set is_leader to false,
then the loop will never get pass the !is_leader condition above

thanks for all the comments,
jirka

> +		/* The name is always alias name */
> +		WARN_ON(strcmp(leader->name, evsel->name));
> +
> +		/* Store the leader event for each PMU */
> +		leaders[nr_pmu++] = (uintptr_t) evsel;
> +	}
> +
> +	/* only one event alias */
> +	if (nr_pmu == total_members) {
> +		parse_state->nr_groups--;
> +		goto handled;
> +	}
> +
> +	/*
> +	 * An uncore event alias is a joint name which means the same event
> +	 * runs on all PMUs of a block.
> +	 * Perf doesn't support mixed events from different PMUs in the same
> +	 * group. The big group has to be split into multiple small groups
> +	 * which only include the events from the same PMU.
> +	 *
> +	 * Here the uncore event aliases must be from the same uncore block.
> +	 * The number of PMUs must be same for each alias. The number of new
> +	 * small groups equals to the number of PMUs.
> +	 * Setting the leader event for corresponding members in each group.
> +	 */
> +	i = 0;
> +	__evlist__for_each_entry(list, evsel) {
> +		if (i >= nr_pmu)
> +			i = 0;
> +		evsel->leader = (struct perf_evsel *) leaders[i++];
> +	}
> +
> +	/* The number of members and group name are same for each group */
> +	for (i = 0; i < nr_pmu; i++) {
> +		evsel = (struct perf_evsel *) leaders[i];
> +		evsel->nr_members = total_members / nr_pmu;
> +		evsel->group_name = name ? strdup(name) : NULL;
> +	}
> +
> +	/* Take the new small groups into account */
> +	parse_state->nr_groups += nr_pmu - 1;
> +
> +handled:
> +	ret = 1;
> +out:
> +	free(leaders);
> +	return ret;
> +}
> +
> +void parse_events__set_leader(char *name, struct list_head *list,
> +			      struct parse_events_state *parse_state)
>  {
>  	struct perf_evsel *leader;
>  
> @@ -1348,6 +1464,9 @@ void parse_events__set_leader(char *name, struct list_head *list)
>  		return;
>  	}
>  
> +	if (parse_events__set_leader_for_uncore_aliase(name, list, parse_state))
> +		return;
> +
>  	__perf_evlist__set_leader(list);
>  	leader = list_entry(list->next, struct perf_evsel, node);
>  	leader->group_name = name ? strdup(name) : NULL;
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index 5015cfd..4473dac 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -167,7 +167,9 @@ int parse_events_add_breakpoint(struct list_head *list, int *idx,
>  				void *ptr, char *type, u64 len);
>  int parse_events_add_pmu(struct parse_events_state *parse_state,
>  			 struct list_head *list, char *name,
> -			 struct list_head *head_config, bool auto_merge_stats);
> +			 struct list_head *head_config,
> +			 bool auto_merge_stats,
> +			 bool use_alias);
>  
>  int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
>  			       char *str,
> @@ -178,7 +180,8 @@ int parse_events_copy_term_list(struct list_head *old,
>  
>  enum perf_pmu_event_symbol_type
>  perf_pmu__parse_check(const char *name);
> -void parse_events__set_leader(char *name, struct list_head *list);
> +void parse_events__set_leader(char *name, struct list_head *list,
> +			      struct parse_events_state *parse_state);
>  void parse_events_update_lists(struct list_head *list_event,
>  			       struct list_head *list_all);
>  void parse_events_evlist_error(struct parse_events_state *parse_state,
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index d14464c..47f6399 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -161,7 +161,7 @@ PE_NAME '{' events '}'
>  	struct list_head *list = $3;
>  
>  	inc_group_count(list, _parse_state);
> -	parse_events__set_leader($1, list);
> +	parse_events__set_leader($1, list, _parse_state);
>  	$$ = list;
>  }
>  |
> @@ -170,7 +170,7 @@ PE_NAME '{' events '}'
>  	struct list_head *list = $2;
>  
>  	inc_group_count(list, _parse_state);
> -	parse_events__set_leader(NULL, list);
> +	parse_events__set_leader(NULL, list, _parse_state);
>  	$$ = list;
>  }
>  
> @@ -232,7 +232,7 @@ PE_NAME '/' event_config '/'
>  		YYABORT;
>  
>  	ALLOC_LIST(list);
> -	if (parse_events_add_pmu(_parse_state, list, $1, $3, false)) {
> +	if (parse_events_add_pmu(_parse_state, list, $1, $3, false, false)) {
>  		struct perf_pmu *pmu = NULL;
>  		int ok = 0;
>  		char *pattern;
> @@ -251,7 +251,7 @@ PE_NAME '/' event_config '/'
>  					free(pattern);
>  					YYABORT;
>  				}
> -				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true))
> +				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true, false))
>  					ok++;
>  				parse_events_terms__delete(terms);
>  			}
> -- 
> 2.7.4
> 
