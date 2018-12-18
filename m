Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553D2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D69B218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbeLRUzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:55:03 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:60010 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeLRUzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:55:02 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3F132EB5;
        Tue, 18 Dec 2018 20:54:54 +0000 (UTC)
Date:   Tue, 18 Dec 2018 12:54:53 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
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
Subject: Re: [PATCH mm] kasan, arm64: use ARCH_SLAB_MINALIGN instead of
 manual aligning
Message-Id: <20181218125453.4c5e6c056d31ccaa3a73d4a5@linux-foundation.org>
In-Reply-To: <706da77adfceb0c324e824d03b52d58a752577ea.1545139710.git.andreyknvl@google.com>
References: <706da77adfceb0c324e824d03b52d58a752577ea.1545139710.git.andreyknvl@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 14:30:33 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:

> Instead of changing cache->align to be aligned to KASAN_SHADOW_SCALE_SIZE
> in kasan_cache_create() we can reuse the ARCH_SLAB_MINALIGN macro.
> 
> ...
>
> --- a/arch/arm64/include/asm/kasan.h
> +++ b/arch/arm64/include/asm/kasan.h
> @@ -36,6 +36,10 @@
>  #define KASAN_SHADOW_OFFSET     (KASAN_SHADOW_END - (1ULL << \
>  					(64 - KASAN_SHADOW_SCALE_SHIFT)))
>  
> +#ifdef CONFIG_KASAN_SW_TAGS
> +#define ARCH_SLAB_MINALIGN	(1ULL << KASAN_SHADOW_SCALE_SHIFT)
> +#endif
> +
>  void kasan_init(void);
>  void kasan_copy_shadow(pgd_t *pgdir);
>  asmlinkage void kasan_early_init(void);

This looks unreliable.  include/linux/slab.h has

/*
 * Setting ARCH_SLAB_MINALIGN in arch headers allows a different alignment.
 * Intended for arches that get misalignment faults even for 64 bit integer
 * aligned buffers.
 */
#ifndef ARCH_SLAB_MINALIGN
#define ARCH_SLAB_MINALIGN __alignof__(unsigned long long)
#endif

so if a .c file includes arch/arm64/include/asm/kasan.h after
include/linux/slab.h, it can get a macro-redefined warning.  If the .c
file includes those headers in the other order, ARCH_SLAB_MINALIGN will
get a different value compared to other .c files.

Or something like that.

Different architectures define ARCH_SLAB_MINALIGN in different place:

./arch/microblaze/include/asm/page.h:#define ARCH_SLAB_MINALIGN L1_CACHE_BYTES
./arch/arm/include/asm/cache.h:#define ARCH_SLAB_MINALIGN 8
./arch/sh/include/asm/page.h:#define ARCH_SLAB_MINALIGN 8
./arch/c6x/include/asm/cache.h:#define ARCH_SLAB_MINALIGN       L1_CACHE_BYTES
./arch/sparc/include/asm/cache.h:#define ARCH_SLAB_MINALIGN     __alignof__(unsigned long long)
./arch/xtensa/include/asm/processor.h:#define ARCH_SLAB_MINALIGN STACK_ALIGN

which is rather bad of us.

But still.  I think your definition should occur in an arch header file
which is reliably included from slab.h.  And kasan code should get its
definition of ARCH_SLAB_MINALIGN by including slab.h.

