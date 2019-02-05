Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2411AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1D720844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 14:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfBEOR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 09:17:26 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:59432 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfBEOR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 09:17:26 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gr1XQ-000322-5Q; Tue, 05 Feb 2019 07:17:24 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gr1Wr-0006MM-JD; Tue, 05 Feb 2019 07:17:23 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Jack Andersen <jackoalan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>
References: <20190203074939.7261-1-jackoalan@gmail.com>
        <20190203083933.ee4a6j4mdecesbn2@brauner.io>
        <CAGXu5jLGgCChpxt3ee8kSi2pTKPd9baHt_uZvTG6qqi8oFK2UQ@mail.gmail.com>
        <87r2cn7y9g.fsf@xmission.com>
        <CAHk-=wjFUCjvFzTGNt2hNO-Q5TaQHYSD_5NDDiS+zxwf3qQPwQ@mail.gmail.com>
        <8736p24trv.fsf@xmission.com>
Date:   Tue, 05 Feb 2019 08:16:42 -0600
In-Reply-To: <8736p24trv.fsf@xmission.com> (Eric W. Biederman's message of
        "Tue, 05 Feb 2019 00:46:28 -0600")
Message-ID: <87ftt22ud1.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gr1Wr-0006MM-JD;;;mid=<87ftt22ud1.fsf_-_@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/D1s7yaN+cSr6yoylYqOLART7Vzdq0r98=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH] signal: Always attempt to allocate siginfo for SIGSTOP
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Since 2.5.34 the code has had the potential to not allocate siginfo
for SIGSTOP signals.  Except for ptrace this is perfectly fine as only
ptrace can use PTRACE_PEEK_SIGINFO and see what the contents of
the delivered siginfo are.

Users of PTRACE_PEEK_SIGINFO that care about the contents siginfo
for SIGSTOP are rare, but they do exist.  A seccomp self test
has cared and lldb cares.

Jack Andersen <jackoalan@gmail.com> writes:

> The patch titled
> `signal: Never allocate siginfo for SIGKILL or SIGSTOP`
> created a regression for users of PTRACE_GETSIGINFO needing to
> discern signals that were raised via the tgkill syscall.
>
> A notable user of this tgkill+ptrace combination is lldb while
> debugging a multithreaded program. Without the ability to detect a
> SIGSTOP originating from tgkill, lldb does not have a way to
> synchronize on a per-thread basis and falls back to SIGSTOP-ing the
> entire process.

Everyone affected by this please note.  The kernel can still fail to
allocate a siginfo structure.  The allocation is with GFP_KERNEL and
is best effort only.  If memory is tight when the signal allocation
comes in this will fail to allocate a siginfo.

So I strongly recommend looking at more robust solutions for
synchronizing with a single thread such as PTRACE_INTERRUPT.  Or if
that does not work persuading your friendly local kernel developer to
build the interface you need.

Reported-by: Tycho Andersen <tycho@tycho.ws>
Reported-by: Kees Cook <keescook@chromium.org>
Reported-by: Jack Andersen <jackoalan@gmail.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Christian Brauner <christian@brauner.io>
Fixes: f149b3155744 ("signal: Never allocate siginfo for SIGKILL or SIGSTOP")
Fixes: 6dfc88977e42 ("[PATCH] shared thread signals")
History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

Unless someone objects I will drop this in my tree for linux-next and
send Linus a pull request in a couple of days.

 kernel/signal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index e1d7ad8e6ab1..45298b3a8ffc 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1057,10 +1057,10 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 
 	result = TRACE_SIGNAL_DELIVERED;
 	/*
-	 * Skip useless siginfo allocation for SIGKILL SIGSTOP,
+	 * Skip useless siginfo allocation for SIGKILL,
 	 * and kernel threads.
 	 */
-	if (sig_kernel_only(sig) || (t->flags & PF_KTHREAD))
+	if ((sig == SIGKILL) || (t->flags & PF_KTHREAD))
 		goto out_set;
 
 	/*
-- 
2.17.1

