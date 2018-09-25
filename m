Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17805C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF5E2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:49:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFF5E2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeIYW5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:57:31 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:61683 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbeIYW5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:57:30 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42KRqT1SRSz9ttCY;
        Tue, 25 Sep 2018 18:49:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id jHxxCneQgvEF; Tue, 25 Sep 2018 18:49:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42KRqT0qnnz9ttCN;
        Tue, 25 Sep 2018 18:49:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 195DF8B7E5;
        Tue, 25 Sep 2018 18:49:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 1wtcYGRQcqLe; Tue, 25 Sep 2018 18:49:09 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 78E868B7C8;
        Tue, 25 Sep 2018 18:49:08 +0200 (CEST)
Subject: Re: [PATCH v4 15/20] powerpc/mm: Avoid useless lock with single page
 fragments
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1537288312.git.christophe.leroy@c-s.fr>
 <7efec0c76fa692513c806871151a7ae20e99fe05.1537288312.git.christophe.leroy@c-s.fr>
 <78cb82d6-1a13-150d-9daa-021bd2f98e7a@linux.ibm.com>
From:   Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <0c09b968-b3ef-ca89-9bd4-bf9df353ff50@c-s.fr>
Date:   Tue, 25 Sep 2018 18:49:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <78cb82d6-1a13-150d-9daa-021bd2f98e7a@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 19/09/2018 à 04:56, Aneesh Kumar K.V a écrit :
> On 9/18/18 10:27 PM, Christophe Leroy wrote:
>> There is no point in taking the page table lock as
>> pte_frag is always NULL when we have only one fragment.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/mm/pgtable-frag.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/powerpc/mm/pgtable-frag.c 
>> b/arch/powerpc/mm/pgtable-frag.c
>> index bc924822dcd6..ab4910e92aaf 100644
>> --- a/arch/powerpc/mm/pgtable-frag.c
>> +++ b/arch/powerpc/mm/pgtable-frag.c
>> @@ -85,6 +85,9 @@ static pte_t *get_pte_from_cache(struct mm_struct *mm)
>>   {
>>       void *pte_frag, *ret;
>>
>> +    if (PTE_FRAG_NR == 1)
>> +        return NULL;
>> +
>>       spin_lock(&mm->page_table_lock);
>>       ret = mm->context.pte_frag;
>>       if (ret) {
>>
> 
> May be update get_pmd_from_cache too?
> 

Ok, done in v5

Christophe
