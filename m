Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162918AbeE1KlE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:41:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162892AbeE1Kk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:40:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 295/329] perf/x86/intel: Fix large period handling on Broadwell CPUs
Date: Mon, 28 May 2018 12:03:44 +0200
Message-Id: <20180528100306.058787643@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kan Liang <kan.liang@linux.intel.com>

[ Upstream commit f605cfca8c39ffa2b98c06d2b9f30ba64f1e54e3 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/intel/core.c |    2 +-
 arch/x86/events/perf_event.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3027,7 +3027,7 @@ hsw_get_event_constraints(struct cpu_hw_
  * Therefore the effective (average) period matches the requested period,
  * despite coarser hardware granularity.
  */
-static unsigned bdw_limit_period(struct perf_event *event, unsigned left)
+static u64 bdw_limit_period(struct perf_event *event, u64 left)
 {
 	if ((event->hw.config & INTEL_ARCH_EVENT_MASK) ==
 			X86_CONFIG(.event=0xc0, .umask=0x01)) {
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -548,7 +548,7 @@ struct x86_pmu {
 	struct x86_pmu_quirk *quirks;
 	int		perfctr_second_write;
 	bool		late_ack;
-	unsigned	(*limit_period)(struct perf_event *event, unsigned l);
+	u64		(*limit_period)(struct perf_event *event, u64 l);
 
 	/*
 	 * sysfs attrs
