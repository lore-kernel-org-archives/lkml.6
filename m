Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF883C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F29A20864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F29A20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754315AbeFREPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 00:15:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754183AbeFREO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 00:14:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E0A82401BF87;
        Mon, 18 Jun 2018 04:14:55 +0000 (UTC)
Received: from llong.com (ovpn-121-11.rdu2.redhat.com [10.10.121.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A699201E288;
        Mon, 18 Jun 2018 04:14:51 +0000 (UTC)
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
        Waiman Long <longman@redhat.com>
Subject: [PATCH v10 3/9] cpuset: Simulate auto-off of sched.domain_root at cgroup removal
Date:   Mon, 18 Jun 2018 12:14:02 +0800
Message-Id: <1529295249-5207-4-git-send-email-longman@redhat.com>
In-Reply-To: <1529295249-5207-1-git-send-email-longman@redhat.com>
References: <1529295249-5207-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 18 Jun 2018 04:14:56 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 18 Jun 2018 04:14:56 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making a cgroup a domain root will reserve cpu resource at its parent.
So when a domain root cgroup is destroyed, we need to free the
reserved cpus at its parent. This is now done by doing an auto-off of
the sched.domain_root flag in the offlining phase when a domain root
cgroup is being removed.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 68a9c25..a1d5ccd 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -995,7 +995,8 @@ static void update_cpumasks_hier(struct cpuset *cs, struct cpumask *new_cpus)
  * If the sched_domain_root flag changes, either the delmask (0=>1) or the
  * addmask (1=>0) will be NULL.
  *
- * Called with cpuset_mutex held.
+ * Called with cpuset_mutex held. Some of the checks are skipped if the
+ * cpuset is being offlined (dying).
  */
 static int update_reserved_cpumask(struct cpuset *cpuset,
 	struct cpumask *delmask, struct cpumask *addmask)
@@ -1005,6 +1006,7 @@ static int update_reserved_cpumask(struct cpuset *cpuset,
 	struct cpuset *sibling;
 	struct cgroup_subsys_state *pos_css;
 	int old_count = parent->nr_reserved;
+	bool dying = cpuset->css.flags & CSS_DYING;
 
 	/*
 	 * The parent must be a scheduling domain root.
@@ -1026,9 +1028,9 @@ static int update_reserved_cpumask(struct cpuset *cpuset,
 
 	/*
 	 * A sched_domain_root state change is not allowed if there are
-	 * online children.
+	 * online children and the cpuset is not dying.
 	 */
-	if (css_has_online_children(&cpuset->css))
+	if (!dying && css_has_online_children(&cpuset->css))
 		return -EBUSY;
 
 	if (!old_count) {
@@ -1058,7 +1060,12 @@ static int update_reserved_cpumask(struct cpuset *cpuset,
 	 * Check if any CPUs in addmask or delmask are in the effective_cpus
 	 * of a sibling cpuset. The implied cpu_exclusive of a scheduling
 	 * domain root will ensure there are no overlap in cpus_allowed.
+	 *
+	 * This check is skipped if the cpuset is dying.
 	 */
+	if (dying)
+		goto updated_reserved_cpus;
+
 	rcu_read_lock();
 	cpuset_for_each_child(sibling, pos_css, parent) {
 		if ((sibling == cpuset) || !(sibling->css.flags & CSS_ONLINE))
@@ -1077,6 +1084,7 @@ static int update_reserved_cpumask(struct cpuset *cpuset,
 	 * Newly added reserved CPUs will be removed from effective_cpus
 	 * and newly deleted ones will be added back if they are online.
 	 */
+updated_reserved_cpus:
 	spin_lock_irq(&callback_lock);
 	if (addmask) {
 		cpumask_or(parent->reserved_cpus,
@@ -2278,7 +2286,12 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 /*
  * If the cpuset being removed has its flag 'sched_load_balance'
  * enabled, then simulate turning sched_load_balance off, which
- * will call rebuild_sched_domains_locked().
+ * will call rebuild_sched_domains_locked(). That is not needed
+ * in the default hierarchy where only changes in domain_root
+ * will cause repartitioning.
+ *
+ * If the cpuset has the 'sched.domain_root' flag enabled, simulate
+ * turning 'sched.domain_root" off.
  */
 
 static void cpuset_css_offline(struct cgroup_subsys_state *css)
@@ -2287,7 +2300,18 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 
 	mutex_lock(&cpuset_mutex);
 
-	if (is_sched_load_balance(cs))
+	/*
+	 * A WARN_ON_ONCE() check after calling update_flag() to make
+	 * sure that the operation succceeds without failure.
+	 */
+	if (is_sched_domain_root(cs)) {
+		int ret = update_flag(CS_SCHED_DOMAIN_ROOT, cs, 0);
+
+		WARN_ON_ONCE(ret);
+	}
+
+	if (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
+	    is_sched_load_balance(cs))
 		update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
 
 	cpuset_dec();
-- 
1.8.3.1

