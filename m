Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26660C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8D120C07
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:56:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC8D120C07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbeHWR0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 13:26:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:54552 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729973AbeHWR0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 13:26:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 57B02AD16;
        Thu, 23 Aug 2018 13:56:34 +0000 (UTC)
Date:   Thu, 23 Aug 2018 15:56:33 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>, stable@vger.kernel.org,
        Christopher Snowhill <kode54@gmail.com>,
        xxxxxx xxxxxx <xxxxxx@xxxxxx.xxx>
Subject: Re: [PATCH] x86/speculation/l1tf: fix off-by-one error when warning
 that system has too much RAM
Message-ID: <20180823135633.GN29735@dhcp22.suse.cz>
References: <20180823134418.17008-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823134418.17008-1-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23-08-18 15:44:18, Vlastimil Babka wrote:
> Two users have reported [1] that they have an "extremely unlikely" system
> with more than MAX_PA/2 memory and L1TF mitigation is not effective. In fact
> it's a CPU with 36bits phys limit (64GB) and 32GB memory, but due to holes
> in the e820 map, the main region is almost 500MB over the 32GB limit:
> 
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000081effffff] usable
> 
> Suggestions to use 'mem=32G' to prefer L1TF mitigation while losing the 500MB
> revealed, that there's an off-by-one error in the check in
> l1tf_select_mitigation(). l1tf_pfn_limit() returns the last usable pfn
> (inclusive), but it's more common and hopefully less error-prone to return the
> first pfn that's over limit, so this patch changes that and updates the other
> callers.
> 
> [1] https://bugzilla.suse.com/show_bug.cgi?id=1105536
> 
> Reported-by: xxxxxx xxxxxx <xxxxxx@xxxxxx.xxx>
> Reported-by: Christopher Snowhill <kode54@gmail.com>
> Fixes: 17dbca119312 ("x86/speculation/l1tf: Add sysfs reporting for l1tf")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Yes this should be less error prone.
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  arch/x86/include/asm/processor.h | 2 +-
>  arch/x86/mm/init.c               | 2 +-
>  arch/x86/mm/mmap.c               | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index a0a52274cb4a..c24297268ebc 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -183,7 +183,7 @@ extern void cpu_detect(struct cpuinfo_x86 *c);
>  
>  static inline unsigned long long l1tf_pfn_limit(void)
>  {
> -	return BIT_ULL(boot_cpu_data.x86_phys_bits - 1 - PAGE_SHIFT) - 1;
> +	return BIT_ULL(boot_cpu_data.x86_phys_bits - 1 - PAGE_SHIFT);
>  }
>  
>  extern void early_cpu_init(void);
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index 02de3d6065c4..63a6f9fcaf20 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -923,7 +923,7 @@ unsigned long max_swapfile_size(void)
>  
>  	if (boot_cpu_has_bug(X86_BUG_L1TF)) {
>  		/* Limit the swap file size to MAX_PA/2 for L1TF workaround */
> -		unsigned long long l1tf_limit = l1tf_pfn_limit() + 1;
> +		unsigned long long l1tf_limit = l1tf_pfn_limit();
>  		/*
>  		 * We encode swap offsets also with 3 bits below those for pfn
>  		 * which makes the usable limit higher.
> diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
> index f40ab8185d94..1e95d57760cf 100644
> --- a/arch/x86/mm/mmap.c
> +++ b/arch/x86/mm/mmap.c
> @@ -257,7 +257,7 @@ bool pfn_modify_allowed(unsigned long pfn, pgprot_t prot)
>  	/* If it's real memory always allow */
>  	if (pfn_valid(pfn))
>  		return true;
> -	if (pfn > l1tf_pfn_limit() && !capable(CAP_SYS_ADMIN))
> +	if (pfn >= l1tf_pfn_limit() && !capable(CAP_SYS_ADMIN))
>  		return false;
>  	return true;
>  }
> -- 
> 2.18.0

-- 
Michal Hocko
SUSE Labs
