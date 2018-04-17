Return-Path: <christophe.leroy@c-s.fr>
X-Google-Smtp-Source: AIpwx4/uhdVQeG2quTL0H9U8lNpS3SoKfg6bYhYgYxs7R0EW3waJL/XtjVEnul9vqYdhiM6ZAM1G
ARC-Seal: i=1; a=rsa-sha256; t=1523980646; cv=none;
        d=google.com; s=arc-20160816;
        b=VAKjiwrNeJqO1oWto4uQuI44G98S79+YQgun1xna1i6U4pXo1aZe3oUeU8jntfoUo5
         WCGE2TgVVEbGkbGJ/VYCEeTKSJ3nfVmqvmwE6ckopR0jEoYtg2OTAJSJUbmzjxdMCKnC
         Qxf+tPPud9CaTBLSIzLeMnXGghw34gt6ky7vBWpKnFdEx5ztm0SWeDNRW7aq1xGpRs5Z
         xWiOIFmVNaNmeB9fGhjJNoZ6xsm6z2aC9dA1u29BvCKlqWxk3LtmCR8iRlxuz7wv7hi9
         Zd1qGjDozEDPw1Q4gHmqsKaQB/kkU5iy2lMpr1tKZiNI5A+q0PRp6a+MCU6x3fzpCb4f
         cy+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:cc:to:subject:from:arc-authentication-results;
        bh=Pp3dNKhsUR2wTzmzeqOS+SL0lvb5mDKikBZONU6yEvU=;
        b=PimQp27XlozbPiBoiUefr4IAJ+Kh8gwvZLBGSCvdLjpB2uXTmE+WLT2iGE+FsaEw0S
         SpIAnmkzPqjGFJGG8fGmuRr+/J16R8XGupU1tKYzWvyg69ZmwgqSUrMZWY+Gp1F1NK/v
         7HfHrSd14QH5xCl4eXvZ7u9Z5ZXrMHmFfOrLyfBoYob8Q1rg0/cOqUTWjm6BB49Kp3Jf
         Or9NczDFjMlsc7us/R1hiNU8/bLmTUiZJUMtDJ9JTkIWpxg7nkldlnUEQ/ifwjoKZRPu
         6BH6TKQLWRi7VgVCVQINW746+hP32x1xj7lV0dA5tJbQKU/YZsI32jhOej5cDv0gLOzt
         rTGA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christophe.leroy@c-s.fr designates 93.17.236.30 as permitted sender) smtp.mailfrom=christophe.leroy@c-s.fr
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christophe.leroy@c-s.fr designates 93.17.236.30 as permitted sender) smtp.mailfrom=christophe.leroy@c-s.fr
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] kernel/sched: declare account_system_time() static
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Message-Id: <20180417155725.BE7D46C0C0@po15720vm.idsi0.si.c-s.fr>
Date: Tue, 17 Apr 2018 17:57:25 +0200 (CEST)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598009530386335146?=
X-GMAIL-MSGID: =?utf-8?q?1598009530386335146?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

account_system_time() is used only from one file, and only
when CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not selected

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 include/linux/kernel_stat.h |  1 -
 kernel/sched/cputime.c      | 50 ++++++++++++++++++++++-----------------------
 2 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 7ee2bb43b251..051b53055d5d 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -80,7 +80,6 @@ static inline unsigned int kstat_cpu_irqs_sum(unsigned int cpu)
 
 extern void account_user_time(struct task_struct *, u64);
 extern void account_guest_time(struct task_struct *, u64);
-extern void account_system_time(struct task_struct *, int, u64);
 extern void account_system_index_time(struct task_struct *, u64,
 				      enum cpu_usage_stat);
 extern void account_steal_time(u64);
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 0796f938c4f0..0ccf4865df35 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -175,31 +175,6 @@ void account_system_index_time(struct task_struct *p,
 }
 
 /*
- * Account system CPU time to a process.
- * @p: the process that the CPU time gets accounted to
- * @hardirq_offset: the offset to subtract from hardirq_count()
- * @cputime: the CPU time spent in kernel space since the last update
- */
-void account_system_time(struct task_struct *p, int hardirq_offset, u64 cputime)
-{
-	int index;
-
-	if ((p->flags & PF_VCPU) && (irq_count() - hardirq_offset == 0)) {
-		account_guest_time(p, cputime);
-		return;
-	}
-
-	if (hardirq_count() - hardirq_offset)
-		index = CPUTIME_IRQ;
-	else if (in_serving_softirq())
-		index = CPUTIME_SOFTIRQ;
-	else
-		index = CPUTIME_SYSTEM;
-
-	account_system_index_time(p, cputime, index);
-}
-
-/*
  * Account for involuntary wait time.
  * @cputime: the CPU time spent in involuntary wait
  */
@@ -467,6 +442,31 @@ void thread_group_cputime_adjusted(struct task_struct *p, u64 *ut, u64 *st)
 #else /* !CONFIG_VIRT_CPU_ACCOUNTING_NATIVE: */
 
 /*
+ * Account system CPU time to a process.
+ * @p: the process that the CPU time gets accounted to
+ * @hardirq_offset: the offset to subtract from hardirq_count()
+ * @cputime: the CPU time spent in kernel space since the last update
+ */
+static void account_system_time(struct task_struct *p, int hardirq_offset, u64 cputime)
+{
+	int index;
+
+	if ((p->flags & PF_VCPU) && (irq_count() - hardirq_offset == 0)) {
+		account_guest_time(p, cputime);
+		return;
+	}
+
+	if (hardirq_count() - hardirq_offset)
+		index = CPUTIME_IRQ;
+	else if (in_serving_softirq())
+		index = CPUTIME_SOFTIRQ;
+	else
+		index = CPUTIME_SYSTEM;
+
+	account_system_index_time(p, cputime, index);
+}
+
+/*
  * Account a single tick of CPU time.
  * @p: the process that the CPU time gets accounted to
  * @user_tick: indicates if the tick is a user or a system tick
-- 
2.13.3
