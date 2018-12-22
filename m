Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09BBC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 22:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB2B21934
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 22:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392889AbeLVWtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 17:49:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44570 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388512AbeLVWtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 17:49:09 -0500
Received: from mail-vs1-f69.google.com ([209.85.217.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <christian.brauner@canonical.com>)
        id 1gaq4x-0000AX-LL
        for linux-kernel@vger.kernel.org; Sat, 22 Dec 2018 22:49:07 +0000
Received: by mail-vs1-f69.google.com with SMTP id b203so4361857vsd.20
        for <linux-kernel@vger.kernel.org>; Sat, 22 Dec 2018 14:49:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c95vZPoFKEFXbWX9ArGamlpKmf1j4Atr3/a94movQzg=;
        b=KPP1Qk4+UYwGHrulYWjDZtypUwZALaQqhGFhLI48JevaJz3PT3s9jhBvd+DjjFP5+i
         7RXVdTMYBeLmBIhQnP5MAZ1152kODkqzcGxel20+wi8nx7rMZVsYSPAHSJJIhCOBOd1X
         Oka6gDNpMIxTBAQADOJ1SEFXLRuQM1wESmn8qFRRemHq9lGehNfqAQqHmBm7RTJ/Ym10
         4IyptMgNlDG/3h0FoBV2be9c0FstScQcUvYjz6v8FWxyt0dJjgqUyikpTu618Udt3bDm
         H9RKacQZJ1oJ+v5MpFRnf/TEpqTetlhUsiepy5SuNYNncryWV3Ul41nHBHwGpeiBIhzV
         QrOg==
X-Gm-Message-State: AJcUukdTLKn1pgaDxIaesRfasxJgng3cfC3jCdhD79tl/0vn4kd5k77P
        +MuS0JupXMJqOHAr/uKl2tkqS3Vk6WAu67KpusG3puXQEUe5JQGfl4DnSjXjJO1LRhZvUIDDkzg
        1zHk2Lvg7RvcE3gnqLP82O9Nd6WgLwkxCGyzXctYTl6dYjlLqfg/3lhnhhg==
X-Received: by 2002:ab0:1425:: with SMTP id b34mr2883515uae.64.1545518946570;
        Sat, 22 Dec 2018 14:49:06 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5+5X+PF7aBAWKd+DSCQ3eIwtOR45Ac9JyEmTrd4kN37BgodZV21ImAreuXPwvTDsSiH4tu8XZnloV7Ynb31OU=
X-Received: by 2002:ab0:1425:: with SMTP id b34mr2883503uae.64.1545518946213;
 Sat, 22 Dec 2018 14:49:06 -0800 (PST)
MIME-Version: 1.0
References: <e62d4c3a-b89b-2380-7b39-66733b389145@gmail.com>
 <CAEJqkggwbNP3Q+7AWr4i64CvAdCp15jVLOtUsnMo6rLk3ExTkA@mail.gmail.com> <CAHk-=wjd2VJDM+RXwg30MpW45F5EHZtLErzxQzYxi4+Dnm3sjw@mail.gmail.com>
In-Reply-To: <CAHk-=wjd2VJDM+RXwg30MpW45F5EHZtLErzxQzYxi4+Dnm3sjw@mail.gmail.com>
From:   Christian Brauner <christian.brauner@canonical.com>
Date:   Sat, 22 Dec 2018 23:48:54 +0100
Message-ID: <CAPP7u0Vo6gB86S-hZcOW9Rmki8oKHd=Lyx3x-N9gjPC4JP_YxQ@mail.gmail.com>
Subject: Re: [BREAKAGE] Since 4.18, kernel sets SB_I_NODEV implicitly on
 userns mounts, breaking systemd-nspawn
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     nix.or.die@gmail.com, "Eric W. Biederman" <ebiederm@xmission.com>,
        ellierevves@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <seth.forshee@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 11:20 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Eric, this is entirely unacceptable.

i would like to point out that I send a revert for this in *July*
before any kernel with this change
was released for the exact same reason. But I was ignored and no one
came to argumentative aid:
- https://lists.linuxfoundation.org/pipermail/containers/2018-July/039182.html
- https://lists.linuxfoundation.org/pipermail/containers/2018-July/039183.html

To be fair, no one apart from me was pointing out that it actually
breaks people including systemd folks
even though I was bringing it up with them. I even tried to fix all of
userspace after this got NACKED
( https://github.com/systemd/systemd/pull/9483 ).

Christian

>
> On Sat, Dec 22, 2018 at 12:58 PM Gabriel C <nix.or.die@gmail.com> wrote:
> >
> > Added some people to CC that might want to see this..
>
> Thanks.
>
> > > Here's an email that was sent to lkml about the subject:
> > >
> > > https://lkml.org/lkml/2018/7/5/742
> > >
> > > I link also this, quoting the last of it:
> > >
> > > https://lkml.org/lkml/2018/7/5/701
> > >
> > > It has never been the case that mknod on a device node will guarantee
> > > that you even can open the device node.  The applications that regress
> > > are broken.  It doesn't mean we shouldn't be bug compatible, but we darn
> > > well should document very clearly the bugs we are being bug compatible with.
>
> Yeah, this is complete garbage.
>
> We have very clear rules in the kernel: if some change breaks existing
> setups, it is ABSOLUTELY NEVER the application that is broken.
>
> It is the kernel.
>
> There is absolutely zero gray areas here. Eric, your behavior is
> entirely out of line, and now we apparently have a regression that
> goes back to June that I was not told about because of your incorrect
> stance.
>
> Eric, I want to make this 1000% clear: there are no user space bugs.
> If it used to work, then user space was clearly doing the right thing.
> The fact that you tried to several times claim it was buggy user space
> is a serious breach of trust. You KNOW this is the case.
>
> Seriously. There are no excuses.
>
> That commit is now reverted in my tree, and furthermore I will not
> take any pull requests from you until you have made it clear that you
> comprehend this very fundamental issue.
>
> Why did it take so long for this issue to be elevated to me?
>
>                    Linus
