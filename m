Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752612AbeCPNRt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 09:17:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55590 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751468AbeCPNRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 09:17:47 -0400
Date: Fri, 16 Mar 2018 13:17:41 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>, tglx@linutronix.de,
        Dmitry.Prohorov@intel.com, alexander.shishkin@linux.intel.com,
        acme@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, mingo@kernel.org,
        vincent.weaver@maine.edu, kan.liang@intel.com, eranian@google.com,
        davidcc@google.com, valery.cherepennikov@intel.com,
        linux-tip-commits@vger.kernel.org
Subject: [PATCH] perf/core: clear sibling list of detached events (was "Re:
 [PATCH] perf: Fix sibling iteration")
Message-ID: <20180316131741.3svgr64yibc6vsid@lakrids.cambridge.arm.com>
References: <tip-8343aae66167df6708128a778e750d48dbe31302@git.kernel.org>
 <20180315170129.GX4043@hirez.programming.kicks-ass.net>
 <0be54adb-a7be-cd2f-dfcb-4166dfe432ea@linux.intel.com>
 <20180316103129.GC4064@hirez.programming.kicks-ass.net>
 <20180316103946.GA6960@krava>
 <20180316105017.GD4064@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316105017.GD4064@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 11:50:17AM +0100, Peter Zijlstra wrote:
> On Fri, Mar 16, 2018 at 11:39:46AM +0100, Jiri Olsa wrote:
> > On Fri, Mar 16, 2018 at 11:31:29AM +0100, Peter Zijlstra wrote:

> > > There is at least one more known issue with that patch, but neither Mark
> > > nor me could reproduce so far, so we don't know if we're right about the
> > > cause.
> > 
> > is there more info about that issue? I could try it
> 
> Find below, 0day report didn't go out to lkml. We think moving the
> list_del_init() out from the !RB_NODE_EMPTY() test might fix, but since
> we can't repro so far, its all guesses.

In testing, I can see this always fires after we perf_group_detach() a
leader whose group_node is empty.

With the list_del_init() pulled out of that check, I see that we still
hit the leaders with an empty group_node (with a hacked-in WARN_ON), but
no longer blow up in a subsequent perf_group_detach().

I've given this 50 boots with the 0day scripts, and no explosions so far
(with 5 boots where a leader had an empty group_node).

Thanks,
Mark.

---->8----
>From 136ebe0f3756d4cf1a37f6d00b7ec1b902980b83 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Fri, 16 Mar 2018 12:51:40 +0000
Subject: [PATCH] perf/core: clear sibling list of detached events

When perf_group_dettach() is called on a group leader, it updates each
sibling's group_leader field to point to that sibling, effectively
upgrading each siblnig to a group leader. After perf_group_detach has
completed, the caller may free the leader event.

We only remove siblings from the group leader's sibling_list when the
leader has a non-empty group_node. This was fine prior to commit:

  8343aae66167df67 ("perf/core: Remove perf_event::group_entry")

... as the sibling's sibling_list would be empty. However, now that we
use the sibling_list field as both the list head and the list entry,
this leaves each sibling with a non-empty sibling list, including the
stale leader event.

If perf_group_detach() is subsequently called on a sibling, it will
appear to be a group leader, and we'll walk the sibling_list,
potentially dereferencing these stale events. In 0day testing, this has
been observed to result in kernel panics.

Let's avoid this by always removing siblings from the sibling list when
we promote them to leaders.

Fixes: 8343aae66167df67 ("perf/core: Remove perf_event::group_entry")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9a07bbe66451..627814e1820d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1917,12 +1917,12 @@ static void perf_group_detach(struct perf_event *event)
 	list_for_each_entry_safe(sibling, tmp, &event->sibling_list, sibling_list) {
 
 		sibling->group_leader = sibling;
+		list_del_init(&sibling->sibling_list);
 
 		/* Inherit group flags from the previous leader */
 		sibling->group_caps = event->group_caps;
 
 		if (!RB_EMPTY_NODE(&event->group_node)) {
-			list_del_init(&sibling->sibling_list);
 			add_event_to_groups(sibling, event->ctx);
 		}
 
-- 
2.11.0
