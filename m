Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00D1C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35870208DC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35870208DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732206AbeHWPQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 11:16:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730163AbeHWPQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 11:16:42 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7NBiIl5072066
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 07:47:21 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m1svfxaam-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 07:47:20 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 23 Aug 2018 12:47:17 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Aug 2018 12:47:14 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7NBlCQL42926200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Aug 2018 11:47:12 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9E644C046;
        Thu, 23 Aug 2018 14:47:13 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71CE44C04E;
        Thu, 23 Aug 2018 14:47:13 +0100 (BST)
Received: from [9.152.224.92] (unknown [9.152.224.92])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Aug 2018 14:47:13 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v3 3/3] KVM: s390: vsie: Make use of CRYCB FORMAT2 clear
To:     Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cohuck@redhat.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        akrowiak@linux.ibm.com, borntraeger@de.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
References: <1535019956-23539-1-git-send-email-pmorel@linux.ibm.com>
 <1535019956-23539-4-git-send-email-pmorel@linux.ibm.com>
 <912d013c-c925-fb3e-ed1d-2d778a60c189@linux.ibm.com>
 <f4c9634d-f442-447a-9eed-7d0f4e72c34f@redhat.com>
 <58427761-072c-e420-a881-4decbe9088bb@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 23 Aug 2018 13:47:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <58427761-072c-e420-a881-4decbe9088bb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18082311-0008-0000-0000-00000265AB5E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082311-0009-0000-0000-000021CDF235
Message-Id: <e0b80820-b4cd-5f51-bd57-ea6e2e638a40@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808230126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2018 13:33, Janosch Frank wrote:
> On 8/23/18 1:21 PM, David Hildenbrand wrote:
>> On 23.08.2018 13:05, Janosch Frank wrote:
>>> On 8/23/18 12:25 PM, Pierre Morel wrote:
>>>> The comment preceding the shadow_crycb function is
>>>> misleading, we effectively accept FORMAT2 CRYCB in the
>>>> guest.
>>>
>>> I beg to differ:
>>>
>>> if (!(crycbd_o & vcpu->arch.sie_block->crycbd & CRYCB_FORMAT1))
>>> 		return 0;
>>
>> FORMAT2 includes bit FORMAT1 (backwards compatible)
> 
> Right, this check is very misleading because of the constant, we
> effectively test against Format 0 and Format 2.
> 
> Can we make this clearer by explicitly ANDing 0x01 or adding a comment?

yes, done, I modified the comment in front of the function.

> 
> Code makes sense:
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

Thanks,

regards,
Pierre

> 
>>
>>>
>>>>
>>>> When using FORMAT2 in the host we do not need to or with
>>>> FORMAT1.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> ---
>>>>   arch/s390/kvm/vsie.c | 6 +++---
>>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>>>> index 38ea5da..e0e6fbf 100644
>>>> --- a/arch/s390/kvm/vsie.c
>>>> +++ b/arch/s390/kvm/vsie.c
>>>> @@ -140,7 +140,8 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>>>    * Create a shadow copy of the crycb block and setup key wrapping, if
>>>>    * requested for guest 3 and enabled for guest 2.
>>>>    *
>>>> - * We only accept format-1 (no AP in g2), but convert it into format-2
>>>> + * We accept format-1 or format-2, but we treat it as a format-1 (no AP in g2),
>>>> + * and we convert it into format-2 in the shadow CRYCB.
>>>>    * There is nothing to do for format-0.
>>>>    *
>>>>    * Returns: - 0 if shadowed or nothing to do
>>>> @@ -179,8 +180,7 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>>>   		return set_validity_icpt(scb_s, 0x0035U);
>>>>   
>>>>   	scb_s->ecb3 |= ecb3_flags;
>>>> -	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT1 |
>>>> -			CRYCB_FORMAT2;
>>>> +	scb_s->crycbd = ((__u32)(__u64) &vsie_page->crycb) | CRYCB_FORMAT2;
>>>
>>> That's purely cosmetic but valid.
>>>
>>>>   
>>>>   	/* xor both blocks in one run */
>>>>   	b1 = (unsigned long *) vsie_page->crycb.dea_wrapping_key_mask;
>>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>
> 
> 


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

