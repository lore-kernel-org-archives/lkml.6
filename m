Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbeDXQoO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:44:14 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:54018 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbeDXQoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:44:13 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
        <David.Panariti@amd.com>, <oleg@redhat.com>,
        <akpm@linux-foundation.org>
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
        <1524583836-12130-2-git-send-email-andrey.grodzovsky@amd.com>
Date: Tue, 24 Apr 2018 11:42:47 -0500
In-Reply-To: <1524583836-12130-2-git-send-email-andrey.grodzovsky@amd.com>
        (Andrey Grodzovsky's message of "Tue, 24 Apr 2018 11:30:34 -0400")
Message-ID: <87y3hca73s.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fB136-0002Ko-9F;;;mid=<87y3hca73s.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19/95cB5SipDUuSwgk9c88wSds4+vAjnfg=
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
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Andrey Grodzovsky <andrey.grodzovsky@amd.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 207 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 6 (2.8%), b_tie_ro: 3.8 (1.8%), parse: 0.70 (0.3%),
        extract_message_metadata: 9 (4.6%), get_uri_detail_list: 0.96 (0.5%),
        tests_pri_-1000: 6 (2.7%), tests_pri_-950: 1.14 (0.6%), tests_pri_-900: 0.96
        (0.5%), tests_pri_-400: 22 (10.6%), check_bayes: 21 (10.1%), b_tokenize: 5
        (2.5%), b_tok_get_all: 5 (2.5%), b_comp_prob: 1.61 (0.8%), b_tok_touch_all: 7
        (3.5%), b_finish: 0.59 (0.3%), tests_pri_0: 155 (75.0%),
        check_dkim_signature: 0.45 (0.2%), check_dkim_adsp: 32 (15.2%),
        tests_pri_500: 3.7 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/3] signals: Allow generation of SIGKILL to exiting task.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Grodzovsky <andrey.grodzovsky@amd.com> writes:

> Currently calling wait_event_killable as part of exiting process
> will stall forever since SIGKILL generation is suppresed by PF_EXITING.
>
> In our partilaur case AMDGPU driver wants to flush all GPU jobs in
> flight before shutting down. But if some job hangs the pipe we still want to
> be able to kill it and avoid a process in D state.

I should clarify.  This absolutely can not be done.
PF_EXITING is set just before a task starts tearing down it's signal
handling.

So delivering any signal, or otherwise depending on signal handling
after PF_EXITING is set can not be done.  That abstraction is gone.

Eric

> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  kernel/signal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index c6e4c83..c49c706 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -886,10 +886,10 @@ static inline int wants_signal(int sig, struct task_struct *p)
>  {
>  	if (sigismember(&p->blocked, sig))
>  		return 0;
> -	if (p->flags & PF_EXITING)
> -		return 0;
>  	if (sig == SIGKILL)
>  		return 1;
> +	if (p->flags & PF_EXITING)
> +		return 0;
>  	if (task_is_stopped_or_traced(p))
>  		return 0;
>  	return task_curr(p) || !signal_pending(p);
