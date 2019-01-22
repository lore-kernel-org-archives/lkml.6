Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACAFC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7566A20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfAVLpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:45:04 -0500
Received: from foss.arm.com ([217.140.101.70]:51798 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbfAVLpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:45:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72E1DA78;
        Tue, 22 Jan 2019 03:45:03 -0800 (PST)
Received: from [10.37.12.103] (unknown [10.37.12.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A081B3F6A8;
        Tue, 22 Jan 2019 03:45:00 -0800 (PST)
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
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <34a31bc8-96c6-2801-689c-3c4498b68ee8@arm.com>
Date:   Tue, 22 Jan 2019 11:44:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <79ac0743-68bc-c2b7-d843-cf152c40d583@epam.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/22/19 10:28 AM, Oleksandr Andrushchenko wrote:
> Hello, Julien!

Hi,

> On 1/21/19 7:09 PM, Julien Grall wrote:
> Well, I didn't get the attributes of pages at the backend side, but IMO
> those
> do not matter in my use-case (for simplicity I am not using zero-copying at
> backend side):

They are actually important no matter what is your use case. If you 
access the same physical page with different attributes, then you are 
asking for trouble.

This is why Xen imposes all the pages shared to have their memory 
attributes following some rules. Actually, speaking with Mark R., we may 
want to tight a bit more the attributes.

> 
> 1. Frontend device allocates display buffer pages which come from shmem
> and have these attributes:
> !PTE_RDONLY + PTE_PXN + PTE_SHARED + PTE_AF + PTE_UXN +
> PTE_ATTRINDX(MT_NORMAL)

My knowledge of Xen DRM is inexistent. However, looking at the code in 
5.0-rc2, I don't seem to find the same attributes. For instance 
xen_drm_front_gem_prime_vmap and gem_mmap_obj are using 
pgprot_writecombine. So it looks like, the mapping will be non-cacheable 
on Arm64.

Can you explain how you came up to these attributes?

> 
> 2. Frontend grants references to these pages and shares those with the
> backend
> 
> 3. Backend is a user-space application (Weston client), so it uses
> gntdev kernel
> driver to mmap the pages. The pages, which are used by gntdev, are those
> coming
> from the Xen balloon driver and I believe they are all normal memory and
> shouldn't be non-cached.
> 
> 4. Once the frontend starts displaying it flips the buffers and backend
> does *memcpy*
> from the frontend-backend shared buffer into Weston's buffer. This means
> no HW at the backend side touches the shared buffer.
> 
> 5. I can see distorted picture.
> 
> Previously I used setup with zero-copying, so then the picture becomes
> more complicated
> in terms of buffers and how those used by the backed, but anyways it
> seems that the
> very basic scenario with memory copying doesn't work for me.
> 
> Using DMA API on frontend's side does help - no artifacts are seen.
> This is why I'm thinking that this is related to frontend/kernel side
> rather then to
> the backend side. This is why I'm thinking this is related to caches and
> trying to figure
> out what can be done here instead of using DMA API.

We actually never required to use cache flush in other PV protocol, so I 
still don't understand why the PV DRM should be different here.

To me, it looks like that you are either missing some barriers or the 
memory attributes are not correct.

Cheers,

-- 
Julien Grall
