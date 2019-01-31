Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057A9C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 05:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58122087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 05:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yfx9Ixah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfAaFuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 00:50:12 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:45141 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfAaFuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 00:50:12 -0500
Received: by mail-ua1-f67.google.com with SMTP id e16so630896uam.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 21:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a7M9o+M8f0jeQ4rfBs7V/CiUOjuEglbuWCo2/ff4NBk=;
        b=Yfx9Ixahpfc7RjCe2p9fSHr8EbM552fycdSovZlQrjSN3O9hYoe5tPIdwmQoSMJVth
         zVupaxdhqZQkz1hyKiFiVI9h9AnsszhCVe6P4QIPayE17xL5PRbtm7kQ0FEDchupDCoS
         GXlhKRb+z0NygvY9dpnDwOw/Svm9j1wGFMB50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a7M9o+M8f0jeQ4rfBs7V/CiUOjuEglbuWCo2/ff4NBk=;
        b=bPj7lE5h7bEs4uLgrk826Tg7U+E4g3DdGdYI+4LJmEJ2QG/epvgk1iu9mRX15UVzZV
         ZtlMUhT/AoXlfTIDDPQ9zuUs//4mxXd7JDKQzoIPWCRu4ks24fkvGOmjlJsKeuBwCuTI
         bYsU7DxWw3Y+G8gNJvuFkBk7wXq25RyTqGYi/saTDuYEsaNYw/X5+PK+u2Hxhkrbp4tx
         G3RE5/F/32RJ/YbMyx8FxVYDYLtR1fv4oMDkjBdMMaZwmEFfLNIbkZTEBXGLbSKI4cva
         fSRHZ50GdkNnIoumKgmHHFIa+80PoUKorcqtfII3ke5iLriQDMlGD3BUP7fFEp6aLeoY
         7qaw==
X-Gm-Message-State: AJcUukd3TAufV/P/za9wQM8qSva/itECAqj4hWok4KfCZFYe4yt43g+K
        TlDTMwf6/jUEBpys9AIvQN603hjmJy4=
X-Google-Smtp-Source: ALg8bN6u0RE0TFupZe+JLHudlYCerYExPaT+DIEd00RhfnI3B2IEAs4y4HzIWR6BfGdep+KNtJhhRA==
X-Received: by 2002:ab0:31d5:: with SMTP id e21mr14129611uan.107.1548913810489;
        Wed, 30 Jan 2019 21:50:10 -0800 (PST)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id r131sm684628vkr.40.2019.01.30.21.50.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 21:50:09 -0800 (PST)
Received: by mail-vk1-f170.google.com with SMTP id t127so480052vke.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 21:50:09 -0800 (PST)
X-Received: by 2002:a1f:e7c5:: with SMTP id e188mr3367673vkh.92.1548913808590;
 Wed, 30 Jan 2019 21:50:08 -0800 (PST)
MIME-Version: 1.0
References: <20190129233426.GA7999@embeddedor> <CAGXu5jJVqbUdF6bVAQYuw9r8emzvy=oJFNJWxM-iSu-t3igeYw@mail.gmail.com>
 <ac8f9634-e298-3daa-e85d-c4b2478ee0a2@embeddedor.com>
In-Reply-To: <ac8f9634-e298-3daa-e85d-c4b2478ee0a2@embeddedor.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 31 Jan 2019 18:49:55 +1300
X-Gmail-Original-Message-ID: <CAGXu5jKphYGcrNm8TGE88ncGJFXQKKruEXGfxNx-F=ZH-xjOeg@mail.gmail.com>
Message-ID: <CAGXu5jKphYGcrNm8TGE88ncGJFXQKKruEXGfxNx-F=ZH-xjOeg@mail.gmail.com>
Subject: Re: [PATCH] lib: zstd: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 12:30 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
>
> On 1/30/19 1:58 AM, Kees Cook wrote:
> > On Wed, Jan 30, 2019 at 12:34 PM Gustavo A. R. Silva
> > <gustavo@embeddedor.com> wrote:
> >>
> >> In preparation to enabling -Wimplicit-fallthrough, mark switch
> >> cases where we are expecting to fall through.
> >>
> >> This patch fixes the following warnings:
> >>
> >> lib/zstd/bitstream.h:261:30: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
> >> lib/zstd/bitstream.h:262:30: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
> >> lib/zstd/bitstream.h:263:30: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
> >> lib/zstd/bitstream.h:264:30: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
> >> lib/zstd/bitstream.h:265:30: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
> >> lib/zstd/compress.c:3183:16: warning: this statement may fall through =
[-Wimplicit-fallthrough=3D]
> >> lib/zstd/decompress.c:1770:18: warning: this statement may fall throug=
h [-Wimplicit-fallthrough=3D]
> >> lib/zstd/decompress.c:2376:15: warning: this statement may fall throug=
h [-Wimplicit-fallthrough=3D]
> >> lib/zstd/decompress.c:2404:15: warning: this statement may fall throug=
h [-Wimplicit-fallthrough=3D]
> >> lib/zstd/decompress.c:2435:16: warning: this statement may fall throug=
h [-Wimplicit-fallthrough=3D]
> >> lib/zstd/huf_compress.c: In function =E2=80=98HUF_compress1X_usingCTab=
le=E2=80=99:
> >> lib/zstd/huf_compress.c:535:5: warning: this statement may fall throug=
h [-Wimplicit-fallthrough=3D]
> >>   if (sizeof((stream)->bitContainer) * 8 < HUF_TABLELOG_MAX * 4 + 7) \
> >>      ^
> >> lib/zstd/huf_compress.c:558:54: note: in expansion of macro =E2=80=98H=
UF_FLUSHBITS_2=E2=80=99
> >>   case 3: HUF_encodeSymbol(&bitC, ip[n + 2], CTable); HUF_FLUSHBITS_2(=
&bitC);
> >>                                                       ^~~~~~~~~~~~~~~
> >> lib/zstd/huf_compress.c:559:2: note: here
> >>   case 2: HUF_encodeSymbol(&bitC, ip[n + 1], CTable); HUF_FLUSHBITS_1(=
&bitC);
> >>   ^~~~
> >> lib/zstd/huf_compress.c:531:5: warning: this statement may fall throug=
h [-Wimplicit-fallthrough=3D]
> >>   if (sizeof((stream)->bitContainer) * 8 < HUF_TABLELOG_MAX * 2 + 7) \
> >>      ^
> >> lib/zstd/huf_compress.c:559:54: note: in expansion of macro =E2=80=98H=
UF_FLUSHBITS_1=E2=80=99
> >>   case 2: HUF_encodeSymbol(&bitC, ip[n + 1], CTable); HUF_FLUSHBITS_1(=
&bitC);
> >>                                                       ^~~~~~~~~~~~~~~
> >> lib/zstd/huf_compress.c:560:2: note: here
> >>   case 1: HUF_encodeSymbol(&bitC, ip[n + 0], CTable); HUF_FLUSHBITS(&b=
itC);
> >>   ^~~~
> >>   AR      lib/zstd//built-in.a
> >>
> >> Warning level 3 was used: -Wimplicit-fallthrough=3D3
> >>
> >> This patch is part of the ongoing efforts to enabling -Wimplicit-fallt=
hrough.
> >>
> >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >> ---
> >>  lib/zstd/bitstream.h    | 5 +++++
> >>  lib/zstd/compress.c     | 1 +
> >>  lib/zstd/decompress.c   | 5 ++++-
> >>  lib/zstd/huf_compress.c | 2 ++
> >>  4 files changed, 12 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/lib/zstd/bitstream.h b/lib/zstd/bitstream.h
> >> index a826b99e1d63..3a49784d5c61 100644
> >> --- a/lib/zstd/bitstream.h
> >> +++ b/lib/zstd/bitstream.h
> >> @@ -259,10 +259,15 @@ ZSTD_STATIC size_t BIT_initDStream(BIT_DStream_t=
 *bitD, const void *srcBuffer, s
> >>                 bitD->bitContainer =3D *(const BYTE *)(bitD->start);
> >>                 switch (srcSize) {
> >>                 case 7: bitD->bitContainer +=3D (size_t)(((const BYTE =
*)(srcBuffer))[6]) << (sizeof(bitD->bitContainer) * 8 - 16);
> >> +                       /* fall through */
> >>                 case 6: bitD->bitContainer +=3D (size_t)(((const BYTE =
*)(srcBuffer))[5]) << (sizeof(bitD->bitContainer) * 8 - 24);
> >> +                       /* fall through */
> >>                 case 5: bitD->bitContainer +=3D (size_t)(((const BYTE =
*)(srcBuffer))[4]) << (sizeof(bitD->bitContainer) * 8 - 32);
> >> +                       /* fall through */
> >>                 case 4: bitD->bitContainer +=3D (size_t)(((const BYTE =
*)(srcBuffer))[3]) << 24;
> >> +                       /* fall through */
> >>                 case 3: bitD->bitContainer +=3D (size_t)(((const BYTE =
*)(srcBuffer))[2]) << 16;
> >> +                       /* fall through */
> >>                 case 2: bitD->bitContainer +=3D (size_t)(((const BYTE =
*)(srcBuffer))[1]) << 8;
> >>                 default:;
> >>                 }
> >> diff --git a/lib/zstd/compress.c b/lib/zstd/compress.c
> >> index f9166cf4f7a9..5e0b67003e55 100644
> >> --- a/lib/zstd/compress.c
> >> +++ b/lib/zstd/compress.c
> >> @@ -3182,6 +3182,7 @@ static size_t ZSTD_compressStream_generic(ZSTD_C=
Stream *zcs, void *dst, size_t *
> >>                                 zcs->outBuffFlushedSize =3D 0;
> >>                                 zcs->stage =3D zcss_flush; /* pass-thr=
ough to flush stage */
> >>                         }
> >> +                       /* fall through */
> >
> > Perhaps reword the existing comment and move it down?
> >
> >>
> >>                 case zcss_flush: {
> >>                         size_t const toFlush =3D zcs->outBuffContentSi=
ze - zcs->outBuffFlushedSize;
> >> diff --git a/lib/zstd/decompress.c b/lib/zstd/decompress.c
> >> index b17846725ca0..269ee9a796c1 100644
> >> --- a/lib/zstd/decompress.c
> >> +++ b/lib/zstd/decompress.c
> >> @@ -1768,6 +1768,7 @@ size_t ZSTD_decompressContinue(ZSTD_DCtx *dctx, =
void *dst, size_t dstCapacity, c
> >>                         return 0;
> >>                 }
> >>                 dctx->expected =3D 0; /* not necessary to copy more */
> >> +               /* fall through */
> >>
> >>         case ZSTDds_decodeFrameHeader:
> >>                 memcpy(dctx->headerBuffer + ZSTD_frameHeaderSize_prefi=
x, src, dctx->expected);
> >> @@ -2375,7 +2376,7 @@ size_t ZSTD_decompressStream(ZSTD_DStream *zds, =
ZSTD_outBuffer *output, ZSTD_inB
> >>                         }
> >>                         zds->stage =3D zdss_read;
> >>                 }
> >> -               /* pass-through */
> >> +               /* fall through */
> >>
> >>                 case zdss_read: {
> >>                         size_t const neededInSize =3D ZSTD_nextSrcSize=
ToDecompress(zds->dctx);
> >> @@ -2404,6 +2405,7 @@ size_t ZSTD_decompressStream(ZSTD_DStream *zds, =
ZSTD_outBuffer *output, ZSTD_inB
> >>                         zds->stage =3D zdss_load;
> >>                         /* pass-through */
> >>                 }
> >> +               /* fall through */
> >
> > Same ("pass-through" exists a couple lines up)
> >
> >>
> >>                 case zdss_load: {
> >>                         size_t const neededInSize =3D ZSTD_nextSrcSize=
ToDecompress(zds->dctx);
> >> @@ -2436,6 +2438,7 @@ size_t ZSTD_decompressStream(ZSTD_DStream *zds, =
ZSTD_outBuffer *output, ZSTD_inB
> >>                                 /* pass-through */
> >>                         }
> >>                 }
> >> +               /* fall through */
> >
> > Same
>
> Yeah. The thing is that the pass-though comment is embedded in two nested=
 blocks of code. And GCC triggers
> a warning if the fall-through comments are not placed at the very bottom =
of the case statement (some people
> dislike this 'feature').
>
> That's the reason why I didn't want to change any of the pass-through com=
ments, and instead added the
> fall-through comments at the bottom of every case.

Okay, that seems fine. Good as-is, then! :)

-Kees

>
> What do you think about this 'feature'?
>
> >
> >>
> >>                 case zdss_flush: {
> >>                         size_t const toFlushSize =3D zds->outEnd - zds=
->outStart;
> >> diff --git a/lib/zstd/huf_compress.c b/lib/zstd/huf_compress.c
> >> index 40055a7016e6..e727812d12aa 100644
> >> --- a/lib/zstd/huf_compress.c
> >> +++ b/lib/zstd/huf_compress.c
> >> @@ -556,7 +556,9 @@ size_t HUF_compress1X_usingCTable(void *dst, size_=
t dstSize, const void *src, si
> >>         n =3D srcSize & ~3; /* join to mod 4 */
> >>         switch (srcSize & 3) {
> >>         case 3: HUF_encodeSymbol(&bitC, ip[n + 2], CTable); HUF_FLUSHB=
ITS_2(&bitC);
> >> +               /* fall through */
> >>         case 2: HUF_encodeSymbol(&bitC, ip[n + 1], CTable); HUF_FLUSHB=
ITS_1(&bitC);
> >> +               /* fall through */
> >>         case 1: HUF_encodeSymbol(&bitC, ip[n + 0], CTable); HUF_FLUSHB=
ITS(&bitC);
> >>         case 0:
> >>         default:;
> >> --
> >> 2.20.1
> >>
> >
> > Otherwise, yup, looks good.
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> >
>
> Thanks
>
> --
> Gustavo



--=20
Kees Cook
