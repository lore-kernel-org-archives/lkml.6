Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C59C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09E7621104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 19:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="ev3VZ0EC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09E7621104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbeK3HCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 02:02:40 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37331 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbeK3HCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 02:02:40 -0500
Received: by mail-pg1-f193.google.com with SMTP id 80so1405617pge.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 11:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4u+eXPirFSPxV6BVFR6iP8Az4P5GKmcgBaEN6qe6ul8=;
        b=ev3VZ0ECjf834FMaTN0LeDMFnpV2PFe/hK1iZ0YbeVSAaR2Kt0FGLCEDYFNZ/LEQrz
         HzJtCdPPgYfV9vGCCLjuz+5Y/EXIJMHM6x6EFj/caqqcUIOx0djmvlZIsi8lMP37OO1g
         /uJXJgmbnRXWZd6qg31yA1qblFXZGAShbExBeRRO7N8MUCXFIKf02extI6nZM+CxgaTb
         h+ZFnVP4f5tg15a5g7oH8o3kdKXbZKrndRSPKYTlPSYskEfayegwsquCkSW10euvsQuI
         uqz6jBc+wxl2/68wCO8Lc2vRORRwnbvLNLzWw++EbhFWbg8xxcnNknWE+wFnjS00/pHC
         locA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4u+eXPirFSPxV6BVFR6iP8Az4P5GKmcgBaEN6qe6ul8=;
        b=okn8oEEwhBoXwRkLxipuXh/SivbzHG68RLCtqFZQTtWBadyr4vZeTAVFRir6Ez4Ruq
         FwbzRxlUxVTXkIu8/c4WgomFuZpRJinOdzOsmqoNoPTjYsxx56rNZp1zklvG9yIN5B50
         /vAYm5QgQu7iEJNnSRrf2dt/cTB+J07ZKqeQwVVt0D6IKI5H03P2HPWgixqi5EYdHo8v
         tx23LksQccYX7pMQLGPE8p4tJ/HKrgqRr8QFel73XvUxSnefNo9Hq5pgDiT4NOD4GKSm
         dlSfZ8YLwoEUIrZOyHVQNtVUahRoBpfXVJoUGt5ZS6ikNlRuXEoDhcKOpw1La8/EnMfX
         FMwQ==
X-Gm-Message-State: AA+aEWYYyz8h1lRHNm4TUzxDtyVz0WMcSNBdDZAeIjdR8rHgfMqMJ7ba
        luGv0lwJMAW6NhzfUBhESatcSQ==
X-Google-Smtp-Source: AFSGD/UhcthDwuO17WXSov/O5TBwiWgRm5gJ2MnW3MhQiSBzKFXLpkyhiG+FB1ZsBVWjNbo/+l147A==
X-Received: by 2002:a63:4706:: with SMTP id u6mr2238154pga.95.1543521365404;
        Thu, 29 Nov 2018 11:56:05 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:ad2e:14cc:5849:819])
        by smtp.gmail.com with ESMTPSA id v12sm4436338pgg.41.2018.11.29.11.55.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 11:56:04 -0800 (PST)
Date:   Thu, 29 Nov 2018 20:55:55 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
Message-ID: <20181129195551.woe2bl3z3yaysqb6@brauner.io>
References: <20181120105124.14733-1-christian@brauner.io>
 <87in0g5aqo.fsf@oldenburg.str.redhat.com>
 <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net>
 <993B98AC-51DF-4131-AF7F-7DA2A7F485F1@brauner.io>
 <CALCETrWnQNMQcCmFZrftVVYgAMW6DT3gyxvVb_v9_enUCUkHiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrWnQNMQcCmFZrftVVYgAMW6DT3gyxvVb_v9_enUCUkHiw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 11:22:58AM -0800, Andy Lutomirski wrote:
> On Thu, Nov 29, 2018 at 11:17 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > On November 30, 2018 5:54:18 AM GMT+13:00, Andy Lutomirski <luto@amacapital.net> wrote:
> > >
> > >
> > >> On Nov 29, 2018, at 4:28 AM, Florian Weimer <fweimer@redhat.com>
> > >wrote:
> > >>
> > >> Disclaimer: I'm looking at this patch because Christian requested it.
> > >> I'm not a kernel developer.
> > >>
> > >> * Christian Brauner:
> > >>
> > >>> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl
> > >b/arch/x86/entry/syscalls/syscall_32.tbl
> > >>> index 3cf7b533b3d1..3f27ffd8ae87 100644
> > >>> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> > >>> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> > >>> @@ -398,3 +398,4 @@
> > >>> 384    i386    arch_prctl        sys_arch_prctl
> > >__ia32_compat_sys_arch_prctl
> > >>> 385    i386    io_pgetevents        sys_io_pgetevents
> > >__ia32_compat_sys_io_pgetevents
> > >>> 386    i386    rseq            sys_rseq            __ia32_sys_rseq
> > >>> +387    i386    procfd_signal        sys_procfd_signal
> > >__ia32_compat_sys_procfd_signal
> > >>> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl
> > >b/arch/x86/entry/syscalls/syscall_64.tbl
> > >>> index f0b1709a5ffb..8a30cde82450 100644
> > >>> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> > >>> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> > >>> @@ -343,6 +343,7 @@
> > >>> 332    common    statx            __x64_sys_statx
> > >>> 333    common    io_pgetevents        __x64_sys_io_pgetevents
> > >>> 334    common    rseq            __x64_sys_rseq
> > >>> +335    64    procfd_signal        __x64_sys_procfd_signal
> > >>>
> > >>> #
> > >>> # x32-specific system call numbers start at 512 to avoid cache
> > >impact
> > >>> @@ -386,3 +387,4 @@
> > >>> 545    x32    execveat        __x32_compat_sys_execveat/ptregs
> > >>> 546    x32    preadv2            __x32_compat_sys_preadv64v2
> > >>> 547    x32    pwritev2        __x32_compat_sys_pwritev64v2
> > >>> +548    x32    procfd_signal        __x32_compat_sys_procfd_signal
> > >>
> > >> Is there a reason why these numbers have to be different?
> > >>
> > >> (See the recent discussion with Andy Lutomirski.)
> > >
> > >Hah, I missed this part of the patch.  Let’s not add new x32 syscall
> > >numbers.
> > >
> > >Also, can we perhaps rework this a bit to get rid of the compat entry
> > >point?  The easier way would be to check in_compat_syscall(). The nicer
> > >way IMO would be to use the 64-bit structure for 32-bit as well.
> >
> > Do you have a syscall which set precedence/did this before I could look at?
> > Just if you happen to remember one.
> > Fwiw, I followed the other signal syscalls.
> > They all introduce compat syscalls.
> >
> 
> Not really.
> 
> Let me try to explain.  I have three issues with the approach in your patchset:
> 
> 1. You're introducing a new syscall, and it behaves differently on
> 32-bit and 64-bit because the structure you pass in is different.
> This is necessary for old syscalls where compatibility matters, but
> maybe we can get rid of it for new syscalls.   Could we define a
> siginfo64_t that is identical to the 64-bit siginfo_t and just use
> that in all cases?
> 
> 2. Assuming that #1 doesn't work, then we need compat support.  But
> you're doing it by having two different entry points.  Instead, you
> could have a single entry point that calls in_compat_syscall() to
> decide which structure to read.  This would simplify things because
> x86 doesn't really support the separate compat entry points, which
> leads me to #3.
> 
> 3. The separate x32 numbers are a huge turd that may have security
> holes and certainly have comprehensibility holes.  I will object to
> any patch that adds a new one (like yours).  Fixing #1 or #2 makes
> this problem go away.
> 
> Does that make any sense?  The #2 fix would be something like:
> 
> if (in_compat_syscall)
>   copy...user32();
> else
>   copy_from_user();
> 
> The #1 fix would add a copy_siginfo_from_user64() or similar.

Thanks very much! That all helped a bunch already! I'll try to go the
copy_siginfo_from_user64() way first and see if I can make this work. If
we do this I would however only want to use it for the new syscall first
and not change all other signal syscalls over to it too. I'd rather keep
this patchset focussed and small and do such conversions caused by the
new approach later. Does that sound reasonable?
