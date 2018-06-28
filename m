Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AEFC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9528524FB6
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9528524FB6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753237AbeF1CnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:43:07 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8598 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752039AbeF1CnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:43:05 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b344b380000>; Wed, 27 Jun 2018 19:43:04 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 27 Jun 2018 19:43:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 27 Jun 2018 19:43:06 -0700
Received: from [10.110.48.28] (10.110.48.28) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 28 Jun
 2018 02:43:04 +0000
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
To:     Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <john.hubbard@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <CAPcyv4iacHYxGmyWokFrVsmxvLj7=phqp2i0tv8z6AT-mYuEEA@mail.gmail.com>
 <3898ef6b-2fa0-e852-a9ac-d904b47320d5@nvidia.com>
 <CAPcyv4iRBzmwWn_9zDvqdfVmTZL_Gn7uA_26A1T-kJib=84tvA@mail.gmail.com>
 <20180626134757.GY28965@dhcp22.suse.cz>
 <20180626164825.fz4m2lv6hydbdrds@quack2.suse.cz>
 <20180627113221.GO32348@dhcp22.suse.cz>
 <20180627115349.cu2k3ainqqdrrepz@quack2.suse.cz>
 <20180627115927.GQ32348@dhcp22.suse.cz>
 <20180627124255.np2a6rxy6rb6v7mm@quack2.suse.cz>
 <20180627145718.GB20171@ziepe.ca>
 <20180627170246.qfvucs72seqabaef@quack2.suse.cz>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <1f6e79c5-5801-16d2-18a6-66bd0712b5b8@nvidia.com>
Date:   Wed, 27 Jun 2018 19:42:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180627170246.qfvucs72seqabaef@quack2.suse.cz>
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

On 06/27/2018 10:02 AM, Jan Kara wrote:
> On Wed 27-06-18 08:57:18, Jason Gunthorpe wrote:
>> On Wed, Jun 27, 2018 at 02:42:55PM +0200, Jan Kara wrote:
>>> On Wed 27-06-18 13:59:27, Michal Hocko wrote:
>>>> On Wed 27-06-18 13:53:49, Jan Kara wrote:
>>>>> On Wed 27-06-18 13:32:21, Michal Hocko wrote:
>>>> [...]
>>>>>> Appart from that, do we really care about 32b here? Big DIO, IB users
>>>>>> seem to be 64b only AFAIU.
>>>>>
>>>>> IMO it is a bad habit to leave unpriviledged-user-triggerable oops in the
>>>>> kernel even for uncommon platforms...
>>>>
>>>> Absolutely agreed! I didn't mean to keep the blow up for 32b. I just
>>>> wanted to say that we can stay with a simple solution for 32b. I thought
>>>> the g-u-p-longterm has plugged the most obvious breakage already. But
>>>> maybe I just misunderstood.
>>>
>>> Most yes, but if you try hard enough, you can still trigger the oops e.g.
>>> with appropriately set up direct IO when racing with writeback / reclaim.
>>
>> gup longterm is only different from normal gup if you have DAX and few
>> people do, which really means it doesn't help at all.. AFAIK??
> 
> Right, what I wrote works only for DAX. For non-DAX situation g-u-p
> longterm does not currently help at all. Sorry for confusion.
> 

OK, I've got an early version of this up and running, reusing the page->lru
fields. I'll clean it up and do some heavier testing, and post as a PATCH v2.

One question though: I'm still vague on the best actions to take in the following
functions:

    page_mkclean_one
    try_to_unmap_one

At the moment, they are both just doing an evil little early-out:

	if (PageDmaPinned(page))
		return false;

...but we talked about maybe waiting for the condition to clear, instead? Thoughts?

And if so, does it sound reasonable to refactor wait_on_page_bit_common(),
so that it learns how to wait for a bit that, while inside struct page, is
not within page->flags?


thanks,
-- 
John Hubbard
NVIDIA
