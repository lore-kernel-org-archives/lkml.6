Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C43C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7859C24E14
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7859C24E14
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeFXHcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 03:32:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752049AbeFXHcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 03:32:12 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC9F44E358;
        Sun, 24 Jun 2018 07:32:11 +0000 (UTC)
Received: from llong.com (ovpn-116-26.phx2.redhat.com [10.3.116.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4ABAF17796;
        Sun, 24 Jun 2018 07:32:06 +0000 (UTC)
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
Subject: [PATCH v11 9/9] cpuset: Allow reporting of sched domain generation info
Date:   Sun, 24 Jun 2018 15:30:40 +0800
Message-Id: <1529825440-9574-10-git-send-email-longman@redhat.com>
In-Reply-To: <1529825440-9574-1-git-send-email-longman@redhat.com>
References: <1529825440-9574-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sun, 24 Jun 2018 07:32:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables us to report sched domain generation information.

If DYNAMIC_DEBUG is enabled, issuing the following command

  echo "file cpuset.c +p" > /sys/kernel/debug/dynamic_debug/control

and setting loglevel to 8 will allow the kernel to show what scheduling
domain changes are being made.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 07a5575..62b7e61 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -836,6 +836,23 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	return ndoms;
 }
 
+#ifdef CONFIG_DEBUG_KERNEL
+static inline void debug_print_domains(cpumask_var_t *doms, int ndoms)
+{
+	int i;
+	char buf[200];
+	char *ptr, *end = buf + sizeof(buf) - 1;
+
+	for (i = 0, ptr = buf, *end = '\0'; i < ndoms; i++)
+		ptr += snprintf(ptr, end - ptr, "dom%d=%*pbl ", i,
+				cpumask_pr_args(doms[i]));
+
+	pr_debug("Generated %d domains: %s\n", ndoms, buf);
+}
+#else
+static inline void debug_print_domains(cpumask_var_t *doms, int ndoms) { }
+#endif
+
 /*
  * Rebuild scheduler domains.
  *
@@ -871,6 +888,7 @@ static void rebuild_sched_domains_locked(void)
 
 	/* Generate domain masks and attrs */
 	ndoms = generate_sched_domains(&doms, &attr);
+	debug_print_domains(doms, ndoms);
 
 	/* Have scheduler rebuild the domains */
 	partition_sched_domains(ndoms, doms, attr);
-- 
1.8.3.1

