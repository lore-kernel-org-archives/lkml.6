Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3887AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBFA20658
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 03:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mv3RblzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDBFA20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbeJLLX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 07:23:59 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4315 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbeJLLX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 07:23:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc01ac20000>; Thu, 11 Oct 2018 20:53:38 -0700
Received: from HQMAIL106.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 11 Oct 2018 20:53:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 11 Oct 2018 20:53:35 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 12 Oct
 2018 03:53:34 +0000
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 12 Oct
 2018 03:53:34 +0000
Subject: Re: [PATCH v4 2/3] mm: introduce put_user_page*(), placeholder
 versions
From:   John Hubbard <jhubbard@nvidia.com>
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
        "Christoph Hellwig" <hch@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>
References: <20181008211623.30796-1-jhubbard@nvidia.com>
 <20181008211623.30796-3-jhubbard@nvidia.com>
 <20181008171442.d3b3a1ea07d56c26d813a11e@linux-foundation.org>
 <5198a797-fa34-c859-ff9d-568834a85a83@nvidia.com>
 <20181010164541.ec4bf53f5a9e4ba6e5b52a21@linux-foundation.org>
 <20181011084929.GB8418@quack2.suse.cz> <20181011132013.GA5968@ziepe.ca>
 <97e89e08-5b94-240a-56e9-ece2b91f6dbc@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <b9899626-9033-348b-6f07-dc90bcd8a468@nvidia.com>
Date:   Thu, 11 Oct 2018 20:53:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <97e89e08-5b94-240a-56e9-ece2b91f6dbc@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL102.nvidia.com (172.18.146.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539316418; bh=DLYDAxARImMUfvoI4Sni/4ANHhReBxvEJH36JkJ5MB4=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mv3RblzF21ENYwQ4E/7I/FDr/05K7rGR/U4jgVMrWT0/+aobc31sDuZvrHJt41K06
         4VJKCbLJ9PeLDgSNApafEVbFWWsliZU8USTRvbFuga9KvERttgsbpooxopzjslVPn2
         /LrnY7fo76Rdgu2Hp+qHhhUE7cn4cZtad6H9D5JZZvS4JG68HSjera5Hw+g2vFNgSY
         zG1BLZE39MTvp++7OxKrGZnjJe0KtIWFDMbVpAlBL/Y8rt3F71nmqN82YRRTh4TaE7
         jNGlKefH2x6J3B9X8eJMUptO/D8x1E/G8ZD5+cv0FHbktnXAJ60ktTfpr3f3HXUwiI
         a9YzUqmWd2y/Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/18 6:23 PM, John Hubbard wrote:
> On 10/11/18 6:20 AM, Jason Gunthorpe wrote:
>> On Thu, Oct 11, 2018 at 10:49:29AM +0200, Jan Kara wrote:
>>
>>>> This is a real worry.  If someone uses a mistaken put_page() then how
>>>> will that bug manifest at runtime?  Under what set of circumstances
>>>> will the kernel trigger the bug?
>>>
>>> At runtime such bug will manifest as a page that can never be evicted from
>>> memory. We could warn in put_page() if page reference count drops below
>>> bare minimum for given user pin count which would be able to catch some
>>> issues but it won't be 100% reliable. So at this point I'm more leaning
>>> towards making get_user_pages() return a different type than just
>>> struct page * to make it much harder for refcount to go wrong...
>>
>> At least for the infiniband code being used as an example here we take
>> the struct page from get_user_pages, then stick it in a sgl, and at
>> put_page time we get the page back out of the sgl via sg_page()
>>
>> So type safety will not help this case... I wonder how many other
>> users are similar? I think this is a pretty reasonable flow for DMA
>> with user pages.
>>
> 
> That is true. The infiniband code, fortunately, never mixes the two page
> types into the same pool (or sg list), so it's actually an easier example
> than some other subsystems. But, yes, type safety doesn't help there. I can 
> take a moment to look around at the other areas, to quantify how much a type
> safety change might help.
> 
> Back to page flags again, out of desperation:
> 
> How much do we know about the page types that all of these subsystems
> use? In other words, can we, for example, use bit 1 of page->lru.next (see [1]
> for context) as the "dma-pinned" page flag, while tracking pages within parts 
> of the kernel that call a mix of alloc_pages, get_user_pages, and other allocators? 
> In order for that to work, page->index, page->private, and bit 1 of page->mapping
> must not be used. I doubt that this is always going to hold, but...does it?
> 

Oops, pardon me, please ignore that nonsense about page->index and page->private
and page->mapping, that's actually fine (I was seeing "union", where "struct" was
written--too much staring at this code). 

So actually, I think maybe we can just use bit 1 in page->lru.next to sort out
which pages are dma-pinned, in the calling code, just like we're going to do
in writeback situations. This should also allow run-time checking that Andrew was 
hoping for:

    put_user_page(): assert that the page is dma-pinned
    put_page(): assert that the page is *not* dma-pinned

...both of which depend on that bit being, essentially, available as sort of a
general page flag. And in fact, if it's not, then the whole approach is dead anyway.

Am I missing anything? This avoids the need to change the get_user_pages interface.


thanks,
-- 
John Hubbard
NVIDIA

