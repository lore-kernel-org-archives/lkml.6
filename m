Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7BAC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED3A20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 07:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EED3A20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbeLKHm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 02:42:57 -0500
Received: from mga09.intel.com ([134.134.136.24]:36295 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbeLKHmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 02:42:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2018 23:42:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,341,1539673200"; 
   d="scan'208";a="117644287"
Received: from aubrey-skl.sh.intel.com ([10.239.53.9])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Dec 2018 23:42:52 -0800
From:   Aubrey Li <aubrey.li@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, aubrey.li@intel.com,
        linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH v4 2/2] proc: add AVX-512 usage to /proc/pid/status
Date:   Tue, 11 Dec 2018 08:24:48 +0800
Message-Id: <20181211002448.3520-2-aubrey.li@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211002448.3520-1-aubrey.li@intel.com>
References: <20181211002448.3520-1-aubrey.li@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AVX-512 components usage could cause core turbo frequency drop. So
it's useful to expose AVX-512 components usage as a heuristic hint
for the user space job scheduler to cluster the AVX-512 using tasks
together.

Example:
$ cat /proc/pid/status | grep AVX512_hint
AVX512_hint:   1

The hint number '0' indicates the task recently didn't use AVX-512
components thus unlikely has frequency drop issue. And the number '1'
indicates the task recently used AVX-512 components thus could cause
core frequency drop. User space tools may want to further check by:

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
 arch/x86/kernel/fpu/xstate.c | 19 +++++++++++++++++++
 fs/proc/array.c              |  5 +++++
 2 files changed, 24 insertions(+)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 87a57b7642d3..98baa47c97b0 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -7,6 +7,7 @@
 #include <linux/cpu.h>
 #include <linux/mman.h>
 #include <linux/pkeys.h>
+#include <linux/seq_file.h>
 
 #include <asm/fpu/api.h>
 #include <asm/fpu/internal.h>
@@ -1245,3 +1246,21 @@ int copy_user_to_xstate(struct xregs_state *xsave, const void __user *ubuf)
 
 	return 0;
 }
+
+/*
+ * Report CPU specific thread state
+ */
+void arch_task_state(struct seq_file *m, struct task_struct *task)
+{
+	/*
+	 * Check the processor and build option if AVX512 is supported.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_AVX512F))
+		return;
+	/*
+	 * Report AVX-512 components usage:
+	 */
+	seq_put_decimal_ull(m, "AVX512_hint:\t",
+				task->thread.fpu.avx512_usage ? 1 : 0);
+	seq_putc(m, '\n');
+}
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 0ceb3b6b37e7..dd88c2219f08 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -392,6 +392,10 @@ static inline void task_core_dumping(struct seq_file *m, struct mm_struct *mm)
 	seq_putc(m, '\n');
 }
 
+void __weak arch_task_state(struct seq_file *m, struct task_struct *task)
+{
+}
+
 int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 			struct pid *pid, struct task_struct *task)
 {
@@ -414,6 +418,7 @@ int proc_pid_status(struct seq_file *m, struct pid_namespace *ns,
 	task_cpus_allowed(m, task);
 	cpuset_task_status_allowed(m, task);
 	task_context_switch_counts(m, task);
+	arch_task_state(m, task);
 	return 0;
 }
 
-- 
2.17.1

