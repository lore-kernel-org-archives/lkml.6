Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E063EC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEA920645
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEA920645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbeIDBH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 21:07:26 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:50363 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbeIDBH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 21:07:26 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fwvj1-00063q-E7; Mon, 03 Sep 2018 14:45:31 -0600
Received: from [105.225.206.69] (helo=x220.Home)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fwviz-0008G7-TD; Mon, 03 Sep 2018 14:45:31 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Mon,  3 Sep 2018 22:44:26 +0200
Message-Id: <20180903204430.25473-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87musyl3fa.fsf@xmission.com>
References: <87musyl3fa.fsf@xmission.com>
X-XM-SPF: eid=1fwviz-0008G7-TD;;;mid=<20180903204430.25473-6-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.225.206.69;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18/e/wF0bucJ8qTTHM4SHN3oczu0E6fJ0U=
X-SA-Exim-Connect-IP: 105.225.206.69
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 06/10] signal: Remove the siginfo paramater from kernel_dqueue_signal
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of the callers use the it so remove it.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 drivers/usb/gadget/function/f_mass_storage.c | 2 +-
 fs/jffs2/background.c                        | 2 +-
 include/linux/sched/signal.h                 | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
index ca8a4b53c59f..70038a475c9f 100644
--- a/drivers/usb/gadget/function/f_mass_storage.c
+++ b/drivers/usb/gadget/function/f_mass_storage.c
@@ -2311,7 +2311,7 @@ static void handle_exception(struct fsg_common *common)
 	 * into a high-priority EXIT exception.
 	 */
 	for (;;) {
-		int sig = kernel_dequeue_signal(NULL);
+		int sig = kernel_dequeue_signal();
 		if (!sig)
 			break;
 		if (sig != SIGUSR1) {
diff --git a/fs/jffs2/background.c b/fs/jffs2/background.c
index 453a6a1fff34..2b4d5013dc5d 100644
--- a/fs/jffs2/background.c
+++ b/fs/jffs2/background.c
@@ -125,7 +125,7 @@ static int jffs2_garbage_collect_thread(void *_c)
 			if (try_to_freeze())
 				goto again;
 
-			signr = kernel_dequeue_signal(NULL);
+			signr = kernel_dequeue_signal();
 
 			switch(signr) {
 			case SIGSTOP:
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 1be35729c2c5..9b6968cbde14 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -272,14 +272,14 @@ extern void ignore_signals(struct task_struct *);
 extern void flush_signal_handlers(struct task_struct *, int force_default);
 extern int dequeue_signal(struct task_struct *tsk, sigset_t *mask, siginfo_t *info);
 
-static inline int kernel_dequeue_signal(siginfo_t *info)
+static inline int kernel_dequeue_signal(void)
 {
 	struct task_struct *tsk = current;
 	siginfo_t __info;
 	int ret;
 
 	spin_lock_irq(&tsk->sighand->siglock);
-	ret = dequeue_signal(tsk, &tsk->blocked, info ?: &__info);
+	ret = dequeue_signal(tsk, &tsk->blocked, &__info);
 	spin_unlock_irq(&tsk->sighand->siglock);
 
 	return ret;
-- 
2.17.1

