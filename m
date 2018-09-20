Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_DBL_ABUSE_MALW autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F81C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E132150F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E132150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeITVqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:46:34 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:33202 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeITVqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 17:46:34 -0400
Received: by mail-qt0-f194.google.com with SMTP id r37-v6so9021973qtc.0;
        Thu, 20 Sep 2018 09:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nytyfi0fTlhxOobRdAPgJCStcxil1PT8fPInJa34k8E=;
        b=ZMdI7JaSIwpvs1jBhA5QSoFqfBb47fkOGieesF1nil1pSUeUbaoQkuAorGGCSI139/
         xNQmX1tRqaaD8Fdm+jbUXyRCKzi1wAoVwmoAl0pRkkbSZ6DdgesjtkWeLkdnwr2je0vv
         B7IoXstwtj9qH9LfJ6OSN4a4WHUy0wi2e6Yj6jQ7w3SH+M5+Bkp3JIyF6BWXNPB40pJs
         7vNez5dBGcfqbs/9z2T8r9qNKFXBoq2g9ekY2Y68KqofGkmMd3P+Bsl6Qi6HhDcTzitP
         8Hj7TyaQysESVfalVxv7LYmFTmy/izLP1Ex0oE3FAi8VOy/QDAAP4M+VR7JH1sOh3aKJ
         ewkA==
X-Gm-Message-State: APzg51CglTJw8Dn++Rj4YbkwAAYVwI0Ml2KTkg5RK+eQxVbZpbp16ldR
        22ePopwoWaVX3j08WkBVEoA1qBJuTaTBhucW88I=
X-Google-Smtp-Source: ANB0VdaexVRvnVlnNnFQvjYzpfiPu94uwIff2F0kSzArFF04oEe8ZLNGOcIsIpxP9KYmuTKtehxhmeuvk892TcMwwiQ=
X-Received: by 2002:a0c:c171:: with SMTP id i46-v6mr28666936qvh.40.1537459344431;
 Thu, 20 Sep 2018 09:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-3-Jason@zx2c4.com>
 <CAKv+Gu-0oTBrg3T8TsNYPOdrmJSSC313-CYASO34kb_nviva6A@mail.gmail.com>
In-Reply-To: <CAKv+Gu-0oTBrg3T8TsNYPOdrmJSSC313-CYASO34kb_nviva6A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 Sep 2018 09:02:07 -0700
Message-ID: <CAK8P3a0CS3QzEKEV5==qj8hUYgW+q2v1f13jA+s0TjQd8kYXFA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 02/20] zinc: introduce minimal cryptography library
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, David Miller <davem@davemloft.net>,
        gregkh <gregkh@linuxfoundation.org>, sneves@dei.uc.pt,
        Andy Lutomirski <luto@kernel.org>,
        jeanphilippe.aumasson@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 8:41 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> (+ Arnd, Eric)
>
> On 18 September 2018 at 09:16, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> ...
>
> > diff --git a/lib/zinc/Makefile b/lib/zinc/Makefile
> > new file mode 100644
> > index 000000000000..83dfd63988c0
> > --- /dev/null
> > +++ b/lib/zinc/Makefile
> > @@ -0,0 +1,4 @@
>
> Apologies for not spotting these before:
>
> > +ccflags-y := -O3
>
> -O3 optimization has been problematic in the past, at least on x86 but
> I think on other architectures as well. Please stick with -O2.
>
> > +ccflags-y += -Wframe-larger-than=$(if (CONFIG_KASAN),16384,8192)
>
> There is no way we can support code in the kernel with that kind of
> stack space requirements. I will let Arnd comment on what we typically
> allow, since he deals with such issues on a regular basis.

Right, if you hit a stack requirement like this, it's usually the compiler
doing something bad, not just using too much stack but also generating
rather slow object code in the process. It's better to fix the bug by
optimizing the code to not spill registers to the stack.

In the long run, I'd like to reduce the stack frame size further, so
best assume that anything over 1024 bytes (on 32-bit) or 1280 bytes
(on 64-bit) is a bug in the code, and stay below that.

For prototyping, you can just mark the broken functions individually
by setting the warning limit for a specific function that is known to
be misoptimized by the compiler (with a comment about which compiler
and architectures are affected), but not override the limit for the
entire file.

       Arnd
