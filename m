Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED13C67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A77421477
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:56:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A77421477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeJMB34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:29:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbeJMB3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:29:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5586080F91;
        Fri, 12 Oct 2018 17:56:16 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B826082F6E;
        Fri, 12 Oct 2018 17:56:14 +0000 (UTC)
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
Subject: [PATCH v13 01/11] cpuset: Enable cpuset controller in default hierarchy
Date:   Fri, 12 Oct 2018 13:55:41 -0400
Message-Id: <1539366951-8498-2-git-send-email-longman@redhat.com>
In-Reply-To: <1539366951-8498-1-git-send-email-longman@redhat.com>
References: <1539366951-8498-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 12 Oct 2018 17:56:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given the fact that thread mode had been merged into 4.14, it is now
time to enable cpuset to be used in the default hierarchy (cgroup v2)
as it is clearly threaded.

The cpuset controller had experienced feature creep since its
introduction more than a decade ago. Besides the core cpus and mems
control files to limit cpus and memory nodes, there are a bunch of
additional features that can be controlled from the userspace. Some of
the features are of doubtful usefulness and may not be actively used.

This patch enables cpuset controller in the default hierarchy with
a minimal set of features, namely just the cpus and mems and their
effective_* counterparts.  We can certainly add more features to the
default hierarchy in the future if there is a real user need for them
later on.

Alternatively, with the unified hiearachy, it may make more sense
to move some of those additional cpuset features, if desired, to
memory controller or may be to the cpu controller instead of staying
with cpuset.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 109 ++++++++++++++++++++++++++++++--
 kernel/cgroup/cpuset.c                  |  48 +++++++++++++-
 2 files changed, 149 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 184193b..0465c23 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -56,11 +56,13 @@ v1 is available under Documentation/cgroup-v1/.
          5-3-3-2. IO Latency Interface Files
      5-4. PID
        5-4-1. PID Interface Files
-     5-5. Device
-     5-6. RDMA
-       5-6-1. RDMA Interface Files
-     5-7. Misc
-       5-7-1. perf_event
+     5-5. Cpuset
+       5.5-1. Cpuset Interface Files
+     5-6. Device
+     5-7. RDMA
+       5-7-1. RDMA Interface Files
+     5-8. Misc
+       5-8-1. perf_event
      5-N. Non-normative information
        5-N-1. CPU controller root cgroup process behaviour
        5-N-2. IO controller root cgroup process behaviour
@@ -1588,6 +1590,103 @@ through fork() or clone(). These will return -EAGAIN if the creation
 of a new process would cause a cgroup policy to be violated.
 
 
+Cpuset
+------
+
+The "cpuset" controller provides a mechanism for constraining
+the CPU and memory node placement of tasks to only the resources
+specified in the cpuset interface files in a task's current cgroup.
+This is especially valuable on large NUMA systems where placing jobs
+on properly sized subsets of the systems with careful processor and
+memory placement to reduce cross-node memory access and contention
+can improve overall system performance.
+
+The "cpuset" controller is hierarchical.  That means the controller
+cannot use CPUs or memory nodes not allowed in its parent.
+
+
+Cpuset Interface Files
+~~~~~~~~~~~~~~~~~~~~~~
+
+  cpuset.cpus
+	A read-write multiple values file which exists on non-root
+	cpuset-enabled cgroups.
+
+	It lists the requested CPUs to be used by tasks within this
+	cgroup.  The actual list of CPUs to be granted, however, is
+	subjected to constraints imposed by its parent and can differ
+	from the requested CPUs.
+
+	The CPU numbers are comma-separated numbers or ranges.
+	For example:
+
+	  # cat cpuset.cpus
+	  0-4,6,8-10
+
+	An empty value indicates that the cgroup is using the same
+	setting as the nearest cgroup ancestor with a non-empty
+	"cpuset.cpus" or all the available CPUs if none is found.
+
+	The value of "cpuset.cpus" stays constant until the next update
+	and won't be affected by any CPU hotplug events.
+
+  cpuset.cpus.effective
+	A read-only multiple values file which exists on non-root
+	cpuset-enabled cgroups.
+
+	It lists the onlined CPUs that are actually granted to this
+	cgroup by its parent.  These CPUs are allowed to be used by
+	tasks within the current cgroup.
+
+	If "cpuset.cpus" is empty, the "cpuset.cpus.effective" file shows
+	all the CPUs from the parent cgroup that can be available to
+	be used by this cgroup.  Otherwise, it should be a subset of
+	"cpuset.cpus" unless none of the CPUs listed in "cpuset.cpus"
+	can be granted.  In this case, it will be treated just like an
+	empty "cpuset.cpus".
+
+	Its value will be affected by CPU hotplug events.
+
+  cpuset.mems
+	A read-write multiple values file which exists on non-root
+	cpuset-enabled cgroups.
+
+	It lists the requested memory nodes to be used by tasks within
+	this cgroup.  The actual list of memory nodes granted, however,
+	is subjected to constraints imposed by its parent and can differ
+	from the requested memory nodes.
+
+	The memory node numbers are comma-separated numbers or ranges.
+	For example:
+
+	  # cat cpuset.mems
+	  0-1,3
+
+	An empty value indicates that the cgroup is using the same
+	setting as the nearest cgroup ancestor with a non-empty
+	"cpuset.mems" or all the available memory nodes if none
+	is found.
+
+	The value of "cpuset.mems" stays constant until the next update
+	and won't be affected by any memory nodes hotplug events.
+
+  cpuset.mems.effective
+	A read-only multiple values file which exists on non-root
+	cpuset-enabled cgroups.
+
+	It lists the onlined memory nodes that are actually granted to
+	this cgroup by its parent. These memory nodes are allowed to
+	be used by tasks within the current cgroup.
+
+	If "cpuset.mems" is empty, it shows all the memory nodes from the
+	parent cgroup that will be available to be used by this cgroup.
+	Otherwise, it should be a subset of "cpuset.mems" unless none of
+	the memory nodes listed in "cpuset.mems" can be granted.  In this
+	case, it will be treated just like an empty "cpuset.mems".
+
+	Its value will be affected by memory nodes hotplug events.
+
+
 Device controller
 -----------------
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 266f10c..2b5c447 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1824,12 +1824,11 @@ static s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft)
 	return 0;
 }
 
-
 /*
  * for the common functions, 'private' gives the type of file
  */
 
-static struct cftype files[] = {
+static struct cftype legacy_files[] = {
 	{
 		.name = "cpus",
 		.seq_show = cpuset_common_seq_show,
@@ -1932,6 +1931,47 @@ static s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft)
 };
 
 /*
+ * This is currently a minimal set for the default hierarchy. It can be
+ * expanded later on by migrating more features and control files from v1.
+ */
+static struct cftype dfl_files[] = {
+	{
+		.name = "cpus",
+		.seq_show = cpuset_common_seq_show,
+		.write = cpuset_write_resmask,
+		.max_write_len = (100U + 6 * NR_CPUS),
+		.private = FILE_CPULIST,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+
+	{
+		.name = "mems",
+		.seq_show = cpuset_common_seq_show,
+		.write = cpuset_write_resmask,
+		.max_write_len = (100U + 6 * MAX_NUMNODES),
+		.private = FILE_MEMLIST,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+
+	{
+		.name = "cpus.effective",
+		.seq_show = cpuset_common_seq_show,
+		.private = FILE_EFFECTIVE_CPULIST,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+
+	{
+		.name = "mems.effective",
+		.seq_show = cpuset_common_seq_show,
+		.private = FILE_EFFECTIVE_MEMLIST,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+
+	{ }	/* terminate */
+};
+
+
+/*
  *	cpuset_css_alloc - allocate a cpuset css
  *	cgrp:	control group that the new cpuset will be part of
  */
@@ -2105,8 +2145,10 @@ struct cgroup_subsys cpuset_cgrp_subsys = {
 	.post_attach	= cpuset_post_attach,
 	.bind		= cpuset_bind,
 	.fork		= cpuset_fork,
-	.legacy_cftypes	= files,
+	.legacy_cftypes	= legacy_files,
+	.dfl_cftypes	= dfl_files,
 	.early_init	= true,
+	.threaded	= true,
 };
 
 /**
-- 
1.8.3.1

