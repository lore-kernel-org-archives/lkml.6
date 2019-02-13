Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E04C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 04:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42FA222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 04:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388527AbfBMEJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 23:09:25 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:55450 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388465AbfBMEJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 23:09:22 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gtlrM-0006Kh-LC; Tue, 12 Feb 2019 21:09:20 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gtlrL-0000r9-P5; Tue, 12 Feb 2019 21:09:20 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jolsa@redhat.com, Namhyung Kim <namhyung@kernel.org>,
        luca abeni <luca.abeni@santannapisa.it>,
        syzkaller <syzkaller@googlegroups.com>,
        Ivan Delalande <colona@arista.com>
References: <878syu7tcm.fsf@xmission.com> <87tvhi4vl7.fsf@xmission.com>
        <87o97q1cky.fsf_-_@xmission.com> <20190206180754.GA23476@redhat.com>
        <87imxwv9jp.fsf@xmission.com> <875ztwt7yy.fsf_-_@xmission.com>
        <87zhr8rtd6.fsf_-_@xmission.com> <20190211141340.GA21430@redhat.com>
        <87zhr1g7ls.fsf@xmission.com> <871s4dctci.fsf@xmission.com>
        <20190212165022.GA29263@redhat.com>
Date:   Tue, 12 Feb 2019 22:09:14 -0600
In-Reply-To: <20190212165022.GA29263@redhat.com> (Oleg Nesterov's message of
        "Tue, 12 Feb 2019 17:50:23 +0100")
Message-ID: <87ef8c5nyt.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gtlrL-0000r9-P5;;;mid=<87ef8c5nyt.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+iZIJ7cbRve7KlhsKCKfyDAnjWkSnbmLg=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH] signal: Restore the stop PTRACE_EVENT_EXIT
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In the middle of do_exit() there is there is a call
"ptrace_event(PTRACE_EVENT_EXIT, code);" That call places the process
in TACKED_TRACED aka "(TASK_WAKEKILL | __TASK_TRACED)" and waits for
for the debugger to release the task or SIGKILL to be delivered.

Skipping past dequeue_signal when we know a fatal signal has already
been delivered resulted in SIGKILL remaining pending and
TIF_SIGPENDING remaining set.  This in turn caused the
scheduler to not sleep in PTACE_EVENT_EXIT as it figured
a fatal signal was pending.  This also caused ptrace_freeze_traced
in ptrace_check_attach to fail because it left a per thread
SIGKILL pending which is what fatal_signal_pending tests for.

This difference in signal state caused strace to report
strace: Exit of unknown pid NNNNN ignored

Therefore update the signal handling state like dequeue_signal
would when removing a per thread SIGKILL, by removing SIGKILL
from the per thread signal mask and clearing TIF_SIGPENDING.

Reported-by: Oleg Nesterov <oleg@redhat.com>
Reported-by: Ivan Delalande <colona@arista.com>
Cc: stable@vger.kernel.org
Fixes: 35634ffa1751 ("signal: Always notice exiting tasks")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

Ivan this change fixes the issues you reported to me.  Can you confirm?
Oleg this looks like the most conservative regression fix I can manage.

 kernel/signal.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 99fa8ff06fd9..57b7771e20d7 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2436,9 +2436,12 @@ bool get_signal(struct ksignal *ksig)
 	}
 
 	/* Has this task already been marked for death? */
-	ksig->info.si_signo = signr = SIGKILL;
-	if (signal_group_exit(signal))
+	if (signal_group_exit(signal)) {
+		ksig->info.si_signo = signr = SIGKILL;
+		sigdelset(&current->pending.signal, SIGKILL);
+		recalc_sigpending();
 		goto fatal;
+	}
 
 	for (;;) {
 		struct k_sigaction *ka;
-- 
2.17.1

