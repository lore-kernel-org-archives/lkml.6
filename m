Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbeEDAcR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 20:32:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750930AbeEDAcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 20:32:15 -0400
Date: Fri, 4 May 2018 08:32:04 +0800
From: Baoquan He <bhe@redhat.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: syzbot <syzbot+d96f60296ef613fe1d69@syzkaller.appspotmail.com>,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Huang Ying <ying.huang@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>,
        akpm@linux-foundation.org, dyoung@redhat.com, mingo@redhat.com,
        prudo@linux.vnet.ibm.com, takahiro.akashi@linaro.org,
        tglx@linutronix.de, thomas.lendacky@amd.com, x86@kernel.org
Subject: Re: kernel BUG at include/linux/mm.h:LINE!
Message-ID: <20180503232922.GE30581@MiWiFi-R3L-srv>
References: <0000000000005dbad8056b20cabc@google.com>
 <cb42fdcd-7d00-373b-094f-4188956afc1d@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb42fdcd-7d00-373b-094f-4188956afc1d@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/18 at 07:10pm, Tetsuo Handa wrote:
> From d54b2acf63191eba3d5052bf34fe6d26e3580ac2 Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Tue, 1 May 2018 15:36:52 +0900
> Subject: [PATCH] x86/kexec: avoid double free_page() upon do_kexec_load()
>  failure.
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
> Fix this by explicitly setting NULL after free_page().

Setting them NULL after free_page() is a good idea. Maybe can remove the
double calling of free_transition_pgtable() too in init_transition_pgtable()
because the returned value will trigger the later calling.

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
>  arch/x86/kernel/machine_kexec_32.c | 5 +++++
>  arch/x86/kernel/machine_kexec_64.c | 4 ++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
> index 60cdec6..ceccfe4 100644
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
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index a5e55d8..76aaee9 100644
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
> -- 
> 1.8.3.1
> 
