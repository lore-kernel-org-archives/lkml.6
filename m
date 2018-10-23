Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044C3C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C381B2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TVxZ+cqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C381B2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbeJWSJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 14:09:05 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:43861 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeJWSJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 14:09:05 -0400
Received: by mail-lj1-f178.google.com with SMTP id r8-v6so714434ljc.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 02:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ni6b44Aky9sa7Tc72cWxBq87VWz7mMHe+tqpDTE3CT0=;
        b=TVxZ+cqpfNoTyAeYJx6C4Gfp7RCnT19Nf7JMfAqZ85EfhPpOiP6BZufWReY4iJEJXh
         zsI2HIHxfPxfUpBToDyP/7sbKBmr6DHeI6EMga8S3GHsiCchjIEs2bwgCt/z0cZfsw1q
         AuJTchiH8M+gRoVD4kImqn6EQTkc+S0GjlFMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ni6b44Aky9sa7Tc72cWxBq87VWz7mMHe+tqpDTE3CT0=;
        b=MqsLeS8e5k62sTcWE9n0fOc2Pr3NyCe/Ght0InZlUoEVZNrgJ4RufclLIGMk3EXY5M
         nCtIAvvWyhXW6NebYarcUf0a4lPaPitQVQEHoTQ6FyL/cSvLCvVEn3NfupdDLbvi0DZv
         Qs50u6ia2W3T2uaVx8BTU6W+zYYhjjdo3V9Jh/oZXMArj+YRW0Xj4OepvYxaQdbdeiIy
         SwRau8uMo6Lwa+NhK6yOD1I94oM98gv7wMoLi6BltdbcdyYbF2b8WDRcqDkQbheqaUEg
         l5q7sgdZZD6lDrCZK1Do7Yo+GIfm6OqJYF2/pli7XiUUdUT6bcm62aCCAslzVb8mh0Be
         yWzw==
X-Gm-Message-State: ABuFfoheXoNIP9846wcdLcMLsjafVUiJRBtLabFMhKnMuZdIJcBLGkUC
        ihcPKEI+EMzjo/5tVKixGvCN1CobNUFDFncH
X-Google-Smtp-Source: ACcGV625A//beBIH24BU3mUp32Wa7+Vud9Ss/avTRM0UceoFE+rjIECV/no6E5/vs6uD8cKzPaWJXA==
X-Received: by 2002:a2e:9d05:: with SMTP id t5-v6mr19279502lji.57.1540287983998;
        Tue, 23 Oct 2018 02:46:23 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id s80-v6sm144164lfg.3.2018.10.23.02.46.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 02:46:23 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id t22-v6so721314lji.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 02:46:22 -0700 (PDT)
X-Received: by 2002:a2e:8743:: with SMTP id q3-v6mr11533657ljj.80.1540287982363;
 Tue, 23 Oct 2018 02:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
 <CACRpkdbi2gqqc271eMgHjD68bqf2mzw8zw+iAhYv2LFajfo-eQ@mail.gmail.com>
 <CAHk-=wiiC65aZFrDp69vdcSALLDZNPkTL1diadxNL54tBPeAzQ@mail.gmail.com> <20181023093521.dm3l5oen2j7etsot@kshutemo-mobl1>
In-Reply-To: <20181023093521.dm3l5oen2j7etsot@kshutemo-mobl1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Oct 2018 10:46:06 +0100
X-Gmail-Original-Message-ID: <CAHk-=wh6i5t5jYHrC-ZCdj8qoZWP3BptV87U=G9G4UyunzPf7Q@mail.gmail.com>
Message-ID: <CAHk-=wh6i5t5jYHrC-ZCdj8qoZWP3BptV87U=G9G4UyunzPf7Q@mail.gmail.com>
Subject: Re: Git pull ack emails..
To:     kirill@shutemov.name
Cc:     Linus Walleij <linus.walleij@linaro.org>,
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

On Tue, Oct 23, 2018 at 10:35 AM Kirill A. Shutemov
<kirill@shutemov.name> wrote:
>
> Can you tag merge commit with message-id of the pull request?
> Automation machinery can reply to the pull request with proper CC list
> obtained from the archive?

If it's a "proper" pull request (ie done by git request-pull), then
the magic marker would be that it as that

    for you to fetch changes up to %H:

line where %H is the hash of the tip of the tree that is requested to be pulled.

Then automation could literally just check "is that commit in Linus'
public tree", and when that happens, generate an automatic
notification that the pull request in question has been merged.

So this could all be automated for people who really want to automate
it. I'm not sure I want to do _that_ kind of automation, though. That
sounds more like "maybe something like that would make sense as an
extension of a patchwork-like tool".

I thik I'll just try the "ack when starting the pull" model and see
how that works. Maybe I was overthinking it.

And if it turns out that it would be better to ack after everything
has passed, I could easily just do an email filter for "messages that
are to me, but I have archived and not replied to, and that have 'git
pull' in them".

I use email filters for pinpointing the pulls to begin with, I could
just use email filters to pinpoint the pull requests that I have
already handled.

                Linus
