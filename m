Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbeCIJIO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 04:08:14 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38413 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbeCIJIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 04:08:12 -0500
Date: Fri, 9 Mar 2018 01:07:50 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-f605cfca8c39ffa2b98c06d2b9f30ba64f1e54e3@git.kernel.org>
Cc: jolsa@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        tglx@linutronix.de, acme@redhat.com, torvalds@linux-foundation.org,
        vincent.weaver@maine.edu, mingo@kernel.org, peterz@infradead.org,
        kan.liang@linux.intel.com, alexander.shishkin@linux.intel.com,
        eranian@google.com
Reply-To: hpa@zytor.com, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, torvalds@linux-foundation.org, acme@redhat.com,
        peterz@infradead.org, mingo@kernel.org, vincent.weaver@maine.edu,
        kan.liang@linux.intel.com, alexander.shishkin@linux.intel.com,
        eranian@google.com
In-Reply-To: <1519926894-3520-1-git-send-email-kan.liang@linux.intel.com>
References: <1519926894-3520-1-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel: Fix large period handling on
 Broadwell CPUs
Git-Commit-ID: f605cfca8c39ffa2b98c06d2b9f30ba64f1e54e3
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

Commit-ID:  f605cfca8c39ffa2b98c06d2b9f30ba64f1e54e3
Gitweb:     https://git.kernel.org/tip/f605cfca8c39ffa2b98c06d2b9f30ba64f1e54e3
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Thu, 1 Mar 2018 12:54:54 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 9 Mar 2018 08:22:05 +0100

perf/x86/intel: Fix large period handling on Broadwell CPUs

Large fixed period values could be truncated on Broadwell, for example:

  perf record -e cycles -c 10000000000

Here the fixed period is 0x2540BE400, but the period which finally applied is
0x540BE400 - which is wrong.

The reason is that x86_pmu::limit_period() uses an u32 parameter, so the
high 32 bits of 'period' get truncated.

This bug was introduced in:

  commit 294fe0f52a44 ("perf/x86/intel: Add INST_RETIRED.ALL workarounds")

It's safe to use u64 instead of u32:

 - Although the 'left' is s64, the value of 'left' must be positive when
   calling limit_period().

 - bdw_limit_period() only modifies the lowest 6 bits, it doesn't touch
   the higher 32 bits.

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
Fixes: 294fe0f52a44 ("perf/x86/intel: Add INST_RETIRED.ALL workarounds")
Link: http://lkml.kernel.org/r/1519926894-3520-1-git-send-email-kan.liang@linux.intel.com
[ Rewrote unacceptably bad changelog. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c | 2 +-
 arch/x86/events/perf_event.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 56457cb73448..6b6c1717787d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3188,7 +3188,7 @@ glp_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
  * Therefore the effective (average) period matches the requested period,
  * despite coarser hardware granularity.
  */
-static unsigned bdw_limit_period(struct perf_event *event, unsigned left)
+static u64 bdw_limit_period(struct perf_event *event, u64 left)
 {
 	if ((event->hw.config & INTEL_ARCH_EVENT_MASK) ==
 			X86_CONFIG(.event=0xc0, .umask=0x01)) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 78f91ec1056e..6495ffd57e3e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -557,7 +557,7 @@ struct x86_pmu {
 	struct x86_pmu_quirk *quirks;
 	int		perfctr_second_write;
 	bool		late_ack;
-	unsigned	(*limit_period)(struct perf_event *event, unsigned l);
+	u64		(*limit_period)(struct perf_event *event, u64 l);
 
 	/*
 	 * sysfs attrs
