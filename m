Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDFFC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456C4214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfAJJmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:42:11 -0500
Received: from relay.sw.ru ([185.231.240.75]:55566 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727903AbfAJJmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:42:10 -0500
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1ghWqg-0003DW-It; Thu, 10 Jan 2019 12:42:02 +0300
Subject: Re: [PATCH RFC 0/3] mm: Reduce IO by improving algorithm of memcg
 pagecache pages eviction
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        josef@toxicpanda.com, jack@suse.cz, hughd@google.com,
        darrick.wong@oracle.com, aryabinin@virtuozzo.com, guro@fb.com,
        mgorman@techsingularity.net, shakeelb@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <154703479840.32690.6504699919905946726.stgit@localhost.localdomain>
 <20190109141113.GW31793@dhcp22.suse.cz>
 <e9b64635-87cf-f330-acea-0ca681a2528e@virtuozzo.com>
 <20190109171021.GY31793@dhcp22.suse.cz>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <3d4f4c83-44c9-c6d5-8dbe-c42a47e6c2bd@virtuozzo.com>
Date:   Thu, 10 Jan 2019 12:42:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190109171021.GY31793@dhcp22.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.01.2019 20:10, Michal Hocko wrote:
> On Wed 09-01-19 18:43:05, Kirill Tkhai wrote:
>> Hi, Michal,
>>
>> On 09.01.2019 17:11, Michal Hocko wrote:
>>> On Wed 09-01-19 15:20:18, Kirill Tkhai wrote:
>>>> On nodes without memory overcommit, it's common a situation,
>>>> when memcg exceeds its limit and pages from pagecache are
>>>> shrinked on reclaim, while node has a lot of free memory.
>>>
>>> Yes, that is the semantic of the hard limit. If the system is not
>>> overcommitted then the hard limit can be used to prevent unexpected
>>> direct reclaim from unrelated activity.
>>
>> According to Documentation/admin-guide/cgroup-v2.rst:
>>
>>   memory.max
>>         Memory usage hard limit.  This is the final protection
>>         mechanism.  If a cgroup's memory usage reaches this limit and
>>         can't be reduced, the OOM killer is invoked in the cgroup.
>>         Under certain circumstances, the usage may go over the limit
>>         temporarily.
>>
>> There is nothing about direct reclaim in another memcg. I don't think
>> we break something here.
> 
> Others in the thread have pointed that out already. What is a hard limit
> in one memcg is an isolateion protection in another one. Especially when
> the system is not overcommited.
> 
>> File pages are accounted to memcg, and this guarantees, that single
>> memcg won't occupy all system memory by its unevictible page cache.
>> But the suggested patchset follows the same way. Pages, which remain
>> in pagecache, are easy-to-be-evicted, since they are not dirty and
>> not under writeback. System can drop them fast and in foreseeable time.
>> This is cardinal thing about the patchset: remained pages do not
>> introduce principal burden on system memory or reclaim time.
> 
> What does prevent that the page cache is easily reclaimable? Aka clean
> and ready to be dropped? Not to mention that even when the reclaim is
> fast it is not free. Especially when you do not expect that because you
> haven't reached your hard limit and the admin made sure that hard limits
> do not overcommit.

Yes, I mean it's clean and ready to drop.

I understand the problem, so in case of people worry about reclaim speed
increasing, this does not mean we should completely forget this way. This
means we possible may find a compromise, which is suitable for everybody.

>>> But this also means that any hard limited memcg can fill up all the
>>> memory and break the above assumption about the isolation from direct
>>> reclaim. Not to mention the OOM or is there anything you do anything
>>> about preventing that?
>>
>> This is discussed thing. We may add such the pages into tail of LRU list
>> instead of head. We may introduce one more separate list to link such
>> the pages only, and fastly evict them in case of global reclaim. I don't
>> think there is a problem.
>>  
>>> That beig said, I do not think we want to or even can change the
>>> semantic of the hard limit and break existing setups.
>>
>> Using the original description and the comments I gave in this message,
>> could you please to clarify the way we break existing setups?
> 
> isolation as explained above.
> 
>>> I am still
>>> interested to hear more about more detailed/specific usecases that might
>>> benefit from this behavior. Why do those users even use hard limit at
>>> all? To protect from anon memory leaks?
>>
>> In multi-user machine people want to have size of available to container
>> memory equal to the size, which they pay. So, hard limit is needed to prevent
>> one container to occupy all system memory via slowly-evictible writeback
>> pages, unevictible anon pages, etc. You can't fastly allocate a page,
>> in case of many pages are under writeback, this operation is very slow.
>>
>> (But unmapped pagecache pages introduced by patchset is another thing:
>>  you just need to take not sleeping spinlock to call __delete_from_page_cache()
>>  only. This is fast)
>>
>> Multi-user machine may have more memory, than sum of all containers hard
>> limit. This may be used as an optimization just to reduce disk IO. There
>> is no contradiction to sane sense here. And it's not a rare situation.
>> In our kernel we have cleancache driver for handling this situation, but
>> cleancache is not the best solution like I wrote.
>>
>> Not overcommited system is likely case for the patchset, while the below
>> is a little less likely:
> 
> I beliave Johannes has explained that you are trying to use the hard
> limit in a wrong way for something it is not designed for.

In general, I think a some time useful design is not a Bible, that nobody
is allowed to change. We should not limit us in something, in case of this
has a sense and may be useful. This is just a note in general.
