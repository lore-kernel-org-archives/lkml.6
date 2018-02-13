Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934954AbeBMLta (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 06:49:30 -0500
Received: from ozlabs.org ([103.22.144.67]:40119 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934231AbeBMLt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:49:28 -0500
From: Michael Ellerman <mpe@ellerman.id.au>
To: Guenter Roeck <linux@roeck-us.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/kdump: Add missing optional dummy functions
In-Reply-To: <1518474848-3158-1-git-send-email-linux@roeck-us.net>
References: <1518474848-3158-1-git-send-email-linux@roeck-us.net>
Date: Tue, 13 Feb 2018 22:49:22 +1100
Message-ID: <877erh2jp9.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> writes:

> If KEXEC_CORE is not enabled, PowerNV builds fail as follows.
>
> arch/powerpc/platforms/powernv/smp.c: In function 'pnv_smp_cpu_kill_self':
> arch/powerpc/platforms/powernv/smp.c:236:4: error:
> 	implicit declaration of function 'crash_ipi_callback'
>
> Add dummy function calls, similar to kdump_in_progress(), to solve the
> problem.
>
> Fixes: 4145f358644b ("powernv/kdump: Fix cases where the kdump kernel ...")

Personally I prefer these untruncated.

> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/powerpc/include/asm/kexec.h | 6 ++++++
>  1 file changed, 6 insertions(+)

Thanks. Nathan sent a fix for this a few days ago, but I like this
version because it uses the existing #ifdefs.

I've taken this version but used the subject from his patch.

cheers

> diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
> index 9dcbfa6bbb91..d8b1e8e7e035 100644
> --- a/arch/powerpc/include/asm/kexec.h
> +++ b/arch/powerpc/include/asm/kexec.h
> @@ -140,6 +140,12 @@ static inline bool kdump_in_progress(void)
>  	return false;
>  }
>  
> +static inline void crash_ipi_callback(struct pt_regs *regs) { }
> +
> +static inline void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
> +{
> +}
> +
>  #endif /* CONFIG_KEXEC_CORE */
>  #endif /* ! __ASSEMBLY__ */
>  #endif /* __KERNEL__ */
> -- 
> 2.7.4
