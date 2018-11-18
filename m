Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE2CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237AD2087C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNWUwSHO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237AD2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbeKSDaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 22:30:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:49782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbeKSDaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 22:30:16 -0500
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B68A208E3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 17:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542560967;
        bh=2QM+RP7fWWbheI5LZR3igWIYaa6+JjVIEblS3pw3ZO8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YNWUwSHOoW73tVsirihN6BQAKMlzV4YtGODCl2bzCLqeSSKyyau/G5OdHn4+Z2mvE
         47d/KtK00MA4OTs4YavgPoka1lQxTIFDY7cXOgVcZafkLfFLlMTE7l3FYOrtrQRrkJ
         ZJhTdtKBWnMjMjGYbCgbIcrVBW8jq5t0gafbv9bY=
Received: by mail-wm1-f41.google.com with SMTP id k198so2591983wmd.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 09:09:27 -0800 (PST)
X-Gm-Message-State: AA+aEWYWNvrSDRo/JWiB0CpUhbQ1aL5y4U+a6UwdOvJUQfKHp0arRoQc
        zOcQ7h2KyFuTs7LjuEznOqA9XNCR2wOxrbDjhCNIjA==
X-Google-Smtp-Source: AJdET5fWqm1/978+pOr3z4bM2Rdyf8jVzuP1vfOa4XDClrrIjkkYfbZhVTxK7CmsKP+scDFxvS8Oo0pXbCwYlr82BRk=
X-Received: by 2002:a7b:ce11:: with SMTP id m17mr4940668wmc.74.1542560965548;
 Sun, 18 Nov 2018 09:09:25 -0800 (PST)
MIME-Version: 1.0
References: <20181118111751.6142-1-christian@brauner.io> <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
 <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
 <CAKOZuev1JUGFWuwsKqS6rXcFMqpCHT1VAG2kwB4O=FHo6DAFiQ@mail.gmail.com>
 <CALCETrVLP_mudJTW6EQpRr5GZ7kfuGci+QCT1uPrOVDTWcod-A@mail.gmail.com>
 <a7f50692-667c-4efe-a2d0-fa324eebb90b@infradead.org> <CAKOZueutLc8d0Fe+7dNWiZKnALhTSST8+kCnOrL+OmB6coUmtA@mail.gmail.com>
In-Reply-To: <CAKOZueutLc8d0Fe+7dNWiZKnALhTSST8+kCnOrL+OmB6coUmtA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 18 Nov 2018 09:09:14 -0800
X-Gmail-Original-Message-ID: <CALCETrVg71XBv-gMOtL-m0Dd0HNz8_oXOUDSWin5LeViAL0UYA@mail.gmail.com>
Message-ID: <CALCETrVg71XBv-gMOtL-m0Dd0HNz8_oXOUDSWin5LeViAL0UYA@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     Daniel Colascione <dancol@google.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
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

On Sun, Nov 18, 2018 at 8:49 AM Daniel Colascione <dancol@google.com> wrote:
>
> On Sun, Nov 18, 2018 at 8:33 AM, Randy Dunlap <rdunlap@infradead.org> wrote:
> > On 11/18/18 8:17 AM, Andy Lutomirski wrote:
> >> On Sun, Nov 18, 2018 at 7:53 AM Daniel Colascione <dancol@google.com> wrote:
> >>>
> >>> On Sun, Nov 18, 2018 at 7:38 AM, Andy Lutomirski <luto@kernel.org> wrote:
> >>>> I fully agree that a more comprehensive, less expensive API for
> >>>> managing processes would be nice.  But I also think that this patch
> >>>> (using the directory fd and ioctl) is better from a security
> >>>> perspective than using a new file in /proc.
> >>>
> >>> That's an assertion, not an argument. And I'm not opposed to an
> >>> operation on the directory FD, now that it's clear Linus has banned
> >>> "write(2)-as-a-command" APIs. I just insist that we implement the API
> >>> with a system call instead of a less-reliable ioctl due to the
> >>> inherent namespace collision issues in ioctl command names.
> >>
> >> Linus banned it because of bugs iike the ones in the patch.
> >>
> >>>
> >>>> I have an old patch to make proc directory fds pollable:
> >>>>
> >>>> https://lore.kernel.org/patchwork/patch/345098/
> >>>>
> >>>> That patch plus the one in this thread might make a nice addition to
> >>>> the kernel even if we expect something much better to come along
> >>>> later.
> >>>
> >>> I've always commented on that patch. You never addressed my technical
> >>> objections. Why are you bringing up this patch again as if that
> >>> discussion had never happened? To review, that patch has various race
> >>> conditions
> >>
> >> I don't think I ever saw that review.
> >>
> >>> and even if it were technically correct, it'd be an abuse
> >>> of directory objects (in what other circumstance do we poll
> >>> directories?) and not logically generalizable to a model in which we
> >>> expose process exit status via the exit-monitoring API.
> >>
> >> I agree it's weird.  It might be better to have /proc/PID/exit_status
> >> and make *that* pollable.
> >>
> >
> > If there is a new exit_status file, it could even be more than
> > 8 bits of exit status:
> >
> > See https://lore.kernel.org/lkml/alpine.LSU.2.20.1507091257010.9602@nerf40.vanv.qr/T/#u
> > and http://austingroupbugs.net/view.php?id=594#c1317
>
> First of all, as I discussed in [1], we need to first figure out *who*
> should have access to the process exit information. FreeBSD appears to
> make it public without disaster, and if we make exit status public, a
> lot of problems just disappear.

I kind of want to go in the other direction of making a lot of process
information (especially cmdline) less publicly accessible.

In general, any kind of API where a process has an fd is tricky to do
right on UNIXy systems because of SUID, SGID, and LSM transition
rules.  Windows has an easy time of it because it's always safe for a
parent process to introspect the child.  (Well, almost, because
Windows gained their privilege elevation stuff.  I'm not saying we
shouldn't do it -- I'm just saying that it's nontrivial.
