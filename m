Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB29C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8BA20820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8BA20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hxt-semitech.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393531AbeKWSjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 13:39:12 -0500
Received: from mx01.hxt-semitech.com ([223.203.96.7]:54727 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390536AbeKWSjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 13:39:11 -0500
X-ASG-Debug-ID: 1542959745-093b7e021a0b010001-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda.hxt-semitech.com with ESMTP id h1wUzLptsjbR4O80 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 23 Nov 2018 15:55:45 +0800 (CST)
X-Barracuda-Envelope-From: dongsheng.wang@hxt-semitech.com
Received: from arch.localdomain (10.64.6.159) by HXTBJIDCEMVIW02.hxtcorp.net
 (10.128.0.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 23 Nov
 2018 15:55:02 +0800
From:   Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
To:     <dhowells@redhat.com>, <tglx@linutronix.de>
CC:     <mingo@kernel.org>, <akpm@linux-foundation.org>,
        <yamada.masahiro@socionext.com>, <keescook@chromium.org>,
        <tony.luck@intel.com>, <will.deacon@arm.com>, <palmer@sifive.com>,
        <yu.zheng@hxt-semitech.com>, <linux-kernel@vger.kernel.org>,
        Wang Dongsheng <dongsheng.wang@hxt-semitech.com>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>
Subject: [PATCH 1/1] sched/headers: fix thread_info.<first> is overwritten by STACK_END_MAGIC
Date:   Fri, 23 Nov 2018 15:54:48 +0800
X-ASG-Orig-Subj: [PATCH 1/1] sched/headers: fix thread_info.<first> is overwritten by STACK_END_MAGIC
Message-ID: <e7952089a66db4e5d59d2af230a324155bb018a0.1542955914.git.dongsheng.wang@hxt-semitech.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.64.6.159]
X-ClientProxiedBy: HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) To
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15)
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1542959745
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9457 1.0000 3.7240
X-Barracuda-Spam-Score: 3.72
X-Barracuda-Spam-Status: No, SCORE=3.72 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.62283
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When select ARCH_TASK_STRUCT_ON_STACK the first of thread_info variable
is overwritten by STACK_END_MAGIC. In fact, the ARCH_TASK_STRUCT_ON_STACK
is not a real task on stack, it's only init_task on init_stack.

Commit 0500871f21b2 ("Construct init thread stack in the linker script
rather than by union") added this macro and put task_strcut into
thread_union. This brings us the following possibilities:
    TASK_ON_STACK    THREAD_INFO_IN_TASK    STACK
                                            ----- <-- thread_info & stack
        N                    N             |     |     --- <-- task
                                           |     |    |   |
                                            -----      ---

                                            ----- <-- stack
        N                    Y             |     |     --- <-- task(Including thread_info)
                                           |     |    |   |
                                            -----      ---

                                            ----- <-- stack & task & thread_info
        Y                    N             |     |
                                           |     |
                                            -----

                                            ----- <-- stack & task(Including thread_info)
        Y                    Y             |     |
                                           |     |
                                            -----
The kernel has handled the first two cases correctly.

For the third case:
TASK_ON_STACK: Y. THREAD_INFO_IN_TASK: N. this case
should never happen, because the task and thread_info will overlap. So
when TASK_ON_STACK is selected, THREAD_INFO_IN_TASK must be selected too.

For the fourth case:
When task on stack, the end of stack should add a sizeof(task_struct) offset.

This patch handled with the third and fourth case.

Fixes: 0500871f21b2 ("Construct init thread stack in the linker ...")

Signed-off-by: Wang Dongsheng <dongsheng.wang@hxt-semitech.com>
Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
---
 arch/Kconfig                     | 1 +
 include/linux/sched/task_stack.h | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index e1e540ffa979..0a2c73e73195 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -251,6 +251,7 @@ config ARCH_HAS_SET_MEMORY
 # Select if arch init_task must go in the __init_task_data section
 config ARCH_TASK_STRUCT_ON_STACK
        bool
+	depends on THREAD_INFO_IN_TASK || IA64
 
 # Select if arch has its private alloc_task_struct() function
 config ARCH_TASK_STRUCT_ALLOCATOR
diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index 6a841929073f..624c48defb9e 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -7,6 +7,7 @@
  */
 
 #include <linux/sched.h>
+#include <linux/sched/task.h>
 #include <linux/magic.h>
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
@@ -25,7 +26,9 @@ static inline void *task_stack_page(const struct task_struct *task)
 
 static inline unsigned long *end_of_stack(const struct task_struct *task)
 {
-	return task->stack;
+	if (!IS_ENABLED(CONFIG_ARCH_TASK_STRUCT_ON_STACK) || task != &init_task)
+		return task->stack;
+	return (unsigned long *)(task + 1);
 }
 
 #elif !defined(__HAVE_THREAD_FUNCTIONS)
-- 
2.19.1

