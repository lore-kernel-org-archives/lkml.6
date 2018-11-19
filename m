Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D217C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B1920870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9V0KK9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36B1920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbeKTChq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:37:46 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:34927 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729796AbeKTChp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:37:45 -0500
Received: by mail-it1-f196.google.com with SMTP id v11so8254160itj.0;
        Mon, 19 Nov 2018 08:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HSsl5sUdP/vssoWlNDZWLB+DW1MRA7rNnOrsZ3lot2k=;
        b=t9V0KK9mnqFLYpl5384MbZYtJQlSmRGyQ6kmMY5ZVaAPCf+eXO1uF14cH2tw20qETO
         rFpg1R1EfQgCqDuICVuKTfUB2KVp2DpsBtNg5ydM+BEJfnJae3UpIOxVeaGWk6G10ipl
         gsJbNq/kFuNwaXYJtnHnNK19+eaDqDpras84tPPTSxdj6D0zIBvfvpMRKZRN+4NEZmW5
         bHZsa4ERpKB+KvqkvtzcHnE0pdBM6LZxrSc9wgMGh3NBG2OcvLyxpk98q2iiCW0qG58b
         Vp0PKL1KElqlVZV5iWzwRQ3Wr1Yg+PhgI3i1DnXp1hKGz1ce97+WxBLDy0WYXcRCIWif
         b1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HSsl5sUdP/vssoWlNDZWLB+DW1MRA7rNnOrsZ3lot2k=;
        b=sqDbECs7q5SJ8b5CeonZ6ni1aQIDIuRaC0ymvXZRZT90xSQNtFlM2Z++zznGeJxdEp
         2LnodOVAHhoNePUDC7tyQHsTIqucVLT4Zw1vPW/TjB7WgePH54GP5WRhArNY1nY82BaZ
         q90XvRt1Zdypr60pLvnveH3djcpBVU0BaLfhaMAqENyGue4fmO+FruCK5ce0Fua8C/y1
         AGF5WGnFXTZeQoMvYPkUH+fLlvA1iNlQTORmSrmNyUO/fqKmNRXrxudWC42pfKXYjAoB
         Dx2i0dTign/fhqH45hKwU//StimLDyurWj1H4p/cWowxYPruFjs7x00sZzehH6+CDF2V
         TtLQ==
X-Gm-Message-State: AGRZ1gJ69rYXyDLV4WeA+310u2KONX5uGe396s0vvBMGMZ8ubOfXX/MV
        i23JWFGxscQPlVQVCOPuVl0V11ycjqInjAXwp9c=
X-Google-Smtp-Source: AJdET5eiGUb0MZwFRW3HVbi/KzDK0hmXnwkgCRTi0xSkblYTDz8sPjSN+/qmglbrMNWst8yCGeHsly1Xiek3+6Ca8CU=
X-Received: by 2002:a02:1b1d:: with SMTP id l29mr4580965jad.98.1542644022543;
 Mon, 19 Nov 2018 08:13:42 -0800 (PST)
MIME-Version: 1.0
References: <20181118111751.6142-1-christian@brauner.io> <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
 <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
 <CAKOZuev1JUGFWuwsKqS6rXcFMqpCHT1VAG2kwB4O=FHo6DAFiQ@mail.gmail.com>
 <CALCETrVLP_mudJTW6EQpRr5GZ7kfuGci+QCT1uPrOVDTWcod-A@mail.gmail.com>
 <a7f50692-667c-4efe-a2d0-fa324eebb90b@infradead.org> <CAKOZueutLc8d0Fe+7dNWiZKnALhTSST8+kCnOrL+OmB6coUmtA@mail.gmail.com>
 <CALCETrVg71XBv-gMOtL-m0Dd0HNz8_oXOUDSWin5LeViAL0UYA@mail.gmail.com>
 <CAKOZuesCKo4GH9fdum2EUFLrtTWam3aizcDQUn3-vCYg4T1P8w@mail.gmail.com>
 <CALCETrUeNZPfrSYa9vH5Ukrk1Y+Kb9GkZOh6LkqG6Z9NpK5P0w@mail.gmail.com>
 <CAKOZuevVk_aH_2TuiNcmxgMa+gHXMBXz6Uu5a6TDjoxjhaE36g@mail.gmail.com> <CALCETrVscRwQG55-j1SKc2TmSb1-=5861804ojUuviNzdyDOrA@mail.gmail.com>
In-Reply-To: <CALCETrVscRwQG55-j1SKc2TmSb1-=5861804ojUuviNzdyDOrA@mail.gmail.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Date:   Mon, 19 Nov 2018 16:13:30 +0000
Message-ID: <CAJwJo6aXQUtciO7kPSENoajV6JUqUGJxCh_0yPf5D8GfbLegzA@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     Andy Lutomirski <luto@kernel.org>
Cc:     dancol@google.com, rdunlap@infradead.org, christian@brauner.io,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        open list <linux-kernel@vger.kernel.org>,
        Serge Hallyn <serge@hallyn.com>, jannh@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, cyphar@cyphar.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, timmurray@google.com,
        Kees Cook <keescook@chromium.org>, jengelh@inai.de,
        Andrei Vagin <avagin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2018 at 18:30, Andy Lutomirski <luto@kernel.org> wrote:
> Here's my point: if we're really going to make a new API to manipulate
> processes by their fd, I think we should have at least a decent idea
> of how that API will get extended in the future.  Right now, we have
> an extremely awkward situation where opening an fd in /proc requires
> certain capabilities or uids, and using those fds often also checks
> current's capabilities, and the target process may have changed its
> own security context, including gaining privilege via SUID, SGID, or
> LSM transition rules in the mean time.  This has been a huge source of
> security bugs.  It would be nice to have a model for future APIs that
> avoids these problems.
>
> And I didn't say in my proposal that a process's identity should
> fundamentally change when it calls execve().  I'm suggesting that
> certain operations that could cause a process to gain privilege or
> otherwise require greater permission to introspect (mainly execve)
> could be handled by invalidating the new process management fds.
> Sure, if init re-execs itself, it's still PID 1, but that doesn't
> necessarily mean that:
>
> fd = process_open_management_fd(1);
> [init reexecs]
> process_do_something(fd);
>
> needs to work.
>
> >
> > > setresuid() has no effect
> > > here -- if you have W access to the process and the process calls
> > > setresuid(), you still have W access.
> >
> > Now you've created a situation in which an operation that security
> > policy previously blocked now becomes possible, invaliding previous
> > designs based on the old security invariant. That's the definition of
> > introducing a security hole.
>
> I think you're overstating your case.  To a pretty good approximation,
> setresuid() allows the caller to remove elements from the set {ruid,
> suid, euid}, unless the caller has CAP_SETUID.  If you could ptrace a
> process before it calls setresuid(), you might as well be able to
> ptrace() it after, since you could have just ptraced it and made it
> call setresuid() while still ptracing it.  Similarly, it seems like
> it's probably safe to be able to open an fd that lets you watch the
> exit status of a process, have the process call setresuid(), and still
> see the exit status.
>
> Regardless of how you feel about these issues, if you're going to add
> an API by which you open an fd, wait for a process to exit, and read
> the exit status, you need to define the conditions under which you may
> open the fd and under which you may read the exit status once you have
> the fd.  There are probably multiple valid answers, but the question
> still needs to be answered.  My POLLERR hack, aside from being ugly,
> avoids this particular issue because it merely lets you wait for
> something you already could have observed using readdir().

Beg your pardon for hijacking the thread..

I wonder how fast it would be holding a pid with another open()ed fd.
And then you need to read comm (or how you filter whom to kill).
It seems to me that procfs will be even slower with this safe-way.
But I might misunderstand the idea, excuses.

So, I just wanted to gently remind about procfs with netlink socket[1].
It seems to me that whenever you receive() pid information, you
can request some uniq 64(?) bit number and kill the process using it.
Whenever uniqueness of 64-bit number to handle pids will be a question
the netlink message might be painlessly extended to 128 or whatever.

Also, it may provide the facilities to atomically kill process say by name
by adding another field to netlink message.

Probably, if it's time to add a new API for procfs, netlink may be more
desirable.

[1]: https://lwn.net/Articles/650243/

Thanks,
             Dmitry
