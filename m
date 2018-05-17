Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752075AbeEQNVK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 09:21:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:54157 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751396AbeEQNVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 09:21:09 -0400
Subject: Re: [PATCH v2 5/5] powerpc/lib: inline memcmp() for small constant
 sizes
To: Mathieu Malaterre <malat@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <cover.1526553552.git.christophe.leroy@c-s.fr>
 <8a6f90d882c8b60e5fa0826cd23dd70a92075659.1526553552.git.christophe.leroy@c-s.fr>
 <CA+7wUsyEBW-sKiwP_KJpwuWC0JGi_Cg-xnxcnw0d_Wc7-GWeeA@mail.gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <c184c807-dac0-0617-f449-492f5b6eeec1@c-s.fr>
Date: Thu, 17 May 2018 15:21:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CA+7wUsyEBW-sKiwP_KJpwuWC0JGi_Cg-xnxcnw0d_Wc7-GWeeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/05/2018 à 15:03, Mathieu Malaterre a écrit :
> On Thu, May 17, 2018 at 12:49 PM, Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>> In my 8xx configuration, I get 208 calls to memcmp()
>> Within those 208 calls, about half of them have constant sizes,
>> 46 have a size of 8, 17 have a size of 16, only a few have a
>> size over 16. Other fixed sizes are mostly 4, 6 and 10.
>>
>> This patch inlines calls to memcmp() when size
>> is constant and lower than or equal to 16
>>
>> In my 8xx configuration, this reduces the number of calls
>> to memcmp() from 208 to 123
>>
>> The following table shows the number of TB timeticks to perform
>> a constant size memcmp() before and after the patch depending on
>> the size
>>
>>          Before  After   Improvement
>> 01:      7577    5682   25%
>> 02:     41668    5682   86%
>> 03:     51137   13258   74%
>> 04:     45455    5682   87%
>> 05:     58713   13258   77%
>> 06:     58712   13258   77%
>> 07:     68183   20834   70%
>> 08:     56819   15153   73%
>> 09:     70077   28411   60%
>> 10:     70077   28411   60%
>> 11:     79546   35986   55%
>> 12:     68182   28411   58%
>> 13:     81440   35986   55%
>> 14:     81440   39774   51%
>> 15:     94697   43562   54%
>> 16:     79546   37881   52%
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/include/asm/string.h | 46 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/string.h b/arch/powerpc/include/asm/string.h
>> index 35f1aaad9b50..80cf0f9605dd 100644
>> --- a/arch/powerpc/include/asm/string.h
>> +++ b/arch/powerpc/include/asm/string.h
>> @@ -4,6 +4,8 @@
>>
>>   #ifdef __KERNEL__
>>
>> +#include <linux/kernel.h>
>> +
>>   #define __HAVE_ARCH_STRNCPY
>>   #define __HAVE_ARCH_STRNCMP
>>   #define __HAVE_ARCH_MEMSET
>> @@ -51,10 +53,54 @@ static inline int strncmp(const char *p, const char *q, __kernel_size_t size)
>>          return __strncmp(p, q, size);
>>   }
>>
>> +static inline int __memcmp1(const void *p, const void *q, int off)
> 
> Does that change anything if you change void* to char* pointer ? I
> find void* arithmetic hard to read.

Yes that's not the same

void* means you can use any pointer, for instance pointers to two 
structs you want to compare.

char* will force users to cast their pointers to char*

> 
>> +{
>> +       return *(u8*)(p + off) - *(u8*)(q + off);
>> +}
>> +
>> +static inline int __memcmp2(const void *p, const void *q, int off)
>> +{
>> +       return be16_to_cpu(*(u16*)(p + off)) - be16_to_cpu(*(u16*)(q + off));
>> +}
>> +
>> +static inline int __memcmp4(const void *p, const void *q, int off)
>> +{
>> +       return be32_to_cpu(*(u32*)(p + off)) - be32_to_cpu(*(u32*)(q + off));
>> +}
>> +
>> +static inline int __memcmp8(const void *p, const void *q, int off)
>> +{
>> +       s64 tmp = be64_to_cpu(*(u64*)(p + off)) - be64_to_cpu(*(u64*)(q + off));
> 
> I always assumed 64bits unaligned access would trigger an exception.
> Is this correct ?

As far as I know, an unaligned access will only occur when the operand 
of lmw, stmw, lwarx, or stwcx. is not aligned.

Maybe that's different for PPC64 ?

Christophe

> 
>> +       return tmp >> 32 ? : (int)tmp;
>> +}
>> +
>> +static inline int __memcmp_cst(const void *p,const void *q,__kernel_size_t size)
>> +{
>> +       if (size == 1)
>> +               return __memcmp1(p, q, 0);
>> +       if (size == 2)
>> +               return __memcmp2(p, q, 0);
>> +       if (size == 3)
>> +               return __memcmp2(p, q, 0) ? : __memcmp1(p, q, 2);
>> +       if (size == 4)
>> +               return __memcmp4(p, q, 0);
>> +       if (size == 5)
>> +               return __memcmp4(p, q, 0) ? : __memcmp1(p, q, 4);
>> +       if (size == 6)
>> +               return __memcmp4(p, q, 0) ? : __memcmp2(p, q, 4);
>> +       if (size == 7)
>> +               return __memcmp4(p, q, 0) ? : __memcmp2(p, q, 4) ? : __memcmp1(p, q, 6);
>> +       return __memcmp8(p, q, 0);
>> +}
>> +
>>   static inline int memcmp(const void *p,const void *q,__kernel_size_t size)
>>   {
>>          if (unlikely(!size))
>>                  return 0;
>> +       if (__builtin_constant_p(size) && size <= 8)
>> +               return __memcmp_cst(p, q, size);
>> +       if (__builtin_constant_p(size) && size <= 16)
>> +               return __memcmp8(p, q, 0) ? : __memcmp_cst(p + 8, q + 8, size - 8);
>>          return __memcmp(p, q, size);
>>   }
>>
>> --
>> 2.13.3
>>
