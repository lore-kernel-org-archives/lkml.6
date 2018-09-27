Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92CAC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D53216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DVkxgmxt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D53216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbeI1E5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:57:50 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:37365 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbeI1E5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:57:50 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 50241ef4;
        Thu, 27 Sep 2018 22:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=Jkoltar1ViGwi32R5R0dVBQ8FoM=; b=DVkxgm
        xt0JQBFRXW5VM65+OnYdst8HThnPzFlpS4xylEIKhZ6d2TgCd80Kaj+Xyhj60pEN
        BWxg7q5gS7QD9JUVM2ZkfEHRul7vkrGaL3wQR968PEQBQFMNmJzo0gzloC6bwWDm
        l3Gub0h66yZy5stBaUL8FnV1o6u3c6ZA4Dz9U6d3eo6J7ulXnWvaiVfmH5kNPcgk
        vbk7zVjx7m4pkRH1rmNkskCLfXKk8vFMD5+Tnwr9e5SCiU4QwKSY04TmJGUFOMpa
        201kB4XBi+Fss/1eEVmMwIU/+oakKvnU4xk5utC4+z/+64yS2uXqmrPussEtnMBQ
        9Qq6aU4YXFfGQ+UA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5b8e877a (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Thu, 27 Sep 2018 22:18:32 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id u74-v6so3635676oia.11;
        Thu, 27 Sep 2018 15:37:14 -0700 (PDT)
X-Gm-Message-State: ABuFfojbVdw7g5DO3/WoD2VQgNKZG9Uy8LMy9mllXbBebtmG6sCTcug5
        Q9d4NnsbUf263Uy6z7jUWqA0W/Cp/YICAfiBxnE=
X-Google-Smtp-Source: ACcGV62ba/dCzxCNZJxoXVIpIxhZ3VqAiJtpBA+8EPLqFqycNx6m/tKrP0SBsgvYq1LcDMKymghndsgnku+9Tb95oqo=
X-Received: by 2002:aca:2c5:: with SMTP id 188-v6mr4080578oic.192.1538087834349;
 Thu, 27 Sep 2018 15:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-24-Jason@zx2c4.com>
 <20180927011526.GB1193@lunn.ch>
In-Reply-To: <20180927011526.GB1193@lunn.ch>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 28 Sep 2018 00:37:03 +0200
X-Gmail-Original-Message-ID: <CAHmME9q7WRGF3TTRhhy0i_EB4ad2DaSD=tnHM92zfV4Cckyw=A@mail.gmail.com>
Message-ID: <CAHmME9q7WRGF3TTRhhy0i_EB4ad2DaSD=tnHM92zfV4Cckyw=A@mail.gmail.com>
Subject: Re: [PATCH net-next v6 23/23] net: WireGuard secure network tunnel
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thanks for following up with this.

On Thu, Sep 27, 2018 at 3:15 AM Andrew Lunn <andrew@lunn.ch> wrote:
> I know you have been concentrating on the crypto code, so i'm not
> expecting too many changes at the moment in the network code.

I should be addressing things in parallel, actually, so I'm happy to
work on this.

> WARNING: Avoid crashing the kernel - try using WARN_ON & recovery code rather than BUG() or BUG_ON()
> #2984: FILE: drivers/net/wireguard/noise.c:293:
> +       BUG_ON(first_len > BLAKE2S_HASH_SIZE || second_len > BLAKE2S_HASH_SIZE ||

I was actually going to ask you about this, because it applies
similarly in another context too that I'm trying to refine. The above
function you quote has the following properties:

- Only ever accepts fixed length parameters, so the compiler can
constant fold invocations of it fantastically. Those parameters are
fixed length in the sense that they're enum/macro constants. They
never come from the user or from a packet or something.
- Never produces an incorrect result. For said constants, all inputs
are valid, and so it succeeds in producing an output every time.
- Is a "pure" function, just knocking bytes around, without needing to
interact with fancy kernel-y things; could be implemented on some sort
of WWII-era rotor machine provided you had the patience.

Because of the above, there's never any error to return to the user of
the function. Also, because it only ever takes constant sized inputs,
in theory I should be able to change that BUG_ON() to BUILD_BUG_ON(),
but in practice the optimizer/inliner isn't actually that aggressive.

But what I would like is some way of signaling to the developer using
this function that they've passed it an illegal value, and their code
should not ship until that's fixed, under any circumstances at all  --
that their usage of the function is completely unacceptable and wrong.
Bla bla strong statements.

For this, I figured the notion would come across with the aberrant
behavior of "crash the developer's [in this case, my] QEMU instance"
when "#ifdef DEBUG is true". This is the same kind of place where I'd
have an "assert()" statement in userland. It sounds like what you're
saying is that a WARN_ON is equally as effective instead? Or given the
above, do you think the BUG_ON is actually sensible? Or neither and I
should do something else?

> WARNING: Macros with flow control statements should be avoided
> #5471: FILE: drivers/net/wireguard/selftest/allowedips.h:456:
> +#define init_peer(name) do {                                               \
> +               name = kzalloc(sizeof(*name), GFP_KERNEL);                 \
> +               if (unlikely(!name)) {                                     \
> +                       pr_info("allowedips self-test: out of memory\n");  \
> +                       goto free;                                         \
> +               }                                                          \
> +               kref_init(&name->refcount);                                \
> +       } while (0)

This is part of a debugging selftest, where I'm initing a bunch of
peers one after another, and this macro helps keep the test clear
while offloading the actual irrelevant coding part to this macro. The
test itself then just has code like:

    init_peer(a);
    init_peer(b);
    init_peer(c);
    init_peer(d);
    init_peer(e);
    init_peer(f);
    init_peer(g);
    init_peer(h);

    insert(4, a, 192, 168, 4, 0, 24);
    insert(4, b, 192, 168, 4, 4, 32);
    insert(4, c, 192, 168, 0, 0, 16);
    insert(4, d, 192, 95, 5, 64, 27);
    /* replaces previous entry, and maskself is required */
    insert(4, c, 192, 95, 5, 65, 27);
    insert(6, d, 0x26075300, 0x60006b00, 0, 0xc05f0543, 128);
    insert(6, c, 0x26075300, 0x60006b00, 0, 0, 64);
    ...

And so forth. I can probably figure out a different way to code this
if you really want, but I thought this would be clear.

> The namespace pollution also needs to be addresses. You have some
> pretty generic named global symbols. I picked out a few examples from
> objdump
>
> 00002a94 g     F .text      00000060 peer_put
> 00003484 g     F .text      0000004c timers_stop
> 00003520 g     F .text      00000114 packet_queue_init
> 00002640 g     F .text      00000034 device_uninit
> 000026bc g     F .text      00000288 peer_create
> 000090d4 g     F .text      000001bc ratelimiter_init
>
> Please make use of a prefix for global symbols, e.g. wg_.

Will do. v7 will include the wg_ prefix.

On a slightly related note, out of curiosity, any idea what's up with
the future of LTO in the kernel? It sounds like that'd be nice to have
on a module-by-module basis. IOW, I'd love to LTO all of my .c files
in wireguard together, and then only ever expose mod_init/exit and
whatever I explicitly EXPORT_SYMBOL, and then have the compiler and
linker treat the rest of everything as essentially in one .c file and
optimize the heck out of it, and then strip all the symbols. It would,
incidentally, remove the need for said symbol prefixes, since I
wouldn't be making anything global. (Probably perf/ftrace/etc would
become harder to use though.)

Jason
