Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACB3C46460
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 02:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4C021797
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 02:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4C021797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbeHMFR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 01:17:28 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59360 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725807AbeHMFR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 01:17:28 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6A02EA47255F9;
        Mon, 13 Aug 2018 10:37:17 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.399.0; Mon, 13 Aug
 2018 10:37:09 +0800
Subject: Re: [PATCH 3/8] staging: erofs: add error handling for xattr
 submodule
To:     Chao Yu <yuchao0@huawei.com>
CC:     Chao Yu <chao@kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20180812140150.13397-1-chao@kernel.org>
 <20180812140150.13397-4-chao@kernel.org>
 <11a5b8c0-c3fa-0da9-a41b-a6b33ddcc9bb@huawei.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <3d6e8cd9-0263-2196-7b45-b60245f0ba7c@huawei.com>
Date:   Mon, 13 Aug 2018 10:36:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <11a5b8c0-c3fa-0da9-a41b-a6b33ddcc9bb@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On 2018/8/13 10:00, Chao Yu wrote:
> On 2018/8/12 22:01, Chao Yu wrote:
>> From: Gao Xiang <gaoxiang25@huawei.com>
>>
>> This patch enhances the missing error handling code for
>> xattr submodule, which improves the stability for the rare cases.
>>
>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  drivers/staging/erofs/internal.h |   6 +-
>>  drivers/staging/erofs/xattr.c    | 120 ++++++++++++++++++++-----------
>>  2 files changed, 83 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
>> index a756abeff7e9..8951e01216e3 100644
>> --- a/drivers/staging/erofs/internal.h
>> +++ b/drivers/staging/erofs/internal.h
>> @@ -485,10 +485,10 @@ struct erofs_map_blocks_iter {
>>  
>>  
>>  static inline struct page *
>> -erofs_get_inline_page_nofail(struct inode *inode,
>> -			     erofs_blk_t blkaddr)
>> +erofs_get_inline_page(struct inode *inode,
>> +		      erofs_blk_t blkaddr)
>>  {
>> -	return erofs_get_meta_page_nofail(inode->i_sb,
>> +	return erofs_get_meta_page(inode->i_sb,
>>  		blkaddr, S_ISDIR(inode->i_mode));
>>  }
>>  
>> diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
>> index 2593c856b079..1b5815fc70db 100644
>> --- a/drivers/staging/erofs/xattr.c
>> +++ b/drivers/staging/erofs/xattr.c
>> @@ -24,16 +24,25 @@ struct xattr_iter {
>>  
>>  static inline void xattr_iter_end(struct xattr_iter *it, bool atomic)
>>  {
>> -	/* only init_inode_xattrs use non-atomic once */
>> +	/* the only user of kunmap() is 'init_inode_xattrs' */
>>  	if (unlikely(!atomic))
>>  		kunmap(it->page);
>>  	else
>>  		kunmap_atomic(it->kaddr);
>> +
>>  	unlock_page(it->page);
>>  	put_page(it->page);
>>  }
>>  
>> -static void init_inode_xattrs(struct inode *inode)
>> +static inline void xattr_iter_end_final(struct xattr_iter *it)
>> +{
>> +	if (unlikely(it->page == NULL))
>> +		return;
>> +
>> +	xattr_iter_end(it, true);
>> +}
>> +
>> +static int init_inode_xattrs(struct inode *inode)
>>  {
>>  	struct xattr_iter it;
>>  	unsigned i;
>> @@ -44,7 +53,7 @@ static void init_inode_xattrs(struct inode *inode)
>>  	bool atomic_map;
>>  
>>  	if (likely(inode_has_inited_xattr(inode)))
>> -		return;
>> +		return 0;
>>  
>>  	vi = EROFS_V(inode);
>>  	BUG_ON(!vi->xattr_isize);
>> @@ -54,8 +63,9 @@ static void init_inode_xattrs(struct inode *inode)
>>  	it.blkaddr = erofs_blknr(iloc(sbi, vi->nid) + vi->inode_isize);
>>  	it.ofs = erofs_blkoff(iloc(sbi, vi->nid) + vi->inode_isize);
>>  
>> -	it.page = erofs_get_inline_page_nofail(inode, it.blkaddr);
>> -	BUG_ON(IS_ERR(it.page));
>> +	it.page = erofs_get_inline_page(inode, it.blkaddr);
>> +	if (IS_ERR(it.page))
>> +		return PTR_ERR(it.page);
>>  
>>  	/* read in shared xattr array (non-atomic, see kmalloc below) */
>>  	it.kaddr = kmap(it.page);
>> @@ -64,9 +74,12 @@ static void init_inode_xattrs(struct inode *inode)
>>  	ih = (struct erofs_xattr_ibody_header *)(it.kaddr + it.ofs);
>>  
>>  	vi->xattr_shared_count = ih->h_shared_count;
>> -	vi->xattr_shared_xattrs = (unsigned *)kmalloc_array(
>> -		vi->xattr_shared_count, sizeof(unsigned),
>> -		GFP_KERNEL | __GFP_NOFAIL);
>> +	vi->xattr_shared_xattrs = kmalloc_array(vi->xattr_shared_count,
>> +						sizeof(unsigned), GFP_KERNEL);
>> +	if (unlikely(vi->xattr_shared_xattrs == NULL)) {
>> +		xattr_iter_end(&it, atomic_map);
>> +		return -ENOMEM;
>> +	}
>>  
>>  	/* let's skip ibody header */
>>  	it.ofs += sizeof(struct erofs_xattr_ibody_header);
>> @@ -77,9 +90,10 @@ static void init_inode_xattrs(struct inode *inode)
>>  			BUG_ON(it.ofs != EROFS_BLKSIZ);
>>  			xattr_iter_end(&it, atomic_map);
>>  
>> -			it.page = erofs_get_meta_page_nofail(sb,
>> +			it.page = erofs_get_meta_page(sb,
>>  				++it.blkaddr, S_ISDIR(inode->i_mode));
>> -			BUG_ON(IS_ERR(it.page));
>> +			if (IS_ERR(it.page))
>> +				return PTR_ERR(it.page);
>>  
>>  			it.kaddr = kmap_atomic(it.page);
>>  			atomic_map = true;
>> @@ -92,6 +106,7 @@ static void init_inode_xattrs(struct inode *inode)
>>  	xattr_iter_end(&it, atomic_map);
>>  
>>  	inode_set_inited_xattr(inode);
>> +	return 0;
>>  }
>>  
>>  struct xattr_iter_handlers {
>> @@ -101,19 +116,24 @@ struct xattr_iter_handlers {
>>  	void (*value)(struct xattr_iter *, unsigned, char *, unsigned);
>>  };
>>  
>> -static void xattr_iter_fixup(struct xattr_iter *it)
>> +static inline int xattr_iter_fixup(struct xattr_iter *it)
>>  {
>> -	if (unlikely(it->ofs >= EROFS_BLKSIZ)) {
>> -		xattr_iter_end(it, true);
>> +	if (likely(it->ofs < EROFS_BLKSIZ))
>> +		return 0;
>>  
>> -		it->blkaddr += erofs_blknr(it->ofs);
>> -		it->page = erofs_get_meta_page_nofail(it->sb,
>> -			it->blkaddr, false);
>> -		BUG_ON(IS_ERR(it->page));
>> +	xattr_iter_end(it, true);
>>  
>> -		it->kaddr = kmap_atomic(it->page);
>> -		it->ofs = erofs_blkoff(it->ofs);
>> +	it->blkaddr += erofs_blknr(it->ofs);
>> +
>> +	it->page = erofs_get_meta_page(it->sb, it->blkaddr, false);
>> +	if (IS_ERR(it->page)) {
>> +		it->page = NULL;
>> +		return PTR_ERR(it->page);
> As LKP reported, we need to fix this as below:
> 
> err = PTR_ERR(it->page);
> it->page = NULL;
> return err;
> 
> Thanks,
>

I have seen this at
https://lists.01.org/pipermail/kbuild-all/2018-August/051187.html

I will fix it soon. Thanks for report.

Thanks,
Gao Xiang
