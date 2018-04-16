Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbeDPPhC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:37:02 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45397 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbeDPPhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:37:00 -0400
X-Google-Smtp-Source: AIpwx487l6BbQQqdfEYF14fj+RX9hn6e+HRFWqjovOoZFxYHzfz8kmNZrr82/77NrqOlWD7Wg0TWxw==
Subject: Re: instant reboot caused by 194a9749c73d650c0
To: "Kirill A. Shutemov" <kirill@shutemov.name>,
        Ingo Molnar <mingo@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Greg Thelen <gthelen@google.com>
References: <5ecfeb13-84e4-f1ef-bd30-391674b2050a@gmail.com>
 <20180416060709.mnzk7fb5y45dnpmg@gmail.com>
 <20180416091514.wqig3l4lrc72tyrs@node.shutemov.name>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <4df21e12-709b-891f-13a8-cd19e92d44f5@gmail.com>
Date: Mon, 16 Apr 2018 08:36:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180416091514.wqig3l4lrc72tyrs@node.shutemov.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/16/2018 02:15 AM, Kirill A. Shutemov wrote:
> On Mon, Apr 16, 2018 at 08:07:09AM +0200, Ingo Molnar wrote:
>>
>> * Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>
>>> Hi Kirill
>>>
>>> For some reason, my hosts instantly crash at boot time, with absolutely no log on console.
>>>
>>> Bisection pointed to :
>>>
>>> $ git bisect bad
>>> 194a9749c73d650c0b1dfdee04fb0bdf0a888ba8 is the first bad commit
>>> commit 194a9749c73d650c0b1dfdee04fb0bdf0a888ba8
>>> Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Date:   Mon Mar 12 13:02:46 2018 +0300
>>>
>>>     x86/boot/compressed/64: Handle 5-level paging boot if kernel is above 4G
>>
>> Could you please send your .config? These early boot problems are sometimes build 
>> and Kconfig environment sensitive.
>>
>> A high level description of your hardware and the distro you are using would also 
>> be useful.
> 
> And how do you start the kernel? EFI? Legacy boot? kexec?
> 
>>
>> Kirill, I'm curious about this change:
>>
>> -       /* Calculate address we are running at */
>> -       call    1f
>> -1:     popl    %edi
>> -       subl    $1b, %edi
>> +       /* Calculate address of paging_enabled() once we are executing in the 
>> trampoline */
>> +       leal    paging_enabled - trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_OFFSET(%ecx), %eax
>>
>> Here we change the calculation from a "discover where we are executing" method to 
>> a calculation method (which is fundamentally more fragile) - why?
> 
> I guess, I tried to save one register -- %rdi is used for return from
> trampoline.
> 
> But you're right there's no reason to do this and it may be more fragile.
> 
> Eric, could you check if the patch makes any difference?
> 
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index fca012baba19..395c122ef70b 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -562,7 +562,10 @@ ENTRY(trampoline_32bit_src)
>  	movl	%eax, %cr4
>  
>  	/* Calculate address of paging_enabled() once we are executing in the trampoline */
> -	leal	paging_enabled - trampoline_32bit_src + TRAMPOLINE_32BIT_CODE_OFFSET(%ecx), %eax
> +	call	1f
> +1:	popl	%eax
> +	subl	$1b, %eax
> +	leal	paging_enabled(%eax), %eax
>  
>  	/* Prepare the stack for far return to Long Mode */
>  	pushl	$__KERNEL_CS
> diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
> index 91f75638f6e6..6ff7e81b5628 100644
> --- a/arch/x86/boot/compressed/pgtable.h
> +++ b/arch/x86/boot/compressed/pgtable.h
> @@ -6,7 +6,7 @@
>  #define TRAMPOLINE_32BIT_PGTABLE_OFFSET	0
>  
>  #define TRAMPOLINE_32BIT_CODE_OFFSET	PAGE_SIZE
> -#define TRAMPOLINE_32BIT_CODE_SIZE	0x60
> +#define TRAMPOLINE_32BIT_CODE_SIZE	0x70
>  
>  #define TRAMPOLINE_32BIT_STACK_END	TRAMPOLINE_32BIT_SIZE
>  
> 

Hi Kirill

This patch did not help.

In the mean time, Greg told me that using gcc-4.9 instead of our old gcc-4.7 based toolchain was working better.

Thanks !
