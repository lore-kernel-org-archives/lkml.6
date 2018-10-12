Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6218EC67837
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 01:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AE621470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 01:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Q8xcwYMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20AE621470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeJLIxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 04:53:21 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17713 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbeJLIxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 04:53:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bbff78f0000>; Thu, 11 Oct 2018 18:23:27 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 11 Oct 2018 18:23:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 11 Oct 2018 18:23:25 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 12 Oct
 2018 01:23:24 +0000
Subject: Re: [PATCH v4 2/3] mm: introduce put_user_page*(), placeholder
 versions
To:     Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <john.hubbard@gmail.com>, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>
References: <20181008211623.30796-1-jhubbard@nvidia.com>
 <20181008211623.30796-3-jhubbard@nvidia.com>
 <20181008171442.d3b3a1ea07d56c26d813a11e@linux-foundation.org>
 <5198a797-fa34-c859-ff9d-568834a85a83@nvidia.com>
 <20181010164541.ec4bf53f5a9e4ba6e5b52a21@linux-foundation.org>
 <20181011084929.GB8418@quack2.suse.cz> <20181011132013.GA5968@ziepe.ca>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <97e89e08-5b94-240a-56e9-ece2b91f6dbc@nvidia.com>
Date:   Thu, 11 Oct 2018 18:23:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181011132013.GA5968@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539307408; bh=zEEczumF5mdpDDdpThD+/SEE2do4Yud/Mria3av7vd4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Q8xcwYMCRFSffkgfqcByr0NCun1FU0/PkE3dPq5iiIy4ZMlVra9IuASsAN7Vqq1pT
         3hB9kKqEkhI6f4jzgzIeb9ags60q9yrSPL9S3oaaeq0N/4RuNZx8TBv46xPo7dHdI4
         uVGXp4RVHWu1MMjG+xLu0ZkAZ1W4EC9AQRR8IgMD94TBJT23IrQmudNRf/c8Twux3j
         qumsH5jrRD7a2hMPONA1QABKsILeI/GGKFol9qoi188Sg1qcM9qhdLryG9rTAMAouU
         Iuslhsxun5/P86J3MGwx/sJXoida1G0xhPSgbHX7sWKQzLbI5MaAUxqS5rieXKEDMX
         R7c3v0551yWww==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/18 6:20 AM, Jason Gunthorpe wrote:
> On Thu, Oct 11, 2018 at 10:49:29AM +0200, Jan Kara wrote:
> 
>>> This is a real worry.  If someone uses a mistaken put_page() then how
>>> will that bug manifest at runtime?  Under what set of circumstances
>>> will the kernel trigger the bug?
>>
>> At runtime such bug will manifest as a page that can never be evicted from
>> memory. We could warn in put_page() if page reference count drops below
>> bare minimum for given user pin count which would be able to catch some
>> issues but it won't be 100% reliable. So at this point I'm more leaning
>> towards making get_user_pages() return a different type than just
>> struct page * to make it much harder for refcount to go wrong...
> 
> At least for the infiniband code being used as an example here we take
> the struct page from get_user_pages, then stick it in a sgl, and at
> put_page time we get the page back out of the sgl via sg_page()
> 
> So type safety will not help this case... I wonder how many other
> users are similar? I think this is a pretty reasonable flow for DMA
> with user pages.
> 

That is true. The infiniband code, fortunately, never mixes the two page
types into the same pool (or sg list), so it's actually an easier example
than some other subsystems. But, yes, type safety doesn't help there. I can 
take a moment to look around at the other areas, to quantify how much a type
safety change might help.

Back to page flags again, out of desperation:

How much do we know about the page types that all of these subsystems
use? In other words, can we, for example, use bit 1 of page->lru.next (see [1]
for context) as the "dma-pinned" page flag, while tracking pages within parts 
of the kernel that call a mix of alloc_pages, get_user_pages, and other allocators? 
In order for that to work, page->index, page->private, and bit 1 of page->mapping
must not be used. I doubt that this is always going to hold, but...does it?

Other ideas: provide a fast lookup tree that tracks pages that were 
obtained via get_user_pages. Before calling put_page or put_user_page,
use that tree to decide which to call. Or anything along the lines of
"yet another way to track pages without using page flags".

(Also, Andrew: "ack" on your point about CC-ing you on all patches, I've fixed
my scripts accordingly, sorry about that.)


[1] Matthew Wilcox's idea for stealing some tracking bits, by removing
dma-pinned pages from the LRU:

   https://lore.kernel.org/r/20180619090255.GA25522@bombadil.infradead.org


thanks,
-- 
John Hubbard
NVIDIA
