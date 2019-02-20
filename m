Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314E4C10F07
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029B52146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 20:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="A2BulD4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfBTUWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 15:22:32 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11622 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfBTUWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 15:22:32 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6db70d0000>; Wed, 20 Feb 2019 12:22:37 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 20 Feb 2019 12:22:31 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 20 Feb 2019 12:22:31 -0800
Received: from [10.2.169.124] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 20 Feb
 2019 20:22:30 +0000
Subject: Re: [PATCH 4/6] mm/gup: track gup-pinned pages
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
References: <20190204052135.25784-1-jhubbard@nvidia.com>
 <20190204052135.25784-5-jhubbard@nvidia.com>
 <20190220192405.GA12114@iweiny-DESK2.sc.intel.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <2c7f6914-71ab-c3a0-d043-b25e1d55a9ce@nvidia.com>
Date:   Wed, 20 Feb 2019 12:22:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190220192405.GA12114@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550694157; bh=xaPm9bOl46WttgSnpiat/PG46CKSbX8nCiFiaT9SwHE=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=A2BulD4LCH07dOSBUhThGzWNUfUExCrX+0oDsuP3ymsZCyxIxxPfpkJbxYf5+eg0z
         V/yOVnEg66OS94CZ/nrMqTwXu9rRqooR+mHf1aclv97tGTs1FAC9SG+Z4m4ghWkGJ6
         6ab0eiOUU5O5OH5Mu989C3llz2w3BtQvtW7rj1UsQowRcWcFYcQvDnSOqZQF+Mrbxb
         OK+1MKgx9135oeKn4nvT7FcIDf5VCCncUPKP9Zikx7Iyaul7JxpBqBDtx8iNUcjnsl
         qOoNwE3nNIPHS1dN1sEjEu1na9B1iTpQSpra9ZE8xvszPKMarxCVqjghfgRtpBUO98
         c133tkaCAR8tA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/19 11:24 AM, Ira Weiny wrote:
> On Sun, Feb 03, 2019 at 09:21:33PM -0800, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
> [snip]
>> + *
>> + * Locking: the lockless algorithm described in page_cache_gup_pin_speculative()
>> + * and page_cache_gup_pin_speculative() provides safe operation for
> 
> Did you mean:
> 
> page_cache_gup_pin_speculative and __ page_cache_get_speculative __?
> 
> Just found this while looking at your branch.
> 
> Sorry,
> Ira
> 

Hi Ira,

Yes, thanks for catching that. I've changed it in the git repo now, and it will
show up when the next spin of this patchset goes out.

thanks,
-- 
John Hubbard
NVIDIA
