Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFBCC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E071E20869
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gMJUxCZf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E071E20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeKSEDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 23:03:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbeKSEDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 23:03:42 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1394A2133F
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 17:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542562969;
        bh=bCs1J/7Yfm0qq5kP6PaCpP2lviOXbQyHS08M4EvEz5w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gMJUxCZf3aEWSJtlxFBa3CP6yw1MZmwnyY/joLuhgglYDp5Cv/g5D/FRn8Lzb1aEr
         xPUZHrg34hLsYWHw7sVmGOAWS+GVh2jmI2ocwamDPc4wttz5f8UyDQAymahRC/HJO6
         fw+OzFlQxFuHkm86pSEQHNOxA63dGd06KVMZ0pjE=
Received: by mail-wm1-f44.google.com with SMTP id g131so2705181wmg.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 09:42:48 -0800 (PST)
X-Gm-Message-State: AGRZ1gLwSs1unFgIu6g/JkiG3xPpTsnIpOpTmPZZcWCIsn8i1BPfYSuH
        XkH0tyugCzntVS8P/xa/UJI7wDSiC3Go4PAQX5WCMw==
X-Google-Smtp-Source: AJdET5eowJmoQbpAPjZFqPKsSdxtOkbKUbhC2+86kZnmtus6ODPhFskY7DI2e0VWjyrymoh/xMyKyOOPuxnLWy2s3S4=
X-Received: by 2002:a1c:bb42:: with SMTP id l63-v6mr4963895wmf.32.1542562967299;
 Sun, 18 Nov 2018 09:42:47 -0800 (PST)
MIME-Version: 1.0
References: <20181118111751.6142-1-christian@brauner.io> <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
 <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
 <CAKOZuev1JUGFWuwsKqS6rXcFMqpCHT1VAG2kwB4O=FHo6DAFiQ@mail.gmail.com>
 <CALCETrVLP_mudJTW6EQpRr5GZ7kfuGci+QCT1uPrOVDTWcod-A@mail.gmail.com>
 <a7f50692-667c-4efe-a2d0-fa324eebb90b@infradead.org> <CAKOZueutLc8d0Fe+7dNWiZKnALhTSST8+kCnOrL+OmB6coUmtA@mail.gmail.com>
 <CALCETrVg71XBv-gMOtL-m0Dd0HNz8_oXOUDSWin5LeViAL0UYA@mail.gmail.com> <CAKOZuesCKo4GH9fdum2EUFLrtTWam3aizcDQUn3-vCYg4T1P8w@mail.gmail.com>
In-Reply-To: <CAKOZuesCKo4GH9fdum2EUFLrtTWam3aizcDQUn3-vCYg4T1P8w@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 18 Nov 2018 09:42:35 -0800
X-Gmail-Original-Message-ID: <CALCETrUeNZPfrSYa9vH5Ukrk1Y+Kb9GkZOh6LkqG6Z9NpK5P0w@mail.gmail.com>
Message-ID: <CALCETrUeNZPfrSYa9vH5Ukrk1Y+Kb9GkZOh6LkqG6Z9NpK5P0w@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     Daniel Colascione <dancol@google.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christian Brauner <christian@brauner.io>,
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
        Jan Engelhardt <jengelh@inai.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 9:24 AM Daniel Colascione <dancol@google.com> wrote:
> Assuming we don't broaden exit status readability (which would make a
> lot of things simpler), the exit notification mechanism must work like
> this: if you can see a process in /proc, you should be able to wait on
> it. If you learn that process's exit status through some other means
> --- e.g., you're the process's parent, you can ptrace the process, you
> have CAP_WHATEVER_IT_IS_ --- then you should be able to learn the fate
> of the process. Otherwise you just be able to learn that the process
> exited.

Sounds reasonable to me.  Except for the obvious turd that, if you
open /proc/PID/whatever, and the process calls execve(), then the
resulting semantics are awkward at best.

>
> >  Windows has an easy time of it because
>
> Windows has an easier time of it because it doesn't use an ad-hoc
> ambient authority permission model. In Windows, if you can open a
> handle to do something, that handle lets you do the thing. Period.
> There's none of this "well, I opened this process FD, but since I
> opened it, the process called setuid, so now I can't get its exit
> status" nonsense. Privilege elevation is always accomplished via a
> separate call to CreateProcessWithToken, which creates a *new* process
> with the elevated privileges. An existing process can't suddenly and
> magically become this special thing that you can't inspect, but that
> has the same PID and identity as this other process that you used to
> be able to inspect. The model is just better, because permission is
> baked into the HANDLE. Now, that ship has sailed. We're stuck with
> setreuid and exec. But let's be clear about what's causing the
> complexity.

I'm not entirely sure that ship has sailed.  In the kernel, we already
have a bit of a distinction between a pid (and tid, etc -- I'm
referring to struct pid) and a task.  If we make a new
process-management API, we could put a distinction like this into the
API.  As a straw-man proposal (highly incomplete and probably wrong,
but maybe it gets the idea across):

Have a way to get an fd that refers to a "running program".  (I'm
calling it that to distinguish it from "task" and "pid", both of which
already mean something.)  You'd be able to open such an fd given a
pid, and your permissions would be checked at that time.  R access
means you can read the running program's memory and otherwise
introspect it.  W means you can modify it's memory and otherwise mess
with it.  X means you can send it signals.  We might need more bits to
really do this right.

Now here's the kicker: if the "running program" calls execve(), it
goes away.  The fd gets some sort of notification that this happened
and there's an API to get a handle to the new running program *if the
caller has the appropriate permissions*.  setresuid() has no effect
here -- if you have W access to the process and the process calls
setresuid(), you still have W access.

To make this fully useful, we'd probably want to elaborate it with a
race-free way to track all descendents and, if needed, kill them all,
subject to permissions.

This API ought to be extensible to replace ptrace() eventually.

Does this seem like a reasonable direction to go in?
