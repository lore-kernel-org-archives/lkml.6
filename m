Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891C2C282D7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635DF21B18
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfBLCT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:19:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:25316 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbfBLCTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 21:19:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 18:19:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,361,1544515200"; 
   d="scan'208";a="123748588"
Received: from aubrey-skl.sh.intel.com ([10.239.53.19])
  by fmsmga008.fm.intel.com with ESMTP; 11 Feb 2019 18:19:21 -0800
From:   Aubrey Li <aubrey.li@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, aubrey.li@intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH v9 2/3] x86,/proc/pid/status: Add AVX-512 usage elapsed time
Date:   Tue, 12 Feb 2019 02:59:30 +0800
Message-Id: <20190211185931.4386-2-aubrey.li@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211185931.4386-1-aubrey.li@intel.com>
References: <20190211185931.4386-1-aubrey.li@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AVX-512 components use could cause core turbo frequency drop. So
it's useful to expose AVX-512 usage elapsed time as a heuristic hint
for the user space job scheduler to cluster the AVX-512 using tasks
together.

Example:
$ cat /proc/pid/status | grep AVX512_elapsed_ms
AVX512_elapsed_ms:      1020

The number '1020' denotes 1020 millisecond elapsed since last time
context switch the off-CPU task using AVX-512 components, thus the
task could cause core frequency drop.

Or:
$ cat /proc/pid/status | grep AVX512_elapsed_ms
AVX512_elapsed_ms:      -1

The number '-1' indicates the task didn't use AVX-512 components
before thus unlikely has frequency drop issue.

User space tools may want to further check by:

$ perf stat --pid <pid> -e core_power.lvl2_turbo_license -- sleep 1

 Performance counter stats for process id '3558':

     3,251,565,961      core_power.lvl2_turbo_license

       1.004031387 seconds time elapsed

Non-zero counter value confirms that the task causes frequency drop.

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
---
 arch/x86/include/asm/processor.h |  2 ++
 arch/x86/kernel/fpu/xstate.c     | 41 ++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index d53c54b842da..60ee932070fe 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -996,5 +996,7 @@ enum l1tf_mitigations {
 };
 
 extern enum l1tf_mitigations l1tf_mitigation;
+/* Add support for architecture specific output in /proc/pid/status */
+extern void arch_proc_pid_status(struct seq_file *m, struct task_struct *task);
 
 #endif /* _ASM_X86_PROCESSOR_H */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 87a57b7642d3..dfd7cf847bc3 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -7,6 +7,7 @@
 #include <linux/cpu.h>
 #include <linux/mman.h>
 #include <linux/pkeys.h>
+#include <linux/seq_file.h>
 
 #include <asm/fpu/api.h>
 #include <asm/fpu/internal.h>
@@ -1245,3 +1246,43 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 
 	return 0;
 }
+
+/*
+ * Report the amount of time elapsed in millisecond since last AVX512
+ * use in the task.
+ */
+void avx512_status(struct seq_file *m, struct task_struct *task)
+{
+	unsigned long timestamp = task->thread.fpu.avx512_timestamp;
+	long delta;
+
+	if (!timestamp) {
+		/*
+		 * Report -1 if no AVX512 usage
+		 */
+		delta = -1;
+	} else {
+		delta = (long)(jiffies - timestamp);
+		/*
+		 * Cap to LONG_MAX if time difference > LONG_MAX
+		 */
+		if (delta < 0)
+			delta = LONG_MAX;
+		delta = jiffies_to_msecs(delta);
+	}
+
+	seq_put_decimal_ll(m, "AVX512_elapsed_ms:\t", delta);
+	seq_putc(m, '\n');
+}
+
+/*
+ * Report architecture specific information
+ */
+void arch_proc_pid_status(struct seq_file *m, struct task_struct *task)
+{
+	/*
+	 * Report AVX512 state if the processor and build option supported.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_AVX512F))
+		avx512_status(m, task);
+}
-- 
2.17.1

