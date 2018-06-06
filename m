Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 97A2760764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752348AbeFFO21 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 10:28:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56530 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752177AbeFFO2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 10:28:25 -0400
Subject: Re: [PATCH v5 11/13] KVM: s390: implement mediated device open
 callback
To: pmorel@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, kwankhede@nvidia.com,
        bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com,
        alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com,
        alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com,
        jjherne@linux.vnet.ibm.com, thuth@redhat.com,
        pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com
References: <1525705912-12815-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1525705912-12815-12-git-send-email-akrowiak@linux.vnet.ibm.com>
 <98ea7ce2-2539-e2ff-4bb4-297e784d87bd@linux.ibm.com>
 <7bb480ac-5723-83ff-c797-53c1ab0458c1@linux.vnet.ibm.com>
 <93cd0f46-a410-51c8-00b9-810c1b3d3ae2@linux.ibm.com>
 <0f37dc39-7355-19e5-40c9-a02a1ea58c2d@linux.vnet.ibm.com>
 <736a1346-f81a-7f71-7d13-38729ff78e4f@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Wed, 6 Jun 2018 10:28:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <736a1346-f81a-7f71-7d13-38729ff78e4f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18060614-0068-0000-0000-000003044104
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009139; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01043027; UDB=6.00534142; IPR=6.00822157;
 MB=3.00021491; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-06 14:28:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18060614-0069-0000-0000-00004496FF2A
Message-Id: <8f68183d-8385-8025-1898-23cad604ae94@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-06_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806060166
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2018 08:19 AM, Pierre Morel wrote:
> On 30/05/2018 16:33, Tony Krowiak wrote:
>> On 05/24/2018 05:08 AM, Pierre Morel wrote:
>>> On 23/05/2018 16:45, Tony Krowiak wrote:
>>>> On 05/16/2018 04:03 AM, Pierre Morel wrote:
>>>>> On 07/05/2018 17:11, Tony Krowiak wrote:
>>>>>> Implements the open callback on the mediated matrix device.
>>>>>> The function registers a group notifier to receive notification
>>>>>> of the VFIO_GROUP_NOTIFY_SET_KVM event. When notified,
>>>>>> the vfio_ap device driver will get access to the guest's
>>>>>> kvm structure. With access to this structure the driver will:
>>>>>>
>>>>>> 1. Ensure that only one mediated device is opened for the guest
>>>
>>> You should explain why.
>>>
>>>>>>
>>>>>> 2. Configure access to the AP devices for the guest.
>>>>>>
>>> ...snip...
>>>>>> +void kvm_ap_refcount_inc(struct kvm *kvm)
>>>>>> +{
>>>>>> +    atomic_inc(&kvm->arch.crypto.aprefs);
>>>>>> +}
>>>>>> +EXPORT_SYMBOL(kvm_ap_refcount_inc);
>>>>>> +
>>>>>> +void kvm_ap_refcount_dec(struct kvm *kvm)
>>>>>> +{
>>>>>> +    atomic_dec(&kvm->arch.crypto.aprefs);
>>>>>> +}
>>>>>> +EXPORT_SYMBOL(kvm_ap_refcount_dec);
>>>>>
>>>>> Why are these functions inside kvm-ap ?
>>>>> Will anyone use this outer of vfio-ap ?
>>>>
>>>> As I've stated before, I made the choice to contain all interfaces 
>>>> that
>>>> access KVM in kvm-ap because I don't think it is appropriate for 
>>>> the device
>>>> driver to have to have "knowledge" of the inner workings of KVM. 
>>>> Why does
>>>> it matter whether any entity outside of the vfio_ap device driver 
>>>> calls
>>>> these functions? I could ask a similar question if the interfaces were
>>>> contained in vfio-ap; what if another device driver needs access to 
>>>> these
>>>> interfaces?
>>>
>>> This is very driver specific and only used during initialization.
>>> It is not a common property of the cryptographic interface.
>>>
>>> I really think you should handle this inside the driver.
>>
>> We are going to have to agree to disagree on this one. Is it not 
>> possible
>> that future drivers - e.g., when full virtualization is implemented - 
>> will
>> require access to KVM?
>
> I do not think that an access to KVM is required for full virtualization.

You may be right, but at this point, there is no guarantee. I stand by my
design on this one.

>
>
>
