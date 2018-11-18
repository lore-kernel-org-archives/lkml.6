Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81687C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2840A2080C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 20:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="dZGLagY/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2840A2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbeKSGgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 01:36:41 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38987 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbeKSGgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 01:36:40 -0500
Received: by mail-pg1-f194.google.com with SMTP id w6so584028pgl.6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 12:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=09TMh7ltv9Knkf6XQBcc1ye3e4wBO5cn7QHqPt6W2Ww=;
        b=dZGLagY/1faClkZX1qWovtSTj82b60UaWO8IUfEdXk3o8fIRNjtU/mrcrl/Ah1XI1Y
         rR7zkzg3JPNmMk9UPRsnueqQUM7cj+iS0TsGx6Z71AlzG2mhpGRYo5noYA1wx+ENnL2f
         73gNqyUXSPn/IQ2MWsOTJfty8YcDaGxZ/dLAOf1dAhEzLl2iwb+KyolxguG5VTiEevQH
         B8olS+MqvTDoL2HTYkUj8snDpJLjngIIU0h+XezC+1alRTr25NidkJ3mt9ZyQiCPDQIt
         UPQppMBy7Si3KXod8veEXnVdvSt8eAy7TJ68cXnJKcXO7M2mg5CdaKczP9oD5KtqHtZT
         81wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=09TMh7ltv9Knkf6XQBcc1ye3e4wBO5cn7QHqPt6W2Ww=;
        b=ZEdd1oQPxPnp2iZK7gyre3bRmkeK+tWSj/sM+f2EagdjDnWkzvXC6ABnOfBeJ4xzES
         QkwY+uyu3v02StRCGuiRzCcozwJpyxHKCAS+/qw7mOmlWLIVJ/1JQqAWVEcdszTuCPN5
         Vmm7K/vTDWgG42JUJNbdGbr5sM0RZJehxnpLKgVUExTD0yxZMFLvA3oUptJyUjJqJQcU
         i9BXgu8C5Zf7th1ycuOdELf4j0bEFzngC1Ljt4Q+Wt0hXYX2JB6TYvi+mHYMlo2oGzBM
         Pd+h56eTb8h5mSmkB9ZTYvdxml3z6kUA9H7+/8qsWcXNoMu81rxUJsOKqHo3M2mjSLjP
         BQzA==
X-Gm-Message-State: AGRZ1gJ/uPQxt1uOd5K5TtHTFMTqeZ3ZjDwhTNIDTWEYyyoQl1EzoCPg
        RVgyMvepF0SI5aefEEtjQgOS0A==
X-Google-Smtp-Source: AJdET5d1cZ/VSiowGeKCkvJycfJ2jOeeL7u52R1XsloX5poCpMOZBxmHdN8+/bi0/XabQwN7n6qa3A==
X-Received: by 2002:a63:7c13:: with SMTP id x19mr17395594pgc.45.1542572125921;
        Sun, 18 Nov 2018 12:15:25 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:9d11:de0b:446c:8485])
        by smtp.gmail.com with ESMTPSA id q199sm26626979pfc.97.2018.11.18.12.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Nov 2018 12:15:25 -0800 (PST)
Date:   Sun, 18 Nov 2018 21:15:16 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Daniel Colascione <dancol@google.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jan Engelhardt <jengelh@inai.de>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
Message-ID: <20181118201514.c5ujdjav6ccodyff@brauner.io>
References: <a7f50692-667c-4efe-a2d0-fa324eebb90b@infradead.org>
 <CAKOZueutLc8d0Fe+7dNWiZKnALhTSST8+kCnOrL+OmB6coUmtA@mail.gmail.com>
 <CALCETrVg71XBv-gMOtL-m0Dd0HNz8_oXOUDSWin5LeViAL0UYA@mail.gmail.com>
 <CAKOZuesCKo4GH9fdum2EUFLrtTWam3aizcDQUn3-vCYg4T1P8w@mail.gmail.com>
 <CALCETrUeNZPfrSYa9vH5Ukrk1Y+Kb9GkZOh6LkqG6Z9NpK5P0w@mail.gmail.com>
 <CAKOZuevVk_aH_2TuiNcmxgMa+gHXMBXz6Uu5a6TDjoxjhaE36g@mail.gmail.com>
 <CALCETrVscRwQG55-j1SKc2TmSb1-=5861804ojUuviNzdyDOrA@mail.gmail.com>
 <CAKOZuevRq-igh06zS_nsGG400zXrKFCtajpEG9-xgU2+Rtb2Pw@mail.gmail.com>
 <20181118190504.ixglsqbn6mxkcdzu@yavin>
 <CAKOZuetfqvn1uVqKJ=16iEzG4g449YOjC_tLM60eKBSkv9u+bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKOZuetfqvn1uVqKJ=16iEzG4g449YOjC_tLM60eKBSkv9u+bQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 11:44:19AM -0800, Daniel Colascione wrote:
> On Sun, Nov 18, 2018 at 11:05 AM, Aleksa Sarai <cyphar@cyphar.com> wrote:
> > On 2018-11-18, Daniel Colascione <dancol@google.com> wrote:
> >> > Here's my point: if we're really going to make a new API to manipulate
> >> > processes by their fd, I think we should have at least a decent idea
> >> > of how that API will get extended in the future.  Right now, we have
> >> > an extremely awkward situation where opening an fd in /proc requires
> >> > certain capabilities or uids, and using those fds often also checks
> >> > current's capabilities, and the target process may have changed its
> >> > own security context, including gaining privilege via SUID, SGID, or
> >> > LSM transition rules in the mean time.  This has been a huge source of
> >> > security bugs.  It would be nice to have a model for future APIs that
> >> > avoids these problems.
> >> >
> >> > And I didn't say in my proposal that a process's identity should
> >> > fundamentally change when it calls execve().  I'm suggesting that
> >> > certain operations that could cause a process to gain privilege or
> >> > otherwise require greater permission to introspect (mainly execve)
> >> > could be handled by invalidating the new process management fds.
> >> > Sure, if init re-execs itself, it's still PID 1, but that doesn't
> >> > necessarily mean that:
> >> >
> >> > fd = process_open_management_fd(1);
> >> > [init reexecs]
> >> > process_do_something(fd);
> >> >
> >> > needs to work.
> >>
> >> PID 1 is a bad example here, because it doesn't get recycled. Other
> >> PIDs do. The snippet you gave *does* need to work, in general, because
> >> if exec invalidates the handle, and you need to reopen by PID to
> >> re-establish your right to do something with the process, that process
> >> may in fact have died between the invalidation and your reopen, and
> >> your reopened FD may refer to some other random process.
> >
> > I imagine the error would be -EPERM rather than -ESRCH in this case,
> > which would be incredibly trivial for userspace to differentiate
> > between.
> 
> Why would userspace necessarily see EPERM? The PID might get recycled
> into a different random process that the caller has the ability to
> affect.
> 
> > If you wish to re-open the path that is also trivial by
> > re-opening through /proc/self/fd/$fd -- which will re-do any permission
> > checks and will guarantee that you are re-opening the same 'struct file'
> > and thus the same 'struct pid'.
> 
> When you reopen via /proc/self/fd, you get a new struct file
> referencing the existing inode, not the same struct file. A new
> reference to the old struct file would just be dup.
> 
> Anyway: what other API requires, for correct operation, occasional
> reopening through /proc/self/fd? It's cumbersome, and it doesn't add
> anything. If we invalidate process handles on execve, and processes
> are legally allowed to re-exec themselves for arbitrary reasons at any
> time, that's tantamount to saying that handles might become invalid at
> any time and that all callers must be prepared to go through the
> reopen-and-retry path before any operation.
> 
> Why are we making them do that? So that a process can have an open FD
> that represents a process-operation capability? Which capability does
> the open FD represent?
> 
> I think when you and Andy must be talking about is an API that looks like this:
> 
> int open_process_operation_handle(int procfs_dirfd, int capability_bitmask)
> 
> capability_bitmask would have bits like
> 
> PROCESS_CAPABILITY_KILL --- send a signal
> PROCESS_CAPABILITY_PTRACE --- attach to a process
> PROCESS_CAPABILITY_READ_EXIT_STATUS --- what it says on the tin
> PROCESS_CAPABILITY_READ_CMDLINE --- etc.
> 
> Then you'd have system calls like
> 
> int process_kill(int process_capability_fd, int signo, const union sigval data)
> int process_ptrace_attach(int process_capability_fd)
> int process_wait_for_exit(int process_capability_fd, siginfo_t* exit_info)
> 
> that worked on these capability bits. If a process execs or does
> something else to change its security capabilities, operations on
> these capability FDs would fail with ESTALE or something and callers
> would have to re-acquire their capabilities.
> 
> This approach works fine. It has some nice theoretical properties, and
> could allow for things like nicer privilege separation for debuggers.
> I wouldn't mind something like this getting into the kernel.
> 
> I just don't think this model is necessary right now. I want a small
> change from what we have today, one likely to actually make it into
> the tree. And bypassing the capability FDs and just allowing callers
> to operate directly on process *identity* FDs, using privileges in
> effect at the time of all, is at least no worse than what we have now.
> 
> That is, I'm proposing an API that looks like this:
> 
> int process_kill(int procfs_dfd, int signo, const union sigval value)

I've started a second tree with process_signal(int procpid_dfd, int sig)
instead of an ioctl(). Why do you want sigval too?

> 
> If, later, process_kill were to *also* accept process-capability FDs,
> nothing would break.
> 
> >> The only way around this problem is to have two separate FDs --- one
> >> to represent process identity, which *must* be continuous across
> >> execve, and the other to represent some specific capability, some
> >> ability to do something to that process. It's reasonable to invalidate
> >> capability after execve, but it's not reasonable to invalidate
> >> identity. In concrete terms, I don't see a big advantage to this
> >> separation, and I think a single identity FD combined with
> >> per-operation capability checks is sufficient. And much simpler.
> >
> > I think that the error separation above would trivially allow user-space
> > to know whether the identity or capability of a process being monitored
> > has changed.
> >
> > Currently, all operations on a '/proc/$pid' which you've previously
> > opened and has died will give you -ESRCH.
> 
> Not the case. Zombies have died, but profs operations work fine on zombies.
> 
> >> > Similarly, it seems like
> >> > it's probably safe to be able to open an fd that lets you watch the
> >> > exit status of a process, have the process call setresuid(), and still
> >> > see the exit status.
> >>
> >> Is it? That's an open question.
> >
> > Well, if we consider wait4(2) it seems that this is already the case.
> > If you fork+exec a setuid binary you can definitely see its exit code.
> 
> Only if you're the parent. Otherwise, you can't see the process exit
> status unless you pass a ptrace access check and consult
> /proc/pid/stat after the process dies, but before the zombie
> disappears. Random unrelated and unprivileged processes can't see exit
> statuses from distant parts of the system.
> 
> >> > My POLLERR hack, aside from being ugly,
> >> > avoids this particular issue because it merely lets you wait for
> >> > something you already could have observed using readdir().
> >>
> >> Yes. I mentioned this same issue-punting as the motivation behind
> >> exithand, initially, just reading EOF on exit.
> >
> > One question I have about EOF-on-exit is that if we wish to extend it to
> > allow providing the exit status (which is something we discussed in the
> > original thread), how will multiple-readers be handled in such a
> > scenario?
> > Would we be storing the exit status or siginfo in the
> > equivalent of a locked memfd?
> 
> Yes, that's what I have in mind. A siginfo_t is small enough that we
> could just store it as a blob allocated off the procfs inode or
> something like that without bothering with a shmfs file. You'd be able
> to read(2) the exit status as many times as you wanted.
