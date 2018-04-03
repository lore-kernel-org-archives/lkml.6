Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbeDCS7C (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 14:59:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:56242 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752420AbeDCS7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 14:59:00 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,402,1517904000";
   d="scan'208";a="217334802"
Date: Tue, 3 Apr 2018 11:58:34 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Norbert Manthey <nmanthey@amazon.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: v4.16+ seeing many unaligned access in dequeue_task_fair() on
 IA64
Message-ID: <20180403185829.yteixqsb5zazmav6@agluck-desk>
References: <20180402232448.fbop7k5xicblski5@agluck-desk>
 <20180403073706.GV4082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180403073706.GV4082@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 09:37:06AM +0200, Peter Zijlstra wrote:
> On Mon, Apr 02, 2018 at 04:24:49PM -0700, Luck, Tony wrote:
> > Any guesses before I start to bisect?
> 
> That doesn't sound good. The only guess I have at this moment is you
> accidentially enabled RANDSTRUCT_PLUGIN and that messes things up.
> 
> struct task_struct whould be at least L1_CACHE_BYTES aligned, and C
> otherwise makes it fairly hard to cause unaligned accesses. Packed
> structures and/or casting are required, and I don't think we added
> anything dodgy like that here.

bisect says:

d519329f72a6 ("sched/fair: Update util_est only on util_avg updates")

Reverting just this commit makes the problem go away.

-Tony
