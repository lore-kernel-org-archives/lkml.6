Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967369AbeBNLQ4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 06:16:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40104 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967252AbeBNLQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 06:16:55 -0500
Subject: Re: [patch] kvm: suppress KVM_SET_GSI_ROUTING allocation failure
To: Paolo Bonzini <pbonzini@redhat.com>,
        David Rientjes <rientjes@google.com>
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <alpine.DEB.2.10.1802081334120.133173@chino.kir.corp.google.com>
 <47a55220-0006-6486-5a9d-1d1142efcc47@de.ibm.com>
 <f9754c98-9b8d-97b6-54cf-6d5e55143100@redhat.com>
 <alpine.DEB.2.10.1802131702280.71590@chino.kir.corp.google.com>
 <179c1c39-2b3f-20f6-d4cb-0044aa49e570@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 14 Feb 2018 12:14:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <179c1c39-2b3f-20f6-d4cb-0044aa49e570@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18021411-0012-0000-0000-000005AE9C12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021411-0013-0000-0000-0000192A6745
Message-Id: <cef46bea-c511-c303-e795-ca0e3b540164@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802140132
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/14/2018 11:10 AM, Paolo Bonzini wrote:
> On 14/02/2018 02:03, David Rientjes wrote:
>> On Tue, 13 Feb 2018, Paolo Bonzini wrote:
>>
>>>>> The KVM_SET_GSI_ROUTING ioctl does a vmalloc() of
>>>>> sizeof(struct kvm_irq_routing_entry) multiplied by a user-supplied value.
>>>>> This can be up to 4096 entries on architectures such as arm64 and s390
>>>>> (and the upper bound may be increased on s390 eventually).
>>>>>
>>>>> This can produce a vmalloc allocation failure warning:
>>>>>
>>>> [...]
>>>>>  kvm_vm_ioctl+0x910/0x15e0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4153
>>>>
>>>>                                                                        ^^^^^
>>>>
>>>>> @@ -3063,7 +3063,8 @@ static long kvm_vm_ioctl(struct file *filp,
>>>>
>>>>       ^^^^^
>>>>
>>>>
>>>> Are you sure that you got the right vmalloc?
>>>
>>> Nice catch!  But well, it's the only one in the whole file. :)
>>>
>>> That seems very much like an old patch then.  I'm unqueuing it.
>>>
>>
>> It's not a catch at all, the fact that I saw this warning with an older 
>> kernel for KVM_SET_GSI_ROUTING doesn't mean that I can't patch it with an 
>> upstream kernel.  Would you prefer I remove the stack trace completely?
> 
> The upstream kernel doesn't warn.  It checks "if (routing.nr)" before
> calling vmalloc.

It will warn of the vmalloc space is really exhausted. But then I really ask
myself if we really want to suppress this warning. This should be a big
ALERT to the host admin.
