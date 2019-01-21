Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A536C31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC7B20879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfAURJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:09:44 -0500
Received: from foss.arm.com ([217.140.101.70]:39378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfAURJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:09:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C679615AB;
        Mon, 21 Jan 2019 09:09:43 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1B0F3F614;
        Mon, 21 Jan 2019 09:09:41 -0800 (PST)
Subject: Re: [Xen-devel] [PATCH v2] drm/xen-front: Make shmem backed display
 buffer coherent
To:     Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "jgross@suse.com" <jgross@suse.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "noralf@tronnes.org" <noralf@tronnes.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "daniel.vetter@intel.com" <daniel.vetter@intel.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20190115140420.4652-1-andr2000@gmail.com>
 <20190116063002.jq3aas6ofhaogmyk@sirius.home.kraxel.org>
 <20190116063631.GA10881@infradead.org>
 <042fe794-dec6-6d9d-5b68-6f142790f5c7@epam.com>
 <20190117091815.GA7090@infradead.org>
 <1cfc5cb4-e481-5d71-29df-958db76fb681@epam.com>
 <2ed681b9-c8d4-ea27-6b8b-e399ed034bda@arm.com>
 <b5ee0d1c-7888-28c4-c5ae-7984c5e54c8e@epam.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <9e0130ee-0418-f68c-94cf-31a5566d929a@arm.com>
Date:   Mon, 21 Jan 2019 17:09:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <b5ee0d1c-7888-28c4-c5ae-7984c5e54c8e@epam.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 21/01/2019 12:43, Oleksandr Andrushchenko wrote:
> On 1/18/19 1:43 PM, Julien Grall wrote:
>> On 18/01/2019 09:40, Oleksandr Andrushchenko wrote:
>>> On 1/17/19 11:18 AM, Christoph Hellwig wrote:
>>>> On Wed, Jan 16, 2019 at 06:43:29AM +0000, Oleksandr Andrushchenko
>>>> wrote:
>>>>>> This whole issue keeps getting more and more confusing.
>>>>> Well, I don't really do DMA here, but instead the buffers in
>>>>> question are shared with other Xen domain, so effectively it
>>>>> could be thought of some sort of DMA here, where the "device" is
>>>>> that remote domain. If the buffers are not flushed then the
>>>>> remote part sees some inconsistency which in my case results
>>>>> in artifacts on screen while displaying the buffers.
>>>>> When buffers are allocated via DMA API then there are no artifacts;
>>>>> if buffers are allocated with shmem + DMA mapping then there are no
>>>>> artifacts as well.
>>>>> The only offending use-case is when I use shmem backed buffers,
>>>>> but do not flush them
>>>> The right answer would be to implement cache maintainance hooks for
>>>> this case in the Xen arch code.  These would basically look the same
>>>> as the low-level cache maintainance used by the DMA ops, but without
>>>> going through the DMA mapping layer, in fact they should probably
>>>> reuse the same low-level assembly routines.
>>>>
>>>> I don't think this is the first usage of such Xen buffer sharing, so
>>>> what do the other users do?
>>> I'll have to get even deeper into it. Initially I
>>> looked at the code, but didn't find anything useful.
>>> Or maybe I have just overlooked obvious things there
>>  From Xen on Arm ABI:
>>
>> "All memory which is shared with other entities in the system
>> (including the hypervisor and other guests) must reside in memory
>> which is mapped as Normal Inner Write-Back Outer Write-Back
>> Inner-Shareable.
>> This applies to:
>>    - hypercall arguments passed via a pointer to guest memory.
>>    - memory shared via the grant table mechanism (including PV I/O
>>      rings etc).
>>    - memory shared with the hypervisor (struct shared_info, struct
>>      vcpu_info, the grant table, etc).
>> "
>>
>> So you should not need any cache maintenance here. Can you provide
>> more details on the memory attribute you use for memory shared in both
>> the backend and frontend?
>>
> It takes quite some time to collect this (because many components are
> involved in the
> use-case), but for now the pages in the guest domain are:
> !PTE_RDONLY + PTE_PXN + PTE_SHARED + PTE_AF + PTE_UXN +
> PTE_ATTRINDX(MT_NORMAL)

So that's the attribute for the page mapped in the frontend, right? How about 
the backend side?

Also, could that page be handed to the graphic card correctly? If so, is your 
graphic card coherent?

If one of your components is mapping with non-cacheable attributes then you are 
already not following the Xen Arm ABI. In that case, we would need to discuss 
how to extend the ABI.

Cheers,

-- 
Julien Grall
