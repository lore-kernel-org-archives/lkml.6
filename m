Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbeA3KWH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:22:07 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:42595 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751373AbeA3KWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:22:05 -0500
Date: Tue, 30 Jan 2018 11:21:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v4.15-rc9] sched, cgroup: Don't reject lower cpu.max on
 ancestors
Message-ID: <20180130102156.GS2249@hirez.programming.kicks-ass.net>
References: <20180122192618.GA1771050@devbig577.frc2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180122192618.GA1771050@devbig577.frc2.facebook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 22, 2018 at 11:26:18AM -0800, Tejun Heo wrote:
> While adding cgroup2 interface for the cpu controller, 0d5936344f30
> ("sched: Implement interface for cgroup unified hierarchy") forgot to
> update input validation and left it to reject cpu.max config if any
> descendant has set a higher value.
> 
> cgroup2 officially supports delegation and a descendant must not be
> able to restrict what its ancestors can configure.  For absolute
> limits such as cpu.max and memory.max, this means that the config at
> each level should only act as the upper limit at that level and
> shouldn't interfere with what other cgroups can configure.

*blink* what?

afaiu the existing code does exactly the opposite, it forces the
descendants to configure less than the parent allows.

You're taking out an error condition and silently allowing descentant
misconfiguration. How does that make sense?
