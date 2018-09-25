Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA53EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645B6208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 07:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645B6208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbeIYNYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 09:24:33 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38572 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727610AbeIYNYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 09:24:33 -0400
Received: by mail-qt1-f195.google.com with SMTP id z13-v6so12290374qts.5;
        Tue, 25 Sep 2018 00:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5opeZDIW/aBS2WE6Df8E63v4NjZqkMq4Cti9GJcXV6s=;
        b=Y4YilAsmSGI7/EBuHACdVkq6e4jOzUYmcJp+wB8HXuOEUVDBpUrzmR9vuBhc0VdD/c
         UBRl4JgNScp7/vFaeuHSEHTZqmyc+bwbYUlA3/hvp/yRZa/pm0iyiOJ+GcBO2Y4GVzR1
         /7/cYAIWKtPFz+XQksIqgQuMnIBM1z6KyJoduDgDjlMivXvu2Zh3c26RAn4wq18fQMpz
         hIqDW75OFwsPii+sghbphy9O9fd4U5M0XqMOefQAZBKSsQJsJNizJK0m8NX3JmEnwvze
         NFyrQFyeYSUGSyFeLDg5kYJ8g9VQalH2bdO3UV7MdN90D6i6xWPxqLnqS6vf9cIUNh9z
         5S6Q==
X-Gm-Message-State: ABuFfohNddg+1YMYFMU5Qw5MX1+ycJ8QFmb3W6P5pkZezcsSJYVe5NiW
        9NwJpqDZME5gPVgiQDwA+qzC2PnLP9Y/ztW4ljk=
X-Google-Smtp-Source: ACcGV61WFJ1eAH6BKHw3ALlDzxXHlKszYbskN+sHjA8HhcLapgfL0XaHKWduaZkYyliUbIjtMq2B5JetK+TDiywETl8=
X-Received: by 2002:ac8:7254:: with SMTP id l20-v6mr1791087qtp.213.1537859901931;
 Tue, 25 Sep 2018 00:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-3-Jason@zx2c4.com>
 <CAKv+Gu-0oTBrg3T8TsNYPOdrmJSSC313-CYASO34kb_nviva6A@mail.gmail.com>
 <CAK8P3a0CS3QzEKEV5==qj8hUYgW+q2v1f13jA+s0TjQd8kYXFA@mail.gmail.com>
 <CAHmME9rJq=q7xj_E_84GN5FuzSW2KdP4Ch=y527Lem0ME4GnLg@mail.gmail.com> <CAK8P3a2VL16mtyq0HjNOXuSp8YJXik4J9Z_aPzksmTAbFB+=_g@mail.gmail.com>
In-Reply-To: <CAK8P3a2VL16mtyq0HjNOXuSp8YJXik4J9Z_aPzksmTAbFB+=_g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 25 Sep 2018 09:18:05 +0200
Message-ID: <CAK8P3a3j0eqAPc-Vkp7YFxT56R2-LrqL_EcULQFam5Bm93gPyw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 02/20] zinc: introduce minimal cryptography library
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 6:11 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Sep 20, 2018 at 5:12 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > Hey Arnd,
> >
> > On Thu, Sep 20, 2018 at 6:02 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > Right, if you hit a stack requirement like this, it's usually the compiler
> > > doing something bad, not just using too much stack but also generating
> > > rather slow object code in the process. It's better to fix the bug by
> > > optimizing the code to not spill registers to the stack.
> > >
> > > In the long run, I'd like to reduce the stack frame size further, so
> > > best assume that anything over 1024 bytes (on 32-bit) or 1280 bytes
> > > (on 64-bit) is a bug in the code, and stay below that.
> > >
> > > For prototyping, you can just mark the broken functions individually
> > > by setting the warning limit for a specific function that is known to
> > > be misoptimized by the compiler (with a comment about which compiler
> > > and architectures are affected), but not override the limit for the
> > > entire file.
> >
> > Thanks for the explanation. Fortunately in my case, the issues were
> > trivially fixable to get it under 1024/1280
>
> A lot of these bugs are not trivial, but we still need a full analysis of what
> failed and what the possible mititgations are. Can you describe more
> specifically what causes it?

I think I misread your earlier sentence and thought you had said the
exact opposite.

For confirmation, I've downloaded your git tree and built it with my
collection of compilers (gcc-4.6 through 8.1) and tried building it
in various configurations. Nothing alarming stood out, the only
thing that I think would might warrant some investigation is this one:

lib/zinc/curve25519/curve25519-hacl64.h: In function 'curve25519_generic':
lib/zinc/curve25519/curve25519-hacl64.h:785:1: warning: the frame size
of 1536 bytes is larger than 500 bytes [-Wframe-larger-than=]

Without KASAN, this takes 832 bytes, which is still more than it should
use from a look at the source code.

I first suspected some misoptimization around the get/put_unaligned_le64()
calls, but playing around with it some more led me to this patch:

diff --git a/lib/zinc/curve25519/curve25519-hacl64.h
b/lib/zinc/curve25519/curve25519-hacl64.h
index c7b2924a68c2..1f6eb5708a0e 100644
--- a/lib/zinc/curve25519/curve25519-hacl64.h
+++ b/lib/zinc/curve25519/curve25519-hacl64.h
@@ -182,8 +182,7 @@ static __always_inline void
fmul_mul_shift_reduce_(u128 *output, u64 *input,

 static __always_inline void fmul_fmul(u64 *output, u64 *input, u64 *input21)
 {
-       u64 tmp[5];
-       memcpy(tmp, input, 5 * sizeof(*input));
+       u64 tmp[5] = { input[0], input[1], input[2], input[3], input[4] };
        {
                u128 b4;
                u128 b0;

That change gets it down to

lib/zinc/curve25519/curve25519-hacl64.h: In function 'curve25519_generic':
lib/zinc/curve25519/curve25519-hacl64.h:788:1: warning: the frame size
of 640 bytes is larger than 500 bytes [-Wframe-larger-than=]

with KASAN, or 496 bytes without it. This indicates that there might
be something wrong with either gcc-8 or with our fortified memset()
function that requires more investigation. Maybe you can see
something there that I missed.

        Arnd
