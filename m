Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751575AbeDXQYq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:24:46 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:38149 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeDXQYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:24:44 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
        <David.Panariti@amd.com>, <oleg@redhat.com>,
        <akpm@linux-foundation.org>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
        <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
Date: Tue, 24 Apr 2018 11:23:18 -0500
In-Reply-To: <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
        (Andrey Grodzovsky's message of "Tue, 24 Apr 2018 11:30:35 -0400")
Message-ID: <87muxsbmkp.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fB0kE-00061D-LF;;;mid=<87muxsbmkp.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+DqkxCcX4823OE7f8fnRg0igG+wbbriVU=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Andrey Grodzovsky <andrey.grodzovsky@amd.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 244 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.5 (1.0%), b_tie_ro: 1.69 (0.7%), parse: 1.16 (0.5%),
        extract_message_metadata: 12 (5.0%), get_uri_detail_list: 1.74 (0.7%),
        tests_pri_-1000: 5.0 (2.0%), tests_pri_-950: 1.19 (0.5%), tests_pri_-900:
        1.01 (0.4%), tests_pri_-400: 30 (12.5%), check_bayes: 29 (12.1%), b_tokenize:
        6 (2.5%), b_tok_get_all: 15 (6.0%), b_comp_prob: 2.1 (0.9%), b_tok_touch_all:
        3.2 (1.3%), b_finish: 0.65 (0.3%), tests_pri_0: 182 (74.4%),
        check_dkim_signature: 0.48 (0.2%), check_dkim_adsp: 3.8 (1.6%),
        tests_pri_500: 6 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for signaled process.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Grodzovsky <andrey.grodzovsky@amd.com> writes:

> Avoid calling wait_event_killable when you are possibly being called
> from get_signal routine since in that case you end up in a deadlock
> where you are alreay blocked in singla processing any trying to wait
> on a new signal.

I am curious what the call path that is problematic here.

In general waiting seems wrong when the process has already been
fatally killed as indicated by PF_SIGNALED.

Returning -ERESTARTSYS seems wrong as nothing should make it back even
to the edge of userspace here.

Given that this is the only use of PF_SIGNALED outside of bsd process
accounting I find this code very suspicious.

It looks the code path that gets called during exit is buggy and needs
to be sorted out.

Eric


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
