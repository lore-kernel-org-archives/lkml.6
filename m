Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405CDC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF102151D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF102151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeHUSIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:08:30 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:47788 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726730AbeHUSIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:08:30 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41vtnc5shPz9tvSc;
        Tue, 21 Aug 2018 16:47:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Hd9LSB2UVtwm; Tue, 21 Aug 2018 16:47:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41vtnc4bDwz9tvSH;
        Tue, 21 Aug 2018 16:47:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 96AEC8B819;
        Tue, 21 Aug 2018 16:48:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ePG_pZNNj4Ex; Tue, 21 Aug 2018 16:48:00 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CFBE58B7F4;
        Tue, 21 Aug 2018 16:47:59 +0200 (CEST)
Subject: Re: [PATCH] powerpc/nohash: fix pte_access_permitted()
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <8097a1d32403ea47d076803e9070869badfe24bc.1534856426.git.christophe.leroy@c-s.fr>
 <87eferg5ki.fsf@linux.ibm.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <6f17bbe5-0ce5-a40e-b3c2-d4b5c9fbfd93@c-s.fr>
Date:   Tue, 21 Aug 2018 16:47:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <87eferg5ki.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 21/08/2018 à 16:25, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> Commit 5769beaf180a8 ("powerpc/mm: Add proper pte access check helper
>> for other platforms") replaced generic pte_access_permitted() by an
>> arch specific one.
>>
>> The generic one is defined as
>> (pte_present(pte) && (!(write) || pte_write(pte)))
>>
>> The arch specific one is open coded checking that _PAGE_USER and
>> _PAGE_WRITE (_PAGE_RW) flags are set, but lacking to check that
>> _PAGE_RO and _PAGE_PRIVILEGED are unset, leading to a useless test
>> on targets like the 8xx which defines _PAGE_RW and _PAGE_USER as 0.
>>
>> Commit 5fa5b16be5b31 ("powerpc/mm/hugetlb: Use pte_access_permitted
>> for hugetlb access check") replaced some tests performed with
>> pte helpers by a call to pte_access_permitted(), leading to the same
>> issue.
>>
>> This patch rewrites powerpc/nohash pte_access_permitted()
>> using pte helpers.
>>
> 
> Thanks for fixing this. I should have used the helper instead of
> opencoding it on nohash platforms. This is another reason why I was also
> suggesting we should avoid consolidating pte accessors across platforms
> and user accessors instead of opencoding.

I fully agree. I have opened a topic for that at 
https://github.com/linuxppc/linux/issues/177

Christophe

> 
> https://lore.kernel.org/lkml/87lgcusc6z.fsf@linux.vnet.ibm.com/T/#u
> 
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> 
>> Fixes: 5769beaf180a8 ("powerpc/mm: Add proper pte access check helper for other platforms")
>> Fixes: 5fa5b16be5b31 ("powerpc/mm/hugetlb: Use pte_access_permitted for hugetlb access check")
>> Cc: stable@vger.kernel.org # v4.15+
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/include/asm/nohash/pgtable.h | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
>> index 2160be2e4339..b321c82b3624 100644
>> --- a/arch/powerpc/include/asm/nohash/pgtable.h
>> +++ b/arch/powerpc/include/asm/nohash/pgtable.h
>> @@ -51,17 +51,14 @@ static inline int pte_present(pte_t pte)
>>   #define pte_access_permitted pte_access_permitted
>>   static inline bool pte_access_permitted(pte_t pte, bool write)
>>   {
>> -	unsigned long pteval = pte_val(pte);
>>   	/*
>>   	 * A read-only access is controlled by _PAGE_USER bit.
>>   	 * We have _PAGE_READ set for WRITE and EXECUTE
>>   	 */
>> -	unsigned long need_pte_bits = _PAGE_PRESENT | _PAGE_USER;
>> -
>> -	if (write)
>> -		need_pte_bits |= _PAGE_WRITE;
>> +	if (!pte_present(pte) || !pte_user(pte) || !pte_read(pte))
>> +		return false;
>>   
>> -	if ((pteval & need_pte_bits) != need_pte_bits)
>> +	if (write && !pte_write(pte))
>>   		return false;
>>   
>>   	return true;
>> -- 
>> 2.13.3
