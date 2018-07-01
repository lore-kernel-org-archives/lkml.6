Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72491C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C24D2464A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:09:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C24D2464A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752388AbeGAQJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:09:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43998 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752224AbeGAQJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:09:53 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3577330E6842;
        Sun,  1 Jul 2018 16:09:53 +0000 (UTC)
Received: from rf.usersys.redhat.com (ovpn-116-8.gru2.redhat.com [10.97.116.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 695B268543;
        Sun,  1 Jul 2018 16:09:52 +0000 (UTC)
From:   Rodrigo Freire <rfreire@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mm: be more informative in OOM task list
Date:   Sun,  1 Jul 2018 13:09:40 -0300
Message-Id: <7de14c6cac4a486c04149f37948e3a76028f3fa5.1530461087.git.rfreire@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.27
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Sun, 01 Jul 2018 16:09:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default page memory unit of OOM task dump events might not be
intuitive for the non-initiated when debugging OOM events. Add
a small printk prior to the task dump informing that the memory
units are actually memory _pages_.

Signed-off-by: Rodrigo Freire <rfreire@redhat.com>
---
 mm/oom_kill.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 84081e7..b4d9557 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -392,6 +392,7 @@ static void dump_tasks(struct mem_cgroup *memcg, const nodemask_t *nodemask)
 	struct task_struct *p;
 	struct task_struct *task;
 
+	pr_info("Tasks state (memory values in pages):\n");
 	pr_info("[ pid ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name\n");
 	rcu_read_lock();
 	for_each_process(p) {
-- 
1.8.3.1

