Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BEDC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3119E20855
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 14:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731427AbfA3O5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 09:57:38 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2708 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbfA3O5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 09:57:38 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A6097B6E625C12DE414F;
        Wed, 30 Jan 2019 22:57:34 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 30 Jan
 2019 22:57:25 +0800
Subject: Re: [PATCH] staging: erofs: keep corrupted fs from crashing kernel in
 erofs_namei()
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Chao Yu <yuchao0@huawei.com>, Al Viro <viro@ZenIV.linux.org.uk>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, Miao Xie <miaoxie@huawei.com>
References: <20190129155540.17473-1-gaoxiang25@huawei.com>
 <20190130144534.GB2010@kadam>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <6cc229c4-5ddf-74d3-36a7-27edee8efb44@huawei.com>
Date:   Wed, 30 Jan 2019 22:57:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190130144534.GB2010@kadam>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thanks for your kindly review.

On 2019/1/30 22:45, Dan Carpenter wrote:
> On Tue, Jan 29, 2019 at 11:55:40PM +0800, Gao Xiang wrote:
>> +static struct page *find_target_block_classic(struct inode *dir,
>> +					      struct erofs_qstr *name,
>> +					      int *_diff,
>> +					      int *_ndirents)
>>  {
>>  	unsigned int startprfx, endprfx;
>> -	unsigned int head, back;
>> +	int head, back;
>>  	struct address_space *const mapping = dir->i_mapping;
>>  	struct page *candidate = ERR_PTR(-ENOENT);
>>  
>> @@ -105,33 +108,34 @@ static struct page *find_target_block_classic(
>>  	back = inode_datablocks(dir) - 1;
>>  
>>  	while (head <= back) {
>> -		unsigned int mid = head + (back - head) / 2;
>> +		const int mid = head + (back - head) / 2;
>>  		struct page *page = read_mapping_page(mapping, mid, NULL);
>>  
>> -		if (IS_ERR(page)) {
>> -exact_out:
>> -			if (!IS_ERR(candidate)) /* valid candidate */
>> -				put_page(candidate);
>> -			return page;
>> -		} else {
>> -			int diff;
>> -			unsigned int ndirents, matched;
>> -			struct qstr dname;
>> +		if (!IS_ERR(page)) {
> 
> It's almost always better to do failure handling instead of success
> handing because it lets you pull everything in one indent level.  You'd
> need to move a bunch of the declarations around.

I just want to leave definition and the initial assignment in one line...
>>  			struct erofs_dirent *de = kmap_atomic(page);
>> -			unsigned int nameoff = le16_to_cpu(de->nameoff);
>> -
>> -			ndirents = nameoff / sizeof(*de);
>> +			const int nameoff = nameoff_from_disk(de->nameoff,
>> +							      EROFS_BLKSIZ);
>> +			const int ndirents = nameoff / sizeof(*de);

or I have to 
		unsigned int mid = head + (back - head) / 2;
		const int mid = head + (back - head) / 2;
  		struct page *page = read_mapping_page(mapping, mid, NULL);
     		struct erofs_dirent *de;
		...
		int ndirents;

		if (IS_ERR(page)) {
			...
		}

		de = kmap_atomic(page);
		...
		ndirents = nameoff / sizeof(*de);

which takes extra lines...

> 
> 	if (IS_ERR(page))
> 		goto out;
> 
> But really the out label is not part of the loop so you could move it
> to the bottom of the function...

It seems that the out label is the part of loop...


> 
>>  			struct erofs_dirent *de = kmap_atomic(page);
>> -			unsigned int nameoff = le16_to_cpu(de->nameoff);
>> -
>> -			ndirents = nameoff / sizeof(*de);
>> +			const int nameoff = nameoff_from_disk(de->nameoff,
>> +							      EROFS_BLKSIZ);
>> +			const int ndirents = nameoff / sizeof(*de);
>> +			int diff;
>> +			unsigned int matched;
>> +			struct erofs_qstr dname;
>>  
>> -			/* corrupted dir (should have one entry at least) */
>> -			BUG_ON(!ndirents || nameoff > PAGE_SIZE);
>> +			if (unlikely(!ndirents)) {
>> +				DBG_BUGON(1);
>> +				put_page(page);
>> +				page = ERR_PTR(-EIO);
>> +				goto out;
> 
> We need to kunmap_atomic(de) on this path.

Thanks, will fix in the next version...

> 
>> +			}
>>  
>>  			matched = min(startprfx, endprfx);
>>  
>>  			dname.name = (u8 *)de + nameoff;
>> -			dname.len = ndirents == 1 ?
>> -				/* since the rest of the last page is 0 */
>> -				EROFS_BLKSIZ - nameoff
>> -				: le16_to_cpu(de[1].nameoff) - nameoff;
>> +			if (ndirents == 1)
>> +				dname.end = (u8 *)de + EROFS_BLKSIZ;
>> +			else
>> +				dname.end = (u8 *)de +
>> +					nameoff_from_disk(de[1].nameoff,
>> +							  EROFS_BLKSIZ);
>>  
>>  			/* string comparison without already matched prefix */
>>  			diff = dirnamecmp(name, &dname, &matched);
>> @@ -139,7 +143,7 @@ static struct page *find_target_block_classic(
>>  
>>  			if (unlikely(!diff)) {
>>  				*_diff = 0;
>> -				goto exact_out;
>> +				goto out;
>>  			} else if (diff > 0) {
>>  				head = mid + 1;
>>  				startprfx = matched;
>> @@ -147,35 +151,42 @@ static struct page *find_target_block_classic(
>>  				if (likely(!IS_ERR(candidate)))
>                                     ^^^^^^
> Not related to the this patch, but I wonder how this works.  IS_ERR()
> already has an opposite unlikely() inside so I wonder which trumps the
> other?

Yes, you are right. That is a remaining issue in the original code.
I will set up a clean up patch to fix that.

Thanks,
Gao Xiang

> 
>>  					put_page(candidate);
>>  				candidate = page;
>> +				*_ndirents = ndirents;
> 
> regards,
> dan carpenter
> 
