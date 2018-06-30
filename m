Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657EEC3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 06:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7C7251E4
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 06:23:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7C7251E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbeF3GXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 02:23:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35204 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751861AbeF3GXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 02:23:49 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5U6J7Lk023079
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 02:23:49 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jx2rp2v75-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 02:23:48 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Sat, 30 Jun 2018 02:23:47 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 30 Jun 2018 02:23:42 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5U6Nf9d16843246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 30 Jun 2018 06:23:41 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5001628059;
        Sat, 30 Jun 2018 02:23:18 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8879A28058;
        Sat, 30 Jun 2018 02:23:11 -0400 (EDT)
Received: from [9.199.32.197] (unknown [9.199.32.197])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 30 Jun 2018 02:23:11 -0400 (EDT)
Subject: Re: [Update] Regression in 4.18 - 32-bit PowerPC crashes on boot -
 bisected to commit 1d40a5ea01d5
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <99169786-61dd-b19c-ac81-84bcd0a67de4@lwfinger.net>
 <CA+55aFzZ7PND2Xvz9wB1jaCmp0rBMTSmJtKiFwSeOWy9iLSd8Q@mail.gmail.com>
 <20180629214647.mkgpni6hxj7aore4@kshutemo-mobl1>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Sat, 30 Jun 2018 11:53:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180629214647.mkgpni6hxj7aore4@kshutemo-mobl1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18063006-2213-0000-0000-000002C23C2C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009281; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01054373; UDB=6.00540691; IPR=6.00832296;
 MB=3.00021938; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-30 06:23:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18063006-2214-0000-0000-00005AA8873B
Message-Id: <c6461a35-c66d-6c62-a255-175917d8881b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-30_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806300073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30/2018 03:16 AM, Kirill A. Shutemov wrote:
> On Fri, Jun 29, 2018 at 02:01:46PM -0700, Linus Torvalds wrote:
>> On Fri, Jun 29, 2018 at 1:42 PM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>>
>>> I have more information regarding this BUG. Line 700 of page-flags.h is the
>>> macro PAGE_TYPE_OPS(Table, table). For further debugging, I manually expanded
>>> the macro, and found that the bug line is VM_BUG_ON_PAGE(!PageTable(page), page)
>>> in routine __ClearPageTable(), which is called from pgtable_page_dtor() in
>>> include/linux/mm.h. I also added a printk call to PageTable() that logs
>>> page->page_type. The routine was called twice. The first had page_type of
>>> 0xfffffbff, which would have been expected for a . The second call had
>>> 0xffffffff, which led to the BUG.
>>
>> So it looks to me like the tear-down of the page tables first found a
>> page that is indeed a page table, and cleared the page table bit
>> (well, it set it - the bits are reversed).
>>
>> Then it took an exception (that "interrupt: 700") and that causes
>> do_exit() again, and it tries to free the same page table - and now
>> it's no longer marked as a page table, because it already went through
>> the __ClearPageTable() dance once.
>>
>> So on the second path through, it catches that "the bit already said
>> it wasn't a page table" and does the BUG.
>>
>> But the real question is what the problem was the *first* time around.
> 
> +Aneesh.
> 
> Looks like pgtable_page_dtor() gets called in __pte_free_tlb() path twice.
> Once in __pte_free_tlb() itself and the second time in pgtable_free().
> 
> Would this help?
> 
> diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
> index 6a6673907e45..e7a2f0e6b695 100644
> --- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
> +++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
> @@ -137,7 +137,6 @@ static inline void pgtable_free_tlb(struct mmu_gather *tlb,
>   static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
>   				  unsigned long address)
>   {
> -	pgtable_page_dtor(table);
>   	pgtable_free_tlb(tlb, page_address(table), 0);
>   }
>   #endif /* _ASM_POWERPC_BOOK3S_32_PGALLOC_H */
> diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
> index 1707781d2f20..30a13b80fd58 100644
> --- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
> +++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
> @@ -139,7 +139,6 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
>   				  unsigned long address)
>   {
>   	tlb_flush_pgtable(tlb, address);
> -	pgtable_page_dtor(table);
>   	pgtable_free_tlb(tlb, page_address(table), 0);
>   }
>   #endif /* _ASM_POWERPC_PGALLOC_32_H */
> 


https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-June/175015.html

Also part of pull request from Michael Ellerman

-aneesh

