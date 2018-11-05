Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15ADFC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC30D20831
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="R6fQtows"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC30D20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbeKEQgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 11:36:15 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17174 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbeKEQgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 11:36:15 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bdfeeaf0000>; Sun, 04 Nov 2018 23:18:07 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 04 Nov 2018 23:17:59 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 04 Nov 2018 23:17:59 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 5 Nov
 2018 07:17:59 +0000
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 5 Nov
 2018 07:17:58 +0000
Subject: Re: [PATCH v4 2/3] mm: introduce put_user_page*(), placeholder
 versions
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        <john.hubbard@gmail.com>, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        "Jerome Glisse" <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>
References: <20181008211623.30796-1-jhubbard@nvidia.com>
 <20181008211623.30796-3-jhubbard@nvidia.com>
 <20181008171442.d3b3a1ea07d56c26d813a11e@linux-foundation.org>
 <5198a797-fa34-c859-ff9d-568834a85a83@nvidia.com>
 <20181010164541.ec4bf53f5a9e4ba6e5b52a21@linux-foundation.org>
 <20181011084929.GB8418@quack2.suse.cz> <20181011132013.GA5968@ziepe.ca>
 <97e89e08-5b94-240a-56e9-ece2b91f6dbc@nvidia.com>
 <20181022194329.GG30059@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <532c7ae5-7277-74a7-93f2-afe8b7dc13fc@nvidia.com>
Date:   Sun, 4 Nov 2018 23:17:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181022194329.GG30059@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL102.nvidia.com (172.18.146.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1541402287; bh=tYkGiEqBavVj5O4eXJF3QSCHhgcVVz5vh6FbUI6KznY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=R6fQtowstnx5u3lvZiS+gRbEr/dLMkU6fdf0UDBvJABAUWPvrxnUG/2tm8CREf6Vo
         8psb4niVcs0jFlXZ98Qyem3ymoJUPU7b0OB1Hn/rH6xrAm3UQzbS9qJZC5gVHjQmXP
         LXeokMnCEJs3T1M6NPUDxUvS/XnnPUG7voQs0Mga3Yhed133co5rSqRphYAZ/mq8M/
         mP/Sja2DTQC+871RgqYa5fS3kALgo227EzdIDpO99MHmHBP9EYYbYhQh6CnWDnAr80
         ccBpvNjzBf7uUT+BvFbVQ++MvQ20bkLqxj0/cbHPsZQnMCc4bdKe0EwOwnME342hEG
         C0W0G4DMoVK6Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/18 12:43 PM, Jason Gunthorpe wrote:
> On Thu, Oct 11, 2018 at 06:23:24PM -0700, John Hubbard wrote:
>> On 10/11/18 6:20 AM, Jason Gunthorpe wrote:
>>> On Thu, Oct 11, 2018 at 10:49:29AM +0200, Jan Kara wrote:
>>>
>>>>> This is a real worry.  If someone uses a mistaken put_page() then how
>>>>> will that bug manifest at runtime?  Under what set of circumstances
>>>>> will the kernel trigger the bug?
>>>>
>>>> At runtime such bug will manifest as a page that can never be evicted from
>>>> memory. We could warn in put_page() if page reference count drops below
>>>> bare minimum for given user pin count which would be able to catch some
>>>> issues but it won't be 100% reliable. So at this point I'm more leaning
>>>> towards making get_user_pages() return a different type than just
>>>> struct page * to make it much harder for refcount to go wrong...
>>>
>>> At least for the infiniband code being used as an example here we take
>>> the struct page from get_user_pages, then stick it in a sgl, and at
>>> put_page time we get the page back out of the sgl via sg_page()
>>>
>>> So type safety will not help this case... I wonder how many other
>>> users are similar? I think this is a pretty reasonable flow for DMA
>>> with user pages.
>>>
>>
>> That is true. The infiniband code, fortunately, never mixes the two page
>> types into the same pool (or sg list), so it's actually an easier example
>> than some other subsystems. But, yes, type safety doesn't help there. I can 
>> take a moment to look around at the other areas, to quantify how much a type
>> safety change might help.
> 
> Are most (all?) of the places working with SGLs?

I finally put together a spreadsheet, in order to answer this sort of thing.
Some notes:

a) There are around 100 call sites of either get_user_pages*(), or indirect
calls via iov_iter_get_pages*().

b) There are only a few SGL users. Most are ad-hoc, instead: some loop that
either can be collapsed nicely into the new put_user_pages*() APIs, or...
cannot.

c) The real problem is: around 20+ iov_iter_get_pages*() call sites. I need
to change both the  iov_iter system a little bit, and also change the callers
so that they don't pile all the gup-pinned pages into the same page** array
that also contains other allocation types. This can be done, it just takes
time, that's the good news.

> 
> Maybe we could just have a 'get_user_pages_to_sgl' and 'put_pages_sgl'
> sort of interface that handled all this instead of trying to make
> something that is struct page based?
> 
> It seems easier to get an extra bit for user/!user in the SGL
> datastructure?
> 

So at the moment I don't think we need this *_sgl interface. We need iov_iter*
changes instead.

thanks,
-- 
John Hubbard
NVIDIA
