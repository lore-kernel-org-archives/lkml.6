Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41560C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE602098A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE602098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbeJPERp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:17:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42618 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727192AbeJPERo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:17:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C7EB307D943;
        Mon, 15 Oct 2018 20:30:53 +0000 (UTC)
Received: from llong.com (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2B0C768A1;
        Mon, 15 Oct 2018 20:30:51 +0000 (UTC)
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
Subject: [PATCH v14 12/12] cpuset: Show descriptive text when reading cpuset.sched.partition
Date:   Mon, 15 Oct 2018 16:29:37 -0400
Message-Id: <1539635377-22335-13-git-send-email-longman@redhat.com>
In-Reply-To: <1539635377-22335-1-git-send-email-longman@redhat.com>
References: <1539635377-22335-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 15 Oct 2018 20:30:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, cpuset.sched.partition returns the values, 0, 1 or -1 on
read. A person who is not familiar with the partition code may not
understand what they mean.

In order to make cpuset.sched.partition more user-friendly, it will
now display the following descriptive text on read:

  "normal" - A normal cpuset, not a partition root
  "partition" - A partition root
  "partition invalid" - An invalid partition root

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 12 ++++++------
 kernel/cgroup/cpuset.c                  | 22 +++++++++++++++++++---
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 178cda473a26..d9cc79ceb9aa 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1729,15 +1729,15 @@ Cpuset Interface Files
 	root to change.  On read, the "cpuset.sched.partition" file
 	can show the following values.
 
-	"0"  Not a partition root
-	"1"  Partition root
-	"-1" Erroneous partition root
+	"normal" - Normal cpuset, not a partition root
+	"partition" - Partition root
+	"partition invalid" - Invalid partition root
 
 	It is a partition root if the first 2 partition root conditions
 	above are true and at least one CPU from "cpuset.cpus" is
 	granted by the parent cgroup.
 
-	A partition root can become an erroneous partition root if none
+	A partition root can become an invalid partition root if none
 	of CPUs requested in "cpuset.cpus" can be granted by the parent
 	cgroup or the parent cgroup is no longer a partition root.
 	In this case, it is not a real partition even though the
@@ -1745,11 +1745,11 @@ Cpuset Interface Files
 	still apply.  All the tasks in the cgroup will be migrated to
 	the nearest ancestor partition.
 
-	An erroneous partition root can be transitioned back to a real
+	An invalid partition root can be transitioned back to a real
 	partition root if at least one of the requested CPUs can now be
 	granted by its parent.	In this case, the tasks will be migrated
 	back to the newly created partition.  Clearing the partition
-	flag of an erroneous partition root is always allowed even if
+	flag of an invalid partition root is always allowed even if
 	child cpusets are present.
 
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 34d47e43c98a..fe6d6366bfa7 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2430,8 +2430,6 @@ static s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft)
 	switch (type) {
 	case FILE_SCHED_RELAX_DOMAIN_LEVEL:
 		return cs->relax_domain_level;
-	case FILE_PARTITION_ROOT:
-		return cs->partition_root_state;
 	default:
 		BUG();
 	}
@@ -2440,6 +2438,24 @@ static s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft)
 	return 0;
 }
 
+static int sched_partition_show(struct seq_file *seq, void *v)
+{
+	struct cpuset *cs = css_cs(seq_css(seq));
+
+	switch (cs->partition_root_state) {
+	case PRS_ENABLED:
+		seq_puts(seq, "partition\n");
+		break;
+	case PRS_DISABLED:
+		seq_puts(seq, "normal\n");
+		break;
+	case PRS_ERROR:
+		seq_puts(seq, "partition invalid\n");
+		break;
+	}
+	return 0;
+}
+
 /*
  * for the common functions, 'private' gives the type of file
  */
@@ -2583,7 +2599,7 @@ static struct cftype dfl_files[] = {
 
 	{
 		.name = "sched.partition",
-		.read_s64 = cpuset_read_s64,
+		.seq_show = sched_partition_show,
 		.write_s64 = cpuset_write_s64,
 		.private = FILE_PARTITION_ROOT,
 		.flags = CFTYPE_NOT_ON_ROOT,
-- 
2.18.0

