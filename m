Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DDDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7F2205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EDZ9C+pj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7F2205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbeJaX0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:26:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41255 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729492AbeJaX0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:26:20 -0400
Received: by mail-ed1-f67.google.com with SMTP id x31-v6so13780702edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 07:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S8M4uCfROE/MuCCdm1NVOeMId99rb3RiYbjAxks8pgI=;
        b=EDZ9C+pjmNi1/XIrovwYvGv7lKChfCUM5UG4YwpAWC+dDbJByVmAi+LH1GhgYLrLeU
         /+ObKcQV031/hcDdMi7XxfrLmcChjvXg6GzLSwzmCr5840EsczXgUMHi2XeLmIuddqUO
         n2o88bz6Bh2ndmfAdBp3+7eSCSXidNUTtSKMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=S8M4uCfROE/MuCCdm1NVOeMId99rb3RiYbjAxks8pgI=;
        b=hloxJaSumZMRklr4mpU3A1Guf+twZXtLnz6Ku1QC3ZgxwFKjZsjdL7edLnHFzgZZ0L
         ksVDkFmqunKMapP+hMU2LvcVLpqYdXgfp5SjU7voACQ2RsREfbbEfPhAsDR3h8wTpZtf
         pf5ytGQnt/ZqBhvI5zAyJju3in9OGaZ8xNIkoJNba2TmW9aLfylTA4Lr360k7TIdrUZt
         U6MDBiZwz/lTth/5qhwRR0Iow1RN7Cu04oHArSr61JrifRbRxskZEQ7/pofLA5PnioGY
         nxPnutQNPAlbbgTP8TDkJR5cAg6qilDy0paKGky0LR0vFPR63guSZ4zddXs1BYMcrzxs
         4nEQ==
X-Gm-Message-State: AGRZ1gKaDujpNmn9b0pxcyHvgohVuoI6SOF9Y+Dsmm6wGz58eO2ChHtf
        hj/XHFwLLDgbKoP8OFZA7bkShQ==
X-Google-Smtp-Source: AJdET5ecFVTwTVN3lbZEOKqwMbfrmVYbl/SCVbSOCJgA4VCJWw4XXXKnnE9ThQEmNTc3ArGjgTV2KQ==
X-Received: by 2002:a50:b574:: with SMTP id z49-v6mr879226edd.219.1540996083031;
        Wed, 31 Oct 2018 07:28:03 -0700 (PDT)
Received: from pure.paranoia.local (192-0-230-179.cpe.teksavvy.com. [192.0.230.179])
        by smtp.gmail.com with ESMTPSA id m19-v6sm4780618ejz.70.2018.10.31.07.27.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 07:28:01 -0700 (PDT)
Date:   Wed, 31 Oct 2018 10:27:56 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kirill@shutemov.name, Linus Walleij <linus.walleij@linaro.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Git pull ack emails..
Message-ID: <20181031142756.GA5679@pure.paranoia.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        kirill@shutemov.name, Linus Walleij <linus.walleij@linaro.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
 <CACRpkdbi2gqqc271eMgHjD68bqf2mzw8zw+iAhYv2LFajfo-eQ@mail.gmail.com>
 <CAHk-=wiiC65aZFrDp69vdcSALLDZNPkTL1diadxNL54tBPeAzQ@mail.gmail.com>
 <20181023093521.dm3l5oen2j7etsot@kshutemo-mobl1>
 <CAHk-=wh6i5t5jYHrC-ZCdj8qoZWP3BptV87U=G9G4UyunzPf7Q@mail.gmail.com>
 <20181023200408.GA13179@chatter.qube.local>
 <CAHk-=wjVJ1w=MYXhu42+1rPybtztz+7q=KWo53nQmasR7R4SNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjVJ1w=MYXhu42+1rPybtztz+7q=KWo53nQmasR7R4SNA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 07:13:59AM -0700, Linus Torvalds wrote:
> It would be much nicer if the "notification" really did the right
> thing, and created an actual email follow-up, with the correct To/Cc
> and subject lines, but also the proper "References" line so that it
> actually gets threaded properly too.
> 
> That implies that it really should be integrated into the mailing list itself.
> 
> But I don't know how flexible the whole lkml archive bot is for things
> like this. But I assume you have _some_ hook into new messages coming
> in for lore.kernel.org?
> 
> > Would that be a useful alternative? If yes, what would be your preferred
> > workflow for such tool instead of "git lmk [commit] [tree-moniker]"?
> 
> I really do suspect that "I sent out a pull request, I'd like to be
> automatically notified when it gets upstream" would be the primary
> thing.
> 
> And by "upstreamed" it isn't necessarily just my tree, of course.

I should have something working soon, hopefully -- which should be
sufficiently generic to be adapted for other devs.

Regarding your case specifically, what's a good cutoff period for
treating a pull request as effectively ignored/abandoned (i.e. no
matching commit-id ever found in the repo). I'm guessing about a month,
or do you want to go longer, in case something shifts to the following
merge window?

Regards,
-K
