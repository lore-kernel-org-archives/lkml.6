Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDABC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26EBE2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26EBE2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeJYTqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:46:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34898 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727350AbeJYTqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:46:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 215234AD58;
        Thu, 25 Oct 2018 11:14:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7ACB2611CF;
        Thu, 25 Oct 2018 11:13:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 25 Oct 2018 13:13:58 +0200 (CEST)
Date:   Thu, 25 Oct 2018 13:13:56 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     serge@hallyn.com,
        syzbot <syzbot+a9ac39bf55329e206219@syzkaller.appspotmail.com>,
        jmorris@namei.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in task_is_descendant
Message-ID: <20181025111355.GA3725@redhat.com>
References: <76013c9e-0664-ef5e-b6c0-d48f6ce5db3c@i-love.sakura.ne.jp>
 <20181022134634.GA7358@redhat.com>
 <201810250215.w9P2Fm2M078167@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201810250215.w9P2Fm2M078167@www262.sakura.ne.jp>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 25 Oct 2018 11:14:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25, Tetsuo Handa wrote:
>
> Oleg Nesterov wrote:
> > On 10/22, Tetsuo Handa wrote:
> > > > And again, I do not know how/if yama ensures that child is rcu-protected, perhaps
> > > > task_is_descendant() needs to check pid_alive(child) right after rcu_read_lock() ?
> > >
> > > Since the caller (ptrace() path) called get_task_struct(child), child itself can't be
> > > released. Do we still need pid_alive(child) ?
> >
> > get_task_struct(child) can only ensure that this task_struct can't be freed.
>
> The report says that it is a use-after-free read at
>
>   walker = rcu_dereference(walker->real_parent);
>
> which means that walker was already released.

quite possibly I missed something, but I am not sure I understand your concerns...

So again, suppose that "child" is already dead. Its task_struct can't be freed,
but child->real_parent can point to the already freed memory.

This means that the 1st walker = rcu_dereference(walker->real_parent) is fine,
this simply reads the child->real_parent pointer, but on the second iteration

	walker = rcu_dereference(walker->real_parent);

reads the alredy freed memory.

> I wonder whether pid_alive() test helps.
>
> We can get
>
> [   40.620318] parent or walker is dead.
> [   40.624146] tracee is dead.
>
> messages using below patch and reproducer.

again, I do not understand, this all looks correct...

> ----------
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 99cfddd..0d9d786 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -385,6 +385,7 @@ static int ptrace_attach(struct task_struct *task, long request,
>  	if (mutex_lock_interruptible(&task->signal->cred_guard_mutex))
>  		goto out;
>
> +	schedule_timeout_killable(HZ);
>  	task_lock(task);
>  	retval = __ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS);
>  	task_unlock(task);
> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index ffda91a..a231ec6 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -283,6 +283,11 @@ static int task_is_descendant(struct task_struct *parent,
>  		return 0;
>
>  	rcu_read_lock();
> +	if (!pid_alive(parent) || !pid_alive(walker)) {
> +		rcu_read_unlock();
> +		printk("parent or walker is dead.\n");

This is what we need to do, except I think we should change yama_ptrace_access_check().
And iiuc parent == current, pid_alive(parent) looks unnecessary. Although we need to
check ptracer_exception_found(), may be it needs some changes too.

And yes, task_is_descendant() can hit the dead child, if nothing else it can
be killed. This can explain the kasan report.

> @@ -315,6 +320,10 @@ static int ptracer_exception_found(struct task_struct *tracer,
>  	bool found = false;
>
>  	rcu_read_lock();
> +	if (!pid_alive(tracee)) {
> +		printk("tracee is dead.\n");
> +		goto unlock;

Sure, this is possible too.

> But since "child" has at least one reference, reading "child->real_parent" should
> be safe. Therefore, I think that bailing out due to pid_is_alive(child) == false
> (like above patch does) cannot avoid this problem...

Why?

OK. Lets ignore ptracer_exception_found() for the moment. Why do you think the
patch below can't help?

Oleg.

--- x/security/yama/yama_lsm.c
+++ x/security/yama/yama_lsm.c
@@ -368,7 +368,8 @@ static int yama_ptrace_access_check(stru
 			break;
 		case YAMA_SCOPE_RELATIONAL:
 			rcu_read_lock();
-			if (!task_is_descendant(current, child) &&
+			if (!pid_alive(child) ||
+			    !task_is_descendant(current, child) &&
 			    !ptracer_exception_found(current, child) &&
 			    !ns_capable(__task_cred(child)->user_ns, CAP_SYS_PTRACE))
 				rc = -EPERM;

