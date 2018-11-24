Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9365FC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 09:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446F720865
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 09:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F+kt41U+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446F720865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbeKXUo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 15:44:57 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34088 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbeKXUo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 15:44:57 -0500
Received: by mail-it1-f194.google.com with SMTP id x124so19696081itd.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 01:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8cgzZRk2BNE6EhD3aCwEge8i+GxY5BFis5pjovLow1k=;
        b=F+kt41U+55ac0yY22HuHY9MXX6sZ+KWHN+s2eb/AKLwzVcVje54CSAHlR67MM1JjJn
         AF+WhmpAiMFcgsFbFMc4w2LbI5vPb0jE3a7Pb0P++INep48jFj363zw2IpKDV4sr7QUg
         JuDFNFuVGY7JghfeSuiOapWF52mwQxWYamxbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8cgzZRk2BNE6EhD3aCwEge8i+GxY5BFis5pjovLow1k=;
        b=OSycvdkbJt2jBEMdVjEpXy2e4QJLZs5FhLeeEiawMcV9MBgcADrvTRsQtYYxOzjn5w
         Cwc8fcd8HeTA37DbdEYU9wNQ1OqXCuR7WZ5V+0xvX9SV0V6bekIiCEFPbOHkDURQENUR
         c+WztIJv/XotJM5B2VmSSfFtQwihjtsZwMrDiHlakTEM0vQF20sogCOS21jD8c+ZO0sO
         BAeOA6aD54yliRIlVoIYc66QrzspjzAHrdzrsPxcBY0N8Lpd2CNXg3A3tmgn3NrLXUpt
         XiPcviw/puAdA+QLvXFz62Mv6DM+xzX4uJwEAlRtCNtA497o+QRYmjWDamYcdKnj6Vf7
         qZyA==
X-Gm-Message-State: AGRZ1gLIiOl2TGwVXHWwtfalAenhQ0/q2Ztnt8+jXjYlR66UWbHAWwbB
        GOCqYzg5xFhB67shHhQThXYRjwNogXpVAlMSe1zp8grm
X-Google-Smtp-Source: AJdET5dHHwDpbFj59rThNUJBW1B2PC0piu8sKy/VUYtsda4JH5yILliM7TP0e9am1IsmUDnL4dMeqxuE3E5D2l21AWM=
X-Received: by 2002:a02:8449:: with SMTP id l9-v6mr16657742jah.130.1543053413339;
 Sat, 24 Nov 2018 01:56:53 -0800 (PST)
MIME-Version: 1.0
References: <0DF8AA8C9CD0FB4ABF4E83674055F7E2D82974@dggemi508-mbx.china.huawei.com>
In-Reply-To: <0DF8AA8C9CD0FB4ABF4E83674055F7E2D82974@dggemi508-mbx.china.huawei.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 24 Nov 2018 10:56:41 +0100
Message-ID: <CAKv+Gu-ffSgS-ZH58u5mNYnqR0++osS-PHn8oHW72o2kRfDYCw@mail.gmail.com>
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

On Sat, 24 Nov 2018 at 07:42, sunrui <sunrui26@huawei.com> wrote:
>
>
> On Thu, 22 Nov 2018 at 02:50, sunrui <sunrui26@huawei.com> wrote:
> >
> >
> >
> > On Sun, 18 Nov 2018 at 23:30, Rui Sun <sunrui26@huawei.com> wrote:
> >
> > >
> >
> > > add 64 bytes loop to acceleration calculation
> >
> > >
> >
> >
> >
> > Can you share some performance numbers please?
> >
> >
> >
> > Also, we don't need 64 byte, 32 byte and 16 byte code paths: just make =
the 8 byte one a loop as well, and drop the 32 byte and 16 byte ones.
> >
> >
> >
> > --
> >
> >
> >
> > Consider of some processor has instruction N-way parallel function, wit=
h the increase of the data buf=E2=80=99s size, 64B loop will performance be=
tter than 16B loop.
> >
> >
> >
> > On the other hand, in the same environment I tested the 8B loop, which =
is worse than the 16-byte loop.
> >
> >
> >
> > The test result is shown in the fellow excel(crc test result.xlsx)
> > sheet1(64B loop) and sheet2(8B loop)
> >
> >
> >Maybe I phrased that wrong: if we add the 64-byte loop, there is no need=
 for a 32-byte block, a 16 byte block and a 8 byte block, since they all us=
e the same crc32x instruction. After the 64-byte loop, just loop in the 8-b=
yte sequence until the remaining data is less than 8 bytes.
> >
> >
> >
> I think we should not use 8-byte loop after 64-byte loop. Although the nu=
mber of code lines is reduced, but it will run more subs and b.cond instruc=
tion. I test it and shown the result in the fellow excel.
>

OK

> Why I used three temp variables to do the ldp below is because our proces=
sor have two load/store unit, if we use the registers which are independent=
, it can processed in parallel.
>

Yes, but you are adding three instructions to a tight loop, which will
be noticeable on in-order cores.

Just use something like

ldp x3, x4, [x0]
ldp x5, x6, [x0, #16]
ldp x7, x8, [x0, #32]
ldp x9, x10, [x0, #48]
add x0, x0, #64

Those are completely independent as well

> By the way,  In most cases, crc short XOR 0xffffffff before and after the=
 calculation, if we add 'mvn w0, w0' at the beginning and before the return=
 will bring some benefits. What do you think about it?

The C code will take care of that.

> >
> >
> > --
> >
> >
> >
> > > Signed-off-by: Rui Sun <sunrui26@huawei.com>
> >
> > > ---
> >
> > >  arch/arm64/lib/crc32.S | 54
> >
> > > ++++++++++++++++++++++++++++++++++++++++++++++----
> >
> > >  1 file changed, 50 insertions(+), 4 deletions(-)
> >
> > >
> >
> > > diff --git a/arch/arm64/lib/crc32.S b/arch/arm64/lib/crc32.S index
> >
> > > 5bc1e85..2b37009 100644
> >
> > > --- a/arch/arm64/lib/crc32.S
> >
> > > +++ b/arch/arm64/lib/crc32.S
> >
> > > @@ -15,15 +15,61 @@
> >
> > >         .cpu            generic+crc
> >
> > >
> >
> > >         .macro          __crc32, c
> >
> > > -0:     subs            x2, x2, #16
> >
> > > -       b.mi            8f
> >
> > > +
> >
> > > +64: cmp     x2, #64
> >
> > > +    b.lt    32f
> >
> > > +
> >
> > > +    adds    x11, x1, #16
> >
> > > +    adds    x12, x1, #32
> >
> > > +    adds    x13, x1, #48
> >
> > > +
> >
> > > +0 : subs    x2, x2, #64
> >
> > > +    b.mi    32f
> >
> > > +
> >
> > > +    ldp     x3, x4, [x1], #64
> >
> > > +    ldp     x5, x6, [x11], #64
> >
> > > +    ldp     x7, x8, [x12], #64
> >
> > > +    ldp     x9, x10,[x13], #64
> >
> > > +
> >
> >
> >
> > Can we do this instead, and get rid of the temp variables?
> >
> >
> >
> >     ldp     x3, x4, [x1], #64
> >
> >     ldp     x5, x6, [x1, #-48]
> >
> >     ldp     x7, x8, [x1, #-32]
> >
> >     ldp     x9, x10,[x1, #-16]
> >
> >
> >
> > > + CPU_BE( rev     x3, x3      )
> >
> > > + CPU_BE( rev     x4, x4      )
> >
> > > + CPU_BE( rev     x5, x5      )
> >
> > > + CPU_BE( rev     x6, x6      )
> >
> > > + CPU_BE( rev     x7, x7      )
> >
> > > + CPU_BE( rev     x8, x8      )
> >
> > > + CPU_BE( rev     x9, x9      )
> >
> > > + CPU_BE( rev     x10,x10     )
> >
> > > +
> >
> > > +    crc32\c\()x w0, w0, x3
> >
> > > +    crc32\c\()x w0, w0, x4
> >
> > > +    crc32\c\()x w0, w0, x5
> >
> > > +    crc32\c\()x w0, w0, x6
> >
> > > +    crc32\c\()x w0, w0, x7
> >
> > > +    crc32\c\()x w0, w0, x8
> >
> > > +    crc32\c\()x w0, w0, x9
> >
> > > +    crc32\c\()x w0, w0, x10
> >
> > > +
> >
> > > +    b.ne       0b
> >
> > > +    ret
> >
> > > +
> >
> > > +32: tbz     x2, #5, 16f
> >
> > > +    ldp     x3, x4, [x1], #16
> >
> > > +    ldp     x5, x6, [x1], #16
> >
> > > +CPU_BE( rev     x3, x3      )
> >
> > > +CPU_BE( rev     x4, x4      )
> >
> > > +CPU_BE( rev     x5, x5      )
> >
> > > +CPU_BE( rev     x6, x6      )
> >
> > > +    crc32\c\()x w0, w0, x3
> >
> > > +    crc32\c\()x w0, w0, x4
> >
> > > +    crc32\c\()x w0, w0, x5
> >
> > > +    crc32\c\()x w0, w0, x6
> >
> > > +
> >
> > > +16: tbz     x2, #4, 8f
> >
> > >         ldp             x3, x4, [x1], #16
> >
> > >  CPU_BE(        rev             x3, x3          )
> >
> > >  CPU_BE(        rev             x4, x4          )
> >
> > >         crc32\c\()x     w0, w0, x3
> >
> > >         crc32\c\()x     w0, w0, x4
> >
> > > -       b.ne            0b
> >
> > > -       ret
> >
> > >
> >
> > >  8:     tbz             x2, #3, 4f
> >
> > >         ldr             x3, [x1], #8
> >
> > > --
> >
> > > 1.8.3.1
> >
> > >
> >
> >
