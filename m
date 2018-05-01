Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756046AbeEAOf3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 10:35:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755453AbeEAOf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 10:35:27 -0400
Date: Tue, 1 May 2018 16:35:24 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: christian.koenig@amd.com, "Eric W. Biederman" <ebiederm@xmission.com>,
        David.Panariti@amd.com, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Alexander.Deucher@amd.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
Message-ID: <20180501143524.GA13017@redhat.com>
References: <877eowa5qh.fsf@xmission.com>
 <20180425135552.GD7592@redhat.com>
 <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
 <20180425171757.GA10441@redhat.com>
 <c39cb438-1e8a-4f2c-50f6-c6e2a144487b@amd.com>
 <874ljyu98e.fsf@xmission.com>
 <c3c9787d-b279-8169-43d1-74eeb666ffbd@gmail.com>
 <bceb1a1b-c453-782d-5a7d-40fa2f22c813@amd.com>
 <20180430160006.GB10583@redhat.com>
 <e5b0221d-84ba-10ff-4a58-4fa27c99650f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5b0221d-84ba-10ff-4a58-4fa27c99650f@amd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/30, Andrey Grodzovsky wrote:
>
> On 04/30/2018 12:00 PM, Oleg Nesterov wrote:
> >On 04/30, Andrey Grodzovsky wrote:
> >>What about changing PF_SIGNALED to  PF_EXITING in
> >>drm_sched_entity_do_release
> >>
> >>-       if ((current->flags & PF_SIGNALED) && current->exit_code == SIGKILL)
> >>+      if ((current->flags & PF_EXITING) && current->exit_code == SIGKILL)
> >let me repeat, please don't use task->exit_code. And in fact this check is racy
> >
> >But this doesn't matter. Say, we can trivially add SIGNAL_GROUP_KILLED_BY_SIGKILL,
> >or do something else,
>
> Can you explain where is the race and what is a possible alternative then ?

Oh. I mentioned this race automatically, because I am pedant ;) Let me repeat
that this doesn't really matter, and let me remind that the caller of fop->release
can be completely unrelated process, say $cat /proc/pid/fdinfo. And in any case
->exit_code should not be used outside of ptrace/exit paths.

OK, the race. Consider a process P with a main thread M and a sub-thread T.

T does pthread_exit(), enters do_exit() and gets a preemption before exit_files().

The process is killed by SIGKILL. M calls do_group_exit(), do_exit() and passes
exit_files(). However, it doesn't call close_files() because T has another reference.

T resumes, calls close_files(), fput(), etc, and then exit_task_work(), so
it can finally call ->release() with current->exit_code == 0 desptite the fact
the process was killed.

Again, again, this doesn't matter. We can distinguish killed-or-not, by SIGKILL-
or-not. But I still do not think we actually need this. At least in ->release()
paths, ->flush() may differ.

Oleg.
