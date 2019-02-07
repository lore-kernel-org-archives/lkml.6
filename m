Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B678AC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903982175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 06:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbfBGGnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 01:43:43 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:43402 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfBGGnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 01:43:43 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1grdPS-000399-6e; Wed, 06 Feb 2019 23:43:42 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1grdPR-0002Ea-Ki; Wed, 06 Feb 2019 23:43:42 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jolsa@redhat.com, Namhyung Kim <namhyung@kernel.org>,
        luca abeni <luca.abeni@santannapisa.it>,
        syzkaller <syzkaller@googlegroups.com>,
        Oleg Nesterov <oleg@redhat.com>
References: <CACT4Y+bFh_S3=U+JF7GCzZjZ9R8b_Xqzi-1AyruKxqNqGrFVrQ@mail.gmail.com>
        <CACT4Y+YdVewFEmw2wFrnaHOc78b4bMZ4Nfu0uEzLk08UtvwOMA@mail.gmail.com>
        <alpine.DEB.2.21.1902041025050.8200@nanos.tec.linutronix.de>
        <CACT4Y+agDBRQ8f0kvqU7dJ9nmNZcNyLk1vc4fcGeH3WR-iAFqw@mail.gmail.com>
        <alpine.DEB.2.21.1902041736240.3006@nanos.tec.linutronix.de>
        <8736p37xcn.fsf@xmission.com> <878syu7tcm.fsf@xmission.com>
        <87tvhi4vl7.fsf@xmission.com> <87o97q1cky.fsf_-_@xmission.com>
        <20190206180754.GA23476@redhat.com> <87imxwv9jp.fsf@xmission.com>
        <875ztwt7yy.fsf_-_@xmission.com>
Date:   Thu, 07 Feb 2019 00:43:33 -0600
In-Reply-To: <875ztwt7yy.fsf_-_@xmission.com> (Eric W. Biederman's message of
        "Thu, 07 Feb 2019 00:42:45 -0600")
Message-ID: <87zhr8rtd6.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1grdPR-0002Ea-Ki;;;mid=<87zhr8rtd6.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18wB0EbOCPNNziO5EdtImiTiVFWzNEQrWc=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 1/2] signal: Always notice exiting tasks
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Recently syzkaller was able to create unkillablle processes by
creating a timer that is delivered as a thread local signal on SIGHUP,
and receiving SIGHUP SA_NODEFERER.  Ultimately causing a loop
failing to deliver SIGHUP but always trying.

Upon examination it turns out part of the problem is actually most of
the solution.  Since 2.5 signal delivery has found all fatal signals,
marked the signal group for death, and queued SIGKILL in every threads
thread queue relying on signal->group_exit_code to preserve the
information of which was the actual fatal signal.

The conversion of all fatal signals to SIGKILL results in the
synchronous signal heuristic in next_signal kicking in and preferring
SIGHUP to SIGKILL.  Which is especially problematic as all
fatal signals have already been transformed into SIGKILL.

Instead of dequeueing signals and depending upon SIGKILL to
be the first signal dequeued, first test if the signal group
has already been marked for death.  This guarantees that
nothing in the signal queue can prevent a process that needs
to exit from exiting.

Cc: stable@vger.kernel.org
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Ref: ebf5ebe31d2c ("[PATCH] signal-fixes-2.5.59-A4")
History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 9ca8e5278c8e..5424cb0006bc 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2393,6 +2393,11 @@ bool get_signal(struct ksignal *ksig)
 		goto relock;
 	}
 
+	/* Has this task already been marked for death? */
+	ksig->info.si_signo = signr = SIGKILL;
+	if (signal_group_exit(signal))
+		goto fatal;
+
 	for (;;) {
 		struct k_sigaction *ka;
 
@@ -2488,6 +2493,7 @@ bool get_signal(struct ksignal *ksig)
 			continue;
 		}
 
+	fatal:
 		spin_unlock_irq(&sighand->siglock);
 
 		/*
-- 
2.17.1

