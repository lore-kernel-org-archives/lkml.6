Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82D6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887F020811
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 23:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbeLSXxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 18:53:04 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:39362 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727171AbeLSXxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 18:53:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04392;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TGAnCed_1545263334;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TGAnCed_1545263334)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 20 Dec 2018 07:48:56 +0800
Subject: Re: [RFC PATCH 1/2] mm: swap: check if swap backing device is
 congested or not
To:     Tim Chen <tim.c.chen@linux.intel.com>, ying.huang@intel.com,
        tim.c.chen@intel.com, minchan@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1545115948-25467-1-git-send-email-yang.shi@linux.alibaba.com>
 <6a51d47a-b87f-b0f1-4dae-843730dba698@linux.intel.com>
 <03462367-3f75-4907-8c5e-526a919e5cf3@linux.alibaba.com>
 <c0290c77-87ba-32bf-8ed0-d42a322d3d06@linux.intel.com>
 <606b73ed-da62-fdd1-71da-c4de7a02e837@linux.alibaba.com>
 <bc63155c-39b4-02b0-4045-da51022dbff5@linux.intel.com>
 <2df52dc3-ae66-0ab8-459e-49f49eaa569c@linux.alibaba.com>
 <50e14a30-97bb-06c6-ae6a-74e6dc827713@linux.intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <385ffd4f-d903-6e2f-e80e-7d3797885c54@linux.alibaba.com>
Date:   Wed, 19 Dec 2018 15:48:53 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <50e14a30-97bb-06c6-ae6a-74e6dc827713@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/19/18 11:00 AM, Tim Chen wrote:
> On 12/19/18 10:40 AM, Yang Shi wrote:
>>
>>>>> I don't think your dereference inode = si->swap_file->f_mapping->host
>>>>> is always safe.  You should do it only when (si->flags & SWP_FS) is true.
>>>> Do you mean it is not safe for swap partition?
>>> The f_mapping may not be instantiated.  It is only done for SWP_FS.
>> Really? I saw the below calls in swapon:
>>
>> swap_file = file_open_name(name, O_RDWR|O_LARGEFILE, 0);
>> ...
>> p->swap_file = swap_file;
>> mapping = swap_file->f_mapping;
>> inode = mapping->host;
>> ...
>>
>> Then the below code manipulates the inode.
>>
>> And, trace shows file_open_name() does call blkdev_open if it is turning block device swap on. And, blkdev_open() would return instantiated address_space and inode.
>>
>> Am I missing something?
>>
> I was trying to limit the congestion logic for block devices backed swap.
> So the check I had in mind should really be "si->flags & SWP_BLKDEV"
> instead of si->flags & SWP_FS.  I was concerned that there could
> be other use cases where the inode dereference is invalid.
>
> Looking at the code a bit more, looks like swap_cluster_readahead is not
> used for other special case swap usage (like page migration).  So
> you would a proper swapfile and inode here.  But I think it is still

Yes, just swap page fault and shmem calls this function. Actually, your 
above concern is valid if the inode were added into swap_address_space 
(address_space->host). I did this in my first attempt, and found out it 
may break some assumption in clear_page_dirty_for_io() and migration.

So, I made the patch as it is.

> a good idea to have a check for SWP_BLKDEV in si->flags.

I don't get your point why it should be block dev swap only. IMHO, block 
dev swap should be less likely fragmented and congested than swap file, 
right? Block dev swap could be a dedicated physical device, but swap 
file has to be with filesystem.

It sounds reasonable to me to have this check for swap file only. 
However, to be honest, it sounds not hurt to have both.

Thanks,
Yang

>
> Thanks.
>
> Tim
>   
>

