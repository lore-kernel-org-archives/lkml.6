Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936086AbeE3Ir5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 04:47:57 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:57189 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935976AbeE3Irv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 04:47:51 -0400
Subject: Re: [PATCH v5 3/3] powerpc/lib: optimise PPC32 memcmp
To: Mathieu Malaterre <malat@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <cover.1527503958.git.christophe.leroy@c-s.fr>
 <88c8cc033b4ea364d62d1d8ba811a8f8d56c297d.1527503958.git.christophe.leroy@c-s.fr>
 <CA+7wUszdfG+u4YSnxjFaujy3s_Vu92POPamK+=zjYe6Pbu+kxw@mail.gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <f2931bb1-2d56-8a5f-84b2-044f043b7633@c-s.fr>
Date: Wed, 30 May 2018 10:47:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CA+7wUszdfG+u4YSnxjFaujy3s_Vu92POPamK+=zjYe6Pbu+kxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 29/05/2018 à 22:03, Mathieu Malaterre a écrit :
> On Mon, May 28, 2018 at 12:49 PM, Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>> At the time being, memcmp() compares two chunks of memory
>> byte per byte.
>>
>> This patch optimises the comparison by comparing word by word.
>>
>> A small benchmark performed on an 8xx comparing two chuncks
>> of 512 bytes performed 100000 times gives:
>>
>> Before : 5852274 TB ticks
>> After:   1488638 TB ticks
>>
>> This is almost 4 times faster
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/lib/string_32.S | 37 +++++++++++++++++++++++++++----------
>>   1 file changed, 27 insertions(+), 10 deletions(-)
> 
> Would it possible for you to move the actual code instead to:
> 
> ./arch/powerpc/lib/memcmp_32.S
> 
> This will seat right next to memcmp_64.S implementation.

Good idea, thanks.
Done in v6

Christophe

> 
>> diff --git a/arch/powerpc/lib/string_32.S b/arch/powerpc/lib/string_32.S
>> index 40a576d56ac7..4fbaa046aa84 100644
>> --- a/arch/powerpc/lib/string_32.S
>> +++ b/arch/powerpc/lib/string_32.S
>> @@ -16,17 +16,34 @@
>>          .text
>>
>>   _GLOBAL(memcmp)
>> -       cmpwi   cr0, r5, 0
>> -       beq-    2f
>> -       mtctr   r5
>> -       addi    r6,r3,-1
>> -       addi    r4,r4,-1
>> -1:     lbzu    r3,1(r6)
>> -       lbzu    r0,1(r4)
>> -       subf.   r3,r0,r3
>> -       bdnzt   2,1b
>> +       srawi.  r7, r5, 2               /* Divide len by 4 */
>> +       mr      r6, r3
>> +       beq-    3f
>> +       mtctr   r7
>> +       li      r7, 0
>> +1:     lwzx    r3, r6, r7
>> +       lwzx    r0, r4, r7
>> +       addi    r7, r7, 4
>> +       cmplw   cr0, r3, r0
>> +       bdnzt   eq, 1b
>> +       bne     5f
>> +3:     andi.   r3, r5, 3
>> +       beqlr
>> +       cmplwi  cr1, r3, 2
>> +       blt-    cr1, 4f
>> +       lhzx    r3, r6, r7
>> +       lhzx    r0, r4, r7
>> +       addi    r7, r7, 2
>> +       subf.   r3, r0, r3
>> +       beqlr   cr1
>> +       bnelr
>> +4:     lbzx    r3, r6, r7
>> +       lbzx    r0, r4, r7
>> +       subf.   r3, r0, r3
>>          blr
>> -2:     li      r3,0
>> +5:     li      r3, 1
>> +       bgtlr
>> +       li      r3, -1
>>          blr
>>   EXPORT_SYMBOL(memcmp)
>>
>> --
>> 2.13.3
>>
