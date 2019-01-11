Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4053CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1850D2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfAKA6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:58:45 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:56924 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726149AbfAKA6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:58:44 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01451;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0THzbz1J_1547168190;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0THzbz1J_1547168190)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 11 Jan 2019 08:56:33 +0800
Subject: Re: [v5 PATCH 1/2] mm: swap: check if swap backing device is
 congested or not
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     ying.huang@intel.com, tim.c.chen@intel.com, minchan@kernel.org,
        daniel.m.jordan@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1546543673-108536-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190110153147.1baf4c88bf0dd3b8a78aad08@linux-foundation.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <bbc7bda7-62d0-df1a-23ef-d369e865bdca@linux.alibaba.com>
Date:   Thu, 10 Jan 2019 16:56:29 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190110153147.1baf4c88bf0dd3b8a78aad08@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/19 3:31 PM, Andrew Morton wrote:
> On Fri,  4 Jan 2019 03:27:52 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
>> Swap readahead would read in a few pages regardless if the underlying
>> device is busy or not.  It may incur long waiting time if the device is
>> congested, and it may also exacerbate the congestion.
>>
>> Use inode_read_congested() to check if the underlying device is busy or
>> not like what file page readahead does.  Get inode from swap_info_struct.
>> Although we can add inode information in swap_address_space
>> (address_space->host), it may lead some unexpected side effect, i.e.
>> it may break mapping_cap_account_dirty().  Using inode from
>> swap_info_struct seems simple and good enough.
>>
>> ...
>>
>> --- a/mm/swap_state.c
>> +++ b/mm/swap_state.c
>> @@ -538,11 +538,18 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>>   	bool do_poll = true, page_allocated;
>>   	struct vm_area_struct *vma = vmf->vma;
>>   	unsigned long addr = vmf->address;
>> +	struct inode *inode = NULL;
>>   
>>   	mask = swapin_nr_pages(offset) - 1;
>>   	if (!mask)
>>   		goto skip;
>>   
>> +	if (si->flags & (SWP_BLKDEV | SWP_FS)) {
> I re-read your discussion with Tim and I must say the reasoning behind
> this test remain foggy.
>
> What goes wrong if we just remove it?

I saw Tim already answered this.

>
> What is the status of shmem swap readahead?

shmem swap readahead will be skipped too if the underlying device is 
congested.

>
> Can we at least get a comment in here which explains the reasoning?

How about like this:

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 3f63bb7..85245fd 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -543,7 +543,8 @@ struct page *swap_cluster_readahead(swp_entry_t 
entry, gfp_t gfp_mask,
         if (!mask)
                 goto skip;

-       if (si->flags & (SWP_BLKDEV | SWP_FS)) {
+       /* Test swap type to make sure the dereference is safe */
+       if (likely(si->flags & (SWP_BLKDEV | SWP_FS))) {
                 struct inode *inode = si->swap_file->f_mapping->host;
                 if (inode_read_congested(inode))
                         goto skip;

Tim is worried about the deference might be not safe for some corner 
case, the corner cases sound unlikely by code inspection. So, added 
"likely" in the if statement.

Thanks,
Yang

>
> Thanks.
>
>> +		inode = si->swap_file->f_mapping->host;
>> +		if (inode_read_congested(inode))
>> +			goto skip;
>> +	}
>> +
>>   	do_poll = false;
>>   	/* Read a page_cluster sized and aligned cluster around offset. */

