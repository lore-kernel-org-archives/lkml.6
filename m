Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755455AbeDVPGR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 11:06:17 -0400
Received: from mx-fe5-210.meituan.com ([103.37.138.210]:58209 "EHLO
        mx02.meituan.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756484AbeDVOLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 10:11:36 -0400
DKIM-Filter: OpenDKIM Filter v2.9.2 dx-it-mx02.dx.sankuai.com 6560B2975BCB
Subject: Re: [PATCH] memcg: writeback: use memcg->cgwb_list directly
To: Michal Hocko <mhocko@kernel.org>
Cc: Jan Kara <jack@suse.cz>, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        aryabinin@virtuozzo.com, akpm@linux-foundation.org,
        khlebnikov@yandex-team.ru, xboe@kernel.dk, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gthelen@google.com, tj@kernel.org
References: <1524317381-236318-1-git-send-email-wanglong19@meituan.com>
 <20180421235057.iyl4sipppfx3qp3m@quack2.suse.cz>
 <20180422124324.GC17484@dhcp22.suse.cz>
From: Wang Long <wanglong19@meituan.com>
Message-ID: <f256af91-f7a4-558f-71c3-aa95ce90d9e5@meituan.com>
Date: Sun, 22 Apr 2018 22:11:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180422124324.GC17484@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/4/2018 8:43 PM, Michal Hocko wrote:
> On Sun 22-04-18 01:50:57, Jan Kara wrote:
>> On Sat 21-04-18 21:29:41, Wang Long wrote:
>>> Signed-off-by: Wang Long <wanglong19@meituan.com>
>> Yeah, looks good. I guess it was originally intended to avoid compilation
>> errors if CONFIG_CGROUP_WRITEBACK was disabled. But it doesn't seem likely
>> we'll ever need that list outside of code under CONFIG_CGROUP_WRITEBACK. So
>> you can add:
> Yeah. Trivial wrappers like these are usualy more harm than goot.  But
> please add _some_ words in the changelog.
ok, I will send the v2 patch.
>> Reviewed-by: Jan Kara <jack@suse.cz>
>>
>> 								Honza
>>
>>> ---
>>>   include/linux/memcontrol.h | 1 -
>>>   mm/backing-dev.c           | 4 ++--
>>>   mm/memcontrol.c            | 5 -----
>>>   3 files changed, 2 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>>> index d99b71b..c0056e0 100644
>>> --- a/include/linux/memcontrol.h
>>> +++ b/include/linux/memcontrol.h
>>> @@ -1093,7 +1093,6 @@ static inline void dec_lruvec_page_state(struct page *page,
>>>   
>>>   #ifdef CONFIG_CGROUP_WRITEBACK
>>>   
>>> -struct list_head *mem_cgroup_cgwb_list(struct mem_cgroup *memcg);
>>>   struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb);
>>>   void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
>>>   			 unsigned long *pheadroom, unsigned long *pdirty,
>>> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
>>> index 023190c..0a48e05 100644
>>> --- a/mm/backing-dev.c
>>> +++ b/mm/backing-dev.c
>>> @@ -555,7 +555,7 @@ static int cgwb_create(struct backing_dev_info *bdi,
>>>   	memcg = mem_cgroup_from_css(memcg_css);
>>>   	blkcg_css = cgroup_get_e_css(memcg_css->cgroup, &io_cgrp_subsys);
>>>   	blkcg = css_to_blkcg(blkcg_css);
>>> -	memcg_cgwb_list = mem_cgroup_cgwb_list(memcg);
>>> +	memcg_cgwb_list = &memcg->cgwb_list;
>>>   	blkcg_cgwb_list = &blkcg->cgwb_list;
>>>   
>>>   	/* look up again under lock and discard on blkcg mismatch */
>>> @@ -734,7 +734,7 @@ static void cgwb_bdi_unregister(struct backing_dev_info *bdi)
>>>    */
>>>   void wb_memcg_offline(struct mem_cgroup *memcg)
>>>   {
>>> -	struct list_head *memcg_cgwb_list = mem_cgroup_cgwb_list(memcg);
>>> +	struct list_head *memcg_cgwb_list = &memcg->cgwb_list;
>>>   	struct bdi_writeback *wb, *next;
>>>   
>>>   	spin_lock_irq(&cgwb_lock);
>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>> index e074f7c..d1adb9c 100644
>>> --- a/mm/memcontrol.c
>>> +++ b/mm/memcontrol.c
>>> @@ -3562,11 +3562,6 @@ static int mem_cgroup_oom_control_write(struct cgroup_subsys_state *css,
>>>   
>>>   #ifdef CONFIG_CGROUP_WRITEBACK
>>>   
>>> -struct list_head *mem_cgroup_cgwb_list(struct mem_cgroup *memcg)
>>> -{
>>> -	return &memcg->cgwb_list;
>>> -}
>>> -
>>>   static int memcg_wb_domain_init(struct mem_cgroup *memcg, gfp_t gfp)
>>>   {
>>>   	return wb_domain_init(&memcg->cgwb_domain, gfp);
>>> -- 
>>> 1.8.3.1
>>>
>> -- 
>> Jan Kara <jack@suse.com>
>> SUSE Labs, CR
