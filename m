Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CA0C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD6625221
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD6625221
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753047AbeGBGmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 02:42:31 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16326 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752766AbeGBGmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 02:42:23 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b39c94c0000>; Sun, 01 Jul 2018 23:42:20 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 01 Jul 2018 23:42:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 01 Jul 2018 23:42:22 -0700
Received: from [10.110.48.28] (10.110.48.28) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 2 Jul
 2018 06:42:21 +0000
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
To:     Leon Romanovsky <leon@kernel.org>
CC:     Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <john.hubbard@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <20180627113221.GO32348@dhcp22.suse.cz>
 <20180627115349.cu2k3ainqqdrrepz@quack2.suse.cz>
 <20180627115927.GQ32348@dhcp22.suse.cz>
 <20180627124255.np2a6rxy6rb6v7mm@quack2.suse.cz>
 <20180627145718.GB20171@ziepe.ca>
 <20180627170246.qfvucs72seqabaef@quack2.suse.cz>
 <1f6e79c5-5801-16d2-18a6-66bd0712b5b8@nvidia.com>
 <20180628091743.khhta7nafuwstd3m@quack2.suse.cz>
 <20180702055251.GV3014@mtr-leonro.mtl.com>
 <235a23e3-6e02-234c-3e20-b2dddc93e568@nvidia.com>
 <20180702063403.GX3014@mtr-leonro.mtl.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <cd6ec2d7-0c19-fb34-e8d3-0459671432b8@nvidia.com>
Date:   Sun, 1 Jul 2018 23:41:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702063403.GX3014@mtr-leonro.mtl.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2018 11:34 PM, Leon Romanovsky wrote:
> On Sun, Jul 01, 2018 at 11:10:04PM -0700, John Hubbard wrote:
>> On 07/01/2018 10:52 PM, Leon Romanovsky wrote:
>>> On Thu, Jun 28, 2018 at 11:17:43AM +0200, Jan Kara wrote:
>>>> On Wed 27-06-18 19:42:01, John Hubbard wrote:
>>>>> On 06/27/2018 10:02 AM, Jan Kara wrote:
>>>>>> On Wed 27-06-18 08:57:18, Jason Gunthorpe wrote:
>>>>>>> On Wed, Jun 27, 2018 at 02:42:55PM +0200, Jan Kara wrote:
>>>>>>>> On Wed 27-06-18 13:59:27, Michal Hocko wrote:
>>>>>>>>> On Wed 27-06-18 13:53:49, Jan Kara wrote:
>>>>>>>>>> On Wed 27-06-18 13:32:21, Michal Hocko wrote:
>>>>>>>>> [...]
>>>>> One question though: I'm still vague on the best actions to take in the
>>>>> following functions:
>>>>>
>>>>>     page_mkclean_one
>>>>>     try_to_unmap_one
>>>>>
>>>>> At the moment, they are both just doing an evil little early-out:
>>>>>
>>>>> 	if (PageDmaPinned(page))
>>>>> 		return false;
>>>>>
>>>>> ...but we talked about maybe waiting for the condition to clear, instead?
>>>>> Thoughts?
>>>>
>>>> What needs to happen in page_mkclean() depends on the caller. Most of the
>>>> callers really need to be sure the page is write-protected once
>>>> page_mkclean() returns. Those are:
>>>>
>>>>   pagecache_isize_extended()
>>>>   fb_deferred_io_work()
>>>>   clear_page_dirty_for_io() if called for data-integrity writeback - which
>>>>     is currently known only in its caller (e.g. write_cache_pages()) where
>>>>     it can be determined as wbc->sync_mode == WB_SYNC_ALL. Getting this
>>>>     information into page_mkclean() will require some plumbing and
>>>>     clear_page_dirty_for_io() has some 50 callers but it's doable.
>>>>
>>>> clear_page_dirty_for_io() for cleaning writeback (wbc->sync_mode !=
>>>> WB_SYNC_ALL) can just skip pinned pages and we probably need to do that as
>>>> otherwise memory cleaning would get stuck on pinned pages until RDMA
>>>> drivers release its pins.
>>>
>>> Sorry for naive question, but won't it create too much dirty pages
>>> so writeback will be called "non-stop" to rebalance watermarks without
>>> ability to progress?
>>>
>>
>> That is an interesting point.
>>
>> Holding off page writeback of this region does seem like it could cause
>> problems under memory pressure. Maybe adjusting the watermarks so that we
>> tell the writeback  system, "all is well, just ignore this region until
>> we're done with it" might help? Any ideas here are welcome...
> 
> AFAIR, it is per-zone, so the solution to count dirty-but-untouchable
> number of pages to take them into account for accounting can work, but
> it seems like an overkill. Can we create special ZONE for such gup
> pages, or this is impossible too?
> 

Let's see what Michal and others prefer. The zone idea intrigues me. 

thanks,
-- 
John Hubbard
NVIDIA
