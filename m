Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA25C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052CB2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aiRzGUhQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfBUVZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:25:04 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13617 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfBUVZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 16:25:04 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6f17370001>; Thu, 21 Feb 2019 13:25:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 21 Feb 2019 13:25:03 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 21 Feb 2019 13:25:03 -0800
Received: from [10.2.161.21] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 21 Feb
 2019 21:25:02 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Jerome Glisse <jglisse@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [RFC PATCH 01/31] mm: migrate: Add exchange_pages to exchange two
 lists of pages.
Date:   Thu, 21 Feb 2019 13:25:02 -0800
X-Mailer: MailMate (1.12.4r5609)
Message-ID: <3AE8BFB7-139B-4312-A0A7-50759BA63362@nvidia.com>
In-Reply-To: <20190221211038.GC5201@redhat.com>
References: <20190215220856.29749-1-zi.yan@sent.com>
 <20190215220856.29749-2-zi.yan@sent.com> <20190221211038.GC5201@redhat.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550784311; bh=VW57buSV9PMYWQz48J9UmJOo0JrnTIg+0Kl1EdES2N4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=aiRzGUhQbpIFpXcfTrDEvOdfujPjXdkqyIBrV2OOqD30hq7BtgcxDRplyHtdWxmEf
         GdH2+JEL7ChdJIcp93Lw3Pqh3N0pX+3ls7McbewYwG5qKA3rbOw5AWaTL4z2jRy40D
         0EA5MBqL28BWjuStftJrRJ2vlg5Z3WAV3rPUd0ZAca2NZQL1XqzUOEpjJt0gzzKpIX
         18BIX4Tstk2+k6fkGpPoIH1Ih1PjjsuNKL5tTm7mUBQGKx7NXi+MqVxetD0Xuk2Y/2
         AMG8UrHvuOHFEoHSr6xzMBxL+yMxHj5LkhdrLk4WM432oYLe5M3kt7k0PB/L+M95W4
         DLmq9PENyuWOQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Feb 2019, at 13:10, Jerome Glisse wrote:

> On Fri, Feb 15, 2019 at 02:08:26PM -0800, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> In stead of using two migrate_pages(), a single exchange_pages() would
>> be sufficient and without allocating new pages.
>
> So i believe it would be better to arrange the code differently instead
> of having one function that special case combination, define function for
> each one ie:
>     exchange_anon_to_share()
>     exchange_anon_to_anon()
>     exchange_share_to_share()
>
> Then you could define function to test if a page is in correct states:
>     can_exchange_anon_page() // return true if page can be exchange
>     can_exchange_share_page()
>
> In fact both of this function can be factor out as common helpers with the
> existing migrate code within migrate.c This way we would have one place
> only where we need to handle all the special casing, test and exceptions.
>
> Other than that i could not spot anything obviously wrong but i did not
> spent enough time to check everything. Re-architecturing the code like
> i propose above would make this a lot easier to review i believe.
>

Thank you for reviewing the patch. Your suggestions are very helpful.
I will restructure the code to help people review it.


>> +	from_page_count = page_count(from_page);
>> +	from_map_count = page_mapcount(from_page);
>> +	to_page_count = page_count(to_page);
>> +	to_map_count = page_mapcount(to_page);
>> +	from_flags = from_page->flags;
>> +	to_flags = to_page->flags;
>> +	from_mapping = from_page->mapping;
>> +	to_mapping = to_page->mapping;
>> +	from_index = from_page->index;
>> +	to_index = to_page->index;
>
> Those are not use anywhere ...

Will remove them. Thanks.

--
Best Regards,
Yan Zi
