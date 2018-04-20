Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754640AbeDTK25 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:28:57 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:48394 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754458AbeDTK24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:28:56 -0400
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC: <linux-mips@linux-mips.org>, Matt Redfearn <matt.redfearn@mips.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Maciej W. Rozycki" <macro@mips.com>,
        Peter Zijlstra <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        "Paul Burton" <paul.burton@mips.com>, Robert Richter <rric@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        <oprofile-list@lists.sf.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v3 2/7] MIPS: perf: More robustly probe for the presence of per-tc counters
Date: Fri, 20 Apr 2018 11:23:04 +0100
Message-ID: <1524219789-31241-3-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524219789-31241-1-git-send-email-matt.redfearn@mips.com>
References: <1524219789-31241-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1524219945-321457-10557-42113-7
X-BESS-VER: 2018.5-r1804181636
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192194
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The presence of per TC performance counters is now detected by
cpu-probe.c and indicated by MIPS_CPU_MT_PER_TC_PERF_COUNTERS in
cpu_data. Switch detection of the feature to use this new flag rather
than blindly testing the implementation specific config7 register with a
magic number.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

Changes in v3:
Use flag in cpu_data set by cpu_probe.c to indicate feature presence.

Changes in v2: None

 arch/mips/include/asm/cpu-features.h | 7 +++++++
 arch/mips/kernel/perf_event_mipsxx.c | 3 ---
 arch/mips/oprofile/op_model_mipsxx.c | 2 --
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 721b698bfe3c..69755d900c69 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -534,6 +534,13 @@
 # define cpu_has_shared_ftlb_entries 0
 #endif
 
+#ifdef CONFIG_MIPS_MT_SMP
+# define cpu_has_mipsmt_pertccounters \
+	(cpu_data[0].options & MIPS_CPU_MT_PER_TC_PERF_COUNTERS)
+#else
+# define cpu_has_mipsmt_pertccounters 0
+#endif /* CONFIG_MIPS_MT_SMP */
+
 /*
  * Guest capabilities
  */
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 6668f67a61c3..0595a974bc81 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -129,8 +129,6 @@ static struct mips_pmu mipspmu;
 
 
 #ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
-static int cpu_has_mipsmt_pertccounters;
-
 static DEFINE_RWLOCK(pmuint_rwlock);
 
 #if defined(CONFIG_CPU_BMIPS5000)
@@ -1723,7 +1721,6 @@ init_hw_perf_events(void)
 	}
 
 #ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
-	cpu_has_mipsmt_pertccounters = read_c0_config7() & (1<<19);
 	if (!cpu_has_mipsmt_pertccounters)
 		counters = counters_total_to_per_cpu(counters);
 #endif
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index c3e4c18ef8d4..7c04b17f4a48 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -36,7 +36,6 @@ static int perfcount_irq;
 #endif
 
 #ifdef CONFIG_MIPS_MT_SMP
-static int cpu_has_mipsmt_pertccounters;
 #define WHAT		(MIPS_PERFCTRL_MT_EN_VPE | \
 			 M_PERFCTL_VPEID(cpu_vpe_id(&current_cpu_data)))
 #define vpe_id()	(cpu_has_mipsmt_pertccounters ? \
@@ -326,7 +325,6 @@ static int __init mipsxx_init(void)
 	}
 
 #ifdef CONFIG_MIPS_MT_SMP
-	cpu_has_mipsmt_pertccounters = read_c0_config7() & (1<<19);
 	if (!cpu_has_mipsmt_pertccounters)
 		counters = counters_total_to_per_cpu(counters);
 #endif
-- 
2.7.4
