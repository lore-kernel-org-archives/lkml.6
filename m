Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbeBZSFz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 13:05:55 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53932 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751908AbeBZSFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 13:05:51 -0500
Date: Mon, 26 Feb 2018 18:05:52 +0000
From: Will Deacon <will.deacon@arm.com>
To: mattst88@gmail.com, rth@twiddle.net, tglx@linutronix.de, hpa@zytor.com,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        ink@jurassic.park.msu.ru, akpm@linux-foundation.org,
        paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: linux-tip-commits@vger.kernel.org
Subject: Re: [tip:locking/urgent] locking/xchg/alpha: Clean up barrier usage
 by using smp_mb() in place of __ASM__MB
Message-ID: <20180226180551.GM26147@arm.com>
References: <1519291469-5702-1-git-send-email-parri.andrea@gmail.com>
 <tip-79d442461df7478cdd0c50d9b8a76f431f150fa3@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-79d442461df7478cdd0c50d9b8a76f431f150fa3@git.kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

I know this is in mainline now, but I think the way you've got the barriers
here:

On Fri, Feb 23, 2018 at 12:27:54AM -0800, tip-bot for Andrea Parri wrote:
> diff --git a/arch/alpha/include/asm/cmpxchg.h b/arch/alpha/include/asm/cmpxchg.h
> index 46ebf14aed4e..8a2b331e43fe 100644
> --- a/arch/alpha/include/asm/cmpxchg.h
> +++ b/arch/alpha/include/asm/cmpxchg.h
> @@ -6,7 +6,6 @@
>   * Atomic exchange routines.
>   */
>  
> -#define __ASM__MB
>  #define ____xchg(type, args...)		__xchg ## type ## _local(args)
>  #define ____cmpxchg(type, args...)	__cmpxchg ## type ## _local(args)
>  #include <asm/xchg.h>
> @@ -33,10 +32,6 @@
>  	cmpxchg_local((ptr), (o), (n));					\
>  })
>  
> -#ifdef CONFIG_SMP
> -#undef __ASM__MB
> -#define __ASM__MB	"\tmb\n"
> -#endif
>  #undef ____xchg
>  #undef ____cmpxchg
>  #define ____xchg(type, args...)		__xchg ##type(args)
> @@ -64,7 +59,6 @@
>  	cmpxchg((ptr), (o), (n));					\
>  })
>  
> -#undef __ASM__MB
>  #undef ____cmpxchg
>  
>  #endif /* _ALPHA_CMPXCHG_H */
> diff --git a/arch/alpha/include/asm/xchg.h b/arch/alpha/include/asm/xchg.h
> index e2660866ce97..e1facf6fc244 100644
> --- a/arch/alpha/include/asm/xchg.h
> +++ b/arch/alpha/include/asm/xchg.h
> @@ -28,12 +28,12 @@ ____xchg(_u8, volatile char *m, unsigned long val)
>  	"	or	%1,%2,%2\n"
>  	"	stq_c	%2,0(%3)\n"
>  	"	beq	%2,2f\n"
> -		__ASM__MB
>  	".subsection 2\n"
>  	"2:	br	1b\n"
>  	".previous"
>  	: "=&r" (ret), "=&r" (val), "=&r" (tmp), "=&r" (addr64)
>  	: "r" ((long)m), "1" (val) : "memory");
> +	smp_mb();
>  
>  	return ret;

ends up adding unnecessary barriers to the _local variants, which the
previous code took care to avoid. That's why I suggesting adding
the smp_mb() into the cmpxchg macro rather than the ____cmpxchg variants.

I think it's worth spinning another patch to fix this properly.

Will
