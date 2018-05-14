Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeENDjr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 23:39:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45985 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752028AbeENDjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 23:39:46 -0400
Subject: Re: [PATCH] f2fs: Fix deadlock in shutdown ioctl
To: Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC: <linux-kernel@vger.kernel.org>
References: <1525958444-5579-1-git-send-email-stummala@codeaurora.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <de6f040b-81d3-7f52-2482-135d11200788@huawei.com>
Date: Mon, 14 May 2018 11:39:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1525958444-5579-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/5/10 21:20, Sahitya Tummala wrote:
> f2fs_ioc_shutdown() ioctl gets stuck in the below path
> when going down with full sync (F2FS_GOING_DOWN_FULLSYNC)
> option.
> 
> __switch_to+0x90/0xc4
> percpu_down_write+0x8c/0xc0
> freeze_super+0xec/0x1e4
> freeze_bdev+0xc4/0xcc
> f2fs_ioctl+0xc0c/0x1ce0
> f2fs_compat_ioctl+0x98/0x1f0
> 
> Fix this by not holding write access during this ioctl.

I think we can just remove lock coverage for F2FS_GOING_DOWN_FULLSYNC path, for
other path, we need to keep as it is.

Thanks,

> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> ---
>  fs/f2fs/file.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index b926df7..2c2e61b 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1835,10 +1835,6 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>  	if (get_user(in, (__u32 __user *)arg))
>  		return -EFAULT;
>  
> -	ret = mnt_want_write_file(filp);
> -	if (ret)
> -		return ret;
> -
>  	switch (in) {
>  	case F2FS_GOING_DOWN_FULLSYNC:
>  		sb = freeze_bdev(sb->s_bdev);
> @@ -1878,7 +1874,6 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>  
>  	f2fs_update_time(sbi, REQ_TIME);
>  out:
> -	mnt_drop_write_file(filp);
>  	return ret;
>  }
>  
> 
