Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB06FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4E32082C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="utGnx948"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4E32082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbeIZTqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:46:00 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:46257 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbeIZTqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:46:00 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 9948c1c3;
        Wed, 26 Sep 2018 13:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=5Th5xSwiiN40zyROLwYuOEGbjJM=; b=utGnx9
        48QzcpKubNEdRRSWyLajdWH9y9yyRZXE/721WXUAa+Ztdvm9kMet0PayzRmucxya
        OJsm33kgTmQOwn8FQ4EbeK+yZ94G7xKaUfZoEN1d0UT2DkmnSgb6nnNHOhtTl+kh
        TaKMesWMSC6Ytj2uykvfCJVlrl7mT0UeNmsmKzHXT9tX/fjh//IxClYjBexEtxiQ
        YLHEhe9nItl5nGSP43JAOLfeRY+vDTYsXHNKT2ElkcJjPJZxZXYhVumydCgh6MKq
        v0d0rqrNWJoTOhkVL5/Atv6y4jev7LWv4YC6bjMmEkHR2X7AHLBMYua7mhmnoFj3
        GcEloRKK4NrNlViQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2a1aa20c (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 26 Sep 2018 13:14:24 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id m23-v6so10566949otf.0;
        Wed, 26 Sep 2018 06:32:57 -0700 (PDT)
X-Gm-Message-State: ABuFfoiL6C1sCw7x1xaoOGFYMRh4jJXqulwvqmz5FSax28R9oQnMF0lC
        6icTi6LoSf8vWWRohHuCgVJ7PC5OX0+UWAhabvo=
X-Google-Smtp-Source: ACcGV60LnAWyKLrT8h1q9a75kE6491gxKEnJdHqRrq0/bi6REjN8w4fjF1hL7zO9hQ090pr6GM0JamnJVYAO2gcTIM8=
X-Received: by 2002:a9d:522d:: with SMTP id e45-v6mr3977455oth.250.1537968776249;
 Wed, 26 Sep 2018 06:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com>
In-Reply-To: <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 26 Sep 2018 15:32:45 +0200
X-Gmail-Original-Message-ID: <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com>
Message-ID: <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64 implementations
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Wed, Sep 26, 2018 at 10:59 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> > +static inline bool chacha20_arch(struct chacha20_ctx *state, u8 *dst,
> > +                                const u8 *src, size_t len,
> > +                                simd_context_t *simd_context)
> > +{
> > +#if defined(CONFIG_KERNEL_MODE_NEON)
> > +       if (chacha20_use_neon && len >= CHACHA20_BLOCK_SIZE * 3 &&
> > +           simd_use(simd_context))
> > +               chacha20_neon(dst, src, len, state->key, state->counter);
> > +       else
> > +#endif
>
> Better to use IS_ENABLED() here:
>
> > +       if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON)) &&
> > +           chacha20_use_neon && len >= CHACHA20_BLOCK_SIZE * 3 &&
> > +           simd_use(simd_context))

Good idea. I'll fix that up.

>
> Also, this still has unbounded worst case scheduling latency, given
> that the outer library function passes its entire input straight into
> the NEON routine.

The vast majority of crypto routines in arch/*/crypto/ follow this
same exact pattern, actually. I realize a few don't -- probably the
ones you had a hand in :) -- but I think this is up to the caller to
handle. I made a change so that in chacha20poly1305.c, it calls
simd_relax after handling each scatter-gather element, so a
"construction" will handle this gracefully. But I believe it's up to
the caller to decide on what sizes of information it wants to pass to
primitives. Put differently, this also hasn't ever been an issue
before -- the existing state of the tree indicates this -- and so I
don't anticipate this will be a real issue now. And if it becomes one,
this is something we can address *later*, but certainly there's no use
of adding additional complexity to the initial patchset to do this
now.

Jason
