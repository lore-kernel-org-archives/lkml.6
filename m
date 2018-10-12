Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC80C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 22:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A25B20868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 22:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nT8X6RRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A25B20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbeJMGTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 02:19:42 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13316 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeJMGTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 02:19:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc123f50000>; Fri, 12 Oct 2018 15:45:09 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 12 Oct 2018 15:45:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 12 Oct 2018 15:45:06 -0700
Received: from [10.2.173.107] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 12 Oct
 2018 22:45:05 +0000
Subject: Re: [PATCH 1/6] mm: get_user_pages: consolidate error handling
To:     Balbir Singh <bsingharora@gmail.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20181012060014.10242-1-jhubbard@nvidia.com>
 <20181012060014.10242-2-jhubbard@nvidia.com> <20181012063034.GI8537@350D>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <090e5019-b1b9-fdc5-73a1-902164400fe2@nvidia.com>
Date:   Fri, 12 Oct 2018 15:45:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181012063034.GI8537@350D>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539384309; bh=HmSvI2dJbJlJCbivHEMd/3Ef67TqPOy5QK9qvRAe6Zo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=nT8X6RRJlNu+Zc5hraBRbiwSC4dt7Gbo+I9RlOztu+8jOzmKw4I7SG67Ti8t8Qd9a
         +vJMpqGtbwOsjFUGNjGSggK4cmWpgQZOwpPHb7Gjg6UWQVFiVYBy4sXF7r7EyPw/cm
         8Y1yDrdcRMpsRq1ya/lVq3YwN3RXy39Jtb6IGlthBKrOLa8jSL5oUB9XMIl9ZUFJw3
         DWSwgOA5fmR2u8jxD2NRQEB6A0Ir5fD/blUMjDKEl63R5IwyiI1eO8wm2D1uYhnthb
         mxHb3HhB6SgMQdGrKTBTUS0ix7BWbplH/kCem7yGZHRYWFm8MA8F5GlyPWt1G42SYo
         YNrxRkyNzRvTQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/18 11:30 PM, Balbir Singh wrote:
> On Thu, Oct 11, 2018 at 11:00:09PM -0700, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
>>
>> An upcoming patch requires a way to operate on each page that
>> any of the get_user_pages_*() variants returns.
>>
>> In preparation for that, consolidate the error handling for
>> __get_user_pages(). This provides a single location (the "out:" label)
>> for operating on the collected set of pages that are about to be returned.
>>
>> As long every use of the "ret" variable is being edited, rename
>> "ret" --> "err", so that its name matches its true role.
>> This also gets rid of two shadowed variable declarations, as a
>> tiny beneficial a side effect.
>>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
> 
> Looks good, might not be needed but
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>
> 

Thanks for the review, very good to have another set of eyes on
this one.

-- 
thanks,
John Hubbard
NVIDIA
