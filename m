Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752838AbeA3O4q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 09:56:46 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:42739 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752295AbeA3O4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 09:56:43 -0500
X-Google-Smtp-Source: AH8x225iDjubnZ6kHdgHy8TKaRJCWpZTYAB2xUhEI3xokLpLJzpBkw/XsepmOxSibWc4MF5sa6O+0A==
Date: Tue, 30 Jan 2018 06:56:39 -0800
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v4.15-rc9] sched, cgroup: Don't reject lower cpu.max on
 ancestors
Message-ID: <20180130145639.GD1121507@devbig577.frc2.facebook.com>
References: <20180122192618.GA1771050@devbig577.frc2.facebook.com>
 <20180130102156.GS2249@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130102156.GS2249@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Jan 30, 2018 at 11:21:56AM +0100, Peter Zijlstra wrote:
> afaiu the existing code does exactly the opposite, it forces the
> descendants to configure less than the parent allows.
> 
> You're taking out an error condition and silently allowing descentant
> misconfiguration. How does that make sense?

Well, they're upper limits, not strict allocations.  The current
behavior implemented by cpu isn't either a strict allocation or upper
limits.  It disallows a child from having a value higher than the
parent (allocation-ish) but the sum of the children is allowed to
exceed the parent's (limit-ish).

The combination is rather arbitrary and makes it impossible to
delegate safely (a delegatee can block the delegator from reducing the
amount resource allocated to the delegatee) while not really
protecting against overcommit from descendants either.

We had this sort of input validations in different controllers all in
their own ways.  In most cases, these aren't well thought out and we
can't support things like delegation without aligning controller
behaviors.

Thanks.

-- 
tejun
