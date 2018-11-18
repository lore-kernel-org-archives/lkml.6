Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B30C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 19:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9998220869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 19:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="SOm4Ow1a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9998220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeKSFqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 00:46:02 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39873 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeKSFqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 00:46:01 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5-v6so13503369pla.6
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 11:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I80PH5bUeNvL93s2ghH98E9Rk1z819E/+ge494yQ1fw=;
        b=SOm4Ow1aPfgl9ftEjYaQqtyRENyfLRKE0T4tk6Se5sQxxjBKFwPrtSrHTZF+lbdPOy
         GPJcQ9IBK+kULRFFUU93MOINZQQuGG2fGU8jQCkf8JfPE6opF9RYmmIAfbg7OvM78vLF
         lyOInkDdm6FzTAFZRJp37TPYPziIpnCKGecpEdvjKengsTUepipSEgW5F5Wi4gRLkZYa
         CKK/uB9YE7rtEhKhvi4pJogUG6FC3cnXUWy9kBwAzWMIOE4KTo7aIaqcm9EU+101rfMU
         VAJ0y3UkGYIDtyyyPIgDOaVvVFvN6UvHIHFOfax2zWBmB9UIXDAJZiyrEUtN1whbAmvy
         i44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I80PH5bUeNvL93s2ghH98E9Rk1z819E/+ge494yQ1fw=;
        b=Ok+fNYC3X0lufkPbPmAfW31KZIU3WQJMChSNokpXG0DcZyb6mC2r8JiLa0Qd/Ao98b
         L+18EUv1BMh6EMwK+QGlWf9TOPiapoC2NIJktmEz9tGXlI2f/EX6i4aI7HvXLyMaQqnm
         /glVMTDc53f4a2r9W4rUTbEczRU20Sn4xs2XgRYAZIr+X1taRLhLrPmyTt/QABBvzpWe
         qqfAhd+T2Ruvw2n1eSzZbZdAxyDHgTmzEmkL/Lh6YENp6gxc9FOnVOftBf1R2gECz49n
         DeZSEx11SBZNG9/d6X62OmU9WZoUgJH71UAoziBGqsQJzG5NEBtOWYS9wKs5W9PhLIoa
         J+Fw==
X-Gm-Message-State: AA+aEWbLeGquu6lr696CDwEWdSNkIC/eqJjOk3I0HFenVstXclLOlNgn
        EhbYgJQb9OaX+ZiJ+Fg0vXKLfQ==
X-Google-Smtp-Source: AFSGD/UkqR1LJfL+j9gmePInWTqGlhrsKYS5wT3eXMFYF0fK/yWanCtiNXSEzANjaX28NP6l9WkJgw==
X-Received: by 2002:a17:902:142:: with SMTP id 60mr4715775plb.330.1542569094501;
        Sun, 18 Nov 2018 11:24:54 -0800 (PST)
Received: from brauner.io ([2404:4404:133a:4500:9d11:de0b:446c:8485])
        by smtp.gmail.com with ESMTPSA id p188sm16212347pfg.65.2018.11.18.11.24.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 18 Nov 2018 11:24:53 -0800 (PST)
Date:   Sun, 18 Nov 2018 20:24:45 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Daniel Colascione <dancol@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
Message-ID: <20181118192443.7ylyl24svrn6jvjd@brauner.io>
References: <20181118111751.6142-1-christian@brauner.io>
 <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
 <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
 <20181118174148.nvkc4ox2uorfatbm@brauner.io>
 <CAKOZueto1CmUSWFKjOkazcDcZH6CiXXCr4U=ghewLh8GjE2-=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKOZueto1CmUSWFKjOkazcDcZH6CiXXCr4U=ghewLh8GjE2-=A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 10:07:31AM -0800, Daniel Colascione wrote:
> On Sun, Nov 18, 2018 at 9:41 AM, Christian Brauner <christian@brauner.io> wrote:
> > On Sun, Nov 18, 2018 at 07:38:09AM -0800, Andy Lutomirski wrote:
> >> On Sun, Nov 18, 2018 at 5:59 AM Daniel Colascione <dancol@google.com> wrote:
> >> >
> >> > I had been led to believe that the proposal would be a comprehensive
> >> > process API, not an ioctl basically equivalent to my previous patch.
> >> > If you had a more comprehensive proposal, please just share it on LKML
> >> > instead of limiting the discussion to those able to attend these
> >> > various conferences. If there's some determined opposition to a
> >> > general new process API, this opposition needs a fair and full airing,
> >> > as not everyone can attend these conferences.
> >> >
> >> > On Sun, Nov 18, 2018 at 3:17 AM, Christian Brauner <christian@brauner.io> wrote:
> >> > > With this patch an open() call on /proc/<pid> will give userspace a handle
> >> > > to struct pid of the process associated with /proc/<pid>. This allows to
> >> > > maintain a stable handle on a process.
> >> > > I have been discussing various approaches extensively during technical
> >> > > conferences this year culminating in a long argument with Eric at Linux
> >> > > Plumbers. The general consensus was that having a handle on a process
> >> > > will be something that is very simple and easy to maintain
> >> >
> >> > ioctls are the opposite of "easy to maintain". Their
> >> > file-descriptor-specific behavior makes it difficult to use the things
> >> > safely. If you want to take this approach, please make a new system
> >> > call. An ioctl is just a system call with a very strange spelling and
> >> > unfortunate collision semantics.
> >> >
> >> > > with the
> >> > > option of being extensible via a more advanced api if the need arises.
> >> >
> >> > The need *has* arisen; see my exithand patch.
> >> >
> >> > > I
> >> > > believe that this patch is the most simple, dumb, and therefore
> >> > > maintainable solution.
> >> > >
> >> > > The need for this has arisen in order to reliably kill a process without
> >> > > running into issues of the pid being recycled as has been described in the
> >> > > rejected patch [1].
> >> >
> >> > That patch was not "rejected". It was tabled pending the more
> >> > comprehensive process API proposal that was supposed to have emerged.
> >> > This patch is just another variant of the sort of approach we
> >> > discussed on that patch's thread here. As I mentioned on that thread,
> >> > the right approach option is a new system call, not an ioctl.
> >> >
> >> >  To fulfill the need described in that patchset a new
> >> > > ioctl() PROC_FD_SIGNAL is added. It can be used to send signals to a
> >> > > process via a file descriptor:
> >> > >
> >> > > int fd = open("/proc/1234", O_DIRECTORY | O_CLOEXEC);
> >> > > ioctl(fd, PROC_FD_SIGNAL, SIGKILL);
> >> > > close(fd);
> >> > >
> >> > > Note, the stable handle will allow us to carefully extend this feature in
> >> > > the future.
> >> >
> >> > We still need the ability to synchronously wait on a process's death,
> >> > as in my patch set. I will be refreshing that patch set.
> >>
> >> I fully agree that a more comprehensive, less expensive API for
> >> managing processes would be nice.  But I also think that this patch
> >> (using the directory fd and ioctl) is better from a security
> >> perspective than using a new file in /proc.
> >>
> >> I have an old patch to make proc directory fds pollable:
> >>
> >> https://lore.kernel.org/patchwork/patch/345098/
> >>
> >> That patch plus the one in this thread might make a nice addition to
> >> the kernel even if we expect something much better to come along
> >> later.
> >
> > I agree. Eric's point was to make the first implementation of this as
> > simple as possible that's why this patch is intentionally almost
> > trivial. And I like it for its simplicity.
> >
> > I had a more comprehensive API proposal of which open(/proc/<pid>) was a
> > part. I didn't send out alongside this patch as Eric clearly prefered to
> > only have the /proc/<pid> part. Here is the full proposal as I intended
> > to originally send it out:
> 
> Thanks.
> 
> > The gist is to have file descriptors for processes which is obviously not a new
> > idea. This has been done before in other OSes and it has been tried before in
> > Linux [2], [3] (Thanks to Kees for pointing out these patches.). So I want to
> > make it very clear that I'm not laying claim to this being my or even a novel
> > idea in any way. However, I want to diverge from previous approaches with my
> > suggestion. (Though I can't be sure that there's not something similar in other
> > OSes already.)
> 
> Windows works basically as you describe. You can create a process is
> suspended state, configure it however you want, then let it run.
> CreateProcess (and even moreso, NtCreateProcess) also provide a rich
> (and *extensible*) interface for pre-creation process configuration.
> 
> >> One of the main motivations for having procfds is to have a race-free way of
> > configuring, starting, polling, and killing a process. Basically, a process
> > lifecycle api if you want to think about it that way. The api should also be
> > easily extendable in the future to avoid running into the limitations we
> > currently see with the clone*() syscall(s) again.
> >
> > One of the crucial points of the api is to *separate the configuration
> > of a process through a procfd from actually creating the process*.
> > This is a crucial property expressed in the open*() system calls. First, get a
> > stable handle on an object then allow for ways to configure it. As such the
> > procfd api shares the same insight with Al's and David's new mount api.
> > (Fwiw, Andy also pointed out similarities with posix_spawn().)
> > What I envisioned was to have the following syscalls (multiple name suggestions):
> >
> > 1. int process_open / proc_open / procopen
> > 2. int process_config / proc_config / procconfig or ioctl()-based
> > 3. int process_info / proc_info / procinfo or ioctl()-based
> > 4. int process_manage / proc_manage / procmanage or ioctl()-based
> 
> The API you've proposed seems fine to me, although I'd either 1)
> consolidate operations further into one system call, or 2) separate
> the different management operations into more and different system
> calls that can be audited independently. The grouping you've proposed
> seems to have the worst aspects of API splitting and API multiplexing.
> But I have no objection to it in spirit.
> 
> That said, while I do want to fix process configuration and startup
> generally, I want to fix specific holes in the existing API surface
> first. The two patches I've already sent do that, and this work
> shouldn't wait on an ideal larger process-API overhaul that may or may
> not arrive. Based on previous history, I suspect that an API of the
> scope you're proposing would take years to overcome all LKML
> objections and land. I don't want to wait that long when we can make
> smaller fixes that would not conflict with the general architecture.
> 
> The original patch on this thread is half of the right fix. While I
> think we should use a system call instead of an ioctl, and while I
> have some specific implementation critiques (which I described in a
> different message), it's the right general sort of thing. We should
> merge it.

Thanks. I agree. Note, I don't care if it's an ioctl() or not. I'm happy
to instead add a syscall process_signal() alongside this patchset. What
do people prefer?

> 
> Next, I want to merge my exithand proposal, or something like it. It's
> likewise a simple change that, in a minimal way, addresses a
> longstanding API deficiency. I'm very strongly against the
> POLLERR-on-directory variant of the idea.
