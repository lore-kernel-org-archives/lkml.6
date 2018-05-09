Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965641AbeEIVr2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 17:47:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965206AbeEIVr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 17:47:27 -0400
Date: Wed, 9 May 2018 14:47:26 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To: Roger Pau Monne <roger.pau@citrix.com>
cc: linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 3/3] xen: share start flags between PV and PVH
In-Reply-To: <20180509102129.14832-4-roger.pau@citrix.com>
Message-ID: <alpine.DEB.2.10.1805091447150.9199@sstabellini-ThinkPad-X260>
References: <20180509102129.14832-1-roger.pau@citrix.com> <20180509102129.14832-4-roger.pau@citrix.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1392289433-1525902447=:9199"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1392289433-1525902447=:9199
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 9 May 2018, Roger Pau Monne wrote:
> Use a global variable to store the start flags for both PV and PVH.
> This allows the xen_initial_domain macro to work properly on PVH.
> 
> Note that ARM is also switched to use the new variable.
> 
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: xen-devel@lists.xenproject.org
> ---
> Changes since v1:
>  - Switch ARM to also use the new xen_start_flags.

The ARM side looks good


> ---
>  arch/arm/xen/enlighten.c     | 7 ++++---
>  arch/x86/xen/enlighten.c     | 7 +++++++
>  arch/x86/xen/enlighten_pv.c  | 1 +
>  arch/x86/xen/enlighten_pvh.c | 1 +
>  include/xen/xen.h            | 4 +++-
>  5 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index ba7f4c8f5c3e..a99d5edf7bdf 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -59,6 +59,9 @@ struct xen_memory_region xen_extra_mem[XEN_EXTRA_MEM_MAX_REGIONS] __initdata;
>  
>  static __read_mostly unsigned int xen_events_irq;
>  
> +uint32_t xen_start_flags;
> +EXPORT_SYMBOL(xen_start_flags);
> +
>  int xen_remap_domain_gfn_array(struct vm_area_struct *vma,
>  			       unsigned long addr,
>  			       xen_pfn_t *gfn, int nr,
> @@ -282,9 +285,7 @@ void __init xen_early_init(void)
>  	xen_setup_features();
>  
>  	if (xen_feature(XENFEAT_dom0))
> -		xen_start_info->flags |= SIF_INITDOMAIN|SIF_PRIVILEGED;
> -	else
> -		xen_start_info->flags &= ~(SIF_INITDOMAIN|SIF_PRIVILEGED);
> +		xen_start_flags |= SIF_INITDOMAIN|SIF_PRIVILEGED;
>  
>  	if (!console_set_on_cmdline && !xen_initial_domain())
>  		add_preferred_console("hvc", 0, NULL);
> diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
> index c9081c6671f0..3b5318505c69 100644
> --- a/arch/x86/xen/enlighten.c
> +++ b/arch/x86/xen/enlighten.c
> @@ -64,6 +64,13 @@ struct shared_info xen_dummy_shared_info;
>  __read_mostly int xen_have_vector_callback;
>  EXPORT_SYMBOL_GPL(xen_have_vector_callback);
>  
> +/*
> + * NB: needs to live in .data because it's used by xen_prepare_pvh which runs
> + * before clearing the bss.
> + */
> +uint32_t xen_start_flags __attribute__((section(".data"))) = 0;
> +EXPORT_SYMBOL(xen_start_flags);
> +
>  /*
>   * Point at some empty memory to start with. We map the real shared_info
>   * page as soon as fixmap is up and running.
> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
> index c36d23aa6c35..04a6914b8b85 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -1227,6 +1227,7 @@ asmlinkage __visible void __init xen_start_kernel(void)
>  		return;
>  
>  	xen_domain_type = XEN_PV_DOMAIN;
> +	xen_start_flags = xen_start_info->flags;
>  
>  	xen_setup_features();
>  
> diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
> index e039d1809809..2653eb9b5dd8 100644
> --- a/arch/x86/xen/enlighten_pvh.c
> +++ b/arch/x86/xen/enlighten_pvh.c
> @@ -98,6 +98,7 @@ void __init xen_prepare_pvh(void)
>  	}
>  
>  	xen_pvh = 1;
> +	xen_start_flags = pvh_start_info.flags;
>  
>  	wrmsr_safe(MSR_MTRRdefType, 0x800 | MTRR_TYPE_WRBACK, 0);
>  
> diff --git a/include/xen/xen.h b/include/xen/xen.h
> index 9d4340c907d1..15fa01c50a53 100644
> --- a/include/xen/xen.h
> +++ b/include/xen/xen.h
> @@ -29,8 +29,10 @@ extern bool xen_pvh;
>  #include <xen/interface/xen.h>
>  #include <asm/xen/hypervisor.h>
>  
> +extern uint32_t xen_start_flags;
> +
>  #define xen_initial_domain()	(xen_domain() && \
> -				 xen_start_info && xen_start_info->flags & SIF_INITDOMAIN)
> +				 (xen_start_flags & SIF_INITDOMAIN))
>  #else  /* !CONFIG_XEN_DOM0 */
>  #define xen_initial_domain()	(0)
>  #endif	/* CONFIG_XEN_DOM0 */
> -- 
> 2.17.0
> 
--8323329-1392289433-1525902447=:9199--
