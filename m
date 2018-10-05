Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4813C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C06020875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 19:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A5ZwVVCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C06020875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbeJFCNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 22:13:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36270 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbeJFCNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 22:13:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id y16so14602069wrw.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 12:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sdpbSWqVxxATFOTM+th+JlVkcdQW8j/qVBFdj3PvebQ=;
        b=A5ZwVVCgW5kIJ5Pqo/lVRjpSvXxTqQENFwQsGhsWyEMHYcm6w1jHw8h2WhxTPQGU+0
         gFQ+BPxZCvrxsquHrqlpi2lHxcCWWTz6J2mJ2dtFCp8Ta9YMkw+V2JJBPIXG0elFuMx+
         /RWpmU4AMbh2GYfR26Lv9ZSJB368ycgNHiZN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sdpbSWqVxxATFOTM+th+JlVkcdQW8j/qVBFdj3PvebQ=;
        b=uRvb/tPMiFGrhjq0aDe/OMl0g/lbXxF727y1NhdeZqEuEw7Ea3P0dK7xOXgy9yynL9
         3IWVm1GOCh5fGDbglMq7JQa1kWhCRWBuk/bjUXnJiWZOj1CYBju8YJ9OZaWO2IrcICvf
         ZeucqxI7DVnGqzOvu3O9/18WKj2qCMQOCUATCjrzg4E3oHQ3O96F4DZL4lmbrNzElryK
         HFcMlU8xCDNEGVmpVw0EkmyniGcKyYrYjvXasrAh33wkqc55Imh1MEQh0vQYdGQTHQKR
         y26GVeJ0IRSP3aN8kH7yI37ibMKa7rjyYgjKiOdRCUNa0dbV/qTJuv3t4DxL4wgJh1tq
         g53g==
X-Gm-Message-State: ABuFfoh3CRKMHkll9ZiJS6uoMTB4AbgvavHXVxCMOQGPhQs26aFiPsJh
        T/uRByfdfhuE7OEQPH3xFFjVZg==
X-Google-Smtp-Source: ACcGV63nW64IxxBk5S+d0rq46sRa+52vihM6ZORtYaMwXrFL0ms/S8j0mDY7oCvN+M69ZGg1LZjNLg==
X-Received: by 2002:adf:b743:: with SMTP id n3-v6mr9445850wre.274.1538766791049;
        Fri, 05 Oct 2018 12:13:11 -0700 (PDT)
Received: from [100.89.214.43] (26.202.154.77.rev.sfr.net. [77.154.202.26])
        by smtp.gmail.com with ESMTPSA id h63-v6sm2732947wmf.31.2018.10.05.12.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 12:13:10 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 1/9] kernel: add support for patchable function pointers
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <CAHmME9pcQF=FvKRuxnqrJ5R1pvtUVbx3DXvXiUX5HywS2Xgj3A@mail.gmail.com>
Date:   Fri, 5 Oct 2018 21:13:08 +0200
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>, Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, benh@kernel.crashing.org,
        paulus@samba.org, Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, richard@nod.at,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E75F755E-E447-4302-BFBD-095FC45B991E@linaro.org>
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org> <20181005081333.15018-2-ard.biesheuvel@linaro.org> <20181005141433.GS19272@hirez.programming.kicks-ass.net> <9E0E08C8-0DFC-4E50-A4FA-73208835EF9E@amacapital.net> <CAKv+Gu9z503ZJXcsG+9Ys240BZiB-+GB=kNY4VGWpjvdzN4JtA@mail.gmail.com> <CALCETrWaewXsdJsf3SocgZ0ggnvZk86L+5-LWPRbjdnG2mB7jw@mail.gmail.com> <CAKv+Gu-oHBtgGbWXJu6+z4+BNhBZyY5VvF_v6cJJUGk_5YX1eQ@mail.gmail.com> <CALCETrU=fm+ZG4WZJfG-5GwL7kv5_GS1aZYu=L42d5BuSbhJDQ@mail.gmail.com> <CAKv+Gu8eHPEsUbkhN=61z9FvhdCo2e3VOdemp4g0bzdO1EJFYQ@mail.gmail.com> <CALCETrVMBULVP9qEQDVuisxAMzdheM1qQ97AZFs-xcO0eaXiiA@mail.gmail.com> <CAHmME9pgJ_2GGDUVsbQXcNRfh3yACqFG+5uemFRMZkb8LdH95g@mail.gmail.com> <CALCETrWjCY2Wceiqu99C+g5RdnrZuRujYO_+jBvuJFRB1LTG4w@mail.gmail.com> <CAHmME9pcQF=FvKRuxnqrJ5R1pvtUVbx3DXvXiUX5HywS2Xgj3A@mail.gmail.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 5 Oct 2018, at 20:28, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>=20
> Hey Andy,
>=20
>> On Fri, Oct 5, 2018 at 7:44 PM Andy Lutomirski <luto@kernel.org> wrote:
>> I *think* the only change to Zinc per se would be that the calls like
>> chacha20_simd() would be static calls or patchable functions or
>> whatever we want to call them.  And there could be a debugfs to
>> override the default selection.
>=20
> Yea, right, exactly. It turns out this is really easy to do with the
> way it's structured now. I'd actually experimented considerably with
> using the static keys a while back, but couldn't find any performance
> difference on any platform at all (four ARM microarchitectures, three
> MIPS, various random intel, an old powerpc), so went with the simplest
> solution. But we can certainly play with more elaborate patching
> mechanisms later on and see how those turn out. Also, even with the
> simple bools as we have now, it's quite easy to make all the
> parameters toggle-able.
>=20
>> Ard, I don't think that sticking this in udev rules makes sense.  The
>> kernel has bascially complete information as to what the right choice
>> is, and that will change over time as the implementation gets tuned,
>> and the udev rules will never get updated in sync.
>=20
> Yes, I agree with this.
>=20
>=20

I am not referring to udev rules. I just mean the current way that udev auto=
loads modules based on CPU features.=
