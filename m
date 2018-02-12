Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932781AbeBLWWE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:22:04 -0500
Received: from mga07.intel.com ([134.134.136.100]:64295 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932738AbeBLWVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:21:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,504,1511856000";
   d="scan'208";a="29490605"
From: kan.liang@linux.intel.com
To: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: acme@kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 5/5] perf/x86: Fix: disable userspace RDPMC usage for large PEBS
Date: Mon, 12 Feb 2018 14:20:35 -0800
Message-Id: <1518474035-21006-6-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518474035-21006-1-git-send-email-kan.liang@linux.intel.com>
References: <1518474035-21006-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The userspace RDPMC usage never works for large PEBS since the large
PEBS is introduced by
commit b8241d20699e ("perf/x86/intel: Implement batched PEBS interrupt
handling (large PEBS interrupt threshold)")

When the PEBS interrupt threshold is larger than one, there is no way to
get exact auto-reload times and value for userspace RDPMC.
Disable the userspace RDPMC usage when large PEBS is enabled.

For the PEBS interrupt threshold equals to one, even it's auto-reload
event, it doesn't need to disable the userspace RDPMC. It works well.

Fixes: b8241d20699e ("perf/x86/intel: Implement batched PEBS interrupt
handling (large PEBS interrupt threshold)")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 00a6251..9c86e10 100644
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
-- 
2.7.4
