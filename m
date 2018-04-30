Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754820AbeD3QAK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 12:00:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754474AbeD3QAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 12:00:09 -0400
Date: Mon, 30 Apr 2018 18:00:06 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: christian.koenig@amd.com, "Eric W. Biederman" <ebiederm@xmission.com>,
        David.Panariti@amd.com, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Alexander.Deucher@amd.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
Message-ID: <20180430160006.GB10583@redhat.com>
References: <87muxsbmkp.fsf@xmission.com>
 <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com>
 <877eowa5qh.fsf@xmission.com>
 <20180425135552.GD7592@redhat.com>
 <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
 <20180425171757.GA10441@redhat.com>
 <c39cb438-1e8a-4f2c-50f6-c6e2a144487b@amd.com>
 <874ljyu98e.fsf@xmission.com>
 <c3c9787d-b279-8169-43d1-74eeb666ffbd@gmail.com>
 <bceb1a1b-c453-782d-5a7d-40fa2f22c813@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bceb1a1b-c453-782d-5a7d-40fa2f22c813@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/30, Andrey Grodzovsky wrote:
>
> What about changing PF_SIGNALED to  PF_EXITING in
> drm_sched_entity_do_release
>
> -       if ((current->flags & PF_SIGNALED) && current->exit_code == SIGKILL)
> +      if ((current->flags & PF_EXITING) && current->exit_code == SIGKILL)

let me repeat, please don't use task->exit_code. And in fact this check is racy.

But this doesn't matter. Say, we can trivially add SIGNAL_GROUP_KILLED_BY_SIGKILL,
or do something else, but I fail to understand what are you trying to do. Suppose
that the check above is correct in that it is true iff the task is exiting and
it was killed by SIGKILL. What about the "else" branch which does

	r = wait_event_killable(sched->job_scheduled, ...)

?

Once again, fatal_signal_pending() (or even signal_pending()) is not well defined
after the exiting task passes exit_signals().

So wait_event_killable() can fail because fatal_signal_pending() is true; and this
can happen even if it was not killed.

Or it can block and SIGKILL won't be able to wake it up.

> If SIGINT was sent then it's SIGINT,

Yes, but see above. in this case fatal_signal_pending() will be likely true so
wait_event_killable() will fail unless condition is already true.

Oleg.
