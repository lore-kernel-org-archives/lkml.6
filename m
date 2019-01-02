Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4295C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5DB8218D4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 11:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbfABLWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 06:22:42 -0500
Received: from ozlabs.org ([203.11.71.1]:50619 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbfABLWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 06:22:41 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43V7v05cZMz9s9G;
        Wed,  2 Jan 2019 22:22:36 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Cc:     masahiroy@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>, linux-arch@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] jump_label: move 'asm goto' support test to Kconfig
In-Reply-To: <1546182855-24290-1-git-send-email-yamada.masahiro@socionext.com>
References: <1546182855-24290-1-git-send-email-yamada.masahiro@socionext.com>
Date:   Wed, 02 Jan 2019 22:22:44 +1100
Message-ID: <87imz7xq0r.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> Currently, CONFIG_JUMP_LABEL just means "I _want_ to use jump label".
>
> The jump label is controlled by HAVE_JUMP_LABEL, which is defined
> like this:
>
>   #if defined(CC_HAVE_ASM_GOTO) && defined(CONFIG_JUMP_LABEL)
>   # define HAVE_JUMP_LABEL
>   #endif
>
> We can improve this by testing 'asm goto' support in Kconfig, then
> make JUMP_LABEL depend on CC_HAS_ASM_GOTO.
>
> Ugly #ifdef HAVE_JUMP_LABEL will go away, and CONFIG_JUMP_LABEL will
> match to the real kernel capability.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
> This is a trivial conversion from the build system PoV.
> I want to queue this up to kbuild tree.
>
>
>  Makefile                                          |  7 -------
>  arch/Kconfig                                      |  1 +
>  arch/arm/kernel/jump_label.c                      |  4 ----
>  arch/arm64/kernel/jump_label.c                    |  4 ----
>  arch/mips/kernel/jump_label.c                     |  4 ----
>  arch/powerpc/include/asm/asm-prototypes.h         |  2 +-
>  arch/powerpc/kernel/jump_label.c                  |  2 --
>  arch/powerpc/platforms/powernv/opal-tracepoints.c |  2 +-
>  arch/powerpc/platforms/powernv/opal-wrappers.S    |  2 +-
>  arch/powerpc/platforms/pseries/hvCall.S           |  4 ++--
>  arch/powerpc/platforms/pseries/lpar.c             |  2 +-

Looks OK to me.

If there's any odd build errors they should get caught in linux-next.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
