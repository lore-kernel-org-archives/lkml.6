Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38375C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E870B208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 17:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="e40+dWMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E870B208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbeLFRln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:41:43 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:41257 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeLFRln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 12:41:43 -0500
Received: by mail-pg1-f182.google.com with SMTP id 70so453428pgh.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 09:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BwxeeGw0kP925QFeYiY37vZUbZuyAELatGlO8fl+J4Q=;
        b=e40+dWMCASBFW7YhDuzC7tFlgJPQ9IsM0mHEnCl79SXO/uIOhxTwNRP2/dtkNvDoCb
         /YAcF2AKLy4FsjhvKWOLITOFABMzE4kf/B/zHTYNVSoXJsXhNgilMPdfdEEoRZYMn2wq
         vP9SHtRmwzDoqF9dgFdxwqtg760KMyRw8pTMEPG0WPV/PrRx1M0abRJ4NE9xqu8lgOaq
         0fuzY50Blmc29ql7MKjCYqJ6rdR5/eKzwmvniawXwd0cqAuSzoteRKuTl04x6V7a5BGg
         8/PXWJytQEX+h0o7aur37MDbgQ7hQ9IJrWF3O9Ib/VcXV0Mm90JDzv0YDeu3xG/WsTo3
         1eIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BwxeeGw0kP925QFeYiY37vZUbZuyAELatGlO8fl+J4Q=;
        b=hDFQl9Gcgl0yBbWvPQTNPzY4pIM41ZCXep6ONTNns3BJusQzqPiwE3KXV70eI0icKC
         hoU2HizB1lYlz4Rz9YtPfNGmQLK/Ma0wRbeJUQTo9oxyjo7V8NAlkRdAFEmguwGubQY/
         R5Spz7FnIKLFyM3GNHb0U4c4RlRdbDovs2y/I3YAupglYLJpANs7wYFKpDdmggeMNnQ6
         lcvMmw6KftLnISZi8BdYSMq3/eQW9CPz6WAMkyZcDWjIGugZwgIBPva6jHWF/1Xat1rA
         Zh6LfGFD7NuGgm3XwguCgjCQZBrk107EOV7eAKx3Zzc4L14kEmtQQw1O/LENpVYXcQ/r
         KvdA==
X-Gm-Message-State: AA+aEWZw6sz7T6Wvy8v2tiWxiLQVqSMPvD/sBq9FR3Y8yri81yGBfpxl
        qjKpW6Ysbe0+Y5TgWDAD2sxT5Q==
X-Google-Smtp-Source: AFSGD/XvcMzRSGgnMWXX23hHJV2xT2WnIXhmi9Nr6J4R5Tf4/R9uGP+Y/WlNk/Nw8QNGkNGsi5wsRg==
X-Received: by 2002:a62:5444:: with SMTP id i65mr30450136pfb.193.1544118101685;
        Thu, 06 Dec 2018 09:41:41 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:b824:a031:b50e:f401])
        by smtp.gmail.com with ESMTPSA id p7sm1793926pfa.22.2018.12.06.09.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 09:41:40 -0800 (PST)
Date:   Thu, 6 Dec 2018 18:41:31 +0100
From:   Christian Brauner <christian@brauner.io>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>, tglx@linutronix.de,
        x86@kernel.org
Subject: Re: [PATCH v4] signal: add taskfd_send_signal() syscall
Message-ID: <20181206174129.taakmwekysbkaosu@brauner.io>
References: <20181206121858.12215-1-christian@brauner.io>
 <87sgzahf7k.fsf@xmission.com>
 <CAKOZuet4ayDu-54u2tO9tRDCgxa9JQ4avAiYS8xEtReN4MMhAA@mail.gmail.com>
 <878t12efg3.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878t12efg3.fsf@xmission.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 11:24:28AM -0600, Eric W. Biederman wrote:
> Daniel Colascione <dancol@google.com> writes:
> 
> > On Thu, Dec 6, 2018 at 7:02 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
> >>
> >> Christian Brauner <christian@brauner.io> writes:
> >>
> >> > The kill() syscall operates on process identifiers (pid). After a process
> >> > has exited its pid can be reused by another process. If a caller sends a
> >> > signal to a reused pid it will end up signaling the wrong process. This
> >> > issue has often surfaced and there has been a push [1] to address this
> >> > problem.
> >> >
> >> > This patch uses file descriptors (fd) from proc/<pid> as stable handles on
> >> > struct pid. Even if a pid is recycled the handle will not change. The fd
> >> > can be used to send signals to the process it refers to.
> >> > Thus, the new syscall taskfd_send_signal() is introduced to solve this
> >> > problem. Instead of pids it operates on process fds (taskfd).
> >>
> >> I am not yet thrilled with the taskfd naming.
> >
> > Both the old and new names were fine. Do you want to suggest a name at
> > this point? You can't just say "I don't like this. Guess again"
> > forever.
> 
> Both names suck, as neither name actually describes what the function is
> designed to do.
> 
> Most issues happen at the interface between abstractions.  A name that
> confuses your users will just make that confusion more likely.  So it is
> important that we do the very best with the name that we can do.
> 
> We are already having questions about what happens when you perform the
> non-sense operation of sending a signal to a zombie.  It comes up
> because there are races when a process may die and you are not expecting
> it.  That is an issue with the existing signal sending API, that has
> caused confusion.   That isn't half as confusing as the naming issue.
> 
> A task in linux is a single thread.  A process is all of the threads.
> If we are going to support both cases it doesn't make sense to hard code
> a single case in the name.
> 
> I would be inclined to simplify things and call the syscall something
> like "fdkill(int fd, struct siginfo *info, int flags)".  Or perhaps

No, definitely nothing with "kill" will be used because that's
absolutely not expressing what this syscall is doing.

> just "fd_send_signal(int fd, struct siginfo *info, int flags)".
> 
> Then we are not overspecifying what the system call does in the name.

I feel changing the name around by a single persons preferences is not
really a nice thing to do community-wise. So I'd like to hear other
people chime in first before I make that change.

> Plus it makes it clear that the fd specifies where the signal goes.
> Something I see that by your reply below that you were confused about.
> 
> >> Is there any plan to support sesssions and process groups?
> >
> > Such a thing could be added with flags in the future. Why complicate
> > this patch?
> 
> Actually that isn't the way this is designed.  You would have to have
> another kind of file descriptor.  I am asking because it goes to the
> question of naming and what we are trying to do here.
> 
> We don't need to implement that but we have already looked into this
> kind of extensibility.  If we want the extensibility we should make
> room for it, or just close the door.  Having the door half open and a
> confusing interface is a problem for users.
> 
> >> I am concerned about using kill_pid_info.  It does this:
> >>
> >>
> >>         rcu_read_lock();
> >>         p = pid_task(pid, PIDTYPE_PID);
> >>         if (p)
> >>                 error = group_send_sig_info(sig, info, p, PIDTYPE_TGID);
> >>         rcu_read_unlock();
> >>
> >> That pid_task(PIDTYPE_PID) is fine for existing callers that need bug
> >> compatibility.  For new interfaces I would strongly prefer pid_task(PIDTYPE_TGID).
> >
> > What is the bug that PIDTYPE_PID preserves?
> 
> I am not 100% certain all of the bits for this to matter have been
> merged yet but we are close enough that it would not be hard to make it
> matter.
> 
> There are two strange behaviours of ordinary kill on the linux kernel
> that I am aware of.
> 
> 1) kill(thread_id,...) where the thread_id is not the id of the first
>    thread and the thread_id thus the pid of the process sends the signal
>    to the entire process.  Something that arguably should not happen.
> 
> 2) kill(pid,...) where the original thread has exited performs the
>    permission checks against the dead signal group leader.  Which means
>    that the permission checks for sending a signal are very likely wrong
>    for a multi-threaded processes that calls a function like setuid.
> 
> To fix the second case we are going to have to perform the permission
> checks on a non-zombie thread.  That is something that is straight
> forward to make work with PIDTYPE_TGID.  It is not so easy to make work
> with PIDTYPE_PID.
> 
> I looked and it doesn't look like I have merged the logic of having
> PIDTYPE_TGID point to a living thread when the signal group leader
> exits and becomes a zombie.  It isn't hard but it does require some very
> delicate surgery on the code, so that we don't break some of the
> historic confusion of threads and process groups.

Then this seems irrelevant to the current patch. It seems we can simply
switch to PIDTYPE_PGID once your new logic lands but not right now.
