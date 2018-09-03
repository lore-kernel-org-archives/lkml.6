Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58245C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18D2820645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D2820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbeIDBHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 21:07:30 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:50369 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbeIDBHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 21:07:30 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fwvj5-000642-P2; Mon, 03 Sep 2018 14:45:35 -0600
Received: from [105.225.206.69] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fwvj4-0008G7-L6; Mon, 03 Sep 2018 14:45:35 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon,  3 Sep 2018 22:44:27 +0200
Message-Id: <20180903204430.25473-7-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87musyl3fa.fsf@xmission.com>
References: <87musyl3fa.fsf@xmission.com>
X-XM-SPF: eid=1fwvj4-0008G7-L6;;;mid=<20180903204430.25473-7-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.225.206.69;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Sv+Z3TecZoUrXUM3DFrcBYM2OyAaVK4c=
X-SA-Exim-Connect-IP: 105.225.206.69
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 07/10] signal: Don't send siginfo to kthreads.
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today kernel threads never dequeue siginfo so it is pointless to
enqueue siginfo for them.  The usb gadget mass storage driver goes
one farther and uses SEND_SIG_FORCED to guarantee that no siginfo is
even enqueued.

Generalize the optimization of the usb mass storage driver and never
perform an unnecessary allocation when delivering signals to kthreads.

Switch the mass storage driver from sending signals with
SEND_SIG_FORCED to SEND_SIG_PRIV.  As using SEND_SIG_FORCED is now
unnecessary.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 drivers/usb/gadget/function/f_mass_storage.c | 2 +-
 kernel/signal.c                              | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index 70038a475c9f..cb402e7a1e9b 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -403,7 +403,7 @@ static void raise_exception(struct fsg_common *common, enum fsg_state new_state)
 		common->exception_req_tag = common->ep0_req_tag;
 		common->state = new_state;
 		if (common->thread_task)
-			send_sig_info(SIGUSR1, SEND_SIG_FORCED,
+			send_sig_info(SIGUSR1, SEND_SIG_PRIV,
 				      common->thread_task);
 	}
 	spin_unlock_irqrestore(&common->lock, flags);
diff --git a/kernel/signal.c b/kernel/signal.c
index 8081ab79e97d..20931a892ace 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1057,7 +1057,7 @@ static int __send_signal(int sig, struct siginfo *info, struct task_struct *t,
 	 * fast-pathed signals for kernel-internal things like SIGSTOP
 	 * or SIGKILL.
 	 */
-	if (info == SEND_SIG_FORCED)
+	if ((info == SEND_SIG_FORCED) || (t->flags & PF_KTHREAD))
 		goto out_set;
 
 	/*
-- 
2.17.1

