Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B79C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7941B2098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7941B2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbeJDP4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:56:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41012 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727150AbeJDP4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:56:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id x12-v6so9013544wru.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 02:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6H8ljX2S2hP69hb4gKCTg6pJqnEyPEUTDTUhUPTcvC8=;
        b=C8DGZTluJ/QvnTIUqUycyCvkFszNJMEF1NdsoArZeE9efGRshLGAUgzOgLZMBmN36Y
         Laui2zimeP5HLstXS9BCw66y8voaAJCm0uY7fgYHjwlxLiC5G8fKkcT5n3zkfANnHK0I
         uhNTxBk8W2JyW6715CPscwAKMPX5YmMi1AuYeb8+ptDgDgs9ful8k9CdY1xsYBf9Xgrp
         qHkw9MiVnKW81pt9VNUn2CZmr5oSwnEs8VFfMiv8M1JvydSXFRYBa8GuO1KHg3OI5/b5
         sByPfI2MK4bAanWMMorVZQgW73bfPL9VQ97DlUx7wzzSV49H3sgxdrQGmb+djUDNQj2X
         N1SA==
X-Gm-Message-State: ABuFfojsNkFPgtnHnYZxh/BDuuKlsyvi/LalcFUi1939/qbhC8os/rY6
        MkW5ZPZI/Qy8+1sY1kMFLNcMJA==
X-Google-Smtp-Source: ACcGV63igASCoZqLtJcOJSO+BOratxHbM3KO1uWuLmOLf7Q2DoGTLS1nDBn3rCRo0ypgNbntprBJOw==
X-Received: by 2002:adf:81e1:: with SMTP id 88-v6mr4512646wra.19.1538643846144;
        Thu, 04 Oct 2018 02:04:06 -0700 (PDT)
Received: from localhost.localdomain (p200300EF2BCD083C4A3C2B1DAC8A8605.dip0.t-ipconnect.de. [2003:ef:2bcd:83c:4a3c:2b1d:ac8a:8605])
        by smtp.gmail.com with ESMTPSA id e64-v6sm3982907wmg.0.2018.10.04.02.04.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 02:04:04 -0700 (PDT)
Date:   Thu, 4 Oct 2018 11:04:01 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v5 4/5] sched/core: Prevent race condition between cpuset
 and __sched_setscheduler()
Message-ID: <20181004090401.GB12774@localhost.localdomain>
References: <20180903142801.20046-1-juri.lelli@redhat.com>
 <20180903142801.20046-5-juri.lelli@redhat.com>
 <20181003154230.4b8792fb@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003154230.4b8792fb@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/18 15:42, Steven Rostedt wrote:
> On Mon,  3 Sep 2018 16:28:00 +0200
> Juri Lelli <juri.lelli@redhat.com> wrote:
> 
> 
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index 5b43f482fa0f..8dc26005bb1e 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -2410,6 +2410,24 @@ void __init cpuset_init_smp(void)
> >  	BUG_ON(!cpuset_migrate_mm_wq);
> >  }
> >  
> > +/**
> > + * cpuset_read_only_lock - Grab the callback_lock from another subsysytem
> > + *
> > + * Description: Gives the holder read-only access to cpusets.
> > + */
> > +void cpuset_read_only_lock(void)
> > +{
> > +	raw_spin_lock(&callback_lock);
> 
> This was confusing to figure out why grabbing a spinlock gives read
> only access. So I read the long comment above the definition of
> callback_lock. A couple of notes.
> 
> 1) The above description needs to go into more detail as to why
> grabbing a spinlock is "read only".
> 
> 2) The comment above the callback_lock needs to incorporate this, as
> reading that comment alone will not give anyone an idea that this
> exists.

Right, does the updated version below look any better?

Thanks for reviewing!

Best,

- Juri

--->8---
From d704536ba80a01116007024ec055efcc4a9ee558 Mon Sep 17 00:00:00 2001
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Thu, 23 Aug 2018 14:52:13 +0200
Subject: [PATCH v5 4/5] sched/core: Prevent race condition between cpuset and
 __sched_setscheduler()

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
index 5b43f482fa0f..bff72b920624 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -273,7 +273,8 @@ static struct cpuset top_cpuset = {
  * __alloc_pages().
  *
  * If a task is only holding callback_lock, then it has read-only
- * access to cpusets.
+ * access to cpusets. Mind that callback_lock might be grabbed from other
+ * subsystems as well (via cpuset_read_only_lock()).
  *
  * Now, the task_struct fields mems_allowed and mempolicy may be changed
  * by other task, we use alloc_lock in the task_struct fields to protect
@@ -2410,6 +2411,28 @@ void __init cpuset_init_smp(void)
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

