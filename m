Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A84C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609CB217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390934AbeLUPUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:20:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:62552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730002AbeLUPUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:20:41 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A74D36887;
        Fri, 21 Dec 2018 15:20:41 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C68BB60BE5;
        Fri, 21 Dec 2018 15:20:40 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Tejun Heo <tj@kernel.org>, Waiman Long <longman@redhat.com>
Subject: [PATCH v4] include/linux/nodemask.h: Use nr_node_ids (not MAX_NUMNODES) in __nodemask_pr_numnodes()
Date:   Fri, 21 Dec 2018 10:20:31 -0500
Message-Id: <1545405631-6808-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 21 Dec 2018 15:20:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When viewing the /proc/<pid>/status file, one can see output lines like

  Cpus_allowed:	ffffffff,ffffffff,ffffffff
  Cpus_allowed_list:	0-95
  Mems_allowed:	00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,0000000f
  Mems_allowed_list:	0-3

The "Mems_allowed" line uses the "%*pb" format string while the
"Mems_allowed_list" line uses the "%*pbl" format string together with
the nodemask_pr_args() macro.

The "Mems_allowed" looks insane compared with the others.  It is because
the nodemask_pr_args() macro uses MAX_NUMNODES as the number of nodes
to iterate. The cpumask_pr_args() macro uses nr_cpu_ids instead of
MAX_CPUS. For nodes, there is a corresponding nr_node_ids.  So it makes
sense to use nr_node_ids instead to be consistent with "Cpus_allowed:".

With that change, the "Mems_allowed" line becomes sane again.

  Mems_allowed:	f

There are currently 10 call sites of nodemask_pr_args() in the kernel.
Of them, only cpuset_task_status_allowed() in kernel/cgroup/cpuset.c
uses the "%*pb" format string that will be affected by this change. That
cpuset function is called by proc_pid_status() only.

 v4: Fix build problem with MAX_NUMNODES=1.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/nodemask.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 5a30ad5..2fc99ac 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -98,6 +98,14 @@
 typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;
 extern nodemask_t _unused_nodemask_arg_;
 
+#if MAX_NUMNODES > 1
+extern int nr_node_ids;
+extern int nr_online_nodes;
+#else
+#define nr_node_ids	1
+#define nr_online_nodes	1
+#endif
+
 /**
  * nodemask_pr_args - printf args to output a nodemask
  * @maskp: nodemask to be printed
@@ -108,7 +116,7 @@
 				__nodemask_pr_bits(maskp)
 static inline unsigned int __nodemask_pr_numnodes(const nodemask_t *m)
 {
-	return m ? MAX_NUMNODES : 0;
+	return m ? nr_node_ids : 0;
 }
 static inline const unsigned long *__nodemask_pr_bits(const nodemask_t *m)
 {
@@ -444,9 +452,6 @@ static inline int next_memory_node(int nid)
 	return next_node(nid, node_states[N_MEMORY]);
 }
 
-extern int nr_node_ids;
-extern int nr_online_nodes;
-
 static inline void node_set_online(int nid)
 {
 	node_set_state(nid, N_ONLINE);
@@ -485,8 +490,6 @@ static inline int num_node_state(enum node_states state)
 #define first_online_node	0
 #define first_memory_node	0
 #define next_online_node(nid)	(MAX_NUMNODES)
-#define nr_node_ids		1
-#define nr_online_nodes		1
 
 #define node_set_online(node)	   node_set_state((node), N_ONLINE)
 #define node_set_offline(node)	   node_clear_state((node), N_ONLINE)
-- 
1.8.3.1

