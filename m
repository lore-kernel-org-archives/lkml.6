Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF12C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 10:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DFB208CA
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 10:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fKspGLkP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34DFB208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbeHYN4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 09:56:15 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:55747 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeHYN4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 09:56:14 -0400
Received: by mail-it0-f45.google.com with SMTP id d10-v6so5304595itj.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Aug 2018 03:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rFrAJl9oUR5Juh2l8chhE3zMHHk1oW0TD1twVGSIwsQ=;
        b=fKspGLkPoN/0+54HlJB9YhrgOq+EDLrDW3NFd7NABW5Qsnrvmrb8m6MiGWcP4fwg5x
         AkeP6Q6w/TSk6abks/bc27GZZD1gAQA3cQfrBpJ9h8JIUrjxDUqnv25VsgEEv2oaKjp/
         AJJYs+HtNIjIMCF1GcaCPvinuCqJ/HLd+4kSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rFrAJl9oUR5Juh2l8chhE3zMHHk1oW0TD1twVGSIwsQ=;
        b=JjKzYPnL/OpWGzMenUogef89I7NqZdrClrYznE5qbZrWnnIZ78VlCDx9XMNuMlJj8A
         VEYB9bFt3p1jSZILWa8zpPhU5DLGMkizsHY9QHdImDt6mRlTVykDWyWbW9KzPwYM0ohy
         RpbOnUYhL41lPgjWWzuUi/KWpWU7fctgHl3RneE0arSAqOdun9Tkw7/FCChuxoqfi5ft
         +SdIPOvCCiMiaysFdNSweKtKt/wETKqdsKd23zoT6iszkOYnWPEmZkVbYYjEUBoLOMWH
         BQEinRdevGz1zkk7CGBEiWJBDesSuCleWRI9t5k//lKKCdOhgf/0ZHPOuWI3azMkfF3N
         Uyfg==
X-Gm-Message-State: APzg51CG+QFge1sJ/jHdglkcAiKy44xFyToyec8um/ssOHV0j5pUhuUP
        hFE4muLXzWvYnx05o8Ju+SueI84/cG78brQIJjmekQ==
X-Google-Smtp-Source: ANB0VdaQZmxt9LK1NLt3Cqz0aKIzcKnXQISCEIxzxz3bAnqK1kZrb6OJokAk7wFw84NIPumC/mDsVktlOTynM02NWK0=
X-Received: by 2002:a02:83ce:: with SMTP id j14-v6mr4321243jah.5.1535192263405;
 Sat, 25 Aug 2018 03:17:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Sat, 25 Aug 2018 03:17:42
 -0700 (PDT)
In-Reply-To: <20180824213849.23647-3-Jason@zx2c4.com>
References: <20180824213849.23647-1-Jason@zx2c4.com> <20180824213849.23647-3-Jason@zx2c4.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 25 Aug 2018 11:17:42 +0100
Message-ID: <CAKv+Gu-u7vPkU49AzToGHyf_cWp0MiOmpD3cRUt8260QC2wj-Q@mail.gmail.com>
Subject: Re: [PATCH v2 02/17] zinc: introduce minimal cryptography library
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 24 August 2018 at 22:38, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Zinc stands for "Zinc Is Neat Crypto" or "Zinc as IN Crypto" or maybe
> just "Zx2c4's INsane Cryptolib." It's also short, easy to type, and
> plays nicely with the recent trend of naming crypto libraries after
> elements. The guiding principle is "don't overdo it". It's less of a
> library and more of a directory tree for organizing well-curated direct
> implementations of cryptography primitives.
>
> Zinc is a new cryptography API that is much more minimal and lower-level
> than the current one. It intends to complement it and provide a basis
> upon which the current crypto API might build, as the provider of
> software implementations of cryptographic primitives. It is motivated by
> three primary observations in crypto API design:
>
>   * Highly composable "cipher modes" and related abstractions from
>     90s cryptographers did not turn out to be as terrific an idea as
>     hoped, leading to a host of API misuse problems.
>
>   * Most programmers are afraid of crypto code, and so prefer to
>     integrate it into libraries in a highly abstracted manner, so as to
>     shield themselves from implementation details. Cryptographers, on
>     the other hand, prefer simple direct implementations, which they're
>     able to verify for high assurance and optimize in accordance with
>     their expertise.
>
>   * Overly abstracted and flexible cryptography APIs lead to a host of
>     dangerous problems and performance issues. The kernel is in the
>     business usually not of coming up with new uses of crypto, but
>     rather implementing various constructions, which means it essentially
>     needs a library of primitives, not a highly abstracted enterprise-ready
>     pluggable system, with a few particular exceptions.
>

Do we really need a new crypto API for WireGuard? Surely, you yourself
are not affected by these concerns, and I don't anticipate an
explosion of new crypto use cases in the kernel that would justify
maintaining two parallel crypto stacks.

Also, I take it this means that WireGuard will only work with your
routines? We don't usually impose that kind of policy in the kernel:
on my arm64 systems, AES/GCM runs at 2.3 cycles per byte, which is a
good enough reason to prefer it over a ChaCha20/Poly1305 based AEAD,
even if your code is faster than the current code (which is debatable,
as you know)

It also means that users of the crypto API will not benefit from your
better code. I'm sure you agree that it is a bad idea to force those
same crypto-impaired programmers to port their code to a new API.

I also suggested that we work with Andy Polyakov (as I have in the
past) to make the changes required for the kernel in the OpenSSL
upstream. That way, we can take the .pl files unmodified, and benefit
from the maintenance and review upstream. Dumping 10,000s of lines of
generated assembler in the kernel tree like that is really
unacceptable IMO.

I think you will have to engage with the kernel community to identify
the problems with the current crypto API, and get them fixed. I think
it makes a lot of sense to have crypto primitives in lib/ (and
arch-specific accelerated versions in arch/<arch>/lib), and layer many
of the current crypto API drivers on top of that. Also, having more
test cases is useful as well. I'm not sure what the relevance of
formally verified implementations is, though, since it only proves
that the code is true to the algorithm, not that the algorithm is
secure. Or am I missing something?

Upstreaming your code is a lot easier if you don't cater for your own
needs only but also for the needs of others. Please work with us to
fix the problems in the current crypto API before parachuting in a new
one.


> This last observation has seen itself play out several times over and
> over again within the kernel:
>
>   * The perennial move of actual primitives away from crypto/ and into
>     lib/, so that users can actually call these functions directly with
>     no overhead and without lots of allocations, function pointers,
>     string specifier parsing, and general clunkiness. For example:
>     sha256, chacha20, siphash, sha1, and so forth live in lib/ rather
>     than in crypto/. Zinc intends to stop the cluttering of lib/ and
>     introduce these direct primitives into their proper place, lib/zinc/.
>
>   * An abundance of misuse bugs with the present crypto API that have
>     been very unpleasant to clean up.
>
>   * A hesitance to even use cryptography, because of the overhead and
>     headaches involved in accessing the routines.
>
> Zinc goes in a rather different direction. Rather than providing a
> thoroughly designed and abstracted API, Zinc gives you simple functions,
> which implement some primitive, or some particular and specific
> construction of primitives. It is not dynamic in the least, though one
> could imagine implementing a complex dynamic dispatch mechanism (such as
> the current crypto API) on top of these basic functions. After all,
> dynamic dispatch is usually needed for applications with cipher agility,
> such as IPsec, dm-crypt, AF_ALG, and so forth, and the existing crypto
> API will continue to play that role. However, Zinc will provide a non-
> haphazard way of directly utilizing crypto routines in applications
> that do have neither the need nor desire for abstraction and dynamic
> dispatch.
>
> It also organizes the implementations in a simple, straight-forward,
> and direct manner, making it enjoyable and intuitive to work on.
> Rather than moving optimized assembly implementations into arch/, it
> keeps them all together in lib/zinc/, making it simple and obvious to
> compare and contrast what's happening. This is, notably, exactly what
> the lib/raid6/ tree does, and that seems to work out rather well. It's
> also the pattern of most successful crypto libraries. The architecture-
> specific glue-code is made a part of each translation unit, rather than
> being in a separate one, so that generic and architecture-optimized code
> are combined at compile-time, and incompatibility branches compiled out by
> the optimizer.
>
> All implementations have been extensively tested and fuzzed, and are
> selected for their quality, trustworthiness, and performance. Wherever
> possible and performant, formally verified implementations are used,
> such as those from HACL* [1] and Fiat-Crypto [2]. The routines also take
> special care to zero out secrets using memzero_explicit (and future work
> is planned to have gcc do this more reliably and performantly with
> compiler plugins). The performance of the selected implementations is
> state-of-the-art and unrivaled on a broad array of hardware, though of
> course we will continue to fine tune these to the hardware demands
> needed by kernel contributors. Each implementation also comes with
> extensive self-tests and crafted test vectors, pulled from various
> places such as Wycheproof [9].
>
> Regularity of function signatures is important, so that users can easily
> "guess" the name of the function they want. Though, individual
> primitives are oftentimes not trivially interchangeable, having been
> designed for different things and requiring different parameters and
> semantics, and so the function signatures they provide will directly
> reflect the realities of the primitives' usages, rather than hiding it
> behind (inevitably leaky) abstractions. Also, in contrast to the current
> crypto API, Zinc functions can work on stack buffers, and can be called
> with different keys, without requiring allocations or locking.
>
> SIMD is used automatically when available, though some routines may
> benefit from either having their SIMD disabled for particular
> invocations, or to have the SIMD initialization calls amortized over
> several invocations of the function, and so Zinc utilizes function
> signatures enabling that in conjunction with the recently introduced
> simd_context_t.
>
> More generally, Zinc provides function signatures that allow just what
> is required by the various callers. This isn't to say that users of the
> functions will be permitted to pollute the function semantics with weird
> particular needs, but we are trying very hard not to overdo it, and that
> means looking carefully at what's actually necessary, and doing just that,
> and not much more than that. Remember: practicality and cleanliness rather
> than over-zealous infrastructure.
>
> Zinc provides also an opening for the best implementers in academia to
> contribute their time and effort to the kernel, by being sufficiently
> simple and inviting. In discussing this commit with some of the best and
> brightest over the last few years, there are many who are eager to
> devote rare talent and energy to this effort.
>
> Following the merging of this, I expect for the primitives that
> currently exist in lib/ to work their way into lib/zinc/, after intense
> scrutiny of each implementation, potentially replacing them with either
> formally-verified implementations, or better studied and faster
> state-of-the-art implementations.
>
> Also following the merging of this, I expect for the old crypto API
> implementations to be ported over to use Zinc for their software-based
> implementations.
>
> As Zinc is simply library code, its config options are un-menued, with
> the exception of CONFIG_ZINC_DEBUG, which enables various selftests and
> BUG_ONs.
>
> [1] https://github.com/project-everest/hacl-star
> [2] https://github.com/mit-plv/fiat-crypto
> [3] https://cr.yp.to/ecdh.html
> [4] https://cr.yp.to/chacha.html
> [5] https://cr.yp.to/snuffle/xsalsa-20081128.pdf
> [6] https://cr.yp.to/mac.html
> [7] https://blake2.net/
> [8] https://tools.ietf.org/html/rfc8439
> [9] https://github.com/google/wycheproof
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Samuel Neves <sneves@dei.uc.pt>
> Cc: Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
> Cc: linux-crypto@vger.kernel.org
> ---
>  MAINTAINERS       |  8 ++++++++
>  lib/Kconfig       |  2 ++
>  lib/Makefile      |  2 ++
>  lib/zinc/Kconfig  | 20 ++++++++++++++++++++
>  lib/zinc/Makefile |  7 +++++++
>  lib/zinc/main.c   | 31 +++++++++++++++++++++++++++++++
>  6 files changed, 70 insertions(+)
>  create mode 100644 lib/zinc/Kconfig
>  create mode 100644 lib/zinc/Makefile
>  create mode 100644 lib/zinc/main.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 955463f8d518..f194eda86011 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16103,6 +16103,14 @@ Q:     https://patchwork.linuxtv.org/project/linux-media/list/
>  S:     Maintained
>  F:     drivers/media/dvb-frontends/zd1301_demod*
>
> +ZINC CRYPTOGRAPHY LIBRARY
> +M:     Jason A. Donenfeld <Jason@zx2c4.com>
> +M:     Samuel Neves <sneves@dei.uc.pt>
> +S:     Maintained
> +F:     lib/zinc/
> +F:     include/zinc/
> +L:     linux-crypto@vger.kernel.org
> +
>  ZPOOL COMPRESSED PAGE STORAGE API
>  M:     Dan Streetman <ddstreet@ieee.org>
>  L:     linux-mm@kvack.org
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 706836ec314d..7ea5437e9f7d 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -478,6 +478,8 @@ config GLOB_SELFTEST
>           module load) by a small amount, so you're welcome to play with
>           it, but you probably don't need it.
>
> +source "lib/zinc/Kconfig"
> +
>  #
>  # Netlink attribute parsing support is select'ed if needed
>  #
> diff --git a/lib/Makefile b/lib/Makefile
> index d95bb2525101..ee41151cba7a 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -212,6 +212,8 @@ obj-$(CONFIG_PERCPU_TEST) += percpu_test.o
>
>  obj-$(CONFIG_ASN1) += asn1_decoder.o
>
> +obj-$(CONFIG_ZINC) += zinc/
> +
>  obj-$(CONFIG_FONT_SUPPORT) += fonts/
>
>  obj-$(CONFIG_PRIME_NUMBERS) += prime_numbers.o
> diff --git a/lib/zinc/Kconfig b/lib/zinc/Kconfig
> new file mode 100644
> index 000000000000..aa4f8d449d6b
> --- /dev/null
> +++ b/lib/zinc/Kconfig
> @@ -0,0 +1,20 @@
> +config ZINC
> +       tristate
> +       select CRYPTO_BLKCIPHER
> +       select VFP
> +       select VFPv3
> +       select NEON
> +       select KERNEL_MODE_NEON
> +
> +config ZINC_DEBUG
> +       bool "Zinc cryptography library debugging and self-tests"
> +       depends on ZINC
> +       help
> +         This builds a series of self-tests for the Zinc crypto library, which
> +         help diagnose any cryptographic algorithm implementation issues that
> +         might be at the root cause of potential bugs. It also adds various
> +         debugging traps.
> +
> +         Unless you're developing and testing cryptographic routines, or are
> +         especially paranoid about correctness on your hardware, you may say
> +         N here.
> diff --git a/lib/zinc/Makefile b/lib/zinc/Makefile
> new file mode 100644
> index 000000000000..8e30115217db
> --- /dev/null
> +++ b/lib/zinc/Makefile
> @@ -0,0 +1,7 @@
> +ccflags-y := -O3
> +ccflags-y += -Wframe-larger-than=8192
> +ccflags-y += -D'pr_fmt(fmt)=KBUILD_MODNAME ": " fmt'
> +
> +zinc-y += main.o
> +
> +obj-$(CONFIG_ZINC) := zinc.o
> diff --git a/lib/zinc/main.c b/lib/zinc/main.c
> new file mode 100644
> index 000000000000..590872563955
> --- /dev/null
> +++ b/lib/zinc/main.c
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Copyright (C) 2015-2018 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +
> +#ifdef CONFIG_ZINC_DEBUG
> +#define selftest(which) do { \
> +       if (!which ## _selftest()) \
> +               return -ENOTRECOVERABLE; \
> +} while (0)
> +#else
> +#define selftest(which)
> +#endif
> +
> +static int __init mod_init(void)
> +{
> +       return 0;
> +}
> +
> +static void __exit mod_exit(void)
> +{
> +}
> +
> +module_init(mod_init);
> +module_exit(mod_exit);
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Zinc cryptography library");
> +MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");
> --
> 2.18.0
>
