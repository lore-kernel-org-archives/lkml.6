Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755033AbeEaMaz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:30:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49561 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754882AbeEaMax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:30:53 -0400
Date: Thu, 31 May 2018 05:30:33 -0700
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-d71f11c076c420c4e2fceb4faefa144e055e0935@git.kernel.org>
Cc: kan.liang@intel.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, mingo@kernel.org, hpa@zytor.com,
        peterz@infradead.org, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, kan.liang@intel.com, hpa@zytor.com,
        mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        torvalds@linux-foundation.org
In-Reply-To: <1525371913-10597-2-git-send-email-kan.liang@intel.com>
References: <1525371913-10597-2-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel/uncore: Correct fixed counter index
 check for NHM
Git-Commit-ID: d71f11c076c420c4e2fceb4faefa144e055e0935
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

Commit-ID:  d71f11c076c420c4e2fceb4faefa144e055e0935
Gitweb:     https://git.kernel.org/tip/d71f11c076c420c4e2fceb4faefa144e055e0935
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 3 May 2018 11:25:07 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 31 May 2018 12:36:28 +0200

perf/x86/intel/uncore: Correct fixed counter index check for NHM

For Nehalem and Westmere, there is only one fixed counter for W-Box.
There is no index which is bigger than UNCORE_PMC_IDX_FIXED.
It is not correct to use >= to check fixed counter.
The code quality issue will bring problem when new counter index is
introduced.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: acme@kernel.org
Cc: eranian@google.com
Link: http://lkml.kernel.org/r/1525371913-10597-2-git-send-email-kan.liang@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore_nhmex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_nhmex.c b/arch/x86/events/intel/uncore_nhmex.c
index 93e7a8397cde..173e2674be6e 100644
--- a/arch/x86/events/intel/uncore_nhmex.c
+++ b/arch/x86/events/intel/uncore_nhmex.c
@@ -246,7 +246,7 @@ static void nhmex_uncore_msr_enable_event(struct intel_uncore_box *box, struct p
 {
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (hwc->idx >= UNCORE_PMC_IDX_FIXED)
+	if (hwc->idx == UNCORE_PMC_IDX_FIXED)
 		wrmsrl(hwc->config_base, NHMEX_PMON_CTL_EN_BIT0);
 	else if (box->pmu->type->event_mask & NHMEX_PMON_CTL_EN_BIT0)
 		wrmsrl(hwc->config_base, hwc->config | NHMEX_PMON_CTL_EN_BIT22);
