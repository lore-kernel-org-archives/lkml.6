Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DD1C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F200F2077B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OO0ZZE3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfBEV4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 16:56:02 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4380 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfBEV4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 16:56:01 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5a06500000>; Tue, 05 Feb 2019 13:55:28 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 05 Feb 2019 13:56:00 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 05 Feb 2019 13:56:00 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 5 Feb
 2019 21:55:59 +0000
Subject: Re: [PATCH 0/6] RFC v2: mm: gup/dma tracking
To:     Tom Talpey <tom@talpey.com>, <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
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
        LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20190204052135.25784-1-jhubbard@nvidia.com>
 <dbca5400-b0c0-0958-c3ba-ff672f301799@talpey.com>
 <80d503f5-038b-7f0b-90d5-e5b9537ae1df@nvidia.com>
 <303ab506-62b7-ee6d-27a0-a818c7ff6473@talpey.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <e2bac0b5-f81f-c2f1-95eb-214c64e89ee0@nvidia.com>
Date:   Tue, 5 Feb 2019 13:55:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <303ab506-62b7-ee6d-27a0-a818c7ff6473@talpey.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549403729; bh=wMhcdXCHqf6V6KTLtjLRAAlffUFv2sOj48RQqhjWWzg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=OO0ZZE3qlHVf7SLdzkvxMWo8XPxxiTP0f0GbZjWPp4EwFzG8T3wH/G90QrC6UY+cr
         JCi0vR8kO1CQ3Zdhp4G2h1lQf45kXjhbwe5mTO4TNxbZE0we2A/YGY3MMqhK/nrdEE
         eyAjKEEabxwN341c/4qSWtvue/sbKfSrwdWIgLYquHT71qrxziTp4K0ntquXnOw2ZM
         5eWdd0BVHj9lyakmUVr4gl3zoIcsDVAX62yvqMpjjBJaMPrL1mTJCPZD9NwZ1X3Tbq
         yEDowBywN1BKTGq6Ewl5ClbhZ+Scn8ItHzjdc4m6fYhwAqBSq171mOvpyyauKHBgmU
         ohRJzyuCO5GNg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/19 5:38 AM, Tom Talpey wrote:
> 
> Ok, I'm satisfied the four-9's latency spike is in not your code. :-)
> Results look good relative to baseline. Thanks for doublechecking!
> 
> Tom.


Great, in that case, I'll put the new before-and-after results in the next 
version. Appreciate your help here, as always!

thanks,
-- 
John Hubbard
NVIDIA
