Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B7CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22D2206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547043077;
	bh=MQqFGIoyW837u5lccsTyS0joBgk96/yJvM/qM1rYDTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BNrZPvGrwDEG2LU4ymMLMOkRqihGJg7Bufj+T4UlrfUIpKnXn4lMcYy9VzlwCC6rn
	 VI+SyIYiZCqU30dxubpmVyqikf9jLD22PAMxYAbO4MhDqzJozdwuYEqC+MFzzIgu4P
	 tSt5wcX8sZscnxP03Hl6X2zQgPhnJzmb7zGFzISw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbfAIOLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:11:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:58000 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729994AbfAIOLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:11:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 04FD5AF6D;
        Wed,  9 Jan 2019 14:11:14 +0000 (UTC)
Date:   Wed, 9 Jan 2019 15:11:13 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        josef@toxicpanda.com, jack@suse.cz, hughd@google.com,
        darrick.wong@oracle.com, aryabinin@virtuozzo.com, guro@fb.com,
        mgorman@techsingularity.net, shakeelb@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] mm: Reduce IO by improving algorithm of memcg
 pagecache pages eviction
Message-ID: <20190109141113.GW31793@dhcp22.suse.cz>
References: <154703479840.32690.6504699919905946726.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154703479840.32690.6504699919905946726.stgit@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-01-19 15:20:18, Kirill Tkhai wrote:
> On nodes without memory overcommit, it's common a situation,
> when memcg exceeds its limit and pages from pagecache are
> shrinked on reclaim, while node has a lot of free memory.

Yes, that is the semantic of the hard limit. If the system is not
overcommitted then the hard limit can be used to prevent unexpected
direct reclaim from unrelated activity.

> Further access to the pages requires real device IO, while
> IO causes time delays, worse powerusage, worse throughput
> for other users of the device, etc.

It is to be expected that a memory throttled usage will have this side
effect IMO.

> Cleancache is not a good solution for this problem, since
> it implies copying of page on every cleancache_put_page()
> and cleancache_get_page(). Also, it requires introduction
> of internal per-cleancache_ops data structures to manage
> cached pages and their inodes relationships, which again
> introduces overhead.
> 
> This patchset introduces another solution. It introduces
> a new scheme for evicting memcg pages:
> 
>   1)__remove_mapping() uncharges unmapped page memcg
>     and leaves page in pagecache on memcg reclaim;
> 
>   2)putback_lru_page() places page into root_mem_cgroup
>     list, since its memcg is NULL. Page may be evicted
>     on global reclaim (and this will be easily, as
>     page is not mapped, so shrinker will shrink it
>     with 100% probability of success);
> 
>   3)pagecache_get_page() charges page into memcg of
>     a task, which takes it first.

But this also means that any hard limited memcg can fill up all the
memory and break the above assumption about the isolation from direct
reclaim. Not to mention the OOM or is there anything you do anything
about preventing that?

That beig said, I do not think we want to or even can change the
semantic of the hard limit and break existing setups. I am still
interested to hear more about more detailed/specific usecases that might
benefit from this behavior. Why do those users even use hard limit at
all? To protect from anon memory leaks? Do different memcgs share the
page cache heavily?
-- 
Michal Hocko
SUSE Labs
