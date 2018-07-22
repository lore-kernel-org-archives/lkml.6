Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D58ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 05:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB1C20874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 05:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB1C20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeGVGY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 02:24:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52405 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727793AbeGVGYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 02:24:25 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CB439322D7F26;
        Sun, 22 Jul 2018 13:28:58 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.382.0; Sun, 22 Jul 2018 13:28:59 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <mingo@redhat.com>, <tglx@linutronix.de>
CC:     <hpa@zytor.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: [PATCH linux-next] kernel/exit: fix mismatch in function argument types
Date:   Sun, 22 Jul 2018 13:17:36 +0800
Message-ID: <1532236656-10220-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following warning:

kernel/exit.c:1634:6: error: symbol 'kernel_wait4' redeclared with different type (originally declared at ./include/linux/sched/task.h:78)
- incompatible argument 2 (different address spaces)

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 include/linux/sched/task.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 5be31eb..108ede9 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -75,7 +75,7 @@ static inline void exit_thread(struct task_struct *tsk)
 extern long do_fork(unsigned long, unsigned long, unsigned long, int __user *, int __user *);
 struct task_struct *fork_idle(int);
 extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
-extern long kernel_wait4(pid_t, int *, int, struct rusage *);
+extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
 
 extern void free_task(struct task_struct *tsk);
 
-- 
1.7.12.4

