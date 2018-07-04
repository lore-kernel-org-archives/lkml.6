Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D975BC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 956B821533
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956B821533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752997AbeGDPXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:23:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27702 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752565AbeGDPXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:23:35 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2309356CD;
        Wed,  4 Jul 2018 15:23:34 +0000 (UTC)
Received: from rf.usersys.redhat.com (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A8DA60175;
        Wed,  4 Jul 2018 15:23:30 +0000 (UTC)
From:   Rodrigo Freire <rfreire@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, aquini@redhat.com,
        rientjes@google.com
Subject: [PATCH v2] mm, oom: Describe task memory unit, larger PID pad
Date:   Wed,  4 Jul 2018 12:23:18 -0300
Message-Id: <c795eb5129149ed8a6345c273aba167ff1bbd388.1530715938.git.rfreire@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 04 Jul 2018 15:23:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default page memory unit of OOM task dump events might not be
intuitive and potentially misleading for the non-initiated when
debugging OOM events: These are pages and not kBs. Add a small
printk prior to the task dump informing that the memory units are
actually memory _pages_.

Also extends PID field to align on up to 7 characters.
References: https://lkml.org/lkml/2018/7/3/1201

Signed-off-by: Rodrigo Freire <rfreire@redhat.com>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Rafael Aquini <aquini@redhat.com>
---
 mm/oom_kill.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 84081e7..520a483 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -392,7 +392,8 @@ static void dump_tasks(struct mem_cgroup *memcg, const nodemask_t *nodemask)
 	struct task_struct *p;
 	struct task_struct *task;
 
-	pr_info("[ pid ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name\n");
+	pr_info("Tasks state (memory values in pages):\n");
+	pr_info("[  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name\n");
 	rcu_read_lock();
 	for_each_process(p) {
 		if (oom_unkillable_task(p, memcg, nodemask))
@@ -408,7 +409,7 @@ static void dump_tasks(struct mem_cgroup *memcg, const nodemask_t *nodemask)
 			continue;
 		}
 
-		pr_info("[%5d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n",
+		pr_info("[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n",
 			task->pid, from_kuid(&init_user_ns, task_uid(task)),
 			task->tgid, task->mm->total_vm, get_mm_rss(task->mm),
 			mm_pgtables_bytes(task->mm),
-- 
1.8.3.1

