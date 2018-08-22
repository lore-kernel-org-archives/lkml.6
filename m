Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18DAC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9A421473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 12:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9A421473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbeHVPun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 11:50:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59634 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728057AbeHVPun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 11:50:43 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7MCP2Df098412
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 08:25:59 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m17s7g4bd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 08:25:59 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Wed, 22 Aug 2018 13:25:56 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 22 Aug 2018 13:25:53 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7MCPpm638010952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Aug 2018 12:25:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EDDBA406B;
        Wed, 22 Aug 2018 15:25:51 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29AB3A4051;
        Wed, 22 Aug 2018 15:25:51 +0100 (BST)
Received: from [9.152.224.111] (unknown [9.152.224.111])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Aug 2018 15:25:51 +0100 (BST)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH] KVM: s390: vsie: Consolidate CRYCB validation
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, cohuck@redhat.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        frankja@linux.ibm.com, akrowiak@linux.ibm.com,
        borntraeger@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
References: <1534925337-18380-1-git-send-email-pmorel@linux.ibm.com>
 <c410ab24-1f83-21f3-1996-7328aeb3f408@redhat.com>
 <7de5e991-764e-dec8-648b-6acc42c141e6@linux.ibm.com>
 <f5261c1a-58f6-68f2-1736-eb13dce863b6@redhat.com>
 <0032fc9b-4328-1a09-66f5-65f485a8a42f@linux.ibm.com>
 <a6a2aec1-33cf-6299-8219-ed5043ba07be@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Wed, 22 Aug 2018 14:25:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a6a2aec1-33cf-6299-8219-ed5043ba07be@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18082212-0008-0000-0000-0000026528F7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082212-0009-0000-0000-000021CD6B75
Message-Id: <8afefad7-d4a5-7e02-d5ea-9a355cbed332@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-22_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808220127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/08/2018 13:09, David Hildenbrand wrote:
> On 22.08.2018 12:42, Pierre Morel wrote:
>> On 22/08/2018 10:44, David Hildenbrand wrote:
>>> On 22.08.2018 10:41, Pierre Morel wrote:
>>>> On 22/08/2018 10:25, David Hildenbrand wrote:
>>>>> On 22.08.2018 10:08, Pierre Morel wrote:
>>>>>> Currently when shadowing the CRYCB on SIE entrance, the validation
>>>>>> tests the following:
>>>>>> - accept only FORMAT1 or FORMAT2
>>>>>> - test if MSAext facility (76) is installed
>>>>>> - accept the CRYCB if no keys are used
>>>>>> - verifies that the CRYCB format1 is inside a page
>>>>>> - verifies that the CRYCB origin is not 0
>>>>>>
>>>>>> This is not following the architecture.
>>>>> I have to trust you on that :)
>>>>>
>>>>>> On SIE entrance, the CRYCB must be validated before accepting
>>>>>> any of its entries.
>>>>>>
>>>>>> Let's do the validation in the right order and also verify
>>>>>> correctly the FORMAT2 CRYCB.
>>>>> With which facility was FORMAT2 introduced?
>>>> With APXA.
>>>> KVM initialization setup CRYCB format according to the presence
>>>> of APXA for FORMAT2 or FORMAT1
>>> As our guest does not see APXA, why should it be allowed to make use of
>>> FORMAT2 here already?
>>>
>>> In my opinion, the size check you are adding is in the current state not
>>> correct.
>> The point is that the documentation states that bit 30 is ignored
>> if the APXA facility is not installed in the **host** configuration.
>>
> host here most probably means "we as a hypervisor that probe for APXA".
> This is to differentiate it from "APXA installed in the guest
> configuration" - e.g. via AP execution control. No AP, no APXA, no
> FORMAT 2 accepted. -> Bit ignored.
>
> Don't confuse it with "machine configuration". (mixing that in makes
> things way too complicated)
OK
>
>> Which I understand as FORMAT2 may not be ignored if APXA is installed
>> in the host configuration.
>>
> "host" is used to differentiate from "guest". If we are at G1 level and
> there is no APXA, the FORMAT2 bit is to be ignored.
OK

>
>>  From the host, we control the guest1 and we start it without AP
>> by not setting ECA.28.
>> So that the guest1 can not know if APXA is installed or not since to know
>> this it must use a AP instruction :)
> No AP implies no APXA. On that logical level "host".

hum.
No seen, usable nor used APXA  on that level: yes.

>
>> Now the guest1 is an hypervizor and wants to start a guest2.
>> It can set ECA.28 to allow the guest2 AP instructions , just because it can,
>> (even guest2 will not see any as it will be masked by the guest1 ECA.28
>> that we did not set)
> ECA.28 has no effect as G1 sees no AP facility. That is the real reason.

Not exactly, the ECA.28 field used for G2 is an effective field
calculated from G1.ECA.28 & G2.ECA.28

G1 not having AP instructions is the consequence of G1.ECA.28=0

There is no AP Facility in the sense of STFL bits.

>
>> It can also set the FORMAT2 just because it can do it.
>> The documentation explicitly says that FORMAT2 may be used
>> without APXA and that in this case it will be handled as a FORMAT1
>>
>>
>> The question is do we want to forbid this?
>> It is not an error.
>> Suppose that an hypervizor always set FORMAT2 to be able to not restart
>> its guest if the host set ECA.28 a posteriori.
>>
>> Anyway we have the choice:
>> - we verify the CRYCB for FORMAT2
>> or
>> - we forbid FORMAT2
>>
>> Since we will soon (I hope) be able to use AP instructions in AP
>> but we are not able to do it today, we could forbid FORMAT2
>> however in the current behavior we authorize FORMAT2...
>>
>> What ever the choice is we must change the current implementation.
>>
>> I prefer to keep the current interface but make sure that the
>> host do not crash when scheduling a FORMAT2 SIE crossing
>> a page boundary.
>>
>>
>> What do you think we should do?
> Keep it simple. Don't mix in machine configuration. Try to make each
> layer look consistent.
>
> If there is no AP/APXA on a level ("host"), FORMAT2 is ignored in SIE.
> If there is no AP/APXA on a level ("host"), ECA.28 is ignored in SIE.
> If there is no MSA3 on a level ("host"), ECB3_AES | ECB3_DEA is ignored
> in SIE.
>
> If there is no AP/APXA/MSA3 on a level ("host"), crycbd is completely
> ignored in SIE. (that means, no validity intercepts to be injected).
> Please double check that in the documentation.
>
> If there is is AP/MSA3 and either ECA.28 | ECB3_AES | ECB3_DEA, what
> should happen? (please verify in the documentation)
>
> FORMAT2 should really only be allowed if there is APXA. As we cannot
> fake abscence for guests (as of now), guest availability always matches
> host availability if AP is enabled for a guest.

I am not sure we can KIS.

For the SIE firmware a guest G1 or G2 or not distinguishable.

Using VSIE we let the G2 run inside a SIE Control Block installed by the 
host.
So if the host has AP/APXA and even if G1 has not AP/APXA
then, if we take your first assumption, FORMAT2 is not ignored in the SIE.

Since the test is done on SIE entry
no need to run an instruction to get a validity interception,
which is for me explained by the documentation stating that:

The check of APCB/CRYCB and APCB/CRYCB origin is performed
only if any of the following is true:
(a) ECA.28 is one
(b) CRYCB format field (F) is one
or
(c) the AXPA facility is installed and the F field is three

If not having the AP instruction would be enough to avoid
a validity interception, then there would be no need to
have the point (c).


Conclusion for me 2 solutions:
- forbid format 2 in G2
- check FORMAT2 before letting it go in the shadow SCB


What did I missed?
What is your point of view?

Thanks for your patience.

Regards,
Pierre


-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

