Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDDFBC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4F621738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4F621738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbeHMOHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:07:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10713 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728370AbeHMOHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:07:32 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 673E25227F432;
        Mon, 13 Aug 2018 19:25:39 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 13 Aug
 2018 19:25:31 +0800
Subject: Re: [PATCH 2/8] staging: erofs: separate erofs_get_meta_page
To:     Dan Carpenter <dan.carpenter@oracle.com>, Chao Yu <chao@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>,
        Chao Yu <yuchao0@huawei.com>, <linux-erofs@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
References: <20180812140150.13397-1-chao@kernel.org>
 <20180812140150.13397-3-chao@kernel.org>
 <20180813110405.3qoburir3ds5ux33@mwanda>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <3e77ae86-d417-6632-4894-d257fdb17a21@huawei.com>
Date:   Mon, 13 Aug 2018 19:23:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180813110405.3qoburir3ds5ux33@mwanda>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 2018/8/13 19:04, Dan Carpenter wrote:
> On Sun, Aug 12, 2018 at 10:01:44PM +0800, Chao Yu wrote:
>> --- a/drivers/staging/erofs/data.c
>> +++ b/drivers/staging/erofs/data.c
>> @@ -39,31 +39,44 @@ static inline void read_endio(struct bio *bio)
>>  }
>>  
>>  /* prio -- true is used for dir */
>> -struct page *erofs_get_meta_page(struct super_block *sb,
>> -	erofs_blk_t blkaddr, bool prio)
>> +struct page *__erofs_get_meta_page(struct super_block *sb,
>> +	erofs_blk_t blkaddr, bool prio, bool nofail)
>>  {
>> -	struct inode *bd_inode = sb->s_bdev->bd_inode;
>> -	struct address_space *mapping = bd_inode->i_mapping;
>> +	struct inode *const bd_inode = sb->s_bdev->bd_inode;
>> +	struct address_space *const mapping = bd_inode->i_mapping;
>> +	/* prefer retrying in the allocator to blindly looping below */
>> +	const gfp_t gfp = mapping_gfp_constraint(mapping, ~__GFP_FS) |
>> +		(nofail ? __GFP_NOFAIL : 0);
>> +	unsigned int io_retries = nofail ? EROFS_IO_MAX_RETRIES_NOFAIL : 0;
>>  	struct page *page;
>>  
>>  repeat:
>> -	page = find_or_create_page(mapping, blkaddr,
>> -	/*
>> -	 * Prefer looping in the allocator rather than here,
>> -	 * at least that code knows what it's doing.
>> -	 */
>> -		mapping_gfp_constraint(mapping, ~__GFP_FS) | __GFP_NOFAIL);
>> -
>> -	BUG_ON(!page || !PageLocked(page));
>> +	page = find_or_create_page(mapping, blkaddr, gfp);
>> +	if (unlikely(page == NULL)) {
>> +		DBG_BUGON(nofail);
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +	DBG_BUGON(!PageLocked(page));
>>  
>>  	if (!PageUptodate(page)) {
>>  		struct bio *bio;
>>  		int err;
>>  
>> -		bio = erofs_grab_bio(sb, blkaddr, 1, read_endio, true);
>> +		bio = erofs_grab_bio(sb, blkaddr, 1, read_endio, nofail);
>> +		if (unlikely(bio == NULL)) {
>> +			DBG_BUGON(nofail);
>> +			err = -ENOMEM;
>> +err_out:
>> +			unlock_page(page);
>> +			put_page(page);
>> +			return ERR_PTR(err);
> 
> Put this err_out stuff at the bottom of the function so that we don't
> have to do backward hops to get to it.
> 
>> +		}
>>  
>>  		err = bio_add_page(bio, page, PAGE_SIZE, 0);
>> -		BUG_ON(err != PAGE_SIZE);
>> +		if (unlikely(err != PAGE_SIZE)) {
>> +			err = -EFAULT;
>> +			goto err_out;
>                         ^^^^^^^^^^^^
> Like this.  Generally avoid backwards hops if you can.
> 
>> +		}
>>  
>>  		__submit_bio(bio, REQ_OP_READ,
>>  			REQ_META | (prio ? REQ_PRIO : 0));
>> @@ -72,6 +85,7 @@ struct page *erofs_get_meta_page(struct super_block *sb,
>>  
>>  		/* the page has been truncated by others? */
>>  		if (unlikely(page->mapping != mapping)) {
>> +unlock_repeat:
> The question mark in the "truncated by others?" is a little concerning.
> It's slightly weird that we don't check "io_retries" on this path.
>
Thanks for your reply.

erofs use the shared block device bd_inode->mapping for its meta use, which is visible
to other code rather than erofs internally only, so I think it needs to get rid of
potentially truncating by others, and such comments can also be found at

- pagecache_get_page
1557                 /* Has the page been truncated? */
1558                 if (unlikely(page->mapping != mapping)) {
1559                         unlock_page(page);
1560                         put_page(page);
1561                         goto repeat;
1562                 }

- filemap_fault
2535         /* Did it get truncated? */
2536         if (unlikely(page->mapping != mapping)) {
2537                 unlock_page(page);
2538                 put_page(page);
2539                 goto retry_find;
2540         }

I think it is somewhat necessary, and some suggestion about this? thanks in advance.

"It's slightly weird that we don't check "io_retries" on this path"
I think you are right, let me rethink about it and send the next patch...

Thanks,
Gao Xiang

