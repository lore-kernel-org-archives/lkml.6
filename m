Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754765AbeEAK1n (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 06:27:43 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:33499 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeEAK1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 06:27:39 -0400
Subject: Re: INFO: task hung in wb_shutdown (2)
To: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Tejun Heo <tj@kernel.org>
Cc: syzbot <syzbot+c0cf869505e03bdf1a24@syzkaller.appspotmail.com>,
        christophe.jaillet@wanadoo.fr, LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, syzkaller-bugs@googlegroups.com,
        weiping zhang <zhangweiping@didichuxing.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>, linux-block@vger.kernel.org
References: <94eb2c05b2d83650030568cc8bd9@google.com>
 <e56c1600-8923-dd6b-d065-c2fd2a720404@I-love.SAKURA.ne.jp>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <43302799-1c50-4cab-b974-9fe1ca584813@I-love.SAKURA.ne.jp>
Date: Tue, 1 May 2018 19:27:14 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e56c1600-8923-dd6b-d065-c2fd2a720404@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun, Jan, Jens,

Can you review this patch? syzbot has hit this bug for nearly 4000 times but
is still unable to find a reproducer. Therefore, the only way to test would be
to apply this patch upstream and test whether the problem is solved.

On 2018/04/24 21:19, Tetsuo Handa wrote:
>>From 39ed6be8a2c12dfe54feaa5abbc2ec46103022bf Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Tue, 24 Apr 2018 11:59:08 +0900
> Subject: [PATCH] bdi: wake up concurrent wb_shutdown() callers.
> 
> syzbot is reporting hung tasks at wait_on_bit(WB_shutting_down) in
> wb_shutdown() [1]. This might be because commit 5318ce7d46866e1d ("bdi:
> Shutdown writeback on all cgwbs in cgwb_bdi_destroy()") forgot to call
> wake_up_bit(WB_shutting_down) after clear_bit(WB_shutting_down).
> 
> [1] https://syzkaller.appspot.com/bug?id=b297474817af98d5796bc544e1bb806fc3da0e5e
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Reported-by: syzbot <syzbot+c0cf869505e03bdf1a24@syzkaller.appspotmail.com>
> Fixes: 5318ce7d46866e1d ("bdi: Shutdown writeback on all cgwbs in cgwb_bdi_destroy()")
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Jens Axboe <axboe@fb.com>
> ---
>  mm/backing-dev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index 023190c..dadac99 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -384,6 +384,8 @@ static void wb_shutdown(struct bdi_writeback *wb)
>  	 */
>  	smp_wmb();
>  	clear_bit(WB_shutting_down, &wb->state);
> +	smp_mb(); /* advised by wake_up_bit() */
> +	wake_up_bit(&wb->state, WB_shutting_down);
>  }
>  
>  static void wb_exit(struct bdi_writeback *wb)
> 
