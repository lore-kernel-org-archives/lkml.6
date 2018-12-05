Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F7EC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646C72084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 646C72084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbeLEINw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:13:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbeLEINv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:13:51 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 02D8958E50;
        Wed,  5 Dec 2018 08:13:51 +0000 (UTC)
Received: from [10.36.117.65] (ovpn-117-65.ams2.redhat.com [10.36.117.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CFAF360E3F;
        Wed,  5 Dec 2018 08:13:47 +0000 (UTC)
Subject: Re: [PATCH RFC 2/3] mm: Add support for exposing if dev_pagemap
 supports refcount pinning
To:     Dan Williams <dan.j.williams@intel.com>,
        alexander.h.duyck@linux.intel.com
Cc:     Barret Rhoden <brho@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Zhang Yi <yi.z.zhang@linux.intel.com>,
        KVM list <kvm@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Dave Jiang <dave.jiang@intel.com>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        Pankaj Gupta <pagupta@redhat.com>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>, rkrcmar@redhat.com,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <154386493754.27193.1300965403157243427.stgit@ahduyck-desk1.amr.corp.intel.com>
 <154386513120.27193.7977541941078967487.stgit@ahduyck-desk1.amr.corp.intel.com>
 <CAPcyv4gZkx9zRsKkVhrmPG7SyjPEycp0neFnECmSADZNLuDOpQ@mail.gmail.com>
 <97943d2ed62e6887f4ba51b985ef4fb5478bc586.camel@linux.intel.com>
 <CAPcyv4i=FL4f34H2_1mgWMk=UyyaXFaKPh5zJSnFNyN3cBoJhA@mail.gmail.com>
 <2a3f70b011b56de2289e2f304b3d2d617c5658fb.camel@linux.intel.com>
 <CAPcyv4hPDjHzKd4wTh8Ujv-xL8YsJpcFXOp5ocJ-5fVJZ3=vRw@mail.gmail.com>
 <30ab5fa569a6ede936d48c18e666bc6f718d50db.camel@linux.intel.com>
 <CAPcyv4izGr4dLs_Xpa1wbqJRrHZVEKFWQNb2Qo2Ej_xbEXhbTg@mail.gmail.com>
 <dd7296db5996f15cc3e666d008f209f5f24fa98e.camel@linux.intel.com>
 <20181204182428.11bec385@gnomeregan.cam.corp.google.com>
 <bb141157ac8bc4a99883800d757aa037a7402b10.camel@linux.intel.com>
 <CAPcyv4ix4aHyivwCiw0YNMxLjRJeqDX3x3m1q1JhyMPCEMOJtQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <ee8cc068-903c-d87e-f418-ade46786249e@redhat.com>
Date:   Wed, 5 Dec 2018 09:13:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CAPcyv4ix4aHyivwCiw0YNMxLjRJeqDX3x3m1q1JhyMPCEMOJtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 05 Dec 2018 08:13:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.12.18 01:26, Dan Williams wrote:
> On Tue, Dec 4, 2018 at 4:01 PM Alexander Duyck
> <alexander.h.duyck@linux.intel.com> wrote:
>>
>> On Tue, 2018-12-04 at 18:24 -0500, Barret Rhoden wrote:
>>> Hi -
>>>
>>> On 2018-12-04 at 14:51 Alexander Duyck
>>> <alexander.h.duyck@linux.intel.com> wrote:
>>>
>>> [snip]
>>>
>>>>> I think the confusion arises from the fact that there are a few MMIO
>>>>> resources with a struct page and all the rest MMIO resources without.
>>>>> The problem comes from the coarse definition of pfn_valid(), it may
>>>>> return 'true' for things that are not System-RAM, because pfn_valid()
>>>>> may be something as simplistic as a single "address < X" check. Then
>>>>> PageReserved is a fallback to clarify the pfn_valid() result. The
>>>>> typical case is that MMIO space is not caught up in this linear map
>>>>> confusion. An MMIO address may or may not have an associated 'struct
>>>>> page' and in most cases it does not.
>>>>
>>>> Okay. I think I understand this somewhat now. So the page might be
>>>> physically there, but with the reserved bit it is not supposed to be
>>>> touched.
>>>>
>>>> My main concern with just dropping the bit is that we start seeing some
>>>> other uses that I was not certain what the impact would be. For example
>>>> the functions like kvm_set_pfn_accessed start going in and manipulating
>>>> things that I am not sure should be messed with for a DAX page.
>>>
>>> One thing regarding the accessed and dirty bits is that we might want
>>> to have DAX pages marked dirty/accessed, even if we can't LRU-reclaim
>>> or swap them.  I don't have a real example and I'm fairly ignorant
>>> about the specifics here.  But one possibility would be using the A/D
>>> bits to detect changes to a guest's memory for VM migration.  Maybe
>>> there would be issues with KSM too.
>>>
>>> Barret
>>
>> I get that, but the issue is that the code associated with those bits
>> currently assumes you are working with either an anonymous swap backed
>> page or a page cache page. We should really be updating that logic now,
>> and then enabling DAX to access it rather than trying to do things the
>> other way around which is how this feels.
> 
> Agree. I understand the concern about unintended side effects of
> dropping PageReserved for dax pages, but they simply don't fit the
> definition of the intended use of PageReserved. We've already had
> fallout from legacy code paths doing the wrong thing with dax pages
> where PageReserved wouldn't have helped. For example, see commit
> 6e2608dfd934 "xfs, dax: introduce xfs_dax_aops", or commit
> 6100e34b2526 "mm, memory_failure: Teach memory_failure() about
> dev_pagemap pages". So formerly teaching kvm about these page
> semantics and dropping the reliance on a side effect of PageReserved()
> seems the right direction.
> 
> That said, for mark_page_accessed(), it does not look like it will
> have any effect on dax pages. PageLRU will be false,
> __lru_cache_activate_page() will not find a page on a percpu pagevec,
> and workingset_activation() won't find an associated memcg. I would
> not be surprised if mark_page_accessed() is already being called today
> via the ext4 + dax use case.
> 

I agree to what Dan says here. I'd vote for getting rid of the
PageReserved bit for these pages and rather fixing the fallout from that
(if any, I also doubt that there will be much). One thing I already
mentioned in another thread is hindering hibernation code from touching
ZONE_DEVICE memory is one thing to take care of.

PageReserved as part of a user space process can mean many things (and I
still have a patch pending for submission to document that). It can mean
zero pages, VDSO pages, MMIO pages and right now DAX pages. For the
first three, we don't want to touch the struct page ever
(->PageReserved). For DAX it should not harm (-> no need for PageReserved).

-- 

Thanks,

David / dhildenb
