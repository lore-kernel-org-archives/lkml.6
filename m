Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B95CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 005D621927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389434AbeLUSyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:54:38 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:34376 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731021AbeLUSyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:54:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07449;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TGL1Hog_1545418274;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TGL1Hog_1545418274)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 22 Dec 2018 02:51:17 +0800
Subject: Re: [v2 PATCH 1/2] mm: swap: check if swap backing device is
 congested or not
To:     Tim Chen <tim.c.chen@linux.intel.com>, ying.huang@intel.com,
        tim.c.chen@intel.com, minchan@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1545351679-23596-1-git-send-email-yang.shi@linux.alibaba.com>
 <c3c77f08-f7af-7633-636d-c467759fbf20@linux.intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <6878473d-3d3a-bbab-e187-f618c17db044@linux.alibaba.com>
Date:   Fri, 21 Dec 2018 10:51:11 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c3c77f08-f7af-7633-636d-c467759fbf20@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/21/18 10:34 AM, Tim Chen wrote:
> On 12/20/18 4:21 PM, Yang Shi wrote:
>
>> --- a/mm/swap_state.c
>> +++ b/mm/swap_state.c
>> @@ -538,11 +538,17 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>>   	bool do_poll = true, page_allocated;
>>   	struct vm_area_struct *vma = vmf->vma;
>>   	unsigned long addr = vmf->address;
>> +	struct inode *inode = si->swap_file->f_mapping->host;
>>   
>>   	mask = swapin_nr_pages(offset) - 1;
>>   	if (!mask)
>>   		goto skip;
>>   
>> +	if (si->flags & (SWP_BLKDEV | SWP_FS)) {
> Maybe move the inode dereference here:
>
> 		inode = si->swap_file->f_mapping->host;

Yes, it looks better since nobody deference inode except the below code. 
Will fix in v3.

Thanks,
Yang

>
>> +		if (inode_read_congested(inode))
>> +			goto skip;
>> +	}
>> +
> Thanks.
>
> Tim

