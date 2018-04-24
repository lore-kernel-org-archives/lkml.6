Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933142AbeDXMqw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 08:46:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38320 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbeDXMqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 08:46:30 -0400
Date: Tue, 24 Apr 2018 14:46:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: subhra mazumdar <subhra.mazumdar@oracle.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com,
        daniel.lezcano@linaro.org, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com
Subject: Re: [PATCH 1/3] sched: remove select_idle_core() for scalability
Message-ID: <20180424124621.GQ4082@hirez.programming.kicks-ass.net>
References: <20180424004116.28151-1-subhra.mazumdar@oracle.com>
 <20180424004116.28151-2-subhra.mazumdar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424004116.28151-2-subhra.mazumdar@oracle.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 05:41:14PM -0700, subhra mazumdar wrote:
> select_idle_core() can potentially search all cpus to find the fully idle
> core even if there is one such core. Removing this is necessary to achieve
> scalability in the fast path.

So this removes the whole core awareness from the wakeup path; this
needs far more justification.

In general running on pure cores is much faster than running on threads.
If you plot performance numbers there's almost always a fairly
significant drop in slope at the moment when we run out of cores and
start using threads.

Also, depending on cpu enumeration, your next patch might not even leave
the core scanning for idle CPUs.

Now, typically on Intel systems, we first enumerate cores and then
siblings, but I've seen Intel systems that don't do this and enumerate
all threads together. Also other architectures are known to iterate full
cores together, both s390 and Power for example do this.

So by only doing a linear scan on CPU number you will actually fill
cores instead of equally spreading across cores. Worse still, by
limiting the scan to _4_ you only barely even get onto a next core for
SMT4 hardware, never mind SMT8.

So while I'm not adverse to limiting the empty core search; I do feel it
is important to have. Overloading cores when you don't have to is not
good.
