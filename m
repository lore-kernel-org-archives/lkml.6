Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F754C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACFD21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfAXPCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:02:18 -0500
Received: from foss.arm.com ([217.140.101.70]:58174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727755AbfAXPCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:02:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98320A78;
        Thu, 24 Jan 2019 07:02:17 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80B093F5AF;
        Thu, 24 Jan 2019 07:02:15 -0800 (PST)
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
 <9e0130ee-0418-f68c-94cf-31a5566d929a@arm.com>
 <79ac0743-68bc-c2b7-d843-cf152c40d583@epam.com>
 <34a31bc8-96c6-2801-689c-3c4498b68ee8@arm.com>
 <b0cfe533-5b0b-e20f-eeab-2ce743914c98@epam.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <e5193e96-a80e-23fd-c833-447d6a2a1574@arm.com>
Date:   Thu, 24 Jan 2019 15:02:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <b0cfe533-5b0b-e20f-eeab-2ce743914c98@epam.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/01/2019 14:34, Oleksandr Andrushchenko wrote:
> Hello, Julien!

Hi,

> On 1/22/19 1:44 PM, Julien Grall wrote:
>>
>>
>> On 1/22/19 10:28 AM, Oleksandr Andrushchenko wrote:
>>> Hello, Julien!
>>
>> Hi,
>>
>>> On 1/21/19 7:09 PM, Julien Grall wrote:
>>> Well, I didn't get the attributes of pages at the backend side, but IMO
>>> those
>>> do not matter in my use-case (for simplicity I am not using
>>> zero-copying at
>>> backend side):
>>
>> They are actually important no matter what is your use case. If you
>> access the same physical page with different attributes, then you are
>> asking for trouble.
> So, we have:
> 
> DomU: frontend side
> ====================
> !PTE_RDONLY + PTE_PXN + PTE_SHARED + PTE_AF + PTE_UXN +
> PTE_ATTRINDX(MT_NORMAL)

I still don't understand how you came up with MT_NORMAL when you seem to confirm...

> 
> DomD: backend side
> ====================
> PTE_USER + !PTE_RDONLY + PTE_PXN + PTE_NG + PTE_CONT + PTE_TABLE_BIT +
> PTE_UXN + PTE_ATTRINDX(MT_NORMAL)
> 
>   From the above it seems that I don't violate cached/non-cached
> agreement here
>>
>> This is why Xen imposes all the pages shared to have their memory
>> attributes following some rules. Actually, speaking with Mark R., we
>> may want to tight a bit more the attributes.
>>
>>>
>>> 1. Frontend device allocates display buffer pages which come from shmem
>>> and have these attributes:
>>> !PTE_RDONLY + PTE_PXN + PTE_SHARED + PTE_AF + PTE_UXN +
>>> PTE_ATTRINDX(MT_NORMAL)
>>
>> My knowledge of Xen DRM is inexistent. However, looking at the code in
>> 5.0-rc2, I don't seem to find the same attributes. For instance
>> xen_drm_front_gem_prime_vmap and gem_mmap_obj are using
>> pgprot_writecombine. So it looks like, the mapping will be
>> non-cacheable on Arm64.
>>
>> Can you explain how you came up to these attributes?
> pgprot_writecombine is PTE_ATTRINDX(MT_NORMAL_NC), so it seems to be
> applicable here? [1]

... that MT_NORMAL_NC is used for the frontend pages.

MT_NORMAL_NC is different from MT_NORMAL. The use of the former will result to 
non-cacheable memory while the latter will result to cacheable memory.

To me, this looks like the exact reason why you see artifact on the display 
buffer. As the author of this code, can you explain why you decided to use 
pgprot_writecombine here instead of relying on the default VMA prot?

[...]

>> We actually never required to use cache flush in other PV protocol, so
>> I still don't understand why the PV DRM should be different here.
> Well, you are right. But at the same time not flushing the buffer makes
> troubles,
> so this is why I am trying to figure out what is wrong here.

The cache flush is likely hiding the real problem rather than solving it.

>>
>> To me, it looks like that you are either missing some barriers
> Barriers for the buffer? Not sure what you mean here.

If you share information between two entities, you may need some ordering so the 
information are seen consistently by the consumer side. This can be achieved by 
using barriers.

> Even more, we have
> a use case
> when the buffer is not touched by CPU in DomD and is solely owned by the HW.

Memory ordering issues are subtle. The fact that one of your use-case works does 
not imply that barriers are not necessary. I am not saying there are a missing 
barriers, I am only pointed out potential reasons.

Anyway, I don't think your problem is a missing barriers here. It is more likely 
because of mismatch memory attributes (see above).

Cheers,

-- 
Julien Grall
