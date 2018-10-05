Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03E1C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71352148D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogbD5313"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71352148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbeJFA0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:26:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbeJFA0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:26:03 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB5DB2147D
        for <linux-kernel@vger.kernel.org>; Fri,  5 Oct 2018 17:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538760382;
        bh=BtUlJXPxzROTLh5ruMHdsHXX1cniMwLqNEy6YBOxFLs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ogbD53136bMyzbUp+AM5lY86M5wI4GC/2eqIE5nF/p9BR8+YU3qEI24enlHUImd+q
         9VqU9PDHVrk6rVGLNNpQkQIEB+qE3rHEsqj7byjxw4Uaujs97vuzCA6VbNiMjafP3Y
         kkIGCzpCEFlTKHOQpIFhcZWVYqWLvVc6+x7Hqh00=
Received: by mail-wr1-f54.google.com with SMTP id e4-v6so14364115wrs.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 10:26:21 -0700 (PDT)
X-Gm-Message-State: ABuFfohq6CKEQBBiFuMFdL8TJUPqD28x0gQ8o84imGdWXYdK/F06OrfM
        36e6jAQGiFnKQ8PdQzetRIjZpeLcIZcMaIW0Z6hANw==
X-Google-Smtp-Source: ACcGV63+AuOHy0b95rEYlVpCtCt0DDMWrn3Jmw20yMApLh17Axv0MfvrRS34XYxbDPUkWS2zSyBBjpgjCwN+kPowR7I=
X-Received: by 2002:adf:82e3:: with SMTP id 90-v6mr8597642wrc.131.1538760380286;
 Fri, 05 Oct 2018 10:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181005081333.15018-1-ard.biesheuvel@linaro.org>
 <20181005133705.GA4588@zx2c4.com> <CAKv+Gu-f4uKBF=gtFcNJEeoC2L4qShX0+3p7kVhjTn0tR+3Gng@mail.gmail.com>
In-Reply-To: <CAKv+Gu-f4uKBF=gtFcNJEeoC2L4qShX0+3p7kVhjTn0tR+3Gng@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 5 Oct 2018 10:26:08 -0700
X-Gmail-Original-Message-ID: <CALCETrVxv1fHt6WE4ZpvVEwtfsKQ19gRrhhA40zwCXGMk+DTLQ@mail.gmail.com>
Message-ID: <CALCETrVxv1fHt6WE4ZpvVEwtfsKQ19gRrhhA40zwCXGMk+DTLQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] patchable function pointers for pluggable crypto routines
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 10:15 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On 5 October 2018 at 15:37, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> ...
> > Therefore, I think this patch goes in exactly the wrong direction. I
> > mean, if you want to introduce dynamic patching as a means for making
> > the crypto API's dynamic dispatch stuff not as slow in a post-spectre
> > world, sure, go for it; that may very well be a good idea. But
> > presenting it as an alternative to Zinc very widely misses the point and
> > serves to prolong a series of bad design choices, which are now able to
> > be rectified by putting energy into Zinc instead.
> >
>
> This series has nothing to do with dynamic dispatch: the call sites
> call crypto functions using ordinary function calls (although my
> example uses CRC-T10DIF), and these calls are redirected via what is
> essentially a PLT entry, so that we can supsersede those routines at
> runtime.

If you really want to do it PLT-style, then just do:

extern void whatever_func(args);

Call it like:
whatever_func(args here);

And rig up something to emit asm like:

GLOBAL(whatever_func)
  jmpq default_whatever_func
ENDPROC(whatever_func)

Architectures without support can instead do:

void whatever_func(args)
{
  READ_ONCE(patchable_function_struct_for_whatever_func->ptr)(args);
}

and patch the asm function for basic support.  It will be slower than
necessary, but maybe the relocation trick could be used on top of this
to redirect the call to whatever_func directly to the target for
architectures that want to squeeze out the last bit of performance.
This might actually be the best of all worlds: easy implementation on
all architectures, no inline asm, and the totally non-magical version
works with okay performance.

(Is this what your code is doing?  I admit I didn't follow all the way
through all the macros.)
