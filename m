Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35EDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF03214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 18:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="bQs8HRss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF03214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeJKBuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 21:50:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39970 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbeJKBt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 21:49:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id z204-v6so6800188wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 11:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v+qJ2nhpq0jpyLRsflMa0SxSL8J3mcPs38ogmv/TZnw=;
        b=bQs8HRssRdZ5L7O3609J9m+1ERciHxnFrH5EPpZ67mKwSVyUaWdE8SiAfC+qdbPui8
         n4damocFPWwpwtC84ikjCyBU/JsvBUbtJNKJbvObk1LGcD86j+5pAB+f0MQ/4/fBl2Eq
         O9EtsoMWddC8jJMs6L9SfZYLg88YYl6+h0ezmrxE9dPnriKISuoM4naTdNUZjWyXYujv
         vj/fZVpUpzjoJ9htroJfTbjOjSr+0gshJ22n/84upTwv52B2gK6BdgGer4r16aJ6oDxn
         SvlqEjIZu1UTpWPiyuVVvcCu42dNm4mwK8AtJDiIZTGBbuaH1oZXIe+spv8yXuyytPRS
         Qe6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v+qJ2nhpq0jpyLRsflMa0SxSL8J3mcPs38ogmv/TZnw=;
        b=JQh6axj6QkMhqIQLwHjWXzhjoxeYanDJaZVyq7NcMYW2k7s7SLXNJQPUonFVg2jOIN
         +oLyhwNeE6md91Kg8nvIWZAE9Hz+1MNCffi4hVxW6p0orhcvD4RYX4+WcS/z4OUBl0FG
         VvUPKzhySCeCiHaTkSE1PM0M9RXYTNG2gmJizWjGZj+5vv+vq4pNt4C5yZOsRXpxi7aK
         XbX6A0RziaX5TaSQOkE2QBW4yn+e6y+Pb8sjVzfkeVHAA5hx+Rnj9aNmEJ1BvfNutVaM
         tTZTankCmdV3WMLYnwI3LofINZYY7R+DusWe9sIEaUniyYpGZ24dSocYjUp3UH4IWSA/
         QPTg==
X-Gm-Message-State: ABuFfojGuLZ6QVzkH1yZ/5dzS/O14n/hAWRsx0nZUbuanreiQnilBCGt
        u8zaXEE9RZv/gcE0risyizDuCA==
X-Google-Smtp-Source: ACcGV61V7imQQoKkU/IEB8+DLjKmTY2YavFFvHtmBv62FxXtkT70bzH+tgG5n1IWaDlT1J0B4MiWiw==
X-Received: by 2002:a1c:930c:: with SMTP id v12-v6mr1932741wmd.9.1539195996992;
        Wed, 10 Oct 2018 11:26:36 -0700 (PDT)
Received: from brauner.io ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id j128-v6sm15730600wmb.43.2018.10.10.11.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 11:26:36 -0700 (PDT)
Date:   Wed, 10 Oct 2018 20:26:30 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Oleg Nesterov <oleg@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v7 3/6] seccomp: add a way to get a listener fd from
 ptrace
Message-ID: <20181010182628.hgprnywup4wgmycg@brauner.io>
References: <20180927151119.9989-1-tycho@tycho.ws>
 <20180927151119.9989-4-tycho@tycho.ws>
 <20181008151629.hkgzzsluevwtuclw@brauner.io>
 <20181008180043.GE28238@cisco.lan>
 <CALCETrVtkvG1NihqMF4qMhhtcXFuLbwS2DW=C5F=Lp5riMa9dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrVtkvG1NihqMF4qMhhtcXFuLbwS2DW=C5F=Lp5riMa9dg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 10:45:29AM -0700, Andy Lutomirski wrote:
> On Mon, Oct 8, 2018 at 11:00 AM Tycho Andersen <tycho@tycho.ws> wrote:
> >
> > On Mon, Oct 08, 2018 at 05:16:30PM +0200, Christian Brauner wrote:
> > > On Thu, Sep 27, 2018 at 09:11:16AM -0600, Tycho Andersen wrote:
> > > > As an alternative to SECCOMP_FILTER_FLAG_GET_LISTENER, perhaps a ptrace()
> > > > version which can acquire filters is useful. There are at least two reasons
> > > > this is preferable, even though it uses ptrace:
> > > >
> > > > 1. You can control tasks that aren't cooperating with you
> > > > 2. You can control tasks whose filters block sendmsg() and socket(); if the
> > > >    task installs a filter which blocks these calls, there's no way with
> > > >    SECCOMP_FILTER_FLAG_GET_LISTENER to get the fd out to the privileged task.
> > >
> > > So for the slow of mind aka me:
> > > I'm not sure I completely understand this problem. Can you outline how
> > > sendmsg() and socket() are involved in this?
> > >
> > > I'm also not sure that this holds (but I might misunderstand the
> > > problem) afaict, you could do try to get the fd out via CLONE_FILES and
> > > other means so something like:
> > >
> > > // let's pretend the libc wrapper for clone actually has sane semantics
> > > pid = clone(CLONE_FILES);
> > > if (pid == 0) {
> > >         fd = seccomp(SECCOMP_SET_MODE_FILTER, SECCOMP_FILTER_FLAG_NEW_LISTENER, &prog);
> > >
> > >         // Now this fd will be valid in both parent and child.
> > >         // If you haven't blocked it you can inform the parent what
> > >         // the fd number is via pipe2(). If you have blocked it you can
> > >         // use dup2() and dup to a known fd number.
> > > }
> >
> > But what if your seccomp filter wants to block both pipe2() and
> > dup2()? Whatever syscall you want to use to do this could be blocked
> > by some seccomp policy, which means you might not be able to use this
> > feature in some cases.
> 
> You don't need a syscall at all. You can use shared memory.

Yeah, I pointed that out too in the next mail. :)

> 
> >
> > Perhaps it's unlikely, and we can just go forward knowing this. But it
> > seems like it is worth at least acknowledging that you can wedge
> > yourself into a corner.
> >
> 
> I think that what we *really* want is a way to create a seccomp fitter

I thought about this exact thing when discussing my reservations about
ptrace() but I didn't want to defer this patchset any longer. But I
really like this idea of being able to get an fd *before* the filter is
loaded.

> and activate it later (on execve or via another call to seccomp(),
> perhaps).  And we already sort of have that using ptrace() but a
> better interface would be nice when a real use case gets figured out.
