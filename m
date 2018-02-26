Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752197AbeBZHtn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 02:49:43 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:45076 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbeBZHtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 02:49:41 -0500
X-Google-Smtp-Source: AG47ELvbm4/IzLcd718We5PqFgxeLjS8PmzeZZfk1KI8E8YmDFoP7yN2yYC2B2LwNK3gj9xDvS4mGMAHHO1++dsSTYM=
MIME-Version: 1.0
In-Reply-To: <55d52f37-c24d-c2da-43c6-73a55403d3b6@c-s.fr>
References: <20180225172236.29650-1-malat@debian.org> <20180225172236.29650-6-malat@debian.org>
 <55d52f37-c24d-c2da-43c6-73a55403d3b6@c-s.fr>
From: Mathieu Malaterre <malat@debian.org>
Date: Mon, 26 Feb 2018 08:49:20 +0100
X-Google-Sender-Auth: np-Qa_as9v6m6xUmNe1MiuRMqbI
Message-ID: <CA+7wUszvNAD-j5PkA3wYBF7oYfu3+L7vCXtyyhiOBdwyVnH9cQ@mail.gmail.com>
Subject: Re: [PATCH 05/21] powerpc: Avoid comparison of unsigned long >= 0 in pfn_valid
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
        Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1Q7nlSN011420

On Mon, Feb 26, 2018 at 7:32 AM, Christophe LEROY
<christophe.leroy@c-s.fr> wrote:
>
>
> Le 25/02/2018 à 18:22, Mathieu Malaterre a écrit :
>>
>> Rewrite comparison since all values compared are of type `unsigned long`.
>>
>> Fix a warning (treated as error in W=1):
>>
>>    CC      arch/powerpc/kernel/irq.o
>> In file included from ./include/linux/bug.h:5:0,
>>                   from ./include/linux/cpumask.h:13,
>>                   from ./include/linux/smp.h:13,
>>                   from ./include/linux/kernel_stat.h:5,
>>                   from arch/powerpc/kernel/irq.c:35:
>> ./include/linux/dma-mapping.h: In function ‘dma_map_resource’:
>> ./arch/powerpc/include/asm/page.h:129:32: error: comparison of unsigned
>> expression >= 0 is always true [-Werror=type-limits]
>>   #define pfn_valid(pfn)  ((pfn) >= ARCH_PFN_OFFSET && (pfn) < max_mapnr)
>>                                  ^
>> Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>>   arch/powerpc/include/asm/page.h | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/page.h
>> b/arch/powerpc/include/asm/page.h
>> index 8da5d4c1cab2..19dea64e7ed2 100644
>> --- a/arch/powerpc/include/asm/page.h
>> +++ b/arch/powerpc/include/asm/page.h
>> @@ -126,7 +126,8 @@ extern long long virt_phys_offset;
>>     #ifdef CONFIG_FLATMEM
>>   #define ARCH_PFN_OFFSET               ((unsigned long)(MEMORY_START >>
>> PAGE_SHIFT))
>> -#define pfn_valid(pfn)         ((pfn) >= ARCH_PFN_OFFSET && (pfn) <
>> max_mapnr)
>> +#define pfn_valid(pfn) \
>> +               (((pfn) - ARCH_PFN_OFFSET) < (max_mapnr -
>> ARCH_PFN_OFFSET))
>
>
> What will happen when ARCH_PFN_OFFSET is not nul and pfn is lower than
> ARCH_PFN_OFFSET ?

I assumed that normal unsigned integers modulo would make the test
fail. But for some particular value of max_mapnr the two are indeed
not equivalent.

> Christophe
>
>
>>   #endif
>>     #define virt_to_pfn(kaddr)  (__pa(kaddr) >> PAGE_SHIFT)
>>
>
