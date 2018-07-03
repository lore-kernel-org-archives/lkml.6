Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4FAC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9549B24C21
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 04:31:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9549B24C21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753950AbeGCEbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 00:31:02 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17523 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753484AbeGCEbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 00:31:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b3afc010000>; Mon, 02 Jul 2018 21:30:57 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 02 Jul 2018 21:31:00 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 02 Jul 2018 21:31:00 -0700
Received: from [10.2.169.219] (10.2.169.219) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 3 Jul
 2018 04:30:59 +0000
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
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <f01666d5-8da1-7bea-adfb-c3571a54587a@nvidia.com>
Date:   Mon, 2 Jul 2018 21:30:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <010001645d77ee2c-de7fedbd-f52d-4b74-9388-e6435973792b-000000@email.amazonses.com>
X-Originating-IP: [10.2.169.219]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 05:08 PM, Christopher Lameter wrote:
> On Mon, 2 Jul 2018, John Hubbard wrote:
> 
>>>
>>> These two are just wrong. You cannot make any page reference for
>>> PageDmaPinned() account against a pin count. First, it is just conceptually
>>> wrong as these references need not be long term pins, second, you can
>>> easily race like:
>>>
>>> Pinner				Random process
>>> 				get_page(page)
>>> pin_page_for_dma()
>>> 				put_page(page)
>>> 				 -> oops, page gets unpinned too early
>>>
>>
>> I'll drop this approach, without mentioning any of the locking that is hiding in
>> there, since that was probably breaking other rules anyway. :) Thanks for your
>> patience in reviewing this.
> 
> Mayb the following would work:
> 
> If you establish a reference to a page then increase the page count. If
> the reference is a dma pin action also then increase the pinned count.
> 
> That way you know how many of the references to the page are dma
> pins and you can correctly manage the state of the page if the dma pins go
> away.
> 

I think this sounds like what this patch already does, right? See:
__put_page_for_pinned_dma(), __get_page_for_pinned_dma(), and 
pin_page_for_dma(). The locking seems correct to me, but I suspect it's 
too heavyweight for such a hot path. But without adding a new put_user_page()
call, that was the best I could come up with.

What I'm hearing now from Jan and Michal is that the desired end result is
a separate API call, put_user_pages(), so that we can explicitly manage
these pinned pages.

thanks,
-- 
John Hubbard
NVIDIA
