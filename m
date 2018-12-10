Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F11C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155AE20851
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155AE20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeLJO5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:57:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbeLJO5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:57:19 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB2583097066;
        Mon, 10 Dec 2018 14:57:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.131])
        by smtp.corp.redhat.com (Postfix) with SMTP id 64F5460158;
        Mon, 10 Dec 2018 14:57:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 10 Dec 2018 15:57:18 +0100 (CET)
Date:   Mon, 10 Dec 2018 15:57:16 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: siginfo pid not populated from ptrace?
Message-ID: <20181210145716.GC4177@redhat.com>
References: <20181127232126.GA23658@cisco>
 <CAGXu5jLw0m8pG16u3huThNM2fYGjKoB2-5baUmg_FH6Z=L2SAg@mail.gmail.com>
 <CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com>
 <87zhtthkuy.fsf@xmission.com>
 <CAGXu5jJv+TG8hovHi3Z5kTccz+Cx-keu=KZf032mCz2VRpc=Og@mail.gmail.com>
 <87k1ktqoe5.fsf@xmission.com>
 <CAGXu5jJgFrWajK5m8ev72DV9ueznLnbGV2-UGECnz0iZ_EFDUg@mail.gmail.com>
 <87r2euiuql.fsf@xmission.com>
 <CAHk-=wjTzjOqEhWJskx7ToHL2d1KUxsNOZ2V0=v_R6VJYtOm7Q@mail.gmail.com>
 <20181206192059.GD10086@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206192059.GD10086@cisco>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 10 Dec 2018 14:57:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06, Tycho Andersen wrote:
>
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1056,11 +1056,14 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
>  		goto ret;
>  
>  	result = TRACE_SIGNAL_DELIVERED;
> +
>  	/*
> -	 * Skip useless siginfo allocation for SIGKILL SIGSTOP,
> -	 * and kernel threads.
> +	 * Skip useless siginfo allocation for SIGKILL and kernel threads.
> +	 * SIGSTOP is visible to tracers, so only skip allocation when the task
> +	 * is not traced.
>  	 */
> -	if (sig_kernel_only(sig) || (t->flags & PF_KTHREAD))
> +	if ((sig == SIGKILL) || (!task_is_traced(t) && sig == SIGSTOP) ||
			          ^^^^^^^^^^^^^^

task_is_traced() checks task->state, probably you meant t->ptrace != 0.

However, in multithreaded case t->ptrace won't help too, unless the signal
is private you do not know which thread will actually dequeue this signal
and possibly report to debugger.

Oleg.

