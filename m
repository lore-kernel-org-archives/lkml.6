Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A1BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A3E21537
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 00:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ldyGK/3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A3E21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388780AbeIUF6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 01:58:04 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:57769 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbeIUF6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 01:58:04 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id d94cd457;
        Thu, 20 Sep 2018 23:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=68QzLuBMy3Wmpn8zaTvNKarwaok=; b=ldyGK/
        3y2o5/1+tFiI573cT958zqOf4fI49Z/KHjwyuCf/3V1mI/pKs7cHtg4hSZdlK+KM
        SGzWPnb+OX/u4QTIHN3fiTQr8n6mjmKKdASmrhkX2g3DYH0E9LYylQmYTDevrKTR
        g3f8Suh3g3C1BlWiBaOdhL/98mem93Foww6qjIq50FS9Q68QZztuWst/zHgAEgcs
        l9vdiYvdghzMvybKaizt3zy9gv6VCtUlIWdG8PqxXasvoaMw4NHqJ2DBzS7dqfO5
        E2/EFwGnAueLeNxAVCANnbyPxYDtKyZMJFe5uyWr8P60vuvACTm+OF02jcq4gAea
        sx/bEex/RSnI43Lg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2e0b2dbc (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Thu, 20 Sep 2018 23:54:04 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id 36-v6so11280492oth.11;
        Thu, 20 Sep 2018 17:11:55 -0700 (PDT)
X-Gm-Message-State: APzg51Df7+ctAifO2mXfz7r0rvmlGUSTzIBNPqFZBS/TlEyopTxowlrh
        NDGx/qPR1++N+cbVyi9GaXro9dLw3Qk3fv0DS0o=
X-Google-Smtp-Source: ANB0VdY4FETggX6Zriz/1zOay3g8AhgG9ONUM1Y8wx1GY768pLEswBTCpYIY7l6cf9EIbhhuUuFeWqlbKgB3cJx3Los=
X-Received: by 2002:a9d:56b6:: with SMTP id o51-v6mr22536761oth.393.1537488714434;
 Thu, 20 Sep 2018 17:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-3-Jason@zx2c4.com>
 <CAKv+Gu-0oTBrg3T8TsNYPOdrmJSSC313-CYASO34kb_nviva6A@mail.gmail.com> <CAK8P3a0CS3QzEKEV5==qj8hUYgW+q2v1f13jA+s0TjQd8kYXFA@mail.gmail.com>
In-Reply-To: <CAK8P3a0CS3QzEKEV5==qj8hUYgW+q2v1f13jA+s0TjQd8kYXFA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 21 Sep 2018 02:11:43 +0200
X-Gmail-Original-Message-ID: <CAHmME9rJq=q7xj_E_84GN5FuzSW2KdP4Ch=y527Lem0ME4GnLg@mail.gmail.com>
Message-ID: <CAHmME9rJq=q7xj_E_84GN5FuzSW2KdP4Ch=y527Lem0ME4GnLg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 02/20] zinc: introduce minimal cryptography library
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Arnd,

On Thu, Sep 20, 2018 at 6:02 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Right, if you hit a stack requirement like this, it's usually the compiler
> doing something bad, not just using too much stack but also generating
> rather slow object code in the process. It's better to fix the bug by
> optimizing the code to not spill registers to the stack.
>
> In the long run, I'd like to reduce the stack frame size further, so
> best assume that anything over 1024 bytes (on 32-bit) or 1280 bytes
> (on 64-bit) is a bug in the code, and stay below that.
>
> For prototyping, you can just mark the broken functions individually
> by setting the warning limit for a specific function that is known to
> be misoptimized by the compiler (with a comment about which compiler
> and architectures are affected), but not override the limit for the
> entire file.

Thanks for the explanation. Fortunately in my case, the issues were
trivially fixable to get it under 1024/1280. (By the way, why does
64-bit have a slightly larger stack frame? To account for 32 pointers
taking double the space or something?) That will be rectified in v6.

There is one exception though: sometimes KASAN bloats the frame on
64-bit compiles. How would you feel about me adding
'ccflags-$(CONFIG_KASAN) += -Wframe-larger-than=16384' in my makefile?
I'm not remotely close to reaching that limit (it's just a tiny bit
over 1280), but it does seem like telling gcc to quiet down about
stack frames when KASAN is being used might make sense. Alternatively,
I see the defaults for FRAME_WARN are:

config FRAME_WARN
       int "Warn for stack frames larger than (needs gcc 4.4)"
       range 0 8192
       default 3072 if KASAN_EXTRA
       default 2048 if GCC_PLUGIN_LATENT_ENTROPY
       default 1280 if (!64BIT && PARISC)
       default 1024 if (!64BIT && !PARISC)
       default 2048 if 64BIT

What about changing that KASAN_EXTRA into just KASAN? This seems
cleanest; I'll send a patch for it.

On the other hand, this KASAN behavior is only observable on 64-bit
systems when I force it to be 1280, whereas the default is still 2048,
so probably this isn't a problem *now* for this patchset. But it is
something to think about for down the road when you lower the default
frame.

Regards,
Jason
