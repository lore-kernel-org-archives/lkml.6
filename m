Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F69C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069282081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YbBuOH9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069282081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbeLDV4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:56:39 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18830 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeLDV4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:56:39 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c06f8160000>; Tue, 04 Dec 2018 13:56:38 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 04 Dec 2018 13:56:37 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 04 Dec 2018 13:56:37 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 4 Dec
 2018 21:56:36 +0000
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     Dan Williams <dan.j.williams@intel.com>,
        John Hubbard <john.hubbard@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Jan Kara <jack@suse.cz>,
        <tom@talpey.com>, Al Viro <viro@zeniv.linux.org.uk>,
        <benve@cisco.com>, Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>, <mike.marciniszyn@intel.com>,
        <rcampbell@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20181204001720.26138-1-jhubbard@nvidia.com>
 <20181204001720.26138-2-jhubbard@nvidia.com>
 <CAPcyv4h99JVHAS7Q7k3iPPUq+oc1NxHdyBHMjpgyesF1EjVfWA@mail.gmail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <a0adcf7c-5592-f003-abc5-a2645eb1d5df@nvidia.com>
Date:   Tue, 4 Dec 2018 13:56:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <CAPcyv4h99JVHAS7Q7k3iPPUq+oc1NxHdyBHMjpgyesF1EjVfWA@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1543960598; bh=7W2wfTpgdToO6GpOI/NSe9+5+c9YZgpSZTI6IpFX1Vo=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=YbBuOH9eie1gri8DKOFeUC4jDGkI5KLAADnmkOQo2/34Vgcoa+Oev4ouHVTeFTNma
         Vyt628PcOHN5bE8bixBfJCNM75XeI20SbOEOVn1Kq6RTN3+ildVPrETzLzpk5G+PkO
         fveqdO3dXySQnD9R74UdtRS2LDFU2/OqVTgzPmyi8YT3PUrv5mlNdCY73Q86Gwt4wA
         GzFCt5+oc9PIyIVtkDAx0ldmFOgHXe8ZubOE4SiAz1743eLXOEMMh9jSrteWFBkQNM
         RLFaDPFFGi86oBpJH74O6YxWZQgys58aHpA2CUj59wV2u2VVJ4AHY+pGi4TINyqX6G
         QEkrGNicjHVtw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/18 12:28 PM, Dan Williams wrote:
> On Mon, Dec 3, 2018 at 4:17 PM <john.hubbard@gmail.com> wrote:
>>
>> From: John Hubbard <jhubbard@nvidia.com>
>>
>> Introduces put_user_page(), which simply calls put_page().
>> This provides a way to update all get_user_pages*() callers,
>> so that they call put_user_page(), instead of put_page().
>>
>> Also introduces put_user_pages(), and a few dirty/locked variations,
>> as a replacement for release_pages(), and also as a replacement
>> for open-coded loops that release multiple pages.
>> These may be used for subsequent performance improvements,
>> via batching of pages to be released.
>>
>> This is the first step of fixing the problem described in [1]. The steps
>> are:
>>
>> 1) (This patch): provide put_user_page*() routines, intended to be used
>>    for releasing pages that were pinned via get_user_pages*().
>>
>> 2) Convert all of the call sites for get_user_pages*(), to
>>    invoke put_user_page*(), instead of put_page(). This involves dozens of
>>    call sites, and will take some time.
>>
>> 3) After (2) is complete, use get_user_pages*() and put_user_page*() to
>>    implement tracking of these pages. This tracking will be separate from
>>    the existing struct page refcounting.
>>
>> 4) Use the tracking and identification of these pages, to implement
>>    special handling (especially in writeback paths) when the pages are
>>    backed by a filesystem. Again, [1] provides details as to why that is
>>    desirable.
> 
> I thought at Plumbers we talked about using a page bit to tag pages
> that have had their reference count elevated by get_user_pages()? That
> way there is no need to distinguish put_page() from put_user_page() it
> just happens internally to put_page(). At the conference Matthew was
> offering to free up a page bit for this purpose.
> 

...but then, upon further discussion in that same session, we realized that
that doesn't help. You need a reference count. Otherwise a random put_page
could affect your dma-pinned pages, etc, etc.

I was not able to actually find any place where a single additional page
bit would help our situation, which is why this still uses LRU fields for
both the two bits required (the RFC [1] still applies), and the dma_pinned_count.


[1] https://lore.kernel.org/r/20181110085041.10071-7-jhubbard@nvidia.com



>> [1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"
>>
>> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Wish, you could have been there Jan. I'm missing why it's safe to
> assume that a single put_user_page() is paired with a get_user_page()?
> 

A put_user_page() per page, or a put_user_pages() for an array of pages. See
patch 0002 for several examples.

thanks,
-- 
John Hubbard
NVIDIA
