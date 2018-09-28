Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33F3C004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8792F206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 21:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U1c8a2if"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8792F206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbeI2EUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:20:32 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45903 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbeI2EUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:20:31 -0400
Received: by mail-ot1-f66.google.com with SMTP id b43-v6so3021517otd.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 14:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iWNYkMpphDJ+ndlDpjBFdzoXG3ztgAAIwahjiBoQgK8=;
        b=U1c8a2ifd0MJ8xwM/7igFOZ7ZdbgmB0IkD22MecjWeTKzyam4jK8d14xfPtYor7Dfn
         YYbbsaxcKquqf3wUQPW2u1e0EQZSq7mkE0clojsniJhnaEnoiWedq81sAlQ0+EG3gS7q
         vwGRSPv/S9PFlvLuUgvpGGavJlCKO/7PlVMDr4TaPkbHDTBuISnvvfgNTQRjdQ9c5ONs
         zzMIOJ0lLm6CBqpft4wK+U1EOHxPP1Ji25iPWDkUUwZP183hzD7VnG5bokSd86+MBRZS
         josL7XQ0kZSt6IDu/MBkCyAIiaJYB8D+nLbwZkI38QajIuXgI3h4T/COHofO+PBRUX1U
         wFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iWNYkMpphDJ+ndlDpjBFdzoXG3ztgAAIwahjiBoQgK8=;
        b=aQjjhLBvjZ2Ol9pU57/pYupxpHGA8OUT4GBI6/hZzwgG58/el+aPSVjCYM3sje6LRS
         48+Q4Hn8y9L0CLEfxbp18XbsWJ4F4+o/ciKP8bLUOR8ojLbVqK50l2jxpaNpZ18ZqHSx
         i/4ISnwQqPZVEsBvmpzx+IOTFWpr5C2GbzGyzq8osg/5qxpWSLpmC433ga1G7FbeJa0T
         hgGoLST8fjUzpKloEPJ7lLNw3uRU6w3nrpj1uK8O+vp5RA02jrgM6Df62Ya/XM25RdIS
         7QT2elVfzqQ5hJokbvK/vgmDr/1DGksDVqj9dLS8BXiB9hDnUSzgZyA99OzgVv8LVwic
         J0Eg==
X-Gm-Message-State: ABuFfoiUM8fIbA1jBtZM32aCbLYotdGe14eyAxueN+YjCv0B6HNcZVvk
        hb8NCioS0d/HkiTHcMLyjW4l0upq1cgKWwn/yi3vcg==
X-Google-Smtp-Source: ACcGV60Ap8iYmoltzz7AdyUrgReDWgETYOEnYVVi8mke5g5bMNv49QqnoGHofFNwLi3/ePSZyCuA6tKzAHNL3ULKpQc=
X-Received: by 2002:a9d:5011:: with SMTP id a17-v6mr388828oth.198.1538171689021;
 Fri, 28 Sep 2018 14:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180928154648.6320-1-tycho@tycho.ws> <20180928154648.6320-3-tycho@tycho.ws>
 <CAG48ez2h51s1VG8hf1ASHHq88r5b+6rS4nSkgvre77jgsJLbhg@mail.gmail.com>
 <20180928205652.GC18045@cisco.lan> <CAG48ez1CpPmk6BFOztA-=w1U-pvaNBXou6JpcfMKx_ELGSwDVA@mail.gmail.com>
 <20180928213557.GD18045@cisco.lan>
In-Reply-To: <20180928213557.GD18045@cisco.lan>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 28 Sep 2018 23:54:22 +0200
Message-ID: <CAG48ez18dg1dZ-jDQjDQ6zmo7R54SHJYYAZpunFLojOChwZ=9g@mail.gmail.com>
Subject: Re: [PATCH 3/3] seccomp: introduce read protection for struct seccomp
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 11:36 PM Tycho Andersen <tycho@tycho.ws> wrote:
> On Fri, Sep 28, 2018 at 11:10:48PM +0200, Jann Horn wrote:
> > On Fri, Sep 28, 2018 at 10:56 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > >
> > > On Fri, Sep 28, 2018 at 10:33:34PM +0200, Jann Horn wrote:
> > > > On Fri, Sep 28, 2018 at 5:47 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > > > > As Jann pointed out, there is a race between SECCOMP_FILTER_FLAG_TSYNC and
> > > > > the ptrace code that can inspect a filter of another process. Let's
> > > > > introduce read locking into the two ptrace accesses so that we don't race.
> > > >
> > > > Hmm. Is that true? The ptrace code uses get_nth_filter(), which holds
> > > > the siglock while grabbing the seccomp filter and bumping its
> > > > refcount. And TSYNC happens from seccomp_set_mode_filter(), which
> > > > takes the siglock. So this looks okay to me?
> > >
> > > Oh, yes, you're right. So I guess we should just change the comment to
> > > say we're using siglock to represent the read lock.
> >
> > Hmm... actually, looking at this closer, I think you only need the
> > siglock for writing. As far as I can tell, any read (no matter if
> > current or non-current) can just use READ_ONCE(), because once a
> > seccomp filter is in a task's seccomp filter chain, it can't be freed
> > until the task reaches free_task() and calls put_seccomp_filter() from
> > there. And if the task whose seccomp filter you're trying to read can
> > reach free_task(), you have bigger problems.
>
> Ok; looks like get_nth_filter() took the siglock anyway. Since we get
> the filters in these two functions in get_nth_filter(), I think it's
> enough just to just,
>
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index f65d47650ac1..79d833ed4c34 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1001,7 +1001,7 @@ static struct seccomp_filter *get_nth_filter(struct task_struct *task,
>                 return ERR_PTR(-EINVAL);
>         }
>
> -       orig = task->seccomp.filter;
> +       orig = READ_ONCE(task->seccomp.filter);
>         __get_seccomp_filter(orig);
>         spin_unlock_irq(&task->sighand->siglock);

Huh? Now you're holding the siglock *and* you're using READ_ONCE()?
I'm not sure what you're trying to accomplish here.

> since once it's returned from get_nth_filter() we don't need to worry
> about multiple accesses?
>
> Tycho
