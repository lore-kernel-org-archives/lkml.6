Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86D8ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8618F20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8618F20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbeKIApZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:45:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbeKIApX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:45:23 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1605D2D7E0;
        Thu,  8 Nov 2018 15:09:27 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40450648C8;
        Thu,  8 Nov 2018 15:09:25 +0000 (UTC)
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
Subject: [PATCH v15 10/12] cpuset: Use descriptive text when reading/writing cpuset.sched.partition
Date:   Thu,  8 Nov 2018 10:08:44 -0500
Message-Id: <1541689726-20088-11-git-send-email-longman@redhat.com>
In-Reply-To: <1541689726-20088-1-git-send-email-longman@redhat.com>
References: <1541689726-20088-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 08 Nov 2018 15:09:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, cpuset.sched.partition returns the values, 0, 1 or -1 on
read. A person who is not familiar with the partition code may not
understand what they mean.

In order to make cpuset.sched.partition more user-friendly, it will
now display the following descriptive text on read:

  "root" - A partition root (top cpuset of a partition)
  "member" - A non-root member of a partition
  "root invalid" - An invalid partition root

Note that there is at least one partition in the whole cgroup hierarchy.
The top cpuset is the root of that partition.  The rests are either a
root if it starts a new partition or a member of a partition.

The cpuset.sched.partition file will now also accept "root" and
"member" besides 1 and 0 as valid input values. The "root invalid"
value is internal only and cannot be written to the file.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 58 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index fc1a809..c739fda 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2278,9 +2278,6 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 	case FILE_SCHED_RELAX_DOMAIN_LEVEL:
 		retval = update_relax_domain_level(cs, val);
 		break;
-	case FILE_PARTITION_ROOT:
-		retval = update_prstate(cs, val);
-		break;
 	default:
 		retval = -EINVAL;
 		break;
@@ -2431,8 +2428,6 @@ static s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft)
 	switch (type) {
 	case FILE_SCHED_RELAX_DOMAIN_LEVEL:
 		return cs->relax_domain_level;
-	case FILE_PARTITION_ROOT:
-		return cs->partition_root_state;
 	default:
 		BUG();
 	}
@@ -2441,6 +2436,55 @@ static s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft)
 	return 0;
 }
 
+static int sched_partition_show(struct seq_file *seq, void *v)
+{
+	struct cpuset *cs = css_cs(seq_css(seq));
+
+	switch (cs->partition_root_state) {
+	case PRS_ENABLED:
+		seq_puts(seq, "root\n");
+		break;
+	case PRS_DISABLED:
+		seq_puts(seq, "member\n");
+		break;
+	case PRS_ERROR:
+		seq_puts(seq, "root invalid\n");
+		break;
+	}
+	return 0;
+}
+
+static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
+				     size_t nbytes, loff_t off)
+{
+	struct cpuset *cs = css_cs(of_css(of));
+	int val;
+	int retval = -ENODEV;
+
+	buf = strstrip(buf);
+
+	/*
+	 * Convert "root"/"1" to 1, and convert "member"/"0" to 0.
+	 */
+	if (!strcmp(buf, "root") || !strcmp(buf, "1"))
+		val = PRS_ENABLED;
+	else if (!strcmp(buf, "member") || !strcmp(buf, "0"))
+		val = PRS_DISABLED;
+	else
+		return -EINVAL;
+
+	css_get(&cs->css);
+	mutex_lock(&cpuset_mutex);
+	if (!is_cpuset_online(cs))
+		goto out_unlock;
+
+	retval = update_prstate(cs, val);
+out_unlock:
+	mutex_unlock(&cpuset_mutex);
+	css_put(&cs->css);
+	return retval ?: nbytes;
+}
+
 /*
  * for the common functions, 'private' gives the type of file
  */
@@ -2584,8 +2628,8 @@ static s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft)
 
 	{
 		.name = "sched.partition",
-		.read_s64 = cpuset_read_s64,
-		.write_s64 = cpuset_write_s64,
+		.seq_show = sched_partition_show,
+		.write = sched_partition_write,
 		.private = FILE_PARTITION_ROOT,
 		.flags = CFTYPE_NOT_ON_ROOT,
 	},
-- 
1.8.3.1

