Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD63C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F7020835
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 07:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="G3BOcRXq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F7020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbeJMPKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 11:10:19 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2088 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbeJMPKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 11:10:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc19fef0000>; Sat, 13 Oct 2018 00:34:07 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 13 Oct 2018 00:34:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 13 Oct 2018 00:34:13 -0700
Received: from [10.2.167.215] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 13 Oct
 2018 07:34:13 +0000
Subject: Re: [PATCH 4/6] mm: introduce page->dma_pinned_flags, _count
To:     Dave Chinner <david@fromorbit.com>
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
 <20181012060014.10242-5-jhubbard@nvidia.com> <20181013035516.GA18822@dastard>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <7c2e3b54-0b1d-6726-a508-804ef8620cfd@nvidia.com>
Date:   Sat, 13 Oct 2018 00:34:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181013035516.GA18822@dastard>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539416047; bh=/bb3AMg9e+Djf3tibPaDqqvLS5l6tMhsKXMx7F1n/D8=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=G3BOcRXqIHOxdV3aC94mYdSric4FDyeDquG+nvFTPLRePE1xH5NYgiDLHu6Z5BYjy
         EAl5D8KaRrDQj09MqrAySppBtlMZ6O5l+YN1Hp70b7GpFvox4zzrhJqblEonr+bFa8
         59LBlXiAyuYBYul9KcHN381GUGk+qwQMX8DH3Wr76EqCQn5PSiHIk3VFyXB+lllHiP
         9lYKDeSzBEU7IHMolGkxM5p6T/XqW16gZfVLKALuGS3m7VaVc1r8GXnovunCnXBd+5
         mmJDY3g/w2VMlbGitheW4YZq0jWDo0hNrYmlWiAsx0aF3l6cimIqxUSTfCx2gCfpR3
         gByApFXA4R5HQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/18 8:55 PM, Dave Chinner wrote:
> On Thu, Oct 11, 2018 at 11:00:12PM -0700, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
[...]
>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>> index 5ed8f6292a53..017ab82e36ca 100644
>> --- a/include/linux/mm_types.h
>> +++ b/include/linux/mm_types.h
>> @@ -78,12 +78,22 @@ struct page {
>>  	 */
>>  	union {
>>  		struct {	/* Page cache and anonymous pages */
>> -			/**
>> -			 * @lru: Pageout list, eg. active_list protected by
>> -			 * zone_lru_lock.  Sometimes used as a generic list
>> -			 * by the page owner.
>> -			 */
>> -			struct list_head lru;
>> +			union {
>> +				/**
>> +				 * @lru: Pageout list, eg. active_list protected
>> +				 * by zone_lru_lock.  Sometimes used as a
>> +				 * generic list by the page owner.
>> +				 */
>> +				struct list_head lru;
>> +				/* Used by get_user_pages*(). Pages may not be
>> +				 * on an LRU while these dma_pinned_* fields
>> +				 * are in use.
>> +				 */
>> +				struct {
>> +					unsigned long dma_pinned_flags;
>> +					atomic_t      dma_pinned_count;
>> +				};
>> +			};
> 
> Isn't this broken for mapped file-backed pages? i.e. they may be
> passed as the user buffer to read/write direct IO and so the pages
> passed to gup will be on the active/inactive LRUs. hence I can't see
> how you can have dual use of the LRU list head like this....
> 
> What am I missing here?

Hi Dave,

In patch 6/6, pin_page_for_dma(), which is called at the end of get_user_pages(),
unceremoniously rips the pages out of the LRU, as a prerequisite to using
either of the page->dma_pinned_* fields. 

The idea is that LRU is not especially useful for this situation anyway,
so we'll just make it one or the other: either a page is dma-pinned, and
just hanging out doing RDMA most likely (and LRU is less meaningful during that
time), or it's possibly on an LRU list.


-- 
thanks,
John Hubbard
NVIDIA
