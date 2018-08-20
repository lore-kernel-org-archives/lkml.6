Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C303DC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D6F20693
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 10:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D6F20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbeHTOEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 10:04:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:36944 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbeHTOEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 10:04:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 585E6ADDD;
        Mon, 20 Aug 2018 10:49:33 +0000 (UTC)
Date:   Mon, 20 Aug 2018 12:49:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, stable@vger.kernel.org,
        Adrian Schroeter <adrian@suse.de>,
        Dominique Leuenberger <dimstar@suse.de>
Subject: Re: [PATCH] x86/speculation/l1tf: fix overflow on l1tf_pfn_limit()
 on 32bit
Message-ID: <20180820104932.GI29735@dhcp22.suse.cz>
References: <20180820095835.5298-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820095835.5298-1-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-08-18 11:58:35, Vlastimil Babka wrote:
> On 32bit PAE kernels on 64bit hardware with enough physical bits,
> l1tf_pfn_limit() will overflow unsigned long. This in turn affects
> max_swapfile_size() and can lead to swapon returning -EINVAL. This has been
> observed in a 32bit guest with 42 bits physical address size, where
> max_swapfile_size() overflows exactly to 1 << 32, thus zero, and produces the
> following warning to dmesg:
> 
> [    6.396845] Truncating oversized swap area, only using 0k out of 2047996k
> 
> Fix this by using unsigned long long instead.
> 
> Reported-by: Dominique Leuenberger <dimstar@suse.de>
> Reported-by: Adrian Schroeter <adrian@suse.de>
> Fixes: 17dbca119312 ("x86/speculation/l1tf: Add sysfs reporting for l1tf")
> Fixes: 377eeaa8e11f ("x86/speculation/l1tf: Limit swap file size to MAX_PA/2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Looks good to me. I would probably use phys_addr_t which would be more
descriptive but this is just minor thing.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/x86/include/asm/processor.h | 4 ++--
>  arch/x86/mm/init.c               | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 682286aca881..a0a52274cb4a 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -181,9 +181,9 @@ extern const struct seq_operations cpuinfo_op;
>  
>  extern void cpu_detect(struct cpuinfo_x86 *c);
>  
> -static inline unsigned long l1tf_pfn_limit(void)
> +static inline unsigned long long l1tf_pfn_limit(void)
>  {
> -	return BIT(boot_cpu_data.x86_phys_bits - 1 - PAGE_SHIFT) - 1;
> +	return BIT_ULL(boot_cpu_data.x86_phys_bits - 1 - PAGE_SHIFT) - 1;
>  }
>  
>  extern void early_cpu_init(void);
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index acfab322fbe0..02de3d6065c4 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -923,7 +923,7 @@ unsigned long max_swapfile_size(void)
>  
>  	if (boot_cpu_has_bug(X86_BUG_L1TF)) {
>  		/* Limit the swap file size to MAX_PA/2 for L1TF workaround */
> -		unsigned long l1tf_limit = l1tf_pfn_limit() + 1;
> +		unsigned long long l1tf_limit = l1tf_pfn_limit() + 1;
>  		/*
>  		 * We encode swap offsets also with 3 bits below those for pfn
>  		 * which makes the usable limit higher.
> @@ -931,7 +931,7 @@ unsigned long max_swapfile_size(void)
>  #if CONFIG_PGTABLE_LEVELS > 2
>  		l1tf_limit <<= PAGE_SHIFT - SWP_OFFSET_FIRST_BIT;
>  #endif
> -		pages = min_t(unsigned long, l1tf_limit, pages);
> +		pages = min_t(unsigned long long, l1tf_limit, pages);
>  	}
>  	return pages;
>  }
> -- 
> 2.18.0

-- 
Michal Hocko
SUSE Labs
