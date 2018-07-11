Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B45AC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440D520936
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:46:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440D520936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbeGKCsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:48:39 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:41559 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732385AbeGKCsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:48:38 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fd59I-000778-Gi; Tue, 10 Jul 2018 20:46:36 -0600
Received: from [97.119.167.31] (helo=x220.int.ebiederm.org)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fd59G-00063R-S7; Tue, 10 Jul 2018 20:46:36 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 10 Jul 2018 21:44:57 -0500
Message-Id: <20180711024459.10654-9-ebiederm@xmission.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <877em2jxyr.fsf_-_@xmission.com>
References: <877em2jxyr.fsf_-_@xmission.com>
X-XM-SPF: eid=1fd59G-00063R-S7;;;mid=<20180711024459.10654-9-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/YveK+NqbqpTh8jRHkKRUEaEFg0fWvq2s=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [RFC][PATCH 09/11] tty_io: Use do_send_sig_info in __do_SACK  to forcibly kill tasks
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

send_sig is thread only making it the wrong command for an action
         directed at a process.

force_sig does not set SEND_SIG_FORCED (causing unnecessary work in
	 __send_signal) and jumps through unnecessary hoops to deal
	 with blocked and ignored signals which SIGKILL can never be.

Therefore use do_send_sig_info in all cases in __do_SAK to kill
tasks as allows for exactly what the code wants to do.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 drivers/tty/tty_io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index cec58c53b0c4..42ac168c2a47 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2747,7 +2747,7 @@ void __do_SAK(struct tty_struct *tty)
 	do_each_pid_task(session, PIDTYPE_SID, p) {
 		tty_notice(tty, "SAK: killed process %d (%s): by session\n",
 			   task_pid_nr(p), p->comm);
-		send_sig(SIGKILL, p, 1);
+		do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, true);
 	} while_each_pid_task(session, PIDTYPE_SID, p);
 
 	/* Now kill any processes that happen to have the tty open */
@@ -2755,7 +2755,7 @@ void __do_SAK(struct tty_struct *tty)
 		if (p->signal->tty == tty) {
 			tty_notice(tty, "SAK: killed process %d (%s): by controlling tty\n",
 				   task_pid_nr(p), p->comm);
-			send_sig(SIGKILL, p, 1);
+			do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, true);
 			continue;
 		}
 		task_lock(p);
@@ -2763,7 +2763,7 @@ void __do_SAK(struct tty_struct *tty)
 		if (i != 0) {
 			tty_notice(tty, "SAK: killed process %d (%s): by fd#%d\n",
 				   task_pid_nr(p), p->comm, i - 1);
-			force_sig(SIGKILL, p);
+			do_send_sig_info(SIGKILL, SEND_SIG_FORCED, p, true);
 		}
 		task_unlock(p);
 	} while_each_thread(g, p);
-- 
2.17.1

