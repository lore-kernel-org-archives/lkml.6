Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E98ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 02:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414F020831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 02:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 414F020831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbeJYKq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 06:46:26 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:26502 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbeJYKq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 06:46:26 -0400
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9P2Fn1Z078174;
        Thu, 25 Oct 2018 11:15:49 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp);
 Thu, 25 Oct 2018 11:15:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav107.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9P2Fmg6078169;
        Thu, 25 Oct 2018 11:15:48 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id w9P2Fm2M078167;
        Thu, 25 Oct 2018 11:15:48 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201810250215.w9P2Fm2M078167@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: KASAN: use-after-free Read in =?ISO-2022-JP?B?dGFza19pc19kZXNjZW5k?=
 =?ISO-2022-JP?B?YW50?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     serge@hallyn.com,
        syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>,
        jmorris@namei.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
MIME-Version: 1.0
Date:   Thu, 25 Oct 2018 11:15:48 +0900
References: <76013c9e-0664-ef5e-b6c0-d48f6ce5db3c@i-love.sakura.ne.jp> <20181022134634.GA7358@redhat.com>
In-Reply-To: <20181022134634.GA7358@redhat.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> On 10/22, Tetsuo Handa wrote:
> > > And again, I do not know how/if yama ensures that child is rcu-protected, perhaps
> > > task_is_descendant() needs to check pid_alive(child) right after rcu_read_lock() ?
> >
> > Since the caller (ptrace() path) called get_task_struct(child), child itself can't be
> > released. Do we still need pid_alive(child) ?
> 
> get_task_struct(child) can only ensure that this task_struct can't be freed.

The report says that it is a use-after-free read at

  walker = rcu_dereference(walker->real_parent);

which means that walker was already released.

> 
> Suppose that this child exits after get_task_struct(), then its real_parent exits
> too and calls call_rcu(delayed_put_task_struct).
> 
> Now, when task_is_descendant() is called, rcu_read_lock() can happen after rcu gp,
> iow child->parent can be already freed/reused/unmapped.
> 
> We need to ensure that child is still protected by RCU.

I wonder whether pid_alive() test helps.

We can get

[   40.620318] parent or walker is dead.
[   40.624146] tracee is dead.

messages using below patch and reproducer.

----------
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 99cfddd..0d9d786 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -385,6 +385,7 @@ static int ptrace_attach(struct task_struct *task, long request,
 	if (mutex_lock_interruptible(&task->signal->cred_guard_mutex))
 		goto out;
 
+	schedule_timeout_killable(HZ);
 	task_lock(task);
 	retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
 	task_unlock(task);
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index ffda91a..a231ec6 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -283,6 +283,11 @@ static int task_is_descendant(struct task_struct *parent,
 		return 0;
 
 	rcu_read_lock();
+	if (!pid_alive(parent) || !pid_alive(walker)) {
+		rcu_read_unlock();
+		printk("parent or walker is dead.\n");
+		return 0;
+	}
 	if (!thread_group_leader(parent))
 		parent = rcu_dereference(parent->group_leader);
 	while (walker->pid > 0) {
@@ -315,6 +320,10 @@ static int ptracer_exception_found(struct task_struct *tracer,
 	bool found = false;
 
 	rcu_read_lock();
+	if (!pid_alive(tracee)) {
+		printk("tracee is dead.\n");
+		goto unlock;
+	}
 
 	/*
 	 * If there's already an active tracing relationship, then make an
----------

----------
#include <unistd.h>
#include <sys/ptrace.h>
#include <poll.h>

int main(int argc, char *argv[])
{
	if (fork() == 0) {
		ptrace(PTRACE_ATTACH, getppid(), NULL, NULL);
		_exit(0);
	}
	poll(NULL, 0, 100);
	return 0;
}
----------

But since "child" has at least one reference, reading "child->real_parent" should
be safe. Therefore, I think that bailing out due to pid_is_alive(child) == false
(like above patch does) cannot avoid this problem...

