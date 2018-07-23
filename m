Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CBBECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBE120858
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 04:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBE120858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbeGWFTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 01:19:53 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:14052 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbeGWFTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 01:19:53 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 8835A15ADD7795D3C508;
        Mon, 23 Jul 2018 12:20:36 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w6N4KPek046097;
        Mon, 23 Jul 2018 12:20:25 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018072312202698-1250143 ;
          Mon, 23 Jul 2018 12:20:26 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        jiang.biao2@zte.com.cn, wang.yi59@zte.com.cn,
        zhong.weidong@zte.com.cn
Subject: [PATCH] sched/topology: check variable group before dereferenced
Date:   Mon, 23 Jul 2018 12:19:07 +0800
Message-Id: <1532319547-33335-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-07-23 12:20:27,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-07-23 12:20:25,
        Serialize complete at 2018-07-23 12:20:25
X-MAIL: mse01.zte.com.cn w6N4KPek046097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable group in sched_domain_debug_one() is not checked
when firstly used in cpumask_test_cpu(cpu, sched_group_span(group)),
but it maybe NULL(checked later in the following while loop) and may
cause NULL pointer dereference without checking. We need to check it
before using to avoid NULL dereference.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 5ac724b..c7cf87c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -53,7 +53,7 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
 		printk(KERN_ERR "ERROR: domain->span does not contain "
 				"CPU%d\n", cpu);
 	}
-	if (!cpumask_test_cpu(cpu, sched_group_span(group))) {
+	if (group && !cpumask_test_cpu(cpu, sched_group_span(group))) {
 		printk(KERN_ERR "ERROR: domain->groups does not contain"
 				" CPU%d\n", cpu);
 	}
-- 
1.8.3.1

