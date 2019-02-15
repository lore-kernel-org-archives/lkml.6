Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D252C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45789207E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403865AbfBOH42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:56:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:19024 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfBOH42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:56:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 23:50:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,372,1544515200"; 
   d="scan'208";a="126685015"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.151])
  by orsmga003.jf.intel.com with ESMTP; 14 Feb 2019 23:50:23 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Hugh Dickins <hughd@google.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        =?utf-8?Q?J=EF=BF=BDr=EF=BF=BDme_Glisse?= <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Dave Jiang <dave.jiang@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH -mm -V7] mm, swap: fix race between swapoff and some swap operations
References: <20190211083846.18888-1-ying.huang@intel.com>
        <20190214023805.GA19090@redhat.com>
        <87k1i2oks6.fsf@yhuang-dev.intel.com>
        <20190214214741.GB10698@redhat.com>
Date:   Fri, 15 Feb 2019 15:50:21 +0800
In-Reply-To: <20190214214741.GB10698@redhat.com> (Andrea Arcangeli's message
        of "Thu, 14 Feb 2019 16:47:41 -0500")
Message-ID: <87mumxa3sy.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <aarcange@redhat.com> writes:

> On Thu, Feb 14, 2019 at 04:07:37PM +0800, Huang, Ying wrote:
>> Before, we choose to use stop_machine() to reduce the overhead of hot
>> path (page fault handler) as much as possible.  But now, I found
>> rcu_read_lock_sched() is just a wrapper of preempt_disable().  So maybe
>> we can switch to RCU version now.
>
> rcu_read_lock looks more efficient than rcu_read_lock_sched. So for
> this purpose in the fast path rcu_read_lock()/unlock() should be the
> preferred methods, no need to force preempt_disable() (except for
> debug purposes if sleep debug is enabled). Server builds are done with
> voluntary preempt (no preempt shouldn't even exist as config option)
> and there rcu_read_lock might be just a noop.

If

CONFIG_PREEMPT_VOLUNTARY=y
CONFIG_PREEMPT=n
CONFIG_PREEMPT_COUNT=n

which is common for servers,

rcu_read_lock() will be a noop, rcu_read_lock_sched() and
preempt_disable() will be barrier().  So rcu_read_lock() is a little
better.

> Against a fast path rcu_read_lock/unlock before the consolidation
> synchronize_rcu would have been enough, now after the consolidation
> even more certain that it's enough because it's equivalent to _mult.

Yes.  Will change to rcu_read_lock/unlock based method.

Best Regards,
Huang, Ying
