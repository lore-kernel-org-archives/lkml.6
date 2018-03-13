Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbeCMMso (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:48:44 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:34424 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbeCMMsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:48:43 -0400
X-Google-Smtp-Source: AG47ELtxfJVQPsn/bu0UhIu8udaDCdDiTaj6sFTFyuYdBdMLVQxPMAWGmFDpNnK3mCoiJZjaEkvMWJpd+A2fYyU4L18=
MIME-Version: 1.0
In-Reply-To: <20180313114202.1977512-1-arnd@arndb.de>
References: <20180313114202.1977512-1-arnd@arndb.de>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 13 Mar 2018 12:48:42 +0000
Message-ID: <CAKv+Gu-6s1tqBzAEgL63WxXrc9SuF2C9PtADqmEcUKWxP8eZUw@mail.gmail.com>
Subject: Re: [PATCH] arm64: fix undefined reference to 'printk'
To: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 March 2018 at 11:41, Arnd Bergmann <arnd@arndb.de> wrote:
> The printk symbol was intended as a generic address that is always
> exported, however that turned out to be false with CONFIG_PRINTK=n:
>
> ERROR: "printk" [arch/arm64/kernel/arm64-reloc-test.ko] undefined!
>
> This changes the references to memstart_addr, which should be there
> regardless of configuration.
>
> Fixes: a257e02579e4 ("arm64/kernel: don't ban ADRP to work around Cortex-A53 erratum #843419")
> Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: ^^^

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/kernel/reloc_test_core.c | 2 +-
>  arch/arm64/kernel/reloc_test_syms.S | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/kernel/reloc_test_core.c b/arch/arm64/kernel/reloc_test_core.c
> index a70489c584c7..5915ce5759cc 100644
> --- a/arch/arm64/kernel/reloc_test_core.c
> +++ b/arch/arm64/kernel/reloc_test_core.c
> @@ -45,7 +45,7 @@ static struct {
>         { "R_AARCH64_MOVW_SABS_Gn",     signed_movw, UL(SYM64_ABS_VAL) },
>         { "R_AARCH64_MOVW_UABS_Gn",     unsigned_movw, UL(SYM64_ABS_VAL) },
>         { "R_AARCH64_ADR_PREL_PG_HI21", relative_adrp, (u64)&sym64_rel },
> -       { "R_AARCH64_ADR_PREL_PG_HI21", relative_adrp_far, (u64)&printk },
> +       { "R_AARCH64_ADR_PREL_PG_HI21", relative_adrp_far, (u64)&memstart_addr },
>         { "R_AARCH64_ADR_PREL_LO21",    relative_adr, (u64)&sym64_rel },
>         { "R_AARCH64_PREL64",           relative_data64, (u64)&sym64_rel },
>         { "R_AARCH64_PREL32",           relative_data32, (u64)&sym64_rel },
> diff --git a/arch/arm64/kernel/reloc_test_syms.S b/arch/arm64/kernel/reloc_test_syms.S
> index f333b4b7880d..2b8d9cb8b078 100644
> --- a/arch/arm64/kernel/reloc_test_syms.S
> +++ b/arch/arm64/kernel/reloc_test_syms.S
> @@ -54,8 +54,8 @@ ENDPROC(relative_adrp)
>         .align  12
>         .space  0xffc
>  ENTRY(relative_adrp_far)
> -       adrp    x0, printk
> -       add     x0, x0, #:lo12:printk
> +       adrp    x0, memstart_addr
> +       add     x0, x0, #:lo12:memstart_addr
>         ret
>  ENDPROC(relative_adrp_far)
>
> --
> 2.9.0
>
