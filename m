Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661AAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391A9218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437955AbfBNVWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:22:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387702AbfBNVWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:22:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B5DF42BDA;
        Thu, 14 Feb 2019 21:22:41 +0000 (UTC)
Received: from sky.random (ovpn-120-178.rdu2.redhat.com [10.10.120.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 38425611B3;
        Thu, 14 Feb 2019 21:22:37 +0000 (UTC)
Date:   Thu, 14 Feb 2019 16:22:36 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Jiang <dave.jiang@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH -mm -V7] mm, swap: fix race between swapoff and some swap
 operations
Message-ID: <20190214212236.GA10698@redhat.com>
References: <20190211083846.18888-1-ying.huang@intel.com>
 <20190214143318.GJ4525@dhcp22.suse.cz>
 <20190214123002.b921b680fea07bf5f798df79@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214123002.b921b680fea07bf5f798df79@linux-foundation.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 14 Feb 2019 21:22:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Feb 14, 2019 at 12:30:02PM -0800, Andrew Morton wrote:
> This was discussed to death and I think the changelog explains the
> conclusions adequately.  swapoff is super-rare so a stop_machine() in
> that path is appropriate if its use permits more efficiency in the
> regular swap code paths.  

The problem is precisely that the way the stop_machine callback is
implemented right now (a dummy noop), makes the stop_machine()
solution fully equivalent to RCU from the fast path point of view. It
does not permit more efficiency in the fast path which is all we care
about.

For the slow path point of view the only difference is possibly that
stop_machine will reach the quiescent state faster (i.e. swapoff may
return a few dozen milliseconds faster), but nobody cares about the
latency of swapoff and it's actually nicer if swapoff doesn't stop all
CPUs on large systems and it uses less CPU overall.

This is why I suggested if we keep using stop_machine() we should not
use a dummy function whose only purpose is to reach a queiscent state
(which is something that is more efficiently achieved with the
syncronize_rcu/sched/kernel RCU API of the day) but we should instead
try to leverage the UP-like serialization to remove more spinlocks
from the fast path and convert them to preempt_disable(). However the
current dummy callback cannot achieve that higher efficiency in the
fast paths, the code would need to be reshuffled to try to remove at
least the swap_lock.

If no spinlock is converted to preempt_disable() RCU I don't see the
point of stop_machine().

On a side note, the cmpxchge machinery I posted to run the function
simultaneously on all CPUs I think may actually be superflous if using
cpus=NULL like Hing suggested. Implementation details aside, still the
idea of stop_machine would be to do those p->swap_map = NULL and
everything protected by the swap_lock, should be executed inside the
callback that runs like in a UP system to speedup the fast path
further.

Thanks,
Andrea
