Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AB0C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3FE21928
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="sAWi2INA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfBHUpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 15:45:01 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5355 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfBHUo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 15:44:59 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5dea4f0000>; Fri, 08 Feb 2019 12:45:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 08 Feb 2019 12:44:59 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 08 Feb 2019 12:44:59 -0800
Received: from [10.2.164.159] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 8 Feb
 2019 20:44:58 +0000
Subject: Re: [PATCH 1/2] mm: introduce put_user_page*(), placeholder versions
To:     Mike Rapoport <rppt@linux.ibm.com>, <john.hubbard@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20190208075649.3025-1-jhubbard@nvidia.com>
 <20190208075649.3025-2-jhubbard@nvidia.com>
 <20190208103211.GD11096@rapoport-lnx>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <9c1985cc-cd99-a950-5ea2-9df9f93eb98b@nvidia.com>
Date:   Fri, 8 Feb 2019 12:44:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190208103211.GD11096@rapoport-lnx>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549658703; bh=ogIholLrpKztcsDoAScWgBL1e5vfshGcZY+vwNC42rg=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=sAWi2INAdMFVha1o+0PxFQFpRxw0XUDZH6EHdS0tXI6IMWQabh2rAzTr96FGKQxAK
         r0aikr3jTyoS3DxaYwrKX5T7q8ls1Aq584uHk8oBkugOH6hSCm3cDIQyxqepV0cPOn
         QuUVL0k04OQP5WPYD9lo2wvJbSKKRMl3l9Xoaqhcad5u/ej2y8PCq9Y/ViixMdQHKb
         kLoMbizF1iqWwlOGrhJoNu2oVKogaWbBomZlQxjQ6TdKT504r9P8hqkIi9AwKZnZB1
         8OpYjxjN40TYgY15Ro/ABg0ylD2edugYItbNuT4lLwlr8I6X5zIoOE1csq+a+zruhC
         5itwstqUV7DNw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/19 2:32 AM, Mike Rapoport wrote:
> On Thu, Feb 07, 2019 at 11:56:48PM -0800, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
[...]
>> +/**
>> + * put_user_page() - release a gup-pinned page
>> + * @page:            pointer to page to be released
>> + *
>> + * Pages that were pinned via get_user_pages*() must be released via
>> + * either put_user_page(), or one of the put_user_pages*() routines
>> + * below. This is so that eventually, pages that are pinned via
>> + * get_user_pages*() can be separately tracked and uniquely handled. In
>> + * particular, interactions with RDMA and filesystems need special
>> + * handling.
>> + *
>> + * put_user_page() and put_page() are not interchangeable, despite this early
>> + * implementation that makes them look the same. put_user_page() calls must
> 
> I just hope we'll remember to update when the real implementation will be
> merged ;-)
> 
> Other than that, feel free to add
> 
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>	# docs
> 

Thanks for the review!

Yes, the follow-on patch that turns this into a real implementation is
posted [1], and its documentation is updated accordingly.

(I've already changed "@Returns" to "@Return" locally in that patch, btw.)

[1] https://lore.kernel.org/r/20190204052135.25784-5-jhubbard@nvidia.com

thanks,
-- 
John Hubbard
NVIDIA
