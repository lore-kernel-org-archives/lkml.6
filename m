Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B96C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05D7206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05D7206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504151AbeKWWzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 17:55:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43700 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388020AbeKWWzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 17:55:31 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CD3A330041F2;
        Fri, 23 Nov 2018 12:11:32 +0000 (UTC)
Received: from [10.36.118.36] (unknown [10.36.118.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3733160BE5;
        Fri, 23 Nov 2018 12:11:30 +0000 (UTC)
Subject: Re: [RFC PATCH 0/4] mm, memory_hotplug: allocate memmap from hotadded
 memory
Cc:     linux-mm@kvack.org, mhocko@suse.com, rppt@linux.vnet.ibm.com,
        akpm@linux-foundation.org, arunks@codeaurora.org, bhe@redhat.com,
        dan.j.williams@intel.com, Pavel.Tatashin@microsoft.com,
        Jonathan.Cameron@huawei.com, jglisse@redhat.com,
        linux-kernel@vger.kernel.org
References: <20181116101222.16581-1-osalvador@suse.com>
 <2571308d-0460-e8b9-ad40-75d6b13b2d09@redhat.com>
 <20181123115519.2dnzscmmgv63fdub@d104.suse.de>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
To:     Oscar Salvador <osalvador@suse.com>
Message-ID: <729f2126-c4ba-e764-3c71-7bd711e44187@redhat.com>
Date:   Fri, 23 Nov 2018 13:11:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181123115519.2dnzscmmgv63fdub@d104.suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 23 Nov 2018 12:11:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.11.18 12:55, Oscar Salvador wrote:
> On Thu, Nov 22, 2018 at 10:21:24AM +0100, David Hildenbrand wrote:
>> 1. How are we going to present such memory to the system statistics?
>>
>> In my opinion, this vmemmap memory should
>> a) still account to total memory
>> b) show up as allocated
>>
>> So just like before.
> 
> No, it does not show up under total memory and neither as allocated memory.
> This memory is not for use for anything but for creating the pagetables
> for the memmap array for the section/s.
> 
> It is not memory that the system can use.
> 
> I also guess that if there is a strong opinion on this, we could create
> a counter, something like NR_VMEMMAP_PAGES, and show it under /proc/meminfo.

It's a change if we "hide" such memory. E.g. in a cloud environment you
request to add XGB to your system. You will not see XGB, that can be
"problematic" with some costumers :) - "But I am paying for additional
XGB". (Showing XGB but YMB as allocated is easier to argue with - "your
OS is using it").

> 
>> 2. Is this optional, in other words, can a device driver decide to not
>> to it like that?
> 
> Right now, is a per arch setup.
> For example, x86_64/powerpc/arm64 will do it inconditionally.

That could indeed break Hyper-V/XEN (if the granularity in which you can
add memory can be smaller than 2MB). Or you have bigger memory blocks.

> 
> If we want to restrict this a per device-driver thing, I guess that we could
> allow to pass a flag to add_memory()->add_memory_resource(), and there
> unset MHP_MEMMAP_FROM_RANGE in case that flag is enabled.
> 
>> You mention ballooning. Now, both XEN and Hyper-V (the only balloon
>> drivers that add new memory as of now), usually add e.g. a 128MB segment
>> to only actually some part of it (e.g. 64MB, but could vary). Now, going
>> ahead and assuming that all memory of a section can be read/written is
>> wrong. A device driver will indicate which pages may actually be used
>> via set_online_page_callback() when new memory is added. But at that
>> point you already happily accessed some memory for vmmap - which might
>> lead to crashes.
>>
>> For now the rule was: Memory that was not onlined will not be
>> read/written, that's why it works for XEN and Hyper-V.
> 
> We do not write all memory of the hot-added section, we just write the
> first 2MB (first 512 pages), the other 126MB are left untouched.

Then that has to be made a rule and we have to make sure that all users
(Hyper-V/XEN) can cope with that.

But it is more problematic because we could have 2GB memory blocks. Then
the 2MB rule does no longer strike. Other archs have other sizes (e.g.
s390x 256MB).

> 
> Assuming that you add a memory-chunk section aligned (128MB), but you only present
> the first 64MB or 32MB to the guest as onlined, we still need to allocate the memmap
> for the whole section.

Yes, that's the right thing to do. (the section will be online but some
parts "fake offline")

> 
> I do not really know the tricks behind Hyper-V/Xen, could you expand on that?

Let's say you want to add 64MB on Hyper-V. What Linux will do is add a
new section (128MB) but only actually online, say the first 64MB (I have
no idea if it has to be the first 64MB actually!).

It will keep the other pages "fake-offline" and online them later on
when e.g. adding another 64MB.

See drivers/hv/hv_balloon.c:
- set_online_page_callback(&hv_online_page);
- hv_bring_pgs_online() -> hv_page_online_one() -> has_pfn_is_backed()

The other 64MB must not be written (otherwise GP!) but eventually be
read for e.g. dumping (although that is also shaky and I am fixing that
right now to make it more reliable).

Long story short: It is better to allow device drivers to make use of
the old behavior until they eventually can make sure that the "altmap?"
can be read/written when adding memory.

It presents a major change in the add_memory() interface.

> 
> So far I only tested this with qemu simulating large machines, but I plan
> to try the balloning thing on Xen.
> 
> At this moment I am working on a second version of this patchset
> to address Dave's feedback.

Cool, keep me tuned :)

> 
> ----
> Oscar Salvador
> SUSE L3 
> 


-- 

Thanks,

David / dhildenb
