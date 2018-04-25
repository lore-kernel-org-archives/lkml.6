Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755873AbeDYQdY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:33:24 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:47262 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755408AbeDYQdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:33:14 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: David.Panariti@amd.com,
        Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        oleg@redhat.com, amd-gfx@lists.freedesktop.org,
        Alexander.Deucher@amd.com, akpm@linux-foundation.org,
        Christian.Koenig@amd.com
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
        <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
        <7313704c-0693-0bb9-8818-99cd2b7c0ca0@daenzer.net>
        <20180424194418.GE25142@phenom.ffwll.local>
        <aa2d8587-651e-2c24-a673-4682e7035a8f@amd.com>
        <87tvs05mik.fsf@xmission.com>
        <27d7d15b-f7c3-2a0a-af85-eb243526ac88@amd.com>
        <20180425071444.GM25142@phenom.ffwll.local>
        <94828a42-02dd-29ad-a3d0-dc4c0cc82ddb@amd.com>
        <87a7trwbh0.fsf@xmission.com>
        <311660b9-9e46-b960-3088-06e16ac3838d@amd.com>
Date: Wed, 25 Apr 2018 11:31:45 -0500
In-Reply-To: <311660b9-9e46-b960-3088-06e16ac3838d@amd.com> (Andrey
        Grodzovsky's message of "Wed, 25 Apr 2018 12:13:58 -0400")
Message-ID: <87y3hbtfgu.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fBNLz-0001Sy-0Y;;;mid=<87y3hbtfgu.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18+0YgW8qEIvnn/m9kD0F6m6kHQGs8YaMs=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 474 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 15 (3.1%), b_tie_ro: 14 (2.9%), parse: 1.34 (0.3%),
        extract_message_metadata: 24 (5.1%), get_uri_detail_list: 2.1 (0.4%),
        tests_pri_-1000: 8 (1.7%), tests_pri_-950: 2.2 (0.5%), tests_pri_-900: 1.82
        (0.4%), tests_pri_-400: 28 (6.0%), check_bayes: 26 (5.6%), b_tokenize: 10
        (2.1%), b_tok_get_all: 7 (1.4%), b_comp_prob: 4.0 (0.8%), b_tok_touch_all:
        2.4 (0.5%), b_finish: 0.84 (0.2%), tests_pri_0: 372 (78.6%),
        check_dkim_signature: 0.85 (0.2%), check_dkim_adsp: 5 (1.1%), tests_pri_500:
        14 (3.0%), poll_dns_idle: 0.04 (0.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for signaled process.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:

> On 04/25/2018 11:29 AM, Eric W. Biederman wrote:
>
>>  Another issue is changing wait_event_killable to wait_event_timeout where I need
>> to understand
>> what TO value is acceptable for all the drivers using the scheduler, or maybe it
>> should come as a property
>> of drm_sched_entity.
>>
>> It would not surprise me if you could pick a large value like 1 second
>> and issue a warning if that time outever triggers.  It sounds like the
>> condition where we wait indefinitely today is because something went
>> wrong in the driver.
>
> We wait here for all GPU jobs in flight which belong to the dying entity to complete. The driver submits
> the GPU jobs but the content of the job might be is not under driver's control and could take 
> long time to finish or even hang (e.g. graphic or compute shader) , I
> guess that why originally the wait is indefinite.


I am ignorant of what user space expect or what the semantics of the
susbsystem are here, so I might be completely off base.  But this wait
for a long time behavior I would expect much more from f_op->flush or a
f_op->fsync method.

fsync so it could be obtained without closing the file descriptor.
flush so that you could get a return value out to close.

But I honestly don't know semantically what your userspace applications
expect and/or require so I can really only say.  Those of weird semantics.

Eric
