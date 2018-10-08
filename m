Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221F3C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B6C20C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B6C20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbeJIDgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 23:36:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42638 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIDgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 23:36:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id g15-v6so19537314wru.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 13:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DFy3W7zI8LoHJg5mLqnu+MPl/0x56XxALsS6LxNO18Y=;
        b=WI7ap8v1udaQ43ofVPobT7H8u+0uX5CCUrqE6fvKjG/Q9E7W77w9Lgy9juxm7CVu2Y
         p/ExyIVTrRk0OS0ly8mTCsoDfpSPfBbWsWysWJ4IK66ekbxrmHKkfSwrNzBE9Gwy1MDF
         4iBN+xeMYnIQ7XKbq1QOVbyo1d1Eg7/eNYB6ScrByNI57m2yOFrwd+5k1GkFlhLf2HDS
         Gk3Rywb6gkhNSz9HZt0/xrdb0baaU/QFA/OcB/aA3VUwCuird1ugdr0Kpe4JZwcKOvnj
         LDfZl03vDs+OLuY2GvX7gcRx8K5A8RXjwKiZj8crR+3KaopXf1np13abOIzEX/tOZL2N
         Qzsw==
X-Gm-Message-State: ABuFfoj5HlkRDD9nnwGaLceIz9xrqRol7eHo/MMRxxvhzv2+fZgr/Y1s
        Y1dGS+hXSV3LQJJt7w2F6juWbxLpB/3gAw==
X-Google-Smtp-Source: ACcGV62i314EFRPO6CD8KgVkfBwF2gbCyyzzXcBFKcyAXVVgtSMLAnIDc29oSg2HuLDdyceqG2jA0g==
X-Received: by 2002:adf:da43:: with SMTP id r3-v6mr18000472wrl.221.1539030153405;
        Mon, 08 Oct 2018 13:22:33 -0700 (PDT)
Received: from t460s.bristot.redhat.com (host232-201-dynamic.17-87-r.retail.telecomitalia.it. [87.17.201.232])
        by smtp.gmail.com with ESMTPSA id r16-v6sm24318188wrv.21.2018.10.08.13.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 13:22:32 -0700 (PDT)
Subject: Re: [RFC PATCH 6/6] x86/jump_label,x86/alternatives: Batch jump label
 transformations
To:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Zhou Chengming <zhouchengming1@huawei.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>
References: <cover.1539001620.git.bristot@redhat.com>
 <e99eb239b0546e180e49c1e5a9e607fb6af0ec60.1539001620.git.bristot@redhat.com>
 <97bb771a-2dfd-6980-5d25-9523a92a7711@akamai.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <bac72bb1-7bd3-9671-1535-5dfbee0e8bd0@redhat.com>
Date:   Mon, 8 Oct 2018 22:22:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <97bb771a-2dfd-6980-5d25-9523a92a7711@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/18 4:33 PM, Jason Baron wrote:
> On 10/08/2018 08:53 AM, Daniel Bristot de Oliveira wrote:
>> A static key, changing from enabled->disabled/disabled->enabled causes
>> the code to be changed, and this is done in three steps:
>>
>> -- Pseudo-code #1 - Current implementation ---
>> For each key to be updated:
>> 	1)  add an int3 trap to the address that will be patched
>>         	sync cores (send IPI to all other CPUs)
>> 	2)  update all but the first byte of the patched range
>> 	        sync cores (send IPI to all other CPUs)
>> 	3)  replace the first byte (int3) by the first byte of replacing opcode
>> 	        sync cores (send IPI to all other CPUs)
>> -- Pseudo-code #1 ---
>>
>> The number of IPIs sent is then linear with regard to the number 'n' of
>> entries of a key: O(n*3), which is O(n). For instance, as the static key
>> netstamp_needed_key has four entries (used in for places in the code)
>> in our kernel, 3 IPIs were generated for each entry, resulting in 12 IPIs.
>>
>> This algorithm works fine for the update of a single key. But we think
>> it is possible to optimize the case in which a static key has more than
>> one entry. For instance, the sched_schedstats jump label has 56 entries
>> in my (updated) fedora kernel, resulting in 168 IPIs for each CPU in
>> which the thread that is enabling is _not_ running.
>>
>> In this patch, rather than doing each updated at once, it queue all
>> updates first, and the, apply all updates at once, rewriting the
>> pseudo-code #1 in this way:
>>
>> -- Pseudo-code #2 - This patch  ---
>> 1)  for each key in the queue:
>>         add an int3 trap to the address that will be patched
>>     sync cores (send IPI to all other CPUs)
>>
>> 2)  for each key in the queue:
>>         update all but the first byte of the patched range
>>     sync cores (send IPI to all other CPUs)
>>
>> 3)  for each key in the queue:
>>         replace the first byte (int3) by the first byte of replacing opcode
>>
>>     sync cores (send IPI to all other CPUs)
>> -- Pseudo-code #2 - This patch  ---
>>
>> Doing the update in this way, the number of IPI becomes O(3) with regard
>> to the number of keys, which is O(1).
>>
>> Currently, the jump label of a static key is transformed via the arch
>> specific function:
>>
>>     void arch_jump_label_transform(struct jump_entry *entry,
>>                                    enum jump_label_type type)
>>
>> The new approach (batch mode) uses two arch functions, the first has the
>> same arguments of the arch_jump_label_transform(), and is the function:
>>
>>     void arch_jump_label_transform_queue(struct jump_entry *entry,
>>                          enum jump_label_type type)
>>
>> Rather than transforming the code, it adds the jump_entry in a queue of
>> entries to be updated.
>>
>> After queuing all jump_entries, the function:
>>
>>     void arch_jump_label_transform_apply(void)
>>
>> Applies the changes in the queue.
>>
>> The batch of operations was:
>> Suggested-by: Scott Wood <swood@redhat.com>
> 
> Hi,
> 
> We've discussed a 'batch' mode here before, and we had patches in the
> past iirc, but they never quite reached a merge-able state.

Hi Jason!

Thanks for your comments! I will try to find references for old patches!

I think for
> this patch, we want to separate it in 2 - the text patching code that
> now takes a list, and the jump_label code consumer. Comments below.
> 

I see your point. I agree on breaking this patch into two.

>>
>> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>> Cc: Zhou Chengming <zhouchengming1@huawei.com>
>> Cc: Jiri Kosina <jkosina@suse.cz>
>> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
>> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
>> Cc: Chris von Recklinghausen <crecklin@redhat.com>
>> Cc: Jason Baron <jbaron@akamai.com>
>> Cc: Scott Wood <swood@redhat.com>
>> Cc: Marcelo Tosatti <mtosatti@redhat.com>
>> Cc: Clark Williams <williams@redhat.com>
>> Cc: x86@kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  arch/x86/include/asm/jump_label.h    |  2 +
>>  arch/x86/include/asm/text-patching.h |  9 +++
>>  arch/x86/kernel/alternative.c        | 83 +++++++++++++++++++++++++---
>>  arch/x86/kernel/jump_label.c         | 54 ++++++++++++++++++
>>  include/linux/jump_label.h           |  5 ++
>>  kernel/jump_label.c                  | 15 +++++
>>  6 files changed, 161 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
>> index 8c0de4282659..d61c476046fe 100644
>> --- a/arch/x86/include/asm/jump_label.h
>> +++ b/arch/x86/include/asm/jump_label.h
>> @@ -15,6 +15,8 @@
>>  #error asm/jump_label.h included on a non-jump-label kernel
>>  #endif
>>  
>> +#define HAVE_JUMP_LABEL_BATCH
>> +
>>  #define JUMP_LABEL_NOP_SIZE 5
>>  
>>  #ifdef CONFIG_X86_64
>> diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
>> index e85ff65c43c3..a28230f09d72 100644
>> --- a/arch/x86/include/asm/text-patching.h
>> +++ b/arch/x86/include/asm/text-patching.h
>> @@ -18,6 +18,14 @@ static inline void apply_paravirt(struct paravirt_patch_site *start,
>>  #define __parainstructions_end	NULL
>>  #endif
>>  
>> +struct text_to_poke {
>> +	struct list_head list;
>> +	void *opcode;
>> +	void *addr;
>> +	void *handler;
>> +	size_t len;
>> +};
>> +
>>  extern void *text_poke_early(void *addr, const void *opcode, size_t len);
>>  
>>  /*
>> @@ -37,6 +45,7 @@ extern void *text_poke_early(void *addr, const void *opcode, size_t len);
>>  extern void *text_poke(void *addr, const void *opcode, size_t len);
>>  extern int poke_int3_handler(struct pt_regs *regs);
>>  extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
>> +extern void text_poke_bp_list(struct list_head *entry_list);
>>  extern int after_bootmem;
>>  
>>  #endif /* _ASM_X86_TEXT_PATCHING_H */
>> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
>> index a4c83cb49cd0..3bd502ea4c53 100644
>> --- a/arch/x86/kernel/alternative.c
>> +++ b/arch/x86/kernel/alternative.c
>> @@ -735,9 +735,12 @@ static void do_sync_core(void *info)
>>  
>>  static bool bp_patching_in_progress;
>>  static void *bp_int3_handler, *bp_int3_addr;
>> +struct list_head *bp_list;
>>  
>>  int poke_int3_handler(struct pt_regs *regs)
>>  {
>> +	void *ip;
>> +	struct text_to_poke *tp;
>>  	/*
>>  	 * Having observed our INT3 instruction, we now must observe
>>  	 * bp_patching_in_progress.
>> @@ -753,21 +756,38 @@ int poke_int3_handler(struct pt_regs *regs)
>>  	if (likely(!bp_patching_in_progress))
>>  		return 0;
>>  
>> -	if (user_mode(regs) || regs->ip != (unsigned long)bp_int3_addr)
>> +	if (user_mode(regs))
>>  		return 0;
>>  
>> -	/* set up the specified breakpoint handler */
>> -	regs->ip = (unsigned long) bp_int3_handler;
>> +	/*
>> +	 * Single poke.
>> +	 */
>> +	if (bp_int3_addr) {
>> +		if (regs->ip == (unsigned long) bp_int3_addr) {
>> +			regs->ip = (unsigned long) bp_int3_handler;
>> +			return 1;
>> +		}
>> +		return 0;
>> +	}
>>  
>> -	return 1;
>> +	/*
>> +	 * Batch mode.
>> +	 */
>> +	ip = (void *) regs->ip - sizeof(unsigned char);
>> +	list_for_each_entry(tp, bp_list, list) {
>> +		if (ip == tp->addr) {
>> +			/* set up the specified breakpoint handler */
>> +			regs->ip = (unsigned long) tp->handler;
>> +			return 1;
>> +		}
>> +	}
>>  
>> +	return 0;
>>  }
>>  
>>  static void text_poke_bp_set_handler(void *addr, void *handler,
>>  				     unsigned char int3)
>>  {
>> -	bp_int3_handler = handler;
>> -	bp_int3_addr = (u8 *)addr + sizeof(int3);
>>  	text_poke(addr, &int3, sizeof(int3));
>>  }
>>  
>> @@ -812,6 +832,9 @@ void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
>>  
>>  	lockdep_assert_held(&text_mutex);
>>  
>> +	bp_int3_handler = handler;
>> +	bp_int3_addr = (u8 *)addr + sizeof(int3);
>> +
>>  	bp_patching_in_progress = true;
>>  	/*
>>  	 * Corresponding read barrier in int3 notifier for making sure the
>> @@ -841,7 +864,53 @@ void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
>>  	 * the writing of the new instruction.
>>  	 */
>>  	bp_patching_in_progress = false;
>> -
>> +	bp_int3_handler = bp_int3_addr = 0;
>>  	return addr;
>>  }
>>  
>> +void text_poke_bp_list(struct list_head *entry_list)
>> +{
>> +	unsigned char int3 = 0xcc;
>> +	int patched_all_but_first = 0;
>> +	struct text_to_poke *tp;
>> +
>> +	bp_list = entry_list;
>> +	bp_patching_in_progress = true;
>> +	/*
>> +	 * Corresponding read barrier in int3 notifier for making sure the
>> +	 * in_progress and handler are correctly ordered wrt. patching.
>> +	 */
>> +	smp_wmb();
>> +
>> +	list_for_each_entry(tp, entry_list, list)
>> +		text_poke_bp_set_handler(tp->addr, tp->handler, int3);
>> +
>> +	on_each_cpu(do_sync_core, NULL, 1);
>> +
>> +	list_for_each_entry(tp, entry_list, list) {
>> +		if (tp->len - sizeof(int3) > 0) {
>> +			patch_all_but_first_byte(tp->addr, tp->opcode, tp->len, int3);
>> +			patched_all_but_first++;
>> +		}
>> +	}
>> +
>> +	if (patched_all_but_first) {
>> +		/*
>> +		 * According to Intel, this core syncing is very likely
>> +		 * not necessary and we'd be safe even without it. But
>> +		 * better safe than sorry (plus there's not only Intel).
>> +		 */
>> +		on_each_cpu(do_sync_core, NULL, 1);
>> +	}
>> +
>> +	list_for_each_entry(tp, entry_list, list)
>> +		patch_first_byte(tp->addr, tp->opcode, int3);
>> +
>> +	on_each_cpu(do_sync_core, NULL, 1);
>> +	/*
>> +	 * sync_core() implies an smp_mb() and orders this store against
>> +	 * the writing of the new instruction.
>> +	 */
>> +	bp_list = 0;
>> +	bp_patching_in_progress = false;
>> +}
>> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
>> index de588ff47f81..3da5af5de4d3 100644
>> --- a/arch/x86/kernel/jump_label.c
>> +++ b/arch/x86/kernel/jump_label.c
>> @@ -12,6 +12,8 @@
>>  #include <linux/list.h>
>>  #include <linux/jhash.h>
>>  #include <linux/cpu.h>
>> +#include <linux/slab.h>
>> +#include <linux/list.h>
>>  #include <asm/kprobes.h>
>>  #include <asm/alternative.h>
>>  #include <asm/text-patching.h>
>> @@ -139,6 +141,58 @@ void arch_jump_label_transform(struct jump_entry *entry,
>>  	mutex_unlock(&text_mutex);
>>  }
>>  
>> +LIST_HEAD(batch_list);
>> +
>> +void arch_jump_label_transform_queue(struct jump_entry *entry,
>> +				     enum jump_label_type type)
>> +{
>> +	struct text_to_poke *tp;
>> +
>> +	/*
>> +	 * Batch mode disabled at boot time.
>> +	 */
>> +	if (early_boot_irqs_disabled)
>> +		goto fallback;
>> +
>> +	/*
>> +	 * RFC Note: I put __GFP_NOFAIL, but I could also goto fallback;
>> +	 * thoughts?
>> +	 */
>> +	tp = kzalloc(sizeof(struct text_to_poke), GFP_KERNEL | __GFP_NOFAIL);
>> +	tp->opcode = kzalloc(sizeof(union jump_code_union),
>> +			     GFP_KERNEL | __GFP_NOFAIL);
> 
> 
> I wonder if we should just set aside a page here so that we can avoid
> the allocation altogether. I think the size of the text_to_poke on
> x86_64 is 44 bytes, so that's 93 or so entries, which I think covers the
> use-case here. If we go over that limit, we would just do things in
> batches of 93. I just think its nice to avoid memory allocations here to
> avoid creating additional dependencies, although I'm not aware of any
> specific ones.

Yeah, the memory allocation is the "weak" point. In the initial
implementation, I was passing all the arguments from

__jump_label_update()

to the arch code. But I ended up mixing a lot of non-arch with arch
code. It was ugly.

Then, I created the functions in the way that they are now. But I was
putting the entries in a static allocated vector of entries. It worked
fine, but it was not efficient w.r.t memory allocation.

I decided to try using the list with memory allocation because it would
not "wast" memory, and would not require to have a limited amount of
entries (what is better for maintenance...). The bad points about the
memory allocation are:

1) The alloc/list/free costs;
2) What to do when there is no memory.

The 1) is not as bad as it seems, because:

  a) it is in the preemptive/irqs enabled context, so it does not cause
latency in the -rt case;
  b) it is in the "absolute slow path" - as mentioned in [1];
  c) Even doing these operations, this method is faster for the case in
which more than one key is being updated - and these are the performance
sensitive case, thinking "machine wise."

Regarding performance, I tested this patch in the -rt as well, and it
did not cause latency (well, more tests are welcome). Rather, I was
seeing a reduction in the average latency on all CPUs.

Regarding 2) I put the nofail because it looks cleaner. But I also had a
version in which, in the case of a system failing to allocate memory, it
simply falls back to the regular case (a goto fallback) in that
function.

Anyway, I agree that this is the point of doubts about this patch (that
is my opinion as well), and I would like to hear people's opinion about it.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/jump_label.h#n56

>> +
>> +	__jump_label_set_jump_code(entry, type, 0, tp->opcode);
>> +	tp->addr = (void *) entry->code;
>> +	tp->len = JUMP_LABEL_NOP_SIZE;
>> +	tp->handler = (void *) entry->code + JUMP_LABEL_NOP_SIZE;
>> +
>> +	list_add_tail(&tp->list, &batch_list);
>> +
>> +	return;
>> +
>> +fallback:
>> +	arch_jump_label_transform(entry, type);
>> +}
>> +
>> +void arch_jump_label_transform_apply(void)
>> +{
>> +	struct text_to_poke *tp, *next;
>> +
>> +	if (early_boot_irqs_disabled)
>> +		return;
>> +
>> +	mutex_lock(&text_mutex);
>> +	text_poke_bp_list(&batch_list);
>> +	mutex_unlock(&text_mutex);
>> +
>> +	list_for_each_entry_safe(tp, next, &batch_list, list) {
>> +		list_del(&tp->list);
>> +		kfree(tp->opcode);
>> +		kfree(tp);
>> +	}
>> +}
>> +
>>  static enum {
>>  	JL_STATE_START,
>>  	JL_STATE_NO_UPDATE,
>> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
>> index cd3bed880ca0..2aca92e03494 100644
>> --- a/include/linux/jump_label.h
>> +++ b/include/linux/jump_label.h
>> @@ -156,6 +156,11 @@ extern void jump_label_lock(void);
>>  extern void jump_label_unlock(void);
>>  extern void arch_jump_label_transform(struct jump_entry *entry,
>>  				      enum jump_label_type type);
>> +#ifdef HAVE_JUMP_LABEL_BATCH
>> +extern void arch_jump_label_transform_queue(struct jump_entry *entry,
>> +					    enum jump_label_type type);
>> +extern void arch_jump_label_transform_apply(void);
>> +#endif
>>  extern void arch_jump_label_transform_static(struct jump_entry *entry,
>>  					     enum jump_label_type type);
>>  extern int jump_label_text_reserved(void *start, void *end);
>> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
>> index 940ba7819c87..f534d9c4e07f 100644
>> --- a/kernel/jump_label.c
>> +++ b/kernel/jump_label.c
>> @@ -377,6 +377,7 @@ bool jump_label_can_update_check(struct jump_entry *entry)
>>  	return 0;
>>  }
>>  
>> +#ifndef HAVE_JUMP_LABEL_BATCH
>>  static void __jump_label_update(struct static_key *key,
>>  				struct jump_entry *entry,
>>  				struct jump_entry *stop)
>> @@ -386,6 +387,20 @@ static void __jump_label_update(struct static_key *key,
>>  			arch_jump_label_transform(entry, jump_label_type(entry));
>>  	}
>>  }
>> +#else
>> +static void __jump_label_update(struct static_key *key,
>> +				struct jump_entry *entry,
>> +				struct jump_entry *stop)
>> +{
>> +	for_each_label_entry(key, entry, stop) {
>> +		if (jump_label_can_update_check(entry))
>> +			arch_jump_label_transform_queue(entry,
>> +							jump_label_type(entry));
>> +	}
> 
> So this could be done in batches if there are more entries than
> PAGE_SIZE / sizeof(struct text_to_poke)

Yeah, but that was one of the reasons for me to try the alloc/list. As
this is the slow path, maintenance and clarity of the code is "a point."

Anyway, I am not against doing the static allocation! Rather, if people
agree this is the way to go, I will go for it as well.

-- Daniel

> 
>> +	arch_jump_label_transform_apply();
>> +
>> +}
>> +#endif
>>  
>>  void __init jump_label_init(void)
>>  {
>>

