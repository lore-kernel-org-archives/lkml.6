Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbeCOSHd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:07:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751466AbeCOSHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:07:32 -0400
Date: Thu, 15 Mar 2018 13:07:31 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 9/9] x86/dumpstack: Explain the reasoning for the
 prologue and buffer size
Message-ID: <20180315180731.mnbpqjte4wafnzd3@treble>
References: <20180315154448.16222-1-bp@alien8.de>
 <20180315154448.16222-10-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180315154448.16222-10-bp@alien8.de>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 04:44:48PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> The whole reasoning behind the amount of opcode bytes dumped and
> prologue length isn't very clear so let's hold down some of the reasons
> for why it is done the way it is.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/kernel/dumpstack.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> index bb712ca99632..7ceba3c09ad7 100644
> --- a/arch/x86/kernel/dumpstack.c
> +++ b/arch/x86/kernel/dumpstack.c
> @@ -70,6 +70,25 @@ static void printk_stack_address(unsigned long address, int reliable,
>  	printk("%s %s%pB\n", log_lvl, reliable ? "" : "? ", (void *)address);
>  }
>  
> +/*
> + * The are a couple of reasons for the 2/3rd prologue, courtesy of Linus:

s/The/There/

> + *
> + * In case where we don't have the exact kernel image (which, if we did, we can
> + * simply disassemble and navigate to the RIP), the purpose of the bigger
> + * prologue is to have more context and to be able to correlate the code from
> + * the different toolchains better.
> + *
> + * In addition, it helps in recreating the register allocation of the failing
> + * kernel and thus make sense of the register dump.
> + *
> + * What is more, the additional complication of a variable length insn arch like
> + * x86 warrants having longer byte sequence before rIP so that the disassembler
> + * can "sync" up properly and find instruction boundaries when decoding the
> + * opcode bytes.
> + *
> + * Thus, the 2/3rds prologue and 64 byte OPCODE_BUFSIZE is just a random
> + * guesstimate in attempt to achieve all of the above.
> + */
>  void show_opcodes(u8 *rip, const char *loglvl)
>  {
>  #define OPCODE_BUFSIZE 64
> -- 
> 2.13.0
> 

-- 
Josh
