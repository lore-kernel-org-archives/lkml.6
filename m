Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE4DC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D025D206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 01:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="AxYaeOoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D025D206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeI2IUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 04:20:33 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:56467 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727248AbeI2IUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 04:20:33 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id c3839219;
        Sat, 29 Sep 2018 01:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=s66Ly328Bt9HDtw+kIy6Teq64vU=; b=AxYaeO
        oXq+Tf9SEJwXKXX3MQCMmMVzlXGTkSrkf/sWDUJT34r7y0aljUXgDzu0Wf8fnBef
        3vNf+vfqkj8ScCBz2P2o7Gv78Du1uUbaVO6RHz25YN4F/eAxN9Yn0yFrw3YNx6xo
        5F4VNteFdyaF4NjH7tt4+K9cgvIoidEHLXt0/neGf4obaADkJD30hof5IsBzvoVO
        aQCb5yLz1byhMPxT1lbeA00VxLLCR9YXcm8lbt4ogEgPAntDM2tw44NQOHf838ay
        DTghljHFBrI0YAQ4Xdj89Y/vT1mJK2e9nYvWlz9LIppARVeDk4NYFc2/lEsATS8z
        /NZO3FaolME2N6jA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 3d8866da (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sat, 29 Sep 2018 01:35:09 +0000 (UTC)
Received: by mail-ot1-f54.google.com with SMTP id e23-v6so3602302otl.7;
        Fri, 28 Sep 2018 18:54:01 -0700 (PDT)
X-Gm-Message-State: ABuFfoisXCTW6qxOER8xm3Zjd04I25sIDv7xOWpZvtrnbYsbB6gQXT07
        Bjai0t08zNb4FI480+cgYOjOd2ppI/GNpc+tK48=
X-Google-Smtp-Source: ACcGV61U1M743GJ+6QrBgo8iI4it5QhlP7z4vDcZfpSYQ2Qx7j2WBeR5KMocPO4wmq5AWVFuNEfDgplngut/PtWAoJE=
X-Received: by 2002:a9d:17d0:: with SMTP id j74-v6mr728100otj.268.1538186040537;
 Fri, 28 Sep 2018 18:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-4-Jason@zx2c4.com>
 <CAKv+Gu8dscmuEnRYNACFfCudwVkA6CRHhTe7K-=r_SfJQBGgzQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu8dscmuEnRYNACFfCudwVkA6CRHhTe7K-=r_SfJQBGgzQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 29 Sep 2018 03:53:48 +0200
X-Gmail-Original-Message-ID: <CAHmME9oigSgEqxcevZNmEB9HYpdW6_aMgkdLAXx5YrDckV=g0w@mail.gmail.com>
Message-ID: <CAHmME9oigSgEqxcevZNmEB9HYpdW6_aMgkdLAXx5YrDckV=g0w@mail.gmail.com>
Subject: Re: [PATCH net-next v6 03/23] zinc: ChaCha20 generic C implementation
 and selftest
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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

Hi Ard,

On Fri, Sep 28, 2018 at 5:40 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> > +struct chacha20_ctx {
> > +       u32 constant[4];
> > +       u32 key[8];
> > +       u32 counter[4];
> > +} __aligned(32);
> > +
>
> 32 *byte* alignment? Is that right? If this is for performance and it
> actually helps, using __cacheline_aligned is more appropriate,

It was originally this way, I believe, for vmovdqa, which requires
32-byte alignment in vex.256 encoding, and I never removed it after
changing some things. But I'll spend some time ensuring this is so and
if it doesn't make sense anymore it'll be gone by v7. On the other
hand, your suggestion of __cacheline_aligned may actually be something
worth considering, especially on MIPS.

> I guess this include is for crypto_xor_cpy() ?
>
> We may want to put a comment here, so we keep track of the interdependencies.

Right, it's for crypto_xor_cpy. Good idea, I'll add the comment.

> > +#ifndef HAVE_CHACHA20_ARCH_IMPLEMENTATION
>
> This #define is never set in subsequent patches, so just drop this
> #ifndef entirely (for this patch only)

Okay. It's also there for the other primitives too; I'll nix it for all of them.

> Return values from initcalls are ignored, and given that chacha20 will
> be depended upon by random.c, it will never be a module in practice.
>
> Given your previous statement that selftest should *not* be a DEBUG
> feature (which I wholeheartedly agree with), you could be a bit
> noisier here imo.
> E.g.,
>
> if (WARN_ON(!chach20_selftest())
>     return ...

That's an excellent idea. We could bloat the whole thing with something like:

#ifdef MODULE
#define WARN_ON_IF_MODULE(x) (x)
#else
#define WARN_ON_IF_MODULE(x) WARN_ON(x)
#endif

But given that kind of thing would probably need to touch more files
in the tree, and hence involve more drawn-out conversation, I'll keep
it as the simple WARN_ON for now. Besides, being noisy no matter what
might actually be the best strategy for receiving bug reports on what
is potentially a pretty catastrophic error.

Thanks for the review.

Jason
