Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934961AbeBML4q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 06:56:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:35712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934861AbeBML4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 06:56:45 -0500
Date: Tue, 13 Feb 2018 12:56:42 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] khungtaskd: Kick stuck processes
Message-ID: <20180213115642.GR3443@dhcp22.suse.cz>
References: <20180208190753.17690-1-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208190753.17690-1-chris@chris-wilson.co.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 08-02-18 19:07:53, Chris Wilson wrote:
> After spotting a stuck process, and having decided not to panic, give
> the task a kick to see if that helps it to recover (e.g. to paper over a
> missed wake up).

huh, this is just no-no. watchdog is there to report problems not
interfere. You cannot never know whether the sleeper is prepared for
spurious wakeups. Do not paper over bugs...

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

-- 
Michal Hocko
SUSE Labs
