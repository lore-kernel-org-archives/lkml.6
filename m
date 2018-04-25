Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756319AbeDYTqP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 15:46:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59865 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751084AbeDYTqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 15:46:14 -0400
Date: Wed, 25 Apr 2018 12:45:49 -0700
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-4e949e9b9d1e3edcdab3b54656c5851bd9e49c67@git.kernel.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, kan.liang@linux.intel.com, hpa@zytor.com
Reply-To: hpa@zytor.com, kan.liang@linux.intel.com, tglx@linutronix.de,
        peterz@infradead.org, linux-kernel@vger.kernel.org, mingo@kernel.org
In-Reply-To: <1524682637-63219-1-git-send-email-kan.liang@linux.intel.com>
References: <1524682637-63219-1-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel: Don't enable freeze-on-smi for
 PerfMon V1
Git-Commit-ID: 4e949e9b9d1e3edcdab3b54656c5851bd9e49c67
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

Commit-ID:  4e949e9b9d1e3edcdab3b54656c5851bd9e49c67
Gitweb:     https://git.kernel.org/tip/4e949e9b9d1e3edcdab3b54656c5851bd9e49c67
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Wed, 25 Apr 2018 14:57:17 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 25 Apr 2018 21:41:22 +0200

perf/x86/intel: Don't enable freeze-on-smi for PerfMon V1

The SMM freeze feature was introduced since PerfMon V2. But the current
code unconditionally enables the feature for all platforms. It can
generate #GP exception, if the related FREEZE_WHILE_SMM bit is set for
the machine with PerfMon V1.

To disable the feature for PerfMon V1, perf needs to
- Remove the freeze_on_smi sysfs entry by moving intel_pmu_attrs to
  intel_pmu, which is only applied to PerfMon V2 and later.
- Check the PerfMon version before flipping the SMM bit when starting CPU

Fixes: 6089327f5424 ("perf/x86: Add sysfs entry to freeze counters on SMI")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: ak@linux.intel.com
Cc: eranian@google.com
Cc: acme@redhat.com
Link: https://lkml.kernel.org/r/1524682637-63219-1-git-send-email-kan.liang@linux.intel.com

---
 arch/x86/events/intel/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 607bf565a90c..707b2a96e516 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3339,7 +3339,8 @@ static void intel_pmu_cpu_starting(int cpu)
 
 	cpuc->lbr_sel = NULL;
 
-	flip_smm_bit(&x86_pmu.attr_freeze_on_smi);
+	if (x86_pmu.version > 1)
+		flip_smm_bit(&x86_pmu.attr_freeze_on_smi);
 
 	if (!cpuc->shared_regs)
 		return;
@@ -3502,6 +3503,8 @@ static __initconst const struct x86_pmu core_pmu = {
 	.cpu_dying		= intel_pmu_cpu_dying,
 };
 
+static struct attribute *intel_pmu_attrs[];
+
 static __initconst const struct x86_pmu intel_pmu = {
 	.name			= "Intel",
 	.handle_irq		= intel_pmu_handle_irq,
@@ -3533,6 +3536,8 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.format_attrs		= intel_arch3_formats_attr,
 	.events_sysfs_show	= intel_event_sysfs_show,
 
+	.attrs			= intel_pmu_attrs,
+
 	.cpu_prepare		= intel_pmu_cpu_prepare,
 	.cpu_starting		= intel_pmu_cpu_starting,
 	.cpu_dying		= intel_pmu_cpu_dying,
@@ -3911,8 +3916,6 @@ __init int intel_pmu_init(void)
 
 	x86_pmu.max_pebs_events		= min_t(unsigned, MAX_PEBS_EVENTS, x86_pmu.num_counters);
 
-
-	x86_pmu.attrs			= intel_pmu_attrs;
 	/*
 	 * Quirk: v2 perfmon does not report fixed-purpose events, so
 	 * assume at least 3 events, when not running in a hypervisor:
