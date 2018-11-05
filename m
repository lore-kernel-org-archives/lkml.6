Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6431C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993AF20825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 10:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 993AF20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbeKET1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 14:27:41 -0500
Received: from outbound-smtp26.blacknight.com ([81.17.249.194]:43018 "EHLO
        outbound-smtp26.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726228AbeKET1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 14:27:41 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp26.blacknight.com (Postfix) with ESMTPS id 0B5D3B86FD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Nov 2018 10:08:43 +0000 (GMT)
Received: (qmail 1045 invoked from network); 5 Nov 2018 10:08:42 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.229.69])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 5 Nov 2018 10:08:42 -0000
Date:   Mon, 5 Nov 2018 10:08:41 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     subhra mazumdar <subhra.mazumdar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, dhaval.giani@oracle.com,
        steven.sistare@oracle.com, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH v2 1/1] pipe: busy wait for pipe
Message-ID: <20181105100841.GG23537@techsingularity.net>
References: <20180925233240.24451-1-subhra.mazumdar@oracle.com>
 <20180925233240.24451-2-subhra.mazumdar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20180925233240.24451-2-subhra.mazumdar@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Al Viro as per get_maintainers.pl.

On Tue, Sep 25, 2018 at 04:32:40PM -0700, subhra mazumdar wrote:
> Introduce pipe_ll_usec field for pipes that indicates the amount of micro
> seconds a thread should spin if pipe is empty or full before sleeping. This
> is similar to network sockets.

Can you point to what pattern from network sockets you are duplicated
exactly? One would assume it's busy_loop_current_time and busy_loop_timeout
but it should be in the changelog because there are differences in polling
depending on where you are in the network subsystem (which I'm not very
familiar with).

> Workloads like hackbench in pipe mode
> benefits significantly from this by avoiding the sleep and wakeup overhead.
> Other similar usecases can benefit. A tunable pipe_busy_poll is introduced
> to enable or disable busy waiting via /proc. The value of it specifies the
> amount of spin in microseconds. Default value is 0 indicating no spin.
> 

Your lead mail indicates the spin was set to a "suitable spin time". How
should an administrator select this spin time? What works for hackbench
might not be suitable for another workload. What if the spin time
selected happens to be just slightly longer than the time it takes the
reader to respond? In such a case, the result would be "all spin, no
gain". While networking potentially suffers the same problem, it appears
to be opt-in per socket so it's up to the application not to shoot
itself in the foot.

> Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
> ---
>  fs/pipe.c                 | 12 ++++++++++++
>  include/linux/pipe_fs_i.h |  2 ++
>  kernel/sysctl.c           |  7 +++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index bdc5d3c..35d805b 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -26,6 +26,7 @@
>  
>  #include <linux/uaccess.h>
>  #include <asm/ioctls.h>
> +#include <linux/sched/clock.h>
>  
>  #include "internal.h"
>  
> @@ -40,6 +41,7 @@ unsigned int pipe_max_size = 1048576;
>   */
>  unsigned long pipe_user_pages_hard;
>  unsigned long pipe_user_pages_soft = PIPE_DEF_BUFFERS * INR_OPEN_CUR;
> +unsigned int pipe_busy_poll;
>  
>  /*
>   * We use a start+len construction, which provides full use of the 
> @@ -106,6 +108,7 @@ void pipe_double_lock(struct pipe_inode_info *pipe1,
>  void pipe_wait(struct pipe_inode_info *pipe)
>  {
>  	DEFINE_WAIT(wait);
> +	u64 start;
>  
>  	/*
>  	 * Pipes are system-local resources, so sleeping on them
> @@ -113,6 +116,10 @@ void pipe_wait(struct pipe_inode_info *pipe)
>  	 */
>  	prepare_to_wait(&pipe->wait, &wait, TASK_INTERRUPTIBLE);
>  	pipe_unlock(pipe);
> +	start = local_clock();
> +	while (current->state != TASK_RUNNING &&
> +	       ((local_clock() - start) >> 10) < pipe->pipe_ll_usec)
> +		cpu_relax();
>  	schedule();
>  	finish_wait(&pipe->wait, &wait);
>  	pipe_lock(pipe);

Networking breaks this out better in terms of options instead of
hard-coding. This does not handle need_resched or signal delivery
properly where as networking does for example.

> @@ -825,6 +832,7 @@ static int do_pipe2(int __user *fildes, int flags)
>  	struct file *files[2];
>  	int fd[2];
>  	int error;
> +	struct pipe_inode_info *pipe;
>  
>  	error = __do_pipe_flags(fd, files, flags);
>  	if (!error) {
> @@ -838,6 +846,10 @@ static int do_pipe2(int __user *fildes, int flags)
>  			fd_install(fd[0], files[0]);
>  			fd_install(fd[1], files[1]);
>  		}
> +		pipe = files[0]->private_data;
> +		pipe->pipe_ll_usec = pipe_busy_poll;
> +		pipe = files[1]->private_data;
> +		pipe->pipe_ll_usec = pipe_busy_poll;
>  	}
>  	return error;
>  }

You add a pipe field but the value in always based on the sysctl
so the information is redundantu (barring a race condition on one
pipe write per sysctl update which is an irrelevant corner case). In
comparison, the network subsystem appears to be explicitly opt-in via
setsockopt(SO_BUSY_POLL) from a glance and the value appears to be tunable
on a per-socket basis (I didn't check for sure, this is based on a glance
at what networking does). It's not clear what a sensible way of replicating
that for pipe file descriptors would be but it's possible that the only
way would be to define the system-wide tunable as a max spin time and try
detect the optimal spin time on a per-fd basis (not entirely dissimilar
to how cpuidle menu guesses how long it'll be in an idle state for).

It's not really my area but I feel that this patch is a benchmark-specific
hack and that tuning it on a system-wide basis will be a game of "win
some, lose some" that is never used in practice. Worse, it might end up
in a tuning guide as "always set this sysctl" without considering the
capabilities of the machine or the workload and falls victim to cargo
cult tuning.

-- 
Mel Gorman
SUSE Labs
