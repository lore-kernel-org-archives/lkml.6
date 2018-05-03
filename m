Return-Path: <jack@suse.cz>
X-Google-Smtp-Source: AB8JxZp4ljMfyiStnN+4lEzwS5wS9/qOFtTcwD+nMd+AxEs8fxoMvGzm7+FJXWxVH7n2t6cFAdlF
ARC-Seal: i=1; a=rsa-sha256; t=1525361635; cv=none;
        d=google.com; s=arc-20160816;
        b=AxWBciK5GbRv5QX6FaUoAzUr8zfka09ccfjmQhNBoa890dt1GbrC6/RvnCgXxJMq27
         ZoDINl6AHp6fxM7VqXnzbQ3AmwrY1nk9yz5vWfNaPlAr0eU7rk5fN4TL+/RDvF0F4ZzP
         AEyXKmHpotOM6ZGR3a6XWI3/CGipZySlud+mZFlLCmaM1IjCtckCE3qn/cmZDzuK7l+N
         q5o2g3+PSfBlYM5zCj1e03RpsEJWt14tjioXSJ3poOxTLt8XlbyQbcfE0G26bPcROAxz
         9yCeRkIeJoOcMFMlYmQA3RQ5yYg02Lwll1nKHVRUgzApt4XTTfV2JksKyMuub0eGcj3n
         TuKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=COZSdTRREV3i4igF7cjJMtyze6wvXZxTfzNuFn895Zc=;
        b=Gb2pYV1FirW/SOcHXGotU2JksoUJpBn9AOQ/SAB3O+1cXPd0Q0dmDUOZKPUAJo13Je
         WGz5GrrMUKbMIn0YMlVlJNdPx8iXKG3YIDYO5t/3gCQ27TIHYH1UwtQib1Vq/Xk7eu5T
         XOEd3QQq14oG3kNt52ZB31+UD5C379rayrgk9xGIzIm45TIDJVJursMWYQUludyPs0He
         bOjmGpR/VuGyQyXNYjJUqnE/KyPVce+ir3on9Z4VEUmOgY5M6mwFn5PDxVdfidbROktc
         AAOH8qqobRDhEbkL3dcA+N9gAleNleR2YsOmOUp1Lfd4cfvkWa4P/GDly5mzgOZmdgWX
         pwNw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jack@suse.cz designates 195.135.220.15 as permitted sender) smtp.mailfrom=jack@suse.cz
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jack@suse.cz designates 195.135.220.15 as permitted sender) smtp.mailfrom=jack@suse.cz
Date: Thu, 3 May 2018 17:33:51 +0200
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: syzbot <syzbot+db48ce201b524603190a@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com,
	weiping zhang <zhangweiping@didichuxing.com>,
	Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: KASAN: use-after-free Read in debugfs_remove (2)
Message-ID: <20180503153351.zmtmo2g6gxw5p6a4@quack2.suse.cz>
References: <000000000000fbda89056a818f20@google.com>
 <a5b6e0ff-ad8e-18f4-8c24-cdfafe4e3883@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5b6e0ff-ad8e-18f4-8c24-cdfafe4e3883@I-love.SAKURA.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598532704298959546?=
X-GMAIL-MSGID: =?utf-8?q?1599457601993976501?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 23-04-18 19:34:45, Tetsuo Handa wrote:
> From be88e559ec13f49b1c3aec2457c14c70f6b1926a Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Mon, 23 Apr 2018 11:21:03 +0900
> Subject: [PATCH] bdi: Fix use after free bug in debugfs_remove()
> 
> syzbot is reporting use after free bug in debugfs_remove() [1].
> 
> This is because fault injection made memory allocation for
> debugfs_create_file() from bdi_debug_register() from bdi_register_va()
> fail and continued with setting WB_registered. But when debugfs_remove()
> is called from debugfs_remove(bdi->debug_dir) from bdi_debug_unregister()
>  from bdi_unregister() from release_bdi() because WB_registered was set
> by bdi_register_va(), IS_ERR_OR_NULL(bdi->debug_dir) == false despite
> debugfs_remove(bdi->debug_dir) was already called from bdi_register_va().
> 
> Fix this by making IS_ERR_OR_NULL(bdi->debug_dir) == true.
> 
> [1] https://syzkaller.appspot.com/bug?id=5ab4efd91a96dcea9b68104f159adf4af2a6dfc1
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+049cb4ae097049dac137@syzkaller.appspotmail.com>
> Fixes: 97f07697932e6faf ("bdi: convert bdi_debug_register to int")
> Cc: weiping zhang <zhangweiping@didichuxing.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Jens Axboe <axboe@kernel.dk>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

Jens, can you please merge this fix? Thanks!

								Honza

> ---
>  mm/backing-dev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 023190c..7fe73fa 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -115,6 +115,7 @@ static int bdi_debug_register(struct backing_dev_info *bdi, const char *name)
>  					       bdi, &bdi_debug_stats_fops);
>  	if (!bdi->debug_stats) {
>  		debugfs_remove(bdi->debug_dir);
> +		bdi->debug_dir = NULL;
>  		return -ENOMEM;
>  	}
>  
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
