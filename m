Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbeDOJX5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 05:23:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751632AbeDOJX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 05:23:56 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, hpa@zytor.com,
        Namhyung Kim <namhyung@kernel.org>, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Subject: [PATCH 1/3] perf: Return proper values for user stack errors
Date: Sun, 15 Apr 2018 11:23:50 +0200
Message-Id: <20180415092352.12403-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return immediately when we find issue in the user
stack checks. The error value could get overwritten
by following check for PERF_SAMPLE_REGS_INTR.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fc1c330c6bd6..4d997bc064d2 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10191,9 +10191,9 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 		 * __u16 sample size limit.
 		 */
 		if (attr->sample_stack_user >= USHRT_MAX)
-			ret = -EINVAL;
+			return -EINVAL;
 		else if (!IS_ALIGNED(attr->sample_stack_user, sizeof(u64)))
-			ret = -EINVAL;
+			return -EINVAL;
 	}
 
 	if (!attr->sample_max_stack)
-- 
2.13.6
