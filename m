Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D12C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F1021901
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498027;
	bh=qQ0q1i46/NaxHC3ex0OTVZg1dWomgXVNSC703YpPqYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mVJSA36H4MSkoUG/JhMG9KwKZls9VdnDmcalfcab8DwcV+MxDplAhdmuWiNxCAgY6
	 GiTUEZW8UPDRtetOzsHxN8Z8BPTPuKTM/anQWcMxg/Im8vgObhEbK19tg7bzOdL2yn
	 Ne9spYUw1Bw810A095UsFlv1K9tfHlWtAc7QKFQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733014AbfBRNxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:53:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:33426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733003AbfBRNxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:53:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9714C20842;
        Mon, 18 Feb 2019 13:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498020;
        bh=qQ0q1i46/NaxHC3ex0OTVZg1dWomgXVNSC703YpPqYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a8qb5YHwqGKyMn0ThhEKZhw9zhpZUxN56ZLR9Xfiy35w19WdeRz57xDdFlqC4Nq4u
         cAS+dvY/UKURYznxgapu1baaCgx8t4Grk1zoK+4q2WHefGMsVGRgxOR5YidtbjejaQ
         IZyGf+fNgBLV3btOFte63V6kX81E0Wfdmy+fBFnE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Ivan Delalande <colona@arista.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4.19 76/85] signal: Restore the stop PTRACE_EVENT_EXIT
Date:   Mon, 18 Feb 2019 14:43:42 +0100
Message-Id: <20190218133507.207140076@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric W. Biederman <ebiederm@xmission.com>

commit cf43a757fd49442bc38f76088b70c2299eed2c2f upstream.

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

Acked-by: Oleg Nesterov <oleg@redhat.com>
Reported-by: Oleg Nesterov <oleg@redhat.com>
Reported-by: Ivan Delalande <colona@arista.com>
Cc: stable@vger.kernel.org
Fixes: 35634ffa1751 ("signal: Always notice exiting tasks")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/signal.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2433,9 +2433,12 @@ relock:
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


