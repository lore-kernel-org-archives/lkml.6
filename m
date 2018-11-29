Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA7DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D6E21019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CU4G/0f/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D6E21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeK3IYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:24:03 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33269 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbeK3IYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:24:03 -0500
Received: by mail-yb1-f193.google.com with SMTP id i78-v6so1369775ybg.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 13:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gelRQd9fpeCKR786ciNloVyvLGhoQvwPwZSQe8mBvW4=;
        b=CU4G/0f/bARfTH9GMQ5D9iYpt93cwEv/tOKjD9wangHPaEsH5KjGBjfgb8T/kLSOr6
         JBtP2DNYpPC6LqdqSCjDKuZNJuXmjGJZS0NfDEkPYvL5C/YVKtOywrkkdgf6wVRVh+Tb
         iX9B9l37sVr7esZF1Ot8e1bl6PJzT8t2mFdwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gelRQd9fpeCKR786ciNloVyvLGhoQvwPwZSQe8mBvW4=;
        b=AefACQWx+QuTpN520YPINPN7DzPIBFkKmL3RWwG58t8OF+nZQaNhteh0ZfS/17nNOA
         qBnU2NqzEi9BVcqJkzZzbqDjxbOwnqs6BNP5Z3lFCaNkwBckhIKKutllsgTRnEdy1dpE
         0i5RXS4aHdk3K99K9hvaVjv9aE+AfOB2E+eOr/P8Ew/3/UFUkiAZauK8Kac86oRyGW3t
         nRw44b/58PY0j2P2nn1R939Osb8jUMgmesQSs6MDiwDGN6zqnelrP4VZKWhR5pOWDTdp
         LnJD5rpuSa5YN9fKuHD/Y0wu0csIHw472PBp2YG3dzQS6UVzT7+WNgqIk302+tPjDjwa
         tjBw==
X-Gm-Message-State: AA+aEWa9oa+VWAkfZgrNBV9d8F//tgH1bvO0FxSF9rvYJlm3nRN82mqp
        MfsHZJb0Z0SAs22ridfUuWbZbwVvlT8=
X-Google-Smtp-Source: AFSGD/WMlZE1LD37P63MLXOQt70GL5onnliyQ0zsQmV/LRyw6uGhNI9eJGizU/3HqqS+yX7S5tDqxQ==
X-Received: by 2002:a25:3005:: with SMTP id w5-v6mr3037461ybw.365.1543526236366;
        Thu, 29 Nov 2018 13:17:16 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id s189-v6sm884105ywg.69.2018.11.29.13.17.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 13:17:16 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id z2-v6so1363385ybj.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 13:17:14 -0800 (PST)
X-Received: by 2002:a25:2349:: with SMTP id j70-v6mr3027535ybj.137.1543526234125;
 Thu, 29 Nov 2018 13:17:14 -0800 (PST)
MIME-Version: 1.0
References: <20181112171144.GI3645@cisco> <87efbqi1xa.fsf@xmission.com>
 <20181112185538.GK3645@cisco> <20181112192443.GL3645@cisco>
 <20181127232126.GA23658@cisco> <CAGXu5jLw0m8pG16u3huThNM2fYGjKoB2-5baUmg_FH6Z=L2SAg@mail.gmail.com>
 <CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com> <87zhtthkuy.fsf@xmission.com>
In-Reply-To: <87zhtthkuy.fsf@xmission.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 29 Nov 2018 13:17:01 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJv+TG8hovHi3Z5kTccz+Cx-keu=KZf032mCz2VRpc=Og@mail.gmail.com>
Message-ID: <CAGXu5jJv+TG8hovHi3Z5kTccz+Cx-keu=KZf032mCz2VRpc=Og@mail.gmail.com>
Subject: Re: siginfo pid not populated from ptrace?
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 8:44 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Kees Cook <keescook@chromium.org> writes:
>
> > On Tue, Nov 27, 2018 at 4:38 PM, Kees Cook <keescook@chromium.org> wrote:
> >> On Tue, Nov 27, 2018 at 3:21 PM, Tycho Andersen <tycho@tycho.ws> wrote:
> >>> On Mon, Nov 12, 2018 at 12:24:43PM -0700, Tycho Andersen wrote:
> >>>> On Mon, Nov 12, 2018 at 11:55:38AM -0700, Tycho Andersen wrote:
> >>>> > I haven't manage to reproduce it on stock v4.20-rc2, unfortunately.
> >>>>
> >>>> Ok, now I have,
> >>>>
> >>>> seccomp_bpf.c:2736:global.syscall_restart:Expected getpid() (1493) == info._sifields._kill.si_pid (0)
> >>>> global.syscall_restart: Test failed at step #22
> >>>
> >>> Seems like this is still happening on v4.20-rc4,
> >>>
> >>> [ RUN      ] global.syscall_restart
> >>> seccomp_bpf.c:2736:global.syscall_restart:Expected getpid() (1901) == info._sifields._kill.si_pid (0)
> >>> global.syscall_restart: Test failed at step #22
> >>
> >> This fails every time for me -- is it still racey for you?
> >>
> >> I'm attempting a bisect, hoping it doesn't _become_ racey for me. ;)
> >
> > This bisect to here for me:
> >
> > commit f149b31557446aff9ca96d4be7e39cc266f6e7cc
> > Author: Eric W. Biederman <ebiederm@xmission.com>
> > Date:   Mon Sep 3 09:50:36 2018 +0200
> >
> >     signal: Never allocate siginfo for SIGKILL or SIGSTOP
> >
> >     The SIGKILL and SIGSTOP signals are never delivered to userspace so
> >     queued siginfo for these signals can never be observed.  Therefore
> >     remove the chance of failure by never even attempting to allocate
> >     siginfo in those cases.
> >
> >     Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> >     Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >
> > They are certainly visible via seccomp ;)
>
> Well SIGSTOP is visible via PTRACE_GETSIGINFO.
>
> I see what is happening now.  Since we don't have queued siginfo
> we generate some as:
>                 /*
>                  * Ok, it wasn't in the queue.  This must be
>                  * a fast-pathed signal or we must have been
>                  * out of queue space.  So zero out the info.
>                  */
>                 clear_siginfo(info);
>                 info->si_signo = sig;
>                 info->si_errno = 0;
>                 info->si_code = SI_USER;
>                 info->si_pid = 0;
>                 info->si_uid = 0;
>
> Which allows last_signfo to be set,
> so despite not really having any siginfo PTRACE_GET_SIGINFO
> has something to return so does not return -EINVAL.
>
> Reconstructing my context that was part of removing SEND_SIG_FORCED
> so this looks like it will take a little more than a revert to fix
> this.
>
> This is definitely a change that is visible to user space.  The logic in
> my patch was definitely wrong with respect to SIGSTOP and
> PTRACE_GETSIGINFO.  Is there something in userspace that actually cares?
> AKA is the idiom that the test seccomp_bpf.c is using something that
> non-test code does?

I think this would be needed by any ptracer that handled multiple
threads. It needs to figure out which pid stopped. I think it's worth
fixing, yes.

> The change below should restore the old behavior.  I am just wondering
> if this is something we want to do.  siginfo is allocated with
> GFP_ATOMIC so if your machine is under memory pressure there is a real
> chance the allocation can fail.  Which would cause whatever is breaking
> now to break less deterministically then.

I think memory pressure that would block a 128 byte GFP_ATOMIC
allocation would mean the system was about to seriously fall over.
Given the user-facing behavior change and that an existing test was
already checking for this means we need to fix it.

> If we need to fix this do we need to make siginfo allocation more
> reliable?

I don't think so -- we'd already get a WARN() if allocation failed.

> Eric
>
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 4fd431ce4f91..5c34c55bfea4 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1057,10 +1057,10 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
>
>         result = TRACE_SIGNAL_DELIVERED;
>         /*
> -        * Skip useless siginfo allocation for SIGKILL SIGSTOP,
> +        * Skip useless siginfo allocation for SIGKILL,
>          * and kernel threads.
>          */
> -       if (sig_kernel_only(sig) || (t->flags & PF_KTHREAD))
> +       if ((sig == SIGKILL) || (t->flags & PF_KTHREAD))
>                 goto out_set;
>
>         /*
>

This fixes it for me!

Reported-by: Tycho Andersen <tycho@tycho.ws>
Tested-by: Kees Cook <keescook@chromium.org>
Fixes: f149b3155744 ("signal: Never allocate siginfo for SIGKILL or SIGSTOP")

Thanks!

-- 
Kees Cook
