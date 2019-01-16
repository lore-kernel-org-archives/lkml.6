Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5402DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F89206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d9bAJymd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbfAPNvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:51:31 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42446 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727935AbfAPNvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:51:31 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so4917379lfh.9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 05:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/QAlEPOTpbjNMnenHIMdR9E8UMK5/zSWeglYGtHhaUc=;
        b=d9bAJymd/T9HU4uCTwuYz5vsazR9vJ/oN3bUaagTOzYk/QKhokk3tTKmllUGImXUb/
         1davUna9zTX7ceySQ7by7EHvBo+jeWeU6VyDH/lzOPboagV5WM+XNf6y6IbIzl508MRj
         hI1TmRxOm5uV6uVKKkkcBdtihIMOWLzXoEFME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/QAlEPOTpbjNMnenHIMdR9E8UMK5/zSWeglYGtHhaUc=;
        b=l+iFOGuYGluN9oBaVunvV3dfNx9FMF/YQtR0h5oR6SJVn36yYR8LUqTFjByZ/yzZ/b
         irvXrQwRfTNom+hPX3tBz0PxVRm+9/YjSNAOq6TR2AVqtq4/LhtzVa6v/9uJ0/MUjuEE
         2l6a90bIMsvi83/UPBtd20DIJ0ib9cYj+xrL/Yx9h7GsD2qm1aYhVFPkKcM6g4l/PzZJ
         6siPOBlfLLZLX/AwoEZ01IbKaj/oYb47QQH9yMvkhaB7jY1ZSf27wPI/r8rql212X6in
         VFZmnr6cHIAtF8ACtgQdSJBAzX3TyA9J51/Ed2B2Xu3Aq/pMHcM6PMRXnF+ekviaDD8I
         7R6g==
X-Gm-Message-State: AJcUukd5GS6apZ/lmDKLCHM+Z1zlQhB0tCBH6tm/rO0hP9j33NwRXXyT
        F+SVFz/q6vlTLmxM9K4Ef3o7eDPud3MuuaQ1rpbmwA==
X-Google-Smtp-Source: ALg8bN6rmOifW5Z+BVBm11ZzhoRM65WVwbSH+n4lOJ5EGq9j1EXWpMOKYEFSXfrjsX/EW8pxMJa1n2IGs8pQ2C+6vkc=
X-Received: by 2002:a19:5154:: with SMTP id f81mr7212599lfb.96.1547646688932;
 Wed, 16 Jan 2019 05:51:28 -0800 (PST)
MIME-Version: 1.0
References: <20190114095804.27978-1-hch@lst.de> <CAPDyKFqCOWmd3kE=f3bgOgYX-aQKCmbuRH98sTr05sHN71vXZA@mail.gmail.com>
 <CAK8P3a16ZoBt=HpZByb_1iH+-0e9O0F0sPX+ROfO9hWnJR94qg@mail.gmail.com>
In-Reply-To: <CAK8P3a16ZoBt=HpZByb_1iH+-0e9O0F0sPX+ROfO9hWnJR94qg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Jan 2019 14:51:16 +0100
Message-ID: <CACRpkdY4SRxJiH8PEwTNAyPum_=e3VhG30y8wJhfcdML--9BdQ@mail.gmail.com>
Subject: Re: remove block layer bounce buffering for MMC
To:     Arnd Bergmann <arnd@arndb.de>
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

On Wed, Jan 16, 2019 at 11:25 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jan 14, 2019 at 11:27 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > +Linus Walleij (recently made a cleanup of the mmc bounce buffering code).

Nah it's not THAT bounce buffer.

> Linus probably knows more here, but I have a vague recollection of
> the MMC bounce buffer code being needed mostly for performance
> reasons: when the scatterlist is discontiguous, that can result in
> a request being split up into separate MMC commands, which due
> to the lack of queued commands combined with the need for
> garbage collection on sub-page writes results in a huge slowdown
> compared to having larger bounce buffers all the time.
>
> We had discussed finding a different way to do this (separate
> from the bounce buffering), but I don't know if that ever happened,
> or if this is even the code that you are changing here.

Nope not the same code.

The term "bounce buffer" is sadly used as ambigously as
__underscores in front of function names.

That other "bounce buffer" was first deleted and then
reimplemented as a local hack in the SDHCI driver core
after it caused performance regressions on the i.MX and
some laptops, see commit:

commit bd9b902798ab14d19ca116b10bde581ddff8f905
mmc: sdhci: Implement an SDHCI-specific bounce buffer

That should be orthogonal to Christoph's changes in this
patch series.

Yours,
Linus Walleij
