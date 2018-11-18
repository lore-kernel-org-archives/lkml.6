Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3E5C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 16:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD9D2086B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 16:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oH4C6WEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD9D2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeKSCiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 21:38:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:42974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbeKSCiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 21:38:51 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B9682087A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 16:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542557889;
        bh=5RS+IIM8wK/4OBumQsai9zq8KId55KB/3RxydSWNf/s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oH4C6WEm5xkko+vSJB+nPBaqaZ4rTky184L4zXQ652C4Zgdqvw3lfV8GP8uD9B0YR
         si6ZAFZmkWbeysJ0Q5kRmiLSN7C7pWmUbiqk4D34mSkRB14VDj2CPJTwqVekNaln0J
         GJ+Jglc19iQfRza9H/Cx/7e8SdAUE5QuJSOwxc8Q=
Received: by mail-wr1-f45.google.com with SMTP id e3-v6so29498728wrs.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 08:18:09 -0800 (PST)
X-Gm-Message-State: AGRZ1gL5QicD6rh3afAgnrMRwKqb3R5B9Uz/zghiad5y9tJL/YgRg+G3
        yvb3gitkhBzfEwPvuE1vqj+KvWT+iPGGomg1ADPaew==
X-Google-Smtp-Source: AJdET5dU+f5ryhLIpeMaHh3+O5udGgg3dAyIcYPKp3BgeICBvRfiJ/Hu9Bh6B/ouYNv5tU0kNfN43h2rxcygw1QC6r4=
X-Received: by 2002:adf:90af:: with SMTP id i44-v6mr14502486wri.77.1542557887990;
 Sun, 18 Nov 2018 08:18:07 -0800 (PST)
MIME-Version: 1.0
References: <20181118111751.6142-1-christian@brauner.io> <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
 <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com> <CAKOZuev1JUGFWuwsKqS6rXcFMqpCHT1VAG2kwB4O=FHo6DAFiQ@mail.gmail.com>
In-Reply-To: <CAKOZuev1JUGFWuwsKqS6rXcFMqpCHT1VAG2kwB4O=FHo6DAFiQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 18 Nov 2018 08:17:55 -0800
X-Gmail-Original-Message-ID: <CALCETrVLP_mudJTW6EQpRr5GZ7kfuGci+QCT1uPrOVDTWcod-A@mail.gmail.com>
Message-ID: <CALCETrVLP_mudJTW6EQpRr5GZ7kfuGci+QCT1uPrOVDTWcod-A@mail.gmail.com>
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

On Sun, Nov 18, 2018 at 7:53 AM Daniel Colascione <dancol@google.com> wrote:
>
> On Sun, Nov 18, 2018 at 7:38 AM, Andy Lutomirski <luto@kernel.org> wrote:
> > I fully agree that a more comprehensive, less expensive API for
> > managing processes would be nice.  But I also think that this patch
> > (using the directory fd and ioctl) is better from a security
> > perspective than using a new file in /proc.
>
> That's an assertion, not an argument. And I'm not opposed to an
> operation on the directory FD, now that it's clear Linus has banned
> "write(2)-as-a-command" APIs. I just insist that we implement the API
> with a system call instead of a less-reliable ioctl due to the
> inherent namespace collision issues in ioctl command names.

Linus banned it because of bugs iike the ones in the patch.

>
> > I have an old patch to make proc directory fds pollable:
> >
> > https://lore.kernel.org/patchwork/patch/345098/
> >
> > That patch plus the one in this thread might make a nice addition to
> > the kernel even if we expect something much better to come along
> > later.
>
> I've always commented on that patch. You never addressed my technical
> objections. Why are you bringing up this patch again as if that
> discussion had never happened? To review, that patch has various race
> conditions

I don't think I ever saw that review.

> and even if it were technically correct, it'd be an abuse
> of directory objects (in what other circumstance do we poll
> directories?) and not logically generalizable to a model in which we
> expose process exit status via the exit-monitoring API.

I agree it's weird.  It might be better to have /proc/PID/exit_status
and make *that* pollable.
