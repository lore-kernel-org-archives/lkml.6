Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeBZPsz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 10:48:55 -0500
Received: from foss.arm.com ([217.140.101.70]:52126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751961AbeBZPsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 10:48:53 -0500
Date: Mon, 26 Feb 2018 15:48:49 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        yamada.masahiro@socionext.com, mingo@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 08/12] arm64: cmpxchg: Include build_bug.h instead
 of bug.h for BUILD_BUG
Message-ID: <20180226154848.ejqxw5lkbiqqxlsf@salmiak>
References: <1519657500-15094-1-git-send-email-will.deacon@arm.com>
 <1519657500-15094-9-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519657500-15094-9-git-send-email-will.deacon@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 03:04:56PM +0000, Will Deacon wrote:
> Having asm/cmpxchg.h pull in linux/bug.h is problematic because this
> ends up pulling in the atomic bitops which themselves may be built on
> top of atomic.h and cmpxchg.h.
> 
> Instead, just include build_bug.h for the definition of BUILD_BUG.

We also use VM_BUG_ON(), defined in <linux/mmdebug.h>, which includes
<linux/bug.h>.

... so I think we still have some fragility here, albeit no worse than before.

We also miss includes for:

* <linux/percpu-defs.h> (raw_cpu_ptr)
* <linux/preempt.h> (preempt_disable, preempt_enable)
* <linux/compiler.h> (unreachable)

I'm not sure if those are made worse by this change.

Mark.

> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm64/include/asm/cmpxchg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
> index ae852add053d..bc9e07bc6428 100644
> --- a/arch/arm64/include/asm/cmpxchg.h
> +++ b/arch/arm64/include/asm/cmpxchg.h
> @@ -18,7 +18,7 @@
>  #ifndef __ASM_CMPXCHG_H
>  #define __ASM_CMPXCHG_H
>  
> -#include <linux/bug.h>
> +#include <linux/build_bug.h>
>  
>  #include <asm/atomic.h>
>  #include <asm/barrier.h>
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
