Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6880C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815B42604E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 19:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 815B42604E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933985AbeFYTEK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 15:04:10 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13281 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbeFYTEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 15:04:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b313c880000>; Mon, 25 Jun 2018 12:03:39 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 25 Jun 2018 12:04:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 25 Jun 2018 12:04:07 -0700
Received: from [10.2.161.233] (10.2.161.233) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 25 Jun
 2018 19:04:03 +0000
Subject: Re: [PATCH 2/2] mm: set PG_dma_pinned on get_user_pages*()
To:     Jan Kara <jack@suse.cz>
CC:     Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <john.hubbard@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <3898ef6b-2fa0-e852-a9ac-d904b47320d5@nvidia.com>
 <CAPcyv4iRBzmwWn_9zDvqdfVmTZL_Gn7uA_26A1T-kJib=84tvA@mail.gmail.com>
 <0e6053b3-b78c-c8be-4fab-e8555810c732@nvidia.com>
 <20180619082949.wzoe42wpxsahuitu@quack2.suse.cz>
 <20180619090255.GA25522@bombadil.infradead.org>
 <20180619104142.lpilc6esz7w3a54i@quack2.suse.cz>
 <70001987-3938-d33e-11e0-de5b19ca3bdf@nvidia.com>
 <20180620120824.bghoklv7qu2z5wgy@quack2.suse.cz>
 <151edbf3-66ff-df0c-c1cc-5998de50111e@nvidia.com>
 <20180621163036.jvdbsv3t2lu34pdl@quack2.suse.cz>
 <20180625152150.jnf5suiubecfppcl@quack2.suse.cz>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <d007873c-4454-4c70-4829-b222155be0ff@nvidia.com>
Date:   Mon, 25 Jun 2018 12:03:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180625152150.jnf5suiubecfppcl@quack2.suse.cz>
X-Originating-IP: [10.2.161.233]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/2018 08:21 AM, Jan Kara wrote:
> On Thu 21-06-18 18:30:36, Jan Kara wrote:
>> On Wed 20-06-18 15:55:41, John Hubbard wrote:
>>> On 06/20/2018 05:08 AM, Jan Kara wrote:
>>>> On Tue 19-06-18 11:11:48, John Hubbard wrote:
>>>>> On 06/19/2018 03:41 AM, Jan Kara wrote:
>>>>>> On Tue 19-06-18 02:02:55, Matthew Wilcox wrote:
>>>>>>> On Tue, Jun 19, 2018 at 10:29:49AM +0200, Jan Kara wrote:
>>> [...]
> I've spent some time on this. There are two obstacles with my approach of
> putting special entry into inode's VMA tree:
> 
> 1) If I want to place this special entry in inode's VMA tree, I either need
> to allocate full VMA, somehow initiate it so that it's clear it's a special
> "pinned" range, not a VMA => uses unnecessarily too much memory, it is
> ugly. Another solution I was hoping for was that I would factor out some
> common bits of vm_area_struct (pgoff, rb_node, ..) into a structure common
> for VMA and the locked range => doable but causes a lot of churn as VMAs
> are accessed (and modified!) at hundreds of places in the kernel. Some
> accessor functions would help to reduce the churn a bit but then stuff like
> vma_set_pgoff(vma, pgoff) isn't exactly beautiful either.
> 
> 2) Some users of GUP (e.g. direct IO) get a block of pages and then put
> references to these pages at different times and in random order -
> basically when IO for given page is completed, reference is dropped and one
> GUP call can acquire page references for pages which end up in multiple
> different bios (we don't know in advance). This makes is difficult to
> implement counterpart to GUP to 'unpin' a range of pages - we'd either have
> to support partial unpins (and splitting of pinned ranges and all such fun)
> or just have to track internally in how many pages are still pinned in the
> originally pinned range and release the pin once all individual pages are
> unpinned but then it's difficult to e.g. get to this internal structure
> from IO completion callback where we only have the bio.
>
> So I think the Matthew's idea of removing pinned pages from LRU is
> definitely worth trying to see how complex that would end up being. Did you
> get to looking into it? If not, I can probably find some time to try that
> out.
> 

OK. Even if we remove the pages from the LRU, we still have to insert a "put_gup_page"
or similarly named call. But it could be a simple replacement for put_page, with
that approach, so that does make it much much easier.
 
I was (and still am) planning on tackling this today, so let me see how far I
get before yelling for help. :)

thanks,
-- 
John Hubbard
NVIDIA
