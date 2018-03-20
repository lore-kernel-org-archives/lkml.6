Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752723AbeCTLPa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:15:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44003 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbeCTLP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:15:29 -0400
Date: Tue, 20 Mar 2018 04:15:06 -0700
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-2c2a9bbe7fecb2ad4981b6f4a56cacbfb849f848@git.kernel.org>
Cc: mingo@kernel.org, jolsa@redhat.com, alexander.shishkin@linux.intel.com,
        torvalds@linux-foundation.org, eranian@google.com,
        kan.liang@linux.intel.com, tglx@linutronix.de, acme@redhat.com,
        hpa@zytor.com, vincent.weaver@maine.edu, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Reply-To: jolsa@redhat.com, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, torvalds@linux-foundation.org,
        acme@redhat.com, tglx@linutronix.de, kan.liang@linux.intel.com,
        eranian@google.com, linux-kernel@vger.kernel.org, peterz@infradead.org,
        vincent.weaver@maine.edu, hpa@zytor.com
In-Reply-To: <1518474035-21006-6-git-send-email-kan.liang@linux.intel.com>
References: <1518474035-21006-6-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel: Disable userspace RDPMC usage for
 large PEBS
Git-Commit-ID: 2c2a9bbe7fecb2ad4981b6f4a56cacbfb849f848
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

Commit-ID:  2c2a9bbe7fecb2ad4981b6f4a56cacbfb849f848
Gitweb:     https://git.kernel.org/tip/2c2a9bbe7fecb2ad4981b6f4a56cacbfb849f848
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Mon, 12 Feb 2018 14:20:35 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Mar 2018 08:52:58 +0100

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
(cherry picked from commit 1af22eba248efe2de25658041a80a3d40fb3e92e)
---
 arch/x86/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 140d33288e78..3d24edfef3e4 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2118,7 +2118,8 @@ static int x86_pmu_event_init(struct perf_event *event)
 			event->destroy(event);
 	}
 
-	if (READ_ONCE(x86_pmu.attr_rdpmc))
+	if (READ_ONCE(x86_pmu.attr_rdpmc) &&
+	    !(event->hw.flags & PERF_X86_EVENT_FREERUNNING))
 		event->hw.flags |= PERF_X86_EVENT_RDPMC_ALLOWED;
 
 	return err;
