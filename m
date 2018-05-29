Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932546AbeE2ItX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 04:49:23 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65390 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932470AbeE2ItD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 04:49:03 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot <syzbot+ae590932da6e45d6564d@syzkaller.appspotmail.com>
Subject: Re: [PATCH] PM / hibernate: Fix oops at snapshot_write().
Date: Tue, 29 May 2018 10:48:16 +0200
Message-ID: <3568719.h7yFa1lZHo@aspire.rjw.lan>
In-Reply-To: <1527296376-3540-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
References: <1527296376-3540-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, May 26, 2018 2:59:36 AM CEST Tetsuo Handa wrote:
> syzbot is reporting NULL pointer dereference at snapshot_write() [1].
> This is because data->handle is zero-cleared by ioctl(SNAPSHOT_FREE).
> Fix this by checking data_of(data->handle) != NULL before using it.
> 
> [1] https://syzkaller.appspot.com/bug?id=828a3c71bd344a6de8b6a31233d51a72099f27fd
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+ae590932da6e45d6564d@syzkaller.appspotmail.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> ---
>  kernel/power/user.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index 75c959d..abd2255 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -186,6 +186,11 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
>  		res = PAGE_SIZE - pg_offp;
>  	}
>  
> +	if (!data_of(data->handle)) {
> +		res = -EINVAL;
> +		goto unlock;
> +	}
> +
>  	res = simple_write_to_buffer(data_of(data->handle), res, &pg_offp,
>  			buf, count);
>  	if (res > 0)
> 

Applied, thanks!
