Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB26C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4577D20856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730838AbfAQIsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:48:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33840 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730777AbfAQIsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:48:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so476008wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 00:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xjjyx0Yjyd2PsWK9SkLNxWwUaL+ykG1i9L2fhMC829Y=;
        b=bTK04mHBdeHu694/s1C52GlmD/dWsshd4s4z/uLLHlk8Fdrq/ixJXEWHUk3cds9+XI
         E4j9NYEYny7LcjMuTUtHJuPOcN9TPlm5wi0IBoTCotqeCvMUCk1af69g3Uqif5aqyGpJ
         zv0927APQ9dBQhL6gNK98nM7KLMeVMqS1NSdGXbYaULcBB9wM05mNqHQHCfSMvl1A4GB
         5skT6AryGaFqcZ4DWpngtPJ8Dgry4HQv3ak5Cc+ds2rJub/g9vAerk2l6AxAjHdusUnm
         R9aWj6GG8vzC+j6iOEP/JrvtbibSLPW90TLM1ySQgfrTavXvbaHCau/O3FeATvIIJpEw
         EnKA==
X-Gm-Message-State: AJcUukcqBhas1aM2il1kbJWlh7RAa4WOS3Jon/PMG9RTjJr/BJwSMCxI
        ocBrJWNyEzeikfDvx9btRTU2Cg==
X-Google-Smtp-Source: ALg8bN4CChnSHyfPY9CSJGlALe5DKWmpxe3eNxb7aLHUkZQBp/s+Wnz1CQHlrn1wiDB9t3p/VAnPQw==
X-Received: by 2002:a1c:5f8a:: with SMTP id t132mr11105254wmb.40.1547714879728;
        Thu, 17 Jan 2019 00:47:59 -0800 (PST)
Received: from localhost.localdomain.home ([151.15.254.62])
        by smtp.gmail.com with ESMTPSA id 199sm41984992wmh.21.2019.01.17.00.47.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 00:47:59 -0800 (PST)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v6 4/5] sched/core: Prevent race condition between cpuset and __sched_setscheduler()
Date:   Thu, 17 Jan 2019 09:47:38 +0100
Message-Id: <20190117084739.17078-5-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190117084739.17078-1-juri.lelli@redhat.com>
References: <20190117084739.17078-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No synchronisation mechanism exists between the cpuset subsystem and calls
to function __sched_setscheduler(). As such, it is possible that new root
domains are created on the cpuset side while a deadline acceptance test
is carried out in __sched_setscheduler(), leading to a potential oversell
of CPU bandwidth.

Grab callback_lock from core scheduler, so to prevent situations such as
the one described above from happening.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

---

v5->v6: Added more descriptive comments about why callback_lock gives
the holder read-only access to cpusets.
---
 include/linux/cpuset.h |  6 ++++++
 kernel/cgroup/cpuset.c | 25 ++++++++++++++++++++++++-
 kernel/sched/core.c    | 10 ++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 934633a05d20..8e5a8dd0622b 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -55,6 +55,8 @@ extern void cpuset_init_smp(void);
 extern void cpuset_force_rebuild(void);
 extern void cpuset_update_active_cpus(void);
 extern void cpuset_wait_for_hotplug(void);
+extern void cpuset_read_only_lock(void);
+extern void cpuset_read_only_unlock(void);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
 extern void cpuset_cpus_allowed_fallback(struct task_struct *p);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
@@ -176,6 +178,10 @@ static inline void cpuset_update_active_cpus(void)
 
 static inline void cpuset_wait_for_hotplug(void) { }
 
+static inline void cpuset_read_only_lock(void) { }
+
+static inline void cpuset_read_only_unlock(void) { }
+
 static inline void cpuset_cpus_allowed(struct task_struct *p,
 				       struct cpumask *mask)
 {
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 54b8ff5de7c8..8ee1b24b6353 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -330,7 +330,8 @@ static struct cpuset top_cpuset = {
  * __alloc_pages().
  *
  * If a task is only holding callback_lock, then it has read-only
- * access to cpusets.
+ * access to cpusets. Mind that callback_lock might be grabbed from other
+ * subsystems as well (via cpuset_read_only_lock()).
  *
  * Now, the task_struct fields mems_allowed and mempolicy may be changed
  * by other task, we use alloc_lock in the task_struct fields to protect
@@ -3218,6 +3219,28 @@ void __init cpuset_init_smp(void)
 	BUG_ON(!cpuset_migrate_mm_wq);
 }
 
+/**
+ * cpuset_read_only_lock - Grab the callback_lock from cpuset subsystem.
+ *
+ * Description: As described in full details the comment above cpuset_mutex
+ * and callback_lock definitions, holding callback_lock gives the holder
+ * read-only access to cpusets. Even though it might look counter-intuitive
+ * (as callback_lock is a spinlock), in fact a task must hold both
+ * callback_lock _and_ cpuset_mutex to modify cpusets (write access).
+ */
+void cpuset_read_only_lock(void)
+{
+	raw_spin_lock(&callback_lock);
+}
+
+/**
+ * cpuset_read_only_unlock - Release the callback_lock from cpuset subsystem.
+ */
+void cpuset_read_only_unlock(void)
+{
+	raw_spin_unlock(&callback_lock);
+}
+
 /**
  * cpuset_cpus_allowed - return cpus_allowed mask from a tasks cpuset.
  * @tsk: pointer to task_struct from which to obtain cpuset->cpus_allowed.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f5263383170e..d928a42b8852 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4224,6 +4224,13 @@ static int __sched_setscheduler(struct task_struct *p,
 	rq = task_rq_lock(p, &rf);
 	update_rq_clock(rq);
 
+	/*
+	 * Make sure we don't race with the cpuset subsystem where root
+	 * domains can be rebuilt or modified while operations like DL
+	 * admission checks are carried out.
+	 */
+	cpuset_read_only_lock();
+
 	/*
 	 * Changing the policy of the stop threads its a very bad idea:
 	 */
@@ -4285,6 +4292,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	/* Re-check policy now with rq lock held: */
 	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
 		policy = oldpolicy = -1;
+		cpuset_read_only_unlock();
 		task_rq_unlock(rq, p, &rf);
 		goto recheck;
 	}
@@ -4342,6 +4350,7 @@ static int __sched_setscheduler(struct task_struct *p,
 
 	/* Avoid rq from going away on us: */
 	preempt_disable();
+	cpuset_read_only_unlock();
 	task_rq_unlock(rq, p, &rf);
 
 	if (pi)
@@ -4354,6 +4363,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	return 0;
 
 unlock:
+	cpuset_read_only_unlock();
 	task_rq_unlock(rq, p, &rf);
 	return retval;
 }
-- 
2.17.2

