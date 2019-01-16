Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1E3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAD820840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389093AbfAPKZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:25:02 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46236 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbfAPKZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:25:01 -0500
Received: by mail-qt1-f194.google.com with SMTP id y20so6480018qtm.13;
        Wed, 16 Jan 2019 02:25:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LmsvamTKgo+58LgedZq1GakVrL3Oa2JR2r8mNl8nyVI=;
        b=at40uF9gLXB73WLeylDk4mWsjDDoWC4/NInB81kafbFudIfBExFllmxGU76u1t3xP+
         HZR176KSEqAPGffLgp26/tI/taeOUEOY150tgjQnY3/KqzCxvlZxqz5WvhNP6T5LvF4M
         DEk8tnmB4QGeQGx4joSgqXw/AAduKD8gzpFCAJjCCCJ0m9uw2ZYta3zFNjGWJabtOeTH
         g6+A0jtC/6e9aM++0aK95MdK3C2Uk/wMxwCSeCXAZaKin9GQH0siNPVl2s4Lwx8a9xZD
         zmOAMFIWf1qKmwOT5Oh3kUjmbpPGJ2Hn7ANGzrvIrewur24h3cjQFgh6qyHeggkfveLs
         /Ljg==
X-Gm-Message-State: AJcUukexUsqLrtTJ9YALKLDVEPcXs9zGzRyqNMSREjV0rAkhmio0mMde
        jShGj4eoBnToYcRLpW40WfEP/XGtTIFWyJqxrVk=
X-Google-Smtp-Source: ALg8bN7TPbSuZQ+urcPiZwntG9alwIAaqb+En/OZwB7UWwOChTvYfu39fhAsU8v0s7alyqMW/8JP2hpa18mO9YsbWWc=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr6344298qtl.343.1547634300459;
 Wed, 16 Jan 2019 02:25:00 -0800 (PST)
MIME-Version: 1.0
References: <20190114095804.27978-1-hch@lst.de> <CAPDyKFqCOWmd3kE=f3bgOgYX-aQKCmbuRH98sTr05sHN71vXZA@mail.gmail.com>
In-Reply-To: <CAPDyKFqCOWmd3kE=f3bgOgYX-aQKCmbuRH98sTr05sHN71vXZA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 16 Jan 2019 11:24:43 +0100
Message-ID: <CAK8P3a16ZoBt=HpZByb_1iH+-0e9O0F0sPX+ROfO9hWnJR94qg@mail.gmail.com>
Subject: Re: remove block layer bounce buffering for MMC
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Walleij <linus.walleij@linaro.org>,
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

On Mon, Jan 14, 2019 at 11:27 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> +Linus Walleij (recently made a cleanup of the mmc bounce buffering code).
>
> On Mon, 14 Jan 2019 at 10:58, Christoph Hellwig <hch@lst.de> wrote:
> >
> > Hi everyone,
> >
> > this series converts the remaining MMC host drivers to properly kmap the
> > scatterlist entries it does PIO operations on, and then goes on to
> > remove the usage of block layer bounce buffering (which I plan to remove
> > eventually) from the MMC layer.
> >
> > As a bonus I've converted various drivers to the proper scatterlist
> > helpers so that at least in theory they are ready for chained
> > scatterlists.
> >
> > All the changes are compile tested only as I don't have any of the
> > hardware, so a careful review would be appreciated.
>
> Thanks for posting this. I will have a look as soon as I can, but
> first needs to catch up with things since the holidays.

Linus probably knows more here, but I have a vague recollection of
the MMC bounce buffer code being needed mostly for performance
reasons: when the scatterlist is discontiguous, that can result in
a request being split up into separate MMC commands, which due
to the lack of queued commands combined with the need for
garbage collection on sub-page writes results in a huge slowdown
compared to having larger bounce buffers all the time.

We had discussed finding a different way to do this (separate
from the bounce buffering), but I don't know if that ever happened,
or if this is even the code that you are changing here.

       Arnd
