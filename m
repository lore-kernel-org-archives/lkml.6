Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751647AbeDYU5L (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 16:57:11 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:37177 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750949AbeDYU5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 16:57:08 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: "Panariti\, David" <David.Panariti@amd.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx\@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher\, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig\, Christian" <Christian.Koenig@amd.com>,
        "oleg\@redhat.com" <oleg@redhat.com>,
        "akpm\@linux-foundation.org" <akpm@linux-foundation.org>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
        <1524583836-12130-4-git-send-email-andrey.grodzovsky@amd.com>
        <DM5PR12MB244017F98FC732EB5DD86E0395880@DM5PR12MB2440.namprd12.prod.outlook.com>
        <b4309ea4-c1a0-5811-040b-4390ce6f297f@amd.com>
        <DM5PR12MB24408FF7C780D95307FB2BAD95880@DM5PR12MB2440.namprd12.prod.outlook.com>
        <87bme8bm9g.fsf@xmission.com>
        <d5a1b82b-a9c2-e6e8-1957-aab8acac242c@amd.com>
Date: Wed, 25 Apr 2018 15:55:24 -0500
In-Reply-To: <d5a1b82b-a9c2-e6e8-1957-aab8acac242c@amd.com> (Andrey
        Grodzovsky's message of "Wed, 25 Apr 2018 13:17:40 -0400")
Message-ID: <87h8nzt39f.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fBRT9-0005S5-HI;;;mid=<87h8nzt39f.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/nan7rMNH2JdJz+BNn4IWtoSDg/NNR2EI=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15027 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.2 (0.0%), b_tie_ro: 1.43 (0.0%), parse: 1.20 (0.0%),
        extract_message_metadata: 16 (0.1%), get_uri_detail_list: 3.9 (0.0%),
        tests_pri_-1000: 3.1 (0.0%), tests_pri_-950: 1.17 (0.0%), tests_pri_-900:
        0.99 (0.0%), tests_pri_-400: 27 (0.2%), check_bayes: 26 (0.2%), b_tokenize: 9
        (0.1%), b_tok_get_all: 9 (0.1%), b_comp_prob: 2.8 (0.0%), b_tok_touch_all:
        3.2 (0.0%), b_finish: 0.61 (0.0%), tests_pri_0: 239 (1.6%),
        check_dkim_signature: 0.72 (0.0%), check_dkim_adsp: 3.0 (0.0%),
        tests_pri_500: 14734 (98.0%), poll_dns_idle: 14726 (98.0%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH 3/3] drm/amdgpu: Switch to interrupted wait to recover from ring hang.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:

> On 04/24/2018 12:30 PM, Eric W. Biederman wrote:
>> "Panariti, David" <David.Panariti@amd.com> writes:
>>
>>> Andrey Grodzovsky <andrey.grodzovsky@amd.com> writes:
>>>> Kind of dma_fence_wait_killable, except that we don't have such API
>>>> (maybe worth adding ?)
>>> Depends on how many places it would be called, or think it might be called.  Can always factor on the 2nd time it's needed.
>>> Factoring, IMO, rarely hurts.  The factored function can easily be visited using `M-.' ;->
>>>
>>> Also, if the wait could be very long, would a log message, something like "xxx has run for Y seconds."  help?
>>> I personally hate hanging w/no info.
>> Ugh.  This loop appears susceptible to loosing wake ups.  There are
>> races between when a wake-up happens, when we clear the sleeping state,
>> and when we test the stat to see if we should stat awake.  So yes
>> implementing a dma_fence_wait_killable that handles of all that
>> correctly sounds like an very good idea.
>
> I am not clear here - could you be more specific about what races will happen
> here, more bellow
>>
>> Eric
>>
>>
>>>> If the ring is hanging for some reason allow to recover the waiting by sending fatal signal.
>>>>
>>>> Originally-by: David Panariti <David.Panariti@amd.com>
>>>> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 14 ++++++++++----
>>>>    1 file changed, 10 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>>> index eb80edf..37a36af 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
>>>> @@ -421,10 +421,16 @@ int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx, unsigned ring_id)
>>>>
>>>>        if (other) {
>>>>                signed long r;
>>>> -             r = dma_fence_wait_timeout(other, false, MAX_SCHEDULE_TIMEOUT);
>>>> -             if (r < 0) {
>>>> -                     DRM_ERROR("Error (%ld) waiting for fence!\n", r);
>>>> -                     return r;
>>>> +
>>>> +             while (true) {
>>>> +                     if ((r = dma_fence_wait_timeout(other, true,
>>>> +                                     MAX_SCHEDULE_TIMEOUT)) >= 0)
>>>> +                             return 0;
>>>> +
>
> Do you mean that by the time I reach here some other thread from my group
> already might dequeued SIGKILL since it's a shared signal and hence
> fatal_signal_pending will return false ? Or are you talking about the
> dma_fence_wait_timeout implementation in dma_fence_default_wait with
> schedule_timeout ?

Given Oleg's earlier comment about the scheduler having special cases
for signals I might be wrong.  But in general there is a pattern:

	for (;;) {
		set_current_state(TASK_UNINTERRUPTIBLE);
		if (loop_is_done())
			break;
		schedule();
	}
        set_current_state(TASK_RUNNING);

If you violate that pattern by testing for a condition without
having first set your task as TASK_UNINTERRUPTIBLE (or whatever your
sleep state is).  Then it is possible to miss a wake-up that
tests the condidtion.

Thus I am quite concerned that there is a subtle corner case where
you can miss a wakeup and not retest fatal_signal_pending().

Given that there is is a timeout the worst case might have you sleep
MAX_SCHEDULE_TIMEOUT instead of indefinitely.

Without a comment why this is safe, or having fatal_signal_pending
check integrated into dma_fence_wait_timeout I am not comfortable
with this loop.

Eric


>>>> +                     if (fatal_signal_pending(current)) {
>>>> +                             DRM_ERROR("Error (%ld) waiting for fence!\n", r);
>>>> +                             return r;
>>>> +                     }
>>>>                }
>>>>        }
>>>>
>>>> --
>>>> 2.7.4
>>>>
>> Eric
