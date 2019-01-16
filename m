Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881E4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FAFA206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733241AbfAPNyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:54:36 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34666 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfAPNyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:54:36 -0500
Received: by mail-qk1-f196.google.com with SMTP id q8so3797484qke.1;
        Wed, 16 Jan 2019 05:54:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OeXSLo9ui7FrcGRJ2DuvONgNX8g8U/wRgwtLSPYMQgY=;
        b=Aa3Rdo2ODbPOtP7k81DI2p55Fc9r2sDcGrfklOwYmjh8IQEQYMC1kVU7gphj17AHRV
         fswhASIZu4qCoDsjUgPlTI89Ax/YTVydRoMrx3WrRiOazd0QJUnzoPRYdIopOxup7P9r
         HMwM7gvRIhEOPRnKjIt7snTYdsdELMBDrIqnabHqazqkpW6NZPsKlkpUIhhj3RC8IMft
         6Xq0ScNh8Pi3vIDYhiwPfKKV8o0Th2PyAfc5calcPZaw+5efWjiDtCdXDe0t9E1SJ8Ce
         GF1AE4aWXCYLIj9x020iIG06jhThB5XprLlA9dGFfmWMhO3hJfXwNGQRMErlDxNQ3QYZ
         4qWA==
X-Gm-Message-State: AJcUukccdlvQgwmKraL3Wh8cUn/4r5UNb1cnfFmCxHdi/csVZJACeujo
        mI+mo7mP0lFaQfn5lY7TGjUET25pRryyTB2fnq/UQA==
X-Google-Smtp-Source: ALg8bN5JYDUHSiThrD7YByCGVuB9x+rHtEvt0GVKiITnGChkIsi8HJ2qupKGY4X8+vQdX0WFItALMDfWT/318cXa5qM=
X-Received: by 2002:ae9:d8c2:: with SMTP id u185mr6371320qkf.107.1547646874745;
 Wed, 16 Jan 2019 05:54:34 -0800 (PST)
MIME-Version: 1.0
References: <20190114095804.27978-1-hch@lst.de> <CAPDyKFqCOWmd3kE=f3bgOgYX-aQKCmbuRH98sTr05sHN71vXZA@mail.gmail.com>
 <CAK8P3a16ZoBt=HpZByb_1iH+-0e9O0F0sPX+ROfO9hWnJR94qg@mail.gmail.com> <CACRpkdY4SRxJiH8PEwTNAyPum_=e3VhG30y8wJhfcdML--9BdQ@mail.gmail.com>
In-Reply-To: <CACRpkdY4SRxJiH8PEwTNAyPum_=e3VhG30y8wJhfcdML--9BdQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 16 Jan 2019 14:54:18 +0100
Message-ID: <CAK8P3a15eGQ+gxxZxGVxsJXpkYSQPOZ5UmRNr7biS--Ye+Unsg@mail.gmail.com>
Subject: Re: remove block layer bounce buffering for MMC
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ben Dooks <ben-linux@fluff.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 2:51 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Jan 16, 2019 at 11:25 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Jan 14, 2019 at 11:27 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > +Linus Walleij (recently made a cleanup of the mmc bounce buffering code).
>
> Nah it's not THAT bounce buffer.
>
> > Linus probably knows more here, but I have a vague recollection of
> > the MMC bounce buffer code being needed mostly for performance
> > reasons: when the scatterlist is discontiguous, that can result in
> > a request being split up into separate MMC commands, which due
> > to the lack of queued commands combined with the need for
> > garbage collection on sub-page writes results in a huge slowdown
> > compared to having larger bounce buffers all the time.
> >
> > We had discussed finding a different way to do this (separate
> > from the bounce buffering), but I don't know if that ever happened,
> > or if this is even the code that you are changing here.
>
> Nope not the same code.
>
> The term "bounce buffer" is sadly used as ambigously as
> __underscores in front of function names.
>
> That other "bounce buffer" was first deleted and then
> reimplemented as a local hack in the SDHCI driver core
> after it caused performance regressions on the i.MX and
> some laptops, see commit:
>
> commit bd9b902798ab14d19ca116b10bde581ddff8f905
> mmc: sdhci: Implement an SDHCI-specific bounce buffer
>
> That should be orthogonal to Christoph's changes in this
> patch series.

Ok, thanks for the clarification. Please ignore my comments then.

    Arnd
