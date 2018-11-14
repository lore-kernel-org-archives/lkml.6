Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48ACAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 04:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8282145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 04:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A8282145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731480AbeKNOeq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 09:34:46 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:34098 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbeKNOeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 09:34:46 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id C24258C3F9D250C45F4A;
        Wed, 14 Nov 2018 12:33:09 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wAE4X5v9095459;
        Wed, 14 Nov 2018 12:33:05 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018111412332545-10576762 ;
          Wed, 14 Nov 2018 12:33:25 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     riel@redhat.com, linux@rasmusvillemoes.dk
Cc:     wang.yi59@zte.com.cn, keescook@chromium.org,
        viro@ZenIV.linux.org.uk, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, rostedt@goodmis.org, tglx@linutronix.de,
        mingo@kernel.org, rppt@linux.vnet.ibm.com,
        linux@dominikbrodowski.net, pasha.tatashin@oracle.com,
        ard.biesheuvel@linaro.org, luto@amacapital.net, wad@chromium.org,
        mhocko@kernel.org, riel@surriel.com, ebiederm@xmission.com,
        kirill.shutemov@linux.intel.com, guro@fb.com,
        marcos.souza.org@gmail.com, zhong.weidong@zte.com.cn
Subject: [PATCH v2] fork: Fix some -Wmissing-prototypes warnings
Date:   Wed, 14 Nov 2018 12:34:47 +0800
Message-Id: <1542170087-23645-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-14 12:33:25,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-14 12:32:57
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse01.zte.com.cn wAE4X5v9095459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get a warning when building kernel with W=1:
kernel/fork.c:167:13: warning: no previous prototype for ‘arch_release_thread_stack’ [-Wmissing-prototypes]
kernel/fork.c:779:13: warning: no previous prototype for ‘fork_init’ [-Wmissing-prototypes]

Add the missing declaration in head file to fix this.

Also, remove arch_release_thread_stack() completely because no
arch seems to implement it since bb9d81264 (arch: remove tile port).

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
v2: remove arch_release_thread_stack(). Thanks to Rasmus.
---
 include/linux/sched/task.h | 2 ++
 init/main.c                | 1 -
 kernel/fork.c              | 5 -----
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 108ede9..44c6f15 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -39,6 +39,8 @@
 
 extern void proc_caches_init(void);
 
+extern void fork_init(void);
+
 extern void release_task(struct task_struct * p);
 
 #ifdef CONFIG_HAVE_COPY_THREAD_TLS
diff --git a/init/main.c b/init/main.c
index ee14710..8feda42 100644
--- a/init/main.c
+++ b/init/main.c
@@ -105,7 +105,6 @@
 static int kernel_init(void *);
 
 extern void init_IRQ(void);
-extern void fork_init(void);
 extern void radix_tree_init(void);
 
 /*
diff --git a/kernel/fork.c b/kernel/fork.c
index 07cddff..c6d02be 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -164,10 +164,6 @@ static inline void free_task_struct(struct task_struct *tsk)
 }
 #endif
 
-void __weak arch_release_thread_stack(unsigned long *stack)
-{
-}
-
 #ifndef CONFIG_ARCH_THREAD_STACK_ALLOCATOR
 
 /*
@@ -417,7 +413,6 @@ static void release_task_stack(struct task_struct *tsk)
 		return;  /* Better to leak the stack than to free prematurely */
 
 	account_kernel_stack(tsk, -1);
-	arch_release_thread_stack(tsk->stack);
 	free_thread_stack(tsk);
 	tsk->stack = NULL;
 #ifdef CONFIG_VMAP_STACK
-- 
1.8.3.1

