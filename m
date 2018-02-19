Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeBSJLN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 04:11:13 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43154 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbeBSJLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 04:11:11 -0500
Date: Mon, 19 Feb 2018 10:11:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Raghavendra Rao Ananta <rananta@codeaurora.org>
Cc: alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        psodagud@codeaurora.org, tsoni@codeaurora.org, skannan@codeaurora.org
Subject: Re: [PATCH 1/1] perf: Add CPU hotplug support for events
Message-ID: <20180219091101.GM25201@hirez.programming.kicks-ass.net>
References: <1518735701-7014-1-git-send-email-rananta@codeaurora.org>
 <1518735701-7014-2-git-send-email-rananta@codeaurora.org>
 <20180216082139.GF25181@hirez.programming.kicks-ass.net>
 <361ffd6f-3eec-4be6-de2f-40beb588c65e@codeaurora.org>
 <20180216203953.GL25201@hirez.programming.kicks-ass.net>
 <aee872be-c34d-729b-575d-df488a46f2cf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aee872be-c34d-729b-575d-df488a46f2cf@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 05:48:21PM -0800, Raghavendra Rao Ananta wrote:
> I am sure we can fix it, but apart
> from the "why we are doing hotplug?" question, was was there specifically
> any issue with our patch?

Yes, the extra list is crazy. We don't keep events in extra lists when a
task isn't currently running either. A CPU being offline shouldn't be
(much) different from that.

Thinking more, we should also get rid of that HOTPLUG offset thing.

> > > > Also, you _still_ don't explain why you care about dead CPUs.
> > > > 
> I wanted to understand, if we no longer care about hotplugging of CPUs, then
> why do we still have exported symbols such as cpu_up() and cpu_down()?

Not sure why we have them, legacy probably. The rcu/lock torture module
is the only legitimate user of them.

But if having those exports gives people the impression its a sane thing
to do hotplug from modules, we should just take it out.

> Moreover, we also have the hotplug interface exposed to users-space as well
> (through sysfs). As long as these interfaces exist, there's always a
> potential chance of bringing the CPU up/down. Can you please clear this
> thing up for me?

Hotplug is an absolute utter slow path. We do our absolute best to put
the entire burden on the hotplug path such that we don't perturb normal
things.

Its primary existence is for physical CPU hotplug, not resource
management. Although there seems to be a misguided 'I have this hammer,
everthing is a nail' thing going on.

I suppose these 'once' things like changing the topology of the machine
-- eg. 'unplug' all but one of the SMT threads, are OK as well.

And RAS things that take a CPU down when there's 'trouble' is also fine.

But anything that does hotplug semi regularly is batshit insane. One of
the first things hotplug does is synchronize_rcu(), that can take a
_long_ time.
