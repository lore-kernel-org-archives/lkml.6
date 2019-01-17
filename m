Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F87C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D7D20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 21:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfAQVRM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 16:17:12 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48793 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728436AbfAQVRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 16:17:10 -0500
Received: from wld62.hos.anvin.org (c-24-5-245-234.hsd1.ca.comcast.net [24.5.245.234] (may be forged))
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x0HLG1ZM901070
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 17 Jan 2019 13:16:01 -0800
Date:   Thu, 17 Jan 2019 13:15:54 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20190117154701.78aa8e9d0130716e0d9ac026@kernel.org>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com> <20190117003259.23141-2-rick.p.edgecombe@intel.com> <20190117154701.78aa8e9d0130716e0d9ac026@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 01/17] Fix "x86/alternatives: Lockdep-enforce text_mutex in text_poke*()"
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
CC:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, linux_dti@icloud.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Nadav Amit <namit@vmware.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>
From:   hpa@zytor.com
Message-ID: <F3B332DA-4637-4A3B-93F9-C7903C1D9FF9@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 16, 2019 10:47:01 PM PST, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>On Wed, 16 Jan 2019 16:32:43 -0800
>Rick Edgecombe <rick.p.edgecombe@intel.com> wrote:
>
>> From: Nadav Amit <namit@vmware.com>
>> 
>> text_mutex is currently expected to be held before text_poke() is
>> called, but we kgdb does not take the mutex, and instead *supposedly*
>> ensures the lock is not taken and will not be acquired by any other
>core
>> while text_poke() is running.
>> 
>> The reason for the "supposedly" comment is that it is not entirely
>clear
>> that this would be the case if gdb_do_roundup is zero.
>> 
>> This patch creates two wrapper functions, text_poke() and
>> text_poke_kgdb() which do or do not run the lockdep assertion
>> respectively.
>> 
>> While we are at it, change the return code of text_poke() to
>something
>> meaningful. One day, callers might actually respect it and the
>existing
>> BUG_ON() when patching fails could be removed. For kgdb, the return
>> value can actually be used.
>
>Looks good to me.
>
>Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
>
>Thank you,
>
>> 
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Dave Hansen <dave.hansen@intel.com>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Fixes: 9222f606506c ("x86/alternatives: Lockdep-enforce text_mutex in
>text_poke*()")
>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>> Acked-by: Jiri Kosina <jkosina@suse.cz>
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>> ---
>>  arch/x86/include/asm/text-patching.h |  1 +
>>  arch/x86/kernel/alternative.c        | 52
>++++++++++++++++++++--------
>>  arch/x86/kernel/kgdb.c               | 11 +++---
>>  3 files changed, 45 insertions(+), 19 deletions(-)
>> 
>> diff --git a/arch/x86/include/asm/text-patching.h
>b/arch/x86/include/asm/text-patching.h
>> index e85ff65c43c3..f8fc8e86cf01 100644
>> --- a/arch/x86/include/asm/text-patching.h
>> +++ b/arch/x86/include/asm/text-patching.h
>> @@ -35,6 +35,7 @@ extern void *text_poke_early(void *addr, const void
>*opcode, size_t len);
>>   * inconsistent instruction while you patch.
>>   */
>>  extern void *text_poke(void *addr, const void *opcode, size_t len);
>> +extern void *text_poke_kgdb(void *addr, const void *opcode, size_t
>len);
>>  extern int poke_int3_handler(struct pt_regs *regs);
>>  extern void *text_poke_bp(void *addr, const void *opcode, size_t
>len, void *handler);
>>  extern int after_bootmem;
>> diff --git a/arch/x86/kernel/alternative.c
>b/arch/x86/kernel/alternative.c
>> index ebeac487a20c..c6a3a10a2fd5 100644
>> --- a/arch/x86/kernel/alternative.c
>> +++ b/arch/x86/kernel/alternative.c
>> @@ -678,18 +678,7 @@ void *__init_or_module text_poke_early(void
>*addr, const void *opcode,
>>  	return addr;
>>  }
>>  
>> -/**
>> - * text_poke - Update instructions on a live kernel
>> - * @addr: address to modify
>> - * @opcode: source of the copy
>> - * @len: length to copy
>> - *
>> - * Only atomic text poke/set should be allowed when not doing early
>patching.
>> - * It means the size must be writable atomically and the address
>must be aligned
>> - * in a way that permits an atomic write. It also makes sure we fit
>on a single
>> - * page.
>> - */
>> -void *text_poke(void *addr, const void *opcode, size_t len)
>> +static void *__text_poke(void *addr, const void *opcode, size_t len)
>>  {
>>  	unsigned long flags;
>>  	char *vaddr;
>> @@ -702,8 +691,6 @@ void *text_poke(void *addr, const void *opcode,
>size_t len)
>>  	 */
>>  	BUG_ON(!after_bootmem);
>>  
>> -	lockdep_assert_held(&text_mutex);
>> -
>>  	if (!core_kernel_text((unsigned long)addr)) {
>>  		pages[0] = vmalloc_to_page(addr);
>>  		pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
>> @@ -732,6 +719,43 @@ void *text_poke(void *addr, const void *opcode,
>size_t len)
>>  	return addr;
>>  }
>>  
>> +/**
>> + * text_poke - Update instructions on a live kernel
>> + * @addr: address to modify
>> + * @opcode: source of the copy
>> + * @len: length to copy
>> + *
>> + * Only atomic text poke/set should be allowed when not doing early
>patching.
>> + * It means the size must be writable atomically and the address
>must be aligned
>> + * in a way that permits an atomic write. It also makes sure we fit
>on a single
>> + * page.
>> + */
>> +void *text_poke(void *addr, const void *opcode, size_t len)
>> +{
>> +	lockdep_assert_held(&text_mutex);
>> +
>> +	return __text_poke(addr, opcode, len);
>> +}
>> +
>> +/**
>> + * text_poke_kgdb - Update instructions on a live kernel by kgdb
>> + * @addr: address to modify
>> + * @opcode: source of the copy
>> + * @len: length to copy
>> + *
>> + * Only atomic text poke/set should be allowed when not doing early
>patching.
>> + * It means the size must be writable atomically and the address
>must be aligned
>> + * in a way that permits an atomic write. It also makes sure we fit
>on a single
>> + * page.
>> + *
>> + * Context: should only be used by kgdb, which ensures no other core
>is running,
>> + *	    despite the fact it does not hold the text_mutex.
>> + */
>> +void *text_poke_kgdb(void *addr, const void *opcode, size_t len)
>> +{
>> +	return __text_poke(addr, opcode, len);
>> +}
>> +
>>  static void do_sync_core(void *info)
>>  {
>>  	sync_core();
>> diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
>> index 5db08425063e..1461544cba8b 100644
>> --- a/arch/x86/kernel/kgdb.c
>> +++ b/arch/x86/kernel/kgdb.c
>> @@ -758,13 +758,13 @@ int kgdb_arch_set_breakpoint(struct kgdb_bkpt
>*bpt)
>>  	if (!err)
>>  		return err;
>>  	/*
>> -	 * It is safe to call text_poke() because normal kernel execution
>> +	 * It is safe to call text_poke_kgdb() because normal kernel
>execution
>>  	 * is stopped on all cores, so long as the text_mutex is not
>locked.
>>  	 */
>>  	if (mutex_is_locked(&text_mutex))
>>  		return -EBUSY;
>> -	text_poke((void *)bpt->bpt_addr, arch_kgdb_ops.gdb_bpt_instr,
>> -		  BREAK_INSTR_SIZE);
>> +	text_poke_kgdb((void *)bpt->bpt_addr, arch_kgdb_ops.gdb_bpt_instr,
>> +		       BREAK_INSTR_SIZE);
>>  	err = probe_kernel_read(opc, (char *)bpt->bpt_addr,
>BREAK_INSTR_SIZE);
>>  	if (err)
>>  		return err;
>> @@ -783,12 +783,13 @@ int kgdb_arch_remove_breakpoint(struct
>kgdb_bkpt *bpt)
>>  	if (bpt->type != BP_POKE_BREAKPOINT)
>>  		goto knl_write;
>>  	/*
>> -	 * It is safe to call text_poke() because normal kernel execution
>> +	 * It is safe to call text_poke_kgdb() because normal kernel
>execution
>>  	 * is stopped on all cores, so long as the text_mutex is not
>locked.
>>  	 */
>>  	if (mutex_is_locked(&text_mutex))
>>  		goto knl_write;
>> -	text_poke((void *)bpt->bpt_addr, bpt->saved_instr,
>BREAK_INSTR_SIZE);
>> +	text_poke_kgdb((void *)bpt->bpt_addr, bpt->saved_instr,
>> +		       BREAK_INSTR_SIZE);
>>  	err = probe_kernel_read(opc, (char *)bpt->bpt_addr,
>BREAK_INSTR_SIZE);
>>  	if (err || memcmp(opc, bpt->saved_instr, BREAK_INSTR_SIZE))
>>  		goto knl_write;
>> -- 
>> 2.17.1
>> 

If you are reorganizing this code, please do so so that the caller doesn't have to worry about if it should call text_poke_bp() or text_poke_early(). Right now the caller had to know that, which makes no sense.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
