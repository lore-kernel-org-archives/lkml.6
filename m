Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C90ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 18:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A3820883
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 18:04:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2A3820883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbeIPX2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 19:28:37 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33671 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbeIPX2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 19:28:37 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g1bPg-0001YF-SN; Sun, 16 Sep 2018 12:04:52 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g1bPf-00022W-9p; Sun, 16 Sep 2018 12:04:52 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <87musyl3fa.fsf@xmission.com> <87lg81pbe2.fsf@xmission.com>
Date:   Sun, 16 Sep 2018 20:04:41 +0200
In-Reply-To: <87lg81pbe2.fsf@xmission.com> (Eric W. Biederman's message of
        "Sun, 16 Sep 2018 20:04:05 +0200")
Message-ID: <87fty9pbd2.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g1bPf-00022W-9p;;;mid=<87fty9pbd2.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+UCOyU3Bq3HgfQvAkys3EFr3p6ZO8oCSo=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 1/4] tty_io: Use group_send_sig_info in __do_SACK to note it is a session being killed
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Replace send_sig and force_sig in __do_SAK with group_send_sig_info
the general helper for sending a signal to a process group.  This is
wordier but it allows specifying PIDTYPE_SID so that the signal code
knows the signal went to a session.

Both force_sig() and send_sig(..., 1) specify SEND_SIG_PRIV and the
new call of group_send_sig_info does that explicitly.  This is enough
to ensure even a pid namespace init is killed.

The global init remains unkillable.  The guarantee that __do_SAK tries
to provide is a clean path to login to a machine.  As the global init is
unkillable, if it chooses to hold open a tty it can violate this
guarantee.  A technique other than killing processes would be needed
to provide this guarantee to userspace.

The only difference between force_sig and send_sig when sending
SIGKILL is that SIGNAL_UNKILLABLE is cleared.  This has no affect on
the processing of a signal sent with SEND_SIG_PRIV by any process, making
it unnecessary, and not behavior that needs to be preserved.

force_sig was used originally because it did not take as many locks as
send_sig.  Today send_sig, force_sig and group_send_sig_info take the
same locks when delivering a signal.

group_send_sig_info also contains a permission check that force_sig
and send_sig do not.  However the presence of SEND_SIG_PRIV makes the
permission check a noop.  So the permission check does not result
in any behavioral differences.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 drivers/tty/tty_io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 32bc3e3fe4d3..6553247a761f 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2738,7 +2738,7 @@ void __do_SAK(struct tty_struct *tty)
 	do_each_pid_task(session, PIDTYPE_SID, p) {
 		tty_notice(tty, "SAK: killed process %d (%s): by session\n",
 			   task_pid_nr(p), p->comm);
-		send_sig(SIGKILL, p, 1);
+		group_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_SID);
 	} while_each_pid_task(session, PIDTYPE_SID, p);
 
 	/* Now kill any processes that happen to have the tty open */
@@ -2746,7 +2746,7 @@ void __do_SAK(struct tty_struct *tty)
 		if (p->signal->tty == tty) {
 			tty_notice(tty, "SAK: killed process %d (%s): by controlling tty\n",
 				   task_pid_nr(p), p->comm);
-			send_sig(SIGKILL, p, 1);
+			group_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_SID);
 			continue;
 		}
 		task_lock(p);
@@ -2754,7 +2754,7 @@ void __do_SAK(struct tty_struct *tty)
 		if (i != 0) {
 			tty_notice(tty, "SAK: killed process %d (%s): by fd#%d\n",
 				   task_pid_nr(p), p->comm, i - 1);
-			force_sig(SIGKILL, p);
+			group_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_SID);
 		}
 		task_unlock(p);
 	} while_each_thread(g, p);
-- 
2.17.1

