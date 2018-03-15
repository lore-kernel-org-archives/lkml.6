Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933085AbeCOXiB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 19:38:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35326 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932673AbeCOXiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 19:38:00 -0400
Subject: Re: [PATCH v3 04/14] KVM: s390: device attribute to set AP
 interpretive execution
To: Pierre Morel <pmorel@linux.vnet.ibm.com>,
        Halil Pasic <pasic@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com,
        buendgen@de.ibm.com
References: <1521051954-25715-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1521051954-25715-5-git-send-email-akrowiak@linux.vnet.ibm.com>
 <d86ad01e-1c79-c14c-b4da-09d9a31572bd@linux.vnet.ibm.com>
 <3afd28d7-57c6-cda6-a436-18da32ef0df3@linux.vnet.ibm.com>
 <1e8a4cfc-1425-b30e-2875-2a5c5d9bcb7c@linux.vnet.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Thu, 15 Mar 2018 19:37:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1e8a4cfc-1425-b30e-2875-2a5c5d9bcb7c@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031523-0012-0000-0000-000015E7DE81
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008681; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01003609; UDB=6.00510773; IPR=6.00782935;
 MB=3.00020058; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-15 23:37:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031523-0013-0000-0000-000051E331F1
Message-Id: <a306855f-381d-9cc6-9996-2e7f75e0bc39@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-15_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803150254
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15/2018 12:00 PM, Pierre Morel wrote:
> On 15/03/2018 16:23, Tony Krowiak wrote:
>> On 03/14/2018 05:57 PM, Halil Pasic wrote:
>>>
>>> On 03/14/2018 07:25 PM, Tony Krowiak wrote:
>>>> The VFIO AP device model exploits interpretive execution of AP
>>>> instructions (APIE) to provide guests passthrough access to AP
>>>> devices. This patch introduces a new device attribute in the
>>>> KVM_S390_VM_CRYPTO device attribute group to set APIE from
>>>> the VFIO AP device defined on the guest.
>>>>
>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>>> ---
>>> [..]
>>>
>>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>>> index a60c45b..bc46b67 100644
>>>> --- a/arch/s390/kvm/kvm-s390.c
>>>> +++ b/arch/s390/kvm/kvm-s390.c
>>>> @@ -815,6 +815,19 @@ static int kvm_s390_vm_set_crypto(struct kvm 
>>>> *kvm, struct kvm_device_attr *attr)
>>>> sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
>>>>           VM_EVENT(kvm, 3, "%s", "DISABLE: DEA keywrapping support");
>>>>           break;
>>>> +    case KVM_S390_VM_CRYPTO_INTERPRET_AP:
>>>> +        if (attr->addr) {
>>>> +            if (!test_kvm_cpu_feat(kvm, KVM_S390_VM_CPU_FEAT_AP))
>>> Unlock mutex before returning?
>> The mutex is unlocked prior to return at the end of the function.
>>>
>>> Maybe flip conditions (don't allow manipulating apie if feature not 
>>> there).
>>> Clearing the anyways clear apie if feature not there ain't too bad, but
>>> rejecting the operation appears nicer to me.
>> I think what you're saying is something like this:
>>
>>     if (!test_kvm_cpu_feat(kvm, KVM_S390_VM_CPU_FEAT_AP))
>>         return -EOPNOTSUPP;
>>
>>     kvm->arch.crypto.apie = (attr->addr) ? 1 : 0;
>>
>> I can make arguments for doing this either way, but since the attribute
>> is will most likely only be set by an AP device in userspace, I suppose
>> it makes sense to allow setting of the attribute if the AP feature is
>> installed. It certainly makes sense for the dedicated implementation.
>>>
>>>> +                return -EOPNOTSUPP;
>
> Obviously Halil is speaking on this return statement.
> Which returns without unlocking the mutex.
Got it.
>
>
>
>
