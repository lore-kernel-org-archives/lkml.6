Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeDLJiI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 05:38:08 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:53027 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751920AbeDLJiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 05:38:07 -0400
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC: <linux-mips@linux-mips.org>, Matt Redfearn <matt.redfearn@mips.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v2 2/6] MIPS: perf: Use correct VPE ID when setting up VPE tracing
Date: Thu, 12 Apr 2018 10:36:22 +0100
Message-ID: <1523525786-29153-3-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523525786-29153-1-git-send-email-matt.redfearn@mips.com>
References: <1523525786-29153-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1523525812-452060-21719-24429-4
X-BESS-VER: 2018.4.1-r1804052329
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191914
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a couple of FIXME's in the perf code which state that
cpu_data[event->cpu].vpe_id reports 0 for both CPUs. This is no longer
the case, since the vpe_id is used extensively by SMP CPS.

VPE local counting gets around this by using smp_processor_id() instead.
As it happens this does work correctly to count events on the right VPE,
but relies on 2 assumptions:
a) Always having 2 VPEs / core.
b) The hardware only paying attention to the least significant bit of
the PERFCTL.VPEID field.
If either of these assumptions change then the incorrect VPEs events
will be counted.

Fix this by replacing smp_processor_id() with
cpu_vpe_id(&current_cpu_data), in the vpe_id() macro, and pass vpe_id()
to M_PERFCTL_VPEID() when setting up PERFCTL.VPEID. The FIXME's can also
be removed since they no longer apply.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

Changes in v2: None

 arch/mips/kernel/perf_event_mipsxx.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index f3ec4a36921d..239c4ca89fb0 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -137,12 +137,8 @@ static DEFINE_RWLOCK(pmuint_rwlock);
 #define vpe_id()	(cpu_has_mipsmt_pertccounters ? \
 			 0 : (smp_processor_id() & MIPS_CPUID_TO_COUNTER_MASK))
 #else
-/*
- * FIXME: For VSMP, vpe_id() is redefined for Perf-events, because
- * cpu_data[cpuid].vpe_id reports 0 for _both_ CPUs.
- */
 #define vpe_id()	(cpu_has_mipsmt_pertccounters ? \
-			 0 : smp_processor_id())
+			 0 : cpu_vpe_id(&current_cpu_data))
 #endif
 
 /* Copied from op_model_mipsxx.c */
@@ -1279,11 +1275,7 @@ static void check_and_calc_range(struct perf_event *event,
 			 */
 			hwc->config_base |= M_TC_EN_ALL;
 		} else {
-			/*
-			 * FIXME: cpu_data[event->cpu].vpe_id reports 0
-			 * for both CPUs.
-			 */
-			hwc->config_base |= M_PERFCTL_VPEID(event->cpu);
+			hwc->config_base |= M_PERFCTL_VPEID(vpe_id());
 			hwc->config_base |= M_TC_EN_VPE;
 		}
 	} else
-- 
2.7.4
