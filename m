Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbeDYNFb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:05:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753508AbeDYNFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:05:25 -0400
Date: Wed, 25 Apr 2018 15:05:22 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
        David.Panariti@amd.com, akpm@linux-foundation.org,
        ebiederm@xmission.com
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
Message-ID: <20180425130522.GA7592@redhat.com>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24, Andrey Grodzovsky wrote:
>
> --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> @@ -227,9 +227,10 @@ void drm_sched_entity_do_release(struct drm_gpu_scheduler *sched,
>  		return;
>  	/**
>  	 * The client will not queue more IBs during this fini, consume existing
> -	 * queued IBs or discard them on SIGKILL
> +	 * queued IBs or discard them when in death signal state since
> +	 * wait_event_killable can't receive signals in that state.
>  	*/
> -	if ((current->flags & PF_SIGNALED) && current->exit_code == SIGKILL)
> +	if (current->flags & PF_SIGNALED)

please do not use PF_SIGNALED, it must die. Besides you can't rely on this flag
in multi-threaded case. current->exit_code doesn't look right too.

>  		entity->fini_status = -ERESTARTSYS;
>  	else
>  		entity->fini_status = wait_event_killable(sched->job_scheduled,

So afaics the problem is that fatal_signal_pending() is not necessarily true
after SIGKILL was already dequeued and thus wait_event_killable(), right?

This was already discussed, but it is not clear what we can/should do. We can
probably change get_signal() to not dequeue SIGKILL or do something else to keep
fatal_signal_pending() == T for the exiting killed thread.

But in this case we probably also want to discriminate the "real" SIGKILL's from
group_exit/exec/coredump.

Oleg.
