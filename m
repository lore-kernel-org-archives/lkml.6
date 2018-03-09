Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751113AbeCIGXG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 01:23:06 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:49600 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750753AbeCIGXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 01:23:05 -0500
Subject: Re: [PATCH] f2fs: avoid selinux denial on CAP_SYS_RESOURCE
To: Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20180309044900.39677-1-jaegeuk@kernel.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <5ec9338e-1522-2b6a-99c2-ffe70b7a06a9@huawei.com>
Date: Fri, 9 Mar 2018 14:22:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180309044900.39677-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/3/9 12:49, Jaegeuk Kim wrote:
> This fixes CAP_SYS_RESOURCE denial of selinux when using resgid.

A little confusion, if capable(CAP_SYS_RESOURCE) is false, we still have chance
to return true for below resuid & resgid cases, right?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/f2fs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f6dc70666ebb..3d12277fbe9e 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1607,13 +1607,13 @@ static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
>  		return false;
>  	if (IS_NOQUOTA(inode))
>  		return true;
> -	if (capable(CAP_SYS_RESOURCE))
> -		return true;
>  	if (uid_eq(sbi->s_resuid, current_fsuid()))
>  		return true;
>  	if (!gid_eq(sbi->s_resgid, GLOBAL_ROOT_GID) &&
>  					in_group_p(sbi->s_resgid))
>  		return true;
> +	if (capable(CAP_SYS_RESOURCE))
> +		return true;
>  	return false;
>  }
>  
> 
