Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B0EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E1F2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfBZMuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:50:15 -0500
Received: from relay.sw.ru ([185.231.240.75]:58674 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfBZMuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:50:15 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gycBM-0007rk-W3; Tue, 26 Feb 2019 15:50:01 +0300
Subject: Re: [PATCH RFC] mm/vmscan: try to protect active working set of
 cgroup from reclaim.
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
References: <20190222175825.18657-1-aryabinin@virtuozzo.com>
 <20190222191552.GA15922@cmpxchg.org>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <f752c208-599c-9b5a-bc42-e4282df43616@virtuozzo.com>
Date:   Tue, 26 Feb 2019 15:50:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190222191552.GA15922@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/22/19 10:15 PM, Johannes Weiner wrote:
> On Fri, Feb 22, 2019 at 08:58:25PM +0300, Andrey Ryabinin wrote:
>> In a presence of more than 1 memory cgroup in the system our reclaim
>> logic is just suck. When we hit memory limit (global or a limit on
>> cgroup with subgroups) we reclaim some memory from all cgroups.
>> This is sucks because, the cgroup that allocates more often always wins.
>> E.g. job that allocates a lot of clean rarely used page cache will push
>> out of memory other jobs with active relatively small all in memory
>> working set.
>>
>> To prevent such situations we have memcg controls like low/max, etc which
>> are supposed to protect jobs or limit them so they to not hurt others.
>> But memory cgroups are very hard to configure right because it requires
>> precise knowledge of the workload which may vary during the execution.
>> E.g. setting memory limit means that job won't be able to use all memory
>> in the system for page cache even if the rest the system is idle.
>> Basically our current scheme requires to configure every single cgroup
>> in the system.
>>
>> I think we can do better. The idea proposed by this patch is to reclaim
>> only inactive pages and only from cgroups that have big
>> (!inactive_is_low()) inactive list. And go back to shrinking active lists
>> only if all inactive lists are low.
> 
> Yes, you are absolutely right.
> 
> We shouldn't go after active pages as long as there are plenty of
> inactive pages around. That's the global reclaim policy, and we
> currently fail to translate that well to cgrouped systems.
> 
> Setting group protections or limits would work around this problem,
> but they're kind of a red herring. We shouldn't ever allow use-once
> streams to push out hot workingsets, that's a bug.
> 
>> @@ -2489,6 +2491,10 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
>>  
>>  		scan >>= sc->priority;
>>  
>> +		if (!sc->may_shrink_active && inactive_list_is_low(lruvec,
>> +						file, memcg, sc, false))
>> +			scan = 0;
>> +
>>  		/*
>>  		 * If the cgroup's already been deleted, make sure to
>>  		 * scrape out the remaining cache.
>> @@ -2733,6 +2739,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>>  	struct reclaim_state *reclaim_state = current->reclaim_state;
>>  	unsigned long nr_reclaimed, nr_scanned;
>>  	bool reclaimable = false;
>> +	bool retry;
>>  
>>  	do {
>>  		struct mem_cgroup *root = sc->target_mem_cgroup;
>> @@ -2742,6 +2749,8 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>>  		};
>>  		struct mem_cgroup *memcg;
>>  
>> +		retry = false;
>> +
>>  		memset(&sc->nr, 0, sizeof(sc->nr));
>>  
>>  		nr_reclaimed = sc->nr_reclaimed;
>> @@ -2813,6 +2822,13 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>>  			}
>>  		} while ((memcg = mem_cgroup_iter(root, memcg, &reclaim)));
>>  
>> +		if ((sc->nr_scanned - nr_scanned) == 0 &&
>> +		     !sc->may_shrink_active) {
>> +			sc->may_shrink_active = 1;
>> +			retry = true;
>> +			continue;
>> +		}
> 
> Using !scanned as the gate could be a problem. There might be a cgroup
> that has inactive pages on the local level, but when viewed from the
> system level the total inactive pages in the system might still be low
> compared to active ones. In that case we should go after active pages.
> 
> Basically, during global reclaim, the answer for whether active pages
> should be scanned or not should be the same regardless of whether the
> memory is all global or whether it's spread out between cgroups.
> 
> The reason this isn't the case is because we're checking the ratio at
> the lruvec level - which is the highest level (and identical to the
> node counters) when memory is global, but it's at the lowest level
> when memory is cgrouped.
> 
> So IMO what we should do is:
> 
> - At the beginning of global reclaim, use node_page_state() to compare
>   the INACTIVE_FILE:ACTIVE_FILE ratio and then decide whether reclaim
>   can go after active pages or not. Regardless of what the ratio is in
>   individual lruvecs.
> 
> - And likewise at the beginning of cgroup limit reclaim, walk the
>   subtree starting at sc->target_mem_cgroup, sum up the INACTIVE_FILE
>   and ACTIVE_FILE counters, and make inactive_is_low() decision on
>   those sums.
> 

Sounds reasonable.
