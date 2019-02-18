Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2ECC10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D16021900
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498201;
	bh=DTLFsRnA83Z9uEdRks2Gm+ZSlt1B8b0rM/4tOPI7ls8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DBP5YnQcR+zFFZ+ne9ZNRaP8BHuq5YZOVaI6wQFZ5X9VvuPo9rpt2yZ+obezqLSsX
	 xJUJDeJx5WmN/d0SK3jzyTYQk/bG9qh5YYm0K3NRWqkZg64NtoitQ91DxjWgzNpsjL
	 G8AL3I9LZV5jVFXm8WiN/Y/oGymh+qorMjH1WI1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387853AbfBRN4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:56:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:36848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730949AbfBRN4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:56:36 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10A062077B;
        Mon, 18 Feb 2019 13:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498195;
        bh=DTLFsRnA83Z9uEdRks2Gm+ZSlt1B8b0rM/4tOPI7ls8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1XNPgsjmdch60nU+xhsD6CYAqfyxN0UCvGIVlwqpcSigbNxULNUMhbGIf0/z6LR55
         kaFooWXt/YvoNE4aZXockOOihjZWt1ja1AC435/EarBnS3BgxDCAqTGjmLnrAMB/us
         /nOVxO2deY122m0yW2IFAZQoLXPeMZLF6KykUMBI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Ivan Delalande <colona@arista.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4.14 54/62] signal: Restore the stop PTRACE_EVENT_EXIT
Date:   Mon, 18 Feb 2019 14:44:00 +0100
Message-Id: <20190218133510.407139360@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133505.801423074@linuxfoundation.org>
References: <20190218133505.801423074@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2268,9 +2268,12 @@ relock:
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


