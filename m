Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E12ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC62B21547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC62B21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390103AbeIUUMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:12:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728313AbeIUUMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:12:30 -0400
Received: from smtp.corp.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 13514C003EB7;
        Fri, 21 Sep 2018 14:23:23 +0000 (UTC)
Received: from [10.36.117.43] (ovpn-117-43.ams2.redhat.com [10.36.117.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A00930912F4;
        Fri, 21 Sep 2018 14:23:19 +0000 (UTC)
Subject: Re: [PATCH V5 4/4] kvm: add a check if pfn is from NVDIMM pmem.
To:     Dan Williams <dan.j.williams@intel.com>,
        KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        Pankaj Gupta <pagupta@redhat.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>, Linux MM <linux-mm@kvack.org>,
        rkrcmar@redhat.com,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
References: <cover.1536342881.git.yi.z.zhang@linux.intel.com>
 <4e8c2e0facd46cfaf4ab79e19c9115958ab6f218.1536342881.git.yi.z.zhang@linux.intel.com>
 <CAPcyv4ifg2BZMTNfu6mg0xxtPWs3BVgkfEj51v1CQ6jp2S70fw@mail.gmail.com>
 <fefbd66e-623d-b6a5-7202-5309dd4f5b32@redhat.com>
 <20180920224953.GA53363@tiger-server>
 <CAPcyv4g6OS=_uSjJenn5WVmpx7zCRCbzJaBr_m0Bq=qyEyVagg@mail.gmail.com>
 <20180921224739.GA33892@tiger-server>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <c8ad8ed7-ca8c-4dd7-819b-8d9c856fbe04@redhat.com>
Date:   Fri, 21 Sep 2018 16:23:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180921224739.GA33892@tiger-server>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.26
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 21 Sep 2018 14:23:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2018 00:47, Yi Zhang wrote:
> On 2018-09-20 at 14:19:17 -0700, Dan Williams wrote:
>> On Thu, Sep 20, 2018 at 7:11 AM Yi Zhang <yi.z.zhang@linux.intel.com> wrote:
>>>
>>> On 2018-09-19 at 09:20:25 +0200, David Hildenbrand wrote:
>>>> Am 19.09.18 um 04:53 schrieb Dan Williams:
>>>>>
>>>>> Should we consider just not setting PageReserved for
>>>>> devm_memremap_pages()? Perhaps kvm is not be the only component making
>>>>> these assumptions about this flag?
>>>>
>>>> I was asking the exact same question in v3 or so.
>>>>
>>>> I was recently going through all PageReserved users, trying to clean up
>>>> and document how it is used.
>>>>
>>>> PG_reserved used to be a marker "not available for the page allocator".
>>>> This is only partially true and not really helpful I think. My current
>>>> understanding:
>>>>
>>>> "
>>>> PG_reserved is set for special pages, struct pages of such pages should
>>>> in general not be touched except by their owner. Pages marked as
>>>> reserved include:
>>>> - Kernel image (including vDSO) and similar (e.g. BIOS, initrd)
>>>> - Pages allocated early during boot (bootmem, memblock)
>>>> - Zero pages
>>>> - Pages that have been associated with a zone but were not onlined
>>>>   (e.g. NVDIMM/pmem, online_page_callback used by XEN)
>>>> - Pages to exclude from the hibernation image (e.g. loaded kexec images)
>>>> - MCA (memory error) pages on ia64
>>>> - Offline pages
>>>> Some architectures don't allow to ioremap RAM pages that are not marked
>>>> as reserved. Allocated pages might have to be set reserved to allow for
>>>> that - if there is a good reason to enforce this. Consequently,
>>>> PG_reserved part of a user space table might be the indicator for the
>>>> zero page, pmem or MMIO pages.
>>>> "
>>>>
>>>> Swapping code does not care about PageReserved at all as far as I
>>>> remember. This seems to be fine as it only looks at the way pages have
>>>> been mapped into user space.
>>>>
>>>> I don't really see a good reason to set pmem pages as reserved. One
>>>> question would be, how/if to exclude them from the hibernation image.
>>>> But that could also be solved differently (we would have to double check
>>>> how they are handled in hibernation code).
>>>>
>>>>
>>>> A similar user of PageReserved to look at is:
>>>>
>>>> drivers/vfio/vfio_iommu_type1.c:is_invalid_reserved_pfn()
>>>>
>>>> It will not mark pages dirty if they are reserved. Similar to KVM code.
>>> Yes, kvm is not the only one user of the dax reserved page.
>>>>
>>>>>
>>>>> Why is MEMORY_DEVICE_PUBLIC memory specifically excluded?
>>>>>
>>>>> This has less to do with "dax" pages and more to do with
>>>>> devm_memremap_pages() established ranges. P2PDMA is another producer
>>>>> of these pages. If either MEMORY_DEVICE_PUBLIC or P2PDMA pages can be
>>>>> used in these kvm paths then I think this points to consider clearing
>>>>> the Reserved flag.
>>>
>>> Thanks Dan/David's comments.
>>> for MEMORY_DEVICE_PUBLIC memory, since host driver could manager the
>>> memory resource to share to guest, Jerome says we could ignore it at
>>> this time.
>>>
>>> And p2pmem, it seems mapped in a PCI bar space which should most likely
>>> a mmio. I think kvm should treated as a reserved page.
>>
>> Ok, but the question you left unanswered is whether it would be better
>> for devm_memremap_pages() to clear the PageReserved flag for
>> MEMORY_DEVICE_{FS,DEV}_DAX rather than introduce a local kvm-only hack
>> for what looks like a global problem.
> 
> Remove the PageReserved flag sounds more reasonable. 
> And Could we still have a flag to identify it is a device private memory, or
> where these pages coming from?

We could use a page type for that or what you proposed. (as I said, we
might have to change hibernation code to skip the pages once we drop the
reserved flag).

-- 

Thanks,

David / dhildenb
