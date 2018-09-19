Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5C3C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616D621508
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616D621508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbeISHYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:24:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12614 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728226AbeISHYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:24:14 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3E86E37936025;
        Wed, 19 Sep 2018 09:48:49 +0800 (CST)
Received: from [127.0.0.1] (10.134.22.195) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.399.0; Wed, 19 Sep 2018
 09:48:46 +0800
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: report ENOENT correct in f2fs_rename
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180918021805.85032-1-jaegeuk@kernel.org>
 <f2d06f89-4f84-8492-eeea-e1c07e5104c3@kernel.org>
 <20180918175936.GF91945@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b791b223-e962-773c-3876-7fd7773df886@huawei.com>
Date:   Wed, 19 Sep 2018 09:48:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918175936.GF91945@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/19 1:59, Jaegeuk Kim wrote:
> On 09/18, Chao Yu wrote:
>> On 2018/9/18 10:18, Jaegeuk Kim wrote:
>>> This fixes wrong error report in f2fs_rename.
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/namei.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>>> index 98d3ab7c3ce6..d653be777529 100644
>>> --- a/fs/f2fs/namei.c
>>> +++ b/fs/f2fs/namei.c
>>> @@ -833,7 +833,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>>>  	struct f2fs_dir_entry *old_entry;
>>>  	struct f2fs_dir_entry *new_entry;
>>>  	bool is_old_inline = f2fs_has_inline_dentry(old_dir);
>>> -	int err = -ENOENT;
>>> +	int err;
>>>  
>>>  	if (unlikely(f2fs_cp_error(sbi)))
>>>  		return -EIO;
>>> @@ -854,6 +854,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>>>  	if (err)
>>>  		goto out;
>>>  
>>> +	err = -ENOENT;
>>
>> I didn't get what's the difference after moving initialization of 'err' here...
> 
> One example,
> 
>         old_entry = f2fs_find_entry(old_dir, &old_dentry->d_name, &old_page);
>         if (!old_entry) {
>                 if (IS_ERR(old_page))
>                         err = PTR_ERR(old_page);
> 
> --> need to return ENOENT instead of 0.

Clear for me now, thanks for your explanation, I just miss that case. ;)

It would be better to add this into commit log.

I agree with Sahitya, we need to cover rename2 as well.

Thanks,

> 
>                 goto out;
>         }
> 
>>
>> Thanks,
>>
>>>  	if (new_inode) {
>>>  		err = dquot_initialize(new_inode);
>>>  		if (err)
>>>
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
> 

