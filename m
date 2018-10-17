Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E660C5ACCC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F8E214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gPvh6/GS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F8E214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeJQJlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:41:42 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10489 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeJQJll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:41:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bc694e50000>; Tue, 16 Oct 2018 18:48:21 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 16 Oct 2018 18:48:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 16 Oct 2018 18:48:24 -0700
Received: from [10.2.167.215] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 17 Oct
 2018 01:48:23 +0000
Subject: Re: [PATCH 4/6] mm: introduce page->dma_pinned_flags, _count
To:     Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
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
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <a9f1df2f-da9d-bf7b-b977-d3d3ca710776@nvidia.com>
Date:   Tue, 16 Oct 2018 18:48:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181016085102.GB18918@quack2.suse.cz>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1539740901; bh=b4/mJam0D1fhRUlyqVCwxK8d3kEQAgqNaK05DHLC8H0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=gPvh6/GSAXbWNCowYe4KAQjnUnW5aDWuxE6PJWdW8aIRiIl05z6Co3ecpR+Mt4ttS
         9cWhuDneyBmZi1FRwzi6YYKDa9RfhLlRDLVz/krw3Im8gNWLOxSxVFHamcHH7++XI2
         EaTW8AKwVFU8myZ/9n4wdXzT09EpuXj1sGeB9zU5Q/HhZFu3ZP8/otlbjys9+hqpAJ
         o81b8KlSxZKn0dt1MDTTLZymhiI6ohs2EZqKw2UyNq63HAA39xGqOBdVgAvVSPfv6r
         uyFQaZlRq2/WbXffPgtT3mqZpVAQNMJP67iYXtVWRmIG4DPy5xRs8iRSB91Yn1H3L5
         Q1ltLPefL50GQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/18 1:51 AM, Jan Kara wrote:
> On Sun 14-10-18 10:01:24, Dave Chinner wrote:
>> On Sat, Oct 13, 2018 at 12:34:12AM -0700, John Hubbard wrote:
>>> On 10/12/18 8:55 PM, Dave Chinner wrote:
>>>> On Thu, Oct 11, 2018 at 11:00:12PM -0700, john.hubbard@gmail.com wrote:
>>>>> From: John Hubbard <jhubbard@nvidia.com>
>>> [...]
>>>>> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
>>>>> index 5ed8f6292a53..017ab82e36ca 100644
>>>>> --- a/include/linux/mm_types.h
>>>>> +++ b/include/linux/mm_types.h
>>>>> @@ -78,12 +78,22 @@ struct page {
>>>>>  	 */
>>>>>  	union {
>>>>>  		struct {	/* Page cache and anonymous pages */
>>>>> -			/**
>>>>> -			 * @lru: Pageout list, eg. active_list protected by
>>>>> -			 * zone_lru_lock.  Sometimes used as a generic list
>>>>> -			 * by the page owner.
>>>>> -			 */
>>>>> -			struct list_head lru;
>>>>> +			union {
>>>>> +				/**
>>>>> +				 * @lru: Pageout list, eg. active_list protected
>>>>> +				 * by zone_lru_lock.  Sometimes used as a
>>>>> +				 * generic list by the page owner.
>>>>> +				 */
>>>>> +				struct list_head lru;
>>>>> +				/* Used by get_user_pages*(). Pages may not be
>>>>> +				 * on an LRU while these dma_pinned_* fields
>>>>> +				 * are in use.
>>>>> +				 */
>>>>> +				struct {
>>>>> +					unsigned long dma_pinned_flags;
>>>>> +					atomic_t      dma_pinned_count;
>>>>> +				};
>>>>> +			};
>>>>
>>>> Isn't this broken for mapped file-backed pages? i.e. they may be
>>>> passed as the user buffer to read/write direct IO and so the pages
>>>> passed to gup will be on the active/inactive LRUs. hence I can't see
>>>> how you can have dual use of the LRU list head like this....
>>>>
>>>> What am I missing here?
>>>
>>> Hi Dave,
>>>
>>> In patch 6/6, pin_page_for_dma(), which is called at the end of get_user_pages(),
>>> unceremoniously rips the pages out of the LRU, as a prerequisite to using
>>> either of the page->dma_pinned_* fields. 
>>
>> How is that safe? If you've ripped the page out of the LRU, it's no
>> longer being tracked by the page cache aging and reclaim algorithms.
>> Patch 6 doesn't appear to put these pages back in the LRU, either,
>> so it looks to me like this just dumps them on the ground after the
>> gup reference is dropped.  How do we reclaim these page cache pages
>> when there is memory pressure if they aren't in the LRU?
> 
> Yeah, that's a bug in patch 6/6 (possibly in ClearPageDmaPinned). It should
> return the page to the LRU from put_user_page().
> 

Yes. Ugh, the LRU handling in this series is definitely not all there yet:
probably need to track (in the page->dma_pinned_flags) which LRU (if any) each 
page was taken from. 

It's hard to say exactly what the active/inactive/unevictable list should
be when DMA is done and put_user_page*() is called, because we don't know
if some device read, wrote, or ignored any of those pages. Although if 
put_user_pages_dirty() is called, that's an argument for "active", at least.

And maybe this will all be pointless if the DIRECT_IO performance test, that
Christoph requested, shows that LRU operations are too expensive here, anyway.
I wonder if we should just limit this to 64-bit arches and find a real
page flag...well, let's see what the testing shows first I suppose.

-- 
thanks,
John Hubbard
NVIDIA
