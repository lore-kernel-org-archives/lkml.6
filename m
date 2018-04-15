Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeDOJYK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 05:24:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752152AbeDOJYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 05:24:01 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>, hpa@zytor.com,
        Namhyung Kim <namhyung@kernel.org>, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Subject: [PATCH 3/3] perf: Remove superfluous allocation error check
Date: Sun, 15 Apr 2018 11:23:52 +0200
Message-Id: <20180415092352.12403-3-jolsa@kernel.org>
In-Reply-To: <20180415092352.12403-1-jolsa@kernel.org>
References: <20180415092352.12403-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the get_callchain_buffers fails to allocate the buffer
it will decrease the nr_callchain_events right away.

There's no point of checking the allocation error for
nr_callchain_events > 1. Removing that check.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/events/callchain.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 73cc26e321de..c187aa3df3c8 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -131,14 +131,8 @@ int get_callchain_buffers(int event_max_stack)
 		goto exit;
 	}
 
-	if (count > 1) {
-		/* If the allocation failed, give up */
-		if (!callchain_cpus_entries)
-			err = -ENOMEM;
-		goto exit;
-	}
-
-	err = alloc_callchain_buffers();
+	if (count == 1)
+		err = alloc_callchain_buffers();
 exit:
 	if (err)
 		atomic_dec(&nr_callchain_events);
-- 
2.13.6
