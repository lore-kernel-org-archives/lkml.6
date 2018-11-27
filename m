Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C801C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B8220873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 15:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B8220873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbeK1CBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 21:01:46 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:30970 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728906AbeK1CBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 21:01:46 -0500
X-IronPort-AV: E=Sophos;i="5.56,287,1539648000"; 
   d="scan'208";a="71602154"
Subject: Re: [Xen-devel] [PATCH v3] xen/balloon: Mark unallocated host memory
 as UNUSABLE
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        <xen-devel@lists.xen.org>, <linux-kernel@vger.kernel.org>
CC:     <jgross@suse.com>, <helgaas@kernel.org>,
        <christian.koenig@amd.com>, <JBeulich@suse.com>
References: <1513778746-6155-1-git-send-email-boris.ostrovsky@oracle.com>
 <7c833e3a-4a0b-e80c-91e2-4348d6959651@citrix.com>
 <d42938a7-2081-65f4-a0d9-6fb7a8dd2fa0@oracle.com>
 <f955576f-532d-d4de-e7eb-718dae4b14c1@citrix.com>
 <3dd5153d-0f17-0e3b-7ebb-5579a7200765@oracle.com>
 <a49d8dc8-ff2f-16d5-aa94-bfb153352d9a@citrix.com>
 <bec58747-dd34-2f2a-135c-c32b39087a3d@oracle.com>
From:   Igor Druzhinin <igor.druzhinin@citrix.com>
Message-ID: <82039741-87dc-c9ab-5bea-4704fe1c55eb@citrix.com>
Date:   Tue, 27 Nov 2018 15:03:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <bec58747-dd34-2f2a-135c-c32b39087a3d@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2018 03:28, Boris Ostrovsky wrote:
> On 11/26/18 2:57 PM, Igor Druzhinin wrote:
>> On 26/11/2018 19:42, Boris Ostrovsky wrote:
>>> On 11/26/18 12:10 PM, Igor Druzhinin wrote:
>>>> On 26/11/2018 16:25, Boris Ostrovsky wrote:
>>>>> On 11/25/18 8:00 PM, Igor Druzhinin wrote:
>>>>>> On 20/12/2017 14:05, Boris Ostrovsky wrote:
>>>>>>> Commit f5775e0b6116 ("x86/xen: discard RAM regions above the maximum
>>>>>>> reservation") left host memory not assigned to dom0 as available for
>>>>>>> memory hotplug.
>>>>>>>
>>>>>>> Unfortunately this also meant that those regions could be used by
>>>>>>> others. Specifically, commit fa564ad96366 ("x86/PCI: Enable a 64bit BAR
>>>>>>> on AMD Family 15h (Models 00-1f, 30-3f, 60-7f)") may try to map those
>>>>>>> addresses as MMIO.
>>>>>>>
>>>>>>> To prevent this mark unallocated host memory as E820_TYPE_UNUSABLE (thus
>>>>>>> effectively reverting f5775e0b6116) and keep track of that region as
>>>>>>> a hostmem resource that can be used for the hotplug.
>>>>>>>
>>>>>>> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>>>>> This commit breaks Xen balloon memory hotplug for us in Dom0 with
>>>>>> "hoplug_unpopulated" set to 1. The issue is that the common kernel
>>>>>> memory onlining procedures require "System RAM" resource to be 1-st
>>>>>> level. That means by inserting it under "Unusable memory" as the commit
>>>>>> above does (intentionally or not) we make it 2-nd level and break memory
>>>>>> onlining.
>>>>> What do you mean by 1st and 2nd level?
>>>>>
>>>> I mean the level of a resource in IOMEM tree (the one that's printed
>>>> from /proc/iomem). 1-st level means its parent is root and so on.
>>> Ah, OK. Doesn't
>>> additional_memory_resource()->insert_resource(iomem_resource) place the
>>> RAM at 1st level? And if not, can we make it so?
>>>
>> That'd mean splitting "Unusable memory" resource. Since it's allocated
>> from bootmem it has proven to be quite difficult but there are seem to
>> be special functions available particularly for memory resource
>> management operations that I've not yet experimented with. So the answer
>> is probably - maybe yes but not straightforward.
>>
>>>>>> There are multiple ways to fix it depending on what was the intention of
>>>>>> original commit and what exactly it tried to workaround. It seems it
>>>>>> does several things at once:
>>>>>> 1) Marks non-Dom0 host memory "Unusable memory" in resource tree.
>>>>>> 2) Keeps track of all the areas safe for hotplug in Dom0
>>>>>> 3) Changes allocation algorithms itself in balloon driver to use those areas
>>>>> Pretty much. (3) is true in the sense that memory is first allocated
>>>>> from hostmem_resource (which is non-dom0 RAM).
>>>>>
>>>>>> Are all the things above necessary to cover the issue in fa564ad96366
>>>>>> ("x86/PCI: Enable a 64bit BAR on AMD Family 15h (Models 00-1f, 30-3f,
>>>>>> 60-7f)")?
>>>>> Not anymore, as far as that particular commit is concerned, but that's
>>>>> because of 03a551734 ("x86/PCI: Move and shrink AMD 64-bit window to
>>>>> avoid conflict") which was introduced after balloon patch. IIRC there
>>>>> were some issues with fa564ad96366 unrelated to balloon.
>>>>>
>>>> If it's not a problem anymore IIUC, can we revert the change as it still
>>>> breaks "hotplug_unpopulated=1" for the reasons I described above?
>>> Since this seems to have broken existing feature this would be an
>>> option. But before going that route I'd like to see if we can fix the patch.
>>>
>>> I have been unable to reproduce your problem. Can you describe what you did?
>>>
>> It doesn't happen on all configurations as sometimes the memory is
>> successfully hotplugged to a hole depending on the size of Dom0 memory.
>> But we reproduced it quite reliably with small Dom0 sizes like 752MB.
>>
>> XenServer is using this feature to hotplug additional memory for grant
>> table operations so we started a VM and observed a stable hang.
>>
>>>>>> Can we remove "Unusable memory" resources as soon as we finished
>>>>>> booting? Is removing on-demand is preferable over "shoot them all" in
>>>>>> that case?
>>>>> The concern is that in principle nothing prevents someone else to do
>>>>> exact same thing fa564ad96366 did, which is grab something from right
>>>>> above end of RAM as the kernel sees it. And that can be done at any point.
>>>>>
>>>> Nothing prevents - true, but that's plainly wrong from OS point of view
>>>> to grab physical ranges for something without knowing what's actually
>>>> behind on that platform. 
>>> I am not sure I agree that this is plainly wrong. If not for BIOS issues
>>> that 03a551734cf mentions I think what the original implementation of
>>> fa564ad963 did was perfectly reasonable. Which is why I would prefer to
>>> keep keep the hostmem resource *if possible*.
>>>
>> Exactly, those *are* BIOS issues and are not supposed to be workarounded
>> by the OS. And as the next commit showed even the workaround didn't
>> quite helped with it.
>>
>> I agree that having hotmem as a precaution is fine but only if there is
>> a non-cringy way to keep things working with it which I'm not sure does
>> exist.
> 
> We have most of the interfaces in the resource framework to do what we
> want. I put together a semi-working prototype but the tricky part is
> resource locking --- we need to remove a chunk from hostmem (which will
> cause hostmem to be resized and possibly split), and insert this chunk
> to iomem's top level as System RAM, all while holding resource_lock.
> 
> I haven't been able to come up with an acceptable interface for that.
> 
> Given that we are actually broken I guess I am OK with reverting the
> patch, but please make sure this works on AMD boxes (I think family 15h
> is what needs to be tested).
> 

After their last commit I don't see how this can be broken:
1) They only claim addresses starting from 0xbd00000000
*unconditionally* which means if there is some memory behind this range
on the host (regardless if it's Dom0 or native Linux) they'll break
their own systems.

2) So, theoretically, to trigger the original issue we'd need to have a
system with RAM higher than 0xbd00000000 and that shouldn't be assigned
to Dom0 but that contradicts (1).

Igor

>>
>>> -boris
>>>
>>>
>>>> I think we shouldn't consider this as a valid
>>>> thing to do and don't try to workaround initially incorrect code.
>>>>
>>>>> -boris
>>>>>
>>>>>> Does it even make sense to remove the 1-st level only restriction in
>>>>>> kernel/resource.c ?
>>>>>
>> _______________________________________________
>> Xen-devel mailing list
>> Xen-devel@lists.xenproject.org
>> https://lists.xenproject.org/mailman/listinfo/xen-devel
> 
