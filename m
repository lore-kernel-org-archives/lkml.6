Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738ECC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A2E2098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A2E2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbeHWLbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:31:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57622 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728186AbeHWLbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:31:34 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7N7xApt126309
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 04:03:09 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m1rtn0qwy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 04:03:09 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Thu, 23 Aug 2018 09:03:07 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Aug 2018 09:03:04 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7N832Ic46399530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Aug 2018 08:03:02 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0341E4C058;
        Thu, 23 Aug 2018 11:03:04 +0100 (BST)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2B654C04A;
        Thu, 23 Aug 2018 11:03:03 +0100 (BST)
Received: from [9.152.224.92] (unknown [9.152.224.92])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Aug 2018 11:03:03 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v2 1/5] KVM: s390: vsie: BUG correction by shadow_crycb
To:     Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <1534956717-14087-1-git-send-email-pmorel@linux.ibm.com>
 <1534956717-14087-2-git-send-email-pmorel@linux.ibm.com>
 <8300634d-8500-1898-e283-175fc893054a@redhat.com>
 <20180823092722.5853bd4b.cohuck@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Thu, 23 Aug 2018 10:03:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180823092722.5853bd4b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18082308-0012-0000-0000-0000029D907C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082308-0013-0000-0000-000020D0D711
Message-Id: <56c0a875-6d1c-9bff-ebce-695334daa725@linux.ibm.com>
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

On 23/08/2018 09:27, Cornelia Huck wrote:
> On Wed, 22 Aug 2018 18:53:02 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 22.08.2018 18:51, Pierre Morel wrote:
>>> Copy the key mask to the right offset inside the shadow CRYCB
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>   arch/s390/kvm/vsie.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>>> index 9175518..12b9707 100644
>>> --- a/arch/s390/kvm/vsie.c
>>> +++ b/arch/s390/kvm/vsie.c
>>> @@ -173,7 +173,8 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>>   		return set_validity_icpt(scb_s, 0x0039U);
>>>   
>>>   	/* copy only the wrapping keys */
>>> -	if (read_guest_real(vcpu, crycb_addr + 72, &vsie_page->crycb, 56))
>>> +	if (read_guest_real(vcpu, crycb_addr + 72,
>>> +			    vsie_page->crycb.dea_wrapping_key_mask, 56))
>>>   		return set_validity_icpt(scb_s, 0x0035U);
>>>   
>>>   	scb_s->ecb3 |= ecb3_flags;
>>>    
>>
>> Please fixup the subject as requested.
> 
> +1
> 
>> (were there more RB-s?)

Already done in my local branch.

>>
> 
> Yep, mine. FTR:
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

Thanks,

regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

