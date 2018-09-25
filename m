Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC42C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E4D2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E4D2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbeIYS21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:28:27 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45683 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbeIYS20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:28:26 -0400
Received: by mail-lf1-f65.google.com with SMTP id m80-v6so9242110lfi.12;
        Tue, 25 Sep 2018 05:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uPYLk6GOCCtoBhi7DSNYHbXcG0cbNWlpGuBf+mxCJI8=;
        b=ObrKUJ2ZkFu3dKl0dU3JtRX9sEtoZY52S4bMJH0hqr1ZEYbgutx/ErB11OvLSVMz3c
         C8CuoaWP9FhZbS7Tg0i01VwGcH0fXv29ZQBxTrkZGqlzK0EfjvemKguHygBPD8CZ4rV1
         e00f/4zhF4RbJEyd/nH5sSTFwVZb9T7jTQIepP4QTIxMXym/U0Qi7wek2BuL4tXUgdx7
         bh1cYUWJFiLl7Mb+b+X5i+Thldys33Bie6NlgPbFJ9d/sWTBUkJK68PFICZPI7j91Rhz
         /0QCprDcapin3YOzrI8VJQJ+bg0893jWzV9AHqPx0Di8ODYyUKCzeShuCXRjxK2MGOzq
         /JcQ==
X-Gm-Message-State: ABuFfoiRgLXdcFr9I1unrF0zX87lfdTT9BzemAvSB7wCG2ptOh9nZbP0
        R18R9IcYLSPQmhXZHZzAvOnyvV/OkYd9d9LhABP39g==
X-Google-Smtp-Source: ACcGV63Zv/5xPBcN7JEtobQcr09UeNRZA0+YAiELTuf6yY0qgvNCyaTZzB06/MKU7y5IpoHCUw+xI+fCgqmSH1wTOvw=
X-Received: by 2002:a19:a854:: with SMTP id r81-v6mr639031lfe.70.1537878066394;
 Tue, 25 Sep 2018 05:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <9516e4b3-f9f2-b150-f019-8b1ef465efb3@tu-dortmund.de>
 <CAK8P3a1sO9HtJPo0S=s3MFK4TN0s_raNTWRTYCYBTGiyHuXg_A@mail.gmail.com> <649d3c5c-3d96-0ed3-cd4d-57641f0ee614@tu-dortmund.de>
In-Reply-To: <649d3c5c-3d96-0ed3-cd4d-57641f0ee614@tu-dortmund.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 25 Sep 2018 14:20:49 +0200
Message-ID: <CAK8P3a2to1LbSNizeSHE3vHaCtp5PSrVFAzy5X2mE49x3tPbxg@mail.gmail.com>
Subject: Re: [x86] BUG()/BUG_ON() macros cannot be disabled
To:     alexander.lochmann@tu-dortmund.de
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 2:13 PM Alexander Lochmann
<alexander.lochmann@tu-dortmund.de> wrote:
>
>
>
> Am 25.09.2018 um 14:06 schrieb Arnd Bergmann:
> > On Tue, Sep 25, 2018 at 1:35 PM Alexander Lochmann
> > <alexander.lochmann@tu-dortmund.de> wrote:
> >>
> >> Hi Arnd,
> >>
> >> I recently tried to disable the BUG macros on x86-32. I disabled the
> >> config item in 'General Setup -> Configure standard kernel features
> >> (expert users) -> BUG() support'.
> >> However, BUG/BUG_ON is still defined. In the !CONFIG_BUG branch in
> >> include/asm-generic/bug.h (line 181) the code checks for the existence
> >> of architecture-specific variants of those macros.
> >> Since x86 defines its own version of BUG(), line 182 is *not* used.
> >> In the following, the x86 variant of BUG() is then used to define the
> >> BUG_ON() macro.
> >>
> >> I propose a patch that really disables both macros if the developer
> >> wants it.
> >> It undefines the respective x86 variants, and defines both macros as
> >> 'empty' macros.
> >
> > Maybe we should update the documentation instead. Note that the
> > generic version is using 'while (1)' rather than 'while (0)', so this is
> > not an empty macro but rather one that does more than the
> > arch-specific one-instruction version does.
> >
> > We don't really want an empty macro any more, this was used in
> > the past, but causes compile-time warnings and undefined behavior
> > for no good reason
> I see. So the documentation of the CONFIG_BUG option is wrong?
> It currently states that 'Disabling this option eliminates support for
> BUG and WARN'.
> Is the current implemention (an endless loop) desired behavior?

I think it's the most reasonable implementation, otherwise a
function like

int something(void)
{
      if (x)
         return 0;
     else
          BUG();
}

will return an uninitialized value.

The arch specific implementations usually just contain a trapping
instruction. With CONFIG_BUG() you get a nice console output
that indicates where this happened, but without CONFIG_BUG(),
this is just reported as an invalid instruction (if CONFIG_PRINTK
is still enabled), killing the current process.

       Arnd
