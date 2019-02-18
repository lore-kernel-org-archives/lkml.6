Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65294C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359972173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GaW3shv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403850AbfBRRvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:51:35 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:7455 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733043AbfBRRvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:51:35 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6af0ad0000>; Mon, 18 Feb 2019 09:51:41 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Feb 2019 09:51:34 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Feb 2019 09:51:34 -0800
Received: from [192.168.45.1] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 18 Feb
 2019 17:51:34 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        David Nellans <dnellans@nvidia.com>
Subject: Re: [RFC PATCH 01/31] mm: migrate: Add exchange_pages to exchange two
 lists of pages.
Date:   Mon, 18 Feb 2019 09:51:33 -0800
X-Mailer: MailMate (1.12.4r5594)
Message-ID: <53690FCD-B0BA-4619-8DF1-B9D721EE1208@nvidia.com>
In-Reply-To: <2630a452-8c53-f109-1748-36b98076c86e@suse.cz>
References: <20190215220856.29749-1-zi.yan@sent.com>
 <20190215220856.29749-2-zi.yan@sent.com>
 <20190217112943.GP12668@bombadil.infradead.org>
 <65A1FFA0-531C-4078-9704-3F44819C3C07@nvidia.com>
 <2630a452-8c53-f109-1748-36b98076c86e@suse.cz>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; format=flowed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550512301; bh=oAMN2SMukQAAwRMkk7Z9t+qJkQU7W0HY8HzcNJMrMEY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=GaW3shv7rI8TEPkLO/Twt/a8gREXMYf56YGKx1eJyIRyFLKzbYW4CobkfS/3jqagM
         35C5RjV32CtSxtAHqo5zPJWeNc6Ic1fxJNIIgbcH/pmU6q8oS8+LbpPWnAZH4aQJNF
         GHYzJ6T2TLTVjbME5dxbDRtsJOREdb1b7wQkerwm63KXkmB7sHCR0QazzCzmRn4UpG
         TXX8EB3hNynxF2IdzXsARkIBe19W0C8KpbJ0FwmbzMHdafVZ9gVskvx5FGpqa1VCWT
         QI7M5+fKUTxvOuSBUNbxaUXsfCE99M05z20iCkTEDRq6yVlsr9f4c1y7DkJYfxP0b+
         NNg1Is4W88Pcw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Feb 2019, at 9:42, Vlastimil Babka wrote:

> On 2/18/19 6:31 PM, Zi Yan wrote:
>> The purpose of proposing exchange_pages() is to avoid allocating any 
>> new
>> page,
>> so that we would not trigger any potential page reclaim or memory
>> compaction.
>> Allocating a temporary page defeats the purpose.
>
> Compaction can only happen for order > 0 temporary pages. Even if you 
> used
> single order = 0 page to gradually exchange e.g. a THP, it should be 
> better than
> u64. Allocating order = 0 should be a non-issue. If it's an issue, 
> then the
> system is in a bad state and physically contiguous layout is a 
> secondary concern.

You are right if we only need to allocate one order-0 page. But this 
also means
we can only exchange two pages at a time. We need to add a lock to make 
sure
the temporary page is used exclusively or we need to keep allocating 
temporary pages
when multiple exchange_pages() are happening at the same time.

--
Best Regards,
Yan Zi
