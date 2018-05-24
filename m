Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755147AbeEXGUU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 02:20:20 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64331 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754995AbeEXGUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 02:20:17 -0400
Subject: Re: [PATCH v3] powerpc: Implement csum_ipv6_magic in assembly
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
References: <20180522065701.9DE696CCB4@po14934vm.idsi0.si.c-s.fr>
 <20180523183447.GV17342@gate.crashing.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <3848a4ad-2c0e-691f-e98f-347cfe3484e8@c-s.fr>
Date: Thu, 24 May 2018 08:20:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180523183447.GV17342@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 23/05/2018 à 20:34, Segher Boessenkool a écrit :
> On Tue, May 22, 2018 at 08:57:01AM +0200, Christophe Leroy wrote:
>> The generic csum_ipv6_magic() generates a pretty bad result
> 
> <snip>
> 
> Please try with a more recent compiler, what you used is pretty ancient.
> It's not like recent compilers do great on this either, but it's not
> *that* bad anymore ;-)
> 
>> --- a/arch/powerpc/lib/checksum_32.S
>> +++ b/arch/powerpc/lib/checksum_32.S
>> @@ -293,3 +293,36 @@ dst_error:
>>   	EX_TABLE(51b, dst_error);
>>   
>>   EXPORT_SYMBOL(csum_partial_copy_generic)
>> +
>> +/*
>> + * static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
>> + *				      const struct in6_addr *daddr,
>> + *				      __u32 len, __u8 proto, __wsum sum)
>> + */
>> +
>> +_GLOBAL(csum_ipv6_magic)
>> +	lwz	r8, 0(r3)
>> +	lwz	r9, 4(r3)
>> +	lwz	r10, 8(r3)
>> +	lwz	r11, 12(r3)
>> +	addc	r0, r5, r6
>> +	adde	r0, r0, r7
>> +	adde	r0, r0, r8
>> +	adde	r0, r0, r9
>> +	adde	r0, r0, r10
>> +	adde	r0, r0, r11
>> +	lwz	r8, 0(r4)
>> +	lwz	r9, 4(r4)
>> +	lwz	r10, 8(r4)
>> +	lwz	r11, 12(r4)
>> +	adde	r0, r0, r8
>> +	adde	r0, r0, r9
>> +	adde	r0, r0, r10
>> +	adde	r0, r0, r11
>> +	addze	r0, r0
>> +	rotlwi	r3, r0, 16
>> +	add	r3, r0, r3
>> +	not	r3, r3
>> +	rlwinm	r3, r3, 16, 16, 31
>> +	blr
>> +EXPORT_SYMBOL(csum_ipv6_magic)
> 
> Clustering the loads and carry insns together is pretty much the worst you
> can do on most 32-bit CPUs.

Oh, really ? __csum_partial is written that way too.

Right, now I tried interleaving the lwz and adde. I get no improvment at 
all on a 885, but I get a 15% improvment on a 8321.

Christophe

> 
> 
> Segher
> 
