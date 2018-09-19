Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C040ECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE4A214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE4A214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbeISIN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 04:13:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12183 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725829AbeISIN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 04:13:27 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [10.3.19.211])
        by Forcepoint Email with ESMTP id 92709682A6104;
        Wed, 19 Sep 2018 10:37:49 +0800 (CST)
Received: from [127.0.0.1] (10.111.220.140) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Wed, 19 Sep 2018
 10:37:44 +0800
Subject: Re: [PATCH] f2fs: avoid GC causing encrypted file corrupted
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <chao@kernel.org>, <yuchao0@huawei.com>, <yunlong.song@icloud.com>,
        <miaoxie@huawei.com>, <bintian.wang@huawei.com>,
        <shengyong1@huawei.com>, <heyunlei@huawei.com>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1537274393-78441-1-git-send-email-yunlong.song@huawei.com>
 <20180918181705.GG91945@jaegeuk-macbookpro.roam.corp.google.com>
From:   Yunlong Song <yunlong.song@huawei.com>
Message-ID: <8f0e5fc7-cb22-47a0-30e8-4e3a25891e8b@huawei.com>
Date:   Wed, 19 Sep 2018 10:37:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180918181705.GG91945@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.111.220.140]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/9/19 2:17, Jaegeuk Kim wrote:
> On 09/18, Yunlong Song wrote:
>> The encrypted file may be corrupted by GC in following case:
>>
>> Time 1: | segment 1 blkaddr = A |  GC -> | segment 2 blkaddr = B |
>> Encrypted block 1 is moved from blkaddr A of segment 1 to blkaddr B of
>> segment 2,
>>
>> Time 2: | segment 1 blkaddr = B |  GC -> | segment 3 blkaddr = C |
>              segment 2 blkaddr = B?
Sorry for typing error.
Yes.
>
>> Before page 1 is written back and if segment 2 become a victim, then
>> page 1 is moved from blkaddr B of segment 2 to blkaddr Cof segment 3,
>                                                           C of ?
Yes.
>
>> during the GC process of Time 2, f2fs should wait for page 1 written back
>> before reading it, or move_data_block will read a garbage block from
>> blkaddr B since page is not written back to blkaddr B yet.
> move_data_block() checks PageUptodate() so it won't get garbage, yes?
> So, does ra_data_block need to check PageUptodate?
You mean if page 1 is read from blkaddr B before it is written back to 
blkaddr B, then
the page will become non-uptodate status, why? Is it because 
__read_end_io checks
"(bio->bi_status || PageError(page))" and ClearPageUptodate(page)?

>
>> Commit 6aa58d8a ("f2fs: readahead encrypted block during GC") introduce
>> ra_data_block to read encrypted block, but it forgets to add
>> f2fs_wait_on_page_writeback to avoid racing between GC and flush.
>>
>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>> ---
>>   fs/f2fs/gc.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index a4c1a41..c55fb62 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -641,6 +641,14 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
>>   	fio.page = page;
>>   	fio.new_blkaddr = fio.old_blkaddr = dn.data_blkaddr;
>>   
>> +	/*
>> +	 * don't cache encrypted data into meta inode until previous dirty
>> +	 * data were writebacked to avoid racing between GC and flush.
>> +	 */
>> +	f2fs_wait_on_page_writeback(page, DATA, true);
>> +
>> +	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
>> +
>>   	fio.encrypted_page = f2fs_pagecache_get_page(META_MAPPING(sbi),
>>   					dn.data_blkaddr,
>>   					FGP_LOCK | FGP_CREAT, GFP_NOFS);
>> @@ -723,6 +731,8 @@ static void move_data_block(struct inode *inode, block_t bidx,
>>   	 */
>>   	f2fs_wait_on_page_writeback(page, DATA, true);
>>   
>> +	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
>> +
>>   	err = f2fs_get_node_info(fio.sbi, dn.nid, &ni);
>>   	if (err)
>>   		goto put_out;
>> -- 
>> 1.8.5.2
> .
>

-- 
Thanks,
Yunlong Song


