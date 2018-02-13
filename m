Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934089AbeBMPtZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:49:25 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933440AbeBMPtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:49:23 -0500
Subject: Re: [patch] kvm: suppress KVM_SET_GSI_ROUTING allocation failure
To: Michal Hocko <mhocko@kernel.org>
Cc: David Rientjes <rientjes@google.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <alpine.DEB.2.10.1802081334120.133173@chino.kir.corp.google.com>
 <20180213144836.GU3443@dhcp22.suse.cz>
 <a68ddd16-dc7a-4ea7-ac33-ceff6d9276b8@redhat.com>
 <20180213154428.GV3443@dhcp22.suse.cz>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1083260b-dfcd-6354-4e0c-b7b162661b15@redhat.com>
Date: Tue, 13 Feb 2018 16:49:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180213154428.GV3443@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2018 16:44, Michal Hocko wrote:
> On Tue 13-02-18 16:03:09, Paolo Bonzini wrote:
>> On 13/02/2018 15:48, Michal Hocko wrote:
>>> On Thu 08-02-18 13:35:08, David Rientjes wrote:
>>>> The KVM_SET_GSI_ROUTING ioctl does a vmalloc() of
>>>> sizeof(struct kvm_irq_routing_entry) multiplied by a user-supplied value.
>>>> This can be up to 4096 entries on architectures such as arm64 and s390
>>>> (and the upper bound may be increased on s390 eventually).
>>>>
>>>> This can produce a vmalloc allocation failure warning:
>>>>
>>>> vmalloc: allocation failure: 0 bytes, mode:0x24000c2(GFP_KERNEL|__GFP_HIGHMEM)
>>>
>>> I am not arguing about the kvm change but do we actaully want to warn
>>> for 0 sized allocations? This just doesn't make much sense to me.
>>> In other words don't we want this?
>>>
>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>> index 673942094328..c5d832510c54 100644
>>> --- a/mm/vmalloc.c
>>> +++ b/mm/vmalloc.c
>>> @@ -1748,7 +1748,9 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>>>  	unsigned long real_size = size;
>>>  
>>>  	size = PAGE_ALIGN(size);
>>> -	if (!size || (size >> PAGE_SHIFT) > totalram_pages)
>>> +	if (!size)
>>> +		return NULL;
>>> +	if ((size >> PAGE_SHIFT) > totalram_pages)
>>>  		goto fail;
>>>  
>>>  	area = __get_vm_area_node(size, align, VM_ALLOC | VM_UNINITIALIZED |
>>>
>>
>> There have been quite a few reports of this from syzkaller and generally
>> we've fixed them.  It does seem like a recipe for NULL-pointer
>> dereferences when the size is user-controlled (as in this case).
> 
> We do return NULL for that case regardless the above. The patch just
> doesn't warn. Or do you think it is helpful to warn?

It certainly helps bringing potential issues in the spotlight (through
fuzzing, mostly).

Paolo
