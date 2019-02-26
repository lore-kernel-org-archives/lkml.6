Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46572C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0E221852
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfBZMEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:04:34 -0500
Received: from relay.sw.ru ([185.231.240.75]:56642 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfBZMEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:04:34 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gybTB-0007VM-To; Tue, 26 Feb 2019 15:04:22 +0300
Subject: Re: [PATCH 5/5] mm/vmscan: don't forcely shrink active anon lru list
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20190222174337.26390-1-aryabinin@virtuozzo.com>
 <20190222174337.26390-5-aryabinin@virtuozzo.com>
 <20190222182249.GC15440@cmpxchg.org>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <ea0f769b-29e6-8787-7b18-cb7b24c1cda3@virtuozzo.com>
Date:   Tue, 26 Feb 2019 15:04:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190222182249.GC15440@cmpxchg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/19 9:22 PM, Johannes Weiner wrote:
> On Fri, Feb 22, 2019 at 08:43:37PM +0300, Andrey Ryabinin wrote:
>> shrink_node_memcg() always forcely shrink active anon list.
>> This doesn't seem like correct behavior. If system/memcg has no swap, it's
>> absolutely pointless to rebalance anon lru lists.
>> And in case we did scan the active anon list above, it's unclear why would
>> we need this additional force scan. If there are cases when we want more
>> aggressive scan of the anon lru we should just change the scan target
>> in get_scan_count() (and better explain such cases in the comments).
>>
>> Remove this force shrink and let get_scan_count() to decide how
>> much of active anon we want to shrink.
> 
> This change breaks the anon pre-aging.
> 
> The idea behind this is that the VM maintains a small batch of anon
> reclaim candidates with recent access information. On every reclaim,
> even when we just trim cache, which is the most common reclaim mode,
> but also when we just swapped out some pages and shrunk the inactive
> anon list, at the end of it we make sure that the list of potential
> anon candidates is refilled for the next reclaim cycle.
> 
> The comments for this are above inactive_list_is_low() and the
> age_active_anon() call from kswapd.
> 
> Re: no swap, you are correct. We should gate that rebalancing on
> total_swap_pages, just like age_active_anon() does.
> 


I think we should leave anon aging only for !SCAN_FILE cases.
At least aging was definitely invented for the SCAN_FRACT mode which was the
main mode at the time it was added by the commit:

	556adecba110bf5f1db6c6b56416cfab5bcab698
	Author: Rik van Riel <riel@redhat.com>
	Date:   Sat Oct 18 20:26:34 2008 -0700

	    vmscan: second chance replacement for anonymous pages


Later we've got more of the SCAN_FILE mode usage, commit:

e9868505987a03a26a3979f27b82911ccc003752
Author: Rik van Riel <riel@redhat.com>
Date:   Tue Dec 11 16:01:10 2012 -0800

    mm,vmscan: only evict file pages when we have plenty


and I think would be reasonable to  avoid the anon aging in the SCAN_FILE case.
Because if workload generates enough inactive file pages we never go to the SCAN_FRACT,
so aging is just as useless as with no swap case.

So, how about something like bellow on top of the patch?

---
 mm/vmscan.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index efd10d6b9510..6c63adfee37b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2525,6 +2525,15 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
 
 		nr[lru] = scan;
 	}
+
+	/*
+	 * Even if we did not try to evict anon pages at all, we want to
+	 * rebalance the anon lru active/inactive ratio to maintain
+	 * enough reclaim candidates for the next reclaim cycle.
+	 */
+	if (scan_balance != SCAN_FILE && inactive_list_is_low(lruvec,
+						false, memcg, sc, false))
+		nr[LRU_ACTIVE_ANON] += SWAP_CLUSTER_MAX;
 }
 
 /*
-- 
2.19.2




