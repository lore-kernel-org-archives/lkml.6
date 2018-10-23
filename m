Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B7AC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F16CD20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PVChCkyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F16CD20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbeJXE3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:29:08 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:35626 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeJXE3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:29:08 -0400
Received: by mail-it1-f196.google.com with SMTP id p64-v6so3754536itp.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 13:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zBvWTX4hOLGHPRuDrjbQlXUxhDKlsDQq3KrliNMAZ2s=;
        b=PVChCkyOFWrFZpa9WJBlkQ2oZnGcabef+Vd9jQESlCdxO792E+jynAuzb0iDwebsXH
         Dng0v39ValSqVjLsvEFpiZg2Vmxa4FjmvsTCEpY7JizD3jLQXIRrfbsUfKxdoVIAniov
         HCXzdpxDxfRLATzXZMygeOKt/oV0Fk8sq0x/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=zBvWTX4hOLGHPRuDrjbQlXUxhDKlsDQq3KrliNMAZ2s=;
        b=Y0M+J5i+QJKd1dkruT/3SMBDhkn5WXk3/mEL7Qp2vKTDAcz3iZxcXBHrYE0DLsqzg4
         /tw1KWSb82MXyJJPxAZFO9DRddweScyH+7tOqfioAgJPyGao5d6pfh5ywSDtq7KOq7/j
         YrqMR7agW6JoJnjOWXxt/XumAiqMHBlfC03xKy0LEgyOwuqR1BlY2zKX0FC3m6hcwk9F
         rYsyAivWAdjnl5gOcEtLPfRjh4CSdthYhJ8LrV1hKK+P7M5YYSMI0/QsS6EkM5+pZNY5
         z4RmTjjMuTgDTFQjNHJ6zJGG6tG8jzkQxiZ6fupmbJNZGTkSyum+Gv81xGPl5ZhEuR9T
         +XWg==
X-Gm-Message-State: ABuFfoi2QEynCnTD1+GIbudUTyAZ22iiBC7BcJ49xZTZvUDaJqCVBU0g
        jzCauynm+12HbnsAkJ6DctmbQA==
X-Google-Smtp-Source: ACcGV637cSVg4+Tsj/+NpZoy9RSKRQJPtOdnL3NN0WrhhdOORTO//5qC9jaTKYzvh0Frl30sT30Znw==
X-Received: by 2002:a24:6e87:: with SMTP id w129-v6mr14646200itc.49.1540325053474;
        Tue, 23 Oct 2018 13:04:13 -0700 (PDT)
Received: from chatter.qube.local ([199.66.90.209])
        by smtp.gmail.com with ESMTPSA id y190-v6sm1077730itg.19.2018.10.23.13.04.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 13:04:12 -0700 (PDT)
Date:   Tue, 23 Oct 2018 16:04:08 -0400
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
Message-ID: <20181023200408.GA13179@chatter.qube.local>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <CAHk-=wh6i5t5jYHrC-ZCdj8qoZWP3BptV87U=G9G4UyunzPf7Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 23, 2018 at 10:46:06AM +0100, Linus Torvalds wrote:
>If it's a "proper" pull request (ie done by git request-pull), then
>the magic marker would be that it as that
>
>    for you to fetch changes up to %H:
>
>line where %H is the hash of the tip of the tree that is requested to be p=
ulled.
>
>Then automation could literally just check "is that commit in Linus'
>public tree", and when that happens, generate an automatic
>notification that the pull request in question has been merged.

I can probably do something like that at kernel.org. How about something=20
more generic -- e.g. a simple tool that asks a remote web service to=20
notify you when a commit-id is seen in one of the kernel.org repos?

E.g.:

git lmk for-linus mainline

this does:

- find out the commit-id points at "for-linus"
- send a REST request to https://foo.kerkel.org/lmk:

  {
    "tree": "mainline",
    "commit": "123abc...abc555",
    "notify": "(output of $(git config user.email)"
  }

We already run a bunch of periodic jobs on repo updates and can run an=20
additional check-and-fire-an-email automation job.

Would that be a useful alternative? If yes, what would be your preferred=20
workflow for such tool instead of "git lmk [commit] [tree-moniker]"?

-K

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCW89+uAAKCRC2xBzjVmSZ
bKZEAP9z4TBbVa6fPLNzstlTlGgBPIPe95UZQM1r4yTccg0pNAD+Jj9rkD/K+J+D
F8S2fNGgUlfJT5z4Vqk1pCxiaJLOPw4=
=dmPA
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
