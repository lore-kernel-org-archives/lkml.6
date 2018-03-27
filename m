Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752190AbeC0KKk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 06:10:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42141 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750978AbeC0KKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 06:10:38 -0400
Date: Tue, 27 Mar 2018 03:10:05 -0700
From: tip-bot for Eric Dumazet <tipbot@zytor.com>
Message-ID: <tip-07cde313b2d21f728cec2836db7cdb55476f7a26@git.kernel.org>
Cc: mingo@kernel.org, bp@alien8.de, eric.dumazet@gmail.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        edumazet@google.com, hughd@google.com
Reply-To: bp@alien8.de, mingo@kernel.org, eric.dumazet@gmail.com,
        hughd@google.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        edumazet@google.com, tglx@linutronix.de
In-Reply-To: <20180323215818.127774-1-edumazet@google.com>
References: <20180323215818.127774-1-edumazet@google.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cleanups] x86/msr: Allow rdmsr_safe_on_cpu() to schedule
Git-Commit-ID: 07cde313b2d21f728cec2836db7cdb55476f7a26
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

Commit-ID:  07cde313b2d21f728cec2836db7cdb55476f7a26
Gitweb:     https://git.kernel.org/tip/07cde313b2d21f728cec2836db7cdb55476f7a26
Author:     Eric Dumazet <edumazet@google.com>
AuthorDate: Fri, 23 Mar 2018 14:58:17 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 27 Mar 2018 12:01:47 +0200

x86/msr: Allow rdmsr_safe_on_cpu() to schedule

High latencies can be observed caused by a daemon periodically reading
various MSR on all cpus. On KASAN enabled kernels ~10ms latencies can be
observed simply reading one MSR. Even without KASAN, sending an IPI to a
CPU, which is in a deep sleep state or in a long hard IRQ disabled section,
waiting for the answer can consume hundreds of microseconds.

All usage sites are in preemptible context, convert rdmsr_safe_on_cpu() to
use a completion instead of busy polling.

Overall daemon cpu usage was reduced by 35 %, and latencies caused by
msr_read() disappeared.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ingo Molnar <mingo@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Link: https://lkml.kernel.org/r/20180323215818.127774-1-edumazet@google.com

---
 arch/x86/lib/msr-smp.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index 693cce0be82d..761ba062afda 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -2,6 +2,7 @@
 #include <linux/export.h>
 #include <linux/preempt.h>
 #include <linux/smp.h>
+#include <linux/completion.h>
 #include <asm/msr.h>
 
 static void __rdmsr_on_cpu(void *info)
@@ -143,13 +144,19 @@ void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr *msrs)
 }
 EXPORT_SYMBOL(wrmsr_on_cpus);
 
+struct msr_info_completion {
+	struct msr_info		msr;
+	struct completion	done;
+};
+
 /* These "safe" variants are slower and should be used when the target MSR
    may not actually exist. */
 static void __rdmsr_safe_on_cpu(void *info)
 {
-	struct msr_info *rv = info;
+	struct msr_info_completion *rv = info;
 
-	rv->err = rdmsr_safe(rv->msr_no, &rv->reg.l, &rv->reg.h);
+	rv->msr.err = rdmsr_safe(rv->msr.msr_no, &rv->msr.reg.l, &rv->msr.reg.h);
+	complete(&rv->done);
 }
 
 static void __wrmsr_safe_on_cpu(void *info)
@@ -161,17 +168,26 @@ static void __wrmsr_safe_on_cpu(void *info)
 
 int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
 {
+	struct msr_info_completion rv;
+	call_single_data_t csd = {
+		.func	= __rdmsr_safe_on_cpu,
+		.info	= &rv,
+	};
 	int err;
-	struct msr_info rv;
 
 	memset(&rv, 0, sizeof(rv));
+	init_completion(&rv.done);
+	rv.msr.msr_no = msr_no;
 
-	rv.msr_no = msr_no;
-	err = smp_call_function_single(cpu, __rdmsr_safe_on_cpu, &rv, 1);
-	*l = rv.reg.l;
-	*h = rv.reg.h;
+	err = smp_call_function_single_async(cpu, &csd);
+	if (!err) {
+		wait_for_completion(&rv.done);
+		err = rv.msr.err;
+	}
+	*l = rv.msr.reg.l;
+	*h = rv.msr.reg.h;
 
-	return err ? err : rv.err;
+	return err;
 }
 EXPORT_SYMBOL(rdmsr_safe_on_cpu);
 
