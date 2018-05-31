Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755190AbeEaMbg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:31:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39395 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755065AbeEaMbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:31:24 -0400
Date: Thu, 31 May 2018 05:31:04 -0700
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-4749f8196452eeb73cf2086a6a9705bae479d33d@git.kernel.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        peterz@infradead.org, kan.liang@intel.com, tglx@linutronix.de,
        torvalds@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, kan.liang@intel.com,
        tglx@linutronix.de, peterz@infradead.org
In-Reply-To: <1525371913-10597-3-git-send-email-kan.liang@intel.com>
References: <1525371913-10597-3-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel/uncore: Correct fixed counter index
 check in generic code
Git-Commit-ID: 4749f8196452eeb73cf2086a6a9705bae479d33d
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

Commit-ID:  4749f8196452eeb73cf2086a6a9705bae479d33d
Gitweb:     https://git.kernel.org/tip/4749f8196452eeb73cf2086a6a9705bae479d33d
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 3 May 2018 11:25:08 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 31 May 2018 12:36:28 +0200

perf/x86/intel/uncore: Correct fixed counter index check in generic code

There is no index which is bigger than UNCORE_PMC_IDX_FIXED. The only
exception is client IMC uncore, which has been specially handled.
For generic code, it is not correct to use >= to check fixed counter.
The code quality issue will bring problem when a new counter index is
introduced.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: acme@kernel.org
Cc: eranian@google.com
Link: http://lkml.kernel.org/r/1525371913-10597-3-git-send-email-kan.liang@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index a7956fc7ca1d..3b0f93eb3cc0 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -218,7 +218,7 @@ void uncore_perf_event_update(struct intel_uncore_box *box, struct perf_event *e
 	u64 prev_count, new_count, delta;
 	int shift;
 
-	if (event->hw.idx >= UNCORE_PMC_IDX_FIXED)
+	if (event->hw.idx == UNCORE_PMC_IDX_FIXED)
 		shift = 64 - uncore_fixed_ctr_bits(box);
 	else
 		shift = 64 - uncore_perf_ctr_bits(box);
