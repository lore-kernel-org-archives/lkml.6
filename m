Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52291C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0469D21473
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0469D21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbeHWL3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:29:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728085AbeHWL3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:29:53 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7N7x9qT031730
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 04:01:29 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m1rmhs1dt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 04:01:29 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 23 Aug 2018 09:01:26 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Aug 2018 09:01:24 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7N81NLi22609944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Aug 2018 08:01:23 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 601984C05A;
        Thu, 23 Aug 2018 11:01:24 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 111E64C05C;
        Thu, 23 Aug 2018 11:01:24 +0100 (BST)
Received: from [9.152.224.92] (unknown [9.152.224.92])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Aug 2018 11:01:24 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v2 5/5] KVM: s390: vsie: Do the CRYCB validation first
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cohuck@redhat.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <1534956717-14087-1-git-send-email-pmorel@linux.ibm.com>
 <1534956717-14087-6-git-send-email-pmorel@linux.ibm.com>
 <e985a036-1b19-0feb-e50c-d55dec3dc9e7@redhat.com>
 <01047750-cdc6-b462-1e4f-c79c1036ab94@linux.ibm.com>
 <18c65e67-c5e6-9c2f-e7ab-962376427369@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 23 Aug 2018 10:01:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <18c65e67-c5e6-9c2f-e7ab-962376427369@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18082308-0020-0000-0000-000002BA93C9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082308-0021-0000-0000-00002107EE0C
Message-Id: <ea1dad6d-a698-5d0d-2c41-c08c46068e96@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808230085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2018 09:31, David Hildenbrand wrote:
> On 23.08.2018 09:17, Pierre Morel wrote:
>> On 22/08/2018 19:15, David Hildenbrand wrote:
>>> On 22.08.2018 18:51, Pierre Morel wrote:
>>>> When entering the SIE the CRYCB validation better
>>>> be done independently of the instruction's
>>>> availability.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> ---
>>>>    arch/s390/kvm/vsie.c | 11 ++++++-----
>>>>    1 file changed, 6 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>>>> index 7ee4329..fca25aa 100644
>>>> --- a/arch/s390/kvm/vsie.c
>>>> +++ b/arch/s390/kvm/vsie.c
>>>> @@ -164,17 +164,18 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>>>    	/* format-1 is supported with message-security-assist extension 3 */
>>>>    	if (!test_kvm_facility(vcpu->kvm, 76))
>>>>    		return 0;
>>>> -	/* we may only allow it if enabled for guest 2 */
>>>> -	ecb3_flags = scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
>>>> -		     (ECB3_AES | ECB3_DEA);
>>>> -	if (!ecb3_flags)
>>>> -		return 0;
>>>>    
>>>>    	if ((crycb_addr & PAGE_MASK) != ((crycb_addr + 128) & PAGE_MASK))
>>>>    		return set_validity_icpt(scb_s, 0x003CU);
>>>>    	if (!crycb_addr)
>>>>    		return set_validity_icpt(scb_s, 0x0039U);
>>>>    
>>>> +	/* we may only allow it if enabled for guest 2 */
>>>> +	ecb3_flags = scb_o->ecb3 & vcpu->arch.sie_block->ecb3 &
>>>> +		     (ECB3_AES | ECB3_DEA);
>>>> +	if (!ecb3_flags)
>>>> +		return 0;
>>>> +
>>>>    	/* copy only the wrapping keys */
>>>>    	if (read_guest_real(vcpu, crycb_addr + 72,
>>>>    			    vsie_page->crycb.dea_wrapping_key_mask, 56))
>>>>
>>>
>>> That makes sense, especially if ECB3_AES is used but effectively turned
>>> off by us.
>>>
>>> What is the expected behavior if ECB3_AES | ECB3_DEA are not set by g2
>>> for g3?
>>>
>>
>> The use of functions PCKMO-Encrypt-DEA/AES induce a specification error.
>>
>> However other MSA3 function will continue to be usable.
> 
> No, I meant which checks should be performed here.

The SIE should check the validity of the CRYCB.

However since we do not copy the key masks we do not
expect any access error on crycb_o

So it is more a philosophical problem, should the
hypervizor enforce an error here to act as the firmware?


regards,
Pierre



-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

