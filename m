Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED526C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C7A208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 00:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lqP0WN3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbeLOAl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 19:41:56 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13020 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbeLOAl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 19:41:56 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c144dcf0000>; Fri, 14 Dec 2018 16:41:51 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 14 Dec 2018 16:41:55 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 14 Dec 2018 16:41:55 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 15 Dec
 2018 00:41:55 +0000
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     Matthew Wilcox <willy@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        david <david@fromorbit.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>, John Hubbard <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, <tom@talpey.com>,
        Al Viro <viro@zeniv.linux.org.uk>, <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        <rcampbell@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20181212150319.GA3432@redhat.com>
 <20181212214641.GB29416@dastard> <20181212215931.GG5037@redhat.com>
 <20181213005119.GD29416@dastard>
 <05a68829-6e6d-b766-11b4-99e1ba4bc87b@nvidia.com>
 <CAPcyv4jyG3YTtghyr04wws_hcSBAmPBpnCm0tFcKgz9VwrV=ow@mail.gmail.com>
 <01cf4e0c-b2d6-225a-3ee9-ef0f7e53684d@nvidia.com>
 <CAPcyv4hrbA9H20bi+QMpKNi7r=egstt61MdQSD5Fb293W1btaw@mail.gmail.com>
 <20181214194843.GG10600@bombadil.infradead.org>
 <ed49a260-ffd5-613d-e48b-dfb4b550e8bb@intel.com>
 <20181214200311.GH10600@bombadil.infradead.org>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <2e9396f4-f0c8-8ae2-8044-cd4807d61bca@nvidia.com>
Date:   Fri, 14 Dec 2018 16:41:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181214200311.GH10600@bombadil.infradead.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1544834511; bh=i9A7NGiDtHXHbUOZwuytamOlJYVGbUTQePeWLbdBzVc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=lqP0WN3ra6mRBvdp4c7ODAL3qEsdTv4vanidxF9jum+4gQlUnqHseOuI8lqoPlj0j
         NcraRuCx7kxOtEwCJonPikQbEGjL9m3rbHCcE4Ht/qxpE8UyBHMA4nZ1AD49164pKl
         kvP4k6EzX582HKXLCqM00fmfjw+NLxytxFt7RHf1EhoRfrsJb/bMf5fg9QYJmMhAC+
         6IDK2H3XnEQmYxcdKuPcU1EUiGfuTjAGHQuK8pRJ2cTiXRKWMD/Ph3hMzCyANPef7f
         heYZCLCAqosn40l7IcJWnL38sGQkX7luAOZyGm1FuKgt4CiMP9nZ6N4uq3dqyF7Yx6
         4LqE6BuEHJNsA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/18 12:03 PM, Matthew Wilcox wrote:
> On Fri, Dec 14, 2018 at 11:53:31AM -0800, Dave Hansen wrote:
>> On 12/14/18 11:48 AM, Matthew Wilcox wrote:
>>> I think we can do better than a proxy object with bit 0 set.  I'd go
>>> for allocating something like this:
>>>
>>> struct dynamic_page {
>>> 	struct page;
>>> 	unsigned long vaddr;
>>> 	unsigned long pfn;
>>> 	...
>>> };
>>>
>>> and use a bit in struct page to indicate that this is a dynamic page.
>>
>> That might be fun.  We'd just need a fast/static and slow/dynamic path
>> in page_to_pfn()/pfn_to_page().  We'd also need some kind of auxiliary
>> pfn-to-page structure since we could not fit that^ structure in vmemmap[].
> 
> Yes; working on the pfn-to-page structure right now as it happens ...
> in the meantime, an XArray for it probably wouldn't be _too_ bad.
> 

OK, this looks great. And as Dan pointed out, we get a nice side effect of
type safety for the gup/dma call site conversion. After doing partial 
conversions, the need for type safety (some of the callers really are 
complex) really seems worth the extra work, so that's a big benefit.

Next steps: I want to go try this dynamic_page approach out right away. 
If there are pieces such as page_to_pfn and related, that are already in
progress, I'd definitely like to work on top of that. Also, any up front
advice or pitfalls to avoid is always welcome, of course. :)

thanks,
-- 
John Hubbard
NVIDIA
