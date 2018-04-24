Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751226AbeDXRNt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:13:49 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:45190 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeDXRNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:13:48 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
        David.Panariti@amd.com, oleg@redhat.com, akpm@linux-foundation.org
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
        <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
        <87muxsbmkp.fsf@xmission.com>
        <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com>
Date: Tue, 24 Apr 2018 12:12:22 -0500
In-Reply-To: <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com> (Andrey
        Grodzovsky's message of "Tue, 24 Apr 2018 12:43:28 -0400")
Message-ID: <877eowa5qh.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fB1Vi-0000lv-HV;;;mid=<877eowa5qh.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+jvaoP0BlCHZpNt7p0NU6nS6R1rb6JMLI=
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
        *  1.0 T_XMDrugObfuBody_04 obfuscated drug references
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 320 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.3 (0.7%), b_tie_ro: 1.54 (0.5%), parse: 1.44 (0.4%),
        extract_message_metadata: 18 (5.5%), get_uri_detail_list: 4.1 (1.3%),
        tests_pri_-1000: 5 (1.7%), tests_pri_-950: 1.70 (0.5%), tests_pri_-900: 1.35
        (0.4%), tests_pri_-400: 36 (11.2%), check_bayes: 35 (10.8%), b_tokenize: 10
        (3.1%), b_tok_get_all: 15 (4.8%), b_comp_prob: 2.6 (0.8%), b_tok_touch_all:
        4.1 (1.3%), b_finish: 0.72 (0.2%), tests_pri_0: 245 (76.5%),
        check_dkim_signature: 0.54 (0.2%), check_dkim_adsp: 2.8 (0.9%),
        tests_pri_500: 4.9 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for signaled process.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:

> On 04/24/2018 12:23 PM, Eric W. Biederman wrote:
>> Andrey Grodzovsky <andrey.grodzovsky@amd.com> writes:
>>
>>> Avoid calling wait_event_killable when you are possibly being called
>>> from get_signal routine since in that case you end up in a deadlock
>>> where you are alreay blocked in singla processing any trying to wait
>>> on a new signal.
>> I am curious what the call path that is problematic here.
>
> Here is the problematic call stack
>
> [<0>] drm_sched_entity_fini+0x10a/0x3a0 [gpu_sched]
> [<0>] amdgpu_ctx_do_release+0x129/0x170 [amdgpu]
> [<0>] amdgpu_ctx_mgr_fini+0xd5/0xe0 [amdgpu]
> [<0>] amdgpu_driver_postclose_kms+0xcd/0x440 [amdgpu]
> [<0>] drm_release+0x414/0x5b0 [drm]
> [<0>] __fput+0x176/0x350
> [<0>] task_work_run+0xa1/0xc0
> [<0>] do_exit+0x48f/0x1280
> [<0>] do_group_exit+0x89/0x140
> [<0>] get_signal+0x375/0x8f0
> [<0>] do_signal+0x79/0xaa0
> [<0>] exit_to_usermode_loop+0x83/0xd0
> [<0>] do_syscall_64+0x244/0x270
> [<0>] entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> [<0>] 0xffffffffffffffff
>
> On exit from system call you process all the signals you received and
> encounter a fatal signal which triggers process termination.
>
>>
>> In general waiting seems wrong when the process has already been
>> fatally killed as indicated by PF_SIGNALED.
>
> So indeed this patch avoids wait in this case.
>
>>
>> Returning -ERESTARTSYS seems wrong as nothing should make it back even
>> to the edge of userspace here.
>
> Can you clarify please - what should be returned here instead ?

__fput does not have a return code.  I don't see the return code of
release being used anywhere.  So any return code is going to be lost.
So maybe something that talks to the drm/kernel layer but don't expect
your system call to be restarted, which is what -ERESTARTSYS asks for.

Hmm.  When looking at the code that is merged versus whatever your
patch is against it gets even clearer.  The -ERESTARTSYS
return code doesn't even get out of drm_sched_entity_fini.

Caring at all about process state at that point is wrong, as except for
being in ``process'' context where you can sleep nothing is connected to
a process.

Let me respectfully suggest that the wait_event_killable on that code
path is wrong.  Possibly you want a wait_event_timeout if you are very
nice.  But the code already has the logic necessary to handle what
happens if it can't sleep.

So I think the justification needs to be why you are trying to sleep
there at all.

The progress guarantee needs to come from the gpu layer or the AMD
driver not from someone getting impatient and sending SIGKILL to
a dead process.


Eric


>>
>> Given that this is the only use of PF_SIGNALED outside of bsd process
>> accounting I find this code very suspicious.
>>
>> It looks the code path that gets called during exit is buggy and needs
>> to be sorted out.
>>
>> Eric
>>
>>
>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>> ---
>>>   drivers/gpu/drm/scheduler/gpu_scheduler.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/scheduler/gpu_scheduler.c b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>>> index 088ff2b..09fd258 100644
>>> --- a/drivers/gpu/drm/scheduler/gpu_scheduler.c
>>> +++ b/drivers/gpu/drm/scheduler/gpu_scheduler.c
>>> @@ -227,9 +227,10 @@ void drm_sched_entity_do_release(struct drm_gpu_scheduler *sched,
>>>   		return;
>>>   	/**
>>>   	 * The client will not queue more IBs during this fini, consume existing
>>> -	 * queued IBs or discard them on SIGKILL
>>> +	 * queued IBs or discard them when in death signal state since
>>> +	 * wait_event_killable can't receive signals in that state.
>>>   	*/
>>> -	if ((current->flags & PF_SIGNALED) && current->exit_code == SIGKILL)
>>> +	if (current->flags & PF_SIGNALED)
>>>   		entity->fini_status = -ERESTARTSYS;
>>>   	else
>>>   		entity->fini_status = wait_event_killable(sched->job_scheduled,
