Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984DEECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A66F21557
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 14:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8QbrBF/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A66F21557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389759AbeIUUJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 16:09:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727392AbeIUUJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 16:09:36 -0400
Received: from [192.168.0.101] (unknown [222.95.226.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58C5421547;
        Fri, 21 Sep 2018 14:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537539630;
        bh=h5gCYzsj1WgZwznh75O2Anppa+/A0aXCYMyxwnGqygo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=A8QbrBF/ZdQ50EhXrtCVtWsV/a4vfX+FbJjUSLAXr8aDWjontNxWcULDwvNJUnrzS
         4Wjl/Hv932QEQtWuF4LMoE0BbH5+9fSce2R6sW47uPNdNxGCXMWOeMQF3dUtyoPAe+
         UKyxLXuYXzCe20sbBFBxm82tdg/WgMzyIaXb2/8A=
Subject: Re: [PATCH] f2fs: avoid GC causing encrypted file corrupted
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Yunlong Song <yunlong.song@huawei.com>
Cc:     yuchao0@huawei.com, yunlong.song@icloud.com, miaoxie@huawei.com,
        bintian.wang@huawei.com, shengyong1@huawei.com,
        heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <1537274393-78441-1-git-send-email-yunlong.song@huawei.com>
 <20180918181705.GG91945@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <aa837149-1dc3-9b75-a54c-00703781b2b4@kernel.org>
Date:   Fri, 21 Sep 2018 22:20:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918181705.GG91945@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
> 
>             segment 2 blkaddr = B?
> 
>>
>> Before page 1 is written back and if segment 2 become a victim, then
>> page 1 is moved from blkaddr B of segment 2 to blkaddr Cof segment 3,
> 
>                                                          C of ?
> 
>> during the GC process of Time 2, f2fs should wait for page 1 written back
>> before reading it, or move_data_block will read a garbage block from
>> blkaddr B since page is not written back to blkaddr B yet.
> 
> move_data_block() checks PageUptodate() so it won't get garbage, yes?

I think the problem here is:

Thread A				Background GC Thread
- writepage
 - f2fs_outplace_write_data
 fio->encrypted_page is in-flight
					- gc_data_segment
					 - ra_data_block
					  - f2fs_pagecache_get_page
					  - f2fs_submit_page_bio
					  cache garbage data in meta page
Device
Receive encrypted data
- f2fs_write_end_io
					 - move_data_block
					  - f2fs_pagecache_get_page
					  - if (PageUptodate(mpage)) memcpy()
					  So here we copy garbage data into meta page
					  - f2fs_submit_page_write
					  Here we migrate incorrect data to new address

> So, does ra_data_block need to check PageUptodate?

Yes, I think so, could improve this in another patch.

Thanks,

> 
>>
>> Commit 6aa58d8a ("f2fs: readahead encrypted block during GC") introduce
>> ra_data_block to read encrypted block, but it forgets to add
>> f2fs_wait_on_page_writeback to avoid racing between GC and flush.
>>
>> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
>> ---
>>  fs/f2fs/gc.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index a4c1a41..c55fb62 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -641,6 +641,14 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
>>  	fio.page = page;
>>  	fio.new_blkaddr = fio.old_blkaddr = dn.data_blkaddr;
>>  
>> +	/*
>> +	 * don't cache encrypted data into meta inode until previous dirty
>> +	 * data were writebacked to avoid racing between GC and flush.
>> +	 */
>> +	f2fs_wait_on_page_writeback(page, DATA, true);
>> +
>> +	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
>> +
>>  	fio.encrypted_page = f2fs_pagecache_get_page(META_MAPPING(sbi),
>>  					dn.data_blkaddr,
>>  					FGP_LOCK | FGP_CREAT, GFP_NOFS);
>> @@ -723,6 +731,8 @@ static void move_data_block(struct inode *inode, block_t bidx,
>>  	 */
>>  	f2fs_wait_on_page_writeback(page, DATA, true);
>>  
>> +	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
>> +
>>  	err = f2fs_get_node_info(fio.sbi, dn.nid, &ni);
>>  	if (err)
>>  		goto put_out;
>> -- 
>> 1.8.5.2
