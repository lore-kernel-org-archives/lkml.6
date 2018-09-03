Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2878C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E782077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E782077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeICStC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 14:49:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56250 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeICSsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 14:48:51 -0400
Received: by mail-wm0-f68.google.com with SMTP id f21-v6so1389624wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 07:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v0jayrGp8UDsEsbUDSIyXVkXNuJR5R5Ac/Dnq7npMJE=;
        b=R8gFj6UssAgTB5AdM7xkeJtmTZbDWSDl8fDE7B0rfnHk7IKJ2zzuSfDPAzu9PI8zbu
         yZy8nOMXo2WnTUV0MUjqdvUgD7jiiCa8RJJmjq1kK1z3PRO20b5q00A+h0kRSUdYWKuU
         q30lIQ7nVj++rUL64F6+3jnozyNeaDz8Xxz2zHwvZlfGeEOvMkeXMIpfOB39xqlbzoBL
         JEOFIxPxlRPbPHsDs9lAbySwYLEJTqDcDbNz7YxVci1/r8Pz9soPwHWkFfKD33jcFqOn
         NN5RumgYIv64pEw/I0PnX3kdEvJUPN4qm2M/y7O8ci1CEjDx9hWcy9U8/v39mUasABbL
         +Ohw==
X-Gm-Message-State: APzg51CaZIXEk5cc4DmqLeeqKjFxRjVl/eNs9ZT+5fRJnQ7FbNC2WkFe
        PCFuuLGfr+2GtBYJuyKseLX4/g==
X-Google-Smtp-Source: ANB0Vdb5G/qfYZ0yqUoYAe/4Jyv2FfJsMyZL1Uv3G+ubcorph8I0vuR4f+dP9f8j8txC+NtaogKPGA==
X-Received: by 2002:a1c:5802:: with SMTP id m2-v6mr5022888wmb.154.1535984904486;
        Mon, 03 Sep 2018 07:28:24 -0700 (PDT)
Received: from localhost.localdomain.com ([151.15.227.30])
        by smtp.gmail.com with ESMTPSA id b74-v6sm14175880wma.8.2018.09.03.07.28.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 07:28:23 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v5 4/5] sched/core: Prevent race condition between cpuset and __sched_setscheduler()
Date:   Mon,  3 Sep 2018 16:28:00 +0200
Message-Id: <20180903142801.20046-5-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180903142801.20046-1-juri.lelli@redhat.com>
References: <20180903142801.20046-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

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

v4->v5: grab callback_lock instead of cpuset_mutex, as callback_lock is
enough to get read-only access to cpusets [1] and it can be easily
converted to be a raw_spinlock (done in previous - new - patch).

[1] https://elixir.bootlin.com/linux/latest/source/kernel/cgroup/cpuset.c#L275
---
 include/linux/cpuset.h |  6 ++++++
 kernel/cgroup/cpuset.c | 18 ++++++++++++++++++
 kernel/sched/core.c    | 10 ++++++++++
 3 files changed, 34 insertions(+)

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
index 5b43f482fa0f..8dc26005bb1e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2410,6 +2410,24 @@ void __init cpuset_init_smp(void)
 	BUG_ON(!cpuset_migrate_mm_wq);
 }
 
+/**
+ * cpuset_read_only_lock - Grab the callback_lock from another subsysytem
+ *
+ * Description: Gives the holder read-only access to cpusets.
+ */
+void cpuset_read_only_lock(void)
+{
+	raw_spin_lock(&callback_lock);
+}
+
+/**
+ * cpuset_read_only_unlock - Release the callback_lock from another subsysytem
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
index 22f5622cba69..ac11ee599968 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4228,6 +4228,13 @@ static int __sched_setscheduler(struct task_struct *p,
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
@@ -4289,6 +4296,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	/* Re-check policy now with rq lock held: */
 	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
 		policy = oldpolicy = -1;
+		cpuset_read_only_unlock();
 		task_rq_unlock(rq, p, &rf);
 		goto recheck;
 	}
@@ -4346,6 +4354,7 @@ static int __sched_setscheduler(struct task_struct *p,
 
 	/* Avoid rq from going away on us: */
 	preempt_disable();
+	cpuset_read_only_unlock();
 	task_rq_unlock(rq, p, &rf);
 
 	if (pi)
@@ -4358,6 +4367,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	return 0;
 
 unlock:
+	cpuset_read_only_unlock();
 	task_rq_unlock(rq, p, &rf);
 	return retval;
 }
-- 
2.17.1

