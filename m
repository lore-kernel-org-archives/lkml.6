Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932868AbeD0QQ2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 12:16:28 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:48952 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757513AbeD0QQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 12:16:26 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20180427093426.13321-1-bigeasy@linutronix.de>
Date: Fri, 27 Apr 2018 11:16:06 -0500
In-Reply-To: <20180427093426.13321-1-bigeasy@linutronix.de> (Sebastian Andrzej
        Siewior's message of "Fri, 27 Apr 2018 11:34:26 +0200")
Message-ID: <87bme48w1l.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fC62c-0006bG-Dy;;;mid=<87bme48w1l.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18xt7gs3ThM9RaFcyzIR4avi3Wb8/R5HLs=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4981]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15021 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.4 (0.0%), b_tie_ro: 1.68 (0.0%), parse: 0.71 (0.0%),
        extract_message_metadata: 10 (0.1%), get_uri_detail_list: 1.47 (0.0%),
        tests_pri_-1000: 2.6 (0.0%), tests_pri_-950: 1.09 (0.0%), tests_pri_-900:
        0.91 (0.0%), tests_pri_-400: 18 (0.1%), check_bayes: 17 (0.1%), b_tokenize: 6
        (0.0%), b_tok_get_all: 6 (0.0%), b_comp_prob: 1.75 (0.0%), b_tok_touch_all:
        2.4 (0.0%), b_finish: 0.56 (0.0%), tests_pri_0: 136 (0.9%),
        check_dkim_signature: 0.58 (0.0%), check_dkim_adsp: 2.9 (0.0%),
        tests_pri_500: 14847 (98.8%), poll_dns_idle: 14838 (98.8%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH] posix-timers: Prevent broadcast signals
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> From: Thomas Gleixner <tglx@linutronix.de>
>
> Posix timers should not send broadcast signals and kernel only
> signals. Prevent it.

You are not adding prevention of ``broadcast'' signals by preventing
sig_kernel_only and sig_kernel_coredump so your change description does
not make sense.

Second we are sending the signal to ourselves.  It may be silly to use
a timer to send SIGKILL or SIGSTOP but I can imagine some reasons.

For signals that might coredump if you setup a handler they won't
coredump so preventing those seems even sillier.

So what is the reason for changing which signals posix timers send?

If SIGEV_THREAD_ID is specificied I can understand not wanting
to send signals that could affect more than just a thread.

if SIGEV_THREAD is specified I can understand not wanting signals
that will do more than wake up the thread.  I presume glibc precreates
the thread.

Neither of those cases should apply to everything passing through
good_sigevent.  So your code is wrong if those are your justification.

Further the kernel is perfectly capable of delivering all types of
signal through send_sigqueue so there is no techincal reason for
preventing these signals.

Eric


> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/time/posix-timers.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> index b6899b5060bd..4c4cbebb0d71 100644
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -435,6 +435,7 @@ static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
>  static struct pid *good_sigevent(sigevent_t * event)
>  {
>  	struct task_struct *rtn = current->group_leader;
> +	int sig = event->sigev_signo;
>  
>  	switch (event->sigev_notify) {
>  	case SIGEV_SIGNAL | SIGEV_THREAD_ID:
> @@ -444,7 +445,8 @@ static struct pid *good_sigevent(sigevent_t * event)
>  		/* FALLTHRU */
>  	case SIGEV_SIGNAL:
>  	case SIGEV_THREAD:
> -		if (event->sigev_signo <= 0 || event->sigev_signo > SIGRTMAX)
> +		if (sig <= 0 || sig > SIGRTMAX ||
> +		    sig_kernel_only(sig) || sig_kernel_coredump(sig))
>  			return NULL;
>  		/* FALLTHRU */
>  	case SIGEV_NONE:
