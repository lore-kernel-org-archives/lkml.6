Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57863C282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 02:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C5820823
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 02:41:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfBECl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 21:41:26 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:49729 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfBECl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 21:41:26 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gqqfs-00038v-Bf; Mon, 04 Feb 2019 19:41:24 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gqqfr-0008Kb-Cb; Mon, 04 Feb 2019 19:41:24 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Jack Andersen <jackoalan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20190203074939.7261-1-jackoalan@gmail.com>
        <20190203083933.ee4a6j4mdecesbn2@brauner.io>
        <CAGXu5jLGgCChpxt3ee8kSi2pTKPd9baHt_uZvTG6qqi8oFK2UQ@mail.gmail.com>
Date:   Mon, 04 Feb 2019 20:41:15 -0600
In-Reply-To: <CAGXu5jLGgCChpxt3ee8kSi2pTKPd9baHt_uZvTG6qqi8oFK2UQ@mail.gmail.com>
        (Kees Cook's message of "Sun, 3 Feb 2019 10:33:55 -0800")
Message-ID: <87r2cn7y9g.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gqqfr-0008Kb-Cb;;;mid=<87r2cn7y9g.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19p8LUxcAxvxlzto2DkitSlhVltmKeZOtg=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] signal: always allocate siginfo for SI_TKILL
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Sun, Feb 3, 2019 at 12:39 AM Christian Brauner <christian@brauner.io> wrote:
>>
>> On Sat, Feb 02, 2019 at 09:49:38PM -1000, Jack Andersen wrote:
>> > The patch titled
>> > `signal: Never allocate siginfo for SIGKILL or SIGSTOP`
>> > created a regression for users of PTRACE_GETSIGINFO needing to
>> > discern signals that were raised via the tgkill syscall.
>> >
>> > A notable user of this tgkill+ptrace combination is lldb while
>> > debugging a multithreaded program. Without the ability to detect a
>> > SIGSTOP originating from tgkill, lldb does not have a way to
>> > synchronize on a per-thread basis and falls back to SIGSTOP-ing the
>> > entire process.
>> >
>> > This patch allocates the siginfo as it did previously whenever the
>> > SI_TKILL code is present.
>> >
>> > Signed-off-by: Jack Andersen <jackoalan@gmail.com>
>>
>> The  commit you're trying to fix has been discussed before wrt to
>> seccomp tests:
>>
>> commit 2bd61abead58c82714a1f6fa6beb0fd0df6a6d13
>> Author: Kees Cook <keescook@chromium.org>
>> Date:   Thu Dec 6 15:50:38 2018 -0800
>>
>>     selftests/seccomp: Remove SIGSTOP si_pid check
>>
>>     Commit f149b3155744 ("signal: Never allocate siginfo for SIGKILL or SIGSTOP")
>>     means that the seccomp selftest cannot check si_pid under SIGSTOP anymore.
>>     Since it's believed[1] there are no other userspace things depending on the
>>     old behavior, this removes the behavioral check in the selftest, since it's
>>     more a "extra" sanity check (which turns out, maybe, not to have been
>>     useful to test).
>>
>>     [1] https://lkml.kernel.org/r/CAGXu5jJaZAOzP1qFz66tYrtbuywqb+UN2SOA1VLHpCCOiYvYeg@mail.gmail.com
>>
>>     Reported-by: Tycho Andersen <tycho@tycho.ws>
>>     Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
>>     Signed-off-by: Kees Cook <keescook@chromium.org>
>>     Signed-off-by: Shuah Khan <shuah@kernel.org>
>>
>> Ccing Kees on this. Seems that this commit might be worth given that
>> there's some parts of userspace relying on it and not just internal
>> kernel tests.
>
> Yup, so this is the "real" userspace example that Eric was looking for.

Yes it is.

> Eric, how does the proposed fix look? I'd also like to revert my
> seccomp selftest change too, since it clearly found a real-world use.
> :)

I think the simpler change to just do:

diff --git a/kernel/signal.c b/kernel/signal.c
index e1d7ad8e6ab1..45298b3a8ffc 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1057,10 +1057,10 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 
        result = TRACE_SIGNAL_DELIVERED;
        /*
-        * Skip useless siginfo allocation for SIGKILL SIGSTOP,
+        * Skip useless siginfo allocation for SIGKILL,
         * and kernel threads.
         */
-       if (sig_kernel_only(sig) || (t->flags & PF_KTHREAD))
+       if ((sig == SIGKILL) || (t->flags & PF_KTHREAD))
                goto out_set;
 
        /*

is the better fix.  As Christian points out that fixes possible
issues with SIGSTOP.

For the ldd use case I do want to suggest that using PTRACE_INTERRUPT
may be a better solution.

Using a signal to stop an individual thread has the problem that
someone else can send that SIGSTOP and siginfo will not be allocated.
Further for the second time a signal is sent we can not implement a
siginfo allocation for historic unix signals because that would cause
the signal to be delivered multiple times instead of just once.

AKA there are unfixable races with using SIGSTOP to stop thread for
debugging.

Eric
