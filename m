Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E7DC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F1E2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F1E2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeJKOya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:54:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37262 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeJKOya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:54:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id 185-v6so8250272wmt.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 00:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=faJsz+IsqfDnPKeWnmD/XDv5jLeKP69JjDm7HJRK2YA=;
        b=kMtvmxIZlEtQQ1qTBcOb0lXe2kcs8A9Rko9pACBdHTiODIRP/s6qDYHxAiYYY16kXD
         c/hN6GeVS4UiXKLJ7elcqswbmjOtQzJYbhsiSytKd1Jbb8OtVOiL+pjHrqXy0qix+yvx
         OxumoJcdMDeKQoRhFrX39yeBXn/ncSmSgjrS8qHT26LTlmh2Owhcert/4Ug4U+pwwmWZ
         CqkMEGmY/6aPl1uY4ThJeL9KwWIeaT+DypYexMBciRdc/ZVWb+yf1nQIhVhiDLHe0jf7
         td+u7yUt0e3+g4OS6hYdb3uJxHKGw8cDzn99lK1/pRhaDZPFnb6Ck9Rq0XRn0j1KrXO7
         XhFg==
X-Gm-Message-State: ABuFfogdnfQxTcf5RoZWs56LyOVNSzYBzWHJgNQHSiqSV+Iloe9wzl6B
        0WTyG5Ohn5ZX+7euZ0IiQ/1kXg==
X-Google-Smtp-Source: ACcGV632ZiOglWRTsHbo5h21DXHRjsvqQTlx7Im/IJ+qMXOOVWmOf7hlgMGULLi9xz5OOfG1Gpu10w==
X-Received: by 2002:a1c:14d1:: with SMTP id 200-v6mr669154wmu.106.1539242908310;
        Thu, 11 Oct 2018 00:28:28 -0700 (PDT)
Received: from t460s.bristot.redhat.com (nat-cataldo.sssup.it. [193.205.81.5])
        by smtp.gmail.com with ESMTPSA id x186-v6sm36712693wmx.24.2018.10.11.00.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 00:28:27 -0700 (PDT)
Subject: Re: [RFC PATCH 6/6] x86/jump_label,x86/alternatives: Batch jump label
 transformations
To:     Steven Rostedt <rostedt@goodmis.org>
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
References: <cover.1539001620.git.bristot@redhat.com>
 <e99eb239b0546e180e49c1e5a9e607fb6af0ec60.1539001620.git.bristot@redhat.com>
 <20181010161759.7bd681c1@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <e475d6f7-4bb9-a701-cddb-29a70c84764e@redhat.com>
Date:   Thu, 11 Oct 2018 09:28:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181010161759.7bd681c1@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18 10:17 PM, Steven Rostedt wrote:
> On Mon,  8 Oct 2018 14:53:05 +0200
> Daniel Bristot de Oliveira <bristot@redhat.com> wrote:
> 
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
> 
> I hate this loop. Makes hitting the static branch (which is probably in
> a fast path, otherwise why use static branches?), do a O(n) loop of
> batch updates. You may not have that many, but why not optimize it?
> 
> Can we make an array of the handlers, in sorted order, then we simply
> do a binary search for the ip involved? Turning this from O(n) to
> O(log2(n)).
> 
> As Jason mentioned. If you set aside a page for processing batches up
> to PAGE / (sizeof tp) then you can also make it sorted and replace the
> iteration with a loop.

Hi Steven!

I am convinced! I am working in the v2 now, that will:

Split the batch mode into two patches (Jason)
Use an aside page rather than allocating memory (Jason)
Use a sorted vector of keys with binary search in the int3 handler (Steven)

I will also do some performance tests in the int3 handler (peterz on IRC).

Thanks!

-- Daniel
