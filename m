Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752665AbeCOSK4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:10:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751466AbeCOSKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:10:55 -0400
Date: Thu, 15 Mar 2018 13:10:54 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/9] x86/dumpstack: Improve opcodes dumping in the Code:
 section
Message-ID: <20180315181054.3fuuetu6fxpzlpcn@treble>
References: <20180315154448.16222-1-bp@alien8.de>
 <20180315154448.16222-5-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180315154448.16222-5-bp@alien8.de>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 04:44:43PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> The code used to iterate byte-by-byte over the bytes around RIP and that
> is expensive: disabling pagefaults around it, copy_from_user, etc...
> 
> Make it read the whole buffer of OPCODE_BUFSIZE size in one go. Use a
> statically allocated 64 bytes buffer so that concurrent show_opcodes()
> do not interleave in the output even though in the majority of the cases
> we sync on die_lock. Except the #PF path which doesn't...
> 
> Also, do the PAGE_OFFSET check outside of the function because latter
> will be reused in other context.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/kernel/dumpstack.c | 34 ++++++++++++++++------------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
> index eb9d6c00a52f..3f781a8dddb8 100644
> --- a/arch/x86/kernel/dumpstack.c
> +++ b/arch/x86/kernel/dumpstack.c
> @@ -22,8 +22,6 @@
>  #include <asm/stacktrace.h>
>  #include <asm/unwind.h>
>  
> -#define OPCODE_BUFSIZE 64
> -
>  int panic_on_unrecovered_nmi;
>  int panic_on_io_nmi;
>  static int die_counter;
> @@ -72,29 +70,25 @@ static void printk_stack_address(unsigned long address, int reliable,
>  
>  static void show_opcodes(u8 *rip)
>  {
> -	unsigned int code_prologue = OPCODE_BUFSIZE * 43 / 64;
> -	unsigned int code_len = OPCODE_BUFSIZE;
> -	unsigned char c;
> +#define OPCODE_BUFSIZE 64
> +	unsigned int code_prologue = OPCODE_BUFSIZE * 2 / 3;
> +	u8 opcodes[OPCODE_BUFSIZE];

I liked OPCODE_BUFSIZE where it was before :-)  Here it disrupts the
readability of the function a bit IMO.

-- 
Josh
