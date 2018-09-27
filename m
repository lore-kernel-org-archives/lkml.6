Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE92C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19B921537
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19B921537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeI0MEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 08:04:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51846 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726687AbeI0MEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 08:04:42 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9DDC7721F3921;
        Thu, 27 Sep 2018 13:48:09 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Thu, 27 Sep 2018
 13:48:09 +0800
Subject: Re: [PATCH] f2fs: refactor ->page_mkwrite() flow
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20180926144552.3302-1-chao@kernel.org>
 <20180927050509.GA72357@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <3bed1658-e24a-c114-3079-62f444c613bc@huawei.com>
Date:   Thu, 27 Sep 2018 13:48:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927050509.GA72357@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/27 13:05, Jaegeuk Kim wrote:
> This makes xfstests/083 stuck. So, I'll drop it for a while.

Alright, let me check that case again.

Thanks,

> 
> On 09/26, Chao Yu wrote:
>> From: Chao Yu <yuchao0@huawei.com>
>>
>> Thread A				Thread B
>> - f2fs_vm_page_mkwrite
>> 					- f2fs_setattr
>> 					 - down_write(i_mmap_sem)
>> 					 - truncate_setsize
>> 					 - f2fs_truncate
>> 					 - up_write(i_mmap_sem)
>>  - f2fs_reserve_block
>>  reserve NEW_ADDR
>>  - skip dirty page due to truncation
>>
>> 1. we don't need to rserve new block address for a truncated page.
>> 2. dn.data_blkaddr is used out of node page lock coverage.
>>
>> Refactor ->page_mkwrite() flow to fix above issues:
>> - use __do_map_lock() to avoid racing checkpoint()
>> - lock data page in prior to dnode page
>> - cover f2fs_reserve_block with i_mmap_sem lock
>> - access dn.data_blkaddr under dnode lock
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/file.c | 29 ++++++++++++++---------------
>>  1 file changed, 14 insertions(+), 15 deletions(-)
>>
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 6f02c8daff76..fcb4788b48aa 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -47,7 +47,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>>  	struct page *page = vmf->page;
>>  	struct inode *inode = file_inode(vmf->vma->vm_file);
>>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>> -	struct dnode_of_data dn;
>> +	struct dnode_of_data dn = { .node_changed = false };
>>  	int err;
>>  
>>  	if (unlikely(f2fs_cp_error(sbi))) {
>> @@ -59,19 +59,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>>  
>>  	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
>>  
>> -	/* block allocation */
>> -	f2fs_lock_op(sbi);
>> -	set_new_dnode(&dn, inode, NULL, NULL, 0);
>> -	err = f2fs_reserve_block(&dn, page->index);
>> -	if (err) {
>> -		f2fs_unlock_op(sbi);
>> -		goto out;
>> -	}
>> -	f2fs_put_dnode(&dn);
>> -	f2fs_unlock_op(sbi);
>> -
>> -	f2fs_balance_fs(sbi, dn.node_changed);
>> -
>>  	file_update_time(vmf->vma->vm_file);
>>  	down_read(&F2FS_I(inode)->i_mmap_sem);
>>  	lock_page(page);
>> @@ -108,12 +95,24 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
>>  	/* fill the page */
>>  	f2fs_wait_on_page_writeback(page, DATA, false);
>>  
>> +	/* block allocation */
>> +	__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);
>> +	set_new_dnode(&dn, inode, NULL, NULL, 0);
>> +	err = f2fs_reserve_block(&dn, page->index);
>> +	if (err)
>> +		goto out_unlock;
>> +
>>  	/* wait for GCed page writeback via META_MAPPING */
>>  	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
>>  
>> +	f2fs_put_dnode(&dn);
>> +out_unlock:
>> +	__do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
>>  out_sem:
>>  	up_read(&F2FS_I(inode)->i_mmap_sem);
>> -out:
>> +
>> +	f2fs_balance_fs(sbi, dn.node_changed);
>> +
>>  	sb_end_pagefault(inode->i_sb);
>>  	f2fs_update_time(sbi, REQ_TIME);
>>  err:
>> -- 
>> 2.18.0
> 
> .
> 

