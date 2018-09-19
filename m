Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586ADECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B294420877
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B294420877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbeISLFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:05:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12186 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726827AbeISLFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:05:07 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5A9475D9F4987;
        Wed, 19 Sep 2018 13:28:46 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.399.0; Wed, 19 Sep 2018 13:28:41 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <mingo@redhat.com>
CC:     <peterz@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched: psi: Fix a GCC uninitialized warning
Date:   Wed, 19 Sep 2018 13:16:20 +0800
Message-ID: <1537334180-31870-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I find the following warning when compiling the kernel.

kernel/sched/psi.c:639:13: warning: 'rq' may be used uninitialized in this function [-Wmaybe-uninitialized]
  struct rq *rq;

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 kernel/sched/psi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 7cdecfc..2d8a1f2 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -636,7 +636,7 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 	bool move_psi = !psi_disabled;
 	unsigned int task_flags = 0;
 	struct rq_flags rf;
-	struct rq *rq;
+	struct rq *rq = NULL;
 
 	if (move_psi) {
 		rq = task_rq_lock(task, &rf);
-- 
1.7.12.4

