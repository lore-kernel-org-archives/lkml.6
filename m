Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeFCSYH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 14:24:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751132AbeFCSYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 14:24:06 -0400
From: David Arcari <darcari@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: David Arcari <darcari@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Donald Zickus <dzickus@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH] perf/x86: read the FREEZE_WHILE_SMM bit during boot
Date: Sun,  3 Jun 2018 14:23:43 -0400
Message-Id: <1528050223-144925-1-git-send-email-darcari@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some systems pressing the external NMI button is now failing to inject
an NMI 5-10% of the time.  This causes confusion for a user that expects
the NMI to dump the system.

Commit 6089327f5424 ("perf/x86: Add sysfs entry to freeze counters on SMI")
does not read the firmware setting of the FREEZE_WHILE_SMM bit and will
always clear it when the PMU is initialized.  As a result the performance
counters will always run and that greatly expands the race in which
external NMI will not be processed if a local NMI is already being
processed.

One option is to change default_do_nmi().  The code snippet below shows the
relevant portion of a patch that resolves the issue, but it is problematic
from a performance perspective and was dismissed.

-345,7 +345,17 @@ static void default_do_nmi(struct pt_regs *regs)
 		 */
 		if (handled > 1)
 			__this_cpu_write(swallow_nmi, true);
-		return;
+
+		/*
+		 * Unfortunately, there is a race condition which can
+		 * result in a missing an external NMI.  Typically, an
+		 * external NMI is processed on cpu 0.  Therefore, on
+		 * cpu 0 check for an external NMI before returning.
+		 */
+		if (smp_processor_id() ||
+		    (x86_platform.get_nmi_reason() & NMI_REASON_MASK) == 0) {
+			return;
+		}
 	}

Ultimately, the issue can be resolved by storing the default firmware
setting of FREEZE_WHILE_SMM before initializing the PMU.

Fixes: 6089327f5424 ("perf/x86: Add sysfs entry to freeze counters on SMI")

Signed-off-by: David Arcari <darcari@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Donald Zickus <dzickus@redhat.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 arch/x86/events/intel/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 707b2a9..fce98df 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3325,6 +3325,18 @@ static void flip_smm_bit(void *data)
 	}
 }
 
+static int read_smm_bit(void)
+{
+	u64 val;
+
+	if (!rdmsrl_safe(MSR_IA32_DEBUGCTLMSR, &val)) {
+		if (val & DEBUGCTLMSR_FREEZE_IN_SMM)
+			return 1;
+	}
+
+	return 0;
+}
+
 static void intel_pmu_cpu_starting(int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
@@ -4423,6 +4435,8 @@ __init int intel_pmu_init(void)
 		pr_cont("full-width counters, ");
 	}
 
+	x86_pmu.attr_freeze_on_smi = read_smm_bit();
+
 	kfree(to_free);
 	return 0;
 }
-- 
1.8.3.1
