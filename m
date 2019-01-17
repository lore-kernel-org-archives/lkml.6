Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADBBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC7920851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbfAQIsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:48:04 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53975 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730770AbfAQIsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:48:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so130344wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 00:47:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oi05hAQVZcQj9iPj9gVCzJZChwnqyaeVFP8MgKcHR/w=;
        b=T2S60lpC+WnjdsYOwPcXUvF44efPAGD66bTQ/ugPU8SjrXQjVgp5JTdJ7Yr9CHTdP+
         OycukSdUwKLj8Sc35HiVHJ4Df/shNJ/opHFQk7y1SFX8KXXDXUkCAmlKWC3RLstZHZ+I
         y1M36BSsx87zVCsLwBeqJhNGKslrJidM6Th20md0XibN6J5ViVrzzQvkea5GXWbiHAKc
         lR/UNvq06qdXhwwvMyXm73TGUA1PW/OnGbgs33tizQp1OMFaz0bEbfLKdr3VeXj6rirc
         ocR1txQd4Wu6F4JG81h9fTlOShGpmXad37+kuJ1j8FGBq6sDLjsUlXs138EsqfwQ953a
         pSmQ==
X-Gm-Message-State: AJcUukebXDW5YlXMsWchectCxaSunYMBbhPmD6Xwrr5UqLE8pRdIHTZN
        3pFbJH5mv1MtwodEQFA9ZVwnVQ==
X-Google-Smtp-Source: ALg8bN7DAvvOajTMTJOswF5UL1mbcCbQl9AVTzOiVqGOWy1zTMksGaHXxX6e6Xv7JJYH2jtrteKXGQ==
X-Received: by 2002:a1c:5dd1:: with SMTP id r200mr11165131wmb.93.1547714878520;
        Thu, 17 Jan 2019 00:47:58 -0800 (PST)
Received: from localhost.localdomain.home ([151.15.254.62])
        by smtp.gmail.com with ESMTPSA id 199sm41984992wmh.21.2019.01.17.00.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 00:47:57 -0800 (PST)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v6 3/5] cgroup/cpuset: make callback_lock raw
Date:   Thu, 17 Jan 2019 09:47:37 +0100
Message-Id: <20190117084739.17078-4-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190117084739.17078-1-juri.lelli@redhat.com>
References: <20190117084739.17078-1-juri.lelli@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

callback_lock grants the holder read-only access to cpusets.  For fixing
a synchronization issue between cpusets and scheduler core, it is now
required to make callback_lock available to core scheduler code.

Convert callback_lock to raw_spin_lock, so that it will be always safe
to acquire it from atomic context.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

---

v5->v6: minor changes required to rebase on top of Waiman Long's cpuset
for cgroup v2 set.
---
 kernel/cgroup/cpuset.c | 70 +++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f0decd8165e7..54b8ff5de7c8 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -345,7 +345,7 @@ static struct cpuset top_cpuset = {
  */
 
 static DEFINE_MUTEX(cpuset_mutex);
-static DEFINE_SPINLOCK(callback_lock);
+static DEFINE_RAW_SPINLOCK(callback_lock);
 
 static struct workqueue_struct *cpuset_migrate_mm_wq;
 
@@ -1220,7 +1220,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 	 * Newly added CPUs will be removed from effective_cpus and
 	 * newly deleted ones will be added back to effective_cpus.
 	 */
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	if (adding) {
 		cpumask_or(parent->subparts_cpus,
 			   parent->subparts_cpus, tmp->addmask);
@@ -1239,7 +1239,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 	}
 
 	parent->nr_subparts_cpus = cpumask_weight(parent->subparts_cpus);
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	return cmd == partcmd_update;
 }
@@ -1344,7 +1344,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 			continue;
 		rcu_read_unlock();
 
-		spin_lock_irq(&callback_lock);
+		raw_spin_lock_irq(&callback_lock);
 
 		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
 		if (cp->nr_subparts_cpus &&
@@ -1375,7 +1375,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 					= cpumask_weight(cp->subparts_cpus);
 			}
 		}
-		spin_unlock_irq(&callback_lock);
+		raw_spin_unlock_irq(&callback_lock);
 
 		WARN_ON(!is_in_v2_mode() &&
 			!cpumask_equal(cp->cpus_allowed, cp->effective_cpus));
@@ -1493,7 +1493,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 			return -EINVAL;
 	}
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->cpus_allowed, trialcs->cpus_allowed);
 
 	/*
@@ -1504,7 +1504,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 			       cs->cpus_allowed);
 		cs->nr_subparts_cpus = cpumask_weight(cs->subparts_cpus);
 	}
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	update_cpumasks_hier(cs, &tmp);
 
@@ -1698,9 +1698,9 @@ static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
 			continue;
 		rcu_read_unlock();
 
-		spin_lock_irq(&callback_lock);
+		raw_spin_lock_irq(&callback_lock);
 		cp->effective_mems = *new_mems;
-		spin_unlock_irq(&callback_lock);
+		raw_spin_unlock_irq(&callback_lock);
 
 		WARN_ON(!is_in_v2_mode() &&
 			!nodes_equal(cp->mems_allowed, cp->effective_mems));
@@ -1768,9 +1768,9 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
 	if (retval < 0)
 		goto done;
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cs->mems_allowed = trialcs->mems_allowed;
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	/* use trialcs->mems_allowed as a temp variable */
 	update_nodemasks_hier(cs, &trialcs->mems_allowed);
@@ -1861,9 +1861,9 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 	spread_flag_changed = ((is_spread_slab(cs) != is_spread_slab(trialcs))
 			|| (is_spread_page(cs) != is_spread_page(trialcs)));
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cs->flags = trialcs->flags;
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	if (!cpumask_empty(trialcs->cpus_allowed) && balance_flag_changed)
 		rebuild_sched_domains_locked();
@@ -2366,7 +2366,7 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
 	cpuset_filetype_t type = seq_cft(sf)->private;
 	int ret = 0;
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 
 	switch (type) {
 	case FILE_CPULIST:
@@ -2388,7 +2388,7 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
 		ret = -EINVAL;
 	}
 
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 	return ret;
 }
 
@@ -2698,14 +2698,14 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 
 	cpuset_inc();
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	if (is_in_v2_mode()) {
 		cpumask_copy(cs->effective_cpus, parent->effective_cpus);
 		cs->effective_mems = parent->effective_mems;
 		cs->use_parent_ecpus = true;
 		parent->child_ecpus_count++;
 	}
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	if (!test_bit(CGRP_CPUSET_CLONE_CHILDREN, &css->cgroup->flags))
 		goto out_unlock;
@@ -2732,12 +2732,12 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	}
 	rcu_read_unlock();
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cs->mems_allowed = parent->mems_allowed;
 	cs->effective_mems = parent->mems_allowed;
 	cpumask_copy(cs->cpus_allowed, parent->cpus_allowed);
 	cpumask_copy(cs->effective_cpus, parent->cpus_allowed);
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 out_unlock:
 	mutex_unlock(&cpuset_mutex);
 	return 0;
@@ -2790,7 +2790,7 @@ static void cpuset_css_free(struct cgroup_subsys_state *css)
 static void cpuset_bind(struct cgroup_subsys_state *root_css)
 {
 	mutex_lock(&cpuset_mutex);
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 
 	if (is_in_v2_mode()) {
 		cpumask_copy(top_cpuset.cpus_allowed, cpu_possible_mask);
@@ -2801,7 +2801,7 @@ static void cpuset_bind(struct cgroup_subsys_state *root_css)
 		top_cpuset.mems_allowed = top_cpuset.effective_mems;
 	}
 
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 	mutex_unlock(&cpuset_mutex);
 }
 
@@ -2902,12 +2902,12 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
 {
 	bool is_empty;
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->cpus_allowed, new_cpus);
 	cpumask_copy(cs->effective_cpus, new_cpus);
 	cs->mems_allowed = *new_mems;
 	cs->effective_mems = *new_mems;
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	/*
 	 * Don't call update_tasks_cpumask() if the cpuset becomes empty,
@@ -2944,10 +2944,10 @@ hotplug_update_tasks(struct cpuset *cs,
 	if (nodes_empty(*new_mems))
 		*new_mems = parent_cs(cs)->effective_mems;
 
-	spin_lock_irq(&callback_lock);
+	raw_spin_lock_irq(&callback_lock);
 	cpumask_copy(cs->effective_cpus, new_cpus);
 	cs->effective_mems = *new_mems;
-	spin_unlock_irq(&callback_lock);
+	raw_spin_unlock_irq(&callback_lock);
 
 	if (cpus_updated)
 		update_tasks_cpumask(cs);
@@ -3102,7 +3102,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 
 	/* synchronize cpus_allowed to cpu_active_mask */
 	if (cpus_updated) {
-		spin_lock_irq(&callback_lock);
+		raw_spin_lock_irq(&callback_lock);
 		if (!on_dfl)
 			cpumask_copy(top_cpuset.cpus_allowed, &new_cpus);
 		/*
@@ -3122,17 +3122,17 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 			}
 		}
 		cpumask_copy(top_cpuset.effective_cpus, &new_cpus);
-		spin_unlock_irq(&callback_lock);
+		raw_spin_unlock_irq(&callback_lock);
 		/* we don't mess with cpumasks of tasks in top_cpuset */
 	}
 
 	/* synchronize mems_allowed to N_MEMORY */
 	if (mems_updated) {
-		spin_lock_irq(&callback_lock);
+		raw_spin_lock_irq(&callback_lock);
 		if (!on_dfl)
 			top_cpuset.mems_allowed = new_mems;
 		top_cpuset.effective_mems = new_mems;
-		spin_unlock_irq(&callback_lock);
+		raw_spin_unlock_irq(&callback_lock);
 		update_tasks_nodemask(&top_cpuset);
 	}
 
@@ -3233,11 +3233,11 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&callback_lock, flags);
+	raw_spin_lock_irqsave(&callback_lock, flags);
 	rcu_read_lock();
 	guarantee_online_cpus(task_cs(tsk), pmask);
 	rcu_read_unlock();
-	spin_unlock_irqrestore(&callback_lock, flags);
+	raw_spin_unlock_irqrestore(&callback_lock, flags);
 }
 
 void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
@@ -3285,11 +3285,11 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
 	nodemask_t mask;
 	unsigned long flags;
 
-	spin_lock_irqsave(&callback_lock, flags);
+	raw_spin_lock_irqsave(&callback_lock, flags);
 	rcu_read_lock();
 	guarantee_online_mems(task_cs(tsk), &mask);
 	rcu_read_unlock();
-	spin_unlock_irqrestore(&callback_lock, flags);
+	raw_spin_unlock_irqrestore(&callback_lock, flags);
 
 	return mask;
 }
@@ -3381,14 +3381,14 @@ bool __cpuset_node_allowed(int node, gfp_t gfp_mask)
 		return true;
 
 	/* Not hardwall and node outside mems_allowed: scan up cpusets */
-	spin_lock_irqsave(&callback_lock, flags);
+	raw_spin_lock_irqsave(&callback_lock, flags);
 
 	rcu_read_lock();
 	cs = nearest_hardwall_ancestor(task_cs(current));
 	allowed = node_isset(node, cs->mems_allowed);
 	rcu_read_unlock();
 
-	spin_unlock_irqrestore(&callback_lock, flags);
+	raw_spin_unlock_irqrestore(&callback_lock, flags);
 	return allowed;
 }
 
-- 
2.17.2

