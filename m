Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754011AbeDYNNy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:13:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752349AbeDYNNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:13:53 -0400
Date: Wed, 25 Apr 2018 15:13:50 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
        David.Panariti@amd.com, akpm@linux-foundation.org,
        ebiederm@xmission.com
Subject: Re: [PATCH 1/3] signals: Allow generation of SIGKILL to exiting task.
Message-ID: <20180425131350.GB7592@redhat.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-2-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524583836-12130-2-git-send-email-andrey.grodzovsky@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24, Andrey Grodzovsky wrote:
>
> Currently calling wait_event_killable as part of exiting process
> will stall forever since SIGKILL generation is suppresed by PF_EXITING.

See my reply to 2/3,

> In our partilaur case AMDGPU driver wants to flush all GPU jobs in
> flight before shutting down. But if some job hangs the pipe we still want to
> be able to kill it and avoid a process in D state.

this patch won't really help in multi-threaded case,

> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -886,10 +886,10 @@ static inline int wants_signal(int sig, struct task_struct *p)
>  {
>  	if (sigismember(&p->blocked, sig))
>  		return 0;
> -	if (p->flags & PF_EXITING)
> -		return 0;
>  	if (sig == SIGKILL)
>  		return 1;
> +	if (p->flags & PF_EXITING)
> +		return 0;

So you want to trigger signal_wake_up() at the end of complete_signal().

Unless you use tkill() you can wake another thread, not the thread blocked
in drm_sched_entity_fini().

And if the whole process is already dying complete_signal() will do nothing
else.

Oleg.
