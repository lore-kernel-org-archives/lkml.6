Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753268AbeCTMda (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 08:33:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:3060 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753190AbeCTMdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 08:33:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,335,1517904000";
   d="scan'208";a="209781499"
From: kan.liang@intel.com
To: peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc: acme@kernel.org, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@intel.com>
Subject: [PATCH V7 3/8] perf/x86/intel/uncore: Correct fixed counter index check in generic code
Date: Tue, 20 Mar 2018 05:32:40 -0700
Message-Id: <1521549165-6216-3-git-send-email-kan.liang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521549165-6216-1-git-send-email-kan.liang@intel.com>
References: <1521549165-6216-1-git-send-email-kan.liang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

There is no index which is bigger than UNCORE_PMC_IDX_FIXED. The only
exception is client IMC uncore. It has customized function to deal with
the 'UNCORE_PMC_IDX_FIXED + 1' case. It does not touch the generic code.
For generic code, it is not correct to use >= to check fixed counter.
The code quality issue will bring problem when new counter index is
introduced.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kan Liang <kan.liang@intel.com>
---

No changes since V6.

 arch/x86/events/intel/uncore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index a7956fc..3b0f93e 100644
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
-- 
2.7.4
