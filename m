Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E53ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18B221502
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C18B221502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbeIQPOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:14:39 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:43537 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727668AbeIQPOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 11:14:38 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42DLs25Jj7z9ttCP;
        Mon, 17 Sep 2018 11:47:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Kuq7uI3F3qRb; Mon, 17 Sep 2018 11:47:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42DLs24kchz9ttCM;
        Mon, 17 Sep 2018 11:47:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EAF728B786;
        Mon, 17 Sep 2018 11:47:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id sy3v4ONfyfjG; Mon, 17 Sep 2018 11:47:58 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7835F8B78F;
        Mon, 17 Sep 2018 11:47:55 +0200 (CEST)
Subject: Re: How to handle PTE tables with non contiguous entries ?
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        aneesh.kumar@linux.vnet.ibm.com,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <ddc3bb56-4da0-c093-256f-185d4a612b5c@c-s.fr>
 <87tvmoh4w9.fsf@linux.ibm.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <d1be61a4-8dc7-cfe0-e4e7-82ce5f57ced3@c-s.fr>
Date:   Mon, 17 Sep 2018 11:47:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87tvmoh4w9.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 17/09/2018 à 11:03, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> Hi,
>>
>> I'm having a hard time figuring out the best way to handle the following
>> situation:
>>
>> On the powerpc8xx, handling 16k size pages requires to have page tables
>> with 4 identical entries.
> 
> I assume that hugetlb page size? If so isn't that similar to FSL hugetlb
> page table layout?

No, it is not for 16k hugepage size with a standard page size of 4k.

Here I'm trying to handle the case of CONFIG_PPC_16K_PAGES.
As of today, it is implemented by using the standard Linux page layout, 
ie one PTE entry for each 16k page. This forbids the use the 8xx HW 
assistance.

> 
>>
>> Initially I was thinking about handling this by simply modifying
>> pte_index() which changing pte_t type in order to have one entry every
>> 16 bytes, then replicate the PTE value at *ptep, *ptep+1,*ptep+2 and
>> *ptep+3 both in set_pte_at() and pte_update().
>>
>> However, this doesn't work because many many places in the mm core part
>> of the kernel use loops on ptep with single ptep++ increment.
>>
>> Therefore did it with the following hack:
>>
>>    /* PTE level */
>> +#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
>> +typedef struct { pte_basic_t pte, pte1, pte2, pte3; } pte_t;
>> +#else
>>    typedef struct { pte_basic_t pte; } pte_t;
>> +#endif
>>
>> @@ -181,7 +192,13 @@ static inline unsigned long pte_update(pte_t *p,
>>           : "cc" );
>>    #else /* PTE_ATOMIC_UPDATES */
>>           unsigned long old = pte_val(*p);
>> -       *p = __pte((old & ~clr) | set);
>> +       unsigned long new = (old & ~clr) | set;
>> +
>> +#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
>> +       p->pte = p->pte1 = p->pte2 = p->pte3 = new;
>> +#else
>> +       *p = __pte(new);
>> +#endif
>>    #endif /* !PTE_ATOMIC_UPDATES */
>>
>>    #ifdef CONFIG_44x
>>
>>
>> @@ -161,7 +161,11 @@ static inline void __set_pte_at(struct mm_struct
>> *mm, unsigned long addr,
>>           /* Anything else just stores the PTE normally. That covers all
>> 64-bit
>>            * cases, and 32-bit non-hash with 32-bit PTEs.
>>            */
>> +#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
>> +       ptep->pte = ptep->pte1 = ptep->pte2 = ptep->pte3 = pte_val(pte);
>> +#else
>>           *ptep = pte;
>> +#endif
>>
>>
>>
>> But I'm not too happy with it as it means pte_t is not a single type
>> anymore so passing it from one function to the other is quite heavy.
>>
>>
>> Would someone have an idea of an elegent way to handle that ?
>>
>> Thanks
>> Christophe
> 
> Why would pte_update bother about updating all the 4 entries?. Can you
> help me understand the issue?

Because the 8xx HW assistance expects 4 identical entries for each 16k 
page, so everytime a PTE is updated the 4 entries have to be updated.

Christophe
