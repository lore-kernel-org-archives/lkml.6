Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2D47BC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC737208B4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC737208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964775AbeFMMRh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:17:37 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36499 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935539AbeFMMRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:17:32 -0400
Received: by mail-wm0-f65.google.com with SMTP id v131-v6so4994413wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 05:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=azAIoic78v8lMlwuZLVdpRYUlXHVjqeoV6ZQxUoPOQQ=;
        b=jTiMLgUff8xDJL+Iza0bGtN3vCzxRqwINm6vNufJPdq3W7kdWWiCBuFjPixijrlKKG
         0/m5Sl99+EQKL0C+3RfUJKAJfAK9tg+Qf8VdxIQ3vw0PMeNyzCJGBCszcHqTYvg+Y+Hy
         NiV3R3jd2KWnFdMIKFfAHZcWgbkWiU0TechMS2YrPi76k7wv+E8XEyKXoP/3/lf2A6XR
         P49MsdralO6HCKQi88OzF1W4qywRoHQduKlL96+6uHFwz96UMGmRYvH2x8jbLGgpFrUE
         x86EmzUb7x2wmL7ghGYGLgWL6o6rNUrVlLxPJN9XYxC22E5Om5Qj1y1nAPdZ7LzcVmJr
         H9sw==
X-Gm-Message-State: APt69E2N+je/PiEyKOMoEpIWUuH4G7UYXnpBbYhlsxg5HI9UJzjU2fK1
        38i9pOFICzedl1E0zaJQ8AhxEw==
X-Google-Smtp-Source: ADUXVKKCWTwGb7qpabu8rHccSb6A/W4A2H3LC7zaEQwHEfoRwyeuSO33iDErhm5Sk8Z3f96bTPEeNw==
X-Received: by 2002:a1c:7113:: with SMTP id m19-v6mr3393058wmc.150.1528892251270;
        Wed, 13 Jun 2018 05:17:31 -0700 (PDT)
Received: from localhost.localdomain.com ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id 137-v6sm4943673wmv.28.2018.06.13.05.17.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 05:17:30 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v4 4/5] sched/core: Prevent race condition between cpuset and __sched_setscheduler()
Date:   Wed, 13 Jun 2018 14:17:10 +0200
Message-Id: <20180613121711.5018-5-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180613121711.5018-1-juri.lelli@redhat.com>
References: <20180613121711.5018-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

No synchronisation mechanism exist between the cpuset subsystem and calls
to function __sched_setscheduler().  As such it is possible that new root
domains are created on the cpuset side while a deadline acceptance test
is carried out in __sched_setscheduler(), leading to a potential oversell
of CPU bandwidth.

By making available the cpuset_mutex to the core scheduler it is possible
to prevent situations such as the one described above from happening.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
[fixed missing cpuset_unlock() and changed to use mutex_trylock()]
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/cpuset.h |  6 ++++++
 kernel/cgroup/cpuset.c | 16 ++++++++++++++++
 kernel/sched/core.c    | 14 ++++++++++++++
 3 files changed, 36 insertions(+)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 934633a05d20..a1970862ab8e 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -55,6 +55,8 @@ extern void cpuset_init_smp(void);
 extern void cpuset_force_rebuild(void);
 extern void cpuset_update_active_cpus(void);
 extern void cpuset_wait_for_hotplug(void);
+extern int cpuset_lock(void);
+extern void cpuset_unlock(void);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
 extern void cpuset_cpus_allowed_fallback(struct task_struct *p);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
@@ -176,6 +178,10 @@ static inline void cpuset_update_active_cpus(void)
 
 static inline void cpuset_wait_for_hotplug(void) { }
 
+static inline int cpuset_lock(void) { return 1; }
+
+static inline void cpuset_unlock(void) { }
+
 static inline void cpuset_cpus_allowed(struct task_struct *p,
 				       struct cpumask *mask)
 {
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b42037e6e81d..d26fd4795aa3 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2409,6 +2409,22 @@ void __init cpuset_init_smp(void)
 	BUG_ON(!cpuset_migrate_mm_wq);
 }
 
+/**
+ * cpuset_lock - Grab the cpuset_mutex from another subsysytem
+ */
+int cpuset_lock(void)
+{
+	return mutex_trylock(&cpuset_mutex);
+}
+
+/**
+ * cpuset_unlock - Release the cpuset_mutex from another subsysytem
+ */
+void cpuset_unlock(void)
+{
+	mutex_unlock(&cpuset_mutex);
+}
+
 /**
  * cpuset_cpus_allowed - return cpus_allowed mask from a tasks cpuset.
  * @tsk: pointer to task_struct from which to obtain cpuset->cpus_allowed.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ca788f74259d..a5b0c6c25b44 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4218,6 +4218,14 @@ static int __sched_setscheduler(struct task_struct *p,
 		if (attr->sched_flags & SCHED_FLAG_SUGOV)
 			return -EINVAL;
 
+		/*
+		 * Make sure we don't race with the cpuset subsystem where root
+		 * domains can be rebuilt or modified while operations like DL
+		 * admission checks are carried out.
+		 */
+		if (!cpuset_lock())
+			return -EBUSY;
+
 		retval = security_task_setscheduler(p);
 		if (retval)
 			return retval;
@@ -4295,6 +4303,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
 		policy = oldpolicy = -1;
 		task_rq_unlock(rq, p, &rf);
+		if (user)
+			cpuset_unlock();
 		goto recheck;
 	}
 
@@ -4352,6 +4362,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	/* Avoid rq from going away on us: */
 	preempt_disable();
 	task_rq_unlock(rq, p, &rf);
+	if (user)
+		cpuset_unlock();
 
 	if (pi)
 		rt_mutex_adjust_pi(p);
@@ -4364,6 +4376,8 @@ static int __sched_setscheduler(struct task_struct *p,
 
 unlock:
 	task_rq_unlock(rq, p, &rf);
+	if (user)
+		cpuset_unlock();
 	return retval;
 }
 
-- 
2.14.3

