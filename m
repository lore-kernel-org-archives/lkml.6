Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157B9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 15:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BAB20869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 15:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y05v9z5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6BAB20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeKSB67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 20:58:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbeKSB67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 20:58:59 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 641BB213A2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 15:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542555502;
        bh=Up6VGSy2xyfQcM0X7k9YsrdA27zOzyg5+F0wR7Oc1rI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=y05v9z5oUCo12QB599rEACuvW59FHRXIhGBVOsQ8WjI3jAzlufyyAypwrlAG+Crwj
         Sxm14cqpx+Pyk6LGGRJVhOJ9HkV7pfoKOn+VgRyHfdgQPT0Qtr7cL8EHZDKsgktQQf
         Z7K2kIfCOQ+T+K1UeF4GYuzD+L5xKS/NlVgKR6uU=
Received: by mail-wm1-f43.google.com with SMTP id s11so2915833wmh.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 07:38:22 -0800 (PST)
X-Gm-Message-State: AA+aEWZN83zsr9Bm4j9AYhOiWrngma66/9Uqz5rxcnEszQ/K/wAbSN87
        Ok2dmrEyDnw8/67IPqHrU0oL5eV1HKALlFYyifVpwg==
X-Google-Smtp-Source: AJdET5eCBRjIjn8kB2ouARvEotq5d1ugQdWELzohHFmYJi+qkE1jg5eO5BFwKuXKGI+InqOVnhZglNARld3/3uooT5Q=
X-Received: by 2002:a7b:ce11:: with SMTP id m17mr4740184wmc.74.1542555500631;
 Sun, 18 Nov 2018 07:38:20 -0800 (PST)
MIME-Version: 1.0
References: <20181118111751.6142-1-christian@brauner.io> <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
In-Reply-To: <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 18 Nov 2018 07:38:09 -0800
X-Gmail-Original-Message-ID: <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
Message-ID: <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     Daniel Colascione <dancol@google.com>
Cc:     Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 5:59 AM Daniel Colascione <dancol@google.com> wrote:
>
> I had been led to believe that the proposal would be a comprehensive
> process API, not an ioctl basically equivalent to my previous patch.
> If you had a more comprehensive proposal, please just share it on LKML
> instead of limiting the discussion to those able to attend these
> various conferences. If there's some determined opposition to a
> general new process API, this opposition needs a fair and full airing,
> as not everyone can attend these conferences.
>
> On Sun, Nov 18, 2018 at 3:17 AM, Christian Brauner <christian@brauner.io> wrote:
> > With this patch an open() call on /proc/<pid> will give userspace a handle
> > to struct pid of the process associated with /proc/<pid>. This allows to
> > maintain a stable handle on a process.
> > I have been discussing various approaches extensively during technical
> > conferences this year culminating in a long argument with Eric at Linux
> > Plumbers. The general consensus was that having a handle on a process
> > will be something that is very simple and easy to maintain
>
> ioctls are the opposite of "easy to maintain". Their
> file-descriptor-specific behavior makes it difficult to use the things
> safely. If you want to take this approach, please make a new system
> call. An ioctl is just a system call with a very strange spelling and
> unfortunate collision semantics.
>
> > with the
> > option of being extensible via a more advanced api if the need arises.
>
> The need *has* arisen; see my exithand patch.
>
> > I
> > believe that this patch is the most simple, dumb, and therefore
> > maintainable solution.
> >
> > The need for this has arisen in order to reliably kill a process without
> > running into issues of the pid being recycled as has been described in the
> > rejected patch [1].
>
> That patch was not "rejected". It was tabled pending the more
> comprehensive process API proposal that was supposed to have emerged.
> This patch is just another variant of the sort of approach we
> discussed on that patch's thread here. As I mentioned on that thread,
> the right approach option is a new system call, not an ioctl.
>
>  To fulfill the need described in that patchset a new
> > ioctl() PROC_FD_SIGNAL is added. It can be used to send signals to a
> > process via a file descriptor:
> >
> > int fd = open("/proc/1234", O_DIRECTORY | O_CLOEXEC);
> > ioctl(fd, PROC_FD_SIGNAL, SIGKILL);
> > close(fd);
> >
> > Note, the stable handle will allow us to carefully extend this feature in
> > the future.
>
> We still need the ability to synchronously wait on a process's death,
> as in my patch set. I will be refreshing that patch set.

I fully agree that a more comprehensive, less expensive API for
managing processes would be nice.  But I also think that this patch
(using the directory fd and ioctl) is better from a security
perspective than using a new file in /proc.

I have an old patch to make proc directory fds pollable:

https://lore.kernel.org/patchwork/patch/345098/

That patch plus the one in this thread might make a nice addition to
the kernel even if we expect something much better to come along
later.

This patch that uses ioctl
