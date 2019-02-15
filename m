Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB488C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75464218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 13:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550236287;
	bh=iqkkqlS+A4RTxdvdayr7E2AtdytsyLOJYhX625HKI7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SXQHfR8e1vGVsIX4CzfJzGcunDQbV5xcZep/vb6/w7PLG04mLxZW2uCf5mcezn3e6
	 WFCb2J2CS2jJaGLfHITOEPEDnf4YBzIAvp0ORKifmt/CytBDhuRkB/0NDhWETZEYtA
	 c2jl6iJfitbQ8W7SwEUFiODaLv13zvBVYrcfngdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437048AbfBONLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 08:11:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:52502 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388952AbfBONLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 08:11:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4B6ADADCA;
        Fri, 15 Feb 2019 13:11:23 +0000 (UTC)
Date:   Fri, 15 Feb 2019 14:11:22 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        =?utf-8?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Jiang <dave.jiang@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH -mm -V7] mm, swap: fix race between swapoff and some swap
 operations
Message-ID: <20190215131122.GA4525@dhcp22.suse.cz>
References: <20190211083846.18888-1-ying.huang@intel.com>
 <20190214143318.GJ4525@dhcp22.suse.cz>
 <871s49bkaz.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871s49bkaz.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15-02-19 15:08:36, Huang, Ying wrote:
> Michal Hocko <mhocko@kernel.org> writes:
> 
> > On Mon 11-02-19 16:38:46, Huang, Ying wrote:
> >> From: Huang Ying <ying.huang@intel.com>
> >> 
> >> When swapin is performed, after getting the swap entry information from
> >> the page table, system will swap in the swap entry, without any lock held
> >> to prevent the swap device from being swapoff.  This may cause the race
> >> like below,
> >> 
> >> CPU 1				CPU 2
> >> -----				-----
> >> 				do_swap_page
> >> 				  swapin_readahead
> >> 				    __read_swap_cache_async
> >> swapoff				      swapcache_prepare
> >>   p->swap_map = NULL		        __swap_duplicate
> >> 					  p->swap_map[?] /* !!! NULL pointer access */
> >> 
> >> Because swapoff is usually done when system shutdown only, the race may
> >> not hit many people in practice.  But it is still a race need to be fixed.
> >> 
> >> To fix the race, get_swap_device() is added to check whether the specified
> >> swap entry is valid in its swap device.  If so, it will keep the swap
> >> entry valid via preventing the swap device from being swapoff, until
> >> put_swap_device() is called.
> >> 
> >> Because swapoff() is very rare code path, to make the normal path runs as
> >> fast as possible, disabling preemption + stop_machine() instead of
> >> reference count is used to implement get/put_swap_device().  From
> >> get_swap_device() to put_swap_device(), the preemption is disabled, so
> >> stop_machine() in swapoff() will wait until put_swap_device() is called.
> >> 
> >> In addition to swap_map, cluster_info, etc.  data structure in the struct
> >> swap_info_struct, the swap cache radix tree will be freed after swapoff,
> >> so this patch fixes the race between swap cache looking up and swapoff
> >> too.
> >> 
> >> Races between some other swap cache usages protected via disabling
> >> preemption and swapoff are fixed too via calling stop_machine() between
> >> clearing PageSwapCache() and freeing swap cache data structure.
> >> 
> >> Alternative implementation could be replacing disable preemption with
> >> rcu_read_lock_sched and stop_machine() with synchronize_sched().
> >
> > using stop_machine is generally discouraged. It is a gross
> > synchronization.
> >
> > Besides that, since when do we have this problem?
> 
> For problem, you mean the race between swapoff and the page fault
> handler?

yes

> The problem is introduced in v4.11 when we avoid to replace
> swap_info_struct->lock with swap_cluster_info->lock in
> __swap_duplicate() if possible to improve the scalability of swap
> operations.  But because swapoff is a really rare operation, I don't
> think it's necessary to backport the fix.

Well, a lack of any bug reports would support your theory that this is
unlikely to hit in practice. Fixes tag would be nice to have regardless
though.

Thanks!
-- 
Michal Hocko
SUSE Labs
