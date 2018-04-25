Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753452AbeDYNFD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753202AbeDYNFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:05:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE65B204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=chao@kernel.org
Subject: Re: [f2fs-dev] [PATCH 5/5] f2fs: enforce fsync_mode=strict for
 renamed directory
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20180425054613.2700-1-jaegeuk@kernel.org>
 <20180425054613.2700-5-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
Message-ID: <42858ef4-c1b8-c83e-4b47-39e28e161e16@kernel.org>
Date: Wed, 25 Apr 2018 21:04:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180425054613.2700-5-jaegeuk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/4/25 13:46, Jaegeuk Kim wrote:
> This is to give a option for user to be able to recover B/foo in the below
> case.
> 
> mkdir A
> sync()
> rename(A, B)
> creat (B/foo)
> fsync (B/foo)
> ---crash---

That makes sense, IMO, it will be better to cover cross rename case as well?

Thanks,

> 
> Sugessted-by: Velayudhan Pillai <vijay@cs.utexas.edu>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/namei.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index b5f404674cad..fef6e3ab2135 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -973,8 +973,11 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
>  			f2fs_put_page(old_dir_page, 0);
>  		f2fs_i_links_write(old_dir, false);
>  	}
> -	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
> +	if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT) {
>  		add_ino_entry(sbi, new_dir->i_ino, TRANS_DIR_INO);
> +		if (S_ISDIR(old_inode->i_mode))
> +			add_ino_entry(sbi, old_inode->i_ino, TRANS_DIR_INO);
> +	}
>  
>  	f2fs_unlock_op(sbi);
>  
> 
