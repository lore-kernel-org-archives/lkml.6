Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58777C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269EF217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499213;
	bh=BDdPfPibgOrWtGZOYqKW3AAlrSo3F+yKdOl34k8ckAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iM/M6IGYGViwxh9kUwpEOO30aAOo2H7ZQChY55zAbhAZTLTjhU2rVjgARaxiWvXrs
	 H0/qQImL2HpRITbzVKUdtLjeTH9QELDXwBMoJE8U1bs8Y+V5+/My3fufFh79W6QS/p
	 OzE1AF3j+5FzJGvd9ITqpEaGgaWJ8REuZHfSFeH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392362AbfBRONb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:13:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:58176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390865AbfBRON2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:13:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D64E7218AD;
        Mon, 18 Feb 2019 14:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499207;
        bh=BDdPfPibgOrWtGZOYqKW3AAlrSo3F+yKdOl34k8ckAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hlVu74ewQ//D5D8S5UGD9WnxFqYp1/1JyFp8DzH0jN071C7Os94Y+e+GZ86w1UPtu
         UnKNc/MzHELsiFIRi0X2CgsNlzB7oPz0/Md76bWElUGQdTDymp6bVPfInixXqnaK3e
         /NltcFKQe9Ax0lH3KKhXIYpjEKFjxNZZS5nZMbf0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        Ivan Delalande <colona@arista.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 3.18 103/108] signal: Restore the stop PTRACE_EVENT_EXIT
Date:   Mon, 18 Feb 2019 14:44:39 +0100
Message-Id: <20190218133524.446138270@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133519.525507231@linuxfoundation.org>
References: <20190218133519.525507231@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2284,9 +2284,12 @@ relock:
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


