Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935727AbeE3F6W (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 01:58:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39333 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933788AbeE3F6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 01:58:20 -0400
X-Google-Smtp-Source: ADUXVKKlHQQ1yibVOsppi6t7eH9EZ01x7LBNf1TR8p2gBLyR5xcdD3tOduUmalV1p2iM0+dwG+3iVQ==
Date: Wed, 30 May 2018 07:58:15 +0200
From: Ingo Molnar <mingo@kernel.org>
To: nixiaoming <nixiaoming@huawei.com>
Cc: catalin.marinas@arm.com, will.deacon@arm.com,
        ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com,
        kristina.martsenko@arm.com, steve.capper@arm.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, akpm@linux-foundation.org,
        vbabka@suse.cz, mhocko@suse.com, dave.hansen@linux.intel.com,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        zhang.jia@linux.alibaba.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/3] x86:add missing CONFIG_STRICT_KERNEL_RWX for
 mark_rodata_ro
Message-ID: <20180530055815.GB6463@gmail.com>
References: <20180529133622.26982-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529133622.26982-1-nixiaoming@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* nixiaoming <nixiaoming@huawei.com> wrote:

> mark_rodata_ro is only called by the function mark_readonly
> when CONFIG_STRICT_KERNEL_RWX=y
> 
> if CONFIG_STRICT_KERNEL_RWX is not set
> a compile warning may be triggered: unused function
> 
> Signed-off-by: nixiaoming <nixiaoming@huawei.com>
> ---
>  arch/x86/mm/init_32.c | 2 ++
>  arch/x86/mm/init_64.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
> index c893c6a..121c567 100644
> --- a/arch/x86/mm/init_32.c
> +++ b/arch/x86/mm/init_32.c
> @@ -920,6 +920,7 @@ static void mark_nxdata_nx(void)
>  	set_pages_nx(virt_to_page(start), size >> PAGE_SHIFT);
>  }
>  
> +#ifdef CONFIG_STRICT_KERNEL_RWX
>  void mark_rodata_ro(void)
>  {
>  	unsigned long start = PFN_ALIGN(_text);
> @@ -957,3 +958,4 @@ void mark_rodata_ro(void)
>  	if (__supported_pte_mask & _PAGE_NX)
>  		debug_checkwx();
>  }
> +#endif /*end of CONFIG_STRICT_KERNEL_RWX*/
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 0a40060..1b7a1a7 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1245,6 +1245,7 @@ void set_kernel_text_ro(void)
>  	set_memory_ro(start, (end - start) >> PAGE_SHIFT);
>  }
>  
> +#ifdef CONFIG_STRICT_KERNEL_RWX
>  void mark_rodata_ro(void)
>  {
>  	unsigned long start = PFN_ALIGN(_text);
> @@ -1298,6 +1299,7 @@ void mark_rodata_ro(void)
>  	 */
>  	pti_clone_kernel_text();
>  }
> +#endif

NAK, this is very ugly and the changelog doesn't appear to be true: the build 
warning does not trigger in the default build, correct?

Thanks,

	Ingo
