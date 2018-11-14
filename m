Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120C5C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 649B82250E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qfd2umRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 649B82250E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbeKNMsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:48:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727005AbeKNMsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:48:12 -0500
Received: from lerouge.suse.de (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3283A223C8;
        Wed, 14 Nov 2018 02:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542163622;
        bh=lv2FFbUWXyRZhn4PpzqhJG4IReAIUhJCkCG8L1rHVWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qfd2umRPveKRuVfbeCko+bMOrCLaL3/WAJwhTEOux396C1K/1D/z2KyluVi75bKB7
         zg7tQBFppEtOOHs2IcQqdv+ojcIEHWTQzS3DENJFWdRhe6PXWxL8F9Ru/PT3SrMgA8
         Iv/N1uAD9sKhjFgBsX6cxKJlsitJIn+AfYIgKqWU=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 20/25] sched/kcpustat: Introduce vtime-aware kcpustat accessor
Date:   Wed, 14 Nov 2018 03:46:04 +0100
Message-Id: <1542163569-20047-21-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542163569-20047-1-git-send-email-frederic@kernel.org>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kcpustat is not correctly supported on nohz_full CPUs. The tick doesn't
fire and the cputime therefore doesn't move forward. The issue has shown
up after the vanishing of the remaining 1Hz which has made the issue
visible.

We are solving that with tracking the task running on a CPU through RCU
and reading its vtime delta that we add to the raw kcpustat values.

We make sure that we fetch a coherent raw-kcpustat/vtime-delta couple
sequence while checking that the CPU referred by the target vtime is the
correct one, under the locked vtime seqcount.

Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/kernel_stat.h | 25 +++++++++++++
 kernel/sched/cputime.c      | 90 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 049d973..2d4d301 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -79,6 +79,31 @@ static inline unsigned int kstat_cpu_irqs_sum(unsigned int cpu)
 	return kstat_cpu(cpu).irqs_sum;
 }
 
+
+static inline void kcpustat_cputime_raw(struct kernel_cpustat *kcpustat,
+					u64 *user, u64 *nice, u64 *system,
+					u64 *guest, u64 *guest_nice)
+{
+	*user = kcpustat->cpustat[CPUTIME_USER];
+	*nice = kcpustat->cpustat[CPUTIME_NICE];
+	*system = kcpustat->cpustat[CPUTIME_SYSTEM];
+	*guest = kcpustat->cpustat[CPUTIME_GUEST];
+	*guest_nice = kcpustat->cpustat[CPUTIME_GUEST_NICE];
+}
+
+#ifdef CONFIG_VIRT_CPU_ACCOUNTING_GEN
+extern void kcpustat_cputime(struct kernel_cpustat *kcpustat, int cpu,
+			     u64 *user, u64 *nice, u64 *system,
+			     u64 *guest, u64 *guest_nice);
+#else
+static inline void kcpustat_cputime(struct kernel_cpustat *kcpustat, int cpu,
+				    u64 *user, u64 *nice, u64 *system,
+				    u64 *guest, u64 *guest_nice)
+{
+	kcpustat_cputime_raw(kcpustat, user, nice, system, guest, guest_nice);
+}
+#endif
+
 extern void account_user_time(struct task_struct *, u64);
 extern void account_guest_time(struct task_struct *, u64);
 extern void account_system_time(struct task_struct *, int, u64);
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 2b35132..3afde9f 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -1024,4 +1024,94 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
 			*utime += vtime->utime + delta;
 	} while (read_seqcount_retry(&vtime->seqcount, seq));
 }
+
+static int kcpustat_vtime(struct kernel_cpustat *kcpustat, struct vtime *vtime,
+			  int cpu, u64 *user, u64 *nice,
+			  u64 *system, u64 *guest, u64 *guest_nice)
+{
+	unsigned int seq;
+	u64 delta;
+	int err;
+
+	do {
+		seq = read_seqcount_begin(&vtime->seqcount);
+
+		/*
+		 * We raced against context switch, fetch the
+		 * kcpustat task again.
+		 */
+		if (vtime->cpu != cpu && vtime->cpu != -1) {
+			err = -EAGAIN;
+			continue;
+		}
+
+		err = 0;
+
+		kcpustat_cputime_raw(kcpustat, user, nice,
+				     system, guest, guest_nice);
+
+		/* Task is sleeping, dead or idle, nothing to add */
+		if (vtime->state < VTIME_SYS)
+			continue;
+
+		delta = vtime_delta(vtime);
+
+		/*
+		 * Task runs either in user (including guest) or kernel space,
+		 * add pending nohz time to the right place.
+		 */
+		if (vtime->state == VTIME_SYS) {
+			*system += vtime->stime + delta;
+		} else if (vtime->state == VTIME_USER) {
+			if (vtime->nice)
+				*nice += vtime->utime + delta;
+			else
+				*user += vtime->utime + delta;
+		} else {
+			WARN_ON_ONCE(vtime->state != VTIME_GUEST);
+			if (vtime->nice) {
+				*guest_nice += vtime->gtime + delta;
+				*nice += vtime->gtime + delta;
+			} else {
+				*guest += vtime->gtime + delta;
+				*user += vtime->gtime + delta;
+			}
+		}
+	} while (read_seqcount_retry(&vtime->seqcount, seq));
+
+	return err;
+}
+
+void kcpustat_cputime(struct kernel_cpustat *kcpustat, int cpu,
+		      u64 *user, u64 *nice, u64 *system,
+		      u64 *guest, u64 *guest_nice)
+{
+	struct task_struct *curr;
+	struct vtime *vtime;
+	int err;
+
+	if (!vtime_accounting_enabled()) {
+		kcpustat_cputime_raw(kcpustat, user, nice,
+				     system, guest, guest_nice);
+		return;
+	}
+
+	rcu_read_lock();
+
+	do {
+		curr = rcu_dereference(kcpustat->curr);
+		if (!curr) {
+			kcpustat_cputime_raw(kcpustat, user, nice,
+					     system, guest, guest_nice);
+			break;
+		}
+
+		vtime = &curr->vtime;
+		err = kcpustat_vtime(kcpustat, vtime, cpu, user,
+				     nice, system, guest, guest_nice);
+	} while (err == -EAGAIN);
+
+	rcu_read_unlock();
+}
+
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
-- 
2.7.4

