Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7A3C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7A552175C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 12:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWeL1UT7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7A552175C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbeHMPQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 11:16:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728493AbeHMPQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 11:16:42 -0400
Received: from [192.168.0.101] (unknown [58.212.144.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DD7A216F2;
        Mon, 13 Aug 2018 12:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534163676;
        bh=f9eWncnBfGdkgm5T5LSZnt5lFwhhf+sGiw9ehuaMJHY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iWeL1UT7SPas1DDFggqhX3gfo0MnA0GWeSRHaPII4d2sD+EXafvn2aZn5VAW25vn/
         SiJQl5E6aUQyvD5x3XZCd89+7Dg6WzbiPlwpDxLJ00h1g8XcH9fNGauafeougv42/L
         Ld+HgqO5cuv0VHfAjGFfQxD6HSBeD4FGVsqljKhY=
Subject: Re: [PATCH 2/8] staging: erofs: separate erofs_get_meta_page
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20180812140150.13397-1-chao@kernel.org>
 <20180812140150.13397-3-chao@kernel.org>
 <20180813110405.3qoburir3ds5ux33@mwanda>
From:   Chao Yu <chao@kernel.org>
Message-ID: <c7ba72fd-8224-c277-3c05-931eaa275ee3@kernel.org>
Date:   Mon, 13 Aug 2018 20:34:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180813110405.3qoburir3ds5ux33@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> 
> Put this err_out stuff at the bottom of the function so that we don't
> have to do backward hops to get to it.

Agreed, we can move error path at the bottom of this function.

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
> 
> The question mark in the "truncated by others?" is a little concerning.

Yup, we can remove the question mark.

> It's slightly weird that we don't check "io_retries" on this path.

We don't need to cover this path since io_retries is used for accounting retry
time only when IO occurs.

Thanks,

> 
>>  			unlock_page(page);
>>  			put_page(page);
>>  			goto repeat;
>> @@ -79,10 +93,12 @@ struct page *erofs_get_meta_page(struct super_block *sb,
>>  
>>  		/* more likely a read error */
>>  		if (unlikely(!PageUptodate(page))) {
>> -			unlock_page(page);
>> -			put_page(page);
>> -
>> -			page = ERR_PTR(-EIO);
>> +			if (io_retries) {
>> +				--io_retries;
>> +				goto unlock_repeat;
>> +			}
>> +			err = -EIO;
>> +			goto err_out;
> 
> regards,
> dan carpenter
> 
