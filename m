Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410AEC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F242081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F242081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbeKHCyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:54:36 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55366 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727757AbeKHCyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:54:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6068EA78;
        Wed,  7 Nov 2018 09:23:16 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8835B3F5CF;
        Wed,  7 Nov 2018 09:23:10 -0800 (PST)
Date:   Wed, 7 Nov 2018 17:23:08 +0000
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
Subject: Re: [PATCH v10 09/22] kasan: add tag related helper functions
Message-ID: <20181107172306.3w2pjecaggsvl5z2@lakrids.cambridge.arm.com>
References: <cover.1541525354.git.andreyknvl@google.com>
 <b8c56d36b79eecf0c331a0a7a2df12632aefccc9.1541525354.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8c56d36b79eecf0c331a0a7a2df12632aefccc9.1541525354.git.andreyknvl@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 06:30:24PM +0100, Andrey Konovalov wrote:
> This commit adds a few helper functions, that are meant to be used to
> work with tags embedded in the top byte of kernel pointers: to set, to
> get or to reset (set to 0xff) the top byte.
> 
> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  arch/arm64/mm/kasan_init.c |  2 ++
>  include/linux/kasan.h      | 13 +++++++++
>  mm/kasan/kasan.h           | 55 ++++++++++++++++++++++++++++++++++++++
>  mm/kasan/tags.c            | 37 +++++++++++++++++++++++++
>  4 files changed, 107 insertions(+)
> 
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index 18ebc8994a7b..370b19d0e2fb 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -249,6 +249,8 @@ void __init kasan_init(void)
>  	memset(kasan_zero_page, KASAN_SHADOW_INIT, PAGE_SIZE);
>  	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
>  
> +	kasan_init_tags();
> +
>  	/* At this point kasan is fully initialized. Enable error messages */
>  	init_task.kasan_depth = 0;
>  	pr_info("KernelAddressSanitizer initialized\n");
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 7f6574c35c62..4c9d6f9029f2 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -169,6 +169,19 @@ static inline void kasan_cache_shutdown(struct kmem_cache *cache) {}
>  
>  #define KASAN_SHADOW_INIT 0xFF
>  
> +void kasan_init_tags(void);
> +
> +void *kasan_reset_tag(const void *addr);
> +
> +#else /* CONFIG_KASAN_SW_TAGS */
> +
> +static inline void kasan_init_tags(void) { }
> +
> +static inline void *kasan_reset_tag(const void *addr)
> +{
> +	return (void *)addr;
> +}
> +

> +#ifdef CONFIG_KASAN_SW_TAGS
> +
> +#define KASAN_PTR_TAG_SHIFT 56
> +#define KASAN_PTR_TAG_MASK (0xFFUL << KASAN_PTR_TAG_SHIFT)
> +
> +u8 random_tag(void);
> +
> +static inline void *set_tag(const void *addr, u8 tag)
> +{
> +	u64 a = (u64)addr;
> +
> +	a &= ~KASAN_PTR_TAG_MASK;
> +	a |= ((u64)tag << KASAN_PTR_TAG_SHIFT);
> +
> +	return (void *)a;
> +}
> +
> +static inline u8 get_tag(const void *addr)
> +{
> +	return (u8)((u64)addr >> KASAN_PTR_TAG_SHIFT);
> +}
> +
> +static inline void *reset_tag(const void *addr)
> +{
> +	return set_tag(addr, KASAN_TAG_KERNEL);
> +}

We seem to be duplicating this functionality in several places.

Could we please make it so that the arch code defines macros:

arch_kasan_set_tag(addr, tag)
arch_kasan_get_tag(addr)
arch_kasan_reset_tag(addr)

... and use thoses consistently rather than open-coding them?

> +
> +#else /* CONFIG_KASAN_SW_TAGS */
> +
> +static inline u8 random_tag(void)
> +{
> +	return 0;
> +}
> +
> +static inline void *set_tag(const void *addr, u8 tag)
> +{
> +	return (void *)addr;
> +}
> +
> +static inline u8 get_tag(const void *addr)
> +{
> +	return 0;
> +}
> +
> +static inline void *reset_tag(const void *addr)
> +{
> +	return (void *)addr;
> +}

... these can be defined in linux/kasan.h as:

#define arch_kasan_set_tag(addr, tag)	(addr)
#define arch_kasan_get_tag(addr)	0
#define arch_kasan_reset_tag(addr)	(addr)

Thanks,
Mark.
