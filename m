Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029E2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C645321916
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550499161;
	bh=PChFWTXHqkJlZED1Fz91KfZZVBssYKks1xPso+qvfZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IoR7/icUt61l5MWLqXSvFZzjI14lku8HYgkKewSUUwUxWF4qeP3k8FhsQGcxPYiMh
	 /duHqzeZXvKudITamVo8ItLr16pz0yDRtp/RjSnTGm66shttsXD5mVJJ6YNKkWdCpM
	 4S6UL+bWsNtQiklcF6Dklgpxuyw3w4Bf1dtIbGOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391530AbfBROMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:12:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:57198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392055AbfBROMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:12:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DAD9217D7;
        Mon, 18 Feb 2019 14:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550499153;
        bh=PChFWTXHqkJlZED1Fz91KfZZVBssYKks1xPso+qvfZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a5wG+I5zgrjK9YtVngMYISD4trC7n59zflGwZPnqdZA98IS3XxAsFvR4IJPSiAJcW
         WeaBcWCf3kYs/P67PCu56kNLZOKf7BjlOHopqJC5tWZUtkhWdwCDJ9DZQnjyrjdh3P
         6KqhvCp7Q/Hvhnm47vsa5trvec9axxPFtirQ94os=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 3.18 076/108] signal: Always notice exiting tasks
Date:   Mon, 18 Feb 2019 14:44:12 +0100
Message-Id: <20190218133523.050488337@linuxfoundation.org>
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

commit 35634ffa1751b6efd8cf75010b509dcb0263e29b upstream.

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
Tested-by: Dmitry Vyukov <dvyukov@google.com>
Reported-by: Dmitry Vyukov <dvyukov@google.com>
Ref: ebf5ebe31d2c ("[PATCH] signal-fixes-2.5.59-A4")
History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/signal.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2241,6 +2241,11 @@ relock:
 		goto relock;
 	}
 
+	/* Has this task already been marked for death? */
+	ksig->info.si_signo = signr = SIGKILL;
+	if (signal_group_exit(signal))
+		goto fatal;
+
 	for (;;) {
 		struct k_sigaction *ka;
 
@@ -2336,6 +2341,7 @@ relock:
 			continue;
 		}
 
+	fatal:
 		spin_unlock_irq(&sighand->siglock);
 
 		/*


