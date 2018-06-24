Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D6EC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3A124E10
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC3A124E10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751915AbeFXHbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 03:31:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751770AbeFXHbc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 03:31:32 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E81FE5D5F9;
        Sun, 24 Jun 2018 07:31:31 +0000 (UTC)
Received: from llong.com (ovpn-116-26.phx2.redhat.com [10.3.116.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F421C17796;
        Sun, 24 Jun 2018 07:31:27 +0000 (UTC)
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
Subject: [PATCH v11 3/9] cpuset: Simulate auto-off of sched.partition at cgroup removal
Date:   Sun, 24 Jun 2018 15:30:34 +0800
Message-Id: <1529825440-9574-4-git-send-email-longman@redhat.com>
In-Reply-To: <1529825440-9574-1-git-send-email-longman@redhat.com>
References: <1529825440-9574-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 24 Jun 2018 07:31:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Making a cgroup a partition root will reserve cpu resource at its parent.
So when a partition root cgroup is destroyed, we need to free the
reserved cpus at its parent. This is now done by doing an auto-off of
the sched.partition flag in the offlining phase when a partition root
cgroup is being removed.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 5989bff..e902f54 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2278,7 +2278,12 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 /*
  * If the cpuset being removed has its flag 'sched_load_balance'
  * enabled, then simulate turning sched_load_balance off, which
- * will call rebuild_sched_domains_locked().
+ * will call rebuild_sched_domains_locked(). That is not needed
+ * in the default hierarchy where only changes in partition
+ * will cause repartitioning.
+ *
+ * If the cpuset has the 'sched.partition' flag enabled, simulate
+ * turning 'sched.partition" off.
  */
 
 static void cpuset_css_offline(struct cgroup_subsys_state *css)
@@ -2287,7 +2292,18 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 
 	mutex_lock(&cpuset_mutex);
 
-	if (is_sched_load_balance(cs))
+	/*
+	 * A WARN_ON_ONCE() check after calling update_flag() to make
+	 * sure that the operation succceeds without failure.
+	 */
+	if (is_partition_root(cs)) {
+		int ret = update_flag(CS_PARTITION_ROOT, cs, 0);
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

