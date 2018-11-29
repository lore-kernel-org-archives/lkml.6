Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB729C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7125420989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7125420989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeK3Ir7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:47:59 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35924 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbeK3Ir6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:47:58 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so3774395qtn.3;
        Thu, 29 Nov 2018 13:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z0Wt85+5fhcDQJaWSJhZaQaaqLPbm2iQ+s2zFOdMVZc=;
        b=bnzFXnnG6Wf4ia6fj/pe/HLQla+RkvsUKNEZ88toHx8DsIuj+iGRULDlgC56V77ZLz
         ckys7U7aJXG6jas4+Po6rwFxu3QUIM64tciXsnWWaYsnWzFwXo4dnjF5er7yL77XpsIi
         9EWyCQZvnM4PNpjRcrSgZ0s38SFL5sYafPAJYCNvD+yLunE24YM52f8a1po1ZKlHbYPk
         gV6yPvypH7H3q4WhgrUAhB4EGfIbSUc9VJwYWnsblfG0+kuyQPhWRD14pDiwJO4R0DP6
         XEyIWqErjdV3u6YZBENlLraaU0sy+f3eaImx54JADHkF/wmbzgjpBkBOvy0oL4L7vb4D
         fq6w==
X-Gm-Message-State: AA+aEWa+zJOvKnkQYC9ivd809JtJkTtf2aquKD/rdoB8tVdW0Es+v+CN
        U2yTctONZ4QBaGfoAznzmLiAxKzXX/Izdsn0llE=
X-Google-Smtp-Source: AFSGD/WlDNAH/4mFXsjcZUUW9IRklh/NqLUqZvDXit7kY/gVGA00IzTBG3Nq4CLc0k0OKKZ8h/TgmVJKDUObT+J6W18=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr3079413qtl.343.1543527667923;
 Thu, 29 Nov 2018 13:41:07 -0800 (PST)
MIME-Version: 1.0
References: <20181120105124.14733-1-christian@brauner.io> <87in0g5aqo.fsf@oldenburg.str.redhat.com>
 <36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net> <993B98AC-51DF-4131-AF7F-7DA2A7F485F1@brauner.io>
 <CALCETrWnQNMQcCmFZrftVVYgAMW6DT3gyxvVb_v9_enUCUkHiw@mail.gmail.com>
 <20181129195551.woe2bl3z3yaysqb6@brauner.io> <6E21165F-2C76-4877-ABD9-0C86D55FD6AA@amacapital.net>
 <CAK8P3a2i9DFaS9-3A9V_pKwFfwVR0bDqgLosmivge3Cx2VyiuQ@mail.gmail.com> <20181129213458.4h44dpg6ltqow4k4@brauner.io>
In-Reply-To: <20181129213458.4h44dpg6ltqow4k4@brauner.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 29 Nov 2018 22:40:49 +0100
Message-ID: <CAK8P3a1_if7+Ak2eefU6JeZT9KW827gkLHaObX-QOsHrB5ZwfA@mail.gmail.com>
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
To:     christian@brauner.io
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, cyphar@cyphar.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>, linux-man@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:35 PM Christian Brauner <christian@brauner.io> wrote:
> On Thu, Nov 29, 2018 at 10:02:13PM +0100, Arnd Bergmann wrote:
> > On Thu, Nov 29, 2018 at 9:14 PM Andy Lutomirski <luto@amacapital.net> wrote:
> >
> > Is the current procfd_signal() proposal (under whichever name) sufficient
> > to correctly implement both sys_rt_sigqueueinfo() and sys_rt_tgsigqueueinfo()?
>
> Yes, I see no reason why not. My idea is to extend it - after we have a
> basic version in - to also work with:
> /proc/<pid>/task/<tid>
> If I'm not mistaken this should be sufficient to get rt_tgsigqueueinfo.
> The thread will be uniquely identified by the tid descriptor and no
> combination of /proc/<pid> and /proc/<pid>/task/<tid> is needed. Does
> that sound reasonable?

Yes. So it would currently replace rt_gsigqueueinfo() but
not rt_tgsigqueueinfo(), and could be extended to do both
afterwards, without making the interface ugly in any form?

I suppose we can always add more flags if needed, and you
already ensure that flags is zero for the moment.

> > Can we implement sys_rt_sigtimedwait() based on signalfd()?
> >
> > If yes, that would leave waitid(), which already needs a replacement
> > for y2038, and that should then also return a signalfd_siginfo.
> > My current preference for waitid() would be to do a version that
> > closely resembles the current interface, but takes a signalfd_siginfo
> > and a __kernel_timespec based rusage replacement (possibly
> > two of them to let us map wait6), but does not operate on procfd or
> > take a signal mask. That would require yet another syscall, but I
> > don't think I can do that before we want to have the set of y2038
> > safe syscalls.
>
> All sounds reasonable to me but that's not a blocker for the current
> syscall though, is it?

I'd like to at least understand about sys_rt_sigtimedwait() before
we go on, so we all know what's coming, and document the
plans in the changelog.

waitid() probably remains on my plate anyway, and I hope understand
where we're at with it.

     Arnd
