Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756692AbeEJGjd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 02:39:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46736 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751313AbeEJGjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 02:39:32 -0400
Date: Thu, 10 May 2018 14:39:25 +0800
From: Baoquan He <bhe@redhat.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: ying.huang@intel.com, hpa@zytor.com, mingo@elte.hu,
        syzbot+d96f60296ef613fe1d69@syzkaller.appspotmail.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org,
        dyoung@redhat.com, mingo@redhat.com, prudo@linux.vnet.ibm.com,
        takahiro.akashi@linaro.org, tglx@linutronix.de,
        thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: [PATCH v3] x86/kexec: avoid double free_page() upon
 do_kexec_load() failure.
Message-ID: <20180510063925.GL30581@MiWiFi-R3L-srv>
References: <0000000000005dbad8056b20cabc@google.com>
 <cb42fdcd-7d00-373b-094f-4188956afc1d@I-love.SAKURA.ne.jp>
 <20180503232922.GE30581@MiWiFi-R3L-srv>
 <201805082026.CAD35992.LFMQtSVFFOOJOH@I-love.SAKURA.ne.jp>
 <201805091942.DGG12448.tMFVFSJFQOOLHO@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201805091942.DGG12448.tMFVFSJFQOOLHO@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/18 at 07:42pm, Tetsuo Handa wrote:
> >From ff82bedd3e12f0d3353282054ae48c3bd8c72012 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Wed, 9 May 2018 12:12:39 +0900
> Subject: [PATCH v3] x86/kexec: avoid double free_page() upon do_kexec_load() failure.
> 
> syzbot is reporting crashes after memory allocation failure inside
> do_kexec_load() [1]. This is because free_transition_pgtable() is called
> by both init_transition_pgtable() and machine_kexec_cleanup() when memory
> allocation failed inside init_transition_pgtable().
> 
> Regarding 32bit code, machine_kexec_free_page_tables() is called by both
> machine_kexec_alloc_page_tables() and machine_kexec_cleanup() when memory
> allocation failed inside machine_kexec_alloc_page_tables().
> 
> Fix this by leaving the error handling to machine_kexec_cleanup()
> (and optionally setting NULL after free_page()).
> 
> [1] https://syzkaller.appspot.com/bug?id=91e52396168cf2bdd572fe1e1bc0bc645c1c6b40
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+d96f60296ef613fe1d69@syzkaller.appspotmail.com>
> Fixes: f5deb79679af6eb4 ("x86: kexec: Use one page table in x86_64 machine_kexec")
> Fixes: 92be3d6bdf2cb349 ("kexec/i386: allocate page table pages dynamically")
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> ---
>  arch/x86/kernel/machine_kexec_32.c | 6 +++++-
>  arch/x86/kernel/machine_kexec_64.c | 5 ++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)

Looks good to me, thx!

Acked-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan

> 
> diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
> index 60cdec6..d1ab07e 100644
> --- a/arch/x86/kernel/machine_kexec_32.c
> +++ b/arch/x86/kernel/machine_kexec_32.c
> @@ -57,12 +57,17 @@ static void load_segments(void)
>  static void machine_kexec_free_page_tables(struct kimage *image)
>  {
>  	free_page((unsigned long)image->arch.pgd);
> +	image->arch.pgd = NULL;
>  #ifdef CONFIG_X86_PAE
>  	free_page((unsigned long)image->arch.pmd0);
> +	image->arch.pmd0 = NULL;
>  	free_page((unsigned long)image->arch.pmd1);
> +	image->arch.pmd1 = NULL;
>  #endif
>  	free_page((unsigned long)image->arch.pte0);
> +	image->arch.pte0 = NULL;
>  	free_page((unsigned long)image->arch.pte1);
> +	image->arch.pte1 = NULL;
>  }
>  
>  static int machine_kexec_alloc_page_tables(struct kimage *image)
> @@ -79,7 +84,6 @@ static int machine_kexec_alloc_page_tables(struct kimage *image)
>  	    !image->arch.pmd0 || !image->arch.pmd1 ||
>  #endif
>  	    !image->arch.pte0 || !image->arch.pte1) {
> -		machine_kexec_free_page_tables(image);
>  		return -ENOMEM;
>  	}
>  	return 0;
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index a5e55d8..6010449 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -39,9 +39,13 @@
>  static void free_transition_pgtable(struct kimage *image)
>  {
>  	free_page((unsigned long)image->arch.p4d);
> +	image->arch.p4d = NULL;
>  	free_page((unsigned long)image->arch.pud);
> +	image->arch.pud = NULL;
>  	free_page((unsigned long)image->arch.pmd);
> +	image->arch.pmd = NULL;
>  	free_page((unsigned long)image->arch.pte);
> +	image->arch.pte = NULL;
>  }
>  
>  static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
> @@ -91,7 +95,6 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
>  	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, PAGE_KERNEL_EXEC_NOENC));
>  	return 0;
>  err:
> -	free_transition_pgtable(image);
>  	return result;
>  }
>  
> -- 
> 1.8.3.1
