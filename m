Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395F6C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D3E2082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KzM1jgVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D3E2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbeLFVek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:34:40 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34810 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeLFVeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:34:37 -0500
Received: by mail-yb1-f195.google.com with SMTP id n15so218203ybd.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 13:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ganMFL1kWtWhNk4pHpEkt+vbRc+N2cb9u3uVW+UYyxs=;
        b=KzM1jgVoj6Yqz5PKztiOvi0BinlQvrj0VzEI6sdTbtBGW2O+SjDv+Bb28I45Sd8+XI
         nP5RT/vUbm0GX3Jp5tTOkSgT69DBr9s5MT3AyUxPIGHJv0aiZRDjVYu+saMU6j6uosiV
         M2Ka1/Omg1KvO6OvF+TEK8mKSULeFC2PqMOP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ganMFL1kWtWhNk4pHpEkt+vbRc+N2cb9u3uVW+UYyxs=;
        b=cyw411OyE6PF9tIhwpjUHtXCWvf1Db18kbwLzikCdxt6YAbk0t5U3MHugm0ARnVgmy
         hbOW75yZCkMDfeJTdLSEg7io20LQ3XeGnzcyZX6DZzv6mKOrEv0kkDjJwJRgr0DL6Or+
         xzbxhi44VaEO8Kw6y0KxficOhq55I/8EnWr1BjehTUzGkxUeffGOeQE2Y58FPF1Ko0ed
         PRy3yyWnkMSdeVRy/Me3Ce4EgRtBRuDacgODfVmYFUQLGAtcZKysO/a1pIGMxufeQaYh
         0LOYjzpbh/uKpQLXSMm4gjs7+LOjZ/s+gT5IPuG7d1h/83h50rC04UKPGCqoWkovZZ3T
         +Ltg==
X-Gm-Message-State: AA+aEWYC+xJN7lP6dR2a1JJEEARc27WtUKTadJ4IG67T3+d36I1TUG7i
        UYcYN6q3ZXpDfJL8MRyYCoBixPd7Z6s=
X-Google-Smtp-Source: AFSGD/WebDQNT4e1Iq8o2D4NjS7OBS37Y39dvk6RePz9I2XFdcjg2ZLGn0TNugEoAAroWceAldlnLA==
X-Received: by 2002:a5b:40a:: with SMTP id m10-v6mr29117240ybp.21.1544132075763;
        Thu, 06 Dec 2018 13:34:35 -0800 (PST)
Received: from mail-yw1-f42.google.com (mail-yw1-f42.google.com. [209.85.161.42])
        by smtp.gmail.com with ESMTPSA id w70sm434549yww.76.2018.12.06.13.34.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 13:34:34 -0800 (PST)
Received: by mail-yw1-f42.google.com with SMTP id g75so206606ywb.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 13:34:34 -0800 (PST)
X-Received: by 2002:a81:98e:: with SMTP id 136mr29954226ywj.47.1544132073806;
 Thu, 06 Dec 2018 13:34:33 -0800 (PST)
MIME-Version: 1.0
References: <20181112192443.GL3645@cisco> <20181127232126.GA23658@cisco>
 <CAGXu5jLw0m8pG16u3huThNM2fYGjKoB2-5baUmg_FH6Z=L2SAg@mail.gmail.com>
 <CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com>
 <87zhtthkuy.fsf@xmission.com> <CAGXu5jJv+TG8hovHi3Z5kTccz+Cx-keu=KZf032mCz2VRpc=Og@mail.gmail.com>
 <87k1ktqoe5.fsf@xmission.com> <CAGXu5jJgFrWajK5m8ev72DV9ueznLnbGV2-UGECnz0iZ_EFDUg@mail.gmail.com>
 <87r2euiuql.fsf@xmission.com> <CAHk-=wjTzjOqEhWJskx7ToHL2d1KUxsNOZ2V0=v_R6VJYtOm7Q@mail.gmail.com>
 <20181206192059.GD10086@cisco> <87lg528io7.fsf@xmission.com>
In-Reply-To: <87lg528io7.fsf@xmission.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 6 Dec 2018 13:34:21 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLUXCP1UWpiFRJ=jM8jwrnS1v2By8c4ywRPhAdOPAUMtA@mail.gmail.com>
Message-ID: <CAGXu5jLUXCP1UWpiFRJ=jM8jwrnS1v2By8c4ywRPhAdOPAUMtA@mail.gmail.com>
Subject: Re: siginfo pid not populated from ptrace?
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 1:11 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Tycho Andersen <tycho@tycho.ws> writes:
>
> > On Thu, Dec 06, 2018 at 10:48:39AM -0800, Linus Torvalds wrote:
> >> On Thu, Dec 6, 2018 at 6:40 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >> >
> >> > We have in the past had ptrace users that weren't just about debugging
> >> > so I don't know that it is fair to just dismiss it as debugging
> >> > infrastructure.
> >>
> >> Absolutely.
> >>
> >> Some uses are more than just debug. People occasionally use ptrace
> >> because it's the only way to do what they want, so you'll find people
> >> who do it for sandboxing, for example. It's not necessarily designed
> >> for that, or particularly fast or well-suited for it, but I've
> >> definitely seen it used that way.
> >>
> >> So I don't think the behavioral test breakage like this is necessarily
> >> a huge deal, and until some "real use" actually shows that it cares it
> >> might be something we dismiss as "just test", but it very much has the
> >> potential to hit real uses.
> >>
> >> The fact that a behavioral test broke is definitely interesting.
> >>
> >> And maybe some of the siginfo allocations could depend on whether the
> >> signal is actually ever caught or not.
> >>
> >> For example, a terminal signal (or one that is ignored) might not need
> >> siginfo. But if the process is ptraced, maybe that terminal signal
> >> isn't actually terminal? So we might have situations where we want to
> >> simply check "is the signal target being ptraced"..
> >
> > Yes, something like this, I suppose? It works for me.
>
> The challenge is that we could be delivering this to a zombie signal
> group leader.  At which point we won't deliver it to the target task.
>
> Sigh it is probably time that I dig in and figure out how to avoid that
> case which we need to fix anyway because we can get the permission
> checks wrong for multi-threaded processes that call setuid and friends.
>
> Once that is sorted your small change will at least be safe.
>
> Eric
>
> > From 3bcaadd56ebb532ab4d481556fcc0826d65efc43 Mon Sep 17 00:00:00 2001
> > From: Tycho Andersen <tycho@tycho.ws>
> > Date: Thu, 6 Dec 2018 12:15:22 -0700
> > Subject: [PATCH] signal: allocate siginfo when a traced task gets SIGSTOP
> >
> > Tracers can view SIGSTOP:
> >
> > https://lore.kernel.org/lkml/87zhtthkuy.fsf@xmission.com/T/#u
> >
> > so let's allocate a siginfo for SIGSTOP when a task is traced.
> >
> > Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> > ---
> >  kernel/signal.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index 9a32bc2088c9..ab4ba00119f4 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -1056,11 +1056,14 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
> >               goto ret;
> >
> >       result = TRACE_SIGNAL_DELIVERED;
> > +
> >       /*
> > -      * Skip useless siginfo allocation for SIGKILL SIGSTOP,
> > -      * and kernel threads.
> > +      * Skip useless siginfo allocation for SIGKILL and kernel threads.
> > +      * SIGSTOP is visible to tracers, so only skip allocation when the task
> > +      * is not traced.
> >        */
> > -     if (sig_kernel_only(sig) || (t->flags & PF_KTHREAD))
> > +     if ((sig == SIGKILL) || (!task_is_traced(t) && sig == SIGSTOP) ||
> > +         (t->flags & PF_KTHREAD))
> >               goto out_set;
> >
> >       /*

What should we do for v4.20? I need to have the selftests actually passing. :)

-- 
Kees Cook
