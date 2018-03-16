Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753066AbeCPOiu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:38:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42247 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752551AbeCPOis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:38:48 -0400
Date: Fri, 16 Mar 2018 07:37:23 -0700
From: tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-bbb68468641547d56c83012670bcaf77f3dacd64@git.kernel.org>
Cc: mark.rutland@arm.com, alexey.budankov@linux.intel.com, hpa@zytor.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        peterz@infradead.org, hpa@zytor.com, jolsa@redhat.com,
        mark.rutland@arm.com, alexey.budankov@linux.intel.com
In-Reply-To: <20180316131741.3svgr64yibc6vsid@lakrids.cambridge.arm.com>
References: <20180316131741.3svgr64yibc6vsid@lakrids.cambridge.arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/core: Clear sibling list of detached events
Git-Commit-ID: bbb68468641547d56c83012670bcaf77f3dacd64
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  bbb68468641547d56c83012670bcaf77f3dacd64
Gitweb:     https://git.kernel.org/tip/bbb68468641547d56c83012670bcaf77f3dacd64
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Fri, 16 Mar 2018 12:51:40 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 16 Mar 2018 15:34:24 +0100

perf/core: Clear sibling list of detached events

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
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: vincent.weaver@maine.edu
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: torvalds@linux-foundation.org
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: valery.cherepennikov@intel.com
Cc: linux-tip-commits@vger.kernel.org
Cc: eranian@google.com
Cc: acme@redhat.com
Cc: alexander.shishkin@linux.intel.com
Cc: davidcc@google.com
Cc: kan.liang@intel.com
Cc: Dmitry.Prohorov@intel.com
Cc: Jiri Olsa <jolsa@redhat.com>
Link: https://lkml.kernel.org/r/20180316131741.3svgr64yibc6vsid@lakrids.cambridge.arm.com
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4d7a460d6669..2776a660db15 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1906,12 +1906,12 @@ static void perf_group_detach(struct perf_event *event)
 	list_for_each_entry_safe(sibling, tmp, &event->sibling_list, sibling_list) {
 
 		sibling->group_leader = sibling;
+		list_del_init(&sibling->sibling_list);
 
 		/* Inherit group flags from the previous leader */
 		sibling->group_caps = event->group_caps;
 
 		if (!RB_EMPTY_NODE(&event->group_node)) {
-			list_del_init(&sibling->sibling_list);
 			add_event_to_groups(sibling, event->ctx);
 
 			if (sibling->state == PERF_EVENT_STATE_ACTIVE) {
