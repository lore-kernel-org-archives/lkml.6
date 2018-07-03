Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB47C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523AE2495A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523AE2495A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934419AbeGCRhI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:37:08 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12016 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934141AbeGCRhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:37:07 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b3bb41e0000>; Tue, 03 Jul 2018 10:36:30 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 03 Jul 2018 10:37:05 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 03 Jul 2018 10:37:05 -0700
Received: from [10.110.48.28] (10.110.48.28) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 3 Jul
 2018 17:37:05 +0000
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
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <3c71556f-1d71-873a-6f74-121865568bf7@nvidia.com>
Date:   Tue, 3 Jul 2018 10:36:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <01000164611dacae-5ac25e48-b845-43ef-9992-fc1047d8e0a0-000000@email.amazonses.com>
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

On 07/03/2018 10:08 AM, Christopher Lameter wrote:
> On Mon, 2 Jul 2018, John Hubbard wrote:
> 
>>> If you establish a reference to a page then increase the page count. If
>>> the reference is a dma pin action also then increase the pinned count.
>>>
>>> That way you know how many of the references to the page are dma
>>> pins and you can correctly manage the state of the page if the dma pins go
>>> away.
>>>
>>
>> I think this sounds like what this patch already does, right? See:
>> __put_page_for_pinned_dma(), __get_page_for_pinned_dma(), and
>> pin_page_for_dma(). The locking seems correct to me, but I suspect it's
>> too heavyweight for such a hot path. But without adding a new put_user_page()
>> call, that was the best I could come up with.
> 
> When I saw the patch it looked like you were avoiding to increment the
> page->count field.

Looking at it again, this patch is definitely susceptible to Jan's "page gets
dma-unpinnned too soon" problem.  That leaves a window in which the original
problem can occur.

The page->_refcount field is used normally, in addition to the dma_pinned_count.
But the problem is that, unless the caller knows what kind of page it is,
the page->dma_pinned_count cannot be looked at, because it is unioned with
page->lru.prev.  page->dma_pinned_flags, at least starting at bit 1, are 
safe to look at due to pointer alignment, but now you cannot atomically 
count...

So this seems unsolvable without having the caller specify that it knows the
page type, and that it is therefore safe to decrement page->dma_pinned_count.
I was hoping I'd found a way, but clearly I haven't. :)


thanks,
-- 
John Hubbard
NVIDIA
