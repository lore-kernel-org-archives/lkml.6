Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DE5C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17EB20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bjhBGSik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17EB20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbeJYWrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:47:18 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:44315 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbeJYWrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:47:17 -0400
Received: by mail-ed1-f49.google.com with SMTP id z21-v6so8625902edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 07:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=YDhjFlrem7ihcwPtsg+9jqHOe+CquFKcYxvZ6CLUyXU=;
        b=bjhBGSikeIQGuxr23B8NCC2ATslcpiNIz12NT5v4FUf0GVn6bn724H15SHO9v5Lb27
         ECPg+dwfVg1ZqCDNevSWdnDiQRPG27AlyjJdjxTbbdbrjfLpu1dNcYwpdmm1OhBKN9PZ
         5r+CJu/iRAv6aekG/YZrtZGDt/XxVeGixTCZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=YDhjFlrem7ihcwPtsg+9jqHOe+CquFKcYxvZ6CLUyXU=;
        b=kmX7FEJTzrHNSLWmww2T9y3i9kpTCKvUJ7Qseusteu5PiBz3mt1/iki0c0ze9ceiW4
         nwxO7KzjptjGKj07hUC8PU/q8BqrSVPZ6tQacgNQ62/isDEQ9IoR1txQD/q/0cJV6CtN
         FqtmB6hSJpjVLrSW/BZygVEjUwE1exYDEN12H2OUthN6wkRMAuAV51zSGVzPVgFtT08g
         zLzaaDF0/5ZevRbSP2t38AVOonJ+8VvcQLEMslinTSMz+N+WehRh446tCEZJKb13Oziu
         Pp7vuw4GPorRauM4ovs0UbU+ZDdj1dn2o8DTAVqASIwgQ7mwEI8x0+vymYVucSrBiQg0
         Jh3Q==
X-Gm-Message-State: AGRZ1gLSGLJKtMAzTsqC/JkPK7+kGR16SIwRFa4+jykUTZd/tiIGOMxi
        smf0rEz8PmFdwycSK4sfCVneLXNssvacTBOA
X-Google-Smtp-Source: AJdET5fBQcMDAuCFONtfQhBEfPoGU56RJYi0WTojtd2ruBunZPUtDEWDxK9wXZcDgh4iBfVg0lR/6Q==
X-Received: by 2002:a17:906:6a13:: with SMTP id o19-v6mr1261812ejr.99.1540476859303;
        Thu, 25 Oct 2018 07:14:19 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id f3-v6sm2414550eds.72.2018.10.25.07.14.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 07:14:17 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id q7-v6so9500251wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 07:14:17 -0700 (PDT)
X-Received: by 2002:adf:fb89:: with SMTP id a9-v6mr1965846wrr.219.1540476857068;
 Thu, 25 Oct 2018 07:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
 <CACRpkdbi2gqqc271eMgHjD68bqf2mzw8zw+iAhYv2LFajfo-eQ@mail.gmail.com>
 <CAHk-=wiiC65aZFrDp69vdcSALLDZNPkTL1diadxNL54tBPeAzQ@mail.gmail.com>
 <20181023093521.dm3l5oen2j7etsot@kshutemo-mobl1> <CAHk-=wh6i5t5jYHrC-ZCdj8qoZWP3BptV87U=G9G4UyunzPf7Q@mail.gmail.com>
 <20181023200408.GA13179@chatter.qube.local>
In-Reply-To: <20181023200408.GA13179@chatter.qube.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 07:13:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjVJ1w=MYXhu42+1rPybtztz+7q=KWo53nQmasR7R4SNA@mail.gmail.com>
Message-ID: <CAHk-=wjVJ1w=MYXhu42+1rPybtztz+7q=KWo53nQmasR7R4SNA@mail.gmail.com>
Subject: Re: Git pull ack emails..
To:     kirill@shutemov.name, Linus Walleij <linus.walleij@linaro.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm back home, slightly jetl-agged, but _oh_ so relieved to not be
doing the merge window on a laptop any more.

I've been continuing to just manually ack the pull requests, but I've
almost forgotten a few times (and maybe I _did_ forget one or two and
didn't catch it? Who knows?).

So while maybe just continuing to do this means that it becomes second
nature, I'm starting to think that mailing list automation really
would be a good idea:

On Tue, Oct 23, 2018 at 1:04 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Tue, Oct 23, 2018 at 10:46:06AM +0100, Linus Torvalds wrote:
> >If it's a "proper" pull request (ie done by git request-pull), then
> >the magic marker would be that it as that
> >
> >    for you to fetch changes up to %H:
> >
> >line where %H is the hash of the tip of the tree that is requested to be pulled.
> >
> >Then automation could literally just check "is that commit in Linus'
> >public tree", and when that happens, generate an automatic
> >notification that the pull request in question has been merged.
>
> I can probably do something like that at kernel.org. How about something
> more generic -- e.g. a simple tool that asks a remote web service to
> notify you when a commit-id is seen in one of the kernel.org repos?

So I think it might be good to have some generic model for "give me a
trigger when XYZ hits git tree ABC" that people could just do in
general, *but* I think the "scan mailing lists for regular pull
requests" would actually be nicer.

Maybe it would be just a special-case wrapper around a more generic
thing, but this:

> - send a REST request to https://foo.kerkel.org/lmk:
>
>   {
>     "tree": "mainline",
>     "commit": "123abc...abc555",
>     "notify": "(output of $(git config user.email)"
>   }

doesn't really sound all that nice for the "I sent a git pull request,
and want to be notified".

It would be much nicer if the "notification" really did the right
thing, and created an actual email follow-up, with the correct To/Cc
and subject lines, but also the proper "References" line so that it
actually gets threaded properly too.

That implies that it really should be integrated into the mailing list itself.

But I don't know how flexible the whole lkml archive bot is for things
like this. But I assume you have _some_ hook into new messages coming
in for lore.kernel.org?

> Would that be a useful alternative? If yes, what would be your preferred
> workflow for such tool instead of "git lmk [commit] [tree-moniker]"?

I really do suspect that "I sent out a pull request, I'd like to be
automatically notified when it gets upstream" would be the primary
thing.

And by "upstreamed" it isn't necessarily just my tree, of course.

Are there other situations where you might want to track something
_outside_ of a pull request? Maybe. I can't really think of a lot of
them, though. Patches etc don't have commit ID's to track, but it
*might* be interesting to see similar automation just based on the git
patch-ID. But that sounds more like a patchwork issue than something
like "track pull requests".

But this might be one of those "maybe a quick prototype gives people
ideas". Sometimes people _really_ hate automation, but it sounds to me
like it would be a lovely thing to have.

                    Linus
