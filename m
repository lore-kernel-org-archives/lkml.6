Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id O3+5GfKqGltrUAAAmS7hNA
	; Fri, 08 Jun 2018 16:12:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4C0AA607E4; Fri,  8 Jun 2018 16:12:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vSuuZA85"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7F54D60590;
	Fri,  8 Jun 2018 16:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7F54D60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752883AbeFHQMc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 12:12:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752794AbeFHQM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 12:12:28 -0400
Received: from [10.0.0.125] (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 486862087F;
        Fri,  8 Jun 2018 16:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528474347;
        bh=W63DnBXMtJaIpBXswyj8ua5HygdZI15YfngkLL6d6Mc=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=vSuuZA855xUsw1X96m1zoiF1fAuGZOZFOg4Zs3OCk9nlBA5G+Vz7BKcIJFuhbL7fg
         a5TaO8Cb0Yt8OSGz8cwido49qUOnOSkiV12O/Ws/XwSGV17Z6EG8/D+8b9/2Z8x1wm
         OQ0kEkX3e9OidRkgh0wU4O5APODUFnLkwdqO71OI=
Date: Fri, 8 Jun 2018 09:12:25 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-X260
To: Roger Pau Monne <roger.pau@citrix.com>
cc: linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH v3] xen: share start flags between PV and PVH
In-Reply-To: <20180608084038.19344-1-roger.pau@citrix.com>
Message-ID: <alpine.DEB.2.10.1806080909320.14699@sstabellini-ThinkPad-X260>
References: <20180608084038.19344-1-roger.pau@citrix.com>
User-Agent: Alpine 2.10 (DEB 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1478822903-1528474284=:14699"
Content-ID: <alpine.DEB.2.10.1806080911340.14699@sstabellini-ThinkPad-X260>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1478822903-1528474284=:14699
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.10.1806080911341.14699@sstabellini-ThinkPad-X260>

On Fri, 8 Jun 2018, Roger Pau Monne wrote:
> Use a global variable to store the start flags for both PV and PVH.
> This allows the xen_initial_domain macro to work properly on PVH.
> 
> Note that ARM is also switched to use the new variable.
> 
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>

As I already mentioned, the ARM part is OK. However, is the issue that
xen_start_info is not available on PVH? We had the same problem on ARM
and solved it by faking a xen_start_info page, see the top of
arch/arm/xen/enlighten.c.

I would love to get rid of that, but to do that, we also need to remove
the xen_start_info referece at drivers/tty/hvc/hvc_xen.c:255:

  if (!xen_start_info->console.domU.evtchn)
		return -ENODEV;


> ---
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: xen-devel@lists.xenproject.org
> ---
> Changes since v2:
>  - Declare xen_start_flags outside of the XEN_DOM0 guard and include
>    types.h.
> 
> Changes since v1:
>  - Switch ARM to also use the new xen_start_flags.
> ---
>  arch/arm/xen/enlighten.c     | 7 ++++---
>  arch/x86/xen/enlighten.c     | 7 +++++++
>  arch/x86/xen/enlighten_pv.c  | 1 +
>  arch/x86/xen/enlighten_pvh.c | 1 +
>  include/xen/xen.h            | 6 +++++-
>  5 files changed, 18 insertions(+), 4 deletions(-)
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
> index 357969a3697c..8d4e2e1ae60b 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -1203,6 +1203,7 @@ asmlinkage __visible void __init xen_start_kernel(void)
>  		return;
>  
>  	xen_domain_type = XEN_PV_DOMAIN;
> +	xen_start_flags = xen_start_info->flags;
>  
>  	xen_setup_features();
>  
> diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
> index aa1c6a6831a9..c85d1a88f476 100644
> --- a/arch/x86/xen/enlighten_pvh.c
> +++ b/arch/x86/xen/enlighten_pvh.c
> @@ -97,6 +97,7 @@ void __init xen_prepare_pvh(void)
>  	}
>  
>  	xen_pvh = 1;
> +	xen_start_flags = pvh_start_info.flags;
>  
>  	msr = cpuid_ebx(xen_cpuid_base() + 2);
>  	pfn = __pa(hypercall_page);
> diff --git a/include/xen/xen.h b/include/xen/xen.h
> index 9d4340c907d1..1e1d9bd0bd37 100644
> --- a/include/xen/xen.h
> +++ b/include/xen/xen.h
> @@ -25,12 +25,16 @@ extern bool xen_pvh;
>  #define xen_hvm_domain()	(xen_domain_type == XEN_HVM_DOMAIN)
>  #define xen_pvh_domain()	(xen_pvh)
>  
> +#include <linux/types.h>
> +
> +extern uint32_t xen_start_flags;
> +
>  #ifdef CONFIG_XEN_DOM0
>  #include <xen/interface/xen.h>
>  #include <asm/xen/hypervisor.h>
>  
>  #define xen_initial_domain()	(xen_domain() && \
> -				 xen_start_info && xen_start_info->flags & SIF_INITDOMAIN)
> +				 (xen_start_flags & SIF_INITDOMAIN))
>  #else  /* !CONFIG_XEN_DOM0 */
>  #define xen_initial_domain()	(0)
>  #endif	/* CONFIG_XEN_DOM0 */
> -- 
> 2.17.1
> 
--8323329-1478822903-1528474284=:14699--
