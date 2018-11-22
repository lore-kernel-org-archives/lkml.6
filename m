Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595AFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B39720820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AH1oKCIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B39720820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389922AbeKVTeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:34:02 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35907 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731706AbeKVTeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:34:02 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so12834028itj.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 00:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QUTvpgJrS8L+IA2wq7JwWDafJ+iU2B32UsdVCezpGlA=;
        b=AH1oKCIjGnpP4iY6NLTyLW6KSNgBW1/C15IwOEEntL9CkoRg4qgaswGQB8h3K5qS/3
         mAjaPPqXpClp0rbBya6FAajaOEVz0TmGcn9FMqHwMYXSPNg7q+GNoZ2IAWNK/bGyGpCI
         4jiESvB5PFqziIprel5ODFIk9W/rPFTyAsMS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QUTvpgJrS8L+IA2wq7JwWDafJ+iU2B32UsdVCezpGlA=;
        b=f9N7hnJcAaF5KooxMwfAPl5xKYYHW8k6VyeztXteAPNfFN4isAfPj0ntLIquX34i6r
         8piQr7czdf93Q+ARFhYFnLjM+ym0U3I6fa0WDC0abP3Ch+q0e0LPxMl68Mv9LqegFmJa
         36qMXz+CHfOfCbgcF6rPLyAjJAHWLKkYNK6dLRCrV9QpP/h6gTNtE4Xi9mI2h6P/YG28
         gPzsV0k8Fo9NKawiNbIB/pDsTKr4Z8bquO1FU/jvhb8PQYE98xzG4FyrzW8Cu02Qy+PA
         wWDloj8gup/WKp/BIV+yl5HzFDZFfLhigGRfA7Saz6PBk0OuEKhEg5srSS4ngiRI84Uw
         wb3Q==
X-Gm-Message-State: AGRZ1gLRF3eMyxogpG/expJ7YFPhNI42xMRYV+owtAXYwKPZcNt9Anm9
        YMnPs4srU28iNNZYb30iJZIGByQ+M9XlfkPuuR4KqA==
X-Google-Smtp-Source: AFSGD/UZAYufP7FAJWyk5iRpMWcExtiTIVzmHk40FbvRjYpv4sDxl71jLh1Z2FpL6g1SZpVLYz7+hXK3IV6c7SXb3/w=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr9681080ith.158.1542876929973;
 Thu, 22 Nov 2018 00:55:29 -0800 (PST)
MIME-Version: 1.0
References: <0DF8AA8C9CD0FB4ABF4E83674055F7E2D7FFCC@dggemi508-mbx.china.huawei.com>
In-Reply-To: <0DF8AA8C9CD0FB4ABF4E83674055F7E2D7FFCC@dggemi508-mbx.china.huawei.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 22 Nov 2018 09:55:18 +0100
Message-ID: <CAKv+Gu_fvcmAKMdj9RyR43ZWC7KQdqo4m=fwAHfN+7u-KXyEWw@mail.gmail.com>
Subject: Re: Re: [PATCH] arm64: crc: accelerated-crc32-by-64bytes
To:     sunrui26@huawei.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Nov 2018 at 02:50, sunrui <sunrui26@huawei.com> wrote:
>
>
>
> On Sun, 18 Nov 2018 at 23:30, Rui Sun <sunrui26@huawei.com> wrote:
>
> >
>
> > add 64 bytes loop to acceleration calculation
>
> >
>
>
>
> Can you share some performance numbers please?
>
>
>
> Also, we don't need 64 byte, 32 byte and 16 byte code paths: just make th=
e 8 byte one a loop as well, and drop the 32 byte and 16 byte ones.
>
>
>
> --
>
>
>
> Consider of some processor has instruction N-way parallel function, with =
the increase of the data buf=E2=80=99s size, 64B loop will performance bett=
er than 16B loop.
>
>
>
> On the other hand, in the same environment I tested the 8B loop, which is=
 worse than the 16-byte loop.
>
>
>
> The test result is shown in the fellow excel(crc test result.xlsx) sheet1=
(64B loop) and sheet2(8B loop)
>

Maybe I phrased that wrong: if we add the 64-byte loop, there is no
need for a 32-byte block, a 16 byte block and a 8 byte block, since
they all use the same crc32x instruction. After the 64-byte loop, just
loop in the 8-byte sequence until the remaining data is less than 8
bytes.


>
>
> --
>
>
>
> > Signed-off-by: Rui Sun <sunrui26@huawei.com>
>
> > ---
>
> >  arch/arm64/lib/crc32.S | 54
>
> > ++++++++++++++++++++++++++++++++++++++++++++++----
>
> >  1 file changed, 50 insertions(+), 4 deletions(-)
>
> >
>
> > diff --git a/arch/arm64/lib/crc32.S b/arch/arm64/lib/crc32.S index
>
> > 5bc1e85..2b37009 100644
>
> > --- a/arch/arm64/lib/crc32.S
>
> > +++ b/arch/arm64/lib/crc32.S
>
> > @@ -15,15 +15,61 @@
>
> >         .cpu            generic+crc
>
> >
>
> >         .macro          __crc32, c
>
> > -0:     subs            x2, x2, #16
>
> > -       b.mi            8f
>
> > +
>
> > +64: cmp     x2, #64
>
> > +    b.lt    32f
>
> > +
>
> > +    adds    x11, x1, #16
>
> > +    adds    x12, x1, #32
>
> > +    adds    x13, x1, #48
>
> > +
>
> > +0 : subs    x2, x2, #64
>
> > +    b.mi    32f
>
> > +
>
> > +    ldp     x3, x4, [x1], #64
>
> > +    ldp     x5, x6, [x11], #64
>
> > +    ldp     x7, x8, [x12], #64
>
> > +    ldp     x9, x10,[x13], #64
>
> > +
>
>
>
> Can we do this instead, and get rid of the temp variables?
>
>
>
>     ldp     x3, x4, [x1], #64
>
>     ldp     x5, x6, [x1, #-48]
>
>     ldp     x7, x8, [x1, #-32]
>
>     ldp     x9, x10,[x1, #-16]
>
>
>
> > + CPU_BE( rev     x3, x3      )
>
> > + CPU_BE( rev     x4, x4      )
>
> > + CPU_BE( rev     x5, x5      )
>
> > + CPU_BE( rev     x6, x6      )
>
> > + CPU_BE( rev     x7, x7      )
>
> > + CPU_BE( rev     x8, x8      )
>
> > + CPU_BE( rev     x9, x9      )
>
> > + CPU_BE( rev     x10,x10     )
>
> > +
>
> > +    crc32\c\()x w0, w0, x3
>
> > +    crc32\c\()x w0, w0, x4
>
> > +    crc32\c\()x w0, w0, x5
>
> > +    crc32\c\()x w0, w0, x6
>
> > +    crc32\c\()x w0, w0, x7
>
> > +    crc32\c\()x w0, w0, x8
>
> > +    crc32\c\()x w0, w0, x9
>
> > +    crc32\c\()x w0, w0, x10
>
> > +
>
> > +    b.ne       0b
>
> > +    ret
>
> > +
>
> > +32: tbz     x2, #5, 16f
>
> > +    ldp     x3, x4, [x1], #16
>
> > +    ldp     x5, x6, [x1], #16
>
> > +CPU_BE( rev     x3, x3      )
>
> > +CPU_BE( rev     x4, x4      )
>
> > +CPU_BE( rev     x5, x5      )
>
> > +CPU_BE( rev     x6, x6      )
>
> > +    crc32\c\()x w0, w0, x3
>
> > +    crc32\c\()x w0, w0, x4
>
> > +    crc32\c\()x w0, w0, x5
>
> > +    crc32\c\()x w0, w0, x6
>
> > +
>
> > +16: tbz     x2, #4, 8f
>
> >         ldp             x3, x4, [x1], #16
>
> >  CPU_BE(        rev             x3, x3          )
>
> >  CPU_BE(        rev             x4, x4          )
>
> >         crc32\c\()x     w0, w0, x3
>
> >         crc32\c\()x     w0, w0, x4
>
> > -       b.ne            0b
>
> > -       ret
>
> >
>
> >  8:     tbz             x2, #3, 4f
>
> >         ldr             x3, [x1], #8
>
> > --
>
> > 1.8.3.1
>
> >
>
>
