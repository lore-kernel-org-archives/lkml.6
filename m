Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163D9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4356214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 20:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4356214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeJKDlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:41:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbeJKDlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:41:49 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 989382086E;
        Wed, 10 Oct 2018 20:18:01 +0000 (UTC)
Date:   Wed, 10 Oct 2018 16:17:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Zhou Chengming <zhouchengming1@huawei.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [RFC PATCH 6/6] x86/jump_label,x86/alternatives: Batch jump
 label transformations
Message-ID: <20181010161759.7bd681c1@gandalf.local.home>
In-Reply-To: <e99eb239b0546e180e49c1e5a9e607fb6af0ec60.1539001620.git.bristot@redhat.com>
References: <cover.1539001620.git.bristot@redhat.com>
        <e99eb239b0546e180e49c1e5a9e607fb6af0ec60.1539001620.git.bristot@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  8 Oct 2018 14:53:05 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
> index 8c0de4282659..d61c476046fe 100644
> --- a/arch/x86/include/asm/jump_label.h
> +++ b/arch/x86/include/asm/jump_label.h
> @@ -15,6 +15,8 @@
>  #error asm/jump_label.h included on a non-jump-label kernel
>  #endif
>  
> +#define HAVE_JUMP_LABEL_BATCH
> +
>  #define JUMP_LABEL_NOP_SIZE 5
>  
>  #ifdef CONFIG_X86_64
> diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
> index e85ff65c43c3..a28230f09d72 100644
> --- a/arch/x86/include/asm/text-patching.h
> +++ b/arch/x86/include/asm/text-patching.h
> @@ -18,6 +18,14 @@ static inline void apply_paravirt(struct paravirt_patch_site *start,
>  #define __parainstructions_end	NULL
>  #endif
>  
> +struct text_to_poke {
> +	struct list_head list;
> +	void *opcode;
> +	void *addr;
> +	void *handler;
> +	size_t len;
> +};
> +
>  extern void *text_poke_early(void *addr, const void *opcode, size_t len);
>  
>  /*
> @@ -37,6 +45,7 @@ extern void *text_poke_early(void *addr, const void *opcode, size_t len);
>  extern void *text_poke(void *addr, const void *opcode, size_t len);
>  extern int poke_int3_handler(struct pt_regs *regs);
>  extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
> +extern void text_poke_bp_list(struct list_head *entry_list);
>  extern int after_bootmem;
>  
>  #endif /* _ASM_X86_TEXT_PATCHING_H */
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index a4c83cb49cd0..3bd502ea4c53 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -735,9 +735,12 @@ static void do_sync_core(void *info)
>  
>  static bool bp_patching_in_progress;
>  static void *bp_int3_handler, *bp_int3_addr;
> +struct list_head *bp_list;
>  
>  int poke_int3_handler(struct pt_regs *regs)
>  {
> +	void *ip;
> +	struct text_to_poke *tp;
>  	/*
>  	 * Having observed our INT3 instruction, we now must observe
>  	 * bp_patching_in_progress.
> @@ -753,21 +756,38 @@ int poke_int3_handler(struct pt_regs *regs)
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
> +	 * Single poke.
> +	 */
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
> +	ip = (void *) regs->ip - sizeof(unsigned char);
> +	list_for_each_entry(tp, bp_list, list) {
> +		if (ip == tp->addr) {
> +			/* set up the specified breakpoint handler */
> +			regs->ip = (unsigned long) tp->handler;

I hate this loop. Makes hitting the static branch (which is probably in
a fast path, otherwise why use static branches?), do a O(n) loop of
batch updates. You may not have that many, but why not optimize it?

Can we make an array of the handlers, in sorted order, then we simply
do a binary search for the ip involved? Turning this from O(n) to
O(log2(n)).

As Jason mentioned. If you set aside a page for processing batches up
to PAGE / (sizeof tp) then you can also make it sorted and replace the
iteration with a loop.

-- Steve


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
> @@ -812,6 +832,9 @@ void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
>  
>  	lockdep_assert_held(&text_mutex);
>  
> +	bp_int3_handler = handler;
> +	bp_int3_addr = (u8 *)addr + sizeof(int3);
> +
>  	bp_patching_in_progress = true;
>  	/*
>  	 * Corresponding read barrier in int3 notifier for making sure the
> @@ -841,7 +864,53 @@ void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
>  	 * the writing of the new instruction.
>  	 */
>  	bp_patching_in_progress = false;
> -
> +	bp_int3_handler = bp_int3_addr = 0;
>  	return addr;
>  }
>  
> +void text_poke_bp_list(struct list_head *entry_list)
> +{
> +	unsigned char int3 = 0xcc;
> +	int patched_all_but_first = 0;
> +	struct text_to_poke *tp;
> +
> +	bp_list = entry_list;
> +	bp_patching_in_progress = true;
> +	/*
> +	 * Corresponding read barrier in int3 notifier for making sure the
> +	 * in_progress and handler are correctly ordered wrt. patching.
> +	 */
> +	smp_wmb();
> +
> +	list_for_each_entry(tp, entry_list, list)
> +		text_poke_bp_set_handler(tp->addr, tp->handler, int3);
> +
> +	on_each_cpu(do_sync_core, NULL, 1);
> +
> +	list_for_each_entry(tp, entry_list, list) {
> +		if (tp->len - sizeof(int3) > 0) {
> +			patch_all_but_first_byte(tp->addr, tp->opcode, tp->len, int3);
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
> +	list_for_each_entry(tp, entry_list, list)
> +		patch_first_byte(tp->addr, tp->opcode, int3);
> +
> +	on_each_cpu(do_sync_core, NULL, 1);
> +	/*
> +	 * sync_core() implies an smp_mb() and orders this store against
> +	 * the writing of the new instruction.
> +	 */
> +	bp_list = 0;
> +	bp_patching_in_progress = false;
> +}
