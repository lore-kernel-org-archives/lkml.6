Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeCQRKB (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 13:10:01 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36427 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752709AbeCQRJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 13:09:59 -0400
X-Google-Smtp-Source: AG47ELs9Dm+hfqugh1OF9c4kZOUIVZu7sG25jGcsqeWKkU60enx8uj1SLjYltPqt2ycV12zqJA0C+Q==
From: Eric Dumazet <edumazet@google.com>
To: x86 <x86@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH 1/2] x86, msr: add rdmsr_safe_on_cpu_resched() and use it in msr_read()
Date: Sat, 17 Mar 2018 10:09:52 -0700
Message-Id: <20180317170953.111610-1-edumazet@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed high latencies caused by a daemon periodically reading
various MSR on all cpus. KASAN kernels would see ~10ms latencies
simply reading one MSR. Even without KASAN, sending IPI to CPU
in deep sleep state or blocking hard IRQ in a a long section,
then waiting for the answer can consume hundreds of usec.

This patch adds rdmsr_safe_on_cpu_resched() which does not spin.

I use this function from msr_read() but future patches might
convert other callers to use this variant as well.

Overall daemon cpu usage was reduced by 35 %,
and latencies caused by msr_read() disappeared.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
---
 arch/x86/include/asm/msr.h |  1 +
 arch/x86/kernel/msr.c      |  2 +-
 arch/x86/lib/msr-smp.c     | 43 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 30df295f6d94c8ac6d87613acae8a32c50436c6d..117a286660c61cf9c10e68f0b48d27e2de17deab 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -321,6 +321,7 @@ int wrmsrl_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
 void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr *msrs);
 void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr *msrs);
 int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
+int rdmsr_safe_on_cpu_resched(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
 int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
 int rdmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
 int wrmsrl_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index ef688804f80d33088fef15448996a97f69e2b193..d464858cdcad59cb08a913388d60f1aee6d2277a 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -60,7 +60,7 @@ static ssize_t msr_read(struct file *file, char __user *buf,
 		return -EINVAL;	/* Invalid chunk size */
 
 	for (; count; count -= 8) {
-		err = rdmsr_safe_on_cpu(cpu, reg, &data[0], &data[1]);
+		err = rdmsr_safe_on_cpu_resched(cpu, reg, &data[0], &data[1]);
 		if (err)
 			break;
 		if (copy_to_user(tmp, &data, 8)) {
diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index 693cce0be82dffb822cecd0c7e38d2821aff896c..80eb10a759fd8356519c05db5c311285027d3463 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -2,6 +2,7 @@
 #include <linux/export.h>
 #include <linux/preempt.h>
 #include <linux/smp.h>
+#include <linux/completion.h>
 #include <asm/msr.h>
 
 static void __rdmsr_on_cpu(void *info)
@@ -159,6 +160,9 @@ static void __wrmsr_safe_on_cpu(void *info)
 	rv->err = wrmsr_safe(rv->msr_no, rv->reg.l, rv->reg.h);
 }
 
+/* Note: This version spins in smp_call_function_single().
+ * Consider using rdmsr_safe_on_cpu_resched() variant instead.
+ */
 int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
 {
 	int err;
@@ -175,6 +179,45 @@ int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
 }
 EXPORT_SYMBOL(rdmsr_safe_on_cpu);
 
+struct msr_info_completion {
+	struct msr_info		msr;
+	struct completion	done;
+};
+
+static void __rdmsr_safe_on_cpu_resched(void *info)
+{
+	struct msr_info_completion *rv = info;
+
+	__rdmsr_safe_on_cpu(&rv->msr);
+	complete(&rv->done);
+}
+
+/* This variant of rdmsr_safe_on_cpu() does reschedule instead of polling */
+int rdmsr_safe_on_cpu_resched(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
+{
+	struct msr_info_completion rv;
+	call_single_data_t csd = {
+		.func	= __rdmsr_safe_on_cpu_resched,
+		.info	= &rv,
+	};
+	int err;
+
+	memset(&rv, 0, sizeof(rv));
+	init_completion(&rv.done);
+	rv.msr.msr_no = msr_no;
+
+	err = smp_call_function_single_async(cpu, &csd);
+	if (!err) {
+		wait_for_completion(&rv.done);
+		err = rv.msr.err;
+	}
+	*l = rv.msr.reg.l;
+	*h = rv.msr.reg.h;
+
+	return err;
+}
+EXPORT_SYMBOL(rdmsr_safe_on_cpu_resched);
+
 int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
 {
 	int err;
-- 
2.16.2.804.g6dcf76e118-goog
