Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E00DC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 11:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ADBF218CD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 11:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfAZLw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 06:52:26 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37969 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfAZLwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 06:52:25 -0500
Received: by mail-qt1-f195.google.com with SMTP id p17so13604022qtl.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 03:52:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NwOXoP3Jrs1/NNuE5qNiF4uBZjuh8UP74x8HpOEvAR8=;
        b=FNKohk2PhGhpZwnOerubLED0HQVWQuAqaMQKvUuwylNTsLtJkZw+2VCRST+Sm1VKfQ
         j2s56bFISfHDeNxE8fbC/pdm02Q1okki5VH83w8IqNI17SBG/K4UVBbNRVnYXX1jqE+Y
         DEF8Txg9buQGp32dgpvfjt3sHx8xMfEiiJUSU6bor8/b4Iwg3Uvs3+IEJmuzAiT7V1qi
         Eswu5XcSiAQa8hj/pITvhtlehtAmOTCRd8L6M0ogXwj/vqi47sNV+EP7pjFeUM0qv4dh
         ji4nqVgVeMUcmmUR4OpyxrEKBaLDOz7jmsGE9FnHGFcleulHLzqPZCyzDCzNcEfMJx/V
         ZiZQ==
X-Gm-Message-State: AJcUukc6PTADsuhMruEiSm5YNaYOZ+SpHq9XLVdYI+VxwPG7fumWW0qa
        nPIFhKq1Snbx1Wp1xeFw54+OPg==
X-Google-Smtp-Source: ALg8bN4p35QuR5eGJ44s9tlwvVaXrD6OPq3sDN8pOzUOyLLkRFULdHBkhMnw4zs1YH6q/zLIaoVW/w==
X-Received: by 2002:a0c:f403:: with SMTP id h3mr13853076qvl.137.1548503544054;
        Sat, 26 Jan 2019 03:52:24 -0800 (PST)
Received: from t460s.bristot.redhat.com ([177.72.25.22])
        by smtp.gmail.com with ESMTPSA id q63sm60070606qke.44.2019.01.26.03.52.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 03:52:23 -0800 (PST)
Subject: Re: [PATCH V3 7/9] x86/alternative: Batch of patch operations
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Jason Baron <jbaron@akamai.com>, Scott Wood <swood@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
References: <cover.1545228276.git.bristot@redhat.com>
 <e3057f0d0bddd625de6d4e7c631faf734e28628b.1545228276.git.bristot@redhat.com>
 <20190123141523.eb6aa6a17efc76881e89e130@kernel.org>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <82bd24f1-305d-fa0c-aa13-3eac4a31fb93@redhat.com>
Date:   Sat, 26 Jan 2019 12:52:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190123141523.eb6aa6a17efc76881e89e130@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/19 6:15 AM, Masami Hiramatsu wrote:
> Hi Daniel,
> 
> On Fri, 21 Dec 2018 11:27:32 +0100
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>> Currently, the patch of an address is done in three steps:
>>
>> -- Pseudo-code #1 - Current implementation ---
>>         1) add an int3 trap to the address that will be patched
>>             sync cores (send IPI to all other CPUs)
>>         2) update all but the first byte of the patched range
>>             sync cores (send IPI to all other CPUs)
>>         3) replace the first byte (int3) by the first byte of replacing opcode
>>             sync cores (send IPI to all other CPUs)
>> -- Pseudo-code #1 ---
>>
>> When a static key has more than one entry, these steps are called once for
>> each entry. The number of IPIs then is linear with regard to the number 'n' of
>> entries of a key: O(n*3), which is O(n).
>>
>> This algorithm works fine for the update of a single key. But we think
>> it is possible to optimize the case in which a static key has more than
>> one entry. For instance, the sched_schedstats jump label has 56 entries
>> in my (updated) fedora kernel, resulting in 168 IPIs for each CPU in
>> which the thread that is enabling the key is _not_ running.
>>
>> With this patch, rather than receiving a single patch to be processed, a vector
>> of patches is passed, enabling the rewrite of the pseudo-code #1 in this
>> way:
>>
>> -- Pseudo-code #2 - This patch  ---
>> 1)  for each patch in the vector:
>>         add an int3 trap to the address that will be patched
>>
>>     sync cores (send IPI to all other CPUs)
>>
>> 2)  for each patch in the vector:
>>         update all but the first byte of the patched range
>>
>>     sync cores (send IPI to all other CPUs)
>>
>> 3)  for each patch in the vector:
>>         replace the first byte (int3) by the first byte of replacing opcode
>>
>>     sync cores (send IPI to all other CPUs)
>> -- Pseudo-code #2 - This patch  ---
>>
>> Doing the update in this way, the number of IPI becomes O(3) with regard
>> to the number of keys, which is O(1).
>>
>> The batch mode is done with the function text_poke_bp_batch(), that receives
>> two arguments: a vector of "struct text_to_poke", and the number of entries
>> in the vector.
>>
>> The vector must be sorted by the addr field of the text_to_poke structure,
>> enabling the binary search of a handler in the poke_int3_handler function
>> (a fast path).
>>
>> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
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
>>  arch/x86/include/asm/text-patching.h |  15 ++++
>>  arch/x86/kernel/alternative.c        | 108 +++++++++++++++++++++++++--
>>  2 files changed, 117 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
>> index e85ff65c43c3..42ea7846df33 100644
>> --- a/arch/x86/include/asm/text-patching.h
>> +++ b/arch/x86/include/asm/text-patching.h
>> @@ -18,6 +18,20 @@ static inline void apply_paravirt(struct paravirt_patch_site *start,
>>  #define __parainstructions_end	NULL
>>  #endif
>>  
>> +/*
>> + * Currently, the max observed size in the kernel code is
>> + * JUMP_LABEL_NOP_SIZE/RELATIVEJUMP_SIZE, which are 5.
>> + * Raise it if needed.
>> + */
>> +#define POKE_MAX_OPCODE_SIZE	5
>> +
>> +struct text_to_poke {
>> +	void *handler;
>> +	void *addr;
>> +	size_t len;
>> +	const char opcode[POKE_MAX_OPCODE_SIZE];
>> +};
>> +
>>  extern void *text_poke_early(void *addr, const void *opcode, size_t len);
>>  
>>  /*
>> @@ -37,6 +51,7 @@ extern void *text_poke_early(void *addr, const void *opcode, size_t len);
>>  extern void *text_poke(void *addr, const void *opcode, size_t len);
>>  extern int poke_int3_handler(struct pt_regs *regs);
>>  extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
>> +extern void text_poke_bp_batch(struct text_to_poke *tp, unsigned int nr_entries);
>>  extern int after_bootmem;
>>  
>>  #endif /* _ASM_X86_TEXT_PATCHING_H */
>> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
>> index 6f5ad8587de0..8fa47e5ec709 100644
>> --- a/arch/x86/kernel/alternative.c
>> +++ b/arch/x86/kernel/alternative.c
>> @@ -21,6 +21,7 @@
>>  #include <asm/tlbflush.h>
>>  #include <asm/io.h>
>>  #include <asm/fixmap.h>
>> +#include <linux/bsearch.h>
>>  
>>  int __read_mostly alternatives_patched;
>>  
>> @@ -738,10 +739,32 @@ static void do_sync_core(void *info)
>>  }
>>  
>>  static bool bp_patching_in_progress;
>> +/*
>> + * Single poke.
>> + */
>>  static void *bp_int3_handler, *bp_int3_addr;
>> +/*
>> + * Batching poke.
>> + */
>> +static struct text_to_poke *bp_int3_tpv;
>> +static unsigned int bp_int3_tpv_nr;
>> +
>> +static int text_bp_batch_bsearch(const void *key, const void *elt)
>> +{
>> +	struct text_to_poke *tp = (struct text_to_poke *) elt;
>> +
>> +	if (key < tp->addr)
>> +		return -1;
>> +	if (key > tp->addr)
>> +		return 1;
>> +	return 0;
>> +}
>>  
>>  int poke_int3_handler(struct pt_regs *regs)
>>  {
>> +	void *ip;
>> +	struct text_to_poke *tp;
>> +
>>  	/*
>>  	 * Having observed our INT3 instruction, we now must observe
>>  	 * bp_patching_in_progress.
>> @@ -757,21 +780,41 @@ int poke_int3_handler(struct pt_regs *regs)
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
>> +	 * Single poke first.
>> +	 */
> 
> I wonder why would you separate single poke and batch poke?
> It seems a single poke is just a case that bp_int3_tpv_nr == 1.

Hi Masami!

The single poke is used only at the boot time, before the system is able to
allocate memory. After that, the batch mode becomes the default.

I was thinking to make one function to each method, but then I would have to
change the do_int3() and manage how to switch between one and the other without
further overhead. I was planing to do this in a second round of improvements.

> If so, you can remove bp_int3_addr and this block.
> 
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
>> +	if (bp_int3_tpv_nr) {
> 
> if (unlikely(bp_int3_tpv_nr))
> 
> Sorry about interrupting, but this is a "hot-path" when we use kprobes.

No problem at all! :-)

I will change this function to better deal with the hot-path (the default mode
after the system boots up).

how about something like this:
------------------ %< ------------------
int poke_int3_handler(struct pt_regs *regs)
{
        void *ip;
        struct text_to_poke *tp;

        /*
         * Having observed our INT3 instruction, we now must observe
         * bp_patching_in_progress.
         *
         *      in_progress = TRUE              INT3
         *      WMB                             RMB
         *      write INT3                      if (in_progress)
         *
         * Idem for bp_int3_handler.
         */
        smp_rmb();

        if (likely(!bp_patching_in_progress))
                return 0;

        if (user_mode(regs))
                return 0;

        /*
         * Single poke is only used at the boot.
         */
        if (unlikely(!bp_int3_tpv))
                goto single_poke;

        ip = (void *) regs->ip - sizeof(unsigned char);
        tp = bsearch(ip, bp_int3_tpv, bp_int3_tpv_nr,
                     sizeof(struct text_to_poke),
                     text_bp_batch_bsearch);
        if (tp) {
                /* set up the specified breakpoint handler */
                regs->ip = (unsigned long) tp->handler;
                return 1;
        }

        return 0;

single_poke:
        if (regs->ip == (unsigned long) bp_int3_addr) {
                regs->ip = (unsigned long) bp_int3_handler;
                return 1;
        }

        return 0;
}
------------- >% ----------

In this way the default code is up, and the only 'if' I am using is a var of the
batch mode (that will be used later). If are are still at the boot, we are
jumping to the end of the function.

look better?

> 
> Also, could you add NOKPROBE_SYMBOL(); for all symbols involved in this
> process?
> Recently I found I missed it for poke_int3_handler and sent a fix.
> ( https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1898241.html )
> If this increase the function-call-chain from poke_int3_handler, those
> must be marked as NOKPROBE_SYMBOL().

Ack! Doing that!

Thanks!
