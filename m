Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267CFC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97C52075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 21:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97C52075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935908AbeFRVhk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 17:37:40 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14103 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754227AbeFRVhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 17:37:38 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b2826240002>; Mon, 18 Jun 2018 14:37:40 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 18 Jun 2018 14:37:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 18 Jun 2018 14:37:42 -0700
Received: from [10.110.48.28] (10.110.48.28) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 18 Jun
 2018 21:37:37 +0000
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <john.hubbard@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>, Jan Kara <jack@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <20180617012510.20139-1-jhubbard@nvidia.com>
 <20180617012510.20139-3-jhubbard@nvidia.com>
 <CAPcyv4i=eky-QrPcLUEqjsASuRUrFEWqf79hWe0mU8xtz6Jk-w@mail.gmail.com>
 <20180617200432.krw36wrcwidb25cj@ziepe.ca>
 <CAPcyv4gayKk_zHDYAvntware12qMXWjnnL_FDJNUQsJS_zNfDw@mail.gmail.com>
 <311eba48-60f1-b6cc-d001-5cc3ed4d76a9@nvidia.com>
 <20180618081258.GB16991@lst.de>
 <d4817192-6db0-2f3f-7c67-6078b69686d3@nvidia.com>
 <CAPcyv4iacHYxGmyWokFrVsmxvLj7=phqp2i0tv8z6AT-mYuEEA@mail.gmail.com>
 <3898ef6b-2fa0-e852-a9ac-d904b47320d5@nvidia.com>
 <CAPcyv4iRBzmwWn_9zDvqdfVmTZL_Gn7uA_26A1T-kJib=84tvA@mail.gmail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <0e6053b3-b78c-c8be-4fab-e8555810c732@nvidia.com>
Date:   Mon, 18 Jun 2018 14:36:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4iRBzmwWn_9zDvqdfVmTZL_Gn7uA_26A1T-kJib=84tvA@mail.gmail.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18/2018 12:21 PM, Dan Williams wrote:
> On Mon, Jun 18, 2018 at 11:14 AM, John Hubbard <jhubbard@nvidia.com> wrote:
>> On 06/18/2018 10:56 AM, Dan Williams wrote:
>>> On Mon, Jun 18, 2018 at 10:50 AM, John Hubbard <jhubbard@nvidia.com> wrote:
>>>> On 06/18/2018 01:12 AM, Christoph Hellwig wrote:
>>>>> On Sun, Jun 17, 2018 at 01:28:18PM -0700, John Hubbard wrote:
>>>>>> Yes. However, my thinking was: get_user_pages() can become a way to indicate that
>>>>>> these pages are going to be treated specially. In particular, the caller
>>>>>> does not really want or need to support certain file operations, while the
>>>>>> page is flagged this way.
>>>>>>
>>>>>> If necessary, we could add a new API call.
>>>>>
>>>>> That API call is called get_user_pages_longterm.
>>>>
>>>> OK...I had the impression that this was just semi-temporary API for dax, but
>>>> given that it's an exported symbol, I guess it really is here to stay.
>>>
>>> The plan is to go back and provide api changes that bypass
>>> get_user_page_longterm() for RDMA. However, for VFIO and others, it's
>>> not clear what we could do. In the VFIO case the guest would need to
>>> be prepared handle the revocation.
>>
>> OK, let's see if I understand that plan correctly:
>>
>> 1. Change RDMA users (this could be done entirely in the various device drivers'
>> code, unless I'm overlooking something) to use mmu notifiers, and to do their
>> DMA to/from non-pinned pages.
> 
> The problem with this approach is surprising the RDMA drivers with
> notifications of teardowns. It's the RDMA userspace applications that
> need the notification, and it likely needs to be explicit opt-in, at
> least for the non-ODP drivers.
> 
>> 2. Return early from get_user_pages_longterm, if the memory is...marked for
>> RDMA? (How? Same sort of page flag that I'm floating here, or something else?)
>> That would avoid the problem with pinned pages getting their buffer heads
>> removed--by disallowing the pinning. Makes sense.
> 
> Well, right now the RDMA workaround is DAX specific and it seems we
> need to generalize it for the page-cache case. One thought is to have
> try_to_unmap() take it's own reference and wait for the page reference
> count to drop to one so that the truncate path knows the page is
> dma-idle and disconnected from the page cache, but I have not looked
> at the details.
> 
>> Also, is there anything I can help with here, so that things can happen sooner?
> 
> I do think we should explore a page flag for pages that are "long
> term" pinned. Michal asked for something along these lines at LSF / MM
> so that the core-mm can give up on pages that the kernel has lost
> lifetime control. Michal, did I capture your ask correctly?


OK, that "refcount == 1" approach sounds promising:

   -- still use a page flag, but narrow the scope to get_user_pages_longterm() pages
   -- just wait in try_to_unmap, instead of giving up

I'll look into it, while waiting for Michal's thoughts on this.

