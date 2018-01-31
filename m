Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752795AbeAaUYa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 15:24:30 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39817 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752308AbeAaUY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 15:24:28 -0500
X-Google-Smtp-Source: AH8x224BDGQ1SJZ2wp8nxTgfEJwxmgrGEGM83ew9viEhXrUzqsEshQ61sxa/f0nrenZzHLq3UPAymrXjwNp0B+IeiAU=
MIME-Version: 1.0
In-Reply-To: <20180131201911.19253-1-anders.roxell@linaro.org>
References: <20180129234900.11121-1-anders.roxell@linaro.org> <20180131201911.19253-1-anders.roxell@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 31 Jan 2018 21:24:27 +0100
X-Google-Sender-Auth: MyG_MQZrRKJQtq99DSNObTS8N9s
Message-ID: <CAK8P3a2o88rAs9_qLY-iBXcyFgtUKUofSYXt2pJpgzypQJnRvQ@mail.gmail.com>
Subject: Re: [PATCHv2] arch/arm/Kconfig: default ARM_MODULE_PLTS to 'y'
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 9:19 PM, Anders Roxell <anders.roxell@linaro.org> wrote:
> While testing multi_v7_defconfig with LOCKDEP enabled, the kernel
> fails to load simple modules, as reported by kselftest:
>
> [   34.107620] test_printf: section 4 reloc 2 sym 'memset': relocation
> 28 out of range (0xbf046044 -> 0xc109f720)
> selftests: printf.sh [FAIL]
>
> The problem that is seen when LOCKDEP is enabled without
> ARM_MODULE_PLTS, is that LOCKDEP eats so much memory that the top of the
> kernel gets out of reach from the bottom of the module area.

I think we could still use a better explanation here, as Russell said anything
could cause the size to grow too much, it's just that you happened to run into
it through lockdep, which can cause a very significant growth.

      Arnd

> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 51c8df561077..8014c8c322df 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1702,6 +1702,7 @@ config ARCH_WANT_GENERAL_HUGETLB
>  config ARM_MODULE_PLTS
>         bool "Use PLTs to allow module memory to spill over into vmalloc area"
>         depends on MODULES
> +       default y
>         help
>           Allocate PLTs when loading modules so that jumps and calls whose
>           targets are too far away for their relative offsets to be encoded
> --
> 2.11.0
>
