Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933547AbeD1OH3 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 10:07:29 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:37138 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933421AbeD1OH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 10:07:27 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Linux-Arch <linux-arch@vger.kernel.org>
Cc: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        =?UTF-8?q?Martin=20P=C3=A4rtel?= <martin.partel@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Sat, 28 Apr 2018 09:06:58 -0500
Message-Id: <20180428140702.3925-1-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87zi1nctut.fsf_-_@xmission.com>
References: <87zi1nctut.fsf_-_@xmission.com>
X-XM-SPF: eid=1fCQVZ-0002Sz-Js;;;mid=<20180428140702.3925-1-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.116.237.29;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18HexSGqGc6mDxLbebIbj+ACGXIcgJwwvk=
X-SA-Exim-Connect-IP: 68.116.237.29
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linux-Arch <linux-arch@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 790 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 7 (0.9%), b_tie_ro: 2.1 (0.3%), parse: 1.47 (0.2%),
        extract_message_metadata: 27 (3.5%), get_uri_detail_list: 4.3 (0.5%),
        tests_pri_-1000: 11 (1.4%), tests_pri_-950: 2.3 (0.3%), tests_pri_-900: 2.0
        (0.3%), tests_pri_-400: 40 (5.0%), check_bayes: 37 (4.7%), b_tokenize: 16
        (2.1%), b_tok_get_all: 9 (1.1%), b_comp_prob: 4.3 (0.5%), b_tok_touch_all:
        3.4 (0.4%), b_finish: 0.95 (0.1%), tests_pri_0: 684 (86.6%),
        check_dkim_signature: 1.09 (0.1%), check_dkim_adsp: 6 (0.7%), tests_pri_500:
        8 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 1/5] signal/signalfd: Remove __put_user from signalfd_copyinfo
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put a signalfd_siginfo structure on the stack fully initializae
it and then copy it to userspace.

The code is a little less wordy, and this avoids a long series
of the somewhat costly __put_user calls.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/signalfd.c | 56 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index ff302bf50be4..31e960209a08 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -81,41 +81,41 @@ static __poll_t signalfd_poll(struct file *file, poll_table *wait)
 static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
 			     siginfo_t const *kinfo)
 {
-	long err;
+	struct signalfd_siginfo new;
 
 	BUILD_BUG_ON(sizeof(struct signalfd_siginfo) != 128);
 
 	/*
 	 * Unused members should be zero ...
 	 */
-	err = __clear_user(uinfo, sizeof(*uinfo));
+	memset(&new, 0, sizeof(new));
 
 	/*
 	 * If you change siginfo_t structure, please be sure
 	 * this code is fixed accordingly.
 	 */
-	err |= __put_user(kinfo->si_signo, &uinfo->ssi_signo);
-	err |= __put_user(kinfo->si_errno, &uinfo->ssi_errno);
-	err |= __put_user(kinfo->si_code, &uinfo->ssi_code);
+	new.ssi_signo = kinfo->si_signo;
+	new.ssi_errno = kinfo->si_errno;
+	new.ssi_code  = kinfo->si_code;
 	switch (siginfo_layout(kinfo->si_signo, kinfo->si_code)) {
 	case SIL_KILL:
-		err |= __put_user(kinfo->si_pid, &uinfo->ssi_pid);
-		err |= __put_user(kinfo->si_uid, &uinfo->ssi_uid);
+		new.ssi_pid = kinfo->si_pid;
+		new.ssi_uid = kinfo->si_uid;
 		break;
 	case SIL_TIMER:
-		 err |= __put_user(kinfo->si_tid, &uinfo->ssi_tid);
-		 err |= __put_user(kinfo->si_overrun, &uinfo->ssi_overrun);
-		 err |= __put_user((long) kinfo->si_ptr, &uinfo->ssi_ptr);
-		 err |= __put_user(kinfo->si_int, &uinfo->ssi_int);
+		new.ssi_tid = kinfo->si_tid;
+		new.ssi_overrun = kinfo->si_overrun;
+		new.ssi_ptr = (long) kinfo->si_ptr;
+		new.ssi_int = kinfo->si_int;
 		break;
 	case SIL_POLL:
-		err |= __put_user(kinfo->si_band, &uinfo->ssi_band);
-		err |= __put_user(kinfo->si_fd, &uinfo->ssi_fd);
+		new.ssi_band = kinfo->si_band;
+		new.ssi_fd   = kinfo->si_fd;
 		break;
 	case SIL_FAULT:
-		err |= __put_user((long) kinfo->si_addr, &uinfo->ssi_addr);
+		new.ssi_addr = (long) kinfo->si_addr;
 #ifdef __ARCH_SI_TRAPNO
-		err |= __put_user(kinfo->si_trapno, &uinfo->ssi_trapno);
+		new.ssi_trapno = kinfo->si_trapno;
 #endif
 		/*
 		 * Other callers might not initialize the si_lsb field,
@@ -124,29 +124,31 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
 		if (kinfo->si_signo == SIGBUS &&
 		    ((kinfo->si_code == BUS_MCEERR_AR) ||
 		     (kinfo->si_code == BUS_MCEERR_AO)))
-			err |= __put_user((short) kinfo->si_addr_lsb,
-					  &uinfo->ssi_addr_lsb);
+			new.ssi_addr_lsb = (short) kinfo->si_addr_lsb;
 		break;
 	case SIL_CHLD:
-		err |= __put_user(kinfo->si_pid, &uinfo->ssi_pid);
-		err |= __put_user(kinfo->si_uid, &uinfo->ssi_uid);
-		err |= __put_user(kinfo->si_status, &uinfo->ssi_status);
-		err |= __put_user(kinfo->si_utime, &uinfo->ssi_utime);
-		err |= __put_user(kinfo->si_stime, &uinfo->ssi_stime);
+		new.ssi_pid    = kinfo->si_pid;
+		new.ssi_uid    = kinfo->si_uid;
+		new.ssi_status = kinfo->si_status;
+		new.ssi_utime  = kinfo->si_utime;
+		new.ssi_stime  = kinfo->si_stime;
 		break;
 	case SIL_RT:
 	default:
 		/*
 		 * This case catches also the signals queued by sigqueue().
 		 */
-		err |= __put_user(kinfo->si_pid, &uinfo->ssi_pid);
-		err |= __put_user(kinfo->si_uid, &uinfo->ssi_uid);
-		err |= __put_user((long) kinfo->si_ptr, &uinfo->ssi_ptr);
-		err |= __put_user(kinfo->si_int, &uinfo->ssi_int);
+		new.ssi_pid = kinfo->si_pid;
+		new.ssi_uid = kinfo->si_uid;
+		new.ssi_ptr = (long) kinfo->si_ptr;
+		new.ssi_int = kinfo->si_int;
 		break;
 	}
 
-	return err ? -EFAULT: sizeof(*uinfo);
+	if (copy_to_user(uinfo, &new, sizeof(struct signalfd_siginfo)))
+		return -EFAULT;
+
+	return sizeof(*uinfo);
 }
 
 static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, siginfo_t *info,
-- 
2.14.1
