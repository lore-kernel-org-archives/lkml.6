Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A8EF83CA1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 06:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA61820893
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 06:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsYcVi/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA61820893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbeG2HcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 03:32:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbeG2HcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 03:32:18 -0400
Received: from [192.168.0.101] (unknown [180.111.102.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FE0320873;
        Sun, 29 Jul 2018 06:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532844183;
        bh=3FFW3zpLyDlYDYwkO1BxvZMT9zOWFGswIalmk2fMRbA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VsYcVi/MvcoI9BK7rJCko/bk8C5SmMsEQnicLgXpE8x/6sxvW33FvP9ctpzsQEeqk
         4MvUQLo8EjvWQSBZ2z/ocfHK4mgcbvx636+O0SfPSkJvfKXT7n8+gQqMVHFgxJbnxN
         sBWlGYSzF7JeT1ssRNibvFsg1IFEFfRSia7WWX0Q=
Subject: Re: [PATCH 3/4] f2fs: fix avoid race between truncate and background
 GC
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20180727101516.41403-1-yuchao0@huawei.com>
 <20180727101516.41403-3-yuchao0@huawei.com>
 <20180729015806.GF83620@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <39022876-5d16-c78a-4869-a316a5021384@kernel.org>
Date:   Sun, 29 Jul 2018 14:02:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180729015806.GF83620@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/29 9:58, Jaegeuk Kim wrote:
> On 07/27, Chao Yu wrote:
>> Thread A				Background GC
>> - f2fs_setattr isize to 0
>>  - truncate_setsize
>> 					- gc_data_segment
>> 					 - f2fs_get_read_data_page page #0
>> 					  - set_page_dirty
>> 					  - set_cold_data
>>  - f2fs_truncate
>>
>> - f2fs_setattr isize to 4k
>> - read 4k <--- hit data in cached page #0
>>
>> Above race condition can cause read out invalid data in a truncated
>> page, fix it by i_gc_rwsem[WRITE] lock.
> 
> We can truncate pages again after f2fs_truncate()?

I think it can fix this issue, although it looks a little strange to truncate
page cache twice.

Thanks,

> 
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/data.c |  4 ++++
>>  fs/f2fs/file.c | 33 +++++++++++++++++++--------------
>>  2 files changed, 23 insertions(+), 14 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 071224ded5f4..a29f3162b887 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -2214,10 +2214,14 @@ static void f2fs_write_failed(struct address_space *mapping, loff_t to)
>>  	loff_t i_size = i_size_read(inode);
>>  
>>  	if (to > i_size) {
>> +		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>  		down_write(&F2FS_I(inode)->i_mmap_sem);
>> +
>>  		truncate_pagecache(inode, i_size);
>>  		f2fs_truncate_blocks(inode, i_size, true);
>> +
>>  		up_write(&F2FS_I(inode)->i_mmap_sem);
>> +		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>  	}
>>  }
>>  
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index 7bd2412a8c37..ed5c9b0e0d0c 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -796,22 +796,25 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
>>  	}
>>  
>>  	if (attr->ia_valid & ATTR_SIZE) {
>> -		if (attr->ia_size <= i_size_read(inode)) {
>> -			down_write(&F2FS_I(inode)->i_mmap_sem);
>> -			truncate_setsize(inode, attr->ia_size);
>> +		bool to_smaller = (attr->ia_size <= i_size_read(inode));
>> +
>> +		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>> +		down_write(&F2FS_I(inode)->i_mmap_sem);
>> +
>> +		truncate_setsize(inode, attr->ia_size);
>> +
>> +		if (to_smaller)
>>  			err = f2fs_truncate(inode);
>> -			up_write(&F2FS_I(inode)->i_mmap_sem);
>> -			if (err)
>> -				return err;
>> -		} else {
>> -			/*
>> -			 * do not trim all blocks after i_size if target size is
>> -			 * larger than i_size.
>> -			 */
>> -			down_write(&F2FS_I(inode)->i_mmap_sem);
>> -			truncate_setsize(inode, attr->ia_size);
>> -			up_write(&F2FS_I(inode)->i_mmap_sem);
>> +		/*
>> +		 * do not trim all blocks after i_size if target size is
>> +		 * larger than i_size.
>> +		 */
>> +		up_write(&F2FS_I(inode)->i_mmap_sem);
>> +		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>> +		if (err)
>> +			return err;
>>  
>> +		if (!to_smaller) {
>>  			/* should convert inline inode here */
>>  			if (!f2fs_may_inline_data(inode)) {
>>  				err = f2fs_convert_inline_inode(inode);
>> @@ -958,6 +961,7 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
>>  
>>  			blk_start = (loff_t)pg_start << PAGE_SHIFT;
>>  			blk_end = (loff_t)pg_end << PAGE_SHIFT;
>> +			down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>  			down_write(&F2FS_I(inode)->i_mmap_sem);
>>  			truncate_inode_pages_range(mapping, blk_start,
>>  					blk_end - 1);
>> @@ -966,6 +970,7 @@ static int punch_hole(struct inode *inode, loff_t offset, loff_t len)
>>  			ret = f2fs_truncate_hole(inode, pg_start, pg_end);
>>  			f2fs_unlock_op(sbi);
>>  			up_write(&F2FS_I(inode)->i_mmap_sem);
>> +			up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>  		}
>>  	}
>>  
>> -- 
>> 2.18.0.rc1
