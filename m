Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C5DC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12BE2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 14:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12BE2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbeJXWaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 18:30:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbeJXWaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 18:30:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D17DF308421B;
        Wed, 24 Oct 2018 14:02:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4508B60921;
        Wed, 24 Oct 2018 14:02:16 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 24 Oct 2018 16:02:22 +0200 (CEST)
Date:   Wed, 24 Oct 2018 16:02:15 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Enke Chen <enkechen@cisco.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Victor Kamensky (kamensky)" <kamensky@cisco.com>,
        xe-linux-external@cisco.com, Stefan Strogin <sstrogin@cisco.com>
Subject: Re: [PATCH v3] kernel/signal: Signal-based pre-coredump notification
Message-ID: <20181024140214.GG30128@redhat.com>
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <458c04d8-d189-4a26-729a-bb1d1d751534@cisco.com>
 <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7741efa7-a3f8-62a1-ba52-613883164643@cisco.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 24 Oct 2018 14:02:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23, Enke Chen wrote:
>
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -590,6 +590,12 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  	if (retval < 0)
>  		goto fail_creds;
>
> +	/*
> +	 * Send the pre-coredump signal to the parent if requested.
> +	 */
> +	do_notify_parent_predump();
> +	cond_resched();

I am still not sure cond_resched() makes any sense here...

> @@ -1553,6 +1553,9 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
>  	tty_audit_fork(sig);
>  	sched_autogroup_fork(sig);
>
> +	/* Clear the pre-coredump signal for the child */
> +	sig->predump_signal = 0;

No need, copy_signal() does zalloc().


> +void do_notify_parent_predump(void)
> +{
> +	struct sighand_struct *sighand;
> +	struct kernel_siginfo info;
> +	struct task_struct *parent;
> +	unsigned long flags;
> +	int sig;
> +
> +	read_lock(&tasklist_lock);
> +	parent = current->parent;
> +	sig = parent->signal->predump_signal;
> +	if (sig != 0) {
> +		clear_siginfo(&info);
> +		info.si_pid = task_tgid_vnr(current);
> +		info.si_signo = sig;
> +		if (sig == SIGCHLD)
> +			info.si_code = CLD_PREDUMP;
> +
> +		sighand = parent->sighand;
> +		spin_lock_irqsave(&sighand->siglock, flags);
> +		__group_send_sig_info(sig, &info, parent);
> +		spin_unlock_irqrestore(&sighand->siglock, flags);

You can just use do_send_sig_info() and remove sighand/flags/spin_lock_irqsave.

Perhaps the "likely" predump_signal==0 check at the start makes sense to avoid
read_lock(tasklist).

And I'd suggest to move it into coredump.c and make it static. It won't have
another user.

Oleg.

