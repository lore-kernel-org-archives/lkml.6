Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbeCTH5U (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 03:57:20 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:40036 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751527AbeCTH5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 03:57:18 -0400
Subject: Re: [PATCH 1/2] powerpc/mm: Add missing tracepoint for tlbie
To: Balbir Singh <bsingharora@gmail.com>,
        Kumar Gala <galak@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <4ffd3d6143f991615ffe07f43952cbc62163d319.1521452718.git.christophe.leroy@c-s.fr>
 <20180320093940.56144adf@balbir.ozlabs.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <b619699e-319b-4c45-7dce-3c74d88d0379@c-s.fr>
Date: Tue, 20 Mar 2018 08:57:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320093940.56144adf@balbir.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 19/03/2018 à 23:39, Balbir Singh a écrit :
> On Mon, 19 Mar 2018 11:32:38 +0100 (CET)
> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> 
>> commit 0428491cba927 ("powerpc/mm: Trace tlbie(l) instructions")
>> added tracepoints for tlbie calls, but _tlbil_va() was forgotten
>>
>> Fixes: 0428491cba927 ("powerpc/mm: Trace tlbie(l) instructions")
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/mm/mmu_decl.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
>> index 57fbc554c785..b9991e0c61a2 100644
>> --- a/arch/powerpc/mm/mmu_decl.h
>> +++ b/arch/powerpc/mm/mmu_decl.h
>> @@ -21,6 +21,7 @@
>>   #include <linux/mm.h>
>>   #include <asm/tlbflush.h>
>>   #include <asm/mmu.h>
>> +#include <asm/trace.h>
>>   
>>   #ifdef CONFIG_PPC_MMU_NOHASH
>>   
>> @@ -56,6 +57,7 @@ static inline void _tlbil_va(unsigned long address, unsigned int pid,
>>   			     unsigned int tsize, unsigned int ind)
>>   {
>>   	asm volatile ("tlbie %0; sync" : : "r" (address) : "memory");
>> +	trace_tlbie(pid, 0, address, 0, 0, 0, 0);
> 
> 
> I did not really cover a whole lot of NOHASH, any idea why its
> called tlbil_va and not _tlbie_va?

Seems it comes from 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=0ba3418b8b1c85ee1771c63f1dd12041614e56ff

Kumar ?

> 
> The first field is really the lpid and should be 0 for non-virtualized
> systems. Can I recommend that we rs field for pid and the rb field for
> address? so effectively something like

Yes having the address in rb is expected since it is the name of the 
only field tlbie has in the 32bits instruction set.

Yes I can use rb for the pid.

Christophe
