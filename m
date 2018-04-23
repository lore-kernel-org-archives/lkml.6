Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754932AbeDWLvN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 07:51:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50420 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754837AbeDWLu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 07:50:56 -0400
Subject: Re: [PATCH v2] KVM: Extend MAX_IRQ_ROUTES to 4096 for all archs
To: Wanpeng Li <kernellwp@gmail.com>, Cornelia Huck <cohuck@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Tonny Lu <tonnylu@tencent.com>, Janosch Frank <frankja@linux.ibm.com>
References: <1524185248-51744-1-git-send-email-wanpengli@tencent.com>
 <20180420091537.1c6cb06b.cohuck@redhat.com>
 <CANRm+CxTDFu4C7bB_9e2a4Wi3BKDvc-RrX3Pj4Q5SRdZHmO-BA@mail.gmail.com>
 <20180420162155.675d516d.cohuck@redhat.com>
 <CANRm+CwQB_EBK_GSF-Nrm6kfpQoNZJmg+N382B+d4YVNjj_gOA@mail.gmail.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Date: Mon, 23 Apr 2018 13:50:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CANRm+CwQB_EBK_GSF-Nrm6kfpQoNZJmg+N382B+d4YVNjj_gOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18042311-0044-0000-0000-0000054B2E20
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042311-0045-0000-0000-0000288B5A8F
Message-Id: <38e7d755-f95a-fcad-3f70-3a4eb049fc81@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804230123
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/21/2018 02:38 AM, Wanpeng Li wrote:
> 2018-04-20 22:21 GMT+08:00 Cornelia Huck <cohuck@redhat.com>:
>> On Fri, 20 Apr 2018 21:51:13 +0800
>> Wanpeng Li <kernellwp@gmail.com> wrote:
>>
>>> 2018-04-20 15:15 GMT+08:00 Cornelia Huck <cohuck@redhat.com>:
>>>> On Thu, 19 Apr 2018 17:47:28 -0700
>>>> Wanpeng Li <kernellwp@gmail.com> wrote:
>>>>
>>>>> From: Wanpeng Li <wanpengli@tencent.com>
>>>>>
>>>>> Our virtual machines make use of device assignment by configuring
>>>>> 12 NVMe disks for high I/O performance. Each NVMe device has 129
>>>>> MSI-X Table entries:
>>>>> Capabilities: [50] MSI-X: Enable+ Count=129 Masked-Vector table: BAR=0 offset=00002000
>>>>> The windows virtual machines fail to boot since they will map the number of
>>>>> MSI-table entries that the NVMe hardware reported to the bus to msi routing
>>>>> table, this will exceed the 1024. This patch extends MAX_IRQ_ROUTES to 4096
>>>>> for all archs, in the future this might be extended again if needed.
>>>>>
>>>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>>>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>>>>> Cc: Tonny Lu <tonnylu@tencent.com>
>>>>> Cc: Cornelia Huck <cohuck@redhat.com>
>>>>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>>>>> Signed-off-by: Tonny Lu <tonnylu@tencent.com>
>>>>> ---
>>>>> v1 -> v2:
>>>>>  * extend MAX_IRQ_ROUTES to 4096 for all archs
>>>>>
>>>>>  include/linux/kvm_host.h | 6 ------
>>>>>  1 file changed, 6 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
>>>>> index 6930c63..0a5c299 100644
>>>>> --- a/include/linux/kvm_host.h
>>>>> +++ b/include/linux/kvm_host.h
>>>>> @@ -1045,13 +1045,7 @@ static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
>>>>>
>>>>>  #ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
>>>>>
>>>>> -#ifdef CONFIG_S390
>>>>>  #define KVM_MAX_IRQ_ROUTES 4096 //FIXME: we can have more than that...
>>>>
>>>> What about /* might need extension/rework in the future */ instead of
>>>> the FIXME?
>>>
>>> Yeah, I guess the maintainers can help to fix it when applying. :)
>>>
>>>>
>>>> As far as I understand, 4096 should cover most architectures and the
>>>> sane end of s390 configurations, but will not be enough at the scarier
>>>> end of s390. (I'm not sure how much it matters in practice.)
>>>>
>>>> Do we want to make this a tuneable in the future? Do some kind of
>>>> dynamic allocation? Not sure whether it is worth the trouble.
>>>
>>> I think keep as it is currently.
>>
>> My main question here is how long this is enough... the number of
>> virtqueues per device is up to 1K from the initial 64, which makes it
>> possible to hit the 4K limit with fewer virtio devices than before (on
>> s390, each virtqueue uses a routing table entry). OTOH, we don't want
>> giant tables everywhere just to accommodate s390.
> 
> I suspect there is no real scenario to futher extend for s390 since no
> guys report.
> 
>> If the s390 maintainers tell me that nobody is doing the really insane
>> stuff, I'm happy as well :)
> 
> Christian, any thoughts?

For now this patch is a no-op for s390 so as long as nobody complains today we are good.
If it turns out to be "not enough" we can then add a configurable number or whatever. 
