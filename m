Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967086AbeBNKK1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:10:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966963AbeBNKKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:10:25 -0500
Subject: Re: [patch] kvm: suppress KVM_SET_GSI_ROUTING allocation failure
To: David Rientjes <rientjes@google.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <alpine.DEB.2.10.1802081334120.133173@chino.kir.corp.google.com>
 <47a55220-0006-6486-5a9d-1d1142efcc47@de.ibm.com>
 <f9754c98-9b8d-97b6-54cf-6d5e55143100@redhat.com>
 <alpine.DEB.2.10.1802131702280.71590@chino.kir.corp.google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <179c1c39-2b3f-20f6-d4cb-0044aa49e570@redhat.com>
Date: Wed, 14 Feb 2018 11:10:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1802131702280.71590@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2018 02:03, David Rientjes wrote:
> On Tue, 13 Feb 2018, Paolo Bonzini wrote:
> 
>>>> The KVM_SET_GSI_ROUTING ioctl does a vmalloc() of
>>>> sizeof(struct kvm_irq_routing_entry) multiplied by a user-supplied value.
>>>> This can be up to 4096 entries on architectures such as arm64 and s390
>>>> (and the upper bound may be increased on s390 eventually).
>>>>
>>>> This can produce a vmalloc allocation failure warning:
>>>>
>>> [...]
>>>>  kvm_vm_ioctl+0x910/0x15e0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:4153
>>>
>>>                                                                        ^^^^^
>>>
>>>> @@ -3063,7 +3063,8 @@ static long kvm_vm_ioctl(struct file *filp,
>>>
>>>       ^^^^^
>>>
>>>
>>> Are you sure that you got the right vmalloc?
>>
>> Nice catch!  But well, it's the only one in the whole file. :)
>>
>> That seems very much like an old patch then.  I'm unqueuing it.
>>
> 
> It's not a catch at all, the fact that I saw this warning with an older 
> kernel for KVM_SET_GSI_ROUTING doesn't mean that I can't patch it with an 
> upstream kernel.  Would you prefer I remove the stack trace completely?

The upstream kernel doesn't warn.  It checks "if (routing.nr)" before
calling vmalloc.

Paolo
