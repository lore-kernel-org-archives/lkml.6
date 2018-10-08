Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838E1C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1FC2075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="jAohorr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1FC2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeJHWZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:25:10 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:48882 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726367AbeJHWZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:25:09 -0400
X-Greylist: delayed 2297 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Oct 2018 18:25:07 EDT
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.16.0.22/8.16.0.22) with SMTP id w98EWFbG010211;
        Mon, 8 Oct 2018 15:33:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=xq4TnlaQ1kYit5E0DJgYJJAQ9Ljymrc8QcY1guxngDo=;
 b=jAohorr4BrMlvl+gU9SqmtAL2E7IaAQSTj+uun6ngaI4umQZWecA6JDCPopOfneP27Hr
 Pu/M7y4j7dsZnKoz95fIoQGt4+xKFC5EsDvIDt2TOGmBe1X9o5VshXTV/Nnx9ua0Ewsu
 XT9NpS2ZhFnsEg5LEaUSPA2wHjUEhISSjU5Kq38uFOtcX5y3g98c/D2tBdgYo0gI1m8D
 +lyDXedf3bh5OLfi+alCFYHon7UkUHx+9p7d8AY5rsP0bwx9uUR6xzEVYTHSf1AzG34l
 K5MgUqFf3XTMxo+hYafC2Xd30Z1HpLuejwXqyIkZBdvIHRO/HoADNpHhZ2sOn8pXtc5g Qw== 
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19])
        by m0050093.ppops.net-00190b01. with ESMTP id 2mxt3ywf8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Oct 2018 15:33:30 +0100
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
        by prod-mail-ppoint2.akamai.com (8.16.0.21/8.16.0.21) with SMTP id w98EKYTM007821;
        Mon, 8 Oct 2018 10:33:28 -0400
Received: from prod-mail-relay10.akamai.com ([172.27.118.251])
        by prod-mail-ppoint2.akamai.com with ESMTP id 2mxrcuhedn-1;
        Mon, 08 Oct 2018 10:33:28 -0400
Received: from [172.28.12.125] (bos-lpjec.kendall.corp.akamai.com [172.28.12.125])
        by prod-mail-relay10.akamai.com (Postfix) with ESMTP id 83C721FCDD;
        Mon,  8 Oct 2018 14:33:28 +0000 (GMT)
Subject: Re: [RFC PATCH 6/6] x86/jump_label,x86/alternatives: Batch jump label
 transformations
To:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
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
From:   Jason Baron <jbaron@akamai.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jbaron@akamai.com; prefer-encrypt=mutual; keydata=
 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
 JeQ7iQ==
Message-ID: <97bb771a-2dfd-6980-5d25-9523a92a7711@akamai.com>
Date:   Mon, 8 Oct 2018 10:33:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e99eb239b0546e180e49c1e5a9e607fb6af0ec60.1539001620.git.bristot@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-08_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810080140
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-08_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1810080140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2018 08:53 AM, Daniel Bristot de Oliveira wrote:
> A static key, changing from enabled->disabled/disabled->enabled causes
> the code to be changed, and this is done in three steps:
> 
> -- Pseudo-code #1 - Current implementation ---
> For each key to be updated:
> 	1)  add an int3 trap to the address that will be patched
>         	sync cores (send IPI to all other CPUs)
> 	2)  update all but the first byte of the patched range
> 	        sync cores (send IPI to all other CPUs)
> 	3)  replace the first byte (int3) by the first byte of replacing opcode
> 	        sync cores (send IPI to all other CPUs)
> -- Pseudo-code #1 ---
> 
> The number of IPIs sent is then linear with regard to the number 'n' of
> entries of a key: O(n*3), which is O(n). For instance, as the static key
> netstamp_needed_key has four entries (used in for places in the code)
> in our kernel, 3 IPIs were generated for each entry, resulting in 12 IPIs.
> 
> This algorithm works fine for the update of a single key. But we think
> it is possible to optimize the case in which a static key has more than
> one entry. For instance, the sched_schedstats jump label has 56 entries
> in my (updated) fedora kernel, resulting in 168 IPIs for each CPU in
> which the thread that is enabling is _not_ running.
> 
> In this patch, rather than doing each updated at once, it queue all
> updates first, and the, apply all updates at once, rewriting the
> pseudo-code #1 in this way:
> 
> -- Pseudo-code #2 - This patch  ---
> 1)  for each key in the queue:
>         add an int3 trap to the address that will be patched
>     sync cores (send IPI to all other CPUs)
> 
> 2)  for each key in the queue:
>         update all but the first byte of the patched range
>     sync cores (send IPI to all other CPUs)
> 
> 3)  for each key in the queue:
>         replace the first byte (int3) by the first byte of replacing opcode
> 
>     sync cores (send IPI to all other CPUs)
> -- Pseudo-code #2 - This patch  ---
> 
> Doing the update in this way, the number of IPI becomes O(3) with regard
> to the number of keys, which is O(1).
> 
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
>                          enum jump_label_type type)
> 
> Rather than transforming the code, it adds the jump_entry in a queue of
> entries to be updated.
> 
> After queuing all jump_entries, the function:
> 
>     void arch_jump_label_transform_apply(void)
> 
> Applies the changes in the queue.
> 
> The batch of operations was:
> Suggested-by: Scott Wood <swood@redhat.com>

Hi,

We've discussed a 'batch' mode here before, and we had patches in the
past iirc, but they never quite reached a merge-able state. I think for
this patch, we want to separate it in 2 - the text patching code that
now takes a list, and the jump_label code consumer. Comments below.


> 
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> Cc: Zhou Chengming <zhouchengming1@huawei.com>
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
>  arch/x86/include/asm/jump_label.h    |  2 +
>  arch/x86/include/asm/text-patching.h |  9 +++
>  arch/x86/kernel/alternative.c        | 83 +++++++++++++++++++++++++---
>  arch/x86/kernel/jump_label.c         | 54 ++++++++++++++++++
>  include/linux/jump_label.h           |  5 ++
>  kernel/jump_label.c                  | 15 +++++
>  6 files changed, 161 insertions(+), 7 deletions(-)
> 
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
> diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
> index de588ff47f81..3da5af5de4d3 100644
> --- a/arch/x86/kernel/jump_label.c
> +++ b/arch/x86/kernel/jump_label.c
> @@ -12,6 +12,8 @@
>  #include <linux/list.h>
>  #include <linux/jhash.h>
>  #include <linux/cpu.h>
> +#include <linux/slab.h>
> +#include <linux/list.h>
>  #include <asm/kprobes.h>
>  #include <asm/alternative.h>
>  #include <asm/text-patching.h>
> @@ -139,6 +141,58 @@ void arch_jump_label_transform(struct jump_entry *entry,
>  	mutex_unlock(&text_mutex);
>  }
>  
> +LIST_HEAD(batch_list);
> +
> +void arch_jump_label_transform_queue(struct jump_entry *entry,
> +				     enum jump_label_type type)
> +{
> +	struct text_to_poke *tp;
> +
> +	/*
> +	 * Batch mode disabled at boot time.
> +	 */
> +	if (early_boot_irqs_disabled)
> +		goto fallback;
> +
> +	/*
> +	 * RFC Note: I put __GFP_NOFAIL, but I could also goto fallback;
> +	 * thoughts?
> +	 */
> +	tp = kzalloc(sizeof(struct text_to_poke), GFP_KERNEL | __GFP_NOFAIL);
> +	tp->opcode = kzalloc(sizeof(union jump_code_union),
> +			     GFP_KERNEL | __GFP_NOFAIL);


I wonder if we should just set aside a page here so that we can avoid
the allocation altogether. I think the size of the text_to_poke on
x86_64 is 44 bytes, so that's 93 or so entries, which I think covers the
use-case here. If we go over that limit, we would just do things in
batches of 93. I just think its nice to avoid memory allocations here to
avoid creating additional dependencies, although I'm not aware of any
specific ones.

> +
> +	__jump_label_set_jump_code(entry, type, 0, tp->opcode);
> +	tp->addr = (void *) entry->code;
> +	tp->len = JUMP_LABEL_NOP_SIZE;
> +	tp->handler = (void *) entry->code + JUMP_LABEL_NOP_SIZE;
> +
> +	list_add_tail(&tp->list, &batch_list);
> +
> +	return;
> +
> +fallback:
> +	arch_jump_label_transform(entry, type);
> +}
> +
> +void arch_jump_label_transform_apply(void)
> +{
> +	struct text_to_poke *tp, *next;
> +
> +	if (early_boot_irqs_disabled)
> +		return;
> +
> +	mutex_lock(&text_mutex);
> +	text_poke_bp_list(&batch_list);
> +	mutex_unlock(&text_mutex);
> +
> +	list_for_each_entry_safe(tp, next, &batch_list, list) {
> +		list_del(&tp->list);
> +		kfree(tp->opcode);
> +		kfree(tp);
> +	}
> +}
> +
>  static enum {
>  	JL_STATE_START,
>  	JL_STATE_NO_UPDATE,
> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
> index cd3bed880ca0..2aca92e03494 100644
> --- a/include/linux/jump_label.h
> +++ b/include/linux/jump_label.h
> @@ -156,6 +156,11 @@ extern void jump_label_lock(void);
>  extern void jump_label_unlock(void);
>  extern void arch_jump_label_transform(struct jump_entry *entry,
>  				      enum jump_label_type type);
> +#ifdef HAVE_JUMP_LABEL_BATCH
> +extern void arch_jump_label_transform_queue(struct jump_entry *entry,
> +					    enum jump_label_type type);
> +extern void arch_jump_label_transform_apply(void);
> +#endif
>  extern void arch_jump_label_transform_static(struct jump_entry *entry,
>  					     enum jump_label_type type);
>  extern int jump_label_text_reserved(void *start, void *end);
> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index 940ba7819c87..f534d9c4e07f 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -377,6 +377,7 @@ bool jump_label_can_update_check(struct jump_entry *entry)
>  	return 0;
>  }
>  
> +#ifndef HAVE_JUMP_LABEL_BATCH
>  static void __jump_label_update(struct static_key *key,
>  				struct jump_entry *entry,
>  				struct jump_entry *stop)
> @@ -386,6 +387,20 @@ static void __jump_label_update(struct static_key *key,
>  			arch_jump_label_transform(entry, jump_label_type(entry));
>  	}
>  }
> +#else
> +static void __jump_label_update(struct static_key *key,
> +				struct jump_entry *entry,
> +				struct jump_entry *stop)
> +{
> +	for_each_label_entry(key, entry, stop) {
> +		if (jump_label_can_update_check(entry))
> +			arch_jump_label_transform_queue(entry,
> +							jump_label_type(entry));
> +	}

So this could be done in batches if there are more entries than
PAGE_SIZE / sizeof(struct text_to_poke)


> +	arch_jump_label_transform_apply();
> +
> +}
> +#endif
>  
>  void __init jump_label_init(void)
>  {
> 
