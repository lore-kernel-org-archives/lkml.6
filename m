Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4263AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CE32086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="SnWZZLMn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02CE32086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbeKTFEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:04:32 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37213 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbeKTFEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:04:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id 80so14206218pge.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 10:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HKIWS2FQiKNrZ3s55kmI7ISTRafazkCOx7CAN32DNq0=;
        b=SnWZZLMnSkw2PT4vVbfnrHOsuOdERX6WcUXgM4quQKWuVdHN6m0ERuVDkb80g7Pp8/
         PN1p8N8eVmYOhwW+kV1Q5hIMMEBlisY7CR3Px6N7YrZL0Z03djLSI0086sFZuoGYzeQw
         UFOYPdhzrWg4pdoId3JmzcsTa49roAEaZ6o3T6CRxYRwRXSf2bUjiRaTWIzERZhDuury
         CxzGN3PF1E6P9tsobRYiOEMjZnBQ9S5EEKzLP6oYMAoEgK57dQWVbZcaObx5iOPqcxvJ
         hWvlaV1tFalkSE/2DWGno3xnYkMKno26yZmG4CM6JmkcG4yif3dySmuJJgNpGbhW2gNF
         HDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HKIWS2FQiKNrZ3s55kmI7ISTRafazkCOx7CAN32DNq0=;
        b=KcG95BEqo1cYpfyCGlR7pmrhHdT4Jo4JdvL/IcaJeYAHrrb7heMOYVseRvD+TuQTgf
         YAFL9ByZQELc7hhhTIht6DZzqarFIyfDXcGjbFEOOknQKztlwR1nMt+/YMqwLiE5GBh6
         px4ptGICoC1uQ2Z52bSMl4bA4g8eQrHRnh8Bc9LRBr/tE1bnUKWYZqmci8zS8KaZ5PsN
         +Uj0p8248Gp6EqZUTb4b5rfSUav7FLPm6nQabkJR2U2dYUT3AYyPLT/R9XQt0l0TlGOl
         ML3mBKijted5efKxDRhibrBoN2PYshuAT6695J8pYHb1863l7LfRKIKlHHHi5RHP2DOC
         cGbw==
X-Gm-Message-State: AGRZ1gK1+AMcAbtj04Y8BrfSsC8bMfjLI+eELghH9x6BrJqHb78UVOjK
        2ue7AGwQ0Mh0yC/LZol7Z7Mk0g==
X-Google-Smtp-Source: AJdET5e9n6N0yO91hV0kxq1JP1JVUiwcQGvFXw8HJ+5f/33yJzItX7Kl1HvSCby4SzieTzUrKf9RgQ==
X-Received: by 2002:a63:4246:: with SMTP id p67mr20902626pga.335.1542652785254;
        Mon, 19 Nov 2018 10:39:45 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:9d11:de0b:446c:8485])
        by smtp.gmail.com with ESMTPSA id m3sm66133111pgl.69.2018.11.19.10.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 10:39:44 -0800 (PST)
Date:   Mon, 19 Nov 2018 19:39:36 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
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
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
Message-ID: <20181119183931.tkz7hfruw2ekqh62@brauner.io>
References: <20181119103241.5229-1-christian@brauner.io>
 <20181119103241.5229-3-christian@brauner.io>
 <CALCETrUY=Hk6=BjgPuDBgj5J1T_b5Q5u1uVOWHjGWXwmHoZBEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrUY=Hk6=BjgPuDBgj5J1T_b5Q5u1uVOWHjGWXwmHoZBEQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 07:45:04AM -0800, Andy Lutomirski wrote:
> On Mon, Nov 19, 2018 at 2:33 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > The kill() syscall operates on process identifiers. After a process has
> > exited its pid can be reused by another process. If a caller sends a signal
> > to a reused pid it will end up signaling the wrong process. This issue has
> > often surfaced and there has been a push [1] to address this problem.
> >
> > A prior patch has introduced the ability to get a file descriptor
> > referencing struct pid by opening /proc/<pid>. This guarantees a stable
> > handle on a process which can be used to send signals to the referenced
> > process. Discussion has shown that a dedicated syscall is preferable over
> > ioctl()s. Thus, the  new syscall procfd_signal() is introduced to solve
> > this problem. It operates on a process file descriptor.
> > The syscall takes an additional siginfo_t and flags argument. If siginfo_t
> > is NULL then procfd_signal() behaves like kill() if it is not NULL it
> > behaves like rt_sigqueueinfo.
> > The flags argument is added to allow for future extensions of this syscall.
> > It currently needs to be passed as 0.
> 
> A few questions.  First: you've made this work on /proc/PID, but
> should it also work on /proc/PID/task/TID to send signals to a
> specific thread?

Yeah, so I thought about that. Your point being to combine: kill(),
tgkill() aka rt_sigqueueinfo() and rt_tg_sigqueueinfo(). If I understand
this correctly the implication is to also get file descriptors to
/proc/PID/task/TID and pass them to procfd_signal()? Can we hold of on
that one? Adding this in the future should be easily doable by simply
getting /proc/PID/task/TID file descriptors but I would like this
patchset to be as small as possible.

> 
> > +bool proc_is_procfd(const struct file *file)
> > +{
> > +       return d_is_dir(file->f_path.dentry) &&
> > +              (file->f_op == &proc_tgid_base_operations);
> > +}
> 
> Maybe rename to proc_is_tgid_procfd() to leave room for proc_is_tid_procfd()?

Yes, good idea!

> 
> > +       if (info) {
> > +               ret = __copy_siginfo_from_user(sig, &kinfo, info);
> > +               if (unlikely(ret))
> > +                       goto err;
> > +               /*
> > +                * Not even root can pretend to send signals from the kernel.
> > +                * Nor can they impersonate a kill()/tgkill(), which adds
> > +                * source info.
> > +                */
> > +               ret = -EPERM;
> > +               if ((kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL) &&
> > +                   (task_pid(current) != pid))
> > +                       goto err;
> 
> Is the exception for signaling yourself actually useful here?

I tried to strictly follow the sigqueue-based permission checks. I'm not
comfortable removing this check without signal-experts telling me that
it is safe to do.
