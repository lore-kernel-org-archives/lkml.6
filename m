Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E785ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2316720854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2316720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388800AbeGWN3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:29:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45578 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388770AbeGWN3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:29:06 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1FBC6BDB;
        Mon, 23 Jul 2018 12:28:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@kernel.org
Subject: [PATCH 4.17 60/63] alpha: fix osf_wait4() breakage
Date:   Mon, 23 Jul 2018 14:25:06 +0200
Message-Id: <20180723122448.624282129@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122446.351334162@linuxfoundation.org>
References: <20180723122446.351334162@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@ZenIV.linux.org.uk>

commit f88a333b44318643282b8acc92af90deda441f5e upstream.

kernel_wait4() expects a userland address for status - it's only
rusage that goes as a kernel one (and needs a copyout afterwards)

[ Also, fix the prototype of kernel_wait4() to have that __user
  annotation   - Linus ]

Fixes: 92ebce5ac55d ("osf_wait4: switch to kernel_wait4()")
Cc: stable@kernel.org # v4.13+
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/alpha/kernel/osf_sys.c |    5 +----
 include/linux/sched/task.h  |    2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -1183,13 +1183,10 @@ SYSCALL_DEFINE2(osf_getrusage, int, who,
 SYSCALL_DEFINE4(osf_wait4, pid_t, pid, int __user *, ustatus, int, options,
 		struct rusage32 __user *, ur)
 {
-	unsigned int status = 0;
 	struct rusage r;
-	long err = kernel_wait4(pid, &status, options, &r);
+	long err = kernel_wait4(pid, ustatus, options, &r);
 	if (err <= 0)
 		return err;
-	if (put_user(status, ustatus))
-		return -EFAULT;
 	if (!ur)
 		return err;
 	if (put_tv_to_tv32(&ur->ru_utime, &r.ru_utime))
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -75,7 +75,7 @@ extern long _do_fork(unsigned long, unsi
 extern long do_fork(unsigned long, unsigned long, unsigned long, int __user *, int __user *);
 struct task_struct *fork_idle(int);
 extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
-extern long kernel_wait4(pid_t, int *, int, struct rusage *);
+extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
 
 extern void free_task(struct task_struct *tsk);
 


