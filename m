Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757119AbeDKT2l (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 15:28:41 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:41632 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757063AbeDKT2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 15:28:39 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@googlemail.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@kernel.org>,
        Serge Hallyn <serge@hallyn.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
References: <20180411183622.305902791@linuxfoundation.org>
        <20180411183623.247331431@linuxfoundation.org>
Date: Wed, 11 Apr 2018 14:27:19 -0500
In-Reply-To: <20180411183623.247331431@linuxfoundation.org> (Greg
        Kroah-Hartman's message of "Wed, 11 Apr 2018 20:32:41 +0200")
Message-ID: <87r2nlilwo.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f6LQ3-0002SW-2v;;;mid=<87r2nlilwo.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.140.30;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+YMgiC8j1MioievVSSkd6JL/Y/kyxFVfw=
X-SA-Exim-Connect-IP: 97.119.140.30
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.5 XMGappySubj_01 Very gappy subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_12 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 889 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.7 (0.4%), b_tie_ro: 2.6 (0.3%), parse: 1.35 (0.2%),
        extract_message_metadata: 72 (8.0%), get_uri_detail_list: 6 (0.7%),
        tests_pri_-1000: 45 (5.1%), tests_pri_-950: 2.1 (0.2%), tests_pri_-900: 1.76
        (0.2%), tests_pri_-400: 54 (6.1%), check_bayes: 49 (5.5%), b_tokenize: 20
        (2.3%), b_tok_get_all: 12 (1.4%), b_comp_prob: 6 (0.7%), b_tok_touch_all: 7
        (0.8%), b_finish: 0.77 (0.1%), tests_pri_0: 695 (78.2%),
        check_dkim_signature: 0.92 (0.1%), check_dkim_adsp: 4.3 (0.5%),
        tests_pri_500: 9 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 4.9 022/310] pidns: disable pid allocation if pid_ns_prepare_proc() is failed in alloc_pid()
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> 4.9-stable review patch.  If anyone has any objections, please let me
> know.

No objections but if you are grabbing that one please check if you
have it's follow on fix.

c0ee554906c3 ("pid: Handle failure to allocate the first pid in a pid namespace")

There were a few cases not handled but the fix below, that made a more
comprehensive fix desirable.

Eric

> ------------------
>
> From: Kirill Tkhai <ktkhai@virtuozzo.com>
>
>
> [ Upstream commit 8896c23d2ef803f1883fea73117a435925c2b4c4 ]
>
> alloc_pidmap() advances pid_namespace::last_pid.  When first pid
> allocation fails, then next created process will have pid 2 and
> pid_ns_prepare_proc() won't be called.  So, pid_namespace::proc_mnt will
> never be initialized (not to mention that there won't be a child
> reaper).
>
> I saw crash stack of such case on kernel 3.10:
>
>     BUG: unable to handle kernel NULL pointer dereference at (null)
>     IP: proc_flush_task+0x8f/0x1b0
>     Call Trace:
>         release_task+0x3f/0x490
>         wait_consider_task.part.10+0x7ff/0xb00
>         do_wait+0x11f/0x280
>         SyS_wait4+0x7d/0x110
>
> We may fix this by restore of last_pid in 0 or by prohibiting of futher
> allocations.  Since there was a similar issue in Oleg Nesterov's commit
> 314a8ad0f18a ("pidns: fix free_pid() to handle the first fork failure").
> and it was fixed via prohibiting allocation, let's follow this way, and
> do the same.
>
> Link: http://lkml.kernel.org/r/149201021004.4863.6762095011554287922.stgit@localhost.localdomain
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> Acked-by: Cyrill Gorcunov <gorcunov@openvz.org>
> Cc: Andrei Vagin <avagin@virtuozzo.com>
> Cc: Andreas Gruenbacher <agruenba@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Michael Kerrisk <mtk.manpages@googlemail.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Serge Hallyn <serge@hallyn.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  kernel/pid.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -322,8 +322,10 @@ struct pid *alloc_pid(struct pid_namespa
>  	}
>  
>  	if (unlikely(is_child_reaper(pid))) {
> -		if (pid_ns_prepare_proc(ns))
> +		if (pid_ns_prepare_proc(ns)) {
> +			disable_pid_allocation(ns);
>  			goto out_free;
> +		}
>  	}
>  
>  	get_pid_ns(ns);
