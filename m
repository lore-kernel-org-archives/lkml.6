Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46B8C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528E920875
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528E920875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754175AbeFTW4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:56:41 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2392 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752838AbeFTW4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:56:39 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b2adbac0000>; Wed, 20 Jun 2018 15:56:44 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 20 Jun 2018 15:56:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 20 Jun 2018 15:56:42 -0700
Received: from [10.110.48.28] (10.110.48.28) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 20 Jun
 2018 22:56:38 +0000
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
References: <20180618081258.GB16991@lst.de>
 <d4817192-6db0-2f3f-7c67-6078b69686d3@nvidia.com>
 <CAPcyv4iacHYxGmyWokFrVsmxvLj7=phqp2i0tv8z6AT-mYuEEA@mail.gmail.com>
 <3898ef6b-2fa0-e852-a9ac-d904b47320d5@nvidia.com>
 <CAPcyv4iRBzmwWn_9zDvqdfVmTZL_Gn7uA_26A1T-kJib=84tvA@mail.gmail.com>
 <0e6053b3-b78c-c8be-4fab-e8555810c732@nvidia.com>
 <20180619082949.wzoe42wpxsahuitu@quack2.suse.cz>
 <20180619090255.GA25522@bombadil.infradead.org>
 <20180619104142.lpilc6esz7w3a54i@quack2.suse.cz>
 <70001987-3938-d33e-11e0-de5b19ca3bdf@nvidia.com>
 <20180620120824.bghoklv7qu2z5wgy@quack2.suse.cz>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <151edbf3-66ff-df0c-c1cc-5998de50111e@nvidia.com>
Date:   Wed, 20 Jun 2018 15:55:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620120824.bghoklv7qu2z5wgy@quack2.suse.cz>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20/2018 05:08 AM, Jan Kara wrote:
> On Tue 19-06-18 11:11:48, John Hubbard wrote:
>> On 06/19/2018 03:41 AM, Jan Kara wrote:
>>> On Tue 19-06-18 02:02:55, Matthew Wilcox wrote:
>>>> On Tue, Jun 19, 2018 at 10:29:49AM +0200, Jan Kara wrote:
[...]
>>> I'm also still pondering the idea of inserting a "virtual" VMA into vma
>>> interval tree in the inode - as the GUP references are IMHO closest to an
>>> mlocked mapping - and that would achieve all the functionality we need as
>>> well. I just didn't have time to experiment with it.
>>
>> How would this work? Would it have the same virtual address range? And how
>> does it avoid the problems we've been discussing? Sorry to be a bit slow
>> here. :)
> 
> The range covered by the virtual mapping would be the one sent to
> get_user_pages() to get page references. And then we would need to teach
> page_mkclean() to check for these virtual VMAs and block / skip / report
> (different situations would need different behavior) such page. But this
> second part is the same regardless how we identify a page that is pinned by
> get_user_pages().


OK. That neatly avoids the need a new page flag, I think. But of course it is 
somewhat more extensive to implement. Sounds like something to keep in mind,
in case it has better tradeoffs than the direction I'm heading so far.

 
>>> And then there's the aspect that both these approaches are a bit too
>>> heavyweight for some get_user_pages_fast() users (e.g. direct IO) - Al Viro
>>> had an idea to use page lock for that path but e.g. fs/direct-io.c would have
>>> problems due to lock ordering constraints (filesystem ->get_block would
>>> suddently get called with the page lock held). But we can probably leave
>>> performance optimizations for phase two.
>>
>>  
>> So I assume that phase one would be to apply this approach only to
>> get_user_pages_longterm. (Please let me know if that's wrong.)
> 
> No, I meant phase 1 would be to apply this to all get_user_pages() flavors.
> Then phase 2 is to try to find a way to make get_user_pages_fast() fast
> again. And then in parallel to that, we also need to find a way for
> get_user_pages_longterm() to signal to the user pinned pages must be
> released soon. Because after phase 1 pinned pages will block page
> writeback and such system won't oops but will become unusable
> sooner rather than later. And again this problem needs to be solved
> regardless of a mechanism of identifying pinned pages.
> 

OK, thanks, that does help. I had the priorities of these get_user_pages*()
changes all scrambled, but between your and Dan's explanation, I finally 
understand the preferred ordering of this work.

