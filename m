Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC76C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 01:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3DE21928
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 01:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404214AbeLVBMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 20:12:00 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:47440 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732140AbeLVBMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 20:12:00 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04389;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TGLpJVy_1545440952;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TGLpJVy_1545440952)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 22 Dec 2018 09:09:15 +0800
Subject: Re: [v3 PATCH 1/2] mm: swap: check if swap backing device is
 congested or not
To:     Tim Chen <tim.c.chen@linux.intel.com>, ying.huang@intel.com,
        tim.c.chen@intel.com, minchan@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1545428420-126557-1-git-send-email-yang.shi@linux.alibaba.com>
 <ead38fbf-50e4-e03c-48eb-c1666e78aeda@linux.intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <ea873cff-4aad-06a3-bdc1-ad011f11c7d2@linux.alibaba.com>
Date:   Fri, 21 Dec 2018 17:09:07 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ead38fbf-50e4-e03c-48eb-c1666e78aeda@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/21/18 2:42 PM, Tim Chen wrote:
> On 12/21/18 1:40 PM, Yang Shi wrote:
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
>> Just does the check in vma_cluster_readahead() since
>> swap_vma_readahead() is just used for non-rotational device which
>> much less likely has congestion than traditional HDD.
>>
>> Although swap slots may be consecutive on swap partition, it still may be
>> fragmented on swap file. This check would help to reduce excessive stall
>> for such case.
>>
>> Cc: Huang Ying <ying.huang@intel.com>
>> Cc: Tim Chen <tim.c.chen@intel.com>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>> v3: Move inode deference under swap device type check per Tim Chen
>> v2: Check the swap device type per Tim Chen
>>
>>   mm/swap_state.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/mm/swap_state.c b/mm/swap_state.c
>> index fd2f21e..78d500e 100644
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
>> +		inode = si->swap_file->f_mapping->host;
>> +		if (inode_read_congested(inode))
>> +			goto skip;
>> +	}
>> +
>>   	do_poll = false;
>>   	/* Read a page_cluster sized and aligned cluster around offset. */
>>   	start_offset = offset & ~mask;
>>
> Acked-by: Tim Chen <tim.c.chen@linux.intel.com>

Thanks. Happy holiday.

