Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0C7C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3971F20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3971F20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbeGYPcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:32:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52979 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbeGYPcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:32:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PEKavt399926
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:20:36 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PEKZ0g399923;
        Wed, 25 Jul 2018 07:20:35 -0700
Date:   Wed, 25 Jul 2018 07:20:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yi Wang <tipbot@zytor.com>
Message-ID: <tip-6cd0c583b04b2bd9415e07b51b63ab799949dd66@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, jiang.biao2@zte.com.cn,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, wang.yi59@zte.com.cn, hpa@zytor.com
Reply-To: hpa@zytor.com, wang.yi59@zte.com.cn,
          torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
          jiang.biao2@zte.com.cn, peterz@infradead.org, mingo@kernel.org,
          tglx@linutronix.de
In-Reply-To: <1532319547-33335-1-git-send-email-wang.yi59@zte.com.cn>
References: <1532319547-33335-1-git-send-email-wang.yi59@zte.com.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/topology: Check variable group before
 dereferencing it
Git-Commit-ID: 6cd0c583b04b2bd9415e07b51b63ab799949dd66
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6cd0c583b04b2bd9415e07b51b63ab799949dd66
Gitweb:     https://git.kernel.org/tip/6cd0c583b04b2bd9415e07b51b63ab799949dd66
Author:     Yi Wang <wang.yi59@zte.com.cn>
AuthorDate: Mon, 23 Jul 2018 12:19:07 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:25:07 +0200

sched/topology: Check variable group before dereferencing it

The 'group' variable in sched_domain_debug_one() is not checked
when firstly used in cpumask_test_cpu(cpu, sched_group_span(group)),
but it might be NULL (it is checked later in the following while loop)
and may cause NULL pointer dereference.

We need to check it before using to avoid NULL dereference.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: zhong.weidong@zte.com.cn
Link: http://lkml.kernel.org/r/1532319547-33335-1-git-send-email-wang.yi59@zte.com.cn
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 05a831427bc7..56a0fed30c0a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -47,7 +47,7 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
 	if (!cpumask_test_cpu(cpu, sched_domain_span(sd))) {
 		printk(KERN_ERR "ERROR: domain->span does not contain CPU%d\n", cpu);
 	}
-	if (!cpumask_test_cpu(cpu, sched_group_span(group))) {
+	if (group && !cpumask_test_cpu(cpu, sched_group_span(group))) {
 		printk(KERN_ERR "ERROR: domain->groups does not contain CPU%d\n", cpu);
 	}
 
