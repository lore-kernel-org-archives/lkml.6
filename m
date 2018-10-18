Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F81ECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54AAA2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FcvJgfKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54AAA2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeJRIBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 04:01:14 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6112 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbeJRIBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 04:01:14 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc7cdb00002>; Wed, 17 Oct 2018 17:02:56 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 17 Oct 2018 17:03:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 17 Oct 2018 17:03:04 -0700
Received: from [10.2.167.215] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 18 Oct
 2018 00:03:03 +0000
Subject: Re: [PATCH 4/6] mm: introduce page->dma_pinned_flags, _count
To:     Michal Hocko <mhocko@kernel.org>
CC:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20181012060014.10242-1-jhubbard@nvidia.com>
 <20181012060014.10242-5-jhubbard@nvidia.com> <20181013035516.GA18822@dastard>
 <7c2e3b54-0b1d-6726-a508-804ef8620cfd@nvidia.com>
 <20181013230124.GB18822@dastard> <20181016085102.GB18918@quack2.suse.cz>
 <a9f1df2f-da9d-bf7b-b977-d3d3ca710776@nvidia.com>
 <20181017110952.GN18839@dhcp22.suse.cz>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <2367ff26-809c-da94-a8f0-e921bdc4862a@nvidia.com>
Date:   Wed, 17 Oct 2018 17:03:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181017110952.GN18839@dhcp22.suse.cz>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539820976; bh=Ida7Jp8IxA9fbRjK4fx2IsAQF0NhHwfkSfRnIz4BEM4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=FcvJgfKmCjgehE03kOpLNFU1SeZxk7MQb/vkPa1+gVm3sI8w52G3iqhO7FuI/+ABg
         XD9bYCKn+Vowg6YCPo4l9PgjyWSu+wqUVZYpc01XlXdsSfaaM1sM4OWYTixzSHHUT/
         cKrCJGLdk+zEsaQR48fNWhNYst+wlWlp6jwRwvYyy0Kh6hxRs8oNJG+mkiOjBNKjKE
         Db1OwXr/plOazkN294r+5PE45UvAt20gsxyZJdDPEZWKoSnHa7Iw8tSr9TIJgkoxG2
         T25erdRFbi6MsHBYpBUSc2ggA1AZmkGBuo/o31u5ry2JUV0Zrl/h471VQ8pW0X2LfP
         i+wCCLkB7PVGQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 4:09 AM, Michal Hocko wrote:
> On Tue 16-10-18 18:48:23, John Hubbard wrote:
> [...]
>> It's hard to say exactly what the active/inactive/unevictable list should
>> be when DMA is done and put_user_page*() is called, because we don't know
>> if some device read, wrote, or ignored any of those pages. Although if 
>> put_user_pages_dirty() is called, that's an argument for "active", at least.
> 
> Any reason to not use putback_lru_page?

That does help with which LRU to use. I guess I'd still need to track whether
a page was on an LRU when get_user_pages() was called, because it seems
that that is not necessarily always the case. And putback_lru_page() definitely
wants to deal with a page that *was* previously on an LRU.

> 
> Please note I haven't really got through your patches to have a wider
> picture of the change so this is just hint for the LRU part of the
> issue.
> 

Understood, and the hints are much appreciated.

-- 
thanks,
John Hubbard
NVIDIA
