Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABB1C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C24920817
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uga8K6Kc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C24920817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeKSEFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 23:05:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:40972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbeKSEFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 23:05:21 -0500
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 482B2208E3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 17:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542563068;
        bh=HA98euqYy3wEgON3mmY8TFT9et9Xln146bQy9GbsbMI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uga8K6KcFlGl/mx8jabRYAiry78uryKEqpdtVmfyGyRvhOmVTxstF1+w0Rq9ZFe/0
         zvaHKHaAh1KoVwNAV4jwOZYLWl4EwSFK3eHv/OXmdjOovF35ia/qgb9pMS3yFKtwIp
         TXY7Ceq972D8ndfZ38owKZ8mRnl59ng/vQqXglI4=
Received: by mail-wr1-f48.google.com with SMTP id x10so951153wrs.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 09:44:28 -0800 (PST)
X-Gm-Message-State: AA+aEWYXT4qCNsNSXahnVWLpYUFbfh7p+uSZu9JWGyufpIz//SEeL1GH
        fWCGenK7q0BwnzCa4OSwG0I2rKnd1KGb3pUn6MD/Qg==
X-Google-Smtp-Source: AFSGD/UxgZkaxfK38dmVQLWXKyiib6XBsbGn86BdsisTENB3rjFnMWRUAIbPbDTe2/roaFfWRIP7Cg47BnqcbCxjCmI=
X-Received: by 2002:a5d:5541:: with SMTP id g1mr2387353wrw.330.1542563066707;
 Sun, 18 Nov 2018 09:44:26 -0800 (PST)
MIME-Version: 1.0
References: <20181118111751.6142-1-christian@brauner.io> <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
 <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com> <20181118174148.nvkc4ox2uorfatbm@brauner.io>
In-Reply-To: <20181118174148.nvkc4ox2uorfatbm@brauner.io>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 18 Nov 2018 09:44:15 -0800
X-Gmail-Original-Message-ID: <CALCETrXJrk3Jys_T6P=PxO4JY=H-1e9hcMVyBxQJvMRYf=5vfQ@mail.gmail.com>
Message-ID: <CALCETrXJrk3Jys_T6P=PxO4JY=H-1e9hcMVyBxQJvMRYf=5vfQ@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     Christian Brauner <christian@brauner.io>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Daniel Colascione <dancol@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 9:42 AM Christian Brauner <christian@brauner.io> wrote:
>
> On Sun, Nov 18, 2018 at 07:38:09AM -0800, Andy Lutomirski wrote:
> > On Sun, Nov 18, 2018 at 5:59 AM Daniel Colascione <dancol@google.com> wrote:
> > >
> > > I had been led to believe that the proposal would be a comprehensive
> > > process API, not an ioctl basically equivalent to my previous patch.
> > > If you had a more comprehensive proposal, please just share it on LKML
> > > instead of limiting the discussion to those able to attend these
> > > various conferences. If there's some determined opposition to a
> > > general new process API, this opposition needs a fair and full airing,
> > > as not everyone can attend these conferences.
> > >
> > > On Sun, Nov 18, 2018 at 3:17 AM, Christian Brauner <christian@brauner.io> wrote:
> > > > With this patch an open() call on /proc/<pid> will give userspace a handle
> > > > to struct pid of the process associated with /proc/<pid>. This allows to
> > > > maintain a stable handle on a process.
> > > > I have been discussing various approaches extensively during technical
> > > > conferences this year culminating in a long argument with Eric at Linux
> > > > Plumbers. The general consensus was that having a handle on a process
> > > > will be something that is very simple and easy to maintain
> > >
> > > ioctls are the opposite of "easy to maintain". Their
> > > file-descriptor-specific behavior makes it difficult to use the things
> > > safely. If you want to take this approach, please make a new system
> > > call. An ioctl is just a system call with a very strange spelling and
> > > unfortunate collision semantics.
> > >
> > > > with the
> > > > option of being extensible via a more advanced api if the need arises.
> > >
> > > The need *has* arisen; see my exithand patch.
> > >
> > > > I
> > > > believe that this patch is the most simple, dumb, and therefore
> > > > maintainable solution.
> > > >
> > > > The need for this has arisen in order to reliably kill a process without
> > > > running into issues of the pid being recycled as has been described in the
> > > > rejected patch [1].
> > >
> > > That patch was not "rejected". It was tabled pending the more
> > > comprehensive process API proposal that was supposed to have emerged.
> > > This patch is just another variant of the sort of approach we
> > > discussed on that patch's thread here. As I mentioned on that thread,
> > > the right approach option is a new system call, not an ioctl.
> > >
> > >  To fulfill the need described in that patchset a new
> > > > ioctl() PROC_FD_SIGNAL is added. It can be used to send signals to a
> > > > process via a file descriptor:
> > > >
> > > > int fd = open("/proc/1234", O_DIRECTORY | O_CLOEXEC);
> > > > ioctl(fd, PROC_FD_SIGNAL, SIGKILL);
> > > > close(fd);
> > > >
> > > > Note, the stable handle will allow us to carefully extend this feature in
> > > > the future.
> > >
> > > We still need the ability to synchronously wait on a process's death,
> > > as in my patch set. I will be refreshing that patch set.
> >
> > I fully agree that a more comprehensive, less expensive API for
> > managing processes would be nice.  But I also think that this patch
> > (using the directory fd and ioctl) is better from a security
> > perspective than using a new file in /proc.
> >
> > I have an old patch to make proc directory fds pollable:
> >
> > https://lore.kernel.org/patchwork/patch/345098/
> >
> > That patch plus the one in this thread might make a nice addition to
> > the kernel even if we expect something much better to come along
> > later.
>
> I agree. Eric's point was to make the first implementation of this as
> simple as possible that's why this patch is intentionally almost
> trivial. And I like it for its simplicity.
>
> I had a more comprehensive API proposal of which open(/proc/<pid>) was a
> part. I didn't send out alongside this patch as Eric clearly prefered to
> only have the /proc/<pid> part. Here is the full proposal as I intended
> to originally send it out:
>
> The gist is to have file descriptors for processes which is obviously not a new
> idea. This has been done before in other OSes and it has been tried before in
> Linux [2], [3] (Thanks to Kees for pointing out these patches.). So I want to
> make it very clear that I'm not laying claim to this being my or even a novel
> idea in any way. However, I want to diverge from previous approaches with my
> suggestion. (Though I can't be sure that there's not something similar in other
> OSes already.)
>
> One of the main motivations for having procfds is to have a race-free way of
> configuring, starting, polling, and killing a process. Basically, a process
> lifecycle api if you want to think about it that way. The api should also be
> easily extendable in the future to avoid running into the limitations we
> currently see with the clone*() syscall(s) again.
>
> One of the crucial points of the api is to *separate the configuration
> of a process through a procfd from actually creating the process*.
> This is a crucial property expressed in the open*() system calls. First, get a
> stable handle on an object then allow for ways to configure it. As such the
> procfd api shares the same insight with Al's and David's new mount api.
> (Fwiw, Andy also pointed out similarities with posix_spawn().)
> What I envisioned was to have the following syscalls (multiple name suggestions):
>
> 1. int process_open / proc_open / procopen
> 2. int process_config / proc_config / procconfig or ioctl()-based
> 3. int process_info / proc_info / procinfo or ioctl()-based
> 4. int process_manage / proc_manage / procmanage or ioctl()-based

Emails crossed :(

For process management, I generally like this, although we might do
better if we make execve() effectively invalidate the handle.  Then we
avoid a bunch of nasty permission issues.  For process *creation*, we
have the problem that libc authors feel that they can't safely use fds
at all.  There was a proposal for "high fds" a long time back to solve
that.  We might finally need to do something like that.
