Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbeDXPrA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:47:00 -0400
Received: from mail.netline.ch ([148.251.143.178]:60387 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbeDXPq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:46:56 -0400
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc: David.Panariti@amd.com, oleg@redhat.com, ebiederm@xmission.com,
        Alexander.Deucher@amd.com, akpm@linux-foundation.org,
        Christian.Koenig@amd.com
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <7313704c-0693-0bb9-8818-99cd2b7c0ca0@daenzer.net>
Date: Tue, 24 Apr 2018 17:46:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Adding the dri-devel list, since this is driver independent code.


On 2018-04-24 05:30 PM, Andrey Grodzovsky wrote:
> Avoid calling wait_event_killable when you are possibly being called
> from get_signal routine since in that case you end up in a deadlock
> where you are alreay blocked in singla processing any trying to wait

Multiple typos here, "[...] already blocked in signal processing and [...]"?


> on a new signal.
> 
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/scheduler/gpu_scheduler.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/drm/scheduler/gpu_scheduler.c
> index 088ff2b..09fd258 100644
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
>  		entity->fini_status = -ERESTARTSYS;
>  	else
>  		entity->fini_status = wait_event_killable(sched->job_scheduled,
> 


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
