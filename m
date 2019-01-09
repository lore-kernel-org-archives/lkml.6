Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88EFC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807E120685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfAISAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:00:43 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:35177 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727007AbfAISAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:00:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0THuA.PJ_1547056754;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0THuA.PJ_1547056754)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Jan 2019 01:59:17 +0800
Subject: Re: [v2 PATCH 3/5] mm: memcontrol: introduce wipe_on_offline
 interface
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1546647560-40026-1-git-send-email-yang.shi@linux.alibaba.com>
 <1546647560-40026-4-git-send-email-yang.shi@linux.alibaba.com>
 <CALvZod4ea4fR2n1EdZ3HwB3O3iWDHw5nXRnPLKbR6mAuDkWuQA@mail.gmail.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <9bd898c7-4c23-7af4-8446-369865b70f3f@linux.alibaba.com>
Date:   Wed, 9 Jan 2019 09:59:11 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CALvZod4ea4fR2n1EdZ3HwB3O3iWDHw5nXRnPLKbR6mAuDkWuQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/4/19 4:47 PM, Shakeel Butt wrote:
> On Fri, Jan 4, 2019 at 4:21 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>> We have some usecases which create and remove memcgs very frequently,
>> and the tasks in the memcg may just access the files which are unlikely
>> accessed by anyone else.  So, we prefer force_empty the memcg before
>> rmdir'ing it to reclaim the page cache so that they don't get
>> accumulated to incur unnecessary memory pressure.  Since the memory
>> pressure may incur direct reclaim to harm some latency sensitive
>> applications.
>>
>> Force empty would help out such usecase, however force empty reclaims
>> memory synchronously when writing to memory.force_empty.  It may take
>> some time to return and the afterwards operations are blocked by it.
>> Although this can be done in background, some usecases may need create
>> new memcg with the same name right after the old one is deleted.  So,
>> the creation might get blocked by the before reclaim/remove operation.
>>
>> Delaying memory reclaim in cgroup offline for such usecase sounds
>> reasonable.  Introduced a new interface, called wipe_on_offline for both
>> default and legacy hierarchy, which does memory reclaim in css offline
>> kworker.
>>
>> Writing to 1 would enable it, writing 0 would disable it.
>>
>> Suggested-by: Michal Hocko <mhocko@suse.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>>   include/linux/memcontrol.h |  3 +++
>>   mm/memcontrol.c            | 49 ++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 52 insertions(+)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 83ae11c..2f1258a 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -311,6 +311,9 @@ struct mem_cgroup {
>>          struct list_head event_list;
>>          spinlock_t event_list_lock;
>>
>> +       /* Reclaim as much as possible memory in offline kworker */
>> +       bool wipe_on_offline;
>> +
>>          struct mem_cgroup_per_node *nodeinfo[0];
>>          /* WARNING: nodeinfo must be the last member here */
>>   };
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 75208a2..5a13c6b 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -2918,6 +2918,35 @@ static ssize_t mem_cgroup_force_empty_write(struct kernfs_open_file *of,
>>          return mem_cgroup_force_empty(memcg) ?: nbytes;
>>   }
>>
>> +static int wipe_on_offline_show(struct seq_file *m, void *v)
>> +{
>> +       struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
>> +
>> +       seq_printf(m, "%lu\n", (unsigned long)memcg->wipe_on_offline);
>> +
>> +       return 0;
>> +}
>> +
>> +static int wipe_on_offline_write(struct cgroup_subsys_state *css,
>> +                                struct cftype *cft, u64 val)
>> +{
>> +       int ret = 0;
>> +
>> +       struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>> +
>> +       if (mem_cgroup_is_root(memcg))
>> +               return -EINVAL;
>> +
>> +       if (val == 0)
>> +               memcg->wipe_on_offline = false;
>> +       else if (val == 1)
>> +               memcg->wipe_on_offline = true;
>> +       else
>> +               ret = -EINVAL;
>> +
>> +       return ret;
>> +}
>> +
>>   static u64 mem_cgroup_hierarchy_read(struct cgroup_subsys_state *css,
>>                                       struct cftype *cft)
>>   {
>> @@ -4283,6 +4312,11 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
>>                  .write = mem_cgroup_reset,
>>                  .read_u64 = mem_cgroup_read_u64,
>>          },
>> +       {
>> +               .name = "wipe_on_offline",
> What about "force_empty_on_offline"?

Actually, I don't have preference to the name of the knob. However, 
wipe_on_offline looks shorter.

>
>> +               .seq_show = wipe_on_offline_show,
>> +               .write_u64 = wipe_on_offline_write,
>> +       },
>>          { },    /* terminate */
>>   };
>>
>> @@ -4569,6 +4603,15 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
>>          page_counter_set_min(&memcg->memory, 0);
>>          page_counter_set_low(&memcg->memory, 0);
>>
>> +       /*
>> +        * Reclaim as much as possible memory when offlining.
>> +        *
>> +        * Do it after min/low is reset otherwise some memory might
>> +        * be protected by min/low.
>> +        */
>> +       if (memcg->wipe_on_offline)
>> +               mem_cgroup_force_empty(memcg);
>> +
> mem_cgroup_force_empty() also does drain_all_stock(), so, move
> drain_all_stock() in mem_cgroup_css_offline() to the else of 'if
> (memcg->wipe_on_offline)'.

Sure.

Thanks,
Yang

>
>>          memcg_offline_kmem(memcg);
>>          wb_memcg_offline(memcg);
>>
>> @@ -5694,6 +5737,12 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
>>                  .seq_show = memory_oom_group_show,
>>                  .write = memory_oom_group_write,
>>          },
>> +       {
>> +               .name = "wipe_on_offline",
>> +               .flags = CFTYPE_NOT_ON_ROOT,
>> +               .seq_show = wipe_on_offline_show,
>> +               .write_u64 = wipe_on_offline_write,
>> +       },
>>          { }     /* terminate */
>>   };
>>
>> --
>> 1.8.3.1
>>

