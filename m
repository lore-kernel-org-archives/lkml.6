Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42491C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 20:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B3920864
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 20:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B3920864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934390AbeFQU2m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 16:28:42 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10978 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933744AbeFQU2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 16:28:40 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b26c4640000>; Sun, 17 Jun 2018 13:28:20 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 17 Jun 2018 13:28:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 17 Jun 2018 13:28:44 -0700
Received: from [10.2.175.123] (10.2.175.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Sun, 17 Jun
 2018 20:28:39 +0000
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
To:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC:     <john.hubbard@gmail.com>, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>, Jan Kara <jack@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20180617012510.20139-1-jhubbard@nvidia.com>
 <20180617012510.20139-3-jhubbard@nvidia.com>
 <CAPcyv4i=eky-QrPcLUEqjsASuRUrFEWqf79hWe0mU8xtz6Jk-w@mail.gmail.com>
 <20180617200432.krw36wrcwidb25cj@ziepe.ca>
 <CAPcyv4gayKk_zHDYAvntware12qMXWjnnL_FDJNUQsJS_zNfDw@mail.gmail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <311eba48-60f1-b6cc-d001-5cc3ed4d76a9@nvidia.com>
Date:   Sun, 17 Jun 2018 13:28:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4gayKk_zHDYAvntware12qMXWjnnL_FDJNUQsJS_zNfDw@mail.gmail.com>
X-Originating-IP: [10.2.175.123]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/17/2018 01:10 PM, Dan Williams wrote:
> On Sun, Jun 17, 2018 at 1:04 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>> On Sun, Jun 17, 2018 at 12:53:04PM -0700, Dan Williams wrote:
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index 6db729dc4c50..37576f0a4645 100644
>>>> +++ b/mm/rmap.c
>>>> @@ -1360,6 +1360,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>>>                                 flags & TTU_SPLIT_FREEZE, page);
>>>>         }
>>>>
>>>> +       if (PageDmaPinned(page))
>>>> +               return false;
>>>>         /*
>>>>          * We have to assume the worse case ie pmd for invalidation. Note that
>>>>          * the page can not be free in this function as call of try_to_unmap()
>>>
>>> We have a similiar problem with DAX and the conclusion we came to is
>>> that it is not acceptable for userspace to arbitrarily block kernel
>>> actions. The conclusion there was: 'wait' if the DMA is transient, and
>>> 'revoke' if the DMA is long lived, or otherwise 'block' long-lived DMA
>>> if a revocation mechanism is not available.
>>
>> This might be the right answer for certain things, but it shouldn't be
>> the immediate reaction to everthing. There are many user APIs that
>> block kernel actions and hold kernel resources.
>>
>> IMHO, there should be an identifiable objection, eg is blocking going
>> to create a DOS, dead-lock, insecurity, etc?
> 
> I believe kernel behavior regression is a primary concern as now
> fallocate() and truncate() can randomly fail where they didn't before.
> 

Yes. However, my thinking was: get_user_pages() can become a way to indicate that 
these pages are going to be treated specially. In particular, the caller
does not really want or need to support certain file operations, while the
page is flagged this way.

If necessary, we could add a new API call. But either way, I think we could
reasonably document that "if you pin these pages (either via get_user_pages,
or some new, similar-looking API call), you can DMA to/from them, and safely
mark them as dirty when you're done, and the right things will happen. 
And in the interim, you can expect that the follow file system API calls
will not behave predictably: fallocate, truncate, ..."

Maybe in the near future, we can remove that last qualification, if we
find a more comprehensive design for this (as opposed to this cheap fix
I'm proposing here).

