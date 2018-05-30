Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935522AbeE3GF4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 02:05:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50628 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933788AbeE3GFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 02:05:55 -0400
Date: Wed, 30 May 2018 07:05:47 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: mingo@kernel.org, tglx@linutronix.de, stable@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/spectre_v1: Disable compiler optimizations over
 array_index_mask_nospec()
Message-ID: <20180530060546.jnjoltsturoduohh@salmiak>
References: <152726886796.10827.14538693708255560877.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152726886796.10827.14538693708255560877.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On Fri, May 25, 2018 at 10:21:08AM -0700, Dan Williams wrote:
> Mark notes that gcc optimization passes have the potential to elide
> necessary invocations of this instruction sequence, so include an
> optimization barrier.
> 
>     > I think that either way, we have a potential problem if the compiler
>     > generates a branch dependent on the result of validate_index_nospec().
>     >
>     > In that case, we could end up with codegen approximating:
>     >
>     >       bool safe = false;
>     >
>     >       if (idx < bound) {
>     >               idx = array_index_nospec(idx, bound);
>     >               safe = true;
>     >       }
>     >
>     >       // this branch can be mispredicted
>     >       if (safe) {
>     >               foo = array[idx];
>     >       }
>     >
>     > ... and thus we lose the nospec protection.
> 
>     I see GCC do this at -O0, but so far I haven't tricked it into doing
>     this at -O1 or above.
> 
>     Regardless, I worry this is fragile -- GCC *can* generate code as per
>     the above, even if it's unlikely to.

I certainly believe that we want the volatile.

However, just to be clear, the barrier doesn't prevent the above example, since
we don't currently have a mechanism to prevent the compiler splitting basic
blocks and inserting additional branches between those blocks.

I've written up a rationale for the volatile below, if you want something for
the commit message. There's a minor comment on the patch after that.

----
The volatile will inhibit *some* cases where the compiler could lift the
array_index_nospec() call out of a branch, e.g. where there are multiple
invocations of array_index_nospec() with the same arguments:

	if (idx < foo) {
		idx1 = array_idx_nospec(idx, foo)
		do_something(idx1);
	}

	< some other code >

	if (idx < foo) {
		idx2 = array_idx_nospec(idx, foo);
		do_something_else(idx2);
	}

... since the compiler can determine that the two invocations yield the same
result, and reuse the first result (likely the same register as idx was in
originally) for the second branch, effectively re-writing the above as:


	if (idx < foo) {
		idx = array_idx_nospec(idx, foo);
		do_something(idx);
	}

	< some other code >

	if (idx < foo) {
		do_something_else(idx);
	}
	
... if we don't take the first branch, then speculatively take the second, we
lose the nospec protection.

There's more info on volatile asm in the GCC docs:

https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Volatile
----

> Cc: <stable@vger.kernel.org>
> Fixes: babdde2698d4 ("x86: Implement array_index_mask_nospec")
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/x86/include/asm/barrier.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
> index 042b5e892ed1..41f7435c84a7 100644
> --- a/arch/x86/include/asm/barrier.h
> +++ b/arch/x86/include/asm/barrier.h
> @@ -38,10 +38,11 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
>  {
>  	unsigned long mask;
>  
> -	asm ("cmp %1,%2; sbb %0,%0;"
> +	asm volatile ("cmp %1,%2; sbb %0,%0;"
>  			:"=r" (mask)
>  			:"g"(size),"r" (index)
>  			:"cc");
> +	barrier();
>  	return mask;
>  }

What does the barrier() prevent?

I don't think that inhibits the insertion of branches, and AFAIK the volatile
is sufficient to prevent elision of identical array_idx_nospec() calls.

I don't have an objection to it, regardless.

So long as the example is updated in the commit message, feel free to add:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
