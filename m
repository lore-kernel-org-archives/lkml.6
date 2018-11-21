Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9F6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF47F214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF47F214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389424AbeKVGyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:54:16 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:45357 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389395AbeKVGyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:54:14 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gPYx5-0000Iy-Vh; Wed, 21 Nov 2018 21:18:24 +0100
Message-Id: <20181121201724.134317923@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 21 Nov 2018 21:14:49 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: [patch 19/24] ptrace: Remove unused ptrace_may_access_sched() and
 MODE_IBRS
References: <20181121201430.559770965@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=ptrace--Remove-unused-ptrace_may_access_sched--.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IBPB control code in x86 removed the usage. Remove the functionality
which was introduced for this.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/ptrace.h |   17 -----------------
 kernel/ptrace.c        |   10 ----------
 2 files changed, 27 deletions(-)

--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -64,15 +64,12 @@ extern void exit_ptrace(struct task_stru
 #define PTRACE_MODE_NOAUDIT	0x04
 #define PTRACE_MODE_FSCREDS	0x08
 #define PTRACE_MODE_REALCREDS	0x10
-#define PTRACE_MODE_SCHED	0x20
-#define PTRACE_MODE_IBPB	0x40
 
 /* shorthands for READ/ATTACH and FSCREDS/REALCREDS combinations */
 #define PTRACE_MODE_READ_FSCREDS (PTRACE_MODE_READ | PTRACE_MODE_FSCREDS)
 #define PTRACE_MODE_READ_REALCREDS (PTRACE_MODE_READ | PTRACE_MODE_REALCREDS)
 #define PTRACE_MODE_ATTACH_FSCREDS (PTRACE_MODE_ATTACH | PTRACE_MODE_FSCREDS)
 #define PTRACE_MODE_ATTACH_REALCREDS (PTRACE_MODE_ATTACH | PTRACE_MODE_REALCREDS)
-#define PTRACE_MODE_SPEC_IBPB (PTRACE_MODE_ATTACH_REALCREDS | PTRACE_MODE_IBPB)
 
 /**
  * ptrace_may_access - check whether the caller is permitted to access
@@ -90,20 +87,6 @@ extern void exit_ptrace(struct task_stru
  */
 extern bool ptrace_may_access(struct task_struct *task, unsigned int mode);
 
-/**
- * ptrace_may_access - check whether the caller is permitted to access
- * a target task.
- * @task: target task
- * @mode: selects type of access and caller credentials
- *
- * Returns true on success, false on denial.
- *
- * Similar to ptrace_may_access(). Only to be called from context switch
- * code. Does not call into audit and the regular LSM hooks due to locking
- * constraints.
- */
-extern bool ptrace_may_access_sched(struct task_struct *task, unsigned int mode);
-
 static inline int ptrace_reparented(struct task_struct *child)
 {
 	return !same_thread_group(child->real_parent, child->parent);
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -261,9 +261,6 @@ static int ptrace_check_attach(struct ta
 
 static int ptrace_has_cap(struct user_namespace *ns, unsigned int mode)
 {
-	if (mode & PTRACE_MODE_SCHED)
-		return false;
-
 	if (mode & PTRACE_MODE_NOAUDIT)
 		return has_ns_capability_noaudit(current, ns, CAP_SYS_PTRACE);
 	else
@@ -331,16 +328,9 @@ static int __ptrace_may_access(struct ta
 	     !ptrace_has_cap(mm->user_ns, mode)))
 	    return -EPERM;
 
-	if (mode & PTRACE_MODE_SCHED)
-		return 0;
 	return security_ptrace_access_check(task, mode);
 }
 
-bool ptrace_may_access_sched(struct task_struct *task, unsigned int mode)
-{
-	return __ptrace_may_access(task, mode | PTRACE_MODE_SCHED);
-}
-
 bool ptrace_may_access(struct task_struct *task, unsigned int mode)
 {
 	int err;


