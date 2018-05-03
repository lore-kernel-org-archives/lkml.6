Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751403AbeEDClf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 22:41:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:18418 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751214AbeEDCla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 22:41:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,360,1520924400";
   d="scan'208";a="221513529"
From: kan.liang@intel.com
To: peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc: acme@kernel.org, eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@intel.com>
Subject: [RESEND PATCH V7 2/8] perf/x86/intel/uncore: Correct fixed counter index check for NHM
Date: Thu,  3 May 2018 11:25:07 -0700
Message-Id: <1525371913-10597-2-git-send-email-kan.liang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525371913-10597-1-git-send-email-kan.liang@intel.com>
References: <1525371913-10597-1-git-send-email-kan.liang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

For Nehalem and Westmere, there is only one fixed counter for W-Box.
There is no index which is bigger than UNCORE_PMC_IDX_FIXED.
It is not correct to use >= to check fixed counter.
The code quality issue will bring problem when new counter index is
introduced.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kan Liang <kan.liang@intel.com>
---

No changes since V6.

 arch/x86/events/intel/uncore_nhmex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_nhmex.c b/arch/x86/events/intel/uncore_nhmex.c
index 93e7a83..173e267 100644
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
-- 
2.7.4
