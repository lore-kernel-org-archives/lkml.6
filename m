Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A992BC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4ED21934
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="m8rpA8Tx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfBOAy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:54:29 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5377 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfBOAy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:54:28 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c660d9e0000>; Thu, 14 Feb 2019 16:53:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 14 Feb 2019 16:54:26 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 14 Feb 2019 16:54:26 -0800
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 15 Feb
 2019 00:54:25 +0000
Subject: Re: [PATCH 0/2] mm: put_user_page() call site conversion first
To:     Ira Weiny <ira.weiny@intel.com>, <john.hubbard@gmail.com>
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
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20190208075649.3025-1-jhubbard@nvidia.com>
 <20190215002312.GC7512@iweiny-DESK2.sc.intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <4a326c1d-0ebb-5463-f7ed-8461bfa489df@nvidia.com>
Date:   Thu, 14 Feb 2019 16:54:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190215002312.GC7512@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550192030; bh=OHV4QGJwXMt6cTDDR9gAJliF74InHPXXIremhlCNuPU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=m8rpA8TxgQeOBZs6mHboNH4I3SHtCGoBV0ITcxs6fERzRDWqgDqPJjZff0Dg/YUj7
         T2/6Qkxi6BRGl5QQRUqDDDHQoVj9g3wg2eb+6pHyCC/4vg+2UhunQ1OAXjw6kF40GZ
         qlIXVrMYsxZz7j4PLMKoaUzyK2q8AYAp8VEzjRIgpS5ScP/34yIG6d7UVivcEb46hO
         EWsK9dpg7heuwwZbsFmhy3UJGOE3V7FUsZe/Ui+knZpWNw/w5f2sakQedbtizKGYpd
         vPbrGtVl1HQJcIZBOYQj/lSHOJMGSa49MyOC1TOnvrGofejPRb2Dp2otF+Vuoej7zm
         GARy95cWHm/kg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/19 4:23 PM, Ira Weiny wrote:
> On Thu, Feb 07, 2019 at 11:56:47PM -0800, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
[...]
>>   mm: introduce put_user_page*(), placeholder versions
>>   infiniband/mm: convert put_page() to put_user_page*()
> 
> A bit late but, FWIW:
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 
> John these are the pages sitting in your gup_dma/first_steps branch here,
> correct?
> 
> https://github.com/johnhubbard/linux.git
> 

That's an old branch. In fact, just deleted it now, in order to avoid further
confusion.

This is the current branch: 

    gup_dma_core 

in that same git repo. It has the current set of call site conversions. 
Please note that there are a lot of conversions that are either incomplete
or likely just plain wrong, at this point, but it is sufficient to at least 
boot up and run things such as fio(1).



thanks,
-- 
John Hubbard
NVIDIA
