Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F63C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C8D2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2Vft/71X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C8D2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbeKSDeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 22:34:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbeKSDef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 22:34:35 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B26872145D
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 17:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542561227;
        bh=cBlCzpwFGB16YMGG5gFTK82IzA0QCWH/ndqovWXyGYk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2Vft/71XBTMAajbbdcVqFSHSEGwtSJiD3C75g15V1psXbbd1rjK4K27kwILtMfjWI
         gClnRMt4Y1s5Aj0AjwYxCSAFi8Y5D5Salj7t2/2O+IhHSNGjY3mdkfXR6uJzN5NElj
         0JZheZ0mvBVjicxuaZjRgB6Jntk2ftUPajL2nrfg=
Received: by mail-wm1-f49.google.com with SMTP id k198so2598068wmd.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 09:13:46 -0800 (PST)
X-Gm-Message-State: AGRZ1gIkUvm9BxKUNtDSJ1u1bE5h20CcRLdLpYcrhNyKp+JnI3PXWcuJ
        3wX0wcvYi5GWl2LD6o0UfvMxfO3XXYJrmyjElxBjLg==
X-Google-Smtp-Source: AFSGD/VZoeeam9z/nd5kxWnfvsBh+AOkDMgqstBNSoLNsDAcp9SqYiZ/bXI06fuNWLfLWcXBkEkM9bLTeHRO/G0EG+8=
X-Received: by 2002:a1c:f112:: with SMTP id p18mr4335845wmh.83.1542561225004;
 Sun, 18 Nov 2018 09:13:45 -0800 (PST)
MIME-Version: 1.0
References: <20181118111751.6142-1-christian@brauner.io> <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
 <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
 <CAKOZuev1JUGFWuwsKqS6rXcFMqpCHT1VAG2kwB4O=FHo6DAFiQ@mail.gmail.com>
 <CALCETrVLP_mudJTW6EQpRr5GZ7kfuGci+QCT1uPrOVDTWcod-A@mail.gmail.com> <CAKOZuetuuxW+yFnyaqS5kW6gkVMstLa8D-7SgYtrLBUQB+sgDg@mail.gmail.com>
In-Reply-To: <CAKOZuetuuxW+yFnyaqS5kW6gkVMstLa8D-7SgYtrLBUQB+sgDg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 18 Nov 2018 09:13:33 -0800
X-Gmail-Original-Message-ID: <CALCETrXNBNcASRtxTL_aO-KSj4ahPRpXKLUdHaWG3sPjsWx3CQ@mail.gmail.com>
Message-ID: <CALCETrXNBNcASRtxTL_aO-KSj4ahPRpXKLUdHaWG3sPjsWx3CQ@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     Daniel Colascione <dancol@google.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
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
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 8:29 AM Daniel Colascione <dancol@google.com> wrote:
>
> On Sun, Nov 18, 2018 at 8:17 AM, Andy Lutomirski <luto@kernel.org> wrote:
> > On Sun, Nov 18, 2018 at 7:53 AM Daniel Colascione <dancol@google.com> wrote:
> >>
> >> On Sun, Nov 18, 2018 at 7:38 AM, Andy Lutomirski <luto@kernel.org> wrote:
> >> > I fully agree that a more comprehensive, less expensive API for
> >> > managing processes would be nice.  But I also think that this patch
> >> > (using the directory fd and ioctl) is better from a security
> >> > perspective than using a new file in /proc.
> >>
> >> That's an assertion, not an argument. And I'm not opposed to an
> >> operation on the directory FD, now that it's clear Linus has banned
> >> "write(2)-as-a-command" APIs. I just insist that we implement the API
> >> with a system call instead of a less-reliable ioctl due to the
> >> inherent namespace collision issues in ioctl command names.
> >
> > Linus banned it because of bugs iike the ones in the patch.
>
> Maybe: he didn't provide a reason. What's your point?

My point is that an API that involves a file like /proc/PID/kill is
very tricky to get right.  Here are some considerations:

1. The .write handler for the file must not behave differently
depending on current.  So we can't check the caller's creds.  (There
are legacy things that are generally buggy that look at current's
creds in write handlers.  They're legacy, and they're almost
universally at least a little bit buggy, and many have been
exploitable.)

2. Even if we have ioctl() or a new syscall on /proc/PID/kill, we at
least have to define whether *opening* kill checks any credentials.
It probably shouldn't, since I don't see what the semantics should be.

3. The current Linux kill_pid stuff doesn't take a cred parameter, so
it's not so easy to check f_cred even if we wanted to.

So the simplest implementation using /proc/PID/kill would be for .open
to do essentially nothing and for ioctl or a new syscall to check
credentials as usual.  But this seems to have no technical advantage
over just using /proc/PID itself, and it's a good deal slower, as it
requires an open/close cycle.

Now if we had an ioctlat() API, maybe it would make sense.  But we
don't, and I think it would be a bit crazy to add one.

--Andy
