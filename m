Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B01C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C04208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C04208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbeJPERP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:17:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbeJPERP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:17:15 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EA5C367465;
        Mon, 15 Oct 2018 20:30:24 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48E456247A;
        Mon, 15 Oct 2018 20:30:23 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v14 03/12] cpuset: Simply allocation and freeing of cpumasks
Date:   Mon, 15 Oct 2018 16:29:28 -0400
Message-Id: <1539635377-22335-4-git-send-email-longman@redhat.com>
In-Reply-To: <1539635377-22335-1-git-send-email-longman@redhat.com>
References: <1539635377-22335-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 15 Oct 2018 20:30:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous commit introduces a new subparts_cpus mask into the cpuset
data structure and a new tmpmasks structure.  Managing the allocation
and freeing of those cpumasks is becoming more complex.

So a number of helper functions are added to simplify and streamline
the management of those cpumasks. To make it simple, all the cpumasks
are now pre-cleared on allocation.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 110 ++++++++++++++++++++++++++++-------------
 1 file changed, 77 insertions(+), 33 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 29a2bdc671fd..2ac9437ce8f1 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -455,6 +455,65 @@ static int is_cpuset_subset(const struct cpuset *p, const struct cpuset *q)
 		is_mem_exclusive(p) <= is_mem_exclusive(q);
 }
 
+/**
+ * alloc_cpumasks - allocate three cpumasks for cpuset
+ * @cs:  the cpuset that have cpumasks to be allocated.
+ * @tmp: the tmpmasks structure pointer
+ * Return: 0 if successful, -ENOMEM otherwise.
+ *
+ * Only one of the two input arguments should be non-NULL.
+ */
+static inline int alloc_cpumasks(struct cpuset *cs, struct tmpmasks *tmp)
+{
+	cpumask_var_t *pmask1, *pmask2, *pmask3;
+
+	if (cs) {
+		pmask1 = &cs->cpus_allowed;
+		pmask2 = &cs->effective_cpus;
+		pmask3 = &cs->subparts_cpus;
+	} else {
+		pmask1 = &tmp->new_cpus;
+		pmask2 = &tmp->addmask;
+		pmask3 = &tmp->delmask;
+	}
+
+	if (!zalloc_cpumask_var(pmask1, GFP_KERNEL))
+		return -ENOMEM;
+
+	if (!zalloc_cpumask_var(pmask2, GFP_KERNEL))
+		goto free_one;
+
+	if (!zalloc_cpumask_var(pmask3, GFP_KERNEL))
+		goto free_two;
+
+	return 0;
+
+free_two:
+	free_cpumask_var(*pmask2);
+free_one:
+	free_cpumask_var(*pmask1);
+	return -ENOMEM;
+}
+
+/**
+ * free_cpumasks - free cpumasks in a tmpmasks structure
+ * @cs:  the cpuset that have cpumasks to be free.
+ * @tmp: the tmpmasks structure pointer
+ */
+static inline void free_cpumasks(struct cpuset *cs, struct tmpmasks *tmp)
+{
+	if (cs) {
+		free_cpumask_var(cs->cpus_allowed);
+		free_cpumask_var(cs->effective_cpus);
+		free_cpumask_var(cs->subparts_cpus);
+	}
+	if (tmp) {
+		free_cpumask_var(tmp->new_cpus);
+		free_cpumask_var(tmp->addmask);
+		free_cpumask_var(tmp->delmask);
+	}
+}
+
 /**
  * alloc_trial_cpuset - allocate a trial cpuset
  * @cs: the cpuset that the trial cpuset duplicates
@@ -467,31 +526,24 @@ static struct cpuset *alloc_trial_cpuset(struct cpuset *cs)
 	if (!trial)
 		return NULL;
 
-	if (!alloc_cpumask_var(&trial->cpus_allowed, GFP_KERNEL))
-		goto free_cs;
-	if (!alloc_cpumask_var(&trial->effective_cpus, GFP_KERNEL))
-		goto free_cpus;
+	if (alloc_cpumasks(trial, NULL)) {
+		kfree(trial);
+		return NULL;
+	}
 
 	cpumask_copy(trial->cpus_allowed, cs->cpus_allowed);
 	cpumask_copy(trial->effective_cpus, cs->effective_cpus);
 	return trial;
-
-free_cpus:
-	free_cpumask_var(trial->cpus_allowed);
-free_cs:
-	kfree(trial);
-	return NULL;
 }
 
 /**
- * free_trial_cpuset - free the trial cpuset
- * @trial: the trial cpuset to be freed
+ * free_cpuset - free the cpuset
+ * @cs: the cpuset to be freed
  */
-static void free_trial_cpuset(struct cpuset *trial)
+static inline void free_cpuset(struct cpuset *cs)
 {
-	free_cpumask_var(trial->effective_cpus);
-	free_cpumask_var(trial->cpus_allowed);
-	kfree(trial);
+	free_cpumasks(cs, NULL);
+	kfree(cs);
 }
 
 /*
@@ -1385,7 +1437,7 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 	if (spread_flag_changed)
 		update_tasks_flags(cs);
 out:
-	free_trial_cpuset(trialcs);
+	free_cpuset(trialcs);
 	return err;
 }
 
@@ -1769,7 +1821,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 		break;
 	}
 
-	free_trial_cpuset(trialcs);
+	free_cpuset(trialcs);
 out_unlock:
 	mutex_unlock(&cpuset_mutex);
 	kernfs_unbreak_active_protection(of->kn);
@@ -2024,26 +2076,19 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
 	cs = kzalloc(sizeof(*cs), GFP_KERNEL);
 	if (!cs)
 		return ERR_PTR(-ENOMEM);
-	if (!alloc_cpumask_var(&cs->cpus_allowed, GFP_KERNEL))
-		goto free_cs;
-	if (!alloc_cpumask_var(&cs->effective_cpus, GFP_KERNEL))
-		goto free_cpus;
+
+	if (alloc_cpumasks(cs, NULL)) {
+		kfree(cs);
+		return ERR_PTR(-ENOMEM);
+	}
 
 	set_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
-	cpumask_clear(cs->cpus_allowed);
 	nodes_clear(cs->mems_allowed);
-	cpumask_clear(cs->effective_cpus);
 	nodes_clear(cs->effective_mems);
 	fmeter_init(&cs->fmeter);
 	cs->relax_domain_level = -1;
 
 	return &cs->css;
-
-free_cpus:
-	free_cpumask_var(cs->cpus_allowed);
-free_cs:
-	kfree(cs);
-	return ERR_PTR(-ENOMEM);
 }
 
 static int cpuset_css_online(struct cgroup_subsys_state *css)
@@ -2134,9 +2179,7 @@ static void cpuset_css_free(struct cgroup_subsys_state *css)
 {
 	struct cpuset *cs = css_cs(css);
 
-	free_cpumask_var(cs->effective_cpus);
-	free_cpumask_var(cs->cpus_allowed);
-	kfree(cs);
+	free_cpuset(cs);
 }
 
 static void cpuset_bind(struct cgroup_subsys_state *root_css)
@@ -2200,6 +2243,7 @@ int __init cpuset_init(void)
 
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.cpus_allowed, GFP_KERNEL));
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.effective_cpus, GFP_KERNEL));
+	BUG_ON(!zalloc_cpumask_var(&top_cpuset.subparts_cpus, GFP_KERNEL));
 
 	cpumask_setall(top_cpuset.cpus_allowed);
 	nodes_setall(top_cpuset.mems_allowed);
-- 
2.18.0

