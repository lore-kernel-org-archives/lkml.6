Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C94ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F5B20657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HX1HCtfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F5B20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbeKADeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:34:20 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:40381 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730000AbeKADeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:34:19 -0400
Received: by mail-lj1-f175.google.com with SMTP id t22-v6so15772825lji.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=FQUsOhAwBp6jUI+p9eH6uJvgprhroMji27yeTbkEtYw=;
        b=HX1HCtfCWHRHiOj2HkHJDfDrTd4kEr78eixfg0e6rWvwpA7/uGXm9eodLrEPPSmkLR
         T6eFpq3xr9sSb0Gt5gR4U076chSuyETG6i/zwGInoKxBWXkx73wAjixl+dShcfe0Gytx
         cBBXuLj4YLiD9mMIgY99h0mtoDjMO3oLW63pM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=FQUsOhAwBp6jUI+p9eH6uJvgprhroMji27yeTbkEtYw=;
        b=QTiFnJT0jNjnWnFe/+GnXySHpUhnebBw4j5Oyu9Zh1qJ8NOu6hwcvd2x9iTvlGTmfg
         sTbPrhKJmdHPsLJDje47a0qIrKtPD2WxPfW/T8cwAGK/kfbcQdwBMWGiC+vT+MZYLoaT
         uFn6GaVlo4JbcsGIjFOZxPm/3mKaCw6gNSK2uGWP2OYKL7YdX1oyfAG/4v8uHb2cWf8B
         oSVA/XgWYDXYxKTe6v6zafUWu14J8IXGQaSH4jokPQ+2PwaGk4YWa5JEIuuOXmM0tJdI
         guhcqvIjWrC3nQOHUMLfmpTI2+PUs6GWxp5Y8BkWmJOTHRMCoPHlTVl5iNdgwVJlR1KZ
         iQag==
X-Gm-Message-State: AGRZ1gIaKyljyQAu4EJDHk1oMM4jNfSjXfPr4ODe2BIR8YHN7ziIqzY/
        U9Q92gPfZfd9scL98NbRaIxRzhE042AZ/A==
X-Google-Smtp-Source: AJdET5dIDaXP1/3LkVjiO3w1fDAWajhEr/8Rpdy2JUoeHu87lufSO08TtY8dJljWVFRDKeY3/yqfiA==
X-Received: by 2002:a2e:2909:: with SMTP id u9-v6mr2822451lje.28.1541010905107;
        Wed, 31 Oct 2018 11:35:05 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id p13-v6sm3315477ljh.31.2018.10.31.11.35.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 11:35:02 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id z80-v6so9723837ljb.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:35:01 -0700 (PDT)
X-Received: by 2002:a2e:874e:: with SMTP id q14-v6mr755549ljj.120.1541010900998;
 Wed, 31 Oct 2018 11:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
 <CACRpkdbi2gqqc271eMgHjD68bqf2mzw8zw+iAhYv2LFajfo-eQ@mail.gmail.com>
 <CAHk-=wiiC65aZFrDp69vdcSALLDZNPkTL1diadxNL54tBPeAzQ@mail.gmail.com>
 <20181023093521.dm3l5oen2j7etsot@kshutemo-mobl1> <CAHk-=wh6i5t5jYHrC-ZCdj8qoZWP3BptV87U=G9G4UyunzPf7Q@mail.gmail.com>
 <20181023200408.GA13179@chatter.qube.local> <CAHk-=wjVJ1w=MYXhu42+1rPybtztz+7q=KWo53nQmasR7R4SNA@mail.gmail.com>
 <20181031142756.GA5679@pure.paranoia.local>
In-Reply-To: <20181031142756.GA5679@pure.paranoia.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 31 Oct 2018 11:34:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wht_ohu8T1yA_cB1VG2=V25X0_2FEbBdq=PsFd50g9pRg@mail.gmail.com>
Message-ID: <CAHk-=wht_ohu8T1yA_cB1VG2=V25X0_2FEbBdq=PsFd50g9pRg@mail.gmail.com>
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

On Wed, Oct 31, 2018 at 7:28 AM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> Regarding your case specifically, what's a good cutoff period for
> treating a pull request as effectively ignored/abandoned (i.e. no
> matching commit-id ever found in the repo). I'm guessing about a month,
> or do you want to go longer, in case something shifts to the following
> merge window?

Oh, I'd definitely not go longer - if anything, I think it could be shorter.

My *normal* reaction time is on the order of days. But yes, every
merge window there are a couple of pulls that I end up delaying to the
end of the merge window when I'm supposed to have more time to really
review them. Right now I have three such pull requests pending, for
example (and had planned to look at them today, but then new "normal"
pull requests happened, so I still haven't gotten around to them).

But even when those things get put in my queue, the queue shouldn't be
longer than the 2-week merge window, and if it is, I end up responding
separately (ie writing people "ok, I'm still mulling this over, but
it's not making rc1").

So I think a one-month queue is more than sufficient, and if there are
reasons to time things out earlier, a two-week one would be perfectly
fine too.

                  Linus
