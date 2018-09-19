Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADE9C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685F42150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 15:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wpZYNLuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 685F42150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732605AbeISVYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 17:24:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732294AbeISVYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 17:24:47 -0400
Received: from [192.168.0.101] (unknown [117.62.222.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B31B52150B;
        Wed, 19 Sep 2018 15:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537371975;
        bh=5KJzLx5r7VEvHV5WzbYOyjZIcfIrO6fL8lpWY0To8Lc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=wpZYNLuLVMuIOzvtu/W7SFsUjSZ5M2CCYvnqpYgLTDC0HWxqPYTzzhSnLfvWRW6ov
         xeOxi9WvcLiztCFOLDnXd/OIJLN2V7iEwohIrgHZSQByjhoVU4ArVWOCcbacjbSf0m
         N9JWdzrTRP6vnDDVmkZDIddoDBK3wVbbsSNMVtmc=
Subject: Re: [PATCH 4/6] staging: erofs: cleanup
 `z_erofs_vle_normalaccess_readpages'
To:     Gao Xiang <hsiangkao@aol.com>, Chao Yu <yuchao0@huawei.com>,
        devel@driverdev.osuosl.org
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, Miao Xie <miaoxie@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, Du Wei <weidu.du@huawei.com>
References: <1537336150-90604-1-git-send-email-gaoxiang25@huawei.com>
 <1537336150-90604-4-git-send-email-gaoxiang25@huawei.com>
 <1b38cbfe-70e0-1e6d-fa50-89b1fddeeb43@kernel.org>
 <fc0f977f-b1c3-41a9-a058-bca4261bf9ea@aol.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <37b566ea-273b-8d81-7428-06bd35d60092@kernel.org>
Date:   Wed, 19 Sep 2018 23:45:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <fc0f977f-b1c3-41a9-a058-bca4261bf9ea@aol.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiang,

On 2018/9/19 23:32, Gao Xiang wrote:
> Hi Chao,
> 
> On 2018/9/19 23:26, Chao Yu wrote:
>> Hi Xiang,
>>
>> On 2018/9/19 13:49, Gao Xiang wrote:
>>> This patch introduces `__should_decompress_synchronously' to
>>> cleanup `z_erofs_vle_normalaccess_readpages'.
>>>
>>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>>> ---
>>>  drivers/staging/erofs/internal.h  | 11 +++++++++++
>>>  drivers/staging/erofs/super.c     |  5 +++++
>>>  drivers/staging/erofs/unzip_vle.c | 20 ++++++--------------
>>>  3 files changed, 22 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
>>> index cfcc6db..c84eb97 100644
>>> --- a/drivers/staging/erofs/internal.h
>>> +++ b/drivers/staging/erofs/internal.h
>>> @@ -95,6 +95,9 @@ struct erofs_sb_info {
>>>  	/* the dedicated workstation for compression */
>>>  	struct radix_tree_root workstn_tree;
>>>  
>>> +	/* threshold for decompression synchronously */
>>> +	unsigned int max_sync_decompress_pages;
>>> +
>>>  #ifdef EROFS_FS_HAS_MANAGED_CACHE
>>>  	struct inode *managed_cache;
>>>  #endif
>>> @@ -273,6 +276,14 @@ extern int erofs_try_to_free_cached_page(struct address_space *mapping,
>>>  	struct page *page);
>>>  #endif
>>>  
>>> +#define DEFAULT_MAX_SYNC_DECOMPRESS_PAGES	4
>>> +
>>> +static inline bool __should_decompress_synchronously(struct erofs_sb_info *sbi,
>>> +						     unsigned int nr)
>>> +{
>>> +	return nr <= sbi->max_sync_decompress_pages;
>> -		nr_pages < 4 /* sync */);
>>
>> There is a little bit changed except cleanup, IIUC, would it be any difference
>> of performance around boundary of four pages?
> 
> No.. Once synchronous decompression is applied for 1,2,3 pages for no special reasons.
> But I think it could be better to adjust it to the power of two --- 1,2,3,4 is preferred.
> Since I have no idea to measure which is better or what value is best for all platform or use cases...
> 
> Therefore I tune it in this patch since I don't like the number
> DEFAULT_MAX_SYNC_DECOMPRESS_PAGES == 3 ...

Yeah, how about adding one more patch to tune this magic number first? as that
change would not be part of cleanup thing. I guess later maybe we could export a
sysfs node to provider tuning ability on that threshold.

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>>
