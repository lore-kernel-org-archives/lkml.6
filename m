Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A24C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE56B20894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dtez4Mmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE56B20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388972AbeHAL0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:26:34 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:37880 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387856AbeHAL0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:26:34 -0400
Received: by mail-io0-f196.google.com with SMTP id z19-v6so15524411ioh.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 02:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sXuwWjcwtoOtJJXy6yV9lBFdRvPugc1q0zHnMLv573M=;
        b=Dtez4MmqJi4aNCjExtxFS8iN9qhIwHB3YC2fs9uCbq0DelF42uIAqXQyBkgw+cEmIU
         K+MXKZoKaEwtQK7oqQfE2bCbgxavMcIqtKnPDMt2eun1Pdn8ZUU8/gkAU60eVB/W//kV
         Mzqsz1uwK0yzqLYr4bueMdu7tmeSt8zfX/tLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sXuwWjcwtoOtJJXy6yV9lBFdRvPugc1q0zHnMLv573M=;
        b=bv/AvzUpMLNy9fWgC7BB/s4/I2PHIx5iSPCKOaRFG5Y7wdGqMS2/e4lcL3P5eVvMPJ
         GAN9QVbrUopmDR9DocglQY1N80P7j3C3gm5xE+5OKD2uioGJGe92Itlf4GO1RfXfbN6u
         cPBIX+h7FTDu3ItOvrhWmeD3gZFsBfBhzZk2Sz/xUYs2qpf249XC3VClBHtbFsyq5PJk
         hMvLnxJtBmOGpVtMGMCTbmxqde7n1tKnHvJREDqjj0/3G2V8umjlaJqpJNQaJ5Z4n8aH
         UeMfcEKTq+wJ8Yp02apWVOGUcEGjz1TShtUeGVJ6+qx6xzAhyCepT0z6ewagvMlOxh2a
         lT7Q==
X-Gm-Message-State: AOUpUlHGnMhbZGnCjHxKqNW5/pGb7voR2YdE19c/cZUuT4UYk1TQa9ox
        lBVdyly4EJ1HWuuwPAfRpqMgNql4CtJoGjihKooOHA==
X-Google-Smtp-Source: AAOMgpePsrv3lE21lfIQZNTIvO4JmXyvXqtyrnh0Xy+g2ieH3Wqm4WUD5znds0mJXfL8nVNhNxGDaG0PyU0Qcofeoqg=
X-Received: by 2002:a6b:c997:: with SMTP id z145-v6mr2751039iof.266.1533116500183;
 Wed, 01 Aug 2018 02:41:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:2b03:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 02:41:39 -0700 (PDT)
In-Reply-To: <CAGXu5jJbS-P9X+6jPVkiVqDN1vF5ZFiwxRD0fHk+yYnhb9qKGQ@mail.gmail.com>
References: <20180712195937.GA36007@beast> <CAPDyKFpi87UaKLScADOT_gkXkXpLR6r2J71G78zVn0hkc3ng5g@mail.gmail.com>
 <CAGXu5jJbS-P9X+6jPVkiVqDN1vF5ZFiwxRD0fHk+yYnhb9qKGQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Aug 2018 11:41:39 +0200
Message-ID: <CAPDyKFpdfVx4QqOEsBhOrTPp7iVo=qqFr7AFr-e2Sfqef+CtWQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mxcmmc: Fix missing parentheses and brace
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 July 2018 at 22:27, Kees Cook <keescook@chromium.org> wrote:
> On Mon, Jul 16, 2018 at 3:11 AM, Ulf Hansson <ulf.hansson@linaro.org> wro=
te:
>> On 12 July 2018 at 21:59, Kees Cook <keescook@chromium.org> wrote:
>>> Looks like the adjusted syntax wasn't fully build tested. This fixes
>>> failures with powerpc builds:
>>>
>>> drivers/mmc/host/mxcmmc.c: In function =E2=80=98mxcmci_swap_buffers=E2=
=80=99:
>>> drivers/mmc/host/mxcmmc.c:296:51: error: expected =E2=80=98)=E2=80=99 b=
efore =E2=80=98;=E2=80=99 token
>>>    void *buf =3D kmap_atomic(sg_page(sg) + sg->offset;
>>>                                                    ^
>>> drivers/mmc/host/mxcmmc.c:299:1: error: expected =E2=80=98,=E2=80=99 or=
 =E2=80=98;=E2=80=99 before =E2=80=98}=E2=80=99 token
>>>  }
>>>  ^
>>>
>>> Fixes: b189e7589f6d3 ("mmc: mxcmmc: handle highmem pages")
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> Thanks, applied for fixes!
>
> I just checked again, and while I see this in linux-next, I would
> expect this to be in 4.18, since this fixes a 4.18-introduced build
> failure for some PPC configurations. Can this please be included in
> 4.18?

Yes it will, I was just about to create a PR for it.

However, I have deliberately slowed down the pace of sending fixes to
Linus, because of trying to achieve a somewhat better test coverage.

If you want to test the latest 4.18 rcs with pending fixes, we have
the pending-fixes branch in Stephen's next tree.

[...]

Kind regards
Uffe
