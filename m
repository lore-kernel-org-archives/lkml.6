Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751933AbeDXRbA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:31:00 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:34964 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbeDXRa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:30:58 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
        David.Panariti@amd.com, oleg@redhat.com, akpm@linux-foundation.org
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
        <1524583836-12130-2-git-send-email-andrey.grodzovsky@amd.com>
        <87y3hca73s.fsf@xmission.com>
        <e371e586-0859-adb0-6666-d40a909d0b22@amd.com>
Date: Tue, 24 Apr 2018 12:29:32 -0500
In-Reply-To: <e371e586-0859-adb0-6666-d40a909d0b22@amd.com> (Andrey
        Grodzovsky's message of "Tue, 24 Apr 2018 12:51:13 -0400")
Message-ID: <871sf48qdf.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fB1mK-000514-PC;;;mid=<871sf48qdf.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19N7LPTUYmHm5Y0FIwrELOcZl/CE6PfpKw=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 476 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 4.1 (0.9%), b_tie_ro: 2.7 (0.6%), parse: 1.45 (0.3%),
        extract_message_metadata: 17 (3.6%), get_uri_detail_list: 2.2 (0.5%),
        tests_pri_-1000: 8 (1.6%), tests_pri_-950: 1.72 (0.4%), tests_pri_-900: 1.45
        (0.3%), tests_pri_-400: 25 (5.2%), check_bayes: 23 (4.9%), b_tokenize: 8
        (1.8%), b_tok_get_all: 6 (1.3%), b_comp_prob: 2.7 (0.6%), b_tok_touch_all:
        2.3 (0.5%), b_finish: 0.73 (0.2%), tests_pri_0: 153 (32.2%),
        check_dkim_signature: 0.57 (0.1%), check_dkim_adsp: 4.5 (0.9%),
        tests_pri_500: 260 (54.6%), poll_dns_idle: 251 (52.6%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH 1/3] signals: Allow generation of SIGKILL to exiting task.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:

> On 04/24/2018 12:42 PM, Eric W. Biederman wrote:
>> Andrey Grodzovsky <andrey.grodzovsky@amd.com> writes:
>>
>>> Currently calling wait_event_killable as part of exiting process
>>> will stall forever since SIGKILL generation is suppresed by PF_EXITING.
>>>
>>> In our partilaur case AMDGPU driver wants to flush all GPU jobs in
>>> flight before shutting down. But if some job hangs the pipe we still want to
>>> be able to kill it and avoid a process in D state.
>> I should clarify.  This absolutely can not be done.
>> PF_EXITING is set just before a task starts tearing down it's signal
>> handling.
>>
>> So delivering any signal, or otherwise depending on signal handling
>> after PF_EXITING is set can not be done.  That abstraction is gone.
>
> I see, so you suggest it's the driver responsibility to avoid creating
> such code path that ends up
> calling wait_event_killable from exit call stack (PF_EXITING == 1) ?

I don't just suggest.

I am saying clearly that any dependency on receiving SIGKILL after
PF_EXITING is set is a bug.

It looks safe (the bitmap is not freed) to use wait_event_killable on a
dual use code path, but you can't expect SIGKILL ever to be delivered
during fop->release, as f_op->release is called from exit after signal
handling has been shutdown.

The best generic code could do would be to always have
fatal_signal_pending return true after PF_EXITING is set.

Increasingly I am thinking that drm_sched_entity_fini should have a
wait_event_timeout or no wait at all.  The cleanup code should have
a progress guarantee of it's own.

Eric
