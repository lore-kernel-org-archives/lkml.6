Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA391C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71EAF217AE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71EAF217AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934631AbeGCStc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:49:32 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:16560 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934488AbeGCSta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:49:30 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b3bc53a0000>; Tue, 03 Jul 2018 11:49:30 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 03 Jul 2018 11:49:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 03 Jul 2018 11:49:29 -0700
Received: from [10.110.48.28] (10.110.48.28) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 3 Jul
 2018 18:49:29 +0000
Subject: Re: [PATCH v2 5/6] mm: track gup pages with page->dma_pinned_* fields
To:     Christopher Lameter <cl@linux.com>
CC:     Jan Kara <jack@suse.cz>, <john.hubbard@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20180702005654.20369-1-jhubbard@nvidia.com>
 <20180702005654.20369-6-jhubbard@nvidia.com>
 <20180702095331.n5zfz35d3invl5al@quack2.suse.cz>
 <bb798475-ebf3-7b02-409f-8c4347fa6674@nvidia.com>
 <010001645d77ee2c-de7fedbd-f52d-4b74-9388-e6435973792b-000000@email.amazonses.com>
 <f01666d5-8da1-7bea-adfb-c3571a54587a@nvidia.com>
 <01000164611dacae-5ac25e48-b845-43ef-9992-fc1047d8e0a0-000000@email.amazonses.com>
 <3c71556f-1d71-873a-6f74-121865568bf7@nvidia.com>
 <0100016461425062-724aa9d3-d7c1-4fa2-a87b-dc59cc5f7800-000000@email.amazonses.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <2e18c1a3-08a3-abaf-1721-89bc527579ab@nvidia.com>
Date:   Tue, 3 Jul 2018 11:48:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <0100016461425062-724aa9d3-d7c1-4fa2-a87b-dc59cc5f7800-000000@email.amazonses.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2018 10:48 AM, Christopher Lameter wrote:
> On Tue, 3 Jul 2018, John Hubbard wrote:
> 
>> The page->_refcount field is used normally, in addition to the dma_pinned_count.
>> But the problem is that, unless the caller knows what kind of page it is,
>> the page->dma_pinned_count cannot be looked at, because it is unioned with
>> page->lru.prev.  page->dma_pinned_flags, at least starting at bit 1, are
>> safe to look at due to pointer alignment, but now you cannot atomically
>> count...
>>
>> So this seems unsolvable without having the caller specify that it knows the
>> page type, and that it is therefore safe to decrement page->dma_pinned_count.
>> I was hoping I'd found a way, but clearly I haven't. :)
> 
> Try to find some way to indicate that the page is pinned by using some of
> the existing page flags? There is already an MLOCK flag. Maybe some
> creativity with that can lead to something (but then the MLOCKed pages are
> on the unevictable LRU....). cgroups used to have something called struct
> page_ext. Oh its there in linux/mm/page_ext.c.
> 

Yes, that would provide just a touch more cabability: we could both read and
write a dma-pinned page(_ext) flag safely, instead of only being able to just 
read.  I'm doubt that that's enough additional information, though. The general
problem of allowing random put_page() calls to decrement the dma-pinned count (see
Jan's diagram at the beginning of this thread) cannot be solved by anything less
than some sort of "who (or which special type of caller, at least) owns this page"
approach, as far as I can see. The put_user_pages() provides arguably the simplest 
version of that kind of solution.

Also, even just using a single bit from page extensions would cost some extra memory, 
because for example on 64-bit systems many configurations do not need the additional 
flags that page_ext.h provides, so they return "false" from the page_ext_operations.need() 
callback. Changing get_user_pages to require page extensions would lead to
*every* configuration requiring page extensions, so 64-bit users would lose some memory
for sure. On the other hand, it avoids the "take page off of the LRU" complexity that 
I've got here. But again, I don't think a single flag, or even a count, would actually 
solve the problem.


