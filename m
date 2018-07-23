Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A56ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E3A20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 09:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQtx9AMF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42E3A20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388222AbeGWKfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 06:35:04 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46255 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388080AbeGWKfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 06:35:03 -0400
Received: by mail-qk0-f195.google.com with SMTP id o2-v6so9734801qkc.13;
        Mon, 23 Jul 2018 02:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=efbnVRUR7iRAArMuxIsJRcpCswVAQzKA//9khjmBDrA=;
        b=WQtx9AMFY006zHiM73sP9jUkQzqLFZZjHaA0PzBk+ZgK86CMEg2tjNLBBaRAlZ6URl
         DcO14v57hlIkFetJuu6hrxfnjSjMZEzFWfQ+upbXklSJmIPbB1xd1Hd33mTQ2+RgvH0s
         FfGXxjfGpX2kvdWJVmj0kBL/O/3a5KqljLQgkmSKtzbr1VLDIN+Sbu129ArK3VPD8ahA
         tOpjTi+jSI++mHRLZ63v1SlxhDgqnxP4lje4dJrNmMWM0m/2NP+7uA9MHs2iTOq8HJyD
         OIPcMpmr22XSYSFrcKVe8SfdRXoHUbQUhhUGti19Jr5oMZucN8WQjCbydmUq1vWVqBoI
         1BWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=efbnVRUR7iRAArMuxIsJRcpCswVAQzKA//9khjmBDrA=;
        b=IWrMeGfEceYx3SkGF3WZzua9byxlQZJNkztxddyL6eIRzIFuf4yID67OG02bd+GY1D
         XAdfewaLE9OunMJyYjs2paDuCRoyKc73fcdQr6eEhVWDCtEJgAXOlSs4VYPed32+5RdM
         +Kf5KzxYqcWgrnqRzl6odmq2mM2/Vb7PLlO3bn48R9Hn6LagkER0/ZPMUcEtwX5WW2zC
         +Sv2pGGg8vL8mhLVNTwet8MeWWl9eR06/LmAiZXvEY7eKchZMMh1Vd2mach8+7Wkalv0
         WsPDvZe2Y0mfHXSjexBBm29ObsOVsxTmwm+J1c+VQCZ4if/kkJZEUmEzspgjW20QH4/O
         isUA==
X-Gm-Message-State: AOUpUlFPiigTUJUz+2ohENxHs4bkGDrMx8eYXavxF2ovkNsxj88V+WuJ
        /nX7p1P9rVyNsVwF4e4D9rQ79d1gms3cOvFfmpQ=
X-Google-Smtp-Source: AAOMgpet3YcR42Bd13zzNFYfyb2Y1j6mhtU5dontrdCSr3RP0ZWlCuENhj3mBFIzsLj6cQXJjIKp8y45lm6k1J8ZXEY=
X-Received: by 2002:a37:2a65:: with SMTP id q98-v6mr10470375qkh.174.1532338484487;
 Mon, 23 Jul 2018 02:34:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Mon, 23 Jul 2018 02:34:43
 -0700 (PDT)
In-Reply-To: <20180722082939.2de739f1@bbrezillon>
References: <20180721200049.7553-1-anders.roxell@linaro.org>
 <a83ff193-be57-f566-cafb-132075025b56@infradead.org> <20180722082939.2de739f1@bbrezillon>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 23 Jul 2018 11:34:43 +0200
X-Google-Sender-Auth: 1kgq8wsrABrxCoJ15lyTe8l6il0
Message-ID: <CAK8P3a1_8OSqyKsbw+m3ZzLWfPqDK4ynG3WoPTk+K2uJJsiq5A@mail.gmail.com>
Subject: Re: [PATCH] drivers/memory/Kconfig: Add CONFIG_OF dependency
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 22, 2018 at 8:29 AM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> +Arnd, Rob and the DT ML.
>
> On Sat, 21 Jul 2018 14:53:47 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
>
>> On 07/21/2018 01:00 PM, Anders Roxell wrote:
>> > JZ4780_NEMC doesn't depend on OF, and if OF isn't enabled we get this
>> > error:
>> > drivers/memory/jz4780-nemc.c: In function =E2=80=98jz4780_nemc_num_ban=
ks=E2=80=99:
>> > drivers/memory/jz4780-nemc.c:72:10: error: implicit declaration of
>> >  function =E2=80=98of_read_number=E2=80=99; did you mean =E2=80=98down=
_read_nested=E2=80=99?
>> >  [-Werror=3Dimplicit-function-declaration]
>> >    bank =3D of_read_number(prop, 1);
>> >           ^~~~~~~~~~~~~~
>> >           down_read_nested
>
> Looks like of.h defines stubs so that people can compile-test without
> CONFIG_OF selected. Maybe we should move of_read_number() and
> of_read_ulong() out of the #ifdef CONFIG_OF section.

That seems fine, though the added dependency seems appropriate
here as well. of_read_number() is rarely used, and for the most part in
powerpc specific code that is guaranteed to have CONFIG_OF enabled,
so it's not that likely to cause many more problems.

> Alternatively, we could patch jz4780-nemc.c to not use of_read_number
> and instead rely on of_read_property_u32_index() +
> of_property_count_elems_of_size() + of_n_{addr,size}_cells():

That seems noticeably longer for no good reason, I'd go with either
the header file change you suggested or Anders' patch.

       Arnd
