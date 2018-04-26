Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbeDZACt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 20:02:49 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:42352 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbeDZACs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 20:02:48 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
        Christian.Koenig@amd.com, David.Panariti@amd.com,
        akpm@linux-foundation.org
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
        <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
        <87muxsbmkp.fsf@xmission.com>
        <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com>
        <877eowa5qh.fsf@xmission.com> <20180425135552.GD7592@redhat.com>
        <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
        <20180425171757.GA10441@redhat.com>
        <c39cb438-1e8a-4f2c-50f6-c6e2a144487b@amd.com>
Date: Wed, 25 Apr 2018 19:01:05 -0500
In-Reply-To: <c39cb438-1e8a-4f2c-50f6-c6e2a144487b@amd.com> (Andrey
        Grodzovsky's message of "Wed, 25 Apr 2018 14:40:54 -0400")
Message-ID: <874ljyu98e.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fBUMp-00051c-5H;;;mid=<874ljyu98e.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+041djFXo9fOfCtq4Ix1QLM87FzXrbEvQ=
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
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15022 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.4 (0.0%), b_tie_ro: 1.70 (0.0%), parse: 0.70 (0.0%),
        extract_message_metadata: 9 (0.1%), get_uri_detail_list: 0.67 (0.0%),
        tests_pri_-1000: 2.8 (0.0%), tests_pri_-950: 1.14 (0.0%), tests_pri_-900:
        0.96 (0.0%), tests_pri_-400: 16 (0.1%), check_bayes: 15 (0.1%), b_tokenize:
        4.5 (0.0%), b_tok_get_all: 5 (0.0%), b_comp_prob: 1.57 (0.0%),
        b_tok_touch_all: 2.2 (0.0%), b_finish: 0.53 (0.0%), tests_pri_0: 107 (0.7%),
        check_dkim_signature: 0.61 (0.0%), check_dkim_adsp: 3.0 (0.0%),
        tests_pri_500: 14880 (99.1%), poll_dns_idle: 14869 (99.0%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for signaled process.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:

> On 04/25/2018 01:17 PM, Oleg Nesterov wrote:
>> On 04/25, Andrey Grodzovsky wrote:
>>> here (drm_sched_entity_fini) is also a bad idea, but we still want to be
>>> able to exit immediately
>>> and not wait for GPU jobs completion when the reason for reaching this code
>>> is because of KILL
>>> signal to the user process who opened the device file.
>> Can you hook f_op->flush method?
>
> But this one is called for each task releasing a reference to the the file, so
> not sure I see how this solves the problem.

The big question is why do you need to wait during the final closing a
file?

The wait can be terminated so the wait does not appear to be simply a
matter of correctness.

Eric
