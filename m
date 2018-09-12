Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D453AC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8180920833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8180920833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeILVKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:10:37 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:3024 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbeILVKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:10:36 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 429RSz5kM7z9ttKn;
        Wed, 12 Sep 2018 18:05:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id r69zPBY0gVMr; Wed, 12 Sep 2018 18:05:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 429RSz54nkz9ttBm;
        Wed, 12 Sep 2018 18:05:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 798A88B873;
        Wed, 12 Sep 2018 18:05:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id bEDGqj7LG45u; Wed, 12 Sep 2018 18:05:24 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 121C08B871;
        Wed, 12 Sep 2018 18:05:24 +0200 (CEST)
Subject: Re: [RFC PATCH v1 00/17] ban the use of _PAGE_XXX flags outside
 platform specific code
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cover.1535913369.git.christophe.leroy@c-s.fr>
 <8736uneylc.fsf@linux.ibm.com> <1f4d6cc9-5d18-b171-02b0-d715629d594f@c-s.fr>
 <8736uhsx3l.fsf@linux.ibm.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <7bf77801-9c6c-a39e-6d82-3a0b0d870b65@c-s.fr>
Date:   Wed, 12 Sep 2018 18:05:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8736uhsx3l.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 10/09/2018 à 08:08, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> On 09/06/2018 09:58 AM, Aneesh Kumar K.V wrote:
>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>>
>>>> Today flags like for instance _PAGE_RW or _PAGE_USER are used through
>>>> common parts of code.
>>>> Using those directly in common parts of code have proven to lead to
>>>> mistakes or misbehaviour, because their use is not always as trivial
>>>> as one could think.
>>>>
>>>> For instance, (flags & _PAGE_USER) == 0 isn't enough to tell
>>>> that a page is a kernel page, because some targets are using
>>>> _PAGE_PRIVILEDGED and not _PAGE_USER, so the test has to be
>>>> (flags & (_PAGE_USER | _PAGE_PRIVILEDGED)) == _PAGE_PRIVILEDGED
>>>> This has to (bad) consequences:
>>>>
>>>>    - All targets must define every bit, even the unsupported ones,
>>>>      leading to a lot of useless #define _PAGE_XXX 0
>>>>    - If someone forgets to take into account all possible _PAGE_XXX bits
>>>>      for the case, we can get unexpected behaviour on some targets.
>>>>
>>>> This becomes even more complex when we come to using _PAGE_RW.
>>>> Testing (flags & _PAGE_RW) is not enough to test whether a page
>>>> if writable or not, because:
>>>>
>>>>    - Some targets have _PAGE_RO instead, which has to be unset to tell
>>>>      a page is writable
>>>>    - Some targets have _PAGE_R and _PAGE_W, in which case
>>>>      _PAGE_RW = _PAGE_R | _PAGE_W
>>>>    - Even knowing whether a page is readable is not always trivial because:
>>>>      - Some targets requires to check that _PAGE_R is set to ensure page
>>>>      is readable
>>>>      - Some targets requires to check that _PAGE_NA is not set
>>>>      - Some targets requires to check that _PAGE_RO or _PAGE_RW is set
>>>>
>>>> Etc ....
>>>>
>>>> In order to work around all those issues and minimise the risks of errors,
>>>> this serie aims at removing all use of _PAGE_XXX flags from powerpc code
>>>> and always use pte_xxx() and pte_mkxxx() accessors instead. Those accessors
>>>> are then defined in target specific parts of the kernel code.
>>>
>>> The series is really good. It also helps in code readability. Few things
>>> i am not sure there is a way to reduce the overhead
>>>
>>> -		access = _PAGE_EXEC;
>>> +		access = pte_val(pte_mkexec(__pte(0)));
>>>
>>> Considering we have multiple big endian to little endian coversion there
>>> for book3s 64.
>>
>> Thanks for the review.
>>
>> For the above, I propose the following:
>>
>> diff --git a/arch/powerpc/mm/hash_utils_64.c
>> b/arch/powerpc/mm/hash_utils_64.c
>> index f23a89d8e4ce..904ac9c84ea5 100644
>> --- a/arch/powerpc/mm/hash_utils_64.c
>> +++ b/arch/powerpc/mm/hash_utils_64.c
>> @@ -1482,7 +1482,7 @@ static bool should_hash_preload(struct mm_struct
>> *mm, unsigned long ea)
>>    #endif
>>
>>    void hash_preload(struct mm_struct *mm, unsigned long ea,
>> -		  unsigned long access, unsigned long trap)
>> +		  bool is_exec, unsigned long trap)
>>    {
>>    	int hugepage_shift;
>>    	unsigned long vsid;
>> @@ -1490,6 +1490,7 @@ void hash_preload(struct mm_struct *mm, unsigned
>> long ea,
>>    	pte_t *ptep;
>>    	unsigned long flags;
>>    	int rc, ssize, update_flags = 0;
>> +	unsigned long access = is_exec ? _PAGE_EXEC : 0;
> 
> 
> I guess it will be better if we do
> 
> unsigned long access = _PAGE_PRESENT | _PAGE_READ
> 
> if (is_exec)
>     access |= _PAGE_EXEC.
> 
> That will also bring it closer to __hash_page. I agree that we should
> always find _PAGE_PRESENT and _PAGE_READ set, because we just handled
> the page fault.
> 

Ok, I did it in v2, can you have a look (patch 11/24) ?

Christophe
