Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeB1Jrn (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 04:47:43 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5719 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752368AbeB1Jrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 04:47:42 -0500
Subject: Re: [f2fs-dev] [PATCH] f2fs: handle quota for orphan inodes
To: Jaegeuk Kim <jaegeuk@kernel.org>
CC: Chao Yu <chao@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180210022841.5707-1-jaegeuk@kernel.org>
 <e48fd2e5-fab6-57c5-5fff-2e44f5a817b0@kernel.org>
 <49c1d817-f375-4194-8139-c352503a9a2d@huawei.com>
 <20180228052308.GE81737@jaegeuk-macbookpro.roam.corp.google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <aff53d1b-1e87-eadd-9132-66258a76a0a3@huawei.com>
Date: Wed, 28 Feb 2018 17:37:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180228052308.GE81737@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/2/28 13:23, Jaegeuk Kim wrote:
> On 02/27, Chao Yu wrote:
>> Ping,
>>
>> On 2018/2/13 22:33, Chao Yu wrote:
>>> On 2018/2/10 10:28, Jaegeuk Kim wrote:
>>>> This is to fix missing dquot_initialize for orphan inodes.
>>>
>>> IMO, we don't need to call dquot_initialize as we have call the function
>>> in evict(), right?
> 
> I think we'd better detect any error in early stage.

Oh, agreed, in evict(), we can not detect or handle the error of
dquot_initialize, how about changing commit log a bit to indicate that, anyway,
the change looks good to me. ;)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
> Thanks,
> 
>>>
>>> Thanks,
>>>
>>>>
>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>> ---
>>>>  fs/f2fs/checkpoint.c | 28 ++++++++++++++++------------
>>>>  1 file changed, 16 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>>> index 8b0945ba284d..e3bf753a47be 100644
>>>> --- a/fs/f2fs/checkpoint.c
>>>> +++ b/fs/f2fs/checkpoint.c
>>>> @@ -569,13 +569,8 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
>>>>  	struct node_info ni;
>>>>  	int err = acquire_orphan_inode(sbi);
>>>>  
>>>> -	if (err) {
>>>> -		set_sbi_flag(sbi, SBI_NEED_FSCK);
>>>> -		f2fs_msg(sbi->sb, KERN_WARNING,
>>>> -				"%s: orphan failed (ino=%x), run fsck to fix.",
>>>> -				__func__, ino);
>>>> -		return err;
>>>> -	}
>>>> +	if (err)
>>>> +		goto err_out;
>>>>  
>>>>  	__add_ino_entry(sbi, ino, 0, ORPHAN_INO);
>>>>  
>>>> @@ -589,6 +584,11 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
>>>>  		return PTR_ERR(inode);
>>>>  	}
>>>>  
>>>> +	err = dquot_initialize(inode);
>>>> +	if (err)
>>>> +		goto err_out;
>>>> +
>>>> +	dquot_initialize(inode);
>>>>  	clear_nlink(inode);
>>>>  
>>>>  	/* truncate all the data during iput */
>>>> @@ -598,14 +598,18 @@ static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
>>>>  
>>>>  	/* ENOMEM was fully retried in f2fs_evict_inode. */
>>>>  	if (ni.blk_addr != NULL_ADDR) {
>>>> -		set_sbi_flag(sbi, SBI_NEED_FSCK);
>>>> -		f2fs_msg(sbi->sb, KERN_WARNING,
>>>> -			"%s: orphan failed (ino=%x) by kernel, retry mount.",
>>>> -				__func__, ino);
>>>> -		return -EIO;
>>>> +		err = -EIO;
>>>> +		goto err_out;
>>>>  	}
>>>>  	__remove_ino_entry(sbi, ino, ORPHAN_INO);
>>>>  	return 0;
>>>> +
>>>> +err_out:
>>>> +	set_sbi_flag(sbi, SBI_NEED_FSCK);
>>>> +	f2fs_msg(sbi->sb, KERN_WARNING,
>>>> +			"%s: orphan failed (ino=%x), run fsck to fix.",
>>>> +			__func__, ino);
>>>> +	return err;
>>>>  }
>>>>  
>>>>  int recover_orphan_inodes(struct f2fs_sb_info *sbi)
>>>>
>>>
>>> .
>>>
> 
> .
> 
