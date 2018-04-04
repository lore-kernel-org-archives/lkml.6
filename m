Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754895AbeDDB1a (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 21:27:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7149 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754844AbeDDB12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 21:27:28 -0400
Subject: Re: [PATCH v2] f2fs: remain written times to update inode during
 fsync
To: Jaegeuk Kim <jaegeuk@kernel.org>
CC: <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180330055126.36202-1-jaegeuk@kernel.org>
 <20180330163036.GC44823@jaegeuk-macbookpro.roam.corp.google.com>
 <90a3d827-5447-437b-b742-79e7084e4a2c@huawei.com>
 <20180403052310.GB57227@jaegeuk-macbookpro.roam.corp.google.com>
 <d67b0a31-ef40-e981-729b-b93758d88ccd@huawei.com>
 <20180403160808.GA68167@jaegeuk-macbookpro.roam.corp.google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <bde39003-062a-e9dd-d5e0-927ae0a15f7e@huawei.com>
Date: Wed, 4 Apr 2018 09:27:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180403160808.GA68167@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/4/4 0:08, Jaegeuk Kim wrote:
> On 04/03, Chao Yu wrote:
>> On 2018/4/3 13:23, Jaegeuk Kim wrote:
>>> On 04/03, Chao Yu wrote:
>>>> On 2018/3/31 0:30, Jaegeuk Kim wrote:
>>>>> Change log from v1:
>>>>>  - add more description
>>>>>
>>>>> This fixes xfstests/generic/392.
>>>>>
>>>>> The failure was caused by different times between 1) one marked in the last
>>>>> fsync(2) call and 2) the other given by roll-forward recovery after power-cut.
>>>>> The reason was that we skipped updating inode block at 1), since its i_size
>>>>> was recoverable along with 4KB-aligned data writes, which was fixed by:
>>>>>   "f2fs: fix a wrong condition in f2fs_skip_inode_update"
>>>>>
>>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>>> ---
>>>>>  fs/f2fs/f2fs.h  | 15 +++++++++++++++
>>>>>  fs/f2fs/inode.c |  4 ++++
>>>>>  2 files changed, 19 insertions(+)
>>>>>
>>>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>>>> index 000f93f6767e..675c39d85111 100644
>>>>> --- a/fs/f2fs/f2fs.h
>>>>> +++ b/fs/f2fs/f2fs.h
>>>>> @@ -664,6 +664,7 @@ struct f2fs_inode_info {
>>>>>  	kprojid_t i_projid;		/* id for project quota */
>>>>>  	int i_inline_xattr_size;	/* inline xattr size */
>>>>>  	struct timespec i_crtime;	/* inode creation time */
>>>>> +	struct timespec i_disk_time[4];	/* inode disk times */
>>>>>  };
>>>>>  
>>>>>  static inline void get_extent_info(struct extent_info *ext,
>>>>> @@ -2457,6 +2458,11 @@ static inline void clear_file(struct inode *inode, int type)
>>>>>  	f2fs_mark_inode_dirty_sync(inode, true);
>>>>>  }
>>>>>  
>>>>> +static inline bool time_equal(struct timespec a, struct timespec b)
>>>>> +{
>>>>> +	return (a.tv_sec == b.tv_sec) && (a.tv_nsec == b.tv_nsec);
>>>>> +}
>>>>
>>>> We can use existing timespec_equal in <linux/time.h> instead of defining a
>>>> duplicated one?
>>>
>>> It is defined with const parameters.
>>
>> I didn't get it, const keyword can used to protect parameter not to be changed
>> in that function, that will be more safe, so it will be better to use that one?
> 
> Oh, I just made a mistake when testing timespec_equal().
> I really need more recess time. :P

Work is hard, right, we'd better keep having enough rest. :)

> 
> Change log from v3:
>  - use timespec_equal()
> 
> This fixes xfstests/generic/392.
> 
> The failure was caused by different times between 1) one marked in the last
> fsync(2) call and 2) the other given by roll-forward recovery after power-cut.
> The reason was that we skipped updating inode block at 1), since its i_size
> was recoverable along with 4KB-aligned data writes, which was fixed by:
>   "f2fs: fix a wrong condition in f2fs_skip_inode_update"
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/f2fs.h  | 11 +++++++++++
>  fs/f2fs/inode.c |  8 ++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 7102d3965fea..1df7f10476d6 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -664,6 +664,7 @@ struct f2fs_inode_info {
>  	kprojid_t i_projid;		/* id for project quota */
>  	int i_inline_xattr_size;	/* inline xattr size */
>  	struct timespec i_crtime;	/* inode creation time */
> +	struct timespec i_disk_time[4];	/* inode disk times */
>  };
>  
>  static inline void get_extent_info(struct extent_info *ext,
> @@ -2474,6 +2475,16 @@ static inline bool f2fs_skip_inode_update(struct inode *inode, int dsync)
>  			i_size_read(inode) & ~PAGE_MASK)
>  		return false;
>  
> +	if (!timespec_equal(F2FS_I(inode)->i_disk_time, &inode->i_atime))
> +		return false;
> +	if (!timespec_equal(F2FS_I(inode)->i_disk_time + 1, &inode->i_ctime))
> +		return false;
> +	if (!timespec_equal(F2FS_I(inode)->i_disk_time + 2, &inode->i_mtime))
> +		return false;
> +	if (!timespec_equal(F2FS_I(inode)->i_disk_time + 3,
> +						&F2FS_I(inode)->i_crtime))
> +		return false;
> +
>  	down_read(&F2FS_I(inode)->i_sem);
>  	ret = F2FS_I(inode)->last_disk_size == i_size_read(inode);
>  	up_read(&F2FS_I(inode)->i_sem);
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index 401f09ccce7e..e0d9e8f27ed2 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -284,6 +284,10 @@ static int do_read_inode(struct inode *inode)
>  		fi->i_crtime.tv_nsec = le32_to_cpu(ri->i_crtime_nsec);
>  	}
>  
> +	F2FS_I(inode)->i_disk_time[0] = inode->i_atime;
> +	F2FS_I(inode)->i_disk_time[1] = inode->i_ctime;
> +	F2FS_I(inode)->i_disk_time[2] = inode->i_mtime;
> +	F2FS_I(inode)->i_disk_time[3] = F2FS_I(inode)->i_crtime;
>  	f2fs_put_page(node_page, 1);
>  
>  	stat_inc_inline_xattr(inode);
> @@ -444,6 +448,10 @@ void update_inode(struct inode *inode, struct page *node_page)
>  	if (inode->i_nlink == 0)
>  		clear_inline_node(node_page);
>  
> +	F2FS_I(inode)->i_disk_time[0] = inode->i_atime;
> +	F2FS_I(inode)->i_disk_time[1] = inode->i_ctime;
> +	F2FS_I(inode)->i_disk_time[2] = inode->i_mtime;
> +	F2FS_I(inode)->i_disk_time[3] = F2FS_I(inode)->i_crtime;
>  }
>  
>  void update_inode_page(struct inode *inode)
> 
