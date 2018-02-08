Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeBHKOX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 05:14:23 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:64752 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752212AbeBHKOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 05:14:21 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: x86@kernel.org, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Len Brown <len.brown@intel.com>,
        Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] x86: fix swsusp_arch_resume prototype
Date: Thu, 08 Feb 2018 11:12:38 +0100
Message-ID: <2199353.ODa2DYVeeo@aspire.rjw.lan>
In-Reply-To: <20180202145634.200291-2-arnd@arndb.de>
References: <20180202145434.100626-1-arnd@arndb.de> <20180202145634.200291-1-arnd@arndb.de> <20180202145634.200291-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, February 2, 2018 3:56:18 PM CET Arnd Bergmann wrote:
> The declaration for swsusp_arch_resume marks it as 'asmlinkage',
> but the definition in x86-32 does not, and it fails to include
> the header with the declaration. This leads to a warning when
> building with link-time-optimizations:
> 
> kernel/power/power.h:108:23: error: type of 'swsusp_arch_resume' does not match original declaration [-Werror=lto-type-mismatch]
>  extern asmlinkage int swsusp_arch_resume(void);
>                        ^
> arch/x86/power/hibernate_32.c:148:0: note: 'swsusp_arch_resume' was previously declared here
>  int swsusp_arch_resume(void)
> 
> This moves the declaration into a globally visible header file
> and fixes up both x86 definitions to match it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/x86/power/hibernate_32.c | 2 +-
>  arch/x86/power/hibernate_64.c | 2 +-
>  include/linux/suspend.h       | 2 ++
>  kernel/power/power.h          | 3 ---
>  4 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/power/hibernate_32.c b/arch/x86/power/hibernate_32.c
> index c35fdb585c68..afc4ed7b1578 100644
> --- a/arch/x86/power/hibernate_32.c
> +++ b/arch/x86/power/hibernate_32.c
> @@ -145,7 +145,7 @@ static inline void resume_init_first_level_page_table(pgd_t *pg_dir)
>  #endif
>  }
>  
> -int swsusp_arch_resume(void)
> +asmlinkage int swsusp_arch_resume(void)
>  {
>  	int error;
>  
> diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
> index f910c514438f..0ef5e5204968 100644
> --- a/arch/x86/power/hibernate_64.c
> +++ b/arch/x86/power/hibernate_64.c
> @@ -174,7 +174,7 @@ static int relocate_restore_code(void)
>  	return 0;
>  }
>  
> -int swsusp_arch_resume(void)
> +asmlinkage int swsusp_arch_resume(void)
>  {
>  	int error;
>  
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index cc22a24516d6..440b62f7502e 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -384,6 +384,8 @@ extern int swsusp_page_is_forbidden(struct page *);
>  extern void swsusp_set_page_free(struct page *);
>  extern void swsusp_unset_page_free(struct page *);
>  extern unsigned long get_safe_page(gfp_t gfp_mask);
> +extern asmlinkage int swsusp_arch_suspend(void);
> +extern asmlinkage int swsusp_arch_resume(void);
>  
>  extern void hibernation_set_ops(const struct platform_hibernation_ops *ops);
>  extern int hibernate(void);
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index f29cd178df90..9e58bdc8a562 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -104,9 +104,6 @@ extern int in_suspend;
>  extern dev_t swsusp_resume_device;
>  extern sector_t swsusp_resume_block;
>  
> -extern asmlinkage int swsusp_arch_suspend(void);
> -extern asmlinkage int swsusp_arch_resume(void);
> -
>  extern int create_basic_memory_bitmaps(void);
>  extern void free_basic_memory_bitmaps(void);
>  extern int hibernate_preallocate_memory(void);
> 

Applied, thanks!
