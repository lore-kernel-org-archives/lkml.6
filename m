Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEF4C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CBB20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="iVsE2iZE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ULv6cSEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23CBB20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754433AbeFTSQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:16:15 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36183 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754199AbeFTSQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:16:13 -0400
Received: by mail-yw0-f193.google.com with SMTP id t198-v6so182811ywc.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 11:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=OwDuo9ERcKx4uU7IYfT0+Yz4INVzG+xx39q61sRaS5M=;
        b=iVsE2iZE26h1FAZpWw4Oz72DAfXOWuxdWrO519oTjfKzbKlVH/wOfsOdMMFEY0NzOu
         2GWNUxyMHa37DuzAn1XxSOubkO/5MIll3jvlLKfMJPyFtf93qAYWueS1J0zrIu8/rOvz
         Rkw0ybb8R6cFpV7aOT0FcF+Gc9KIIDYemt7r/L11eUoJlErYOJTWK8ZQ982SLaFEY5m4
         3uZjldrAs8YXIp+TLIk2sJdgcSmOsjpMyr16FAVwUWPE/950WigTu1/nHsS5fO5ct2zK
         oiAU3rHw8nhaTScLxD9rHPnJZlge0OInQCMezA7Jn2DbAKmG73DScWopCcKMYwzC0dO0
         HCuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=OwDuo9ERcKx4uU7IYfT0+Yz4INVzG+xx39q61sRaS5M=;
        b=ULv6cSEdllZ0UKcewasNk4Z2bmFtl8UmLR0FNiK2OI2eAoclEvH6Gn0J2b2ztPoNyw
         x///5tzEf/WYfHeABn3YvfUeMJvRE6K+o2mOaILYYaMRfnU2Cmbb+6MLs8XIJLdfBKRb
         dn69t+Oi5mxMtdkukXBeQke/hPsPHApjkB7uY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=OwDuo9ERcKx4uU7IYfT0+Yz4INVzG+xx39q61sRaS5M=;
        b=Y6SPNCEkFerdOusjMki1gskkGZBeMH8+8x90SvDiFoPIHI2N7ppa7pb7J/WMcU8pi2
         FTYarMJy6x3+BU3lB/3dRXrSo3LmSOyEw9yhrG0agYchfCwxB0Pb2jqugoAxQYEVztAu
         YD1wZEBzcKU+nD1ZM4x9LgEjXb3YbGwhioAh6oIDAYFNI0wwShz2hEwYOXyfZwCRVk7P
         CM4BMK9oNZjnioTnCEcyTKKBKK5ZnBS+3ZUc4JYfwbZ35/yFKjekuBY2AINsep2dYe++
         fCuMxO8X+l57RMFSzeYjxnGTgavghb2g5M4D7VhQu4yBpDnvYheyh1HX6nV5hn047Bz8
         MIYw==
X-Gm-Message-State: APt69E0uV9X5Af9X/dboymfyq3ZR7EwZrlZFHhrhOAp0ZIIOC9OwaAtc
        FmaWjUCff6kdQW60n3OTMYhdfuMHEBOFBZfeXn6BEQ==
X-Google-Smtp-Source: ADUXVKJtCDiPhwHGsI36w3uFq2N0MkVIVCbpQfe77m9zRF2xOGlAi73bdQjlFTPX5Wu8icji6z6vWjNeXjkZXnV/3K4=
X-Received: by 2002:a81:3050:: with SMTP id w77-v6mr10293621yww.88.1529518572963;
 Wed, 20 Jun 2018 11:16:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 11:16:11
 -0700 (PDT)
In-Reply-To: <20180620093805.6d9c602e@bbrezillon>
References: <20180531184525.GA11068@beast> <20180601110921.GC4695@parrot.com>
 <CAGXu5jJVX5tk3w5etreTPJpoEzXfF9bFD4GNNW69yRHZTEBYiA@mail.gmail.com> <20180620093805.6d9c602e@bbrezillon>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Jun 2018 11:16:11 -0700
X-Google-Sender-Auth: X6GXz9uU3GbcCHNQDQEhBLVYL70
Message-ID: <CAGXu5j+A4jXuf_TO0UF0zp-7kHUEFP8FZY=+mat96CaQ-a87LQ@mail.gmail.com>
Subject: Re: [PATCH v3] lib/bch: Remove VLA usage
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Ivan Djelic <ivan.djelic@parrot.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Linux mtd <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 12:38 AM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> Hi Kees,
>
> On Tue, 19 Jun 2018 16:48:17 -0700
> Kees Cook <keescook@chromium.org> wrote:
>
>> On Fri, Jun 1, 2018 at 4:09 AM, Ivan Djelic <ivan.djelic@parrot.com> wro=
te:
>> > On Thu, May 31, 2018 at 11:45:25AM -0700, Kees Cook wrote:
>> >> In the quest to remove all stack VLA usage from the kernel[1], this
>> >> allocates a fixed size stack array to cover the range needed for
>> >> bch. This was done instead of a preallocation on the SLAB due to
>> >> performance reasons, shown by Ivan Djelic:
>> >>
>> >>  little-endian, type sizes: int=3D4 long=3D8 longlong=3D8
>> >>  cpu: Intel(R) Core(TM) i5 CPU         650  @ 3.20GHz
>> >>  calibration: iter=3D4.9143=C2=B5s niter=3D2034 nsamples=3D200 m=3D13=
 t=3D4
>> >>
>> >>    Buffer allocation |  Encoding throughput (Mbit/s)
>> >>  ---------------------------------------------------
>> >>   on-stack, VLA      |   3988
>> >>   on-stack, fixed    |   4494
>> >>   kmalloc            |   1967
>> >>
>> >> So this change actually improves performance too, it seems.
>> >>
>> >> The resulting stack allocation can get rather large; without
>> >> CONFIG_BCH_CONST_PARAMS, it will allocate 4096 bytes, which
>> >> trips the stack size checking:
>> >>
>> >> lib/bch.c: In function =E2=80=98encode_bch=E2=80=99:
>> >> lib/bch.c:261:1: warning: the frame size of 4432 bytes is larger than=
 2048 bytes [-Wframe-larger-than=3D]
>> >>
>> >> Even the default case for "allmodconfig" (with CONFIG_BCH_CONST_M=3D1=
4 and
>> >> CONFIG_BCH_CONST_T=3D4) would have started throwing a warning:
>> >>
>> >> lib/bch.c: In function =E2=80=98encode_bch=E2=80=99:
>> >> lib/bch.c:261:1: warning: the frame size of 2288 bytes is larger than=
 2048 bytes [-Wframe-larger-than=3D]
>> >>
>> >> But this is how large it's always been; it was just hidden from
>> >> the checker because it was a VLA. So the Makefile has been adjusted t=
o
>> >> silence this warning for anything smaller than 4500 bytes, which shou=
ld
>> >> provide room for normal cases, but still low enough to catch any futu=
re
>> >> pathological situations.
>> >>
>> >> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=3Dq=
PXydAacU1RqZWA@mail.gmail.com
>> >>
>> >> Signed-off-by: Kees Cook <keescook@chromium.org>
>> >> ---
>> >> v3: fix r_bytes to whole-word size
>> >> v2: switch to fixed-size stack array
>> >> ---
>> >>  lib/Makefile |  1 +
>> >>  lib/bch.c    | 23 +++++++++++++++--------
>> >>  2 files changed, 16 insertions(+), 8 deletions(-)
>> >
>> >
>> > The patch looks good to me. It also passed my regression tests.
>> >
>> > Reviewed-by: Ivan Djelic <ivan.djelic@parrot.com>
>> > Tested-by: Ivan Djelic <ivan.djelic@parrot.com>
>>
>> Thanks for the review and testing!
>>
>> Who's the best person to carry this patch?
>
> Looks like all users of this lib are in drivers/mtd, so I can take the
> patches if you want, but I can also let you take them if you prefer.

I'd love it if you could take it; thank you!

-Kees

--=20
Kees Cook
Pixel Security
