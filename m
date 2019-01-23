Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97EFC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 05:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDA2217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 05:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548220533;
	bh=OSiRo2aClblcsUW7mK8Fq8Rs89gg9wZmGZD96JQp9yg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pv5el9z8fafYpDE019VUIsSnSDFXcGEVH6gRlwqWbEvia5tu5iN4eBk5cw2hKyS1s
	 JpPr/tq9BrcCmFlht7bBVf/v/vY2C0b6jXhKcPXwRx8TmZx343nXFl8A7Jix4mzPto
	 fgDhXxvn63YOj89+ctl0y8rG/wqc5N1SljGfPR+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfAWFPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 00:15:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:49794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfAWFPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 00:15:31 -0500
Received: from devnote (p105099-mobac01.tokyo.ocn.ne.jp [153.233.96.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B2D821726;
        Wed, 23 Jan 2019 05:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548220529;
        bh=OSiRo2aClblcsUW7mK8Fq8Rs89gg9wZmGZD96JQp9yg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LEcSR5RV2xbMeWGX4IdQpKRTxW75hK6dhEqzbmACTxiom2DTDqwlqIM3MRunbxxAi
         77wuGErpF517PTL4ud+ro7bb9mwcdLX8rFAb+738mDnYsqe+kPPKs8Bgah4nIaD/f5
         aZ8GfYiUI+SX1d3QND8DxcVIbG3QO5I7Je17c0VU=
Date:   Wed, 23 Jan 2019 14:15:23 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
Subject: Re: [PATCH V3 7/9] x86/alternative: Batch of patch operations
Message-Id: <20190123141523.eb6aa6a17efc76881e89e130@kernel.org>
In-Reply-To: <e3057f0d0bddd625de6d4e7c631faf734e28628b.1545228276.git.bristot@redhat.com>
References: <cover.1545228276.git.bristot@redhat.com>
        <e3057f0d0bddd625de6d4e7c631faf734e28628b.1545228276.git.bristot@redhat.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Fri, 21 Dec 2018 11:27:32 +0100
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> Currently, the patch of an address is done in three steps:
> 
> -- Pseudo-code #1 - Current implementation ---
>         1) add an int3 trap to the address that will be patched
>             sync cores (send IPI to all other CPUs)
>         2) update all but the first byte of the patched range
>             sync cores (send IPI to all other CPUs)
>         3) replace the first byte (int3) by the first byte of replacing opcode
>             sync cores (send IPI to all other CPUs)
> -- Pseudo-code #1 ---
> 
> When a static key has more than one entry, these steps are called once for
> each entry. The number of IPIs then is linear with regard to the number 'n' of
> entries of a key: O(n*3), which is O(n).
> 
> This algorithm works fine for the update of a single key. But we think
> it is possible to optimize the case in which a static key has more than
> one entry. For instance, the sched_schedstats jump label has 56 entries
> in my (updated) fedora kernel, resulting in 168 IPIs for each CPU in
> which the thread that is enabling the key is _not_ running.
> 
> With this patch, rather than receiving a single patch to be processed, a vector
> of patches is passed, enabling the rewrite of the pseudo-code #1 in this
> way:
> 
> -- Pseudo-code #2 - This patch  ---
> 1)  for each patch in the vector:
>         add an int3 trap to the address that will be patched
> 
>     sync cores (send IPI to all other CPUs)
> 
> 2)  for each patch in the vector:
>         update all but the first byte of the patched range
> 
>     sync cores (send IPI to all other CPUs)
> 
> 3)  for each patch in the vector:
>         replace the first byte (int3) by the first byte of replacing opcode
> 
>     sync cores (send IPI to all other CPUs)
> -- Pseudo-code #2 - This patch  ---
> 
> Doing the update in this way, the number of IPI becomes O(3) with regard
> to the number of keys, which is O(1).
> 
> The batch mode is done with the function text_poke_bp_batch(), that receives
> two arguments: a vector of "struct text_to_poke", and the number of entries
> in the vector.
> 
> The vector must be sorted by the addr field of the text_to_poke structure,
> enabling the binary search of a handler in the poke_int3_handler function
> (a fast path).
> 
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Cc: Jiri Kosina <jkosina@suse.cz>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> Cc: Chris von Recklinghausen <crecklin@redhat.com>
> Cc: Jason Baron <jbaron@akamai.com>
> Cc: Scott Wood <swood@redhat.com>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Clark Williams <williams@redhat.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/x86/include/asm/text-patching.h |  15 ++++
>  arch/x86/kernel/alternative.c        | 108 +++++++++++++++++++++++++--
>  2 files changed, 117 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
> index e85ff65c43c3..42ea7846df33 100644
> --- a/arch/x86/include/asm/text-patching.h
> +++ b/arch/x86/include/asm/text-patching.h
> @@ -18,6 +18,20 @@ static inline void apply_paravirt(struct paravirt_patch_site *start,
>  #define __parainstructions_end	NULL
>  #endif
>  
> +/*
> + * Currently, the max observed size in the kernel code is
> + * JUMP_LABEL_NOP_SIZE/RELATIVEJUMP_SIZE, which are 5.
> + * Raise it if needed.
> + */
> +#define POKE_MAX_OPCODE_SIZE	5
> +
> +struct text_to_poke {
> +	void *handler;
> +	void *addr;
> +	size_t len;
> +	const char opcode[POKE_MAX_OPCODE_SIZE];
> +};
> +
>  extern void *text_poke_early(void *addr, const void *opcode, size_t len);
>  
>  /*
> @@ -37,6 +51,7 @@ extern void *text_poke_early(void *addr, const void *opcode, size_t len);
>  extern void *text_poke(void *addr, const void *opcode, size_t len);
>  extern int poke_int3_handler(struct pt_regs *regs);
>  extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
> +extern void text_poke_bp_batch(struct text_to_poke *tp, unsigned int nr_entries);
>  extern int after_bootmem;
>  
>  #endif /* _ASM_X86_TEXT_PATCHING_H */
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 6f5ad8587de0..8fa47e5ec709 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -21,6 +21,7 @@
>  #include <asm/tlbflush.h>
>  #include <asm/io.h>
>  #include <asm/fixmap.h>
> +#include <linux/bsearch.h>
>  
>  int __read_mostly alternatives_patched;
>  
> @@ -738,10 +739,32 @@ static void do_sync_core(void *info)
>  }
>  
>  static bool bp_patching_in_progress;
> +/*
> + * Single poke.
> + */
>  static void *bp_int3_handler, *bp_int3_addr;
> +/*
> + * Batching poke.
> + */
> +static struct text_to_poke *bp_int3_tpv;
> +static unsigned int bp_int3_tpv_nr;
> +
> +static int text_bp_batch_bsearch(const void *key, const void *elt)
> +{
> +	struct text_to_poke *tp = (struct text_to_poke *) elt;
> +
> +	if (key < tp->addr)
> +		return -1;
> +	if (key > tp->addr)
> +		return 1;
> +	return 0;
> +}
>  
>  int poke_int3_handler(struct pt_regs *regs)
>  {
> +	void *ip;
> +	struct text_to_poke *tp;
> +
>  	/*
>  	 * Having observed our INT3 instruction, we now must observe
>  	 * bp_patching_in_progress.
> @@ -757,21 +780,41 @@ int poke_int3_handler(struct pt_regs *regs)
>  	if (likely(!bp_patching_in_progress))
>  		return 0;
>  
> -	if (user_mode(regs) || regs->ip != (unsigned long)bp_int3_addr)
> +	if (user_mode(regs))
>  		return 0;
>  
> -	/* set up the specified breakpoint handler */
> -	regs->ip = (unsigned long) bp_int3_handler;
> +	/*
> +	 * Single poke first.
> +	 */

I wonder why would you separate single poke and batch poke?
It seems a single poke is just a case that bp_int3_tpv_nr == 1.
If so, you can remove bp_int3_addr and this block.

> +	if (bp_int3_addr) {
> +		if (regs->ip == (unsigned long) bp_int3_addr) {
> +			regs->ip = (unsigned long) bp_int3_handler;
> +			return 1;
> +		}
> +		return 0;
> +	}
> 
> -	return 1;
> +	/*
> +	 * Batch mode.
> +	 */
> +	if (bp_int3_tpv_nr) {

if (unlikely(bp_int3_tpv_nr))

Sorry about interrupting, but this is a "hot-path" when we use kprobes.

Also, could you add NOKPROBE_SYMBOL(); for all symbols involved in this
process?
Recently I found I missed it for poke_int3_handler and sent a fix.
( https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1898241.html )
If this increase the function-call-chain from poke_int3_handler, those
must be marked as NOKPROBE_SYMBOL().

But basically this series looks good to me.

Thank you, 

> +		ip = (void *) regs->ip - sizeof(unsigned char);
> +		tp = bsearch(ip, bp_int3_tpv, bp_int3_tpv_nr,
> +			     sizeof(struct text_to_poke),
> +			     text_bp_batch_bsearch);
> +		if (tp) {
> +			/* set up the specified breakpoint handler */
> +			regs->ip = (unsigned long) tp->handler;
> +			return 1;
> +		}
> +	}
>  
> +	return 0;
>  }
>  
>  static void text_poke_bp_set_handler(void *addr, void *handler,
>  				     unsigned char int3)
>  {
> -	bp_int3_handler = handler;
> -	bp_int3_addr = (u8 *)addr + sizeof(int3);
>  	text_poke(addr, &int3, sizeof(int3));
>  }
>  
> @@ -816,6 +859,9 @@ void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
>  
>  	lockdep_assert_held(&text_mutex);
>  
> +	bp_int3_handler = handler;
> +	bp_int3_addr = (u8 *)addr + sizeof(int3);
> +
>  	bp_patching_in_progress = true;
>  	/*
>  	 * Corresponding read barrier in int3 notifier for making sure the
> @@ -846,6 +892,56 @@ void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
>  	 */
>  	bp_patching_in_progress = false;
>  
> +	bp_int3_handler = bp_int3_addr = 0;
>  	return addr;
>  }
>  
> +void text_poke_bp_batch(struct text_to_poke *tp, unsigned int nr_entries)
> +{
> +	unsigned int i;
> +	unsigned char int3 = 0xcc;
> +	int patched_all_but_first = 0;
> +
> +	bp_int3_tpv = tp;
> +	bp_int3_tpv_nr = nr_entries;
> +	bp_patching_in_progress = true;
> +	/*
> +	 * Corresponding read barrier in int3 notifier for making sure the
> +	 * in_progress and handler are correctly ordered wrt. patching.
> +	 */
> +	smp_wmb();
> +
> +	for (i = 0; i < nr_entries; i++)
> +		text_poke_bp_set_handler(tp[i].addr, tp[i].handler, int3);
> +
> +	on_each_cpu(do_sync_core, NULL, 1);
> +
> +	for (i = 0; i < nr_entries; i++) {
> +		if (tp[i].len - sizeof(int3) > 0) {
> +			patch_all_but_first_byte(tp[i].addr, tp[i].opcode,
> +						 tp[i].len, int3);
> +			patched_all_but_first++;
> +		}
> +	}
> +
> +	if (patched_all_but_first) {
> +		/*
> +		 * According to Intel, this core syncing is very likely
> +		 * not necessary and we'd be safe even without it. But
> +		 * better safe than sorry (plus there's not only Intel).
> +		 */
> +		on_each_cpu(do_sync_core, NULL, 1);
> +	}
> +
> +	for (i = 0; i < nr_entries; i++)
> +		patch_first_byte(tp[i].addr, tp[i].opcode, int3);
> +
> +	on_each_cpu(do_sync_core, NULL, 1);
> +	/*
> +	 * sync_core() implies an smp_mb() and orders this store against
> +	 * the writing of the new instruction.
> +	 */
> +	bp_int3_tpv_nr = 0;
> +	bp_int3_tpv = NULL;
> +	bp_patching_in_progress = false;
> +}
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
