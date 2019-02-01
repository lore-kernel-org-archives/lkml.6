Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5799C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9C2218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbfBAMtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:49:43 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:47099 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfBAMtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:49:42 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so7208254qtm.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 04:49:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MdW34/ED0liT6PA0lGKp+bJ59Tv9uOVttUpJvWFkKAI=;
        b=RHRcFvJO3WPwlX92FwF85aKhgHkcJzMANsYu1nXGQ0/eSLlWFlsRQSF/AtLEZfJDj6
         pYxdI78sBNeb37Z+aCX+iMQt9q06TXSGGBJZx9EBnrwufKkPdA55PErXJ7LLhxgfsDKD
         PkFMxlLpk7e54fTej+psOfKjSSa5G8T+sfew2L0jJB+RtmH1LNJb1gtI/fCpgE8yS801
         hX34onjlc5f658V/wG80hp8ndhuR9j4NRJqvtK4TORQU6hx8lDOR4N2wYDI7IXG4pKII
         SnKhvv/0jsBDnOFnqTi2NhYvMkCqNEGAbV6INiWlHzh4NkQIO6eSEooirsnHT5cUULOl
         pc7g==
X-Gm-Message-State: AJcUukf9trnIH86VNTYPvgyTpkQinU8ikKa6ZNC6NUjIKW88+6eQItdM
        pwet5v6y+fihapbENOF6GLKenQ==
X-Google-Smtp-Source: ALg8bN6cl/YOVMm3XYP6wMR4pP3RgVvgDi/0B1TDa6YwgTa6w7SBRV6Rxn3DTTGr49e4pAGFdMvqCQ==
X-Received: by 2002:ac8:278a:: with SMTP id w10mr38994904qtw.149.1549025380571;
        Fri, 01 Feb 2019 04:49:40 -0800 (PST)
Received: from t460s.bristot.redhat.com ([177.72.25.22])
        by smtp.gmail.com with ESMTPSA id 12sm17152173qka.83.2019.02.01.04.49.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 04:49:39 -0800 (PST)
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
 <82bd24f1-305d-fa0c-aa13-3eac4a31fb93@redhat.com>
 <20190128225254.6a30448ad13577c865f2bf69@kernel.org>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <d83c9449-c62d-ecf6-1e37-a14d33053adf@redhat.com>
Date:   Fri, 1 Feb 2019 13:49:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128225254.6a30448ad13577c865f2bf69@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/19 2:52 PM, Masami Hiramatsu wrote:
> On Sat, 26 Jan 2019 12:52:15 +0100
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
>> On 1/23/19 6:15 AM, Masami Hiramatsu wrote:
>>> Hi Daniel,
>>>
>>> On Fri, 21 Dec 2018 11:27:32 +0100
>>> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
>>>
>>>> Currently, the patch of an address is done in three steps:
>>>>
>>>> -- Pseudo-code #1 - Current implementation ---
>>>>         1) add an int3 trap to the address that will be patched
>>>>             sync cores (send IPI to all other CPUs)
>>>>         2) update all but the first byte of the patched range
>>>>             sync cores (send IPI to all other CPUs)
>>>>         3) replace the first byte (int3) by the first byte of replacing opcode
>>>>             sync cores (send IPI to all other CPUs)
>>>> -- Pseudo-code #1 ---
>>>>
>>>> When a static key has more than one entry, these steps are called once for
>>>> each entry. The number of IPIs then is linear with regard to the number 'n' of
>>>> entries of a key: O(n*3), which is O(n).
>>>>
>>>> This algorithm works fine for the update of a single key. But we think
>>>> it is possible to optimize the case in which a static key has more than
>>>> one entry. For instance, the sched_schedstats jump label has 56 entries
>>>> in my (updated) fedora kernel, resulting in 168 IPIs for each CPU in
>>>> which the thread that is enabling the key is _not_ running.
>>>>
>>>> With this patch, rather than receiving a single patch to be processed, a vector
>>>> of patches is passed, enabling the rewrite of the pseudo-code #1 in this
>>>> way:
>>>>
>>>> -- Pseudo-code #2 - This patch  ---
>>>> 1)  for each patch in the vector:
>>>>         add an int3 trap to the address that will be patched
>>>>
>>>>     sync cores (send IPI to all other CPUs)
>>>>
>>>> 2)  for each patch in the vector:
>>>>         update all but the first byte of the patched range
>>>>
>>>>     sync cores (send IPI to all other CPUs)
>>>>
>>>> 3)  for each patch in the vector:
>>>>         replace the first byte (int3) by the first byte of replacing opcode
>>>>
>>>>     sync cores (send IPI to all other CPUs)
>>>> -- Pseudo-code #2 - This patch  ---
>>>>
>>>> Doing the update in this way, the number of IPI becomes O(3) with regard
>>>> to the number of keys, which is O(1).
>>>>
>>>> The batch mode is done with the function text_poke_bp_batch(), that receives
>>>> two arguments: a vector of "struct text_to_poke", and the number of entries
>>>> in the vector.
>>>>
>>>> The vector must be sorted by the addr field of the text_to_poke structure,
>>>> enabling the binary search of a handler in the poke_int3_handler function
>>>> (a fast path).
>>>>
>>>> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>> Cc: Borislav Petkov <bp@alien8.de>
>>>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>>>> Cc: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>>>> Cc: Jiri Kosina <jkosina@suse.cz>
>>>> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
>>>> Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
>>>> Cc: Chris von Recklinghausen <crecklin@redhat.com>
>>>> Cc: Jason Baron <jbaron@akamai.com>
>>>> Cc: Scott Wood <swood@redhat.com>
>>>> Cc: Marcelo Tosatti <mtosatti@redhat.com>
>>>> Cc: Clark Williams <williams@redhat.com>
>>>> Cc: x86@kernel.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> ---
>>>>  arch/x86/include/asm/text-patching.h |  15 ++++
>>>>  arch/x86/kernel/alternative.c        | 108 +++++++++++++++++++++++++--
>>>>  2 files changed, 117 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
>>>> index e85ff65c43c3..42ea7846df33 100644
>>>> --- a/arch/x86/include/asm/text-patching.h
>>>> +++ b/arch/x86/include/asm/text-patching.h
>>>> @@ -18,6 +18,20 @@ static inline void apply_paravirt(struct paravirt_patch_site *start,
>>>>  #define __parainstructions_end	NULL
>>>>  #endif
>>>>  
>>>> +/*
>>>> + * Currently, the max observed size in the kernel code is
>>>> + * JUMP_LABEL_NOP_SIZE/RELATIVEJUMP_SIZE, which are 5.
>>>> + * Raise it if needed.
>>>> + */
>>>> +#define POKE_MAX_OPCODE_SIZE	5
>>>> +
>>>> +struct text_to_poke {
>>>> +	void *handler;
>>>> +	void *addr;
>>>> +	size_t len;
>>>> +	const char opcode[POKE_MAX_OPCODE_SIZE];
>>>> +};
>>>> +
>>>>  extern void *text_poke_early(void *addr, const void *opcode, size_t len);
>>>>  
>>>>  /*
>>>> @@ -37,6 +51,7 @@ extern void *text_poke_early(void *addr, const void *opcode, size_t len);
>>>>  extern void *text_poke(void *addr, const void *opcode, size_t len);
>>>>  extern int poke_int3_handler(struct pt_regs *regs);
>>>>  extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
>>>> +extern void text_poke_bp_batch(struct text_to_poke *tp, unsigned int nr_entries);
>>>>  extern int after_bootmem;
>>>>  
>>>>  #endif /* _ASM_X86_TEXT_PATCHING_H */
>>>> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
>>>> index 6f5ad8587de0..8fa47e5ec709 100644
>>>> --- a/arch/x86/kernel/alternative.c
>>>> +++ b/arch/x86/kernel/alternative.c
>>>> @@ -21,6 +21,7 @@
>>>>  #include <asm/tlbflush.h>
>>>>  #include <asm/io.h>
>>>>  #include <asm/fixmap.h>
>>>> +#include <linux/bsearch.h>
>>>>  
>>>>  int __read_mostly alternatives_patched;
>>>>  
>>>> @@ -738,10 +739,32 @@ static void do_sync_core(void *info)
>>>>  }
>>>>  
>>>>  static bool bp_patching_in_progress;
>>>> +/*
>>>> + * Single poke.
>>>> + */
>>>>  static void *bp_int3_handler, *bp_int3_addr;
>>>> +/*
>>>> + * Batching poke.
>>>> + */
>>>> +static struct text_to_poke *bp_int3_tpv;
>>>> +static unsigned int bp_int3_tpv_nr;
>>>> +
>>>> +static int text_bp_batch_bsearch(const void *key, const void *elt)
>>>> +{
>>>> +	struct text_to_poke *tp = (struct text_to_poke *) elt;
>>>> +
>>>> +	if (key < tp->addr)
>>>> +		return -1;
>>>> +	if (key > tp->addr)
>>>> +		return 1;
>>>> +	return 0;
>>>> +}
>>>>  
>>>>  int poke_int3_handler(struct pt_regs *regs)
>>>>  {
>>>> +	void *ip;
>>>> +	struct text_to_poke *tp;
>>>> +
>>>>  	/*
>>>>  	 * Having observed our INT3 instruction, we now must observe
>>>>  	 * bp_patching_in_progress.
>>>> @@ -757,21 +780,41 @@ int poke_int3_handler(struct pt_regs *regs)
>>>>  	if (likely(!bp_patching_in_progress))
>>>>  		return 0;
>>>>  
>>>> -	if (user_mode(regs) || regs->ip != (unsigned long)bp_int3_addr)
>>>> +	if (user_mode(regs))
>>>>  		return 0;
>>>>  
>>>> -	/* set up the specified breakpoint handler */
>>>> -	regs->ip = (unsigned long) bp_int3_handler;
>>>> +	/*
>>>> +	 * Single poke first.
>>>> +	 */
>>>
>>> I wonder why would you separate single poke and batch poke?
>>> It seems a single poke is just a case that bp_int3_tpv_nr == 1.
>>
>> Hi Masami!
>>
>> The single poke is used only at the boot time, before the system is able to
>> allocate memory. After that, the batch mode becomes the default.
> 
> Hmm, what's the difference from text_poke_early()?

text_poke_early(): before enabling interrupts at boot.

text_poke_bp(): after enabling interrupts, before being able to allocate memory,
or in the error handling with batch mode.

task_poke_batch(): After enabling interrupts and being able to allocate memory.

>>
>> I was thinking to make one function to each method, but then I would have to
>> change the do_int3() and manage how to switch between one and the other without
>> further overhead. I was planing to do this in a second round of improvements.
> 
> I didn't think such big change.
> I just thought we could allocate single entry array on stack, something like

Ah!

> text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
> {
> 	struct text_to_poke tp = {.handler = handler, .addr = addr, .len = len};
> 	if (len > POKE_MAX_OPCODE_SIZE)
> 		return -E2BIG;
> 	memcpy(tp.opcode, opcode, len);
> 	return text_poke_bp_batch(&tp, 1);
> }

Good idea!

>>
>>> If so, you can remove bp_int3_addr and this block.
>>>
>>>> +	if (bp_int3_addr) {
>>>> +		if (regs->ip == (unsigned long) bp_int3_addr) {
>>>> +			regs->ip = (unsigned long) bp_int3_handler;
>>>> +			return 1;
>>>> +		}
>>>> +		return 0;
>>>> +	}
>>>>
>>>> -	return 1;
>>>> +	/*
>>>> +	 * Batch mode.
>>>> +	 */
>>>> +	if (bp_int3_tpv_nr) {
>>>
>>> if (unlikely(bp_int3_tpv_nr))
>>>
>>> Sorry about interrupting, but this is a "hot-path" when we use kprobes.
>>
>> No problem at all! :-)
> 
> Thanks! :-)
> 
>>
>> I will change this function to better deal with the hot-path (the default mode
>> after the system boots up).
>>
>> how about something like this:
>> ------------------ %< ------------------
>> int poke_int3_handler(struct pt_regs *regs)
>> {
>>         void *ip;
>>         struct text_to_poke *tp;
>>
>>         /*
>>          * Having observed our INT3 instruction, we now must observe
>>          * bp_patching_in_progress.
>>          *
>>          *      in_progress = TRUE              INT3
>>          *      WMB                             RMB
>>          *      write INT3                      if (in_progress)
>>          *
>>          * Idem for bp_int3_handler.
>>          */
>>         smp_rmb();
>>
>>         if (likely(!bp_patching_in_progress))
>>                 return 0;
>>
>>         if (user_mode(regs))
>>                 return 0;
>>
>>         /*
>>          * Single poke is only used at the boot.
>>          */
>>         if (unlikely(!bp_int3_tpv))
>>                 goto single_poke;
>>
>>         ip = (void *) regs->ip - sizeof(unsigned char);
>>         tp = bsearch(ip, bp_int3_tpv, bp_int3_tpv_nr,
>>                      sizeof(struct text_to_poke),
>>                      text_bp_batch_bsearch);
>>         if (tp) {
>>                 /* set up the specified breakpoint handler */
>>                 regs->ip = (unsigned long) tp->handler;
>>                 return 1;
>>         }
>>
>>         return 0;
>>
>> single_poke:
>>         if (regs->ip == (unsigned long) bp_int3_addr) {
>>                 regs->ip = (unsigned long) bp_int3_handler;
>>                 return 1;
>>         }
>>
>>         return 0;
>> }
>> ------------- >% ----------
>>
>> In this way the default code is up, and the only 'if' I am using is a var of the
>> batch mode (that will be used later). If are are still at the boot, we are
>> jumping to the end of the function.
>>
>> look better?
> 
> yeah, it looks much better. But I just wonder why don't you consolidate both by
> just because reducing code.
> 

and so I did. How about something like this?
---------- %< ---------
---
 arch/x86/include/asm/text-patching.h |  15 ++++
 arch/x86/kernel/alternative.c        | 118 +++++++++++++++++++--------
 lib/bsearch.c                        |   2 +
 3 files changed, 100 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index e85ff65c43c3..42ea7846df33 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -18,6 +18,20 @@ static inline void apply_paravirt(struct paravirt_patch_site *start,
 #define __parainstructions_end	NULL
 #endif
 
+/*
+ * Currently, the max observed size in the kernel code is
+ * JUMP_LABEL_NOP_SIZE/RELATIVEJUMP_SIZE, which are 5.
+ * Raise it if needed.
+ */
+#define POKE_MAX_OPCODE_SIZE	5
+
+struct text_to_poke {
+	void *handler;
+	void *addr;
+	size_t len;
+	const char opcode[POKE_MAX_OPCODE_SIZE];
+};
+
 extern void *text_poke_early(void *addr, const void *opcode, size_t len);
 
 /*
@@ -37,6 +51,7 @@ extern void *text_poke_early(void *addr, const void *opcode, size_t len);
 extern void *text_poke(void *addr, const void *opcode, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
 extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
+extern void text_poke_bp_batch(struct text_to_poke *tp, unsigned int nr_entries);
 extern int after_bootmem;
 
 #endif /* _ASM_X86_TEXT_PATCHING_H */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 202af29c43c0..2196bb8bb924 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -11,6 +11,7 @@
 #include <linux/stop_machine.h>
 #include <linux/slab.h>
 #include <linux/kdebug.h>
+#include <linux/kprobes.h>
 #include <asm/text-patching.h>
 #include <asm/alternative.h>
 #include <asm/sections.h>
@@ -21,6 +22,7 @@
 #include <asm/tlbflush.h>
 #include <asm/io.h>
 #include <asm/fixmap.h>
+#include <linux/bsearch.h>
 
 int __read_mostly alternatives_patched;
 
@@ -738,10 +740,26 @@ static void do_sync_core(void *info)
 }
 
 static bool bp_patching_in_progress;
-static void *bp_int3_handler, *bp_int3_addr;
+static struct text_to_poke *bp_int3_tpv;
+static unsigned int bp_int3_tpv_nr;
+
+static int text_bp_batch_bsearch(const void *key, const void *elt)
+{
+	struct text_to_poke *tp = (struct text_to_poke *) elt;
+
+	if (key < tp->addr)
+		return -1;
+	if (key > tp->addr)
+		return 1;
+	return 0;
+}
+NOKPROBE_SYMBOL(text_bp_batch_bsearch);
 
 int poke_int3_handler(struct pt_regs *regs)
 {
+	void *ip;
+	struct text_to_poke *tp;
+
 	/*
 	 * Having observed our INT3 instruction, we now must observe
 	 * bp_patching_in_progress.
@@ -757,21 +775,41 @@ int poke_int3_handler(struct pt_regs *regs)
 	if (likely(!bp_patching_in_progress))
 		return 0;
 
-	if (user_mode(regs) || regs->ip != (unsigned long)bp_int3_addr)
+	if (user_mode(regs))
 		return 0;
 
-	/* set up the specified breakpoint handler */
-	regs->ip = (unsigned long) bp_int3_handler;
+	ip = (void *) regs->ip - sizeof(unsigned char);
 
-	return 1;
+	/*
+	 * Skip the binary search if there is a single member in the vector.
+	 */
+	if (unlikely(bp_int3_tpv_nr == 1))
+		goto single_poke;
+
+	tp = bsearch(ip, bp_int3_tpv, bp_int3_tpv_nr,
+		     sizeof(struct text_to_poke),
+		     text_bp_batch_bsearch);
+	if (tp) {
+		/* set up the specified breakpoint handler */
+		regs->ip = (unsigned long) tp->handler;
+		return 1;
+	}
+
+	return 0;
+
+single_poke:
+	if (ip == (unsigned long) bp_int3_tpv->addr) {
+		regs->ip = (unsigned long) bp_int3_tpv->handler;
+		return 1;
+	}
 
+	return 0;
 }
+NOKPROBE_SYMBOL(poke_int3_handler);
 
 static void text_poke_bp_set_handler(void *addr, void *handler,
 				     unsigned char int3)
 {
-	bp_int3_handler = handler;
-	bp_int3_addr = (u8 *)addr + sizeof(int3);
 	text_poke(addr, &int3, sizeof(int3));
 }
 
@@ -790,32 +828,14 @@ static void patch_first_byte(void *addr, const void *opcode, unsigned char int3)
 	text_poke(addr, opcode, sizeof(int3));
 }
 
-/**
- * text_poke_bp() -- update instructions on live kernel on SMP
- * @addr:	address to patch
- * @opcode:	opcode of new instruction
- * @len:	length to copy
- * @handler:	address to jump to when the temporary breakpoint is hit
- *
- * Modify multi-byte instruction by using int3 breakpoint on SMP.
- * We completely avoid stop_machine() here, and achieve the
- * synchronization using int3 breakpoint.
- *
- * The way it is done:
- *	- add a int3 trap to the address that will be patched
- *	- sync cores
- *	- update all but the first byte of the patched range
- *	- sync cores
- *	- replace the first byte (int3) by the first byte of
- *	  replacing opcode
- *	- sync cores
- */
-void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
+void text_poke_bp_batch(struct text_to_poke *tp, unsigned int nr_entries)
 {
+	unsigned int i;
 	unsigned char int3 = 0xcc;
+	int patched_all_but_first = 0;
 
-	lockdep_assert_held(&text_mutex);
-
+	bp_int3_tpv = tp;
+	bp_int3_tpv_nr = nr_entries;
 	bp_patching_in_progress = true;
 	/*
 	 * Corresponding read barrier in int3 notifier for making sure the
@@ -823,12 +843,20 @@ void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
 	 */
 	smp_wmb();
 
-	text_poke_bp_set_handler(addr, handler, int3);
+	for (i = 0; i < nr_entries; i++)
+		text_poke_bp_set_handler(tp[i].addr, tp[i].handler, int3);
 
 	on_each_cpu(do_sync_core, NULL, 1);
 
-	if (len - sizeof(int3) > 0) {
-		patch_all_but_first_byte(addr, opcode, len, int3);
+	for (i = 0; i < nr_entries; i++) {
+		if (tp[i].len - sizeof(int3) > 0) {
+			patch_all_but_first_byte(tp[i].addr, tp[i].opcode,
+						 tp[i].len, int3);
+			patched_all_but_first++;
+		}
+	}
+
+	if (patched_all_but_first) {
 		/*
 		 * According to Intel, this core syncing is very likely
 		 * not necessary and we'd be safe even without it. But
@@ -837,15 +865,35 @@ void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
 		on_each_cpu(do_sync_core, NULL, 1);
 	}
 
-	patch_first_byte(addr, opcode, int3);
+	for (i = 0; i < nr_entries; i++)
+		patch_first_byte(tp[i].addr, tp[i].opcode, int3);
 
 	on_each_cpu(do_sync_core, NULL, 1);
 	/*
 	 * sync_core() implies an smp_mb() and orders this store against
 	 * the writing of the new instruction.
 	 */
+	bp_int3_tpv_nr = 0;
+	bp_int3_tpv = NULL;
 	bp_patching_in_progress = false;
+}
+ XXX: paste the old comment here... I forgot.
+void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler)
+{
+	struct text_to_poke tp = {
+		.handler = handler,
+		.addr = addr,
+		.len = len
+	};
+
+	if (len > POKE_MAX_OPCODE_SIZE) {
+		WARN_ONCE(1, "len is larger than %d\n", POKE_MAX_OPCODE_SIZE);
+		return NULL;
+	}
+
+	memcpy((void *)tp.opcode, opcode, len);
+
+	text_poke_bp_batch(&tp, 1);
 
 	return addr;
 }
-
diff --git a/lib/bsearch.c b/lib/bsearch.c
index 18b445b010c3..82512fe7b33c 100644
--- a/lib/bsearch.c
+++ b/lib/bsearch.c
@@ -11,6 +11,7 @@
 
 #include <linux/export.h>
 #include <linux/bsearch.h>
+#include <linux/kprobes.h>
 
 /*
  * bsearch - binary search an array of elements
@@ -53,3 +54,4 @@ void *bsearch(const void *key, const void *base, size_t num, size_t size,
 	return NULL;
 }
 EXPORT_SYMBOL(bsearch);
+NOKPROBE_SYMBOL(bsearch);
-- 

If so, I will send a v4 with this ideia.

Thanks!

-- Daniel
