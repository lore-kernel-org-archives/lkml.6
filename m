Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3404C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 05:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4CB2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 05:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4CB2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeIDJnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 05:43:53 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:38854 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbeIDJnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 05:43:52 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1fx3lH-0000An-UH; Tue, 04 Sep 2018 13:20:24 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1fx3kn-0003JX-0P; Tue, 04 Sep 2018 13:19:53 +0800
Date:   Tue, 4 Sep 2018 13:19:52 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-crypto@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        ebiggers@google.com, Megha Dey <megha.dey@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] crypto: x86 - remove SHA multibuffer routines and mcryptd
Message-ID: <20180904051952.d23crymm6ve7sect@gondor.apana.org.au>
References: <20180822085144.4872-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822085144.4872-1-ard.biesheuvel@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 10:51:44AM +0200, Ard Biesheuvel wrote:
> As it turns out, the AVX2 multibuffer SHA routines are currently
> broken [0], in a way that would have likely been noticed if this
> code were in wide use. Since the code is too complicated to be
> maintained by anyone except the original authors, and since the
> performance benefits for real-world use cases are debatable to
> begin with, it is better to drop it entirely for the moment.
> 
> [0] https://marc.info/?l=linux-crypto-vger&m=153476243825350&w=2
> 
> Suggested-by: Eric Biggers <ebiggers@google.com>
> Cc: Megha Dey <megha.dey@linux.intel.com>
> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  MAINTAINERS                                   |    8 -
>  arch/m68k/configs/amiga_defconfig             |    1 -
>  arch/m68k/configs/apollo_defconfig            |    1 -
>  arch/m68k/configs/atari_defconfig             |    1 -
>  arch/m68k/configs/bvme6000_defconfig          |    1 -
>  arch/m68k/configs/hp300_defconfig             |    1 -
>  arch/m68k/configs/mac_defconfig               |    1 -
>  arch/m68k/configs/multi_defconfig             |    1 -
>  arch/m68k/configs/mvme147_defconfig           |    1 -
>  arch/m68k/configs/mvme16x_defconfig           |    1 -
>  arch/m68k/configs/q40_defconfig               |    1 -
>  arch/m68k/configs/sun3_defconfig              |    1 -
>  arch/m68k/configs/sun3x_defconfig             |    1 -
>  arch/s390/configs/debug_defconfig             |    1 -
>  arch/s390/configs/performance_defconfig       |    1 -
>  arch/x86/crypto/Makefile                      |    3 -
>  arch/x86/crypto/sha1-mb/Makefile              |   14 -
>  arch/x86/crypto/sha1-mb/sha1_mb.c             | 1011 ----------------
>  arch/x86/crypto/sha1-mb/sha1_mb_ctx.h         |  134 ---
>  arch/x86/crypto/sha1-mb/sha1_mb_mgr.h         |  110 --
>  .../crypto/sha1-mb/sha1_mb_mgr_datastruct.S   |  287 -----
>  .../crypto/sha1-mb/sha1_mb_mgr_flush_avx2.S   |  304 -----
>  .../crypto/sha1-mb/sha1_mb_mgr_init_avx2.c    |   64 -
>  .../crypto/sha1-mb/sha1_mb_mgr_submit_avx2.S  |  209 ----
>  arch/x86/crypto/sha1-mb/sha1_x8_avx2.S        |  492 --------
>  arch/x86/crypto/sha256-mb/Makefile            |   14 -
>  arch/x86/crypto/sha256-mb/sha256_mb.c         | 1013 ----------------
>  arch/x86/crypto/sha256-mb/sha256_mb_ctx.h     |  134 ---
>  arch/x86/crypto/sha256-mb/sha256_mb_mgr.h     |  108 --
>  .../sha256-mb/sha256_mb_mgr_datastruct.S      |  304 -----
>  .../sha256-mb/sha256_mb_mgr_flush_avx2.S      |  307 -----
>  .../sha256-mb/sha256_mb_mgr_init_avx2.c       |   65 -
>  .../sha256-mb/sha256_mb_mgr_submit_avx2.S     |  214 ----
>  arch/x86/crypto/sha256-mb/sha256_x8_avx2.S    |  598 ----------
>  arch/x86/crypto/sha512-mb/Makefile            |   12 -
>  arch/x86/crypto/sha512-mb/sha512_mb.c         | 1047 -----------------
>  arch/x86/crypto/sha512-mb/sha512_mb_ctx.h     |  128 --
>  arch/x86/crypto/sha512-mb/sha512_mb_mgr.h     |  104 --
>  .../sha512-mb/sha512_mb_mgr_datastruct.S      |  281 -----
>  .../sha512-mb/sha512_mb_mgr_flush_avx2.S      |  297 -----
>  .../sha512-mb/sha512_mb_mgr_init_avx2.c       |   69 --
>  .../sha512-mb/sha512_mb_mgr_submit_avx2.S     |  224 ----
>  arch/x86/crypto/sha512-mb/sha512_x4_avx2.S    |  531 ---------
>  crypto/Kconfig                                |   62 -
>  crypto/Makefile                               |    1 -
>  crypto/mcryptd.c                              |  675 -----------
>  include/crypto/mcryptd.h                      |  114 --
>  47 files changed, 8952 deletions(-)
>  delete mode 100644 arch/x86/crypto/sha1-mb/Makefile
>  delete mode 100644 arch/x86/crypto/sha1-mb/sha1_mb.c
>  delete mode 100644 arch/x86/crypto/sha1-mb/sha1_mb_ctx.h
>  delete mode 100644 arch/x86/crypto/sha1-mb/sha1_mb_mgr.h
>  delete mode 100644 arch/x86/crypto/sha1-mb/sha1_mb_mgr_datastruct.S
>  delete mode 100644 arch/x86/crypto/sha1-mb/sha1_mb_mgr_flush_avx2.S
>  delete mode 100644 arch/x86/crypto/sha1-mb/sha1_mb_mgr_init_avx2.c
>  delete mode 100644 arch/x86/crypto/sha1-mb/sha1_mb_mgr_submit_avx2.S
>  delete mode 100644 arch/x86/crypto/sha1-mb/sha1_x8_avx2.S
>  delete mode 100644 arch/x86/crypto/sha256-mb/Makefile
>  delete mode 100644 arch/x86/crypto/sha256-mb/sha256_mb.c
>  delete mode 100644 arch/x86/crypto/sha256-mb/sha256_mb_ctx.h
>  delete mode 100644 arch/x86/crypto/sha256-mb/sha256_mb_mgr.h
>  delete mode 100644 arch/x86/crypto/sha256-mb/sha256_mb_mgr_datastruct.S
>  delete mode 100644 arch/x86/crypto/sha256-mb/sha256_mb_mgr_flush_avx2.S
>  delete mode 100644 arch/x86/crypto/sha256-mb/sha256_mb_mgr_init_avx2.c
>  delete mode 100644 arch/x86/crypto/sha256-mb/sha256_mb_mgr_submit_avx2.S
>  delete mode 100644 arch/x86/crypto/sha256-mb/sha256_x8_avx2.S
>  delete mode 100644 arch/x86/crypto/sha512-mb/Makefile
>  delete mode 100644 arch/x86/crypto/sha512-mb/sha512_mb.c
>  delete mode 100644 arch/x86/crypto/sha512-mb/sha512_mb_ctx.h
>  delete mode 100644 arch/x86/crypto/sha512-mb/sha512_mb_mgr.h
>  delete mode 100644 arch/x86/crypto/sha512-mb/sha512_mb_mgr_datastruct.S
>  delete mode 100644 arch/x86/crypto/sha512-mb/sha512_mb_mgr_flush_avx2.S
>  delete mode 100644 arch/x86/crypto/sha512-mb/sha512_mb_mgr_init_avx2.c
>  delete mode 100644 arch/x86/crypto/sha512-mb/sha512_mb_mgr_submit_avx2.S
>  delete mode 100644 arch/x86/crypto/sha512-mb/sha512_x4_avx2.S
>  delete mode 100644 crypto/mcryptd.c
>  delete mode 100644 include/crypto/mcryptd.h

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
