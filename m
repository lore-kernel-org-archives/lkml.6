Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF7FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F2B20883
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F2B20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731663AbeKHCgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:36:21 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54684 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727757AbeKHCgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:36:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C046FA78;
        Wed,  7 Nov 2018 09:05:06 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E94AF3F5BD;
        Wed,  7 Nov 2018 09:05:00 -0800 (PST)
Date:   Wed, 7 Nov 2018 17:04:58 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, linux-mm@kvack.org,
        linux-kbuild@vger.kernel.org, Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>
Subject: Re: [PATCH v10 05/22] kasan: add CONFIG_KASAN_GENERIC and
 CONFIG_KASAN_SW_TAGS
Message-ID: <20181107170458.jirk2b3tszrcagbt@lakrids.cambridge.arm.com>
References: <cover.1541525354.git.andreyknvl@google.com>
 <ea8f0391d7befab4afec34d2a009028cd9e0f326.1541525354.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea8f0391d7befab4afec34d2a009028cd9e0f326.1541525354.git.andreyknvl@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 06:30:20PM +0100, Andrey Konovalov wrote:
> This commit splits the current CONFIG_KASAN config option into two:
> 1. CONFIG_KASAN_GENERIC, that enables the generic KASAN mode (the one
>    that exists now);
> 2. CONFIG_KASAN_SW_TAGS, that enables the software tag-based KASAN mode.
> 
> The name CONFIG_KASAN_SW_TAGS is chosen as in the future we will have
> another hardware tag-based KASAN mode, that will rely on hardware memory
> tagging support in arm64.
> 
> With CONFIG_KASAN_SW_TAGS enabled, compiler options are changed to
> instrument kernel files with -fsantize=kernel-hwaddress (except the ones
> for which KASAN_SANITIZE := n is set).
> 
> Both CONFIG_KASAN_GENERIC and CONFIG_KASAN_SW_TAGS support both
> CONFIG_KASAN_INLINE and CONFIG_KASAN_OUTLINE instrumentation modes.
> 
> This commit also adds empty placeholder (for now) implementation of
> tag-based KASAN specific hooks inserted by the compiler and adjusts
> common hooks implementation to compile correctly with each of the
> config options.
> 
> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/Kconfig                  |  1 +
>  include/linux/compiler-clang.h      |  5 +-
>  include/linux/compiler-gcc.h        |  6 ++
>  include/linux/compiler_attributes.h | 13 -----
>  include/linux/kasan.h               | 16 ++++--
>  lib/Kconfig.kasan                   | 87 +++++++++++++++++++++++------
>  mm/kasan/Makefile                   |  6 +-
>  mm/kasan/generic.c                  |  2 +-
>  mm/kasan/kasan.h                    |  3 +-
>  mm/kasan/tags.c                     | 75 +++++++++++++++++++++++++
>  mm/slub.c                           |  2 +-
>  scripts/Makefile.kasan              | 27 ++++++++-
>  12 files changed, 201 insertions(+), 42 deletions(-)
>  create mode 100644 mm/kasan/tags.c
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 787d7850e064..8b331dcfb48e 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -111,6 +111,7 @@ config ARM64
>  	select HAVE_ARCH_JUMP_LABEL
>  	select HAVE_ARCH_JUMP_LABEL_RELATIVE
>  	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
> +	select HAVE_ARCH_KASAN_SW_TAGS if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)

Given this relies on a compiler feature, can we please gate this on
compiler feature detection? e.g. in some common Kconfig have:

	select CC_HAS_ASAN_HWADDRESS if $(cc-option -fsanitize=kernel-hwaddress)

... and on arm64 we can do:

	select HAVE_ARCH_KASAN_SW_TAGS if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)

... and core KASAN Kconfig can have:

config KASAN_SW_TAGS
	depends on HAVE_ARCH_KASAN_SW_TAGS
	depends on CC_HAS_ASAN_HWADDRESS

[...]

> +ifeq ($(call cc-option, $(CFLAGS_KASAN) -Werror),)
> +    ifneq ($(CONFIG_COMPILE_TEST),y)
> +        $(warning Cannot use CONFIG_KASAN_SW_TAGS: \
> +            -fsanitize=hwaddress is not supported by compiler)
> +    endif
> +endif

... and then this warning shouldn't be possible, and can go.

Thanks,
Mark.
