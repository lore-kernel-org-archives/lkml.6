Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8A9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3432133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 17:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbeLRRal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:30:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbeLRRal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 12:30:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 67374DC8FF;
        Tue, 18 Dec 2018 17:30:41 +0000 (UTC)
Received: from llong.com (dhcp-17-223.bos.redhat.com [10.18.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49951679F0;
        Tue, 18 Dec 2018 17:30:38 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>
Subject: [PATCH] include/linux/nodemask.h: Use nr_node_ids instead of MAX_NUMNODES in nodemask_pr_args
Date:   Tue, 18 Dec 2018 12:30:31 -0500
Message-Id: <1545154231-22824-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 18 Dec 2018 17:30:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When viewing the /proc/<pid>/status file, one can see output lines like

  Cpus_allowed:	ffffffff,ffffffff,ffffffff
  Cpus_allowed_list:	0-95
  Mems_allowed:	00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,00000000,0000000f
  Mems_allowed_list:	0-3

It looks really strange that so many bits are displayed in the
"Mems_allowed:" line.  Whereas the "Cpus_allowed:" line is perfectly
fine.

It is because the nodemask_pr_args() macro uses MAX_NUMNODES as the
number of nodes to iterate. The cpumask_pr_args() macro uses nr_cpu_ids
instead of MAX_CPUS. For nodes, there is a corresponding nr_node_ids.
So it makes sense to use nr_node_ids instead to be consistent with
"Cpus_allowed:".

With that change, the "Mems_allowed:" line becomes

  Mems_allowed:	f

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/nodemask.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/nodemask.h b/include/linux/nodemask.h
index 5a30ad5..ba07661 100644
--- a/include/linux/nodemask.h
+++ b/include/linux/nodemask.h
@@ -97,6 +97,8 @@
 
 typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;
 extern nodemask_t _unused_nodemask_arg_;
+extern int nr_node_ids;
+extern int nr_online_nodes;
 
 /**
  * nodemask_pr_args - printf args to output a nodemask
@@ -108,7 +110,7 @@
 				__nodemask_pr_bits(maskp)
 static inline unsigned int __nodemask_pr_numnodes(const nodemask_t *m)
 {
-	return m ? MAX_NUMNODES : 0;
+	return m ? nr_node_ids : 0;
 }
 static inline const unsigned long *__nodemask_pr_bits(const nodemask_t *m)
 {
@@ -444,9 +446,6 @@ static inline int next_memory_node(int nid)
 	return next_node(nid, node_states[N_MEMORY]);
 }
 
-extern int nr_node_ids;
-extern int nr_online_nodes;
-
 static inline void node_set_online(int nid)
 {
 	node_set_state(nid, N_ONLINE);
-- 
1.8.3.1

