Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751161AbeDXVCS convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 17:02:18 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:41361 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbeDXVCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 17:02:15 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, David.Panariti@amd.com,
        oleg@redhat.com, Alexander.Deucher@amd.com, akpm@linux-foundation.org,
        Christian.Koenig@amd.com
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
        <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
        <7313704c-0693-0bb9-8818-99cd2b7c0ca0@daenzer.net>
        <20180424194418.GE25142@phenom.ffwll.local>
Date: Tue, 24 Apr 2018 16:00:32 -0500
In-Reply-To: <20180424194418.GE25142@phenom.ffwll.local> (Daniel Vetter's
        message of "Tue, 24 Apr 2018 21:44:18 +0200")
Message-ID: <87tvs0721b.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1fB54X-0001pY-Jk;;;mid=<87tvs0721b.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19x2DrNOZ5CazrZIWcEHS50rVuoo4WhFPk=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: =?ISO-8859-1?Q?**;Michel D=c3=a4nzer <michel@daenzer.net>?=
X-Spam-Relay-Country: 
X-Spam-Timing: total 15034 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.4 (0.0%), b_tie_ro: 1.54 (0.0%), parse: 1.39 (0.0%),
        extract_message_metadata: 21 (0.1%), get_uri_detail_list: 2.5 (0.0%),
        tests_pri_-1000: 4.9 (0.0%), tests_pri_-950: 1.85 (0.0%), tests_pri_-900:
        1.56 (0.0%), tests_pri_-400: 28 (0.2%), check_bayes: 27 (0.2%), b_tokenize:
        12 (0.1%), b_tok_get_all: 7 (0.0%), b_comp_prob: 2.4 (0.0%), b_tok_touch_all:
        3.2 (0.0%), b_finish: 0.61 (0.0%), tests_pri_0: 183 (1.2%),
        check_dkim_signature: 0.67 (0.0%), check_dkim_adsp: 3.7 (0.0%),
        tests_pri_500: 14786 (98.3%), poll_dns_idle: 14775 (98.3%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for signaled process.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Vetter <daniel@ffwll.ch> writes:

> On Tue, Apr 24, 2018 at 05:46:52PM +0200, Michel Dänzer wrote:
>> 
>> Adding the dri-devel list, since this is driver independent code.
>> 
>> 
>> On 2018-04-24 05:30 PM, Andrey Grodzovsky wrote:
>> > Avoid calling wait_event_killable when you are possibly being called
>> > from get_signal routine since in that case you end up in a deadlock
>> > where you are alreay blocked in singla processing any trying to wait
>> 
>> Multiple typos here, "[...] already blocked in signal processing and [...]"?
>> 
>> 
>> > on a new signal.
>> > 
>> > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>> > ---
>> >  drivers/gpu/drm/scheduler/gpu_scheduler.c | 5 +++--
>> >  1 file changed, 3 insertions(+), 2 deletions(-)
>> > 
>> > diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>> > index 088ff2b..09fd258 100644
>> > --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
>> > +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>> > @@ -227,9 +227,10 @@ void drm_sched_entity_do_release(struct drm_gpu_scheduler *sched,
>> >  		return;
>> >  	/**
>> >  	 * The client will not queue more IBs during this fini, consume existing
>> > -	 * queued IBs or discard them on SIGKILL
>> > +	 * queued IBs or discard them when in death signal state since
>> > +	 * wait_event_killable can't receive signals in that state.
>> >  	*/
>> > -	if ((current->flags & PF_SIGNALED) && current->exit_code == SIGKILL)
>> > +	if (current->flags & PF_SIGNALED)
>
> You want fatal_signal_pending() here, instead of inventing your own broken
> version.
>> >  		entity->fini_status = -ERESTARTSYS;
>> >  	else
>> >  		entity->fini_status = wait_event_killable(sched->job_scheduled,
>
> But really this smells like a bug in wait_event_killable, since
> wait_event_interruptible does not suffer from the same bug. It will return
> immediately when there's a signal pending.
>
> I think this should be fixed in core code, not papered over in some
> subsystem.

PF_SIGNALED does not mean a signal has been sent.  PF_SIGNALED means
the process was killed by a signal.

Neither of interruptible or killable makes sense after the process has
been killed.

Eric
