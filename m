Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbeCNNIC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 09:08:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751289AbeCNNIB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 09:08:01 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C98720685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=chao@kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid selinux denial on CAP_SYS_RESOURCE
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20180309044900.39677-1-jaegeuk@kernel.org>
 <5ec9338e-1522-2b6a-99c2-ffe70b7a06a9@huawei.com>
 <20180309215705.GB56123@jaegeuk-macbookpro.roam.corp.google.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <76907981-6aae-f80c-e5fd-6de9127394f4@kernel.org>
Date: Wed, 14 Mar 2018 21:07:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180309215705.GB56123@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/3/10 5:57, Jaegeuk Kim wrote:
> On 03/09, Chao Yu wrote:
>> On 2018/3/9 12:49, Jaegeuk Kim wrote:
>>> This fixes CAP_SYS_RESOURCE denial of selinux when using resgid.
>>
>> A little confusion, if capable(CAP_SYS_RESOURCE) is false, we still have chance
>> to return true for below resuid & resgid cases, right?
> 
> I didn't dig it deeply tho, it seems selinux log came up when capable() is
> failed in the first place. We actually didn't need to show it up, since next
> resgid will give mostly true.

Got it, how about adding this reason into commit message? Anyway,

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>  fs/f2fs/f2fs.h | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index f6dc70666ebb..3d12277fbe9e 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -1607,13 +1607,13 @@ static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
>>>  		return false;
>>>  	if (IS_NOQUOTA(inode))
>>>  		return true;
>>> -	if (capable(CAP_SYS_RESOURCE))
>>> -		return true;
>>>  	if (uid_eq(sbi->s_resuid, current_fsuid()))
>>>  		return true;
>>>  	if (!gid_eq(sbi->s_resgid, GLOBAL_ROOT_GID) &&
>>>  					in_group_p(sbi->s_resgid))
>>>  		return true;
>>> +	if (capable(CAP_SYS_RESOURCE))
>>> +		return true;
>>>  	return false;
>>>  }
>>>  
>>>
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> 
