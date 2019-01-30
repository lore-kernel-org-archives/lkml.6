Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD61C282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEAB2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PBem4RYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbfA3IQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 03:16:40 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42513 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbfA3IQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 03:16:40 -0500
Received: by mail-ua1-f68.google.com with SMTP id d21so7784907uap.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 00:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c07v3eFRCVOXyTYENQwlxmL4v60pJZfN9DAmaLr1bJE=;
        b=PBem4RYZpO/OvXfNPQJVGAJ/r8msY2M3zLJ54Vd5yVxOtfRJUhsXmUnGnlrePTRcat
         ZtY8hMNCFUMX05g//ZW0tpy7RsLMzmzJE1UkHJDZf4GC8A0OVWic84gH2b/zjcYYI+0S
         h8YqzvjHYVUtHgH8FTzlh6fPHBQJN8XDGWruw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c07v3eFRCVOXyTYENQwlxmL4v60pJZfN9DAmaLr1bJE=;
        b=L4eUpHdIBaOQiGyIWa3RqNzA0gTxhpwLzca8lccRMXWjIykoVtQbACItG+89OhzuEl
         MD8LQhG5u67MTmky3pMOTDPNQnTRTT2AJRMuL7N27kOWkv9MnhmnKRUgfWuimfEH5pMt
         hhssLxRBhvS6VC68oSbJtWtQC89Ba/tBqAA6OrbolTsBG4QPFH6xUnjXuBFXUxtrdRsh
         8CwofWzCQepoVP1QWOE2mBPxBGGyg03LJXFbxdi98iwWMpf6TqyJvA5CtKtAYx9m78//
         2IN1Dlm4P4D/sFgOvC4LZTyiXj+wC1X/MTLZ5LOoBIrxKwJNLM8msEa+SfpEvfGEWWEX
         PrIQ==
X-Gm-Message-State: AJcUukcaYRwinKQh4rRcH/DrpmUISSmOxy9R+1IJg+jp1Lkh1Hu0eTcT
        1C7re01X+9Ke9TEkdPD7sSYpa3ImQm7ld0rvGwm6IQ==
X-Google-Smtp-Source: ALg8bN5Ph4KwIq7RATJQUlitfc+i5I7CLw66TVchouohYuBRY5easDW5lfzuDeUV79ae0b4kboXorLnDYfPmY7CwkoM=
X-Received: by 2002:a9f:2244:: with SMTP id 62mr11741335uad.119.1548836198904;
 Wed, 30 Jan 2019 00:16:38 -0800 (PST)
MIME-Version: 1.0
References: <20190114095804.27978-1-hch@lst.de> <20190114095804.27978-6-hch@lst.de>
 <CAPDyKFpcHv7KwuVpWcKjxj--n4YOFADWD5WzOCJ6Dca_JjqnAw@mail.gmail.com> <20190130080423.GA29937@lst.de>
In-Reply-To: <20190130080423.GA29937@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Jan 2019 09:16:03 +0100
Message-ID: <CAPDyKFq5mMPX6vfbJVqGPFBwSQ0+eG_UVcok74GQqcmTktgkXA@mail.gmail.com>
Subject: Re: [PATCH 05/11] mmc: s3cmci: handle highmem pages
To:     Christoph Hellwig <hch@lst.de>
Cc:     Russell King <linux@armlinux.org.uk>,
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

On Wed, 30 Jan 2019 at 09:04, Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Jan 30, 2019 at 08:57:47AM +0100, Ulf Hansson wrote:
> > On Mon, 14 Jan 2019 at 10:58, Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > Instead of setting up a kernel pointer to track the current PIO address,
> > > track the offset in the current page, and do an atomic kmap for the page
> > > while doing the actual PIO operations.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > Nitpick: This one have some trailing whitespace errors, which git
> > complains about when I apply it.
> >
> > No need to re-spin due to this, I can fix it  up.
>
> I'll need to respin to limit the segment size to a page anyway, so I
> will take this into account as well for v2.

Okay!

FYI, I have no further comment on the series, it looks okay to me!

Kind regards
Uffe
