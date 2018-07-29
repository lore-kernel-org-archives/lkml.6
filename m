Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D93EC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 02:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E714020899
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 02:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v6y5gd2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E714020899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbeG2EWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 00:22:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725856AbeG2EWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 00:22:46 -0400
Received: from [192.168.0.101] (unknown [180.111.102.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9212320893;
        Sun, 29 Jul 2018 02:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532832841;
        bh=68xUfhKEmnhSFkkCZklvU/LIKTPXO0emH2/2dWbrEHQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=v6y5gd2Ygctmx/L5IhJpCNJvseGxQ7tJrpxZhzayTTEbiWxBtWFYzDYqTEz/y93t4
         WAXFMbXY0g1mZqYAI3wov088+RZJL9fvse2cQc4IbWcqcO6CaCT0/ReX7eNw+0T3dB
         GZN+m5p6jUYt8No2EzqTX7aLWGqRazEHIK78rvCU=
Subject: Re: [PATCH] f2fs: avoid race between zero_range and background GC
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20180726104536.114340-1-yuchao0@huawei.com>
 <20180727102916.GI16155@jaegeuk-macbookpro.roam.corp.google.com>
 <10d7814b-06d0-6751-ca56-85e7c8b92a27@kernel.org>
 <20180729020254.GH83620@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <6d86bad1-52fa-2309-9403-47490345e372@kernel.org>
Date:   Sun, 29 Jul 2018 10:53:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180729020254.GH83620@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/7/29 10:02, Jaegeuk Kim wrote:
> On 07/27, Chao Yu wrote:
>> On 2018/7/27 18:29, Jaegeuk Kim wrote:
>>> On 07/26, Chao Yu wrote:
>>>> Thread A				Background GC
>>>> - f2fs_zero_range
>>>>  - truncate_pagecache_range
>>>> 					- gc_data_segment
>>>> 					 - get_read_data_page
>>>> 					  - move_data_page
>>>> 					   - set_page_dirty
>>>> 					   - set_cold_data
>>>>  - f2fs_do_zero_range
>>>>   - dn->data_blkaddr = NEW_ADDR;
>>>>   - f2fs_set_data_blkaddr
>>>>
>>>> Actually, we don't need to set dirty & checked flag on the page, since
>>>> all valid data in the page should be zeroed by zero_range().
>>>
>>> But, it doesn't matter too much, right?
>>
>> No, if the dirtied page is writebacked after f2fs_do_zero_range(), result of
>> zero_range() should be wrong, as zeroed page contains valid user data.
> 
> How about truncating page caches after block address change or doing it twice
> before and after?

Thread A				Background GC
- f2fs_zero_range
 - truncate_pagecache_range
					- gc_data_segment
					 - get_read_data_page
					  - move_data_page
					   - set_page_dirty
					   - set_cold_data
 - f2fs_do_zero_range
  - dn->data_blkaddr = NEW_ADDR;
  - f2fs_set_data_blkaddr
					bdi-flusher
					- __write_data_page
					 - f2fs_update_data_blkaddr
					 : data_blkaddr has been updated here.
 - truncate_pagecache_range
 : data & dnode has been writebacked before page cache truncation?

How about this case?

Thanks,

> 
>>
>>>
>>>> Use i_gc_rwsem[WRITE] to avoid such race condition.
>>>
>>> Hope to avoid abusing i_gc_rwsem[] tho.
>>
>> Agreed, let's try avoiding until we have to use it.
>>
>> Thanks,
>>
>>>
>>>>
>>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>>>> ---
>>>>  fs/f2fs/file.c | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>>>> index 267ec3794e1e..7bd2412a8c37 100644
>>>> --- a/fs/f2fs/file.c
>>>> +++ b/fs/f2fs/file.c
>>>> @@ -1309,6 +1309,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
>>>>  	if (ret)
>>>>  		return ret;
>>>>  
>>>> +	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>>>  	down_write(&F2FS_I(inode)->i_mmap_sem);
>>>>  	ret = filemap_write_and_wait_range(mapping, offset, offset + len - 1);
>>>>  	if (ret)
>>>> @@ -1389,6 +1390,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
>>>>  	}
>>>>  out_sem:
>>>>  	up_write(&F2FS_I(inode)->i_mmap_sem);
>>>> +	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
>>>>  
>>>>  	return ret;
>>>>  }
>>>> -- 
>>>> 2.18.0.rc1
