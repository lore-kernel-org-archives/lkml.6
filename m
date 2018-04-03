Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932193AbeDCMdF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 08:33:05 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:50369 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932081AbeDCMdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 08:33:03 -0400
From: Matt Redfearn <matt.redfearn@mips.com>
To: James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
CC: <linux-mips@linux-mips.org>, Matt Redfearn <matt.redfearn@mips.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Maciej W. Rozycki" <macro@mips.com>,
        Peter Zijlstra <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        "Paul Burton" <paul.burton@mips.com>, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 1/5] MIPS: perf: More robustly probe for the presence of per-tc counters
Date: Tue, 3 Apr 2018 13:31:27 +0100
Message-ID: <1522758691-17003-2-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522758691-17003-1-git-send-email-matt.redfearn@mips.com>
References: <1522758691-17003-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1522758734-452059-13817-58425-11
X-BESS-VER: 2018.4.1-r1803302241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191653
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Processors implementing the MIPS MT ASE may have performance counters
implemented per core or per TC. Processors implemented by MIPS and the
BMIPS5000 signify presence per TC through a bit in the implementation
specific Config7 register. Currently the code which probes for their
presence blindly reads a magic number corresponding to this bit, despite
it potentially having a different meaning in the CPU implementation.

Fix this by introducing probe_mipsmt_pertccounters() to probe for their
presence. This detects the ases implemented in the CPU, and reads any
implementation specific bit flagging their presence. In the case of MIPS
and BMIPS5000 implementations, this bit is Config7.PTC. A definition of
this bit is added in mipsregs.h for both MIPS Technologies
implementations and BMIPS5000.

Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
---

The test of Config7.PTC was previously enabled when CONFIG_BMIPS5000 was
enabled, whereas now it is based on Broadcom PRID. If this bit is not
present / defined for all Broadcom implementations, please could someone
present a correct alternative means to detect it?

---
 arch/mips/include/asm/mipsregs.h     | 10 ++++++++++
 arch/mips/kernel/perf_event_mipsxx.c | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 858752dac337..4f61e16f43c3 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -684,6 +684,16 @@
 #define MIPS_CONF7_IAR		(_ULCAST_(1) << 10)
 #define MIPS_CONF7_AR		(_ULCAST_(1) << 16)
 
+/* Config7 Bits specific to MIPS Technologies. */
+
+/* Performance counters implemented Per TC */
+#define MTI_CONF7_PTC		(_ULCAST_(1) << 19)
+
+/* Config7 Bits specific to BMIPS5000. */
+
+/* Performance counters implemented Per TC */
+#define BRCM_CONF7_PTC		(_ULCAST_(1) << 19)
+
 /* WatchLo* register definitions */
 #define MIPS_WATCHLO_IRW	(_ULCAST_(0x7) << 0)
 
diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 6668f67a61c3..3308b35d6680 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -1708,6 +1708,36 @@ static const struct mips_perf_event *xlp_pmu_map_raw_event(u64 config)
 	return &raw_event;
 }
 
+#ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
+/*
+ * The MIPS MT ASE specifies that performance counters may be implemented
+ * per core or per TC. If implemented per TC then all Linux CPUs have their
+ * own unique counters. If implemented per core, then VPEs in the core must
+ * treat the counters as a shared resource.
+ * Probe for the presence of per-TC counters
+ */
+static int probe_mipsmt_pertccounters(void)
+{
+	struct cpuinfo_mips *c = &current_cpu_data;
+
+	/* Non-MT cores by definition cannot implement per-TC counters */
+	if (!cpu_has_mipsmt)
+		return 0;
+
+	switch (c->processor_id & PRID_COMP_MASK) {
+	case PRID_COMP_MIPS:
+		/* MTI implementations use CONFIG7.PTC to signify presence */
+		return read_c0_config7() & MTI_CONF7_PTC;
+	case PRID_COMP_BROADCOM:
+		/* BMIPS5000 uses CONFIG7.PTC to signify presence */
+		return read_c0_config7() & BRCM_CONF7_PTC;
+	default:
+		break;
+	}
+	return 0;
+}
+#endif /* CONFIG_MIPS_PERF_SHARED_TC_COUNTERS */
+
 static int __init
 init_hw_perf_events(void)
 {
@@ -1723,7 +1753,7 @@ init_hw_perf_events(void)
 	}
 
 #ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
-	cpu_has_mipsmt_pertccounters = read_c0_config7() & (1<<19);
+	cpu_has_mipsmt_pertccounters = probe_mipsmt_pertccounters();
 	if (!cpu_has_mipsmt_pertccounters)
 		counters = counters_total_to_per_cpu(counters);
 #endif
-- 
2.7.4
