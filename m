Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753306AbeDRN5G (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 09:57:06 -0400
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:34065 "EHLO
        mail.osadl.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbeDRN5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 09:57:05 -0400
Date: Wed, 18 Apr 2018 13:49:51 +0000
From: Nicholas Mc Guire <der.herr@hofr.at>
To: Philipp Klocke <Phil_K97@gmx.de>
Cc: lukas.bulwahn@gmail.com, kernelnewbies@kernelnewbies.org,
        llvmlinux@lists.linuxfoundation.org, sil2review@lists.osadl.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Change sched_feat(x) in !CONFIG_SCHED_DEBUG
 case
Message-ID: <20180418134951.GA7289@osadl.at>
References: <20180416085426.24157-1-Phil_K97@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416085426.24157-1-Phil_K97@gmx.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 10:54:26AM +0200, Philipp Klocke wrote:
> Make sched_feat(x) return 1 or 0 instead of 2**x or 0 when
> sysctl_sched_features is constant, by changing the left shift of the
> mask-bit to a right shift of the bitmap. The behaviour of the code
> remains unchanged.
> We prove this by showing that the compiler can evaluate this shift
> during compile time, which results in generating the same
> machine code as before.
> 
> This patch is motivated by the clang warning Wconstant-logical-operand,
> issued when logically comparing a variable to a constant integer that is
> neither 1 nor 0.  It happens for sched_feat(x) when sysctl_sched_features
> is constant, i.e., CONFIG_SCHED_DEBUG is not set.
> 
> kernel/sched/fair.c:3927:14: warning: use of logical '&&' with constant operand [-Wconstant-logical-operand]
>         if (initial && sched_feat(START_DEBIT))
>                     ^  ~~~~~~~~~~~~~~~~~~~~~~~
> kernel/sched/fair.c:3927:14: note: use '&' for a bitwise operation
>         if (initial && sched_feat(START_DEBIT))
>                     ^~
>                     &
> kernel/sched/fair.c:3927:14: note: remove constant to silence this warning
>         if (initial && sched_feat(START_DEBIT))
>                    ~^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This resolves the warning, leaves the code base largely as is.
> 
> Tested with gcc 7.3.1 and clang 6.0.0 on x86_64, comparing resulting
> binaries with diff.
> Applicable to all modern compilers and architectures
> 
> Signed-off-by: Philipp Klocke <Phil_K97@gmx.de>
> Suggested-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Reviewed-by: Nicholas Mc Guire <der.herr@hofr.at>

> ---
>  kernel/sched/sched.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index fb5fc458547f..d2aedee6ab0f 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1305,7 +1305,11 @@ static const_debug __maybe_unused unsigned int sysctl_sched_features =
>  	0;
>  #undef SCHED_FEAT
>  
> +#ifdef CONFIG_SCHED_DEBUG
>  #define sched_feat(x) (sysctl_sched_features & (1UL << __SCHED_FEAT_##x))
> +#else
> +#define sched_feat(x) ((sysctl_sched_features >> __SCHED_FEAT_##x) & 1UL)
> +#endif
>  

The changed sched_feat(y) line is fine but I do not get/like the 
of the ifdef - keeping the change minimal is ok if there is a
relevant impact but here there is no effective difference (you write
the object code is the same for the !CONFIG_SCHED_DEBUG case)
So I think the ifdef should be kicked here and the proposed change
seems fine to me.

>  #endif /* SCHED_DEBUG && HAVE_JUMP_LABEL */
>  
> -- 
> 2.17.0
> 
