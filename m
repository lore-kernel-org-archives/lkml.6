Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33C9C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF3620825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CilEVoYo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF3620825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387925AbeKFETI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:19:08 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:34762 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387907AbeKFETI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:19:08 -0500
Received: by mail-it1-f194.google.com with SMTP id t189-v6so8447689itf.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 10:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=PJ0xWYpcXqt9aEpU0k0lrUjeZxIr8u8feCW2IDN9bbw=;
        b=CilEVoYoeHnC3DgaGhwfyA+xIs3N9murIZXKZIeMCbjW8l0IWhtQeSFxm2rmdU+M/r
         i0nebEN/6OTEQqZZQlz8zx1yCx/azHfgKqMAY3QRmBg34ShE476h0BVoTkMn9iRLJqfT
         WIQpVber7qrz+Lzlr5SVGPOExu9fj2NzMKp/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=PJ0xWYpcXqt9aEpU0k0lrUjeZxIr8u8feCW2IDN9bbw=;
        b=uP6C66t+LP5IEqmpWH4jG9loiSgH6e7xfXZKjq9Nf1f2BnAPmjsqo9s8hCdHFB92e5
         lq36alB3dNvwRiFEEQLUak+tACdBlAp5mbOTIQgBCzJTQqWtxR/jvDDwxME0+l5kC6nC
         zcHOeIs7xEQ2T4+yXPdXJrIk9fKdvTfjS21gRWRUP/laoabTzX6k+KxZVTO++Bkq9erq
         Ii7Ye02ISMm/6xZRZluSFvlYBnfY6FxYy+klbKzJ99dhrFWvZkwMGT43CkWleSNKEdnn
         IwHJlYWuHgae2BMB9mzwyDW+xulsgoYFEL1UVJjKU7097PqruaykrHtMaku53Zv2iGS/
         2LRQ==
X-Gm-Message-State: AGRZ1gJQ/pQ0v8QW7/PBgueM8/t3XWBMnvR2UP2fZ9Uu0rNTD0wKCtd+
        ukl7GY9BuLrvgZgmdwJbyMy3X+m36h5zA354rSvEUrfu
X-Google-Smtp-Source: AJdET5eh5FTkUuHEV2MmhigSvfOIi4mM0IY88AI9IsxqKgyaK/XNc1oFRgq84e37bR32TwSsxLCBeSpcyQyEizlY6sA=
X-Received: by 2002:a02:9f85:: with SMTP id a5-v6mr21553083jam.2.1541444285995;
 Mon, 05 Nov 2018 10:58:05 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 10:58:05 -0800 (PST)
In-Reply-To: <20181105182314.c7xdsolvxr2iyd5n@sole.flsd.net>
References: <20181024032356.3388-1-vt@altlinux.org> <20181024032356.3388-2-vt@altlinux.org>
 <CAKv+Gu9LSUNwW_3E3QtxV123u=mU-B+p6FFRAkWq8_e9Jsgb2w@mail.gmail.com> <20181105182314.c7xdsolvxr2iyd5n@sole.flsd.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 5 Nov 2018 19:58:05 +0100
Message-ID: <CAKv+Gu_uahQEP-4mc10KQThQM6rTF4o5xqi6YgEq8Od87x3KgQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] crypto: streebog - add Streebog hash function
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 November 2018 at 19:23, Vitaly Chikunov <vt@altlinux.org> wrote:
> Ard,
>
> On Mon, Nov 05, 2018 at 02:22:21PM +0100, Ard Biesheuvel wrote:
>>
>> > +static const struct streebog_uint512 buffer512 = { {
>> > +       cpu_to_le64(0x200ULL),
>>
>> Can we keep the memory representation in native endianness, and only
>> swab the in/output [where needed]?
>
> I hope you do not insist on that?
>
> The code is using same primitives to add/xor/permute with data from
> these arrays (buffer512[] and C[], those which use cpu_to_le64), and
> from generic data buffers. Having these arrays in native endianness will
> cause complexities - code split and duplications. For example, XLPS
> permutation will require two versions, with one accessing (y) as is and
> another as cpu_to_le64(y).
>
> The code is based on canonical implementation by RFC 6986 ("GOST R
> 34.11-2012: Hash Function") author, and I don't want it do deviate that
> much from the original, which would complicate algorithm reviews.
>

That is a very good reason, so unless anyone has concerns about the
performance on BE systems, let's leave it as is.
