Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932153AbeBVLY3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:24:29 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41549 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932117AbeBVLY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:24:26 -0500
X-Google-Smtp-Source: AH8x2267W25crI7Z0I/BJ3Lw6a3u/SvDt8Gu20erQDERY5P2OGtPalC2kPu43j5DikuJXbzCc6JGri/RgiCM+1ZIjFU=
MIME-Version: 1.0
In-Reply-To: <20180222110252.ogmn3yf6ln5edc6t@node.shutemov.name>
References: <20180222104101.2717185-1-arnd@arndb.de> <20180222110252.ogmn3yf6ln5edc6t@node.shutemov.name>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 22 Feb 2018 12:24:25 +0100
X-Google-Sender-Auth: cBeZwV_I8kbOPIYVlOsUUeBnuiw
Message-ID: <CAK8P3a2FaGfCYmMqD-1WPks+F-jpM-AzSFWLtYfp=BxgoFLTfA@mail.gmail.com>
Subject: Re: [PATCH] x86/boot/compressed/64: fix warning for 32-bit trampoline copy
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Martin Sebor <msebor@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 12:02 PM, Kirill A. Shutemov
<kirill@shutemov.name> wrote:
> On Thu, Feb 22, 2018 at 11:40:41AM +0100, Arnd Bergmann wrote:
>> gcc-8 warns that we copy TRAMPOLINE_32BIT_CODE_SIZE bytes from the pointer
>> to the function into actual trampoline, when that pointer is only 8 bytes:
>>
>> In file included from arch/x86/boot/compressed/pgtable_64.c:3:
>> arch/x86/boot/compressed/pgtable_64.c: In function 'paging_prepare':
>> arch/x86/boot/compressed/../string.h:18:23: error: '__builtin_memcpy' reading 96 bytes from a region of size 8 [-Werror=stringop-overflow=]
>>  #define memcpy(d,s,l) __builtin_memcpy(d,s,l)
>>                        ^~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/boot/compressed/pgtable_64.c:62:2: note: in expansion of macro 'memcpy'
>>   memcpy(trampoline + TRAMPOLINE_32BIT_CODE_OFFSET / sizeof(unsigned long),
>>   ^~~~~~
>>
>> I assume what was intended here is to copy the trampoline itself rather than
>> the pointer to the trampoline.
>>
>> Cc: Martin Sebor <msebor@gmail.com>
>> Fixes: b91993a87aff ("x86/boot/compressed/64: Prepare trampoline memory")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> This is a fairly new warning in gcc, it's possible that the code is
>> correct and the warning message got it wrong, please double-check this.
>>
>> Was the 32-bit trampoline code in the 64-bit decompressor tested successfully?
>
> Yes, it was. Actually it tested on every boot of any 64-bit machine.
>
> The fix is wrong and it breaks boot. The bug is in trampoline_32bit_src
> declaration. Could you check if this helps with the warning:

Got it, yes that definitely explains the problem. Your patch fixes it
and I'll follow up with a new submission using this change, unless you
want to send it as a patch yourself.

       Arnd

> diff --git a/arch/x86/boot/compressed/pgtable.h b/arch/x86/boot/compressed/pgtable.h
> index 6e0db2260147..5e0b1c4abef4 100644
> --- a/arch/x86/boot/compressed/pgtable.h
> +++ b/arch/x86/boot/compressed/pgtable.h
> @@ -12,7 +12,7 @@
>
>  #ifndef __ASSEMBLER__
>
> -extern void (*trampoline_32bit_src)(void *return_ptr);
> +extern void trampoline_32bit_src(void *return_ptr);
>
>  #endif /* __ASSEMBLER__ */
>  #endif /* BOOT_COMPRESSED_PAGETABLE_H */
> --
>  Kirill A. Shutemov
