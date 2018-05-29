Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755448AbeE2I4f (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 04:56:35 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:16013 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751091AbeE2I4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 04:56:34 -0400
Subject: Re: [PATCH v2] powerpc/64: Fix build failure with GCC 8.1
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Geoff Levand <geoff@infradead.org>
References: <f5f2de3e1a39613f7303bfdc0d2f2210d4c91910.1527573345.git.christophe.leroy@c-s.fr>
 <CAMuHMdVSKigQPUQH=BVc2fRSRmuEThLaf+V9ghMPDT9_m1C6BA@mail.gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <1fa5b220-4d21-b4cd-33bf-8a3ce3178063@c-s.fr>
Date: Tue, 29 May 2018 10:56:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVSKigQPUQH=BVc2fRSRmuEThLaf+V9ghMPDT9_m1C6BA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 29/05/2018 à 09:47, Geert Uytterhoeven a écrit :
> Hi Christophe,
> 
> CC Geoff
> 
> On Tue, May 29, 2018 at 8:03 AM, Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>>    CC      arch/powerpc/kernel/nvram_64.o
>> arch/powerpc/kernel/nvram_64.c: In function 'nvram_create_partition':
>> arch/powerpc/kernel/nvram_64.c:1042:2: error: 'strncpy' specified bound 12 equals destination size [-Werror=stringop-truncation]
>>    strncpy(new_part->header.name, name, 12);
>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>>    CC      arch/powerpc/kernel/trace/ftrace.o
>> In function 'make_field',
>>      inlined from 'ps3_repository_read_boot_dat_address' at arch/powerpc/platforms/ps3/repository.c:900:9:
>> arch/powerpc/platforms/ps3/repository.c:106:2: error: 'strncpy' output truncated before terminating nul copying 8 bytes from a string of the same length [-Werror=stringop-truncation]
>>    strncpy((char *)&n, text, 8);
>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> 
> Thanks for your patch!
> 
>> --- a/arch/powerpc/kernel/nvram_64.c
>> +++ b/arch/powerpc/kernel/nvram_64.c
>> @@ -1039,7 +1039,7 @@ loff_t __init nvram_create_partition(const char *name, int sig,
>>          new_part->index = free_part->index;
>>          new_part->header.signature = sig;
>>          new_part->header.length = size;
>> -       strncpy(new_part->header.name, name, 12);
>> +       memcpy(new_part->header.name, name, strnlen(name, sizeof(new_part->header.name)));
> 
> The comment for nvram_header.lgnth says:
> 
>          /* Terminating null required only for names < 12 chars. */
> 
> This will not terminate the string with a zero (the struct is
> allocated with kmalloc).
> So the original code is correct, the new one isn't.

Right, then I have to first zeroize the destination.

> 
>>          new_part->header.checksum = nvram_checksum(&new_part->header);
>>
>>          rc = nvram_write_header(new_part);
>> diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
>> index 50dbaf24b1ee..e49c887787c4 100644
>> --- a/arch/powerpc/platforms/ps3/repository.c
>> +++ b/arch/powerpc/platforms/ps3/repository.c
>> @@ -101,9 +101,9 @@ static u64 make_first_field(const char *text, u64 index)
>>
>>   static u64 make_field(const char *text, u64 index)
>>   {
>> -       u64 n;
>> +       u64 n = 0;
>>
>> -       strncpy((char *)&n, text, 8);
>> +       memcpy((char *)&n, text, strnlen(text, sizeof(n)));
> 
> This changes behavior: strncpy() fills the remainder of the buffer with
> zeroes.  I don't remember the details of the PS3 repository structure,
> but given this writes to a fixed size u64 buffer, I'd expect the PS3
> hypervisor code to (1) rely on the zero padding, and (2) not need a zero
> terminator if there are 8 characters in the buffer, so probably the
> original code is correct, and the "fixed" code isn't.

Here I have set n to 0 prior to the copy, so the buffer IS zero padded.

Christophe

> 
> Has this been tested on a PS3?
> 
>>          return n + index;
>>   }
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
