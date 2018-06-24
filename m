Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7FCC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE36924E1D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE36924E1D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbeFXHcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 03:32:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53310 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752049AbeFXHcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 03:32:06 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E73D23082131;
        Sun, 24 Jun 2018 07:32:05 +0000 (UTC)
Received: from llong.com (ovpn-116-26.phx2.redhat.com [10.3.116.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2CC617796;
        Sun, 24 Jun 2018 07:32:00 +0000 (UTC)
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
Subject: [PATCH v11 8/9] cpuset: Don't rebuild sched domains if cpu changes in non-partition root
Date:   Sun, 24 Jun 2018 15:30:39 +0800
Message-Id: <1529825440-9574-9-git-send-email-longman@redhat.com>
In-Reply-To: <1529825440-9574-1-git-send-email-longman@redhat.com>
References: <1529825440-9574-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sun, 24 Jun 2018 07:32:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the cpuset v1, any changes to the list of allowable CPUs in a cpuset
may cause changes in the sched domain configuration depending on the
load balancing states and the cpu lists of its parent and its children.

With cpuset v2 (on default hierarchy), there are more restrictions
on how the load balancing state of a cpuset can change. As a result,
only changes made in a partition root will cause possible changes to
the corresponding sched domain. CPU changes to any of the non-partition
root cpusets will not cause changes in the sched domain configuration.
As a result, we don't need to call rebuild_sched_domains_locked()
for changes in a non-partition root cpuset saving precious cpu cycles.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 9097e9d..07a5575 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -986,11 +986,15 @@ static void update_cpumasks_hier(struct cpuset *cs, struct cpumask *new_cpus)
 		update_tasks_cpumask(cp);
 
 		/*
-		 * If the effective cpumask of any non-empty cpuset is changed,
-		 * we need to rebuild sched domains.
+		 * On legacy hierarchy, if the effective cpumask of any non-
+		 * empty cpuset is changed, we need to rebuild sched domains.
+		 * On default hierarchy, the cpuset needs to be a partition
+		 * root as well.
 		 */
 		if (!cpumask_empty(cp->cpus_allowed) &&
-		    is_sched_load_balance(cp))
+		    is_sched_load_balance(cp) &&
+		   (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys) ||
+		    is_partition_root(cp)))
 			need_rebuild_sched_domains = true;
 
 		rcu_read_lock();
-- 
1.8.3.1

