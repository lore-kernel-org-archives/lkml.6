Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeB1HAB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 02:00:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55604 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751717AbeB1HAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 02:00:00 -0500
Subject: Re: [RFC REBASED 5/5] powerpc/mm/slice: use the dynamic high slice
 size to limit bitmap operations
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <02a62db83282b5ef3e0e8281fdc46fa91beffc86.1518382747.git.christophe.leroy@c-s.fr>
 <5badd882663833576c10b8aafe235fe1e443f119.1518382747.git.christophe.leroy@c-s.fr>
 <87bmga7qng.fsf@linux.vnet.ibm.com>
 <20180227191125.659d5cbe@roar.ozlabs.ibm.com>
 <878tbe7ggs.fsf@linux.vnet.ibm.com>
 <20180228165331.6e09959d@roar.ozlabs.ibm.com>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 28 Feb 2018 12:29:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228165331.6e09959d@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18022806-0044-0000-0000-000003EB2F21
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008601; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00996192; UDB=6.00506426; IPR=6.00775515;
 MB=3.00019772; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-28 06:59:57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022806-0045-0000-0000-0000081B3ACE
Message-Id: <1f14fec4-a2b9-30c8-4c73-ecf00dbba0d7@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280083
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/28/2018 12:23 PM, Nicholas Piggin wrote:
> On Tue, 27 Feb 2018 18:11:07 +0530
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
> 
>> Nicholas Piggin <npiggin@gmail.com> writes:
>>
>>> On Tue, 27 Feb 2018 14:31:07 +0530
>>> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
>>>   
>>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>>>    
>>>>> The number of high slices a process might use now depends on its
>>>>> address space size, and what allocation address it has requested.
>>>>>
>>>>> This patch uses that limit throughout call chains where possible,
>>>>> rather than use the fixed SLICE_NUM_HIGH for bitmap operations.
>>>>> This saves some cost for processes that don't use very large address
>>>>> spaces.
>>>>
>>>> I haven't really looked at the final code. One of the issue we had was
>>>> with the below scenario.
>>>>
>>>> mmap(addr, len) where addr < 128TB and addr+len > 128TB  We want to make
>>>> sure we build the mask such that we don't find the addr available.
>>>
>>> We should run it through the mmap regression tests. I *think* we moved
>>> all of that logic from the slice code to get_ummapped_area before going
>>> in to slices. I may have missed something though, it would be good to
>>> have more eyes on it.
>>>   
>>
>> mmap(-1,...) failed with the test. Something like below fix it
>>
>> @@ -756,7 +770,7 @@ void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
>>          mm->context.low_slices_psize = lpsizes;
>>   
>>          hpsizes = mm->context.high_slices_psize;
>> -       high_slices = GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit);
>> +       high_slices = SLICE_NUM_HIGH;
>>          for (i = 0; i < high_slices; i++) {
>>                  mask_index = i & 0x1;
>>                  index = i >> 1;
>>
>> I guess for everything in the mm_context_t, we should compute it till
>> SLICE_NUM_HIGH. The reason for failure was, even though we recompute the
>> slice mask cached in mm_context on slb_addr_limit, it was still derived
>> from the high_slices_psizes which was computed with lower value.
> 
> Okay thanks for catching that Aneesh. I guess that's a slow path so it
> should be okay. Christophe if you're taking care of the series can you
> fold it in? Otherwise I'll do that after yours gets merged.
> 

should we also compute the mm_context_t.slice_mask using SLICE_NUM_HIGH 
and skip the recalc_slice_mask_cache when we change the addr limit?

-aneesh
