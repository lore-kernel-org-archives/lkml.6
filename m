Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C04C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9FC27592
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 14:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9FC27592
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966782AbeF1Ov1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 10:51:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41710 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966458AbeF1OvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 10:51:23 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5SEmsDC059328
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 10:51:23 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jw08vvyxn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 10:51:22 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Thu, 28 Jun 2018 15:51:20 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Jun 2018 15:51:16 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5SEpF8D33947896
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Jun 2018 14:51:15 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0119F52050;
        Thu, 28 Jun 2018 15:51:06 +0100 (BST)
Received: from oc7330422307.ibm.com (unknown [9.152.224.133])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9DF7452054;
        Thu, 28 Jun 2018 15:51:05 +0100 (BST)
Subject: Re: [PATCH/RFC] mm: do not drop unused pages when userfaultd is
 running
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-s390@vger.kernel.org
Cc:     kvm@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20180628123916.96106-1-borntraeger@de.ibm.com>
 <df95ae10-0c78-0d76-d2bb-c91712c145ea@redhat.com>
 <1e470063-d56c-0a76-7a7f-2c0f0e87824b@de.ibm.com>
 <eca5be20-6c3a-5d9b-152a-f4e8b61b810e@redhat.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 syiRa+UVlsKmx1hsEg==
Date:   Thu, 28 Jun 2018 16:51:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <eca5be20-6c3a-5d9b-152a-f4e8b61b810e@redhat.com>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18062814-0008-0000-0000-0000024CE51E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062814-0009-0000-0000-000021B35F6F
Message-Id: <eaa540cb-2249-72d1-d4b8-a54c2869d7a3@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806280168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/28/2018 04:49 PM, David Hildenbrand wrote:
> On 28.06.2018 16:39, Christian Borntraeger wrote:
>>
>>
>> On 06/28/2018 03:18 PM, David Hildenbrand wrote:
>>> On 28.06.2018 14:39, Christian Borntraeger wrote:
>>>> KVM guests on s390 can notify the host of unused pages. This can result
>>>> in pte_unused callbacks to be true for KVM guest memory.
>>>>
>>>> If a page is unused (checked with pte_unused) we might drop this page
>>>> instead of paging it. This can have side-effects on userfaultd, when the
>>>> page in question was already migrated:
>>>>
>>>> The next access of that page will trigger a fault and a user fault
>>>> instead of faulting in a new and empty zero page. As QEMU does not
>>>> expect a userfault on an already migrated page this migration will fail.
>>>>
>>>> The most straightforward solution is to ignore the pte_unused hint if a
>>>> userfault context is active for this VMA.
>>>>
>>>> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
>>>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> ---
>>>>  mm/rmap.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index 6db729dc4c50..3f3a72aa99f2 100644
>>>> --- a/mm/rmap.c
>>>> +++ b/mm/rmap.c
>>>> @@ -1481,7 +1481,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>>>  				set_pte_at(mm, address, pvmw.pte, pteval);
>>>>  			}
>>>>  
>>>> -		} else if (pte_unused(pteval)) {
>>>> +		} else if (pte_unused(pteval) && !vma->vm_userfaultfd_ctx.ctx) {
>>>>  			/*
>>>>  			 * The guest indicated that the page content is of no
>>>>  			 * interest anymore. Simply discard the pte, vmscan
>>>>
>>>
>>> To understand the implications better:
>>>
>>> This is like a MADV_DONTNEED from user space while a userfaultfd
>>> notifier is registered for this vma range.
>>>
>>> While we can block such calls in QEMU ("we registered it, we know it
>>> best"), we can't do the same in the kernel.
>>>
>>> These "intern MADV_DONTNEED" can actually trigger "deferred", so e.g. if
>>> the pte_unused() was set before userfaultfd has been registered, we can
>>> still get the same result, right?>
>> Not sure I understand your last sentence.
> 
> Rephrased: Instead trying to stop somebody from setting pte_unused will
> not work, as we might get a userfaultfd registration at some point and
> find a previously set pte_unused afterwards.

Yes, exactly. the unused value can be set before the migration.


> 
>> This place here is called on the unmap, (e.g. when the host tries to page out).
>> The value was transferred before (and always before) during the page table invalidation.
>> So pte_unused was always set before. This is the place where we decide if we page
>> out (ans establish a swap pte) or just drop this page table entry. So if
>> no userfaultd is registered at that point in time we are good.
> 
> This certainly applies to ordinary userfaultfd we have right now.
> userfaultfd WP (write-protect) or other features to come might be
> different, but it does not seem to do any harm in case we page out
> instead of dropping it. This way we are on the safe side.

yes.
> 
> In other words: I think this is the right approach.

