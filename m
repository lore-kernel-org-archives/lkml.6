Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBDEC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECD2208D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECD2208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbeHVRp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:45:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728509AbeHVRp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:45:59 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7MEJ9Ok067699
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 10:20:53 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m168bgk1w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 10:20:53 -0400
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Wed, 22 Aug 2018 08:20:52 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 Aug 2018 08:20:49 -0600
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7MEKm3v51380240
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Aug 2018 07:20:48 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 900F56E052;
        Wed, 22 Aug 2018 08:20:48 -0600 (MDT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B52BE6E050;
        Wed, 22 Aug 2018 08:20:45 -0600 (MDT)
Received: from [9.102.1.235] (unknown [9.102.1.235])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 22 Aug 2018 08:20:45 -0600 (MDT)
Subject: Re: [PATCH v2 3/4] powerpc/mm: fix a warning when a cache is common
 to PGD and hugepages
To:     Christophe LEROY <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <2f96bf1a8df1091c642de099ed07c34b5ab9b90a.1534258290.git.christophe.leroy@c-s.fr>
 <4aaca2d27429e6bdadc340fd3b96e7c350c4b2f4.1534258290.git.christophe.leroy@c-s.fr>
 <6dea8d0c-c4ab-49aa-da26-a729c18fa818@linux.ibm.com>
 <006e5f33-b816-7508-faac-da26a860659c@c-s.fr>
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date:   Wed, 22 Aug 2018 19:50:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <006e5f33-b816-7508-faac-da26a860659c@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18082214-0012-0000-0000-000016A32F22
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009591; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01077232; UDB=6.00555383; IPR=6.00857208;
 MB=3.00022867; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-22 14:20:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082214-0013-0000-0000-0000542198BC
Message-Id: <3e6412ac-c645-908f-a3bb-c9a2a72f4b68@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-22_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=717 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808220147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/17/2018 04:14 PM, Christophe LEROY wrote:
> 
> 
> Le 17/08/2018 à 05:32, Aneesh Kumar K.V a écrit :
>> On 08/14/2018 08:24 PM, Christophe Leroy wrote:
>>> While implementing TLB miss HW assistance on the 8xx, the following
>>> warning was encountered:
>>>
>>> [  423.732965] WARNING: CPU: 0 PID: 345 at mm/slub.c:2412 
>>> ___slab_alloc.constprop.30+0x26c/0x46c
>>> [  423.733033] CPU: 0 PID: 345 Comm: mmap Not tainted 
>>> 4.18.0-rc8-00664-g2dfff9121c55 #671
>>> [  423.733075] NIP:  c0108f90 LR: c0109ad0 CTR: 00000004
>>> [  423.733121] REGS: c455bba0 TRAP: 0700   Not tainted 
>>> (4.18.0-rc8-00664-g2dfff9121c55)
>>> [  423.733147] MSR:  00021032 <ME,IR,DR,RI>  CR: 24224848  XER: 20000000
>>> [  423.733319]
>>> [  423.733319] GPR00: c0109ad0 c455bc50 c4521910 c60053c0 007080c0 
>>> c0011b34 c7fa41e0 c455be30
>>> [  423.733319] GPR08: 00000001 c00103a0 c7fa41e0 c49afcc4 24282842 
>>> 10018840 c079b37c 00000040
>>> [  423.733319] GPR16: 73f00000 00210d00 00000000 00000001 c455a000 
>>> 00000100 00000200 c455a000
>>> [  423.733319] GPR24: c60053c0 c0011b34 007080c0 c455a000 c455a000 
>>> c7fa41e0 00000000 00009032
>>> [  423.734190] NIP [c0108f90] ___slab_alloc.constprop.30+0x26c/0x46c
>>> [  423.734257] LR [c0109ad0] kmem_cache_alloc+0x210/0x23c
>>> [  423.734283] Call Trace:
>>> [  423.734326] [c455bc50] [00000100] 0x100 (unreliable)
>>> [  423.734430] [c455bcc0] [c0109ad0] kmem_cache_alloc+0x210/0x23c
>>> [  423.734543] [c455bcf0] [c0011b34] huge_pte_alloc+0xc0/0x1dc
>>> [  423.734633] [c455bd20] [c01044dc] hugetlb_fault+0x408/0x48c
>>> [  423.734720] [c455bdb0] [c0104b20] follow_hugetlb_page+0x14c/0x44c
>>> [  423.734826] [c455be10] [c00e8e54] __get_user_pages+0x1c4/0x3dc
>>> [  423.734919] [c455be80] [c00e9924] __mm_populate+0xac/0x140
>>> [  423.735020] [c455bec0] [c00db14c] vm_mmap_pgoff+0xb4/0xb8
>>> [  423.735127] [c455bf00] [c00f27c0] ksys_mmap_pgoff+0xcc/0x1fc
>>> [  423.735222] [c455bf40] [c000e0f8] ret_from_syscall+0x0/0x38
>>> [  423.735271] Instruction dump:
>>> [  423.735321] 7cbf482e 38fd0008 7fa6eb78 7fc4f378 4bfff5dd 7fe3fb78 
>>> 4bfffe24 81370010
>>> [  423.735536] 71280004 41a2ff88 4840c571 4bffff80 <0fe00000> 
>>> 4bfffeb8 81340010 712a0004
>>> [  423.735757] ---[ end trace e9b222919a470790 ]---
>>>
>>> This warning occurs when calling kmem_cache_zalloc() on a
>>> cache having a constructor.
>>>
>>> In this case it happens because PGD cache and 512k hugepte cache are
>>> the same size (4k). While a cache with constructor is created for
>>> the PGD, hugepages create cache without constructor and uses
>>> kmem_cache_zalloc(). As both expect a cache with the same size,
>>> the hugepages reuse the cache created for PGD, hence the conflict.
>>>
>>> In order to avoid this conflict, this patch:
>>> - modifies pgtable_cache_add() so that a zeroising constructor is
>>> added for any cache size.
>>> - replaces calls to kmem_cache_zalloc() by kmem_cache_alloc()
>>>
>>
>> Can't we just do kmem_cache_alloc with gfp flags __GFP_ZERO? and 
>> remove the constructor completely?
> 
> I don't understand what you mean. That's exactly what I did in v1 (by 
> using kmem_cache_zalloc()), and you commented that doing this we would 
> zeroise at allocation whereas the constructors are called when adding 
> memory to the slab and when freeing the allocated block. Or did I 
> misunderstood your comment ?
> 
> static inline void *kmem_cache_zalloc(struct kmem_cache *k, gfp_t flags)
> {
>      return kmem_cache_alloc(k, flags | __GFP_ZERO);
> }
> 
>

I completely misunderstood kmem_cache_zalloc. I took it as we zero out 
after each alloc. I guess your earlier patch is then good. We may want 
to double check this, I haven't looked at the slab internals.

What we want is to make sure when we add new memory to slab, we want it 
zeroed. If we are allocating objects from existing slab memory pool, we 
don't need to zero out, because when we release objects to slab we make 
sure we clear it.

-aneesh

