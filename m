Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751726AbeAaTlN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 14:41:13 -0500
Received: from mga09.intel.com ([134.134.136.24]:32795 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751296AbeAaTlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 14:41:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,441,1511856000";
   d="scan'208";a="170672685"
Subject: Re: [PATCH] x86/mm: Rename flush_tlb_single() and flush_tlb_one()
To: Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org
References: <3303b02e3c3d049dc5235d5651e0ae6d29a34354.1517414378.git.luto@kernel.org>
Cc: linux-mm@kvack.org, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bpetkov@suse.de>, Kees Cook <keescook@google.com>,
        Hugh Dickins <hughd@google.com>, Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, Rik van Riel <riel@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Eduardo Valentin <eduval@amazon.com>,
        Will Deacon <will.deacon@arm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <032133ea-0f5a-379a-2bff-58142518a96e@intel.com>
Date: Wed, 31 Jan 2018 11:41:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <3303b02e3c3d049dc5235d5651e0ae6d29a34354.1517414378.git.luto@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -437,18 +437,31 @@ static inline void __flush_tlb_all(void)
>  /*
>   * flush one page in the kernel mapping
>   */
> -static inline void __flush_tlb_one(unsigned long addr)
> +static inline void __flush_tlb_one_kernel(unsigned long addr)
>  {
>  	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ONE);
> -	__flush_tlb_single(addr);
> +
> +	/*
> +	 * If PTI is off, then __flush_tlb_one_user() is just INVLPG or its
> +	 * paravirt equivalent.  Even with PCID, this is sufficient: we only
> +	 * use PCID if we also use global PTEs for the kernel mapping, and
> +	 * INVLPG flushes global translations across all address spaces.

This looks good.

> +	 * If PTI is on, then the kernel is mapped with non-global PTEs, and
> +	 * __flush_tlb_one_user() will flush the given address for the current
> +	 * kernel address space and for its usermode counterpart, but it goes
> +	 * not flush it for other address spaces.
> +	 */
> +	__flush_tlb_one_user(addr);

s/goes/does/

It also goes off and flushes the address out of the user asid.  That
_seems_ a bit goofy, but it is needed for addresses that might be mapped
into the user asid, so it's definitely safe.  Might be worth calling out.

Maybe add a (if one exists) or something like:

... kernel address space and for its usermode counterpart (if one exists).

>  	if (!static_cpu_has(X86_FEATURE_PTI))
>  		return;
>  
>  	/*
> -	 * __flush_tlb_single() will have cleared the TLB entry for this ASID,
> -	 * but since kernel space is replicated across all, we must also
> -	 * invalidate all others.
> +	 * See above.  We need to propagate the flush to all other address
> +	 * spaces.  In principle, we only need to propagate it to kernelmode
> +	 * address spaces, but the extra bookkeeping we would need is not
> +	 * worth it.
>  	 */
>  	invalidate_other_asid();
>  }

That comment is true, except if we were invalidating a user-mapped
address.  Right?

We've just been pretending so far for the purposes of TLB invalidation
that all kernel addresses are potentially user-mapped.

The name change looks really good to me, though.  Thanks for doing this.
