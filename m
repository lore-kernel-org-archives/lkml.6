Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A46ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51592083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 15:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51592083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeINUtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 16:49:14 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37601 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeINUtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 16:49:10 -0400
Received: by mail-qt0-f194.google.com with SMTP id n6-v6so9102426qtl.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 08:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+07kIwD2hSywqITsmMbqKKEJYTSm7IfqHnRKXchrBNg=;
        b=AoScQJiIouDYxAkeVyGe6Sy7drdof4pGnyApQUz0Ef6euk3MFK0ZxLreNmxKgfsrqO
         5RBWwrVrlXwsht23+AiIoGng5emWtp4/GtA4LL2EZTDD2JxcZfBqQm57SWM6tqkTMjlc
         9zNxssvCmt/QbtqKIKF+oKRQLkADUgOgJIZ0jK9gAk2UCZH4i28AZVO9vKy8VosuCStR
         eRAQtOdZv53gPTwSWlAmuR6gS/PZ6gjHTsA1ICuwBihgtoI62QCR9ICXAJubKkfzDQG8
         NilibQ31QvjqjPkQCethwV5KHbWZlce7pzytDbAgUxAmLADyoB+2ntvzvO8JZwpkNnW5
         8+sQ==
X-Gm-Message-State: APzg51ANHXwS+2XubDy6Q+4Fh+m8A8yD9Xz/7Nf2C/O6yGOgLUPghpGB
        zx0U09UW173LP8x3MoiItI6TIRvAPwCsP34FeFo=
X-Google-Smtp-Source: ANB0VdbanxpWYKvZYlChFHKBat8bXSGTJTtHCcM93vleNCVWTHBxjC5vOZYO2SOFYlgnCqHg7rm4qEjI0qMuPS1Uqco=
X-Received: by 2002:aed:3608:: with SMTP id e8-v6mr9449723qtb.75.1536939247366;
 Fri, 14 Sep 2018 08:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180913023119.GQ19965@ZenIV.linux.org.uk> <CAK8P3a2LpC6sw5KQ_6kcXKNfgUXkjsxbFkD30kdMgQjurGgy9Q@mail.gmail.com>
 <20180913203145.GU19965@ZenIV.linux.org.uk> <CAK8P3a3LD58jnwP38OpnEWHMzAAfrqtfjHamWVU5PwaKoWyKjg@mail.gmail.com>
 <20180914022737.GX19965@ZenIV.linux.org.uk> <CAK8P3a0wN0uMZdj-mxXwbN9AnZjHzMU6_b01H5y+Vpdt+UoeAw@mail.gmail.com>
 <20180914151011.GZ19965@ZenIV.linux.org.uk>
In-Reply-To: <20180914151011.GZ19965@ZenIV.linux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 14 Sep 2018 17:33:51 +0200
Message-ID: <CAK8P3a2vbLueZ=h6RY74wucH9u2St1z3z62CHUqz9uBs-at7Ew@mail.gmail.com>
Subject: Re: [PATCHES] tty ioctls cleanups, compat and not only
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 5:10 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Sep 14, 2018 at 10:21:53AM +0200, Arnd Bergmann wrote:
>
> > This does sound very appealing, but there is a small downside:
> > The difference between ".compat_ioctl = NULL" and
> > ".compat_ioctl=native_ioctl" is now very subtle, and I wouldn't
> > necessarily expect casual readers to understand that.
>
> ???
>
> One is "all non-generics take pointers to wordsize-neutral objects",
> another "all non-generics take integers".

Yes, I understand that distinction, I'm just trying to look at it from
teh perspective of the majority of developers that roughtly understand
what compat mode is but have never deal with arch/s390 and
compat_ptr() conversion but simply try to get stuff working.

> That solution certainly needs to be documented more than just in commit
> message, though; IMO the method descriptions next to declaration are the
> best place for that.  Will update...

That helps of course.

> > If we go with my file_operations patch for generic_compat_ioctl_ptrarg
> > and add generic_compat_ioctl_intarg, we can do the same thing here
> > with ldisc_compat_ioctl_ptrarg/ldisc_compat_ioctl_intarg to make it
> > a little more consistent with fops and self-documenting.
>
> No, we can't - ldisc ->ioctl() (or ->compat_ioctl()) doesn't get ldisc
> in arguments.  Besides, indirect calls are costly these days...

Ah right. I suppose the argument list could be changed, or
we could call tty_ldisc_ref()/tty_ldisc_deref() again (not sure
if that's safe when we already hold the reference).

> > +        if (retval == -ENOIOCTLCMD && _IOC_TYPE(cmd) == 'T') {
> > +                 retval = tty_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
> > +                 WARN_ON_ONCE(retval != -ENOIOCTLCMD && retval != -ENOTTY);
> > +        }
> >
> > Seeing that you list every single 'T' command in tty_compat_ioctl()
> > that we handle in the native case, that WARN_ON_ONCE should not
> > trigger for any input, but it would catch (and warn about) any of those
> > that might get added in the future to the native code path without the
> > compat entry.
>
> Anything adding new ioctls needs careful review anyway.  And blind bets upon
> that stuff taking compat pointer are, AFAICS, completely unfounded.

I was basing it only on statistics: only two commands out of the whole set
take a translation, and the worst case that would happen if we add a new
command without a compat handler is that user space doesn't get what it
wants but we do get the WARN_ON. In comparison, without that check, user
space never gets what it wants for that command (always -ENOTTY) but
no indication that this is a kernel bug.

      Arnd
