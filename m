Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBF3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8090217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389937AbfBNVrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:47:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406222AbfBNVrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:47:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 92CBDC058CAD;
        Thu, 14 Feb 2019 21:47:46 +0000 (UTC)
Received: from sky.random (ovpn-120-178.rdu2.redhat.com [10.10.120.178])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A208E600C1;
        Thu, 14 Feb 2019 21:47:42 +0000 (UTC)
Date:   Thu, 14 Feb 2019 16:47:41 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        =?iso-8859-1?B?Su+/vXLvv71tZQ==?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Jiang <dave.jiang@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH -mm -V7] mm, swap: fix race between swapoff and some swap
 operations
Message-ID: <20190214214741.GB10698@redhat.com>
References: <20190211083846.18888-1-ying.huang@intel.com>
 <20190214023805.GA19090@redhat.com>
 <87k1i2oks6.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1i2oks6.fsf@yhuang-dev.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 14 Feb 2019 21:47:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 04:07:37PM +0800, Huang, Ying wrote:
> Before, we choose to use stop_machine() to reduce the overhead of hot
> path (page fault handler) as much as possible.  But now, I found
> rcu_read_lock_sched() is just a wrapper of preempt_disable().  So maybe
> we can switch to RCU version now.

rcu_read_lock looks more efficient than rcu_read_lock_sched. So for
this purpose in the fast path rcu_read_lock()/unlock() should be the
preferred methods, no need to force preempt_disable() (except for
debug purposes if sleep debug is enabled). Server builds are done with
voluntary preempt (no preempt shouldn't even exist as config option)
and there rcu_read_lock might be just a noop.

Against a fast path rcu_read_lock/unlock before the consolidation
synchronize_rcu would have been enough, now after the consolidation
even more certain that it's enough because it's equivalent to _mult.
