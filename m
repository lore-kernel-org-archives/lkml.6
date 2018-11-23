Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBB2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6594320685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 17:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6594320685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440990AbeKXE3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 23:29:15 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50084 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730951AbeKXE3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 23:29:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A51D3574;
        Fri, 23 Nov 2018 09:44:01 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E3113F5CF;
        Fri, 23 Nov 2018 09:43:55 -0800 (PST)
Date:   Fri, 23 Nov 2018 17:43:52 +0000
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
Subject: Re: [PATCH v11 05/24] kasan: add CONFIG_KASAN_GENERIC and
 CONFIG_KASAN_SW_TAGS
Message-ID: <20181123174352.ri3qo3wx2irm6hzj@lakrids.cambridge.arm.com>
References: <cover.1542648335.git.andreyknvl@google.com>
 <356c34c9a2ae8348a6cbd1de53135a28187fa120.1542648335.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <356c34c9a2ae8348a6cbd1de53135a28187fa120.1542648335.git.andreyknvl@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 06:26:21PM +0100, Andrey Konovalov wrote:
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
>  include/linux/compiler_attributes.h | 13 ----
>  include/linux/kasan.h               | 16 +++--
>  lib/Kconfig.kasan                   | 96 +++++++++++++++++++++++------
>  mm/kasan/Makefile                   |  6 +-
>  mm/kasan/generic.c                  |  2 +-
>  mm/kasan/kasan.h                    |  3 +-
>  mm/kasan/tags.c                     | 75 ++++++++++++++++++++++
>  mm/slub.c                           |  2 +-
>  scripts/Makefile.kasan              | 53 +++++++++-------
>  12 files changed, 216 insertions(+), 62 deletions(-)
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

> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -1,35 +1,95 @@
> +# This config refers to the generic KASAN mode.
>  config HAVE_ARCH_KASAN
>  	bool
>  
> +config HAVE_ARCH_KASAN_SW_TAGS
> +	bool
> +
> +config CC_HAS_KASAN_GENERIC
> +	def_bool $(cc-option, -fsanitize=kernel-address)
> +
> +config CC_HAS_KASAN_SW_TAGS
> +	def_bool $(cc-option, -fsanitize=kernel-hwaddress)

> +if HAVE_ARCH_KASAN_SW_TAGS
> +
> +config KASAN_SW_TAGS
> +	bool "Software tag-based mode"
> +	depends on CC_HAS_KASAN_SW_TAGS
> +	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
> +	select SLUB_DEBUG if SLUB
> +	select CONSTRUCTORS
> +	select STACKDEPOT
> +	help
> +	  Enables software tag-based KASAN mode.
> +	  This mode requires Top Byte Ignore support by the CPU and therefore
> +	  is only supported for arm64.
> +	  This mode requires Clang version 7.0.0 or later.
> +	  This mode consumes about 1/16th of available memory at kernel start
> +	  and introduces an overhead of ~20% for the rest of the allocations.
> +	  This mode may potentially introduce problems relating to pointer
> +	  casting and comparison, as it embeds tags into the top byte of each
> +	  pointer.
> +	  For better error detection enable CONFIG_STACKTRACE.
> +	  Currently CONFIG_KASAN_SW_TAGS doesn't work with CONFIG_DEBUG_SLAB
> +	  (the resulting kernel does not boot).
> +
> +endif

IIUC as of this patch a user can select KASAN_SW_TAGS...

> +ifdef CONFIG_KASAN_SW_TAGS
> +
> +ifdef CONFIG_KASAN_INLINE
> +    instrumentation_flags := -mllvm -hwasan-mapping-offset=$(KASAN_SHADOW_OFFSET)
> +else
> +    instrumentation_flags := -mllvm -hwasan-instrument-with-calls=1
> +endif
> +
> +CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
> +		-mllvm -hwasan-instrument-stack=0 \
> +		$(instrumentation_flags)
> +
> +endif # CONFIG_KASAN_SW_TAGS

... and therefore we start using the compiler option, even though we
haven't introduced all of the necessary infrastructure yet.

That doesn't sound right to me. At the very least, that breaks
randconfig builds.

What we can do, in-order, is:

1) introduce the core refactoring, dependent on HAVE_ARCH_KASAN_SW_TAGS
2) instroduce the new infrastructure and arch code
3) select HAVE_ARCH_KASAN_SW_TAGS

... such that at (3), all KASAN configurations are known to work.

Thanks,
Mark.
