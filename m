Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB05C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 971ED218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549434607;
	bh=0FEzJD1+6ouDjVYqb1E9vDF97qeGNjwz+IpXEIwlJY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=b6RCKFEvygZYQApU92i6TPPOG8L6n8+R8hSHnfCaawKnjNKikXtzfvCFM03CAZXZS
	 hJaxGEH49LzDSO1cqfwhnFmdMrBQqV2HTMtcq5R3dxFzjFT764wQMhrkTA2GtJOdC6
	 Pyky0L96NCs3GGwkmQaEAP2KTeI6XPIIjzLcD6AA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfBFGaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 01:30:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:57810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbfBFGaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 01:30:05 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B3B420818;
        Wed,  6 Feb 2019 06:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549434603;
        bh=0FEzJD1+6ouDjVYqb1E9vDF97qeGNjwz+IpXEIwlJY8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ndMk9wb7Yi8gRyG0ZYkQNRadUpAKX7JY91TT6Pyv9xo9ofihgfWOddpCGuD5iVLnG
         Scf8PKG9Au5AlKa6XFr+iibUNPzAQSSUyUQHleeHIQBwoVqa0m6/UTBwc7fQOaE5zm
         T4wivoJB2YljnYI/9HWR7zl9pkKzGm2eXzlLa+n0=
Date:   Wed, 6 Feb 2019 15:29:59 +0900
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
Subject: Re: [PATCH V4 9/9] x86/jump_label: Batch jump label updates
Message-Id: <20190206152959.e244296603d9d30ec63c49c0@kernel.org>
In-Reply-To: <9604e1d5aa1aa847f3cdb0fce9e3d331f8fbb447.1549308412.git.bristot@redhat.com>
References: <cover.1549308412.git.bristot@redhat.com>
        <9604e1d5aa1aa847f3cdb0fce9e3d331f8fbb447.1549308412.git.bristot@redhat.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Mon,  4 Feb 2019 20:59:02 +0100
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> Currently, the jump label of a static key is transformed via the arch
> specific function:
> 
>     void arch_jump_label_transform(struct jump_entry *entry,
>                                    enum jump_label_type type)
> 
> The new approach (batch mode) uses two arch functions, the first has the
> same arguments of the arch_jump_label_transform(), and is the function:
> 
>     void arch_jump_label_transform_queue(struct jump_entry *entry,
> 					 enum jump_label_type type)

This function actually returns "int" value.
Also, it seems the function returns 0 for failure and 1 for success,
but usually we guess "int" returns -errno or 0 for success.

So could you update the inferface to return -ENOSPC for vector
overflow, and -EINVAL for invalid entry?

Thank you,

> 
> Rather than transforming the code, it adds the jump_entry in a queue of
> entries to be updated. This functions returns 1 in the case of a
> successful enqueue of an entry. If it returns 0, the caller must to
> apply the queue and then try to queue again, for instance, because the
> queue is full.
> 
> This function expects the caller to sort the entries by the address before
> enqueueuing then. This is already done by the arch independent code, though.
> 
> After queuing all jump_entries, the function:
> 
>     void arch_jump_label_transform_apply(void)
> 
> Applies the changes in the queue.
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
>  arch/x86/include/asm/jump_label.h |  2 +
>  arch/x86/kernel/jump_label.c      | 88 +++++++++++++++++++++++++++++++
>  2 files changed, 90 insertions(+)
> 
> diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
> index 65191ce8e1cf..06c3cc22a058 100644
> --- a/arch/x86/include/asm/jump_label.h
> +++ b/arch/x86/include/asm/jump_label.h
> @@ -2,6 +2,8 @@
>  #ifndef _ASM_X86_JUMP_LABEL_H
>  #define _ASM_X86_JUMP_LABEL_H
>  
> +#define HAVE_JUMP_LABEL_BATCH
> +
>  #define JUMP_LABEL_NOP_SIZE 5
>  
>  #ifdef CONFIG_X86_64
> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
> index 2ef687db5a87..3c81cf8f06ca 100644
> --- a/arch/x86/kernel/jump_label.c
> +++ b/arch/x86/kernel/jump_label.c
> @@ -15,6 +15,7 @@
>  #include <asm/kprobes.h>
>  #include <asm/alternative.h>
>  #include <asm/text-patching.h>
> +#include <linux/slab.h>
>  
>  union jump_code_union {
>  	char code[JUMP_LABEL_NOP_SIZE];
> @@ -130,6 +131,93 @@ void arch_jump_label_transform(struct jump_entry *entry,
>  	mutex_unlock(&text_mutex);
>  }
>  
> +struct text_to_poke *entry_vector;
> +unsigned int entry_vector_max_elem __read_mostly;
> +unsigned int entry_vector_nr_elem;
> +
> +void arch_jump_label_init(void)
> +{
> +	entry_vector = (void *) __get_free_page(GFP_KERNEL);
> +
> +	if (WARN_ON_ONCE(!entry_vector))
> +		return;
> +
> +	entry_vector_max_elem = PAGE_SIZE / sizeof(struct text_to_poke);
> +	return;
> +}
> +
> +int arch_jump_label_transform_queue(struct jump_entry *entry,
> +				     enum jump_label_type type)
> +{
> +	void *entry_code;
> +	struct text_to_poke *tp;
> +
> +	/*
> +	 * Batch mode disabled before being able to allocate memory:
> +	 * Fallback to the non-batching mode.
> +	 */
> +	if (unlikely(!entry_vector_max_elem)) {
> +		if (!slab_is_available() || early_boot_irqs_disabled)
> +			goto fallback;
> +
> +		arch_jump_label_init();
> +	}
> +
> +	/*
> +	 * No more space in the vector, tell upper layer to apply
> +	 * the queue before continuing.
> +	 */
> +	if (entry_vector_nr_elem == entry_vector_max_elem)
> +		return 0;
> +
> +	tp = &entry_vector[entry_vector_nr_elem];
> +
> +	entry_code = (void *)jump_entry_code(entry);
> +
> +	/*
> +	 * The int3 handler will do a bsearch in the queue, so we need entries
> +	 * to be sorted. We can survive an unsorted list by rejecting the entry,
> +	 * forcing the generic jump_label code to apply the queue. Warning once,
> +	 * to raise the attention to the case of an unsorted entry that is
> +	 * better not happen, because, in the worst case we will perform in the
> +	 * same way as we do without batching - with some more overhead.
> +	 */
> +	if (entry_vector_nr_elem > 0) {
> +		int prev_idx = entry_vector_nr_elem - 1;
> +		struct text_to_poke *prev_tp = &entry_vector[prev_idx];
> +
> +		if (WARN_ON_ONCE(prev_tp->addr > entry_code))
> +			return 0;
> +	}
> +
> +	__jump_label_set_jump_code(entry, type,
> +				   (union jump_code_union *) &tp->opcode, 0);
> +
> +	tp->addr = entry_code;
> +	tp->handler = entry_code + JUMP_LABEL_NOP_SIZE;
> +	tp->len = JUMP_LABEL_NOP_SIZE;
> +
> +	entry_vector_nr_elem++;
> +
> +	return 1;
> +
> +fallback:
> +	arch_jump_label_transform(entry, type);
> +	return 1;
> +}
> +
> +void arch_jump_label_transform_apply(void)
> +{
> +	if (early_boot_irqs_disabled || !entry_vector_nr_elem)
> +		return;
> +
> +	mutex_lock(&text_mutex);
> +	text_poke_bp_batch(entry_vector, entry_vector_nr_elem);
> +	mutex_unlock(&text_mutex);
> +
> +	entry_vector_nr_elem = 0;
> +}
> +
>  static enum {
>  	JL_STATE_START,
>  	JL_STATE_NO_UPDATE,
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
