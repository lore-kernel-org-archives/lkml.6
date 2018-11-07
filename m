Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3EFC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203D320892
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203D320892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731324AbeKHCXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:23:23 -0500
Received: from foss.arm.com ([217.140.101.70]:54368 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727676AbeKHCXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:23:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5C81A78;
        Wed,  7 Nov 2018 08:52:12 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09F2F3F5BD;
        Wed,  7 Nov 2018 08:52:06 -0800 (PST)
Date:   Wed, 7 Nov 2018 16:52:00 +0000
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
Subject: Re: [PATCH v10 08/22] kasan, arm64: untag address in __kimg_to_phys
 and _virt_addr_is_linear
Message-ID: <20181107165200.oaou6cx2lmjzmjyl@lakrids.cambridge.arm.com>
References: <cover.1541525354.git.andreyknvl@google.com>
 <b2aa056b65b8f1a410379bf2f6ef439d5d99e8eb.1541525354.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2aa056b65b8f1a410379bf2f6ef439d5d99e8eb.1541525354.git.andreyknvl@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Tue, Nov 06, 2018 at 06:30:23PM +0100, Andrey Konovalov wrote:
> __kimg_to_phys (which is used by virt_to_phys) and _virt_addr_is_linear
> (which is used by virt_addr_valid) assume that the top byte of the address
> is 0xff, which isn't always the case with tag-based KASAN.

I'm confused by this. Why/when do kimg address have a non-default tag?

Any kimg address is part of the static kernel image, so it's not obvious
to me how a kimg address would gain a tag. Could you please explain how
this happens in the commit message?

> This patch resets the tag in those macros.
> 
> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/include/asm/memory.h | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index 0f1e024a951f..3226a0218b0b 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -92,6 +92,15 @@
>  #define KASAN_THREAD_SHIFT	0
>  #endif
>  
> +#ifdef CONFIG_KASAN_SW_TAGS
> +#define KASAN_TAG_SHIFTED(tag)		((unsigned long)(tag) << 56)
> +#define KASAN_SET_TAG(addr, tag)	(((addr) & ~KASAN_TAG_SHIFTED(0xff)) | \
> +						KASAN_TAG_SHIFTED(tag))
> +#define KASAN_RESET_TAG(addr)		KASAN_SET_TAG(addr, 0xff)
> +#else
> +#define KASAN_RESET_TAG(addr)		addr
> +#endif

Nit: the rest of the helper macros in this file are lower-case, with
specialised helpers prefixed with several underscores. Could we please
stick with that convention?

e.g. have __tag_set() and __tag_reset() helpers.

> +
>  #define MIN_THREAD_SHIFT	(14 + KASAN_THREAD_SHIFT)
>  
>  /*
> @@ -232,7 +241,7 @@ static inline unsigned long kaslr_offset(void)
>  #define __is_lm_address(addr)	(!!((addr) & BIT(VA_BITS - 1)))
>  
>  #define __lm_to_phys(addr)	(((addr) & ~PAGE_OFFSET) + PHYS_OFFSET)
> -#define __kimg_to_phys(addr)	((addr) - kimage_voffset)
> +#define __kimg_to_phys(addr)	(KASAN_RESET_TAG(addr) - kimage_voffset)

IIUC You need to adjust __lm_to_phys() too, since that could be passed
an address from SLAB.

Maybe that's done in a later patch, but if so it's confusing to split it
out that way. It would be nicer to fix all the *_to_*() helpers in one
go.

>  
>  #define __virt_to_phys_nodebug(x) ({					\
>  	phys_addr_t __x = (phys_addr_t)(x);				\
> @@ -308,7 +317,8 @@ static inline void *phys_to_virt(phys_addr_t x)
>  #endif
>  #endif
>  
> -#define _virt_addr_is_linear(kaddr)	(((u64)(kaddr)) >= PAGE_OFFSET)
> +#define _virt_addr_is_linear(kaddr)	(KASAN_RESET_TAG((u64)(kaddr)) >= \
> +						PAGE_OFFSET)

This is painful to read. Could you please split this like:

#define _virt_addr_is_linear(kaddr) \
	(__tag_reset((u64)(kaddr)) >= PAGE_OFFSET)

... and we could reformat virt_addr_valid() in the same way while we're
at it.

Thanks,
Mark.
