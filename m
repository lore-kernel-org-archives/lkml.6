Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B414C64EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 01:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9EAC2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 01:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aW2rvpmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9EAC2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbeJEIme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 04:42:34 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40224 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbeJEImd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 04:42:33 -0400
Received: by mail-oi1-f196.google.com with SMTP id j68-v6so9150459oib.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 18:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HgKSEEQ5IA8zrLmJQ3K/k7s0GrUwLuKe/fLokXDAc20=;
        b=aW2rvpmVDD4kB18R27lPuRpVE4Th2SQrr6rXJjsE6V2/q+O+STKtfUapOkkeDqi81U
         DFFLFDfKANml5cAm4kv+PMT4gOPoaP0EPEmOP57CXOLaGzaHwQyAnTnZqWlkZRIRo9Xz
         GnfMQ7K/bnOQFkpoxCDFDjKs3iy2oT9Rp063A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HgKSEEQ5IA8zrLmJQ3K/k7s0GrUwLuKe/fLokXDAc20=;
        b=SgHynWLv0U1YO79eFMV+LDsdWDrh0C2jZ4tl6uEgjm6v2MSlgFuoPINqDU/o49CNsu
         iww+Bf5kgbAUtsuW1CEODstgdjNIWhptoxku/+pDqh4Btp9WUQfKi1Pexn0oTmtwkx23
         3rusWe0LJZl1iZOJvw/TycfXXXTZfnILz6ytYfJ/gnQW3rV2jjjW2SmFOKTzEUV0dffY
         9fMe8C37/5/eGJfxdp4mjiyka+nCWjeQ+ZLQJo0lH4Y9R9PKjIii5V9rJudUY78eY5me
         WrUI+A0VQ3uctgvGAj8Aq6zuzKWMKiqEk/sj/HGB/PcZBJC2vZOdMY9wZ02PG99EKRO+
         0+ng==
X-Gm-Message-State: ABuFfoiVFulRwMTYqZx4KedISfCPS7Mq6qdyS3Zjaf5EGIFl+UZvIdpg
        gVJ/SIv9Ay1GfUJ9lkXMz5MpGIv9o4p+PYIt0j+7dw==
X-Google-Smtp-Source: ACcGV629lQ0n38oYbzUG3k7WC7rbRgpE1xbq6LK4czbfvuPLb63YIiGt0WKeK4WUgx3J40cjbl9gblNRoqtiVLkvldM=
X-Received: by 2002:aca:c54f:: with SMTP id v76-v6mr4019147oif.276.1538703968224;
 Thu, 04 Oct 2018 18:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180926032455.224600-1-louiscollard@chromium.org> <20180926103521.GB4885@linux.intel.com>
In-Reply-To: <20180926103521.GB4885@linux.intel.com>
From:   Louis Collard <louiscollard@chromium.org>
Date:   Fri, 5 Oct 2018 09:45:57 +0800
Message-ID: <CAKNRAJVibJ0VnxbEiWR_8_q3FzKHT+Q9etcnqJ8Fny40p_cx8g@mail.gmail.com>
Subject: Re: [PATCH] Allow hwrng to initialize crng.
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Andrey Pronin <apronin@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David R. Bild" <david.bild@xaptum.com>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Michael Buesch <m@bues.ch>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Gary R Hook <gary.hook@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 6:35 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, Sep 26, 2018 at 11:24:55AM +0800, Louis Collard wrote:
> > Some systems, for example embedded systems, do not generate
> > enough entropy on boot through interrupts, and boot may be blocked for
> > several minutes waiting for a call to getrandom to complete.
> >
> > Currently, random data is read from a hwrng when it is registered,
> > and is loaded into primary_crng. This data is treated in the same
> > way as data that is device-specific but otherwise unchanging, and
> > so primary_crng cannot become initialized with the data from the
> > hwrng.
> >
> > This change causes the data initially read from the hwrng to be
> > treated the same as subsequent data that is read from the hwrng if
> > it's quality score is non-zero.
> >
> > The implications of this are:
> >
> > The data read from hwrng can cause primary_crng to become
> > initialized, therefore avoiding problems of getrandom blocking
> > on boot.
> >
> > Calls to getrandom (with GRND_RANDOM) may be using entropy
> > exclusively (or in practise, almost exclusively) from the hwrng.
> >
> > Regarding the latter point; this behavior is the same as if a
> > user specified a quality score of 1 (bit of entropy per 1024 bits)
> > so hopefully this is not too scary a change to make.
> >
> > This change is the result of the discussion here:
> > https://patchwork.kernel.org/patch/10453893/
> >
> > Signed-off-by: Louis Collard <louiscollard@chromium.org>
>
> Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>
> /Jarkko

Thanks!

Adding a few people I think I should have included previously - I'm
new to this process so apologies for any missteps; please let me know
if there is anything else I can / should be doing!
