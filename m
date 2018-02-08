Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbeBHXLE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 18:11:04 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:63324 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbeBHXLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 18:11:03 -0500
To: chris@chris-wilson.co.uk, linux-kernel@vger.kernel.org
Cc: mingo@kernel.org, akpm@linux-foundation.org, ak@linux.intel.com,
        jack@suse.cz, aryabinin@virtuozzo.com, dvyukov@google.com
Subject: Re: [PATCH] khungtaskd: Kick stuck processes
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20180208190753.17690-1-chris@chris-wilson.co.uk>
In-Reply-To: <20180208190753.17690-1-chris@chris-wilson.co.uk>
Message-Id: <201802090810.DBF09356.OFMQFVFJtOHOLS@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Fri, 9 Feb 2018 08:10:43 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wilson wrote:
> After spotting a stuck process, and having decided not to panic, give
> the task a kick to see if that helps it to recover (e.g. to paper over a
> missed wake up).

Yes, we are seeing hangs at io_schedule(), but doesn't optionally allowing
io_schedule() be replaced with timeout version (e.g. dump_page() upon timeout
if io_schedule() was called for e.g. wait_on_page_bit()) give us more clue?

> 
> References: https://bugs.freedesktop.org/show_bug.cgi?id=104009
> References: https://bugs.freedesktop.org/show_bug.cgi?id=104682
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  kernel/hung_task.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 751593ed7c0b..b32acb6bcc63 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -132,6 +132,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
>  		trigger_all_cpu_backtrace();
>  		panic("hung_task: blocked tasks");
>  	}
> +
> +	wake_up_process(t);
>  }
>  
>  /*
> -- 
> 2.16.1
