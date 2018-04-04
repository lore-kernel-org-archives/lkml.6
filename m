Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750916AbeDDGby (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 02:31:54 -0400
Received: from mx-fe5-210.meituan.com ([103.37.138.210]:48640 "EHLO
        mx02.meituan.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbeDDGbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 02:31:52 -0400
DKIM-Filter: OpenDKIM Filter v2.9.2 dx-it-mx02.dx.sankuai.com 6548B297675C
Subject: Re: [RFC] Is it correctly that the usage for spin_{lock|unlock}_irq
 in clear_page_dirty_for_io
To: Greg Thelen <gthelen@google.com>, Michal Hocko <mhocko@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>, npiggin@gmail.com
References: <157ed606-4a61-508b-d26a-2f5d638f39bb@meituan.com>
 <d5f73e91-6fd5-12ab-d005-93a72e146464@meituan.com>
 <20180403120312.GS5501@dhcp22.suse.cz>
 <CAHH2K0Y2=Hc-W+JsTeHvgi9_59OKh+fJEgTY-x48gh18f_MQ6Q@mail.gmail.com>
From: Wang Long <wanglong19@meituan.com>
Message-ID: <2cb713cd-0b9b-594c-31db-b4582f8ba822@meituan.com>
Date: Wed, 4 Apr 2018 14:31:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHH2K0Y2=Hc-W+JsTeHvgi9_59OKh+fJEgTY-x48gh18f_MQ6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/2018 7:12 AM, Greg Thelen wrote:
> On Tue, Apr 3, 2018 at 5:03 AM Michal Hocko <mhocko@kernel.org> wrote:
>
>> On Mon 02-04-18 19:50:50, Wang Long wrote:
>>> Hi,  Johannes Weiner and Tejun Heo
>>>
>>> I use linux-4.4.y to test the new cgroup controller io and the current
>>> stable kernel linux-4.4.y has the follow logic
>>>
>>>
>>> int clear_page_dirty_for_io(struct page *page){
>>> ...
>>> ...
>>>                  memcg = mem_cgroup_begin_page_stat(page); ----------(a)
>>>                  wb = unlocked_inode_to_wb_begin(inode, &locked);
> ---------(b)
>>>                  if (TestClearPageDirty(page)) {
>>>                          mem_cgroup_dec_page_stat(memcg,
> MEM_CGROUP_STAT_DIRTY);
>>>                          dec_zone_page_state(page, NR_FILE_DIRTY);
>>>                          dec_wb_stat(wb, WB_RECLAIMABLE);
>>>                          ret =1;
>>>                  }
>>>                  unlocked_inode_to_wb_end(inode, locked); -----------(c)
>>>                  mem_cgroup_end_page_stat(memcg); -------------(d)
>>>                  return ret;
>>> ...
>>> ...
>>> }
>>>
>>>
>>> when memcg is moving, and I_WB_SWITCH flags for inode is set. the logic
>>> is the following:
>>>
>>>
>>> spin_lock_irqsave(&memcg->move_lock, flags); -------------(a)
>>>          spin_lock_irq(&inode->i_mapping->tree_lock); ------------(b)
>>>          spin_unlock_irq(&inode->i_mapping->tree_lock); -----------(c)
>>> spin_unlock_irqrestore(&memcg->move_lock, flags); -----------(d)
>>>
>>>
>>> after (c) , the local irq is enabled. I think it is not correct.
>>>
>>> We get a deadlock backtrace after (c), the cpu get an softirq and in the
>>> irq it also call mem_cgroup_begin_page_stat to lock the same
>>> memcg->move_lock.
>>>
>>> Since the conditions are too harsh, this scenario is difficult to
>>> reproduce.  But it really exists.
>>>
>>> So how about change (b) (c) to spin_lock_irqsave/spin_lock_irqrestore?
>> Yes, it seems we really need this even for the current tree. Please note
>> that At least clear_page_dirty_for_io doesn't lock memcg anymore.
>> __cancel_dirty_page still uses lock_page_memcg though (former
>> mem_cgroup_begin_page_stat).
>> --
>> Michal Hocko
>> SUSE Labs
> I agree the issue looks real in 4.4 stable and upstream.  It seems like
> unlocked_inode_to_wb_begin/_end should use spin_lock_irqsave/restore.
>
> I'm testing a little patch now.
Thanks.

When fix it on upstream. The longterm kernel 4.9 and 4.14 also need to fix.
