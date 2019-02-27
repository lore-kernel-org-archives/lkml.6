Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D736C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285E32184A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbfB0SAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 13:00:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725854AbfB0SAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 13:00:38 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1RHxiZk064692
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 13:00:37 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qwxdg3206-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 13:00:37 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <akrowiak@linux.ibm.com>;
        Wed, 27 Feb 2019 18:00:36 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Feb 2019 18:00:33 -0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x1RI0TFE24903914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Feb 2019 18:00:29 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC21C11206D;
        Wed, 27 Feb 2019 18:00:28 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE609112069;
        Wed, 27 Feb 2019 18:00:27 +0000 (GMT)
Received: from [9.80.218.61] (unknown [9.80.218.61])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 27 Feb 2019 18:00:27 +0000 (GMT)
Subject: Re: [PATCH v4 1/7] s390: ap: kvm: add PQAP interception for AQIC
To:     pmorel@linux.ibm.com, borntraeger@de.ibm.com
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com,
        david@redhat.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
 <1550849400-27152-2-git-send-email-pmorel@linux.ibm.com>
 <babf7884-35f1-2f2e-34dc-96d9190fd15b@linux.ibm.com>
 <e7ba5cb0-b254-7f73-bc59-ca2456ce7951@linux.ibm.com>
 <9f1d9241-39b9-adbc-d0e9-cb702e609cbc@linux.ibm.com>
 <4dc59125-7f96-cba8-651b-382ed8f8bff8@linux.ibm.com>
From:   Tony Krowiak <akrowiak@linux.ibm.com>
Date:   Wed, 27 Feb 2019 13:00:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <4dc59125-7f96-cba8-651b-382ed8f8bff8@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19022718-2213-0000-0000-00000359D25A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010675; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01167206; UDB=6.00609755; IPR=6.00947817;
 MB=3.00025768; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-27 18:00:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022718-2214-0000-0000-00005D7FE165
Message-Id: <8526f468-9a4d-68d2-3868-0dad5ce16f46@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-27_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902270123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/19 3:09 AM, Pierre Morel wrote:
> On 26/02/2019 16:47, Tony Krowiak wrote:
>> On 2/26/19 6:47 AM, Pierre Morel wrote:
>>> On 25/02/2019 19:36, Tony Krowiak wrote:
>>>> On 2/22/19 10:29 AM, Pierre Morel wrote:
>>>>> We prepare the interception of the PQAP/AQIC instruction for
>>>>> the case the AQIC facility is enabled in the guest.
>>>>>
>>>>> We add a callback inside the KVM arch structure for s390 for
>>>>> a VFIO driver to handle a specific response to the PQAP
>>>>> instruction with the AQIC command.
>>>>>
>>>>> We inject the correct exceptions from inside KVM for the case the
>>>>> callback is not initialized, which happens when the vfio_ap driver
>>>>> is not loaded.
>>>>>
>>>>> If the callback has been setup we call it.
>>>>> If not we setup an answer considering that no queue is available
>>>>> for the guest when no callback has been setup.
>>>>>
>>>>> We do consider the responsability of the driver to always initialize
>>>>> the PQAP callback if it defines queues by initializing the CRYCB for
>>>>> a guest.
>>>>>
>>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>
>>> ...snip...
>>>
>>>>> @@ -592,6 +593,55 @@ static int handle_io_inst(struct kvm_vcpu *vcpu)
>>>>>       }
>>>>>   }
>>>>> +/*
>>>>> + * handle_pqap: Handling pqap interception
>>>>> + * @vcpu: the vcpu having issue the pqap instruction
>>>>> + *
>>>>> + * We now support PQAP/AQIC instructions and we need to correctly
>>>>> + * answer the guest even if no dedicated driver's hook is available.
>>>>> + *
>>>>> + * The intercepting code calls a dedicated callback for this 
>>>>> instruction
>>>>> + * if a driver did register one in the CRYPTO satellite of the
>>>>> + * SIE block.
>>>>> + *
>>>>> + * For PQAP/AQIC instructions only, verify privilege and 
>>>>> specifications.
>>>>> + *
>>>>> + * If no callback available, the queues are not available, return 
>>>>> this to
>>>>> + * the caller.
>>>>> + * Else return the value returned by the callback.
>>>>> + */
>>>>> +static int handle_pqap(struct kvm_vcpu *vcpu)
>>>>> +{
>>>>> +    uint8_t fc;
>>>>> +    struct ap_queue_status status = {};
>>>>> +
>>>>> +    /* Verify that the AP instruction are available */
>>>>> +    if (!ap_instructions_available())
>>>>> +        return -EOPNOTSUPP;
>>>>
>>>> How can the guest even execute an AP instruction if the AP instructions
>>>> are not available? If the AP instructions are not available on the 
>>>> host,
>>>> they will not be available on the guest (i.e., CPU model feature
>>>> S390_FEAT_AP will not be set). I suppose it doesn't hurt to check this
>>>> here given QEMU may not be the only client.
>>>>
>>>>> +    /* Verify that the guest is allowed to use AP instructions */
>>>>> +    if (!(vcpu->arch.sie_block->eca & ECA_APIE))
>>>>> +        return -EOPNOTSUPP;
>>>>> +    /* Verify that the function code is AQIC */
>>>>> +    fc = vcpu->run->s.regs.gprs[0] >> 24;
>>>>> +    if (fc != 0x03)
>>>>> +        return -EOPNOTSUPP;
>>>>
>>>> You must have missed my suggestion to move this to the
>>>> vcpu->kvm->arch.crypto.pqap_hook(vcpu) in the following responses:
>>>
>>> Please consider what happen if the vfio_ap module is not loaded.
>>
>> I have considered it and even verified my expectations empirically. If
>> the vfio_ap module is not loaded, you will not be able to create an 
>> mdev device.
> 
> OK, now please consider that another userland tool, not QEMU uses KVM.

What does that have to do with loading the vfio_ap module? Without the
vfio_ap module, there will be no AP devices for the guest. What are you
suggesting here?

> 
>> If you don't have an mdev device, you will not be able to
>> start a guest with a vfio-ap device. If you start a guest without a
>> vfio-ap device, but enable AP instructions for the guest, there will be
>> no AP devices attached to the guest. Without any AP devices attached,
>> the PQAP(AQIC) instructions will not ever get executed.
> 
> This is not right. The instruction will be executed, eventually, after 
> decoding.

Please explain why the PQAP(AQIC) instruction will be executed on a
guest without any devices? Point me to the code in the AP bus where
PQAP(AQIC) is executed without a queue?

> 
>> Even if for some
>> unknown reason the PQAP(AQIC) instruction is executed - for some unknown
>> reason, it will fail with response code 0x01, AP-queue number not valid.
> 
> No, before accessing the AP-queue the instruction will be decoded and 
> depending on the installed micro-code it will fail with
> - OPERATION EXCEPTION if the micro-code is not installed
> - PRIVILEDGE OPERATION if the instruction is issued from userland 
> (programm state)
> - SPECIFICATION exception if the instruction do not respect the usage 
> specification
> 
> then it will be interpreted by the microcode and access the queue and 
> only then it will fail with RC 0x01, AP queue not valid.
> 
> In the case of KVM, we intercept the instruction because it is issued by 
> the guest and we set the AQIC facility on to force interception.
> 
> KVM do for us all the decode steps I mention here above, if there is or 
> not a pqap hook to be call to simulate the QP queue access.
> 
> That done, the AP queue virtualisation can be called, this is done by 
> calling the hook.

Okay, let's go back to the genesis of this discussion; namely, my
suggestion about moving the fc == 0x03 check into the hook code. If
the vfio_ap module is not loaded, there will be no hook code. In that
case, the check for the hook will fail and ultimately response code
0x01 will be set in the status word (which may not be the right thing
to do?). You have not stated a single good reason for keeping this
check, but I'm done with this silly argument. It certainly doesn't
hurt anything.

> 
>>
>>
>>>
>>>>
>>>> Message ID <342ffd56-b73a-b1f4-004d-de2c4aeef729@linux.ibm.com>
>>>> Message ID <e04f0c8b-2fd9-1846-334a-faa48e0e051e@linux.ibm.com>
>>>>
>>>> You previously stated:
>>>>
>>>>     "QEMU and KVM can both accept PQAP/AQIC even if the vfio_ap 
>>>> driver is
>>>>      not loaded. However now that the guest officially get the 
>>>> PQAP/AQIC
>>>>      instruction we need to handle the specification and operation
>>>>      exceptions inside KVM _before_ testing and even calling the driver
>>>>      hook.
>>>>
>>>>      I will make the changes in the next iteration."
>>>
>>> Still seems right to me, and is done is this patch.
>>> Isn't it?
>>
>> I don't think it's a matter of right and wrong, it's a matter of what
>> makes sense. IMHO, you want to make things easy if other PQAP functions
>> are intercepted at some time. In my opinion, there should be a switch
>> statement in the pqap hook code with a case statement for each PQAP
>> function supported by the hook. To plug in a new PQAP function handler,
>> it will be a simple matter of writing the handler function and calling
>> it from the case statement, like this:
>>
>> static int handle_pqap(struct kvm_vcpu *vcpu)
>> {
>>      int ret;
>>      uint8_t fc;
>>
>>      fc = vcpu->run->s.regs.gprs[0] >> 24;
>>
>>      switch (fc) {
>>      case 0x03:
>>          ret = handle_pqap_aqic(vcpu);
>>      default:
>>          ret = -EOPNOTSUPP;
>>      }
>>
>>      return ret;
>> }
>>
>> That function belongs in the pqap hook. I see no reaason whatsoever to
>> check the function code here. If there is no hook, then you will fall
>> through to the instruction below:
>>
>> status.response_code = 0x01;
> 
> See answer above, what you are speaking about is the execution of the 
> instruction, but there can be exceptions during the decode of the 
> instruction.

What are you talking about, "decode of the instruction".

> 
>>
>>>
>>>>
>>>> I don't know what any of the above has to do with checking FC=0x03? If
>>>> that check is moved to the pqap handler hook, it can just as well 
>>>> return
>>>> -EOPNOTSUPP. In fact, down below you do this:
>>>>
>>>>      return vcpu->kvm->arch.crypto.pqap_hook(vcpu);
>>>>
>>>> If the RC=0x03 check fails in the hook, it will return -EOPNOTSUPP just
>>>> like above. None of this is critical, but the parsing of the register
>>>> values for the PQAP(AQIC) function ought to be done in the code that
>>>> handles the PQAP instruction IMHO.
>>>
>>>
>>> This interception code must handle the PQAP/AQIC instruction when the 
>>> hook is not used and should not modify the handling for other PQAP 
>>> instructions.
>>> We can not move anything inside the hook that must be always done.
>>
>> What you are saying here makes no sense. If the check for the function
>> code is moved into the pqap hook and fc != 0x03, the result will be
>> exactly the same; the hook will return -EOPNOTSUPP.
> 
> again please consider that the hook may not be initialized.


So what? Then maybe the code at the end of the function is wrong:

/* PQAP/AQIC instructions are authorized but there is no queue */
status.response_code = 0x01;
memcpy(&vcpu->run->s.regs.gprs[1], &status, sizeof(status));
return 0;

Why does this make sense? What if the APQN is valid? You don't even know
whether it is or not. The only reason you would even reach this
instruction is if the pqap hook is not initialized. Wouldn't it make
more sense to just return -EOPNOTSUPP here? If there is no hook, then
it is not supported.

> 
> Regards,
> Pierre
> 

