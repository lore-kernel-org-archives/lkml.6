Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F49FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5D521924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbfBOJ4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:56:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39634 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731497AbfBOJ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:56:07 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1F9qWmx068963
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 04:56:06 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qnswac2ux-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 04:56:05 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 15 Feb 2019 09:56:03 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 15 Feb 2019 09:56:00 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1F9twY22228726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 09:55:58 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EB47A405F;
        Fri, 15 Feb 2019 09:55:58 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BE98A4054;
        Fri, 15 Feb 2019 09:55:57 +0000 (GMT)
Received: from [9.145.44.11] (unknown [9.145.44.11])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 15 Feb 2019 09:55:57 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v3 2/9] s390: ap: kvm: setting a hook for PQAP
 instructions
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     borntraeger@de.ibm.com, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
 <1550152269-6317-3-git-send-email-pmorel@linux.ibm.com>
 <20190214165407.335b4ec0.cohuck@redhat.com>
 <2609f072-ab16-429e-8aba-e1af20757c25@linux.ibm.com>
 <20190215102627.6e300e28.cohuck@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Fri, 15 Feb 2019 10:55:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215102627.6e300e28.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19021509-0016-0000-0000-00000256CB24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19021509-0017-0000-0000-000032B0FFA6
Message-Id: <336a22e1-5b42-5dd8-f771-e417bda05342@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=598 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902150072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2019 10:26, Cornelia Huck wrote:
> On Thu, 14 Feb 2019 17:45:06 +0100
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 14/02/2019 16:54, Cornelia Huck wrote:
>>> On Thu, 14 Feb 2019 14:51:02 +0100
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>    
>>>> This patch adds interception code for the PQAP instructions,
>>>> and a callback inside the KVM arch structure for s390.
>>>>
>>>> If a VFIO-AP drivers needs to intercept PQAP/AQIC or PQAP/TAPQ
>>>
>>> s/drivers/driver/
>>
>> thanks. OK
>>
> 
>>>> + *
>>>> + * This callback only handles PQAP/AQIC instruction and
>>>
>>> Here you only talk about PQAP/AQIC, what about PQAP/TAPQ mentioned in
>>> the patch description?
>>
>> I can add "for now" or "in this patch" or suppress the reference to
>> PAPQ/TAPQ
> 
> I'd just add a note to the patch description that this patch only
> handles PQAP/AQCI and that handling PQAP/TAPQ is something for a
> follow-on patch.

OK, I will clear this.
Thanks


> 
>>
>>>   

...snip...

>>>> +	/* PQAP instructions are allowed for guest kernel only */
>>>> +	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
>>>> +		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
>>>> +	/* AQIC instruction is allowed only if facility 65 is available */
>>>> +	if (!test_kvm_facility(vcpu->kvm, 65))
>>>> +		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
>>>> +	/* All right, call the callback */
>>>> +	return vcpu->kvm->arch.crypto.pqap_hook(vcpu);
>>>
>>> Can that callback also return -EOPNOTSUPP to order to drop to user
>>> space?
>>
>> Yes.
>> Why not?
> 
> Maybe also mention that in the function description?
> 

Will do thanks.

Regards,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

