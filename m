Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE4FECE560
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DDB20842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DDB20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeIZPN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:13:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727310AbeIZPN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:13:28 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8Q90V4Q126094
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 05:01:32 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mr60tu9nu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 05:01:31 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 26 Sep 2018 05:01:30 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Sep 2018 05:01:26 -0400
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8Q91P7h46465110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Sep 2018 09:01:25 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FE1228064;
        Wed, 26 Sep 2018 04:59:12 -0400 (EDT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2AFA2805E;
        Wed, 26 Sep 2018 04:59:10 -0400 (EDT)
Received: from [9.124.31.179] (unknown [9.124.31.179])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 26 Sep 2018 04:59:10 -0400 (EDT)
Subject: Re: [PATCH v5 18/22] powerpc/mm: Extend pte_fragment functionality to
 nohash/32
To:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1537892498.git.christophe.leroy@c-s.fr>
 <cda95a5508594e2a2ad5f6f214c435d9a1b44c46.1537892499.git.christophe.leroy@c-s.fr>
 <87in2tgeix.fsf@linux.ibm.com> <156d8a34-c40f-553a-0d4a-98433af1a1a2@c-s.fr>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Wed, 26 Sep 2018 14:31:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <156d8a34-c40f-553a-0d4a-98433af1a1a2@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18092609-0064-0000-0000-00000355545C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009774; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01093837; UDB=6.00565383; IPR=6.00873874;
 MB=3.00023511; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-26 09:01:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092609-0065-0000-0000-00003AC6FC3B
Message-Id: <12bb6cf8-b3e5-c54b-a5a4-d36f30bd28ea@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-26_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809260092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/18 1:40 PM, Christophe LEROY wrote:
> 
> 
> Le 26/09/2018 à 04:48, Aneesh Kumar K.V a écrit :
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>
>>> In order to allow the 8xx to handle pte_fragments, this patch
>>> extends the use of pte_fragments to nohash/32 platforms.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> ---
>>>   arch/powerpc/include/asm/mmu_context.h       |  2 +-
>>>   arch/powerpc/include/asm/nohash/32/mmu-40x.h |  1 +
>>>   arch/powerpc/include/asm/nohash/32/mmu-44x.h |  1 +
>>>   arch/powerpc/include/asm/nohash/32/mmu-8xx.h |  1 +
>>>   arch/powerpc/include/asm/nohash/32/mmu.h     |  4 ++-
>>>   arch/powerpc/include/asm/nohash/32/pgalloc.h | 52 
>>> +++++++++++++---------------
>>>   arch/powerpc/include/asm/nohash/32/pgtable.h | 11 ++++--
>>>   arch/powerpc/include/asm/nohash/mmu-book3e.h |  1 +
>>>   arch/powerpc/mm/Makefile                     |  3 ++
>>>   arch/powerpc/mm/mmu_context_nohash.c         | 14 ++++++++
>>>   10 files changed, 57 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/mmu_context.h 
>>> b/arch/powerpc/include/asm/mmu_context.h
>>> index b2f89b621b15..7f2c37a3f99d 100644
>>> --- a/arch/powerpc/include/asm/mmu_context.h
>>> +++ b/arch/powerpc/include/asm/mmu_context.h
>>> @@ -222,7 +222,7 @@ static inline int arch_dup_mmap(struct mm_struct 
>>> *oldmm,
>>>       return 0;
>>>   }
>>> -#ifndef CONFIG_PPC_BOOK3S_64
>>> +#if defined(CONFIG_PPC_BOOK3E_64) || defined(CONFIG_PPC_BOOK3S_32)
>>>   static inline void arch_exit_mmap(struct mm_struct *mm)
>>>   {
>>>   }
>>
>>
>> Can we do that with #ifndef arch_exit_mmap? This should handle every
>> platform that doesn't use pte_frag right?
> 
> Yes we can, that means moving arch_exit_mmap() prototype in platform 
> specific mmu headers, and adding there a #define arch_exit_mmap 
> arch_exit_mmap
> 
> Is that your idea ?
> 

yes. that way it is easy to find out which platforms really want that to 
be a different.

-aneesh

