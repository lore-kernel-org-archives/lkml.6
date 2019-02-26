Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6332CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2001B2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfBZPge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:36:34 -0500
Received: from relay.sw.ru ([185.231.240.75]:36254 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbfBZPgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:36:33 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gyemJ-0000Cx-2M; Tue, 26 Feb 2019 18:36:19 +0300
Subject: Re: [PATCH RFC] mm/vmscan: try to protect active working set of
 cgroup from reclaim.
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Shakeel Butt <shakeelb@google.com>
References: <20190222175825.18657-1-aryabinin@virtuozzo.com>
 <20190225040255.GA31684@castle.DHCP.thefacebook.com>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <88207884-c643-eb2c-a784-6a7b11d0e7c7@virtuozzo.com>
Date:   Tue, 26 Feb 2019 18:36:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190225040255.GA31684@castle.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/19 7:03 AM, Roman Gushchin wrote:
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
> Hi Andrey!
> 
> It's definitely an interesting idea! However, let me bring some concerns:
> 1) What's considered active and inactive depends on memory pressure inside
> a cgroup.

There is no such dependency. High memory pressure may be generated both
by active and inactive pages. We also can have a cgroup creating no pressure
with almost only active (or only inactive) pages.

> Actually active pages in one cgroup (e.g. just deleted) can be colder
> than inactive pages in an other (e.g. a memory-hungry cgroup with a tight
> memory.max).
> 

Well, yes, this is a drawback of having per-memcg lrus.

> Also a workload inside a cgroup can to some extend control what's going
> to the active LRU. So it opens a way to get more memory unfairly by
> artificially promoting more pages to the active LRU. So a cgroup
> can get an unfair advantage over other cgroups.
> 

Unfair is usually a negative term, but in this case it's very much depends on definition of what is "fair".

If fair means to put equal reclaim pressure on all cgroups, than yes, the patch
increases such unfairness, but such unfairness is a good thing.
Obviously it's more valuable to keep in memory actively used page than the page that not used.

> Generally speaking, now we have a way to measure the memory pressure
> inside a cgroup. So, in theory, it should be possible to balance
> scanning effort based on memory pressure.
> 

Simply by design, the inactive pages are the first candidates to reclaim.
Any decision that doesn't take into account inactive pages probably would be wrong.

E.g. cgroup A with active job loading a big and active working set which creates high memory pressure
and cgroup B - idle (no memory pressure) with a huge not used cache.
It's definitely preferable to reclaim from B rather than from A.
