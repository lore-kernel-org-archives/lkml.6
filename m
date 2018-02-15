Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426672AbeBOQzC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:55:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:54589 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423681AbeBOQy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:54:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,517,1511856000";
   d="scan'208";a="18754099"
Subject: Re: [PATCH RFC v2 5/6] x86: Use global pages when PTI is disabled
To: Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>
References: <20180215163602.61162-1-namit@vmware.com>
 <20180215163602.61162-6-namit@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>,
        Nadav Amit <nadav.amit@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <10c21933-fe93-ccad-b315-2a7ca1e917a4@linux.intel.com>
Date: Thu, 15 Feb 2018 08:54:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180215163602.61162-6-namit@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/15/2018 08:36 AM, Nadav Amit wrote:
> As long as PTI is disabled, it is possible to use global pages, as long
> as we remove them once PTI is enabled again. To do so, return the global
> bit to __supported_pte_mask and disable global pages using CR4.
> 
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  arch/x86/include/asm/tlbflush.h |  6 ++++++
>  arch/x86/mm/init.c              | 14 ++++++--------
>  arch/x86/mm/tlb.c               |  3 ++-
>  3 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
> index ea65cf951c49..3a44cb0a9f56 100644
> --- a/arch/x86/include/asm/tlbflush.h
> +++ b/arch/x86/include/asm/tlbflush.h
> @@ -319,6 +319,12 @@ static inline void set_cpu_pti_disable(unsigned short disable)
>  	WARN_ON_ONCE(preemptible());
>  
>  	pti_update_user_cs64(cpu_pti_disable(), disable);
> +	if (__supported_pte_mask & _PAGE_GLOBAL) {
> +		if (disable)
> +			cr4_set_bits(X86_CR4_PGE);
> +		else
> +			cr4_clear_bits(X86_CR4_PGE);
> +	}
>  	this_cpu_write(cpu_tlbstate.pti_disable, disable);
>  }

The TLB invalidations when doing this switch are *CRITICAL*.  Otherwise,
we end up globally-mapped kernel entries persisting to other processes
that are then vulnerable to Meltdown.

So, where are the TLB flushes?

They're hidden in the cr4_set/clear_bits() function, of course.  This is
dangerous for two reasons because it makes them non-obvious and hard to
find.  It also has no interactions with the existing TLB invalidation
infrastructure.  That's _safe_ of course because extra flushing is OK,
but it feels really funky because you're going to end up double-flushing
on context switches which is rather unfortunate.

This also needs some heavy commenting about the fact that _PAGE_GLOBAL
is ignored when CR4.PGE=0.  That's key to this working and not mentioned
anywhere.

While this looks OK to me, it still makes me rather nervous.  The
changelog and commenting definitely need a lot of work.  I'm also still
rather unconvinced that the added complexity here is worth it.

> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index c67ef3fb4f35..979c7ec6baab 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -74,7 +74,8 @@ static void choose_new_asid(struct mm_struct *next, u64 next_tlb_gen,
>  		return;
>  	}
>  
> -	if (this_cpu_read(cpu_tlbstate.invalidate_other))
> +	if (this_cpu_read(cpu_tlbstate.invalidate_other) &&
> +	    !mm_pti_disable(next))
>  		clear_asid_other();

This isn't obviously correct.  Don't we still need to invalidate other
user asids?
