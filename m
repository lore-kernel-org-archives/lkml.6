Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756813AbeDZQDC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:03:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:52893 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756519AbeDZQDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:03:01 -0400
Date: Thu, 26 Apr 2018 18:02:58 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
        npiggin@gmail.com
Subject: Re: [PATCH 4/6] powerpc/64s: Enable barrier_nospec based on
 firmware settings
Message-ID: <20180426180258.04e6bee6@kitsune.suse.cz>
In-Reply-To: <20180424041559.32410-4-mpe@ellerman.id.au>
References: <20180424041559.32410-1-mpe@ellerman.id.au>
        <20180424041559.32410-4-mpe@ellerman.id.au>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, 24 Apr 2018 14:15:57 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> From: Michal Suchanek <msuchanek@suse.de>
> 
> Check what firmware told us and enable/disable the barrier_nospec as
> appropriate.
> 
> We err on the side of enabling the barrier, as it's no-op on older
> systems, see the comment for more detail.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/setup.h       |  1 +
>  arch/powerpc/kernel/security.c         | 60
> ++++++++++++++++++++++++++++++++++
> arch/powerpc/platforms/powernv/setup.c |  1 +
> arch/powerpc/platforms/pseries/setup.c |  1 + 4 files changed, 63
> insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/setup.h
> b/arch/powerpc/include/asm/setup.h index 4335cddc1cf2..aeb175e8a525
> 100644 --- a/arch/powerpc/include/asm/setup.h
> +++ b/arch/powerpc/include/asm/setup.h
> @@ -52,6 +52,7 @@ enum l1d_flush_type {
>  
>  void setup_rfi_flush(enum l1d_flush_type, bool enable);
>  void do_rfi_flush_fixups(enum l1d_flush_type types);
> +void setup_barrier_nospec(void);
>  void do_barrier_nospec_fixups(bool enable);
>  
>  #ifdef CONFIG_PPC_BOOK3S_64
> diff --git a/arch/powerpc/kernel/security.c
> b/arch/powerpc/kernel/security.c index b963eae0b0a0..d1b9639e5e24
> 100644 --- a/arch/powerpc/kernel/security.c
> +++ b/arch/powerpc/kernel/security.c
> @@ -8,6 +8,7 @@
>  #include <linux/device.h>
>  #include <linux/seq_buf.h>
>  
> +#include <asm/debugfs.h>
>  #include <asm/security_features.h>
>  #include <asm/setup.h>
>  
> @@ -22,6 +23,65 @@ static void enable_barrier_nospec(bool enable)
>  	do_barrier_nospec_fixups(enable);
>  }
>  
> +void setup_barrier_nospec(void)
> +{
> +	bool enable;
> +
> +	/*
> +	 * It would make sense to check SEC_FTR_SPEC_BAR_ORI31 below
> as well.
> +	 * But there's a good reason not to. The two flags we check
> below are
> +	 * both are enabled by default in the kernel, so if the
> hcall is not
> +	 * functional they will be enabled.
> +	 * On a system where the host firmware has been updated (so
> the ori
> +	 * functions as a barrier), but on which the hypervisor
> (KVM/Qemu) has
> +	 * not been updated, we would like to enable the barrier.
> Dropping the
> +	 * check for SEC_FTR_SPEC_BAR_ORI31 achieves that. The only
> downside is
> +	 * we potentially enable the barrier on systems where the
> host firmware
> +	 * is not updated, but that's harmless as it's a no-op.
> +	 */
> +	enable = security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) &&
> +		 security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR);
> +
> +	enable_barrier_nospec(enable);
> +}

I am missing the option for the barrier to be disabled by a kernel
commandline argument here.

It does make sense to add a kernel parameter that is checked on boot to
be compatible with other platforms that implement one.

Thanks

Michal
