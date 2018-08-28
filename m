Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59522C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED3720894
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 16:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED3720894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeH1URz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:17:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:37450 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727072AbeH1URz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:17:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 80827AFD7;
        Tue, 28 Aug 2018 16:25:27 +0000 (UTC)
Date:   Tue, 28 Aug 2018 18:25:51 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        security@kernel.org
Subject: Re: [PATCH v2] x86/dumpstack: don't dump kernel memory based on
 usermode RIP
Message-ID: <20180828162551.GA4950@nazgul.tnic>
References: <20180828154901.112726-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180828154901.112726-1-jannh@google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 05:49:01PM +0200, Jann Horn wrote:
> show_opcodes() is used both for dumping kernel instructions and for dumping
> user instructions. If userspace causes #PF by jumping to a kernel address,
> show_opcodes() can be reached with regs->ip controlled by the user,
> pointing to kernel code.

Yap, and people keep asking how to dump the running kernel, after
patching and jump labels and stuff... Here's how!

:-))))

> Make sure that userspace can't trick us into
> dumping kernel memory into dmesg.
> 
> Cc: stable@vger.kernel.org
> Fixes: 7cccf0725cf7 ("x86/dumpstack: Add a show_ip() function")

I think this one is more likely:

  ba54d856a9d8 ("x86/fault: Dump user opcode bytes on fatal faults")

as it added the dumping of user opcode bytes.

> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> v2: Andy pointed out that I probably shouldn't be doing wrapping
> arithmetic on pointers.
> 
>  arch/x86/include/asm/stacktrace.h |  2 +-
>  arch/x86/kernel/dumpstack.c       | 13 ++++++++++---
>  arch/x86/mm/fault.c               |  2 +-
>  3 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
> index b6dc698f992a..f335aad404a4 100644
> --- a/arch/x86/include/asm/stacktrace.h
> +++ b/arch/x86/include/asm/stacktrace.h
> @@ -111,6 +111,6 @@ static inline unsigned long caller_frame_pointer(void)
>  	return (unsigned long)frame;
>  }
>  
> -void show_opcodes(u8 *rip, const char *loglvl);
> +void show_opcodes(struct pt_regs *regs, const char *loglvl);
>  void show_ip(struct pt_regs *regs, const char *loglvl);
>  #endif /* _ASM_X86_STACKTRACE_H */
> diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> index 9c8652974f8e..14b337582b6f 100644
> --- a/arch/x86/kernel/dumpstack.c
> +++ b/arch/x86/kernel/dumpstack.c
> @@ -89,14 +89,21 @@ static void printk_stack_address(unsigned long address, int reliable,
>   * Thus, the 2/3rds prologue and 64 byte OPCODE_BUFSIZE is just a random
>   * guesstimate in attempt to achieve all of the above.
>   */
> -void show_opcodes(u8 *rip, const char *loglvl)
> +void show_opcodes(struct pt_regs *regs, const char *loglvl)
>  {
>  #define PROLOGUE_SIZE 42
>  #define EPILOGUE_SIZE 21
>  #define OPCODE_BUFSIZE (PROLOGUE_SIZE + 1 + EPILOGUE_SIZE)
>  	u8 opcodes[OPCODE_BUFSIZE];
> +	u8 *prologue = (u8 *)(regs->ip - PROLOGUE_SIZE);
> +	/*
> +	 * Make sure userspace isn't trying to trick us into dumping kernel
> +	 * memory by pointing the userspace instruction pointer at it.
> +	 */
> +	bool bad_ip = user_mode(regs) &&
> +		      __range_not_ok(prologue, OPCODE_BUFSIZE, TASK_SIZE_MAX);
>  

Ok, can we pls move the sole dumping of opcodes in a helper called,
__show_opcodes(), for example, which the checking wrapper show_opcodes()
- without the "__" prefix - calls?

So that show_signal_msg() can call the checking variant - show_opcodes()
- as userspace might be doing monkey business there and we definitely
wanna check first but __show_regs() can call the non-checking variant
__show_opcodes() because there we wanna dump whatever rIP points to
because we wanna know if the machine has gone off into the weeds etc,
when staring at splats.

Or am I missing a security aspect here?

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
