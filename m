Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeCIJLK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:11:10 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43979 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751258AbeCIJLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:11:08 -0500
Date: Fri, 9 Mar 2018 01:10:46 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-1af22eba248efe2de25658041a80a3d40fb3e92e@git.kernel.org>
Cc: jolsa@redhat.com, mingo@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, hpa@zytor.com, eranian@google.com,
        torvalds@linux-foundation.org, kan.liang@linux.intel.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, peterz@infradead.org,
        vincent.weaver@maine.edu
Reply-To: kan.liang@linux.intel.com, vincent.weaver@maine.edu,
        linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, eranian@google.com, acme@redhat.com,
        hpa@zytor.com, alexander.shishkin@linux.intel.com, mingo@kernel.org,
        jolsa@redhat.com
In-Reply-To: <1518474035-21006-6-git-send-email-kan.liang@linux.intel.com>
References: <1518474035-21006-6-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel: Disable userspace RDPMC usage for
 large PEBS
Git-Commit-ID: 1af22eba248efe2de25658041a80a3d40fb3e92e
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

Commit-ID:  1af22eba248efe2de25658041a80a3d40fb3e92e
Gitweb:     https://git.kernel.org/tip/1af22eba248efe2de25658041a80a3d40fb3e92e
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Mon, 12 Feb 2018 14:20:35 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 9 Mar 2018 08:22:23 +0100

perf/x86/intel: Disable userspace RDPMC usage for large PEBS

Userspace RDPMC cannot possibly work for large PEBS, which was introduced in:

  b8241d20699e ("perf/x86/intel: Implement batched PEBS interrupt handling (large PEBS interrupt threshold)")

When the PEBS interrupt threshold is larger than one, there is no way
to get exact auto-reload times and value for userspace RDPMC.  Disable
the userspace RDPMC usage when large PEBS is enabled.

The only exception is when the PEBS interrupt threshold is 1, in which
case user-space RDPMC works well even with auto-reload events.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: acme@kernel.org
Fixes: b8241d20699e ("perf/x86/intel: Implement batched PEBS interrupt handling (large PEBS interrupt threshold)")
Link: http://lkml.kernel.org/r/1518474035-21006-6-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 00a6251981d2..9c86e10f1196 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2117,7 +2117,8 @@ static int x86_pmu_event_init(struct perf_event *event)
 			event->destroy(event);
 	}
 
-	if (READ_ONCE(x86_pmu.attr_rdpmc))
+	if (READ_ONCE(x86_pmu.attr_rdpmc) &&
+	    !(event->hw.flags & PERF_X86_EVENT_FREERUNNING))
 		event->hw.flags |= PERF_X86_EVENT_RDPMC_ALLOWED;
 
 	return err;
