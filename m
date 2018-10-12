Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6C5C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3EA21477
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3EA21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbeJMBaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:30:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbeJMBaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:30:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8255C3002DD2;
        Fri, 12 Oct 2018 17:56:44 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED33279425;
        Fri, 12 Oct 2018 17:56:42 +0000 (UTC)
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
Subject: [PATCH v13 11/11] cpuset: Expose cpuset.cpus.subpartitions with cgroup_debug
Date:   Fri, 12 Oct 2018 13:55:51 -0400
Message-Id: <1539366951-8498-12-git-send-email-longman@redhat.com>
In-Reply-To: <1539366951-8498-1-git-send-email-longman@redhat.com>
References: <1539366951-8498-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 12 Oct 2018 17:56:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For debugging purpose, it will be useful to expose the content of the
subparts_cpus as a read-only file to see if the code work correctly.
However, subparts_cpus will not be used at all in most use cases. So
adding a new cpuset file that clutters the cgroup directory may not be
desirable.  This is now being done by using the hidden "cgroup_debug"
kernel command line option to expose a new "cpuset.cpus.subpartitions"
file.

That option was originally used by the debug controller to expose
itself when configured into the kernel. This is now extended to set an
internal flag used by cgroup_addrm_files(). A new CFTYPE_DEBUG flag
can now be used to specify that a cgroup file should only be created
when the "cgroup_debug" option is specified.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/cgroup-defs.h     |  1 +
 kernel/cgroup/cgroup-internal.h |  2 ++
 kernel/cgroup/cgroup.c          | 14 +++++++++++++-
 kernel/cgroup/cpuset.c          | 11 +++++++++++
 kernel/cgroup/debug.c           |  4 +---
 5 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index ff20b67..94c7a78 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -91,6 +91,7 @@ enum {
 
 	CFTYPE_NO_PREFIX	= (1 << 3),	/* (DON'T USE FOR NEW FILES) no subsys prefix */
 	CFTYPE_WORLD_WRITABLE	= (1 << 4),	/* (DON'T USE FOR NEW FILES) S_IWUGO */
+	CFTYPE_DEBUG		= (1 << 5),	/* create when cgroup_debug */
 
 	/* internal flags, do not use outside cgroup core proper */
 	__CFTYPE_ONLY_ON_DFL	= (1 << 16),	/* only on default hierarchy */
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 75568fc..c950864 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -11,6 +11,8 @@
 #define TRACE_CGROUP_PATH_LEN 1024
 extern spinlock_t trace_cgroup_path_lock;
 extern char trace_cgroup_path[TRACE_CGROUP_PATH_LEN];
+extern bool cgroup_debug;
+extern void __init enable_debug_cgroup(void);
 
 /*
  * cgroup_path() takes a spin lock. It is good practice not to take
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index aae10ba..067e48a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -85,6 +85,7 @@
 
 DEFINE_SPINLOCK(trace_cgroup_path_lock);
 char trace_cgroup_path[TRACE_CGROUP_PATH_LEN];
+bool cgroup_debug __read_mostly;
 
 /*
  * Protects cgroup_idr and css_idr so that IDs can be released without
@@ -3616,7 +3617,8 @@ static int cgroup_addrm_files(struct cgroup_subsys_state *css,
 			continue;
 		if ((cft->flags & CFTYPE_ONLY_ON_ROOT) && cgroup_parent(cgrp))
 			continue;
-
+		if ((cft->flags & CFTYPE_DEBUG) && !cgroup_debug)
+			continue;
 		if (is_add) {
 			ret = cgroup_add_file(css, cgrp, cft);
 			if (ret) {
@@ -5695,6 +5697,16 @@ static int __init cgroup_disable(char *str)
 }
 __setup("cgroup_disable=", cgroup_disable);
 
+void __init __weak enable_debug_cgroup(void) { }
+
+static int __init enable_cgroup_debug(char *str)
+{
+	cgroup_debug = true;
+	enable_debug_cgroup();
+	return 1;
+}
+__setup("cgroup_debug", enable_cgroup_debug);
+
 /**
  * css_tryget_online_from_dir - get corresponding css from a cgroup dentry
  * @dentry: directory dentry of interest
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a3b81d4..9db4f10 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2190,6 +2190,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	FILE_MEMLIST,
 	FILE_EFFECTIVE_CPULIST,
 	FILE_EFFECTIVE_MEMLIST,
+	FILE_SUBPARTS_CPULIST,
 	FILE_CPU_EXCLUSIVE,
 	FILE_MEM_EXCLUSIVE,
 	FILE_MEM_HARDWALL,
@@ -2371,6 +2372,9 @@ static int cpuset_common_seq_show(struct seq_file *sf, void *v)
 	case FILE_EFFECTIVE_MEMLIST:
 		seq_printf(sf, "%*pbl\n", nodemask_pr_args(&cs->effective_mems));
 		break;
+	case FILE_SUBPARTS_CPULIST:
+		seq_printf(sf, "%*pbl\n", cpumask_pr_args(cs->subparts_cpus));
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -2576,6 +2580,13 @@ static s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft)
 		.flags = CFTYPE_NOT_ON_ROOT,
 	},
 
+	{
+		.name = "cpus.subpartitions",
+		.seq_show = cpuset_common_seq_show,
+		.private = FILE_SUBPARTS_CPULIST,
+		.flags = CFTYPE_DEBUG,
+	},
+
 	{ }	/* terminate */
 };
 
diff --git a/kernel/cgroup/debug.c b/kernel/cgroup/debug.c
index 9caeda6..5f1b873 100644
--- a/kernel/cgroup/debug.c
+++ b/kernel/cgroup/debug.c
@@ -373,11 +373,9 @@ struct cgroup_subsys debug_cgrp_subsys = {
  * On v2, debug is an implicit controller enabled by "cgroup_debug" boot
  * parameter.
  */
-static int __init enable_cgroup_debug(char *str)
+void __init enable_debug_cgroup(void)
 {
 	debug_cgrp_subsys.dfl_cftypes = debug_files;
 	debug_cgrp_subsys.implicit_on_dfl = true;
 	debug_cgrp_subsys.threaded = true;
-	return 1;
 }
-__setup("cgroup_debug", enable_cgroup_debug);
-- 
1.8.3.1

