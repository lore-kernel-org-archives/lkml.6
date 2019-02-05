Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE09C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14112070B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="U563G7iP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfBELXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:23:07 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40304 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbfBELXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:23:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id f188so3176116wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 03:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FsEq8PViZYcZB8uuToBhj4NENPaLkjCmQanmTlxMIC4=;
        b=U563G7iPIiPndfc5SGfjeWoeuvbEIyN8MOzXC7kbxrhDJO/Hh6rqEEN/UbjkQLUOpC
         D/wmiF+Wyx5sJQHpDREkskFUbHpYY5vZxlWesLyqfkvpXVfxfmaX5JoS3jt14G9ogyMT
         aJX9aMy7u278HMQdCEwvIF+Af4ZkVzz1iPaXxVIO4BOibYQGMLOqnuige6wBuOjyBRmS
         TS8DxIKbPTxxOIfUAlMjCwiSPcB1H1Afw+PuvpoXOvgNr4XaLIndtkotYiFW5b2+YIXD
         FtN9yVC9XbFRtY35gtk6lSFszuRr1dpMY/Pkumu+tggE5tpjmVnkE9wMxFp2y801XkH6
         01Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FsEq8PViZYcZB8uuToBhj4NENPaLkjCmQanmTlxMIC4=;
        b=sEOeft19hucpXM6iWvjxHBtqzlDtQid1GaeEfSUgYHciyXpjN+rJi9rGNtTo0ylaNX
         XgUm0vaXHndL+bgWymEO5a0zWtUHWo9evRjPYopCtzPLYAgdi9YbviVH1IXDbPW+Cx9P
         utX9IfVxnuKVwpabGYQMh2q+3tLHK2rs1BQeeyg21QuF2IXLj66ENkuSVD+EZxS24bIu
         Xne/DvHbKZ1CLstLxF8biHOS26354aC6QqnOrWh8BuZrsh1xZMgILSVr0YPOLep+wSWc
         ZytPb/zdyMSEo2vmtxg7lS3TnC1smKg56CrRyCnwagWSEfvqTxyzgeKorQWSm+5h/zt7
         VAaw==
X-Gm-Message-State: AHQUAubLfUzr1owW7LvLuxb4UnlfXjAf2akkxsFgBvSZEqiUnOCcRWNk
        QBGvwntrhCOsGe18J64yu9zi8A==
X-Google-Smtp-Source: AHgI3IbuoFFB4SlLpvTr4Pdm80KCduyuZ83MRmty/k+C3ueW7u3lHSycksJwf/Ekkys25EVn+bKJPg==
X-Received: by 2002:a1c:5f04:: with SMTP id t4mr3148254wmb.141.1549365784676;
        Tue, 05 Feb 2019 03:23:04 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6c0:76e:3db8:91df:1b3:e26d])
        by smtp.gmail.com with ESMTPSA id e9sm19721545wrc.56.2019.02.05.03.23.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 03:23:04 -0800 (PST)
Date:   Tue, 5 Feb 2019 12:23:02 +0100
From:   Christian Brauner <christian@brauner.io>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jack Andersen <jackoalan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] signal: always allocate siginfo for SI_TKILL
Message-ID: <20190205112301.z72wfoz4k2bbafu4@brauner.io>
References: <20190203074939.7261-1-jackoalan@gmail.com>
 <20190203083933.ee4a6j4mdecesbn2@brauner.io>
 <CAGXu5jLGgCChpxt3ee8kSi2pTKPd9baHt_uZvTG6qqi8oFK2UQ@mail.gmail.com>
 <87r2cn7y9g.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r2cn7y9g.fsf@xmission.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 08:41:15PM -0600, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Sun, Feb 3, 2019 at 12:39 AM Christian Brauner <christian@brauner.io> wrote:
> >>
> >> On Sat, Feb 02, 2019 at 09:49:38PM -1000, Jack Andersen wrote:
> >> > The patch titled
> >> > `signal: Never allocate siginfo for SIGKILL or SIGSTOP`
> >> > created a regression for users of PTRACE_GETSIGINFO needing to
> >> > discern signals that were raised via the tgkill syscall.
> >> >
> >> > A notable user of this tgkill+ptrace combination is lldb while
> >> > debugging a multithreaded program. Without the ability to detect a
> >> > SIGSTOP originating from tgkill, lldb does not have a way to
> >> > synchronize on a per-thread basis and falls back to SIGSTOP-ing the
> >> > entire process.
> >> >
> >> > This patch allocates the siginfo as it did previously whenever the
> >> > SI_TKILL code is present.
> >> >
> >> > Signed-off-by: Jack Andersen <jackoalan@gmail.com>
> >>
> >> The  commit you're trying to fix has been discussed before wrt to
> >> seccomp tests:
> >>
> >> commit 2bd61abead58c82714a1f6fa6beb0fd0df6a6d13
> >> Author: Kees Cook <keescook@chromium.org>
> >> Date:   Thu Dec 6 15:50:38 2018 -0800
> >>
> >>     selftests/seccomp: Remove SIGSTOP si_pid check
> >>
> >>     Commit f149b3155744 ("signal: Never allocate siginfo for SIGKILL or SIGSTOP")
> >>     means that the seccomp selftest cannot check si_pid under SIGSTOP anymore.
> >>     Since it's believed[1] there are no other userspace things depending on the
> >>     old behavior, this removes the behavioral check in the selftest, since it's
> >>     more a "extra" sanity check (which turns out, maybe, not to have been
> >>     useful to test).
> >>
> >>     [1] https://lkml.kernel.org/r/CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com
> >>
> >>     Reported-by: Tycho Andersen <tycho@tycho.ws>
> >>     Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
> >>     Signed-off-by: Kees Cook <keescook@chromium.org>
> >>     Signed-off-by: Shuah Khan <shuah@kernel.org>
> >>
> >> Ccing Kees on this. Seems that this commit might be worth given that
> >> there's some parts of userspace relying on it and not just internal
> >> kernel tests.
> >
> > Yup, so this is the "real" userspace example that Eric was looking for.
> 
> Yes it is.
> 
> > Eric, how does the proposed fix look? I'd also like to revert my
> > seccomp selftest change too, since it clearly found a real-world use.
> > :)
> 
> I think the simpler change to just do:
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index e1d7ad8e6ab1..45298b3a8ffc 100644
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
> is the better fix.  As Christian points out that fixes possible
> issues with SIGSTOP.

Yep. That looks good! I take it you'll be sending this out then. :)
Thanks Eric! 

Reviewed-by: Christian Brauner <christian@brauner.io>
