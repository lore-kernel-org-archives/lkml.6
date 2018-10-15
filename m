Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29421C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C442064A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 12:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C442064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbeJOTud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:50:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33992 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbeJOTud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:50:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B1A35CF21;
        Mon, 15 Oct 2018 12:05:32 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9E24B45A5;
        Mon, 15 Oct 2018 12:05:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 15 Oct 2018 14:05:32 +0200 (CEST)
Date:   Mon, 15 Oct 2018 14:05:21 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Enke Chen <enkechen@cisco.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Victor Kamensky (kamensky)" <kamensky@cisco.com>,
        xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>,
        Eugene Syromiatnikov <esyr@redhat.com>
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
Message-ID: <20181015120521.GA10146@redhat.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 15 Oct 2018 12:05:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12, Enke Chen wrote:
>
> For simplicity and consistency, this patch provides an implementation
> for signal-based fault notification prior to the coredump of a child
> process. A new prctl command, PR_SET_PREDUMP_SIG, is defined that can
> be used by an application to express its interest and to specify the
> signal (SIGCHLD or SIGUSR1 or SIGUSR2) for such a notification. A new
> signal code (si_code), CLD_PREDUMP, is also defined for SIGCHLD.

To be honest, I can't say I like this new feature...

> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -696,6 +696,10 @@ struct task_struct {
>  	int				exit_signal;
>  	/* The signal sent when the parent dies: */
>  	int				pdeath_signal;
> +
> +	/* The signal sent prior to a child's coredump: */
> +	int				predump_signal;
> +

At least, I think predump_signal should live in signal_struct, not
task_struct.

(pdeath_signal too, but it is too late to change (fix) this awkward API).

> +static void do_notify_parent_predump(struct task_struct *tsk)
> +{
> +	struct sighand_struct *sighand;
> +	struct task_struct *parent;
> +	struct kernel_siginfo info;
> +	unsigned long flags;
> +	int sig;
> +
> +	parent = tsk->real_parent;

So, debuggere won't be notified, only real_parent...

> +	sig = parent->predump_signal;

probably ->predump_signal should be cleared on exec?

> +	/* Check again with tasklist_lock" locked by the caller */
> +	if (!valid_predump_signal(sig))
> +		return;

I don't understand why we need valid_predump_signal() at all.

>  bool get_signal(struct ksignal *ksig)
>  {
>  	struct sighand_struct *sighand = current->sighand;
> @@ -2497,6 +2535,19 @@ bool get_signal(struct ksignal *ksig)
>  		current->flags |= PF_SIGNALED;
>  
>  		if (sig_kernel_coredump(signr)) {
> +			/*
> +			 * Notify the parent prior to the coredump if the
> +			 * parent is interested in such a notificaiton.
> +			 */
> +			int p_sig = current->real_parent->predump_signal;
> +
> +			if (valid_predump_signal(p_sig)) {
> +				read_lock(&tasklist_lock);
> +				do_notify_parent_predump(current);
> +				read_unlock(&tasklist_lock);
> +				cond_resched();

perhaps this should be called by do_coredump() after coredump_wait() kills
all the sub-threads?

> +static int prctl_set_predump_signal(struct task_struct *tsk, pid_t pid, int sig)
> +{
> +	struct task_struct *p;
> +	int error;
> +
> +	/* 0 is valid for disabling the feature */
> +	if (sig && !valid_predump_signal(sig))
> +		return -EINVAL;
> +
> +	/* For the current task, the common case */
> +	if (pid == 0) {
> +		tsk->predump_signal = sig;
> +		return 0;
> +	}
> +
> +	error = -ESRCH;
> +	rcu_read_lock();
> +	p = find_task_by_vpid(pid);
> +	if (p) {
> +		if (!set_predump_signal_perm(p))
> +			error = -EPERM;
> +		else {
> +			error = 0;
> +			p->predump_signal = sig;
> +		}
> +	}
> +	rcu_read_unlock();
> +	return error;
> +}

Why? I mean, why do we really want to support the pid != 0 case?

Oleg.

