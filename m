Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579D0C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F7420892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F7420892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbeLFVLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:11:35 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:50499 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeLFVLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:11:33 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gV0vk-0003Ra-GR; Thu, 06 Dec 2018 14:11:32 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gV0vj-0004Hb-Na; Thu, 06 Dec 2018 14:11:32 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20181112192443.GL3645@cisco> <20181127232126.GA23658@cisco>
        <CAGXu5jLw0m8pG16u3huThNM2fYGjKoB2-5baUmg_FH6Z=L2SAg@mail.gmail.com>
        <CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com>
        <87zhtthkuy.fsf@xmission.com>
        <CAGXu5jJv+TG8hovHi3Z5kTccz+Cx-keu=KZf032mCz2VRpc=Og@mail.gmail.com>
        <87k1ktqoe5.fsf@xmission.com>
        <CAGXu5jJgFrWajK5m8ev72DV9ueznLnbGV2-UGECnz0iZ_EFDUg@mail.gmail.com>
        <87r2euiuql.fsf@xmission.com>
        <CAHk-=wjTzjOqEhWJskx7ToHL2d1KUxsNOZ2V0=v_R6VJYtOm7Q@mail.gmail.com>
        <20181206192059.GD10086@cisco>
Date:   Thu, 06 Dec 2018 15:11:20 -0600
In-Reply-To: <20181206192059.GD10086@cisco> (Tycho Andersen's message of "Thu,
        6 Dec 2018 12:20:59 -0700")
Message-ID: <87lg528io7.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gV0vj-0004Hb-Na;;;mid=<87lg528io7.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18BfvyqDnk7yUNNtTwx8jkzq2qkGaW2fQQ=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: siginfo pid not populated from ptrace?
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tycho Andersen <tycho@tycho.ws> writes:

> On Thu, Dec 06, 2018 at 10:48:39AM -0800, Linus Torvalds wrote:
>> On Thu, Dec 6, 2018 at 6:40 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> >
>> > We have in the past had ptrace users that weren't just about debugging
>> > so I don't know that it is fair to just dismiss it as debugging
>> > infrastructure.
>> 
>> Absolutely.
>> 
>> Some uses are more than just debug. People occasionally use ptrace
>> because it's the only way to do what they want, so you'll find people
>> who do it for sandboxing, for example. It's not necessarily designed
>> for that, or particularly fast or well-suited for it, but I've
>> definitely seen it used that way.
>> 
>> So I don't think the behavioral test breakage like this is necessarily
>> a huge deal, and until some "real use" actually shows that it cares it
>> might be something we dismiss as "just test", but it very much has the
>> potential to hit real uses.
>> 
>> The fact that a behavioral test broke is definitely interesting.
>> 
>> And maybe some of the siginfo allocations could depend on whether the
>> signal is actually ever caught or not.
>> 
>> For example, a terminal signal (or one that is ignored) might not need
>> siginfo. But if the process is ptraced, maybe that terminal signal
>> isn't actually terminal? So we might have situations where we want to
>> simply check "is the signal target being ptraced"..
>
> Yes, something like this, I suppose? It works for me.

The challenge is that we could be delivering this to a zombie signal
group leader.  At which point we won't deliver it to the target task.

Sigh it is probably time that I dig in and figure out how to avoid that
case which we need to fix anyway because we can get the permission
checks wrong for multi-threaded processes that call setuid and friends.

Once that is sorted your small change will at least be safe.

Eric

> From 3bcaadd56ebb532ab4d481556fcc0826d65efc43 Mon Sep 17 00:00:00 2001
> From: Tycho Andersen <tycho@tycho.ws>
> Date: Thu, 6 Dec 2018 12:15:22 -0700
> Subject: [PATCH] signal: allocate siginfo when a traced task gets SIGSTOP
>
> Tracers can view SIGSTOP:
>
> https://lore.kernel.org/lkml/87zhtthkuy.fsf@xmission.com/T/#u
>
> so let's allocate a siginfo for SIGSTOP when a task is traced.
>
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> ---
>  kernel/signal.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 9a32bc2088c9..ab4ba00119f4 100644
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
> +	    (t->flags & PF_KTHREAD))
>  		goto out_set;
>  
>  	/*
